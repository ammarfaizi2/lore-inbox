Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268382AbUJPKaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268382AbUJPKaA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 06:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268405AbUJPKaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 06:30:00 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:29929 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S268382AbUJPK3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 06:29:49 -0400
Date: Sat, 16 Oct 2004 12:29:48 +0200
From: bert hubert <ahu@ds9a.nl>
To: roland@redhat.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       albert@users.sf.net, kernel@kolivas.org, wli@holomorphy.com
Subject: [PATCH, RFC] bring /proc/pid/stat and /proc/pid/task/tid/stat in line with getrusage
Message-ID: <20041016102948.GA8958@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, roland@redhat.com,
	linux-kernel@vger.kernel.org, akpm@osdl.org, albert@users.sf.net,
	kernel@kolivas.org, wli@holomorphy.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In http://lkml.org/lkml/2004/8/18/50 Roland added the infrastructure to make
getrusage report the rusage of all tasks that are or (crucially) were part
of a thread group.

Patch below builds on that code to make /proc/pid/stat return the same
values for utime and stime as getrusage(RUSAGE_SELF, &ru) would.

Because this hides task specific information, /proc/pid/stat and
/proc/pid/task/tid/stat are made different in that the task/tid/stat variant
only prints rusage for that thread.

This solves two important problems:

1) Tasks with an idle group leader but busy threads, a common scenario,
currently appear to non-NPTL aware tools as idle. This patch makes sure
that a non-threads aware tool sees a process as a single process, no matter
how many threads it has. This means that top and ps suddenly do the right
thing again.

2) It makes available statistics that were previously hidden. On exit of a
task, its rusage would be lost, except to the process itself. It was not
available over /proc

I wrote this patch because I have a threaded webserver and a threaded
indexer that are taking too long to do their thing, but I was unable to
figure out which was the culprit as neither appeared in any statistics, both
are using shortlived threads.

The patch has some problems of its own, which is why it should not be
applied in its current form:

1) It is not complete in that it only does utime and stime, and not yet the
other interesting fields (context switches etc)

2) A little bird told me that at KS, it was decided not to make processes
with threads act like normal processes.

3) I think it is prone to some race conditions and needs at least one
additional 'task_alive()' check.

4) It may confuse procps tools that synthesize part of the missing
information by manually summing the data in /proc/pid/task/tid/stat, which
will from now on report double cpu time.

To this I mention that all information is still available and that the
common case 'tell me which process is busy' is a lot cheaper now, and does
not require walking over all /proc/pid/task/tid/stat.

I'm happy to hear comments, but I hope this patch will be considered as it
solves real world problems, even though it might confuse some theoretically
task-aware procps tools (which I did not find).

Patch, followed by a small program which can be used to study the problem.

diff -urNbB -X dontdiff linux-2.6.9-rc4/fs/proc/array.c linux-2.6.9-rc4-ahu/fs/proc/array.c
--- linux-2.6.9-rc4/fs/proc/array.c	2004-10-16 12:03:43.000000000 +0200
+++ linux-2.6.9-rc4-ahu/fs/proc/array.c	2004-10-16 12:12:05.000000000 +0200
@@ -300,7 +300,19 @@
 	return buffer - orig;
 }
 
-int proc_pid_stat(struct task_struct *task, char * buffer)
+static void sub_task_accounting(struct task_struct *leader_task, unsigned long* utime, unsigned long* stime)
+{
+	struct task_struct *task=leader_task;
+
+	read_lock(&tasklist_lock);
+	do {
+		*utime += task->utime;
+		*stime += task->stime;
+	} while ((task = next_thread(task)) != leader_task);
+	read_unlock(&tasklist_lock);
+}
+
+static int proc_pid_stat(struct task_struct *task, char * buffer, char taskview)
 {
 	unsigned long vsize, eip, esp, wchan;
 	long priority, nice;
@@ -313,6 +325,7 @@
 	struct mm_struct *mm;
 	unsigned long long start_time;
 	unsigned long cmin_flt = 0, cmaj_flt = 0, cutime = 0, cstime = 0;
+	unsigned long stutime = 0, ststime = 0;
 	char tcomm[sizeof(task->comm)];
 
 	state = *get_task_state(task);
@@ -347,6 +360,10 @@
 		cmaj_flt = task->signal->cmaj_flt;
 		cutime = task->signal->cutime;
 		cstime = task->signal->cstime;
+		if (!taskview) {
+			stutime = task->signal->utime;
+			ststime = task->signal->stime;
+		}
 	}
 	read_unlock(&tasklist_lock);
 
@@ -362,6 +379,9 @@
 	/* Temporary variable needed for gcc-2.96 */
 	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
 
+	if (!taskview) 
+		sub_task_accounting(task, &stutime, &ststime);
+
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
@@ -378,8 +398,8 @@
 		cmin_flt,
 		task->maj_flt,
 		cmaj_flt,
-		jiffies_to_clock_t(task->utime),
-		jiffies_to_clock_t(task->stime),
+		jiffies_to_clock_t(task->utime + stutime),
+		jiffies_to_clock_t(task->stime + ststime),
 		jiffies_to_clock_t(cutime),
 		jiffies_to_clock_t(cstime),
 		priority,
@@ -415,6 +435,18 @@
 	return res;
 }
 
+
+int proc_tid_stat(struct task_struct *task, char * buffer)
+{
+	return proc_pid_stat(task, buffer, 1);
+}
+
+int proc_tgid_stat(struct task_struct *task, char * buffer)
+{
+	return proc_pid_stat(task, buffer, 0);
+}
+
+
 int proc_pid_statm(struct task_struct *task, char *buffer)
 {
 	int size = 0, resident = 0, shared = 0, text = 0, lib = 0, data = 0;
diff -urNbB -X dontdiff linux-2.6.9-rc4/fs/proc/base.c linux-2.6.9-rc4-ahu/fs/proc/base.c
--- linux-2.6.9-rc4/fs/proc/base.c	2004-10-16 12:03:43.000000000 +0200
+++ linux-2.6.9-rc4-ahu/fs/proc/base.c	2004-10-16 11:48:14.000000000 +0200
@@ -189,7 +189,8 @@
 	return PROC_I(inode)->type;
 }
 
-int proc_pid_stat(struct task_struct*,char*);
+int proc_tid_stat(struct task_struct*,char*);
+int proc_tgid_stat(struct task_struct*,char*);
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
 
@@ -1315,9 +1316,12 @@
 			ei->op.proc_read = proc_pid_status;
 			break;
 		case PROC_TID_STAT:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_tid_stat;
+			break;		
 		case PROC_TGID_STAT:
 			inode->i_fop = &proc_info_file_operations;
-			ei->op.proc_read = proc_pid_stat;
+			ei->op.proc_read = proc_tgid_stat;
 			break;
 		case PROC_TID_CMDLINE:
 		case PROC_TGID_CMDLINE:


-------------

#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>

#include <stdio.h>
#include <pthread.h>

void *run(void *arg)
{
  unsigned int n=0;
  for(n=0;n<3000000000U;++n)
    ;
  return 0;
}

int main()
{
    pthread_t t;
    struct rusage ru;

    int i;
    void* ret;

    for (i = 0; i < 5; ++i)
        pthread_create(&t, NULL, run, NULL);
    pthread_join(t, &ret);
    getrusage(RUSAGE_SELF, &ru);

    printf("%d seconds\n", ru.ru_utime.tv_sec);

    sleep(10);

}

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
