Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWBFUQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWBFUQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWBFUQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:16:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1409 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932376AbWBFUQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:16:28 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 20/20] proc: Update /proc to support multiple pid
 spaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
	<m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xsol0p9.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q3cl0mk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zml4jlzk.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vevsjlxa.fsf_-_@ebiederm.dsl.xmission.com>
	<m1r76gjlua.fsf_-_@ebiederm.dsl.xmission.com>
	<m1mzh4jlrl.fsf_-_@ebiederm.dsl.xmission.com>
	<m1irrsjlnn.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:12:14 -0700
In-Reply-To: <m1irrsjlnn.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 13:07:56 -0700")
Message-ID: <m1ek2gjlgh.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch does a couple of things.
- It splits proc into proc and proc_sysinfo
- It adds pspace support to proc
- It adds getattr methods to ensure proc has the proper hard link count.
- It increases the size of a couple of buffers by one to avoid buffer overflow
- It moves /proc/mounts and /proc/loadavg into the proc filesystem from proc_sysinfo

Sorry for the big patch.  When I start feeding this changes seriously I will
split this patch.

The split of /proc into mutliple filesystems works well however it comes
with one downsides.  There are now some directories where cd -P <subdir>/..
is not a noop.  Basically it is doing the equivalent of following symlinks
into an internal kernel mount.  It is well defined and safe behaviour but
I'm not certain if it is desirable.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/Kconfig                      |    6 
 fs/proc/Makefile                |   22 +-
 fs/proc/array.c                 |  203 ++++++++++++++++
 fs/proc/base.c                  |  487 +++++++++++++++++++++++++++++++++------
 fs/proc/generic.c               |   28 ++
 fs/proc/inode.c                 |   92 ++-----
 fs/proc/internal.h              |   38 +--
 fs/proc/kcore.c                 |    2 
 fs/proc/mmu.c                   |    4 
 fs/proc/nommu.c                 |    4 
 fs/proc/proc.c                  |  168 +++++++++++++
 fs/proc/proc_devtree.c          |    2 
 fs/proc/proc_misc.c             |   27 --
 fs/proc/proc_tty.c              |    2 
 fs/proc/root.c                  |  101 +-------
 fs/proc/sysinfo.h               |   35 +++
 fs/proc/vmcore.c                |    2 
 include/linux/proc_fs.h         |  216 -----------------
 include/linux/proc_sysinfo_fs.h |  228 ++++++++++++++++++
 include/linux/pspace.h          |    1 
 kernel/pid.c                    |    4 
 security/selinux/hooks.c        |   10 -
 22 files changed, 1156 insertions(+), 526 deletions(-)
 create mode 100644 fs/proc/proc.c
 create mode 100644 fs/proc/sysinfo.h
 create mode 100644 include/linux/proc_sysinfo_fs.h

85533ea023d4002528fe0325406160e69c4ca7dd
diff --git a/fs/Kconfig b/fs/Kconfig
index 93b5dc4..f953b29 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -765,6 +765,7 @@ menu "Pseudo filesystems"
 
 config PROC_FS
 	bool "/proc file system support"
+	select PROC_SYSINFO_FS
 	help
 	  This is a virtual file system providing information about the status
 	  of the system. "Virtual" means that it doesn't take up any space on
@@ -792,6 +793,11 @@ config PROC_FS
 	  This option will enlarge your kernel by about 67 KB. Several
 	  programs depend on this, so everyone should say Y here.
 
+config PROC_SYSINFO_FS
+	bool
+	depends on PROC_FS
+	default n
+
 config PROC_KCORE
 	bool "/proc/kcore support" if !ARM
 	depends on PROC_FS && MMU
diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index 7431d7b..1ff44cf 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -2,14 +2,20 @@
 # Makefile for the Linux proc filesystem routines.
 #
 
-obj-$(CONFIG_PROC_FS) += proc.o
+obj-$(CONFIG_PROC_FS) += procfs.o
+obj-$(CONFIG_PROC_SYSINFO_FS) += proc-sysinfo.o
 
-proc-y			:= nommu.o task_nommu.o
-proc-$(CONFIG_MMU)	:= mmu.o task_mmu.o
+procfs-y		:= task_nommu.o
+procfs-$(CONFIG_MMU)	:= task_mmu.o
+procfs-y		+= proc.o base.o array.o
 
-proc-y       += inode.o root.o base.o generic.o array.o \
-		kmsg.o proc_tty.o proc_misc.o
 
-proc-$(CONFIG_PROC_KCORE)	+= kcore.o
-proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
-proc-$(CONFIG_PROC_DEVICETREE)	+= proc_devtree.o
+proc-sysinfo-y			:= nommu.o
+proc-sysinfo-$(CONFIG_MMU)	:= mmu.o
+
+proc-sysinfo-y	+= inode.o root.o generic.o kmsg.o proc_tty.o proc_misc.o
+
+proc-sysinfo-$(CONFIG_PROC_KCORE)	+= kcore.o
+proc-sysinfo-$(CONFIG_PROC_VMCORE)	+= vmcore.o
+proc-sysinfo-$(CONFIG_PROC_DEVICETREE)	+= proc_devtree.o
+
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 7eb1bd7..baa7d5e 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -75,6 +75,7 @@
 #include <linux/times.h>
 #include <linux/cpuset.h>
 #include <linux/rcupdate.h>
+#include <linux/pspace.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -137,6 +138,8 @@ static const char *task_state_array[] = 
 	"Z (zombie)",		/* 16 */
 	"X (dead)"		/* 32 */
 };
+static const char task_state_pspace[] = 
+	"P (pspace)";
 
 static inline const char * get_task_state(struct task_struct *tsk)
 {
@@ -175,8 +178,11 @@ static inline char * task_state(struct t
 		get_task_state(p),
 		(p->sleep_avg/1024)*100/(1020000000/1024),
 	       	p->tgid,
-		p->pid, pid_alive(p) ? p->group_leader->real_parent->tgid : 0,
-		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
+		p->pid, 
+		pid_alive(p) &&	p->pspace == p->group_leader->real_parent->pspace ?
+			p->group_leader->real_parent->tgid : 0,
+		pid_alive(p) && p->ptrace && p->pspace == p->parent->pspace ?
+			p->parent->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);
 	read_unlock(&tasklist_lock);
@@ -202,6 +208,47 @@ static inline char * task_state(struct t
 	return buffer;
 }
 
+
+static inline char * pspace_task_state(struct task_struct *p, char *buffer)
+{
+	struct group_info *group_info;
+	int g;
+
+	read_lock(&tasklist_lock);
+	buffer += sprintf(buffer,
+		"State:\t%s\n"
+		"Tgid:\t%d\n"
+		"Pid:\t%d\n"
+		"PPid:\t%d\n"
+		"TracerPid:\t%d\n"
+		"Uid:\t%d\t%d\t%d\t%d\n"
+		"Gid:\t%d\t%d\t%d\t%d\n",
+		task_state_pspace,
+	       	p->wid,
+		p->wid,
+		pid_alive(p)? p->group_leader->real_parent->tgid : 0,
+		pid_alive(p) && p->ptrace ? p->parent->pid : 0,
+		p->uid, p->euid, p->suid, p->fsuid,
+		p->gid, p->egid, p->sgid, p->fsgid);
+	read_unlock(&tasklist_lock);
+	task_lock(p);
+	rcu_read_lock();
+	buffer += sprintf(buffer,
+		"Groups:\t");
+	rcu_read_unlock();
+
+	group_info = p->group_info;
+	get_group_info(group_info);
+	task_unlock(p);
+
+	for (g = 0; g < min(group_info->ngroups,NGROUPS_SMALL); g++)
+		buffer += sprintf(buffer, "%d ", GROUP_AT(group_info,g));
+	put_group_info(group_info);
+
+	buffer += sprintf(buffer, "\n");
+	return buffer;
+}
+
 static char * render_sigset_t(const char *header, sigset_t *set, char *buffer)
 {
 	int i, len;
@@ -314,6 +361,15 @@ int proc_pid_status(struct task_struct *
 	return buffer - orig;
 }
 
+int proc_pspace_status(struct task_struct *task, char * buffer)
+{
+	char *orig = buffer;
+	buffer = task_name(task, buffer);
+	buffer = pspace_task_state(task, buffer);
+	buffer += sprintf(buffer, "Threads:\t%d\n", task->pspace->nr_threads);
+	return buffer - orig;
+}
+
 static int do_task_stat(struct task_struct *task, char * buffer, int whole)
 {
 	unsigned long vsize, eip, esp, wchan = ~0UL;
@@ -388,7 +444,9 @@ static int do_task_stat(struct task_stru
 		}
 		it_real_value = task->signal->real_timer.expires;
 	}
-	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
+	ppid = pid_alive(task) &&
+		task->pspace == task->group_leader->real_parent->pspace ?
+			task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
 
 	if (!whole || num_threads<2)
@@ -475,6 +533,137 @@ int proc_tgid_stat(struct task_struct *t
 	return do_task_stat(task, buffer, 1);
 }
 
+int proc_pspace_stat(struct task_struct *task, char * buffer)
+{
+	struct pspace *pspace = task->pspace;
+	long priority, nice;
+	int tty_pgrp = -1, tty_nr = 0;
+	char state;
+	int res;
+ 	pid_t ppid, pgid = -1, sid = -1;
+	int num_threads = 0;
+	unsigned long long start_time;
+	unsigned long cmin_flt = 0, cmaj_flt = 0;
+	unsigned long  min_flt = 0,  maj_flt = 0;
+	cputime_t cutime, cstime, utime, stime;
+	struct task_struct *p;
+	char tcomm[sizeof(task->comm)];
+
+	state = *task_state_pspace;
+	get_task_comm(tcomm, task);
+
+	cutime = cstime = utime = stime = cputime_zero;
+
+	/* scale priority and nice values from timeslices to -20..20 */
+	/* to make it look like a "normal" Unix priority/nice value  */
+	priority = task_prio(task);
+	nice = task_nice(task);
+
+	/* add up live thread stats at the pspace level */
+	read_lock(&tasklist_lock);
+	for_each_process(p) {
+		long t_priority, t_nice;
+		/* Skip processes outside the target process space */
+		if (!in_pspace(pspace, p))
+			continue;
+
+		t_priority = task_prio(task);
+		t_nice = task_nice(task);
+
+		if (priority > t_priority)
+			priority = t_priority;
+		if (nice > t_nice)
+			nice = t_nice;
+
+		if (p->sighand) {
+			spin_lock_irq(&task->sighand->siglock);
+			min_flt += p->min_flt;
+			maj_flt += p->maj_flt;
+			utime   = cputime_add(utime, p->utime);
+			stime   = cputime_add(stime, p->stime);
+			spin_unlock_irq(&task->sighand->siglock);
+		}
+		if (thread_group_leader(p) && p->signal) {
+			min_flt  += p->signal->min_flt;
+			maj_flt  += p->signal->maj_flt;
+			utime    = cputime_add(utime, p->signal->utime);
+			stime    = cputime_add(stime, p->signal->stime);
+			cmin_flt += p->signal->cmin_flt;
+			cmaj_flt += p->signal->cmaj_flt;
+			cutime   += p->signal->cutime;
+			cstime   += p->signal->cstime;
+		}
+		if (pspace_leader(p)) {
+			num_threads += p->pspace->nr_threads;
+		}
+	}
+	if (task->signal) {
+		if (task->signal->tty) {
+			tty_pgrp = task->wid;
+			tty_nr = new_encode_dev(tty_devnum(task->signal->tty));
+		}
+	}
+	ppid = pid_alive(task)? task->group_leader->real_parent->tgid : 0;
+	read_unlock(&tasklist_lock);
+
+	/* Temporary variable needed for gcc-2.96 */
+	/* convert timespec -> nsec*/
+	start_time = (unsigned long long)task->start_time.tv_sec * NSEC_PER_SEC
+				+ task->start_time.tv_nsec;
+	/* convert nsec -> ticks */
+	start_time = nsec_to_clock_t(start_time);
+	
+	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %d %ld %llu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
+		task->wid,
+		tcomm,
+		state,
+		ppid,
+		pgid,
+		sid,
+		tty_nr,
+		tty_pgrp,
+		0UL, /* task->flags */
+		min_flt,
+		cmin_flt,
+		maj_flt,
+		cmaj_flt,
+		cputime_to_clock_t(utime),
+		cputime_to_clock_t(stime),
+		cputime_to_clock_t(cutime),
+		cputime_to_clock_t(cstime),
+		priority,
+		nice,
+		num_threads,
+		0UL /* it_real_value (Not implemented) */,
+		start_time,
+		0UL /* vsize */,
+		0L /* mm_counter */,
+	        0UL /* rsslim */,
+		0UL /* start_code */,
+		0UL /* end_code */,
+		0UL /* start_stack */,
+		0UL /* esp */,
+		0UL /* eip */,
+		/* The signal information here is obsolete.
+		 * It must be decimal for Linux 2.0 compatibility.
+		 * Use /proc/#/status for real-time signals.
+		 */
+		0UL /* task->pending.signal.sig[0] & 0x7fffffffUL */,
+		0UL /* task->blocked.sig[0] & 0x7fffffffUL */,
+		0UL /* sigign      .sig[0] & 0x7fffffffUL */,
+		0UL /* sigcatch    .sig[0] & 0x7fffffffUL */,
+		0UL /* wchan */,
+		0UL,
+		0UL,
+		task->exit_signal,
+		0 /* task_cpu(task) */,
+		0UL /* task->rt_priority*/,
+		0UL /* task->policy*/);
+	return res;
+}
+
 int proc_pid_statm(struct task_struct *task, char *buffer)
 {
 	int size = 0, resident = 0, shared = 0, text = 0, lib = 0, data = 0;
@@ -488,3 +677,11 @@ int proc_pid_statm(struct task_struct *t
 	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
 		       size, resident, shared, text, lib, data, 0);
 }
+
+int proc_pspace_statm(struct task_struct *task, char *buffer)
+{
+	int size = 0, resident = 0, shared = 0, text = 0, lib = 0, data = 0;
+	
+	return sprintf(buffer,"%d %d %d %d %d %d %d\n",
+		       size, resident, shared, text, lib, data, 0);
+}
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 20feb75..66f2ccf 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -72,8 +72,12 @@
 #include <linux/cpuset.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
+#include <linux/pspace.h>
+
 #include "internal.h"
 
+static int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir, unsigned int nr);
+
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
  * Feel free to change the macro below - just keep the range distinct from
@@ -85,7 +89,11 @@
 #define fake_ino(pid,ino) (((pid)<<16)|(ino))
 
 enum pid_directory_inos {
-	PROC_TGID_INO = 2,
+	PROC_SELF = 2,
+	PROC_MOUNTS,
+	PROC_LOADAVG,	/* Must come after all of the symlinks */
+
+	PROC_TGID_INO,
 	PROC_TGID_TASK,
 	PROC_TGID_STATUS,
 	PROC_TGID_MEM,
@@ -126,6 +134,7 @@ enum pid_directory_inos {
 #endif
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
+
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
@@ -167,6 +176,11 @@ enum pid_directory_inos {
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
 
+	PROC_PSPACE_STAT,
+	PROC_PSPACE_STATM,
+	PROC_PSPACE_STATUS,
+	PROC_PSPACE_CMDLINE,
+
 	/* Add new entries before this */
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
 };
@@ -180,6 +194,13 @@ struct pid_entry {
 
 #define E(type,name,mode) {(type),sizeof(name)-1,(name),(mode)}
 
+static struct pid_entry proc_base_stuff[] = {
+	E(PROC_SELF,		"self",   S_IFLNK|S_IRWXUGO),
+	E(PROC_MOUNTS,		"mounts", S_IFLNK|S_IRWXUGO),
+	E(PROC_LOADAVG,		"loadavg", S_IFREG|S_IRUGO),
+	{0,0,NULL,0}
+};
+
 static struct pid_entry tgid_base_stuff[] = {
 	E(PROC_TGID_TASK,      "task",    S_IFDIR|S_IRUGO|S_IXUGO),
 	E(PROC_TGID_FD,        "fd",      S_IFDIR|S_IRUSR|S_IXUSR),
@@ -266,6 +287,15 @@ static struct pid_entry tid_base_stuff[]
 	{0,0,NULL,0}
 };
 
+static struct pid_entry pspace_base_stuff[] = {
+	E(PROC_ROOT_INO,       "pspace",  S_IFDIR|S_IRUGO|S_IXUGO),
+	E(PROC_PSPACE_STAT,    "stat",    S_IFREG|S_IRUGO),
+	E(PROC_PSPACE_STATM,   "statm",   S_IFREG|S_IRUGO),
+	E(PROC_PSPACE_STATUS,  "status",  S_IFREG|S_IRUGO),
+	E(PROC_PSPACE_CMDLINE, "cmdline", S_IFREG|S_IRUGO),
+	{0,0,NULL,0}
+};
+
 #ifdef CONFIG_SECURITY
 static struct pid_entry tgid_attr_stuff[] = {
 	E(PROC_TGID_ATTR_CURRENT,  "current",  S_IFREG|S_IRUGO|S_IWUGO),
@@ -1067,6 +1097,118 @@ static struct file_operations proc_secco
 };
 #endif /* CONFIG_SECCOMP */
 
+/*
+ * /proc/self:
+ */
+struct pspace *child_pspace(struct pspace *pspace, struct task_struct *tsk)
+{
+	struct pspace *child;
+	child = tsk->pspace;
+	while(child && (child->child_reaper.pspace != pspace)) {
+		child = child->child_reaper.pspace;
+	}
+	return child;
+}
+
+static int proc_self_readlink(struct dentry *dentry, char __user *buffer,
+			      int buflen)
+{
+	struct pspace *pspace = proc_pspace(dentry->d_inode);
+	char tmp[30];
+	int result, len = 0;
+	while(buflen && pspace && (pspace != current->pspace)) {
+		pspace = child_pspace(pspace, current);
+		sprintf(tmp, "%d/pspace/", pspace->child_reaper.task->wid);
+		result = vfs_readlink(dentry, buffer, buflen, tmp);
+		if (result < 0)
+			goto out;
+		len += result;
+		buffer += result;
+		buflen -= result;
+	}
+	sprintf(tmp, "%d", current->tgid);
+	result = vfs_readlink(dentry, buffer, buflen, tmp);
+	if (result < 0)
+		goto out;
+	len += result;
+	result = len;
+ out:
+	return result;
+}
+
+static void *proc_self_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	struct pspace *pspace = proc_pspace(dentry->d_inode);
+	char tmp[30];
+	int result;
+	while(pspace && (pspace != current->pspace)) {
+		pspace = child_pspace(pspace, current);
+		sprintf(tmp, "%d/pspace/", pspace->child_reaper.task->wid);
+		result = vfs_follow_link(nd, tmp);
+		if (result < 0)
+			goto out;
+	}
+	sprintf(tmp, "%d", current->tgid);
+	result = vfs_follow_link(nd,tmp);
+ out:
+	return ERR_PTR(result);
+}	
+
+static struct inode_operations proc_self_inode_operations = {
+	.readlink	= proc_self_readlink,
+	.follow_link	= proc_self_follow_link,
+};
+
+static int self_revalidate(struct dentry *dentry, struct nameidata *nd)
+{
+	d_drop(dentry);
+	return 0;
+}
+
+static int self_delete_dentry(struct dentry * dentry)
+{
+	return 1;
+}
+
+static struct dentry_operations self_dentry_operations =
+{
+	.d_revalidate	= self_revalidate,
+	.d_delete	= self_delete_dentry,
+};
+
+static void *proc_mounts_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	static const char *mounts = "self/mounts";
+	nd_set_link(nd, (char *)mounts);
+	return NULL;
+}
+
+static struct inode_operations proc_mounts_inode_operations = {
+	.readlink	= generic_readlink,
+	.follow_link	= proc_mounts_follow_link,
+};
+
+#define LOAD_INT(x) ((x) >> FSHIFT)
+#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
+
+static int proc_loadavg(struct task_struct *task, char * buffer)
+{
+	struct pspace *pspace = task->pspace;
+	int a, b, c;
+	int len;
+
+	a = avenrun[0] + (FIXED_1/200);
+	b = avenrun[1] + (FIXED_1/200);
+	c = avenrun[2] + (FIXED_1/200);
+	len = sprintf(buffer,"%d.%02d %d.%02d %d.%02d %ld/%d %d\n",
+		LOAD_INT(a), LOAD_FRAC(a),
+		LOAD_INT(b), LOAD_FRAC(b),
+		LOAD_INT(c), LOAD_FRAC(c),
+		nr_running(), nr_threads, pspace? pspace->last_pid : 0);
+
+	return len;
+}
+
 static void *proc_pid_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = dentry->d_inode;
@@ -1149,11 +1291,12 @@ static struct inode_operations proc_pid_
 
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct dentry *dentry = filp->f_dentry;
+	struct inode *inode = dentry->d_inode;
 	struct task_struct *p = proc_task(inode);
 	unsigned int fd, tid, ino;
 	int retval;
-	char buf[NUMBUF];
+	char buf[NUMBUF + 1];
 	struct files_struct * files;
 	struct fdtable *fdt;
 
@@ -1170,7 +1313,7 @@ static int proc_readfd(struct file * fil
 				goto out;
 			filp->f_pos++;
 		case 1:
-			ino = fake_ino(tid, PROC_TID_INO);
+			ino = parent_ino(dentry);
 			if (filldir(dirent, "..", 2, 1, ino, DT_DIR) < 0)
 				goto out;
 			filp->f_pos++;
@@ -1189,8 +1332,9 @@ static int proc_readfd(struct file * fil
 					continue;
 				rcu_read_unlock();
 
-				j = NUMBUF;
 				i = fd;
+				j = NUMBUF;
+				buf[j] = '\0';
 				do {
 					j--;
 					buf[j] = '0' + (i % 10);
@@ -1219,16 +1363,17 @@ static int proc_pident_readdir(struct fi
 	int pid;
 	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = proc_task(inode);
 	struct pid_entry *p;
 	ino_t ino;
 	int ret;
 
 	ret = -ENOENT;
-	if (!pid_alive(proc_task(inode)))
+	if (!pid_alive(task))
 		goto out;
 
 	ret = 0;
-	pid = proc_task(inode)->pid;
+	pid = task->pid;
 	i = filp->f_pos;
 	switch (i) {
 	case 0:
@@ -1280,6 +1425,111 @@ static int proc_tid_base_readdir(struct 
 				   tid_base_stuff,ARRAY_SIZE(tid_base_stuff));
 }
 
+static int proc_pspace_base_readdir(struct file * filp,
+			     void * dirent, filldir_t filldir)
+{
+	return proc_pident_readdir(filp,dirent,filldir,
+				   pspace_base_stuff,ARRAY_SIZE(pspace_base_stuff));
+}
+
+/* pspace root operations */
+static int proc_pspace_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *p = proc_task(inode);
+	generic_fillattr(inode, stat);
+	/*
+	 * nr_processes is actually protected by the tasklist_lock;
+	 * however, it's conventional to do reads, especially for
+	 * reporting, without any locking whatsoever.
+	 */
+	stat->nlink = proc_root.nlink;
+	if (pid_alive(p))
+		stat->nlink += p->pspace->nr_processes;
+	return 0;
+}
+
+static struct dentry *proc_pspace_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
+{
+	struct nameidata sysinfo_nd;
+	int err;
+	memset(&sysinfo_nd, 0, sizeof(sysinfo_nd));
+	sysinfo_nd.mnt = mntget(proc_sysinfo_mnt);
+	sysinfo_nd.dentry = dget(proc_sysinfo_mnt->mnt_root);
+	err = link_path_walk(dentry->d_name.name, &sysinfo_nd);
+	if (err == 0) {
+		mntput(sysinfo_nd.mnt);
+		return sysinfo_nd.dentry;
+	}
+	return proc_pid_lookup(dir, dentry, nd);
+}
+
+static int proc_pspace_open_dir(struct inode *inode, struct file *f)
+{
+	struct vfsmount *mnt = proc_sysinfo_mnt;
+	struct file *filp;
+	int err;
+
+	err = 0;
+	mntget(mnt);
+	dget(mnt->mnt_root);
+	filp = dentry_open(mnt->mnt_root, mnt, f->f_flags);
+	if (IS_ERR(filp))
+		err = PTR_ERR(filp);
+	else
+		f->private_data = filp;
+	return err;
+}
+
+static int proc_pspace_release_dir(struct inode *inode, struct file *f)
+{
+	struct file *filp;
+	filp = f->private_data;
+	f->private_data = NULL;
+	return filp_close(filp, NULL);
+}
+
+static int proc_pspace_readdir(struct file * f,
+	void * dirent, filldir_t filldir)
+{
+	struct file *filp;
+
+	filp = f->private_data;
+	if (f->f_pos < FIRST_PROCESS_ENTRY) {
+		int res;
+		filp->f_pos = f->f_pos;
+		/* Don't pick up . or .. */
+		if (filp->f_pos < 2)
+			filp->f_pos = 2;
+		res = vfs_readdir(filp, filldir, dirent);
+		f->f_pos = filp->f_pos;
+		if (res <= 0)
+			return res;
+		f->f_pos = FIRST_PROCESS_ENTRY;
+	}
+	return proc_pid_readdir(f, dirent, filldir, f->f_pos - FIRST_PROCESS_ENTRY);
+}
+
+/*
+ * The root /proc directory is special, as it has the
+ * <pid> directories. Thus we don't use the generic
+ * directory handling functions for that..
+ */
+static struct file_operations proc_pspace_operations = {
+	.read		= generic_read_dir,
+	.readdir	= proc_pspace_readdir,
+	.open		= proc_pspace_open_dir,
+	.release	= proc_pspace_release_dir,
+};
+
+/*
+ * proc root can do almost nothing..
+ */
+static struct inode_operations proc_pspace_inode_operations = {
+	.lookup		= proc_pspace_lookup,
+	.getattr	= proc_pspace_getattr,
+};
+
 /* building an inode */
 
 static int task_dumpable(struct task_struct *task)
@@ -1336,11 +1586,23 @@ out:
 	return inode;
 
 out_unlock:
-	ei->pde = NULL;
 	iput(inode);
 	return NULL;
 }
 
+struct inode *proc_pspace_make_inode(struct super_block *sb, struct pspace *pspace)
+{
+	struct inode *inode;
+	inode = proc_pid_make_inode(sb, pspace->child_reaper.task, PROC_ROOT_INO);
+	if (inode) {
+		inode->i_op    = &proc_pspace_inode_operations;
+		inode->i_fop   = &proc_pspace_operations;
+		inode->i_nlink = proc_root.nlink;
+		inode->i_mode  = S_IFDIR|S_IRUGO|S_IXUGO;
+	}
+	return inode;
+}
+
 /* dentry stuff */
 
 /*
@@ -1527,6 +1789,18 @@ static struct file_operations proc_task_
 /*
  * proc directories can do almost nothing..
  */
+static int proc_task_getattr(struct vfsmount *mnt, struct dentry *dentry, struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *p = proc_task(inode);
+	generic_fillattr(inode, stat);
+
+	stat->nlink = inode->i_nlink;
+	if (pid_alive(p) && p->signal)
+		stat->nlink += atomic_read(&p->signal->count);
+	return 0;
+}
+
 static struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.permission	= proc_permission,
@@ -1535,6 +1809,7 @@ static struct inode_operations proc_fd_i
 static struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
 	.permission	= proc_task_permission,
+	.getattr	= proc_task_getattr,
 };
 
 #ifdef CONFIG_SECURITY
@@ -1600,7 +1875,7 @@ static struct file_operations proc_tgid_
 static struct inode_operations proc_tgid_attr_inode_operations;
 #endif
 
-static int get_tid_list(int index, unsigned int *tids, struct inode *dir);
+static int get_tid_list(struct pspace *pspace, int index, unsigned int *tids, struct inode *dir);
 
 /* SMP-safe */
 static struct dentry *proc_pident_lookup(struct inode *dir, 
@@ -1609,6 +1884,7 @@ static struct dentry *proc_pident_lookup
 {
 	struct inode *inode;
 	int error;
+	struct pspace *pspace = proc_pspace(dir);
 	struct task_struct *task = proc_task(dir);
 	struct pid_entry *p;
 	struct proc_inode *ei;
@@ -1628,6 +1904,10 @@ static struct dentry *proc_pident_lookup
 	if (!p->name)
 		goto out;
 
+	/* Don't setup /proc/self symlinks if this isn't the readers pspace. */
+	if ((p->type < PROC_LOADAVG) && !in_pspace(pspace, current))
+		goto out;
+
 	error = -EINVAL;
 	inode = proc_pid_make_inode(dir->i_sb, task, p->type);
 	if (!inode)
@@ -1635,13 +1915,26 @@ static struct dentry *proc_pident_lookup
 
 	ei = PROC_I(inode);
 	inode->i_mode = p->mode;
+	dentry->d_op = &pid_dentry_operations;
 	/*
 	 * Yes, it does not scale. And it should not. Don't add
 	 * new entries into /proc/<tgid>/ without very good reasons.
 	 */
 	switch(p->type) {
+		case PROC_SELF:
+			inode->i_op = &proc_self_inode_operations;
+			dentry->d_op = &self_dentry_operations;
+			break;
+		case PROC_MOUNTS:
+			inode->i_op = &proc_mounts_inode_operations;
+			dentry->d_op = &self_dentry_operations;
+			break;
+		case PROC_LOADAVG:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_loadavg;
+			break;
 		case PROC_TGID_TASK:
-			inode->i_nlink = 2 + get_tid_list(2, NULL, dir);
+			inode->i_nlink = 2;
 			inode->i_op = &proc_task_inode_operations;
 			inode->i_fop = &proc_task_operations;
 			break;
@@ -1681,6 +1974,10 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_status;
 			break;
+		case PROC_PSPACE_STATUS:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pspace_status;
+			break;
 		case PROC_TID_STAT:
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_tid_stat;
@@ -1689,8 +1986,13 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_tgid_stat;
 			break;
+		case PROC_PSPACE_STAT:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pspace_stat;
+			break;
 		case PROC_TID_CMDLINE:
 		case PROC_TGID_CMDLINE:
+		case PROC_PSPACE_CMDLINE:
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_cmdline;
 			break;
@@ -1699,6 +2001,10 @@ static struct dentry *proc_pident_lookup
 			inode->i_fop = &proc_info_file_operations;
 			ei->op.proc_read = proc_pid_statm;
 			break;
+		case PROC_PSPACE_STATM:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_pspace_statm;
+			break;
 		case PROC_TID_MAPS:
 		case PROC_TGID_MAPS:
 			inode->i_fop = &proc_maps_operations;
@@ -1792,7 +2098,6 @@ static struct dentry *proc_pident_lookup
 			iput(inode);
 			return ERR_PTR(-EINVAL);
 	}
-	dentry->d_op = &pid_dentry_operations;
 	d_add(dentry, inode);
 	return NULL;
 
@@ -1808,6 +2113,19 @@ static struct dentry *proc_tid_base_look
 	return proc_pident_lookup(dir, dentry, tid_base_stuff);
 }
 
+static struct dentry *proc_pspace_base_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
+{
+	int error;
+	error = -ENOENT;
+	if (memcmp(dentry->d_name.name, "pspace", 6) == 0) {
+		struct vfsmount *mnt;
+		mnt = proc_pspace_get_mnt(proc_pspace(dir));
+		if (!IS_ERR(mnt))
+			return dget(mnt->mnt_root);
+	}
+	return proc_pident_lookup(dir, dentry, pspace_base_stuff);
+}
+
 static struct file_operations proc_tgid_base_operations = {
 	.read		= generic_read_dir,
 	.readdir	= proc_tgid_base_readdir,
@@ -1818,6 +2136,11 @@ static struct file_operations proc_tid_b
 	.readdir	= proc_tid_base_readdir,
 };
 
+static struct file_operations proc_pspace_base_operations = {
+	.read		= generic_read_dir,
+	.readdir	= proc_pspace_base_readdir,
+};
+
 static struct inode_operations proc_tgid_base_inode_operations = {
 	.lookup		= proc_tgid_base_lookup,
 };
@@ -1826,6 +2149,10 @@ static struct inode_operations proc_tid_
 	.lookup		= proc_tid_base_lookup,
 };
 
+static struct inode_operations proc_pspace_base_inode_operations = {
+	.lookup		= proc_pspace_base_lookup,
+};
+
 #ifdef CONFIG_SECURITY
 static int proc_tgid_attr_readdir(struct file * filp,
 			     void * dirent, filldir_t filldir)
@@ -1872,29 +2199,6 @@ static struct inode_operations proc_tid_
 };
 #endif
 
-/*
- * /proc/self:
- */
-static int proc_self_readlink(struct dentry *dentry, char __user *buffer,
-			      int buflen)
-{
-	char tmp[30];
-	sprintf(tmp, "%d", current->tgid);
-	return vfs_readlink(dentry,buffer,buflen,tmp);
-}
-
-static void *proc_self_follow_link(struct dentry *dentry, struct nameidata *nd)
-{
-	char tmp[30];
-	sprintf(tmp, "%d", current->tgid);
-	return ERR_PTR(vfs_follow_link(nd,tmp));
-}	
-
-static struct inode_operations proc_self_inode_operations = {
-	.readlink	= proc_self_readlink,
-	.follow_link	= proc_self_follow_link,
-};
-
 /**
  * proc_pid_unhash -  Unhash /proc/@pid entry from the dcache.
  * @p: task that should be flushed.
@@ -1952,33 +2256,23 @@ void proc_pid_flush(struct dentry *proc_
 /* SMP-safe */
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
+	struct pspace *pspace = proc_pspace(nd->dentry->d_inode);
+	struct dentry *result;
 	struct task_struct *task;
 	struct inode *inode;
-	struct proc_inode *ei;
 	unsigned tgid;
 	int died;
 
-	if (dentry->d_name.len == 4 && !memcmp(dentry->d_name.name,"self",4)) {
-		inode = new_inode(dir->i_sb);
-		if (!inode)
-			return ERR_PTR(-ENOMEM);
-		ei = PROC_I(inode);
-		inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-		inode->i_ino = fake_ino(0, PROC_TGID_INO);
-		ei->pde = NULL;
-		inode->i_mode = S_IFLNK|S_IRWXUGO;
-		inode->i_uid = inode->i_gid = 0;
-		inode->i_size = 64;
-		inode->i_op = &proc_self_inode_operations;
-		d_add(dentry, inode);
-		return NULL;
-	}
+	result = proc_pident_lookup(dir, dentry, proc_base_stuff);
+	if (!IS_ERR(result) || (PTR_ERR(result) != -ENOENT))
+		return result;
+
 	tgid = name_to_int(dentry);
 	if (tgid == ~0U)
 		goto out;
 
 	read_lock(&tasklist_lock);
-	task = find_task_by_pid(tgid);
+	task = find_task_by_pid(pspace, tgid);
 	if (task)
 		get_task_struct(task);
 	read_unlock(&tasklist_lock);
@@ -1993,14 +2287,20 @@ struct dentry *proc_pid_lookup(struct in
 		goto out;
 	}
 	inode->i_mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	inode->i_op = &proc_tgid_base_inode_operations;
-	inode->i_fop = &proc_tgid_base_operations;
 	inode->i_flags|=S_IMMUTABLE;
+	if (unlikely(pspace_leader(task) && (task->pspace != pspace))) {
+		inode->i_op = &proc_pspace_base_inode_operations;
+		inode->i_fop = &proc_pspace_base_operations;
+		inode->i_nlink = 3;
+	} else {
+		inode->i_op = &proc_tgid_base_inode_operations;
+		inode->i_fop = &proc_tgid_base_operations;
 #ifdef CONFIG_SECURITY
-	inode->i_nlink = 5;
+		inode->i_nlink = 5;
 #else
-	inode->i_nlink = 4;
+		inode->i_nlink = 4;
 #endif
+	}
 
 	dentry->d_op = &pid_base_dentry_operations;
 
@@ -2027,6 +2327,7 @@ out:
 /* SMP-safe */
 static struct dentry *proc_task_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *nd)
 {
+	struct pspace *pspace = proc_pspace(dir);
 	struct task_struct *task;
 	struct task_struct *leader = proc_task(dir);
 	struct inode *inode;
@@ -2037,7 +2338,7 @@ static struct dentry *proc_task_lookup(s
 		goto out;
 
 	read_lock(&tasklist_lock);
-	task = find_task_by_pid(tid);
+	task = find_task_by_pid(pspace, tid);
 	if (task)
 		get_task_struct(task);
 	read_unlock(&tasklist_lock);
@@ -2081,16 +2382,15 @@ out:
  * tasklist lock while doing this, and we must release it before
  * we actually do the filldir itself, so we use a temp buffer..
  */
-static int get_tgid_list(int index, unsigned long version, unsigned int *tgids)
+static int get_tgid_list(struct pspace *pspace, int index, unsigned long version, unsigned int *tgids)
 {
 	struct task_struct *p;
 	int nr_tgids = 0;
 
-	index--;
 	read_lock(&tasklist_lock);
 	p = NULL;
 	if (version) {
-		p = find_task_by_pid(version);
+		p = find_task_by_pid(pspace, version);
 		if (p && !thread_group_leader(p))
 			p = NULL;
 	}
@@ -2101,12 +2401,13 @@ static int get_tgid_list(int index, unsi
 		p = next_task(&init_task);
 
 	for ( ; p != &init_task; p = next_task(p)) {
-		int tgid = p->pid;
 		if (!pid_alive(p))
 			continue;
+		if (!pspace_task_visible(pspace, p))
+			continue;
 		if (--index >= 0)
 			continue;
-		tgids[nr_tgids] = tgid;
+		tgids[nr_tgids] = (p->pspace == pspace) ? p->pid : p->wid;
 		nr_tgids++;
 		if (nr_tgids >= PROC_MAXPIDS)
 			break;
@@ -2120,7 +2421,7 @@ static int get_tgid_list(int index, unsi
  * tasklist lock while doing this, and we must release it before
  * we actually do the filldir itself, so we use a temp buffer..
  */
-static int get_tid_list(int index, unsigned int *tids, struct inode *dir)
+static int get_tid_list(struct pspace *pspace, int index, unsigned int *tids, struct inode *dir)
 {
 	struct task_struct *leader_task = proc_task(dir);
 	struct task_struct *task = leader_task;
@@ -2133,7 +2434,7 @@ static int get_tid_list(int index, unsig
 	 * unlinked task, which cannot be used to access the task-list
 	 * via next_thread().
 	 */
-	if (pid_alive(task)) do {
+	if (pid_alive(task) && pspace_task_visible(pspace, task)) do {
 		int tid = task->pid;
 
 		if (--index >= 0)
@@ -2149,20 +2450,47 @@ static int get_tid_list(int index, unsig
 }
 
 /* for the /proc/ directory itself, after non-process stuff has been done */
-int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
+static int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir, unsigned int nr)
 {
+	struct dentry *dentry = filp->f_dentry;
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = proc_task(inode);
+	struct pspace *pspace = task->pspace;
 	unsigned int tgid_array[PROC_MAXPIDS];
-	char buf[PROC_NUMBUF];
-	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
+	char buf[PROC_NUMBUF + 1];
 	unsigned int nr_tgids, i;
+	ino_t ino;
 	int next_tgid;
 
-	if (!nr) {
-		ino_t ino = fake_ino(0,PROC_TGID_INO);
-		if (filldir(dirent, "self", 4, filp->f_pos, ino, DT_LNK) < 0)
-			return 0;
+	if (!pid_alive(task))
+		goto out;
+
+	switch (nr) {
+	case 0:
+		ino = inode->i_ino;
+		if (filldir(dirent, ".", 1, filp->f_pos, ino, DT_DIR) < 0)
+			goto out;
+		filp->f_pos++; 
+		nr++;
+		/* fall through */
+	case 1:
+		ino = parent_ino(dentry);
+		if (filldir(dirent, "..", 2, filp->f_pos, ino, DT_DIR) < 0)
+			goto out;
 		filp->f_pos++;
 		nr++;
+		/* fall through */
+	}
+	nr -= 2;
+	for(; nr < (ARRAY_SIZE(proc_base_stuff) - 1); filp->f_pos++, nr++) {
+		struct pid_entry *p = proc_base_stuff + nr;
+		/* Don't return /proc/self symlinks if this isn't the readers pspace. */
+		if ((p->type < PROC_LOADAVG) && !in_pspace(pspace, current))
+			continue;
+		ino = fake_ino(1, p->type);
+		if (filldir(dirent, p->name, p->len, filp->f_pos,
+			    ino, p->mode >> 12) < 0)
+			goto out;
 	}
 
 	/* f_version caches the tgid value that the last readdir call couldn't
@@ -2170,8 +2498,9 @@ int proc_pid_readdir(struct file * filp,
 	 */
 	next_tgid = filp->f_version;
 	filp->f_version = 0;
+	nr -= (ARRAY_SIZE(proc_base_stuff) - 1);
 	for (;;) {
-		nr_tgids = get_tgid_list(nr, next_tgid, tgid_array);
+		nr_tgids = get_tgid_list(pspace, nr, next_tgid, tgid_array);
 		if (!nr_tgids) {
 			/* no more entries ! */
 			break;
@@ -2186,9 +2515,11 @@ int proc_pid_readdir(struct file * filp,
 
 		for (i=0;i<nr_tgids;i++) {
 			int tgid = tgid_array[i];
-			ino_t ino = fake_ino(tgid,PROC_TGID_INO);
-			unsigned long j = PROC_NUMBUF;
+			unsigned long j;
 
+			ino = fake_ino(tgid, PROC_TGID_INO);
+			j = PROC_NUMBUF;
+			buf[j] = '\0';
 			do
 				buf[--j] = '0' + (tgid % 10);
 			while ((tgid /= 10) != 0);
@@ -2211,15 +2542,17 @@ out:
 static int proc_task_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
 	unsigned int tid_array[PROC_MAXPIDS];
-	char buf[PROC_NUMBUF];
+	char buf[PROC_NUMBUF + 1];
 	unsigned int nr_tids, i;
 	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = proc_task(inode);
+	struct pspace *pspace = task->pspace;
 	int retval = -ENOENT;
 	ino_t ino;
 	unsigned long pos = filp->f_pos;  /* avoiding "long long" filp->f_pos */
 
-	if (!pid_alive(proc_task(inode)))
+	if (!pid_alive(task))
 		goto out;
 	retval = 0;
 
@@ -2238,8 +2571,7 @@ static int proc_task_readdir(struct file
 		/* fall through */
 	}
 
-	nr_tids = get_tid_list(pos, tid_array, inode);
-	inode->i_nlink = pos + nr_tids;
+	nr_tids = get_tid_list(pspace, pos, tid_array, inode);
 
 	for (i = 0; i < nr_tids; i++) {
 		unsigned long j = PROC_NUMBUF;
@@ -2247,6 +2579,7 @@ static int proc_task_readdir(struct file
 
 		ino = fake_ino(tid,PROC_TID_INO);
 
+		buf[j] = '\0';
 		do
 			buf[--j] = '0' + (tid % 10);
 		while ((tid /= 10) != 0);
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 20e5c45..9befe4b 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -10,7 +10,7 @@
 
 #include <linux/errno.h>
 #include <linux/time.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/stat.h>
 #include <linux/module.h>
 #include <linux/mount.h>
@@ -21,7 +21,7 @@
 #include <linux/bitops.h>
 #include <asm/uaccess.h>
 
-#include "internal.h"
+#include "sysinfo.h"
 
 static ssize_t proc_file_read(struct file *file, char __user *buf,
 			      size_t nbytes, loff_t *ppos);
@@ -254,7 +254,7 @@ static int proc_getattr(struct vfsmount 
 			struct kstat *stat)
 {
 	struct inode *inode = dentry->d_inode;
-	struct proc_dir_entry *de = PROC_I(inode)->pde;
+	struct proc_dir_entry *de = PDE(inode);
 	if (de && de->nlink)
 		inode->i_nlink = de->nlink;
 
@@ -373,7 +373,7 @@ static struct dentry_operations proc_den
  * Don't create negative dentries here, return -ENOENT by hand
  * instead.
  */
-struct dentry *proc_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
+static struct dentry *proc_lookup(struct inode * dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct inode *inode = NULL;
 	struct proc_dir_entry * de;
@@ -389,7 +389,7 @@ struct dentry *proc_lookup(struct inode 
 				unsigned int ino = de->low_ino;
 
 				error = -EINVAL;
-				inode = proc_get_inode(dir->i_sb, ino, de);
+				inode = proc_sysinfo_get_inode(dir->i_sb, ino, de);
 				break;
 			}
 		}
@@ -413,7 +413,7 @@ struct dentry *proc_lookup(struct inode 
  * value of the readdir() call, as long as it's non-negative
  * for success..
  */
-int proc_readdir(struct file * filp,
+static int proc_readdir(struct file * filp,
 	void * dirent, filldir_t filldir)
 {
 	struct proc_dir_entry * de;
@@ -492,6 +492,20 @@ static struct inode_operations proc_dir_
 	.setattr	= proc_notify_change,
 };
 
+/*
+ * This is the root "inode" in the /proc tree..
+ */
+struct proc_dir_entry proc_root = {
+	.low_ino	= PROC_SYSINFO_ROOT_INO, 
+	.namelen	= 5, 
+	.name		= "/proc",
+	.mode		= S_IFDIR | S_IRUGO | S_IXUGO, 
+	.nlink		= 2, 
+	.proc_iops	= &proc_dir_inode_operations, 
+	.proc_fops	= &proc_dir_operations,
+	.parent		= &proc_root,
+};
+
 static int proc_register(struct proc_dir_entry * dir, struct proc_dir_entry * dp)
 {
 	unsigned int i;
@@ -527,7 +541,7 @@ static int proc_register(struct proc_dir
 static void proc_kill_inodes(struct proc_dir_entry *de)
 {
 	struct list_head *p;
-	struct super_block *sb = proc_mnt->mnt_sb;
+	struct super_block *sb = proc_sysinfo_mnt->mnt_sb;
 
 	/*
 	 * Actually it's a partial revoke().
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 6573f31..cf15c39 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -5,7 +5,7 @@
  */
 
 #include <linux/time.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/string.h>
@@ -15,11 +15,12 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/pspace.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
 
-#include "internal.h"
+#include "sysinfo.h"
 
 static inline struct proc_dir_entry * de_get(struct proc_dir_entry *de)
 {
@@ -55,20 +56,14 @@ static void de_put(struct proc_dir_entry
 /*
  * Decrement the use count of the proc_dir_entry.
  */
-static void proc_delete_inode(struct inode *inode)
+static void proc_sysinfo_delete_inode(struct inode *inode)
 {
 	struct proc_dir_entry *de;
-	struct task_struct *tsk;
 
 	truncate_inode_pages(&inode->i_data, 0);
 
-	/* Let go of any associated process */
-	tsk = PROC_I(inode)->task;
-	if (tsk)
-		put_task_struct(tsk);
-
 	/* Let go of any associated proc directory entry */
-	de = PROC_I(inode)->pde;
+	de = PDE(inode);
 	if (de) {
 		if (de->owner)
 			module_put(de->owner);
@@ -77,74 +72,29 @@ static void proc_delete_inode(struct ino
 	clear_inode(inode);
 }
 
-struct vfsmount *proc_mnt;
-
-static void proc_read_inode(struct inode * inode)
-{
-	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-}
-
-static kmem_cache_t * proc_inode_cachep;
+struct vfsmount *proc_sysinfo_mnt;
 
-static struct inode *proc_alloc_inode(struct super_block *sb)
+static void proc_sysinfo_read_inode(struct inode * inode)
 {
-	struct proc_inode *ei;
-	struct inode *inode;
-
-	ei = (struct proc_inode *)kmem_cache_alloc(proc_inode_cachep, SLAB_KERNEL);
-	if (!ei)
-		return NULL;
-	ei->task = NULL;
-	ei->type = 0;
-	ei->op.proc_get_link = NULL;
-	ei->pde = NULL;
-	inode = &ei->vfs_inode;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	return inode;
 }
 
-static void proc_destroy_inode(struct inode *inode)
-{
-	kmem_cache_free(proc_inode_cachep, PROC_I(inode));
-}
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
-{
-	struct proc_inode *ei = (struct proc_inode *) foo;
-
-	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
-	    SLAB_CTOR_CONSTRUCTOR)
-		inode_init_once(&ei->vfs_inode);
-}
- 
-int __init proc_init_inodecache(void)
-{
-	proc_inode_cachep = kmem_cache_create("proc_inode_cache",
-					     sizeof(struct proc_inode),
-					     0, SLAB_RECLAIM_ACCOUNT,
-					     init_once, NULL);
-	if (proc_inode_cachep == NULL)
-		return -ENOMEM;
-	return 0;
-}
-
-static int proc_remount(struct super_block *sb, int *flags, char *data)
+static int proc_sysinfo_remount(struct super_block *sb, int *flags, char *data)
 {
 	*flags |= MS_NODIRATIME;
 	return 0;
 }
 
-static struct super_operations proc_sops = { 
-	.alloc_inode	= proc_alloc_inode,
-	.destroy_inode	= proc_destroy_inode,
-	.read_inode	= proc_read_inode,
+static struct super_operations proc_sysinfo_sops = { 
+	.read_inode	= proc_sysinfo_read_inode,
 	.drop_inode	= generic_delete_inode,
-	.delete_inode	= proc_delete_inode,
+	.delete_inode	= proc_sysinfo_delete_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= proc_remount,
+	.remount_fs	= proc_sysinfo_remount,
 };
 
-struct inode *proc_get_inode(struct super_block *sb, unsigned int ino,
+struct inode *proc_sysinfo_get_inode(struct super_block *sb, unsigned int ino,
 				struct proc_dir_entry *de)
 {
 	struct inode * inode;
@@ -163,7 +113,7 @@ struct inode *proc_get_inode(struct supe
 	if (!inode)
 		goto out_ino;
 
-	PROC_I(inode)->pde = de;
+	inode->u.generic_ip = de;
 	if (de) {
 		if (de->mode) {
 			inode->i_mode = de->mode;
@@ -190,24 +140,20 @@ out_mod:
 	return NULL;
 }			
 
-int proc_fill_super(struct super_block *s, void *data, int silent)
+int proc_sysinfo_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode * root_inode;
 
 	s->s_flags |= MS_NODIRATIME;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
-	s->s_magic = PROC_SUPER_MAGIC;
-	s->s_op = &proc_sops;
+	s->s_magic = PROC_SYSINFO_SUPER_MAGIC;
+	s->s_op = &proc_sysinfo_sops;
 	s->s_time_gran = 1;
 	
-	root_inode = proc_get_inode(s, PROC_ROOT_INO, &proc_root);
+	root_inode = proc_sysinfo_get_inode(s, PROC_SYSINFO_ROOT_INO, &proc_root);
 	if (!root_inode)
 		goto out_no_root;
-	/*
-	 * Fixup the root inode's nlink value
-	 */
-	root_inode->i_nlink += nr_processes();
 	root_inode->i_uid = 0;
 	root_inode->i_gid = 0;
 	s->s_root = d_alloc_root(root_inode);
@@ -216,7 +162,7 @@ int proc_fill_super(struct super_block *
 	return 0;
 
 out_no_root:
-	printk("proc_read_super: get root inode failed\n");
+	printk("%s: get root inode failed\n", __func__);
 	iput(root_inode);
 	return -ENOMEM;
 }
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 95a1cf3..0a30e23 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -11,35 +11,22 @@
 
 #include <linux/proc_fs.h>
 
-struct vmalloc_info {
-	unsigned long	used;
-	unsigned long	largest_chunk;
-};
-
-#ifdef CONFIG_MMU
-#define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
-extern void get_vmalloc_info(struct vmalloc_info *vmi);
-#else
-
-#define VMALLOC_TOTAL 0UL
-#define get_vmalloc_info(vmi)			\
-do {						\
-	(vmi)->used = 0;			\
-	(vmi)->largest_chunk = 0;		\
-} while(0)
+/*
+ * Offset of the first process in the /proc root directory..
+ */
+#define FIRST_PROCESS_ENTRY 256
 
-#endif
-
-extern void create_seq_entry(char *name, mode_t mode, struct file_operations *f);
 extern int proc_exe_link(struct inode *, struct dentry **, struct vfsmount **);
 extern int proc_tid_stat(struct task_struct *,  char *);
 extern int proc_tgid_stat(struct task_struct *, char *);
+extern int proc_pspace_stat(struct task_struct *, char *);
 extern int proc_pid_status(struct task_struct *, char *);
+extern int proc_pspace_status(struct task_struct *, char *);
 extern int proc_pid_statm(struct task_struct *, char *);
+extern int proc_pspace_statm(struct task_struct *, char *);
+extern struct inode *proc_pspace_make_inode(struct super_block *sb, struct pspace *pspace);
+extern struct vfsmount *proc_pspace_get_mnt(struct pspace *pspace);
 
-void free_proc_entry(struct proc_dir_entry *de);
-
-int proc_init_inodecache(void);
 
 static inline struct task_struct *proc_task(struct inode *inode)
 {
@@ -50,3 +37,10 @@ static inline int proc_type(struct inode
 {
 	return PROC_I(inode)->type;
 }
+
+static inline struct pspace *proc_pspace(struct inode *inode)
+{
+	struct task_struct *task = proc_task(inode);
+	return task ? task->pspace : NULL;
+}
+
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index adc2cd9..fa24c71 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -11,7 +11,7 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/capability.h>
diff --git a/fs/proc/mmu.c b/fs/proc/mmu.c
index 25d2d9c..887eb5e 100644
--- a/fs/proc/mmu.c
+++ b/fs/proc/mmu.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/mman.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/pagemap.h>
@@ -29,7 +29,7 @@
 #include <asm/pgtable.h>
 #include <asm/tlb.h>
 #include <asm/div64.h>
-#include "internal.h"
+#include "sysinfo.h"
 
 void get_vmalloc_info(struct vmalloc_info *vmi)
 {
diff --git a/fs/proc/nommu.c b/fs/proc/nommu.c
index cff10ab..65c66ef 100644
--- a/fs/proc/nommu.c
+++ b/fs/proc/nommu.c
@@ -16,7 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/mman.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 #include <linux/pagemap.h>
@@ -30,7 +30,7 @@
 #include <asm/pgtable.h>
 #include <asm/tlb.h>
 #include <asm/div64.h>
-#include "internal.h"
+#include "sysinfo.h"
 
 /*
  * display a list of all the VMAs the kernel knows about
diff --git a/fs/proc/proc.c b/fs/proc/proc.c
new file mode 100644
index 0000000..0501975
--- /dev/null
+++ b/fs/proc/proc.c
@@ -0,0 +1,168 @@
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pspace.h>
+
+#include <linux/proc_fs.h>
+#include "internal.h"
+/*
+ * Release the task.
+ */
+static void proc_delete_inode(struct inode *inode)
+{
+	struct task_struct *tsk;
+
+	truncate_inode_pages(&inode->i_data, 0);
+
+	/* Let go of any associated process */
+	tsk = PROC_I(inode)->task;
+	if (tsk)
+		put_task_struct(tsk);
+
+	clear_inode(inode);
+}
+
+static void proc_read_inode(struct inode * inode)
+{
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+}
+
+static kmem_cache_t * proc_inode_cachep;
+
+static struct inode *proc_alloc_inode(struct super_block *sb)
+{
+	struct proc_inode *ei;
+	struct inode *inode;
+
+	ei = (struct proc_inode *)kmem_cache_alloc(proc_inode_cachep, SLAB_KERNEL);
+	if (!ei)
+		return NULL;
+	ei->task = NULL;
+	ei->type = 0;
+	ei->op.proc_get_link = NULL;
+	inode = &ei->vfs_inode;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
+	return inode;
+}
+
+static void proc_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(proc_inode_cachep, PROC_I(inode));
+}
+
+static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+{
+	struct proc_inode *ei = (struct proc_inode *) foo;
+
+	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
+	    SLAB_CTOR_CONSTRUCTOR)
+		inode_init_once(&ei->vfs_inode);
+}
+ 
+static int __init proc_init_inodecache(void)
+{
+	proc_inode_cachep = kmem_cache_create("proc_inode_cache",
+					     sizeof(struct proc_inode),
+					     0, SLAB_RECLAIM_ACCOUNT,
+					     init_once, NULL);
+	if (proc_inode_cachep == NULL)
+		return -ENOMEM;
+	return 0;
+}
+
+static int proc_remount(struct super_block *sb, int *flags, char *data)
+{
+	*flags |= MS_NODIRATIME;
+	return 0;
+}
+
+static struct super_operations proc_sops = { 
+	.alloc_inode	= proc_alloc_inode,
+	.destroy_inode	= proc_destroy_inode,
+	.read_inode	= proc_read_inode,
+	.drop_inode	= generic_delete_inode,
+	.delete_inode	= proc_delete_inode,
+	.statfs		= simple_statfs,
+	.remount_fs	= proc_remount,
+};
+
+static int proc_fill_super(struct super_block *s, void *data, int silent)
+{
+	struct inode * root_inode;
+	struct pspace *pspace = data;
+
+	s->s_flags |= MS_NODIRATIME;
+	s->s_blocksize = 1024;
+	s->s_blocksize_bits = 10;
+	s->s_magic = PROC_SUPER_MAGIC;
+	s->s_op = &proc_sops;
+	s->s_time_gran = 1;
+	
+	root_inode = proc_pspace_make_inode(s, pspace);
+	if (!root_inode)
+		goto out_no_root;
+	s->s_root = d_alloc_root(root_inode);
+	if (!s->s_root)
+		goto out_no_root;
+	return 0;
+
+out_no_root:
+	printk("%s: get root inode failed\n", __func__);
+	iput(root_inode);
+	return -ENOMEM;
+}
+
+static int proc_test_sb(struct super_block *s, void *data)
+{
+	struct dentry *dentry = s->s_root;
+	struct inode *inode = dentry->d_inode;
+	struct task_struct *task = PROC_I(inode)->task;
+
+	return task->pspace == data;
+}
+
+static int proc_set_sb(struct super_block *s, void *data)
+{
+	int err;
+	err = set_anon_super(s, NULL);
+	if (!err)
+		err = proc_fill_super(s, data, 0);
+	return err;
+}
+
+static struct super_block *proc_get_sb(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	return sget(fs_type, proc_test_sb, proc_set_sb, current->pspace);
+}
+
+static struct file_system_type proc_fs_type = {
+	.name		= "proc",
+	.get_sb		= proc_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+struct vfsmount *proc_pspace_get_mnt(struct pspace *pspace)
+{
+	struct vfsmount *mnt;
+	mnt = pspace->proc_mnt;
+	if (!mnt)
+		mnt = kern_mount(&proc_fs_type);
+	if (!IS_ERR(mnt))
+		pspace->proc_mnt = mnt;
+	return mnt;
+}
+
+static int __init proc_init(void)
+{
+	int err = 0;
+	err = proc_init_inodecache();
+	if (err)
+		goto out;
+	err = register_filesystem(&proc_fs_type);
+ out:
+	return err;
+}
+
+module_init(proc_init);
+MODULE_LICENSE("GPL");
diff --git a/fs/proc/proc_devtree.c b/fs/proc/proc_devtree.c
index 9bdd077..8b749d6 100644
--- a/fs/proc/proc_devtree.c
+++ b/fs/proc/proc_devtree.c
@@ -5,7 +5,7 @@
  */
 #include <linux/errno.h>
 #include <linux/time.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <asm/prom.h>
diff --git a/fs/proc/proc_misc.c b/fs/proc/proc_misc.c
index 8f80142..5037ed6 100644
--- a/fs/proc/proc_misc.c
+++ b/fs/proc/proc_misc.c
@@ -24,7 +24,7 @@
 #include <linux/tty.h>
 #include <linux/string.h>
 #include <linux/mman.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/mm.h>
@@ -46,15 +46,14 @@
 #include <linux/sysrq.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
+#include <linux/pspace.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
 #include <asm/tlb.h>
 #include <asm/div64.h>
-#include "internal.h"
+#include "sysinfo.h"
 
-#define LOAD_INT(x) ((x) >> FSHIFT)
-#define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
 /*
  * Warning: stuff below (imported functions) assumes that its output will fit
  * into one page. For some of those functions it may be wrong. Moreover, we
@@ -79,23 +78,6 @@ static int proc_calc_metrics(char *page,
 	return len;
 }
 
-static int loadavg_read_proc(char *page, char **start, off_t off,
-				 int count, int *eof, void *data)
-{
-	int a, b, c;
-	int len;
-
-	a = avenrun[0] + (FIXED_1/200);
-	b = avenrun[1] + (FIXED_1/200);
-	c = avenrun[2] + (FIXED_1/200);
-	len = sprintf(page,"%d.%02d %d.%02d %d.%02d %ld/%d %d\n",
-		LOAD_INT(a), LOAD_FRAC(a),
-		LOAD_INT(b), LOAD_FRAC(b),
-		LOAD_INT(c), LOAD_FRAC(c),
-		nr_running(), nr_threads, last_pid);
-	return proc_calc_metrics(page, start, off, count, eof, len);
-}
-
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
@@ -712,7 +694,6 @@ void __init proc_misc_init(void)
 		char *name;
 		int (*read_proc)(char*,char**,off_t,int,int*,void*);
 	} *p, simple_ones[] = {
-		{"loadavg",     loadavg_read_proc},
 		{"uptime",	uptime_read_proc},
 		{"meminfo",	meminfo_read_proc},
 		{"version",	version_read_proc},
@@ -731,8 +712,6 @@ void __init proc_misc_init(void)
 	for (p = simple_ones; p->name; p++)
 		create_proc_read_entry(p->name, 0, NULL, p->read_proc, NULL);
 
-	proc_symlink("mounts", NULL, "self/mounts");
-
 	/* And now for trickier ones */
 	entry = create_proc_entry("kmsg", S_IRUSR, &proc_root);
 	if (entry)
diff --git a/fs/proc/proc_tty.c b/fs/proc/proc_tty.c
index 15c4455..9715c1f 100644
--- a/fs/proc/proc_tty.c
+++ b/fs/proc/proc_tty.c
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/time.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/stat.h>
 #include <linux/tty.h>
 #include <linux/seq_file.h>
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 6889628..6e0f451 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -10,15 +10,15 @@
 
 #include <linux/errno.h>
 #include <linux/time.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/stat.h>
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/bitops.h>
 #include <linux/smp_lock.h>
-
-#include "internal.h"
+#include <linux/mount.h>
+#include "sysinfo.h"
 
 struct proc_dir_entry *proc_net, *proc_net_stat, *proc_bus, *proc_root_fs, *proc_root_driver;
 
@@ -26,30 +26,29 @@ struct proc_dir_entry *proc_net, *proc_n
 struct proc_dir_entry *proc_sys_root;
 #endif
 
-static struct super_block *proc_get_sb(struct file_system_type *fs_type,
+
+static struct super_block *proc_sysinfo_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
-	return get_sb_single(fs_type, flags, data, proc_fill_super);
+	return get_sb_single(fs_type, flags, data, proc_sysinfo_fill_super);
 }
 
-static struct file_system_type proc_fs_type = {
-	.name		= "proc",
-	.get_sb		= proc_get_sb,
+static struct file_system_type proc_sysinfo_fs_type = {
+	.name		= "proc_sysinfo",
+	.get_sb		= proc_sysinfo_get_sb,
 	.kill_sb	= kill_anon_super,
 };
 
 void __init proc_root_init(void)
 {
-	int err = proc_init_inodecache();
-	if (err)
-		return;
-	err = register_filesystem(&proc_fs_type);
+	int err;
+	err = register_filesystem(&proc_sysinfo_fs_type);
 	if (err)
 		return;
-	proc_mnt = kern_mount(&proc_fs_type);
-	err = PTR_ERR(proc_mnt);
-	if (IS_ERR(proc_mnt)) {
-		unregister_filesystem(&proc_fs_type);
+	proc_sysinfo_mnt = kern_mount(&proc_sysinfo_fs_type);
+	err = PTR_ERR(proc_sysinfo_mnt);
+	if (IS_ERR(proc_sysinfo_mnt)) {
+		unregister_filesystem(&proc_sysinfo_fs_type);
 		return;
 	}
 	proc_misc_init();
@@ -80,76 +79,6 @@ void __init proc_root_init(void)
 	proc_bus = proc_mkdir("bus", NULL);
 }
 
-static struct dentry *proc_root_lookup(struct inode * dir, struct dentry * dentry, struct nameidata *nd)
-{
-	/*
-	 * nr_threads is actually protected by the tasklist_lock;
-	 * however, it's conventional to do reads, especially for
-	 * reporting, without any locking whatsoever.
-	 */
-	if (dir->i_ino == PROC_ROOT_INO) /* check for safety... */
-		dir->i_nlink = proc_root.nlink + nr_threads;
-
-	if (!proc_lookup(dir, dentry, nd)) {
-		return NULL;
-	}
-	
-	return proc_pid_lookup(dir, dentry, nd);
-}
-
-static int proc_root_readdir(struct file * filp,
-	void * dirent, filldir_t filldir)
-{
-	unsigned int nr = filp->f_pos;
-	int ret;
-
-	lock_kernel();
-
-	if (nr < FIRST_PROCESS_ENTRY) {
-		int error = proc_readdir(filp, dirent, filldir);
-		if (error <= 0) {
-			unlock_kernel();
-			return error;
-		}
-		filp->f_pos = FIRST_PROCESS_ENTRY;
-	}
-	unlock_kernel();
-
-	ret = proc_pid_readdir(filp, dirent, filldir);
-	return ret;
-}
-
-/*
- * The root /proc directory is special, as it has the
- * <pid> directories. Thus we don't use the generic
- * directory handling functions for that..
- */
-static struct file_operations proc_root_operations = {
-	.read		 = generic_read_dir,
-	.readdir	 = proc_root_readdir,
-};
-
-/*
- * proc root can do almost nothing..
- */
-static struct inode_operations proc_root_inode_operations = {
-	.lookup		= proc_root_lookup,
-};
-
-/*
- * This is the root "inode" in the /proc tree..
- */
-struct proc_dir_entry proc_root = {
-	.low_ino	= PROC_ROOT_INO, 
-	.namelen	= 5, 
-	.name		= "/proc",
-	.mode		= S_IFDIR | S_IRUGO | S_IXUGO, 
-	.nlink		= 2, 
-	.proc_iops	= &proc_root_inode_operations, 
-	.proc_fops	= &proc_root_operations,
-	.parent		= &proc_root,
-};
-
 EXPORT_SYMBOL(proc_symlink);
 EXPORT_SYMBOL(proc_mkdir);
 EXPORT_SYMBOL(create_proc_entry);
diff --git a/fs/proc/sysinfo.h b/fs/proc/sysinfo.h
new file mode 100644
index 0000000..86cec89
--- /dev/null
+++ b/fs/proc/sysinfo.h
@@ -0,0 +1,35 @@
+/* sysinfo.h: internal proc_sysinfo_fs definitions
+ *
+ * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/proc_sysinfo_fs.h>
+
+struct vmalloc_info {
+	unsigned long	used;
+	unsigned long	largest_chunk;
+};
+
+#ifdef CONFIG_MMU
+#define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
+extern void get_vmalloc_info(struct vmalloc_info *vmi);
+#else
+
+#define VMALLOC_TOTAL 0UL
+#define get_vmalloc_info(vmi)			\
+do {						\
+	(vmi)->used = 0;			\
+	(vmi)->largest_chunk = 0;		\
+} while(0)
+
+#endif
+
+extern void create_seq_entry(char *name, mode_t mode, struct file_operations *f);
+
+void free_proc_entry(struct proc_dir_entry *de);
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4063fb3..fc192ae 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -9,7 +9,7 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
 #include <linux/elf.h>
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index aa6322d..185dac9 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -11,12 +11,6 @@
  */
 
 /*
- * Offset of the first process in the /proc root directory..
- */
-#define FIRST_PROCESS_ENTRY 256
-
-
-/*
  * We always define these enumerators
  */
 
@@ -26,225 +20,24 @@ enum {
 
 #define PROC_SUPER_MAGIC 0x9fa0
 
-/*
- * This is not completely implemented yet. The idea is to
- * create an in-memory tree (like the actual /proc filesystem
- * tree) of these proc_dir_entries, so that we can dynamically
- * add new files to /proc.
- *
- * The "next" pointer creates a linked list of one /proc directory,
- * while parent/subdir create the directory structure (every
- * /proc file has a parent, but "subdir" is NULL for all
- * non-directory entries).
- *
- * "get_info" is called at "read", while "owner" is used to protect module
- * from unloading while proc_dir_entry is in use
- */
-
-typedef	int (read_proc_t)(char *page, char **start, off_t off,
-			  int count, int *eof, void *data);
-typedef	int (write_proc_t)(struct file *file, const char __user *buffer,
-			   unsigned long count, void *data);
-typedef int (get_info_t)(char *, char **, off_t, int);
-
-struct proc_dir_entry {
-	unsigned int low_ino;
-	unsigned short namelen;
-	const char *name;
-	mode_t mode;
-	nlink_t nlink;
-	uid_t uid;
-	gid_t gid;
-	unsigned long size;
-	struct inode_operations * proc_iops;
-	struct file_operations * proc_fops;
-	get_info_t *get_info;
-	struct module *owner;
-	struct proc_dir_entry *next, *parent, *subdir;
-	void *data;
-	read_proc_t *read_proc;
-	write_proc_t *write_proc;
-	atomic_t count;		/* use count */
-	int deleted;		/* delete flag */
-	void *set;
-};
-
-struct kcore_list {
-	struct kcore_list *next;
-	unsigned long addr;
-	size_t size;
-};
-
-struct vmcore {
-	struct list_head list;
-	unsigned long long paddr;
-	unsigned long size;
-	loff_t offset;
-};
-
 #ifdef CONFIG_PROC_FS
 
-extern struct proc_dir_entry proc_root;
-extern struct proc_dir_entry *proc_root_fs;
-extern struct proc_dir_entry *proc_net;
-extern struct proc_dir_entry *proc_net_stat;
-extern struct proc_dir_entry *proc_bus;
-extern struct proc_dir_entry *proc_root_driver;
-extern struct proc_dir_entry *proc_root_kcore;
-
-extern void proc_root_init(void);
-extern void proc_misc_init(void);
-
 struct mm_struct;
 
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *);
 struct dentry *proc_pid_unhash(struct task_struct *p);
 void proc_pid_flush(struct dentry *proc_dentry);
-int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir);
 unsigned long task_vsize(struct mm_struct *);
 int task_statm(struct mm_struct *, int *, int *, int *, int *);
 char *task_mem(struct mm_struct *, char *);
 
-extern struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
-						struct proc_dir_entry *parent);
-extern void remove_proc_entry(const char *name, struct proc_dir_entry *parent);
-
-extern struct vfsmount *proc_mnt;
-extern int proc_fill_super(struct super_block *,void *,int);
-extern struct inode *proc_get_inode(struct super_block *, unsigned int, struct proc_dir_entry *);
-
-extern int proc_match(int, const char *,struct proc_dir_entry *);
-
-/*
- * These are generic /proc routines that use the internal
- * "struct proc_dir_entry" tree to traverse the filesystem.
- *
- * The /proc root directory has extended versions to take care
- * of the /proc/<pid> subdirectories.
- */
-extern int proc_readdir(struct file *, void *, filldir_t);
-extern struct dentry *proc_lookup(struct inode *, struct dentry *, struct nameidata *);
-
-extern struct file_operations proc_kcore_operations;
-extern struct file_operations proc_kmsg_operations;
-extern struct file_operations ppc_htab_operations;
-
-/*
- * proc_tty.c
- */
-struct tty_driver;
-extern void proc_tty_init(void);
-extern void proc_tty_register_driver(struct tty_driver *driver);
-extern void proc_tty_unregister_driver(struct tty_driver *driver);
-
-/*
- * proc_devtree.c
- */
-#ifdef CONFIG_PROC_DEVICETREE
-struct device_node;
-struct property;
-extern void proc_device_tree_init(void);
-extern void proc_device_tree_add_node(struct device_node *, struct proc_dir_entry *);
-extern void proc_device_tree_add_prop(struct proc_dir_entry *pde, struct property *prop);
-extern void proc_device_tree_remove_prop(struct proc_dir_entry *pde,
-					 struct property *prop);
-extern void proc_device_tree_update_prop(struct proc_dir_entry *pde,
-					 struct property *newprop,
-					 struct property *oldprop);
-#endif /* CONFIG_PROC_DEVICETREE */
-
-extern struct proc_dir_entry *proc_symlink(const char *,
-		struct proc_dir_entry *, const char *);
-extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
-extern struct proc_dir_entry *proc_mkdir_mode(const char *name, mode_t mode,
-			struct proc_dir_entry *parent);
-
-static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
-	mode_t mode, struct proc_dir_entry *base, 
-	read_proc_t *read_proc, void * data)
-{
-	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
-	if (res) {
-		res->read_proc=read_proc;
-		res->data=data;
-	}
-	return res;
-}
- 
-static inline struct proc_dir_entry *create_proc_info_entry(const char *name,
-	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
-{
-	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
-	if (res) res->get_info=get_info;
-	return res;
-}
- 
-static inline struct proc_dir_entry *proc_net_create(const char *name,
-	mode_t mode, get_info_t *get_info)
-{
-	return create_proc_info_entry(name,mode,proc_net,get_info);
-}
-
-static inline struct proc_dir_entry *proc_net_fops_create(const char *name,
-	mode_t mode, struct file_operations *fops)
-{
-	struct proc_dir_entry *res = create_proc_entry(name, mode, proc_net);
-	if (res)
-		res->proc_fops = fops;
-	return res;
-}
-
-static inline void proc_net_remove(const char *name)
-{
-	remove_proc_entry(name,proc_net);
-}
-
-#else
-
-#define proc_root_driver NULL
-#define proc_net NULL
-#define proc_bus NULL
-
-#define proc_net_fops_create(name, mode, fops)  ({ (void)(mode), NULL; })
-#define proc_net_create(name, mode, info)	({ (void)(mode), NULL; })
-static inline void proc_net_remove(const char *name) {}
+#else /* CONFIG_PROC_FS */
 
 static inline struct dentry *proc_pid_unhash(struct task_struct *p) { return NULL; }
 static inline void proc_pid_flush(struct dentry *proc_dentry) { }
 
-static inline struct proc_dir_entry *create_proc_entry(const char *name,
-	mode_t mode, struct proc_dir_entry *parent) { return NULL; }
-
-#define remove_proc_entry(name, parent) do {} while (0)
-
-static inline struct proc_dir_entry *proc_symlink(const char *name,
-		struct proc_dir_entry *parent,const char *dest) {return NULL;}
-static inline struct proc_dir_entry *proc_mkdir(const char *name,
-	struct proc_dir_entry *parent) {return NULL;}
-
-static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
-	mode_t mode, struct proc_dir_entry *base, 
-	read_proc_t *read_proc, void * data) { return NULL; }
-static inline struct proc_dir_entry *create_proc_info_entry(const char *name,
-	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
-	{ return NULL; }
-
-struct tty_driver;
-static inline void proc_tty_register_driver(struct tty_driver *driver) {};
-static inline void proc_tty_unregister_driver(struct tty_driver *driver) {};
-
-extern struct proc_dir_entry proc_root;
-
 #endif /* CONFIG_PROC_FS */
 
-#if !defined(CONFIG_PROC_KCORE)
-static inline void kclist_add(struct kcore_list *new, void *addr, size_t size)
-{
-}
-#else
-extern void kclist_add(struct kcore_list *, void *, size_t);
-#endif
-
 struct proc_inode {
 	struct task_struct *task;
 	int type;
@@ -252,8 +45,8 @@ struct proc_inode {
 		int (*proc_get_link)(struct inode *, struct dentry **, struct vfsmount **);
 		int (*proc_read)(struct task_struct *task, char *page);
 	} op;
-	struct proc_dir_entry *pde;
 	struct inode vfs_inode;
+	
 };
 
 static inline struct proc_inode *PROC_I(const struct inode *inode)
@@ -261,9 +54,6 @@ static inline struct proc_inode *PROC_I(
 	return container_of(inode, struct proc_inode, vfs_inode);
 }
 
-static inline struct proc_dir_entry *PDE(const struct inode *inode)
-{
-	return PROC_I(inode)->pde;
-}
+#include <linux/proc_sysinfo_fs.h>
 
 #endif /* _LINUX_PROC_FS_H */
diff --git a/include/linux/proc_sysinfo_fs.h b/include/linux/proc_sysinfo_fs.h
new file mode 100644
index 0000000..cbd8e1d
--- /dev/null
+++ b/include/linux/proc_sysinfo_fs.h
@@ -0,0 +1,228 @@
+#ifndef _LINUX_PROC_SYSINFO_FS_H
+#define _LINUX_PROC_SYSINFO_FS_H
+
+#include <linux/config.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <asm/atomic.h>
+
+/*
+ * We always define these enumerators
+ */
+
+enum {
+	PROC_SYSINFO_ROOT_INO = 1,
+};
+
+#define PROC_SYSINFO_SUPER_MAGIC 0x9fa1
+
+struct kcore_list {
+	struct kcore_list *next;
+	unsigned long addr;
+	size_t size;
+};
+
+struct vmcore {
+	struct list_head list;
+	unsigned long long paddr;
+	unsigned long size;
+	loff_t offset;
+};
+
+#ifdef CONFIG_PROC_SYSINFO_FS
+
+/*
+ * This is not completely implemented yet. The idea is to
+ * create an in-memory tree (like the actual /proc filesystem
+ * tree) of these proc_dir_entries, so that we can dynamically
+ * add new files to /proc.
+ *
+ * The "next" pointer creates a linked list of one /proc directory,
+ * while parent/subdir create the directory structure (every
+ * /proc file has a parent, but "subdir" is NULL for all
+ * non-directory entries).
+ *
+ * "get_info" is called at "read", while "owner" is used to protect module
+ * from unloading while proc_dir_entry is in use
+ */
+
+typedef	int (read_proc_t)(char *page, char **start, off_t off,
+			  int count, int *eof, void *data);
+typedef	int (write_proc_t)(struct file *file, const char __user *buffer,
+			   unsigned long count, void *data);
+typedef int (get_info_t)(char *, char **, off_t, int);
+
+struct proc_dir_entry {
+	unsigned int low_ino;
+	unsigned short namelen;
+	const char *name;
+	mode_t mode;
+	nlink_t nlink;
+	uid_t uid;
+	gid_t gid;
+	unsigned long size;
+	struct inode_operations * proc_iops;
+	struct file_operations * proc_fops;
+	get_info_t *get_info;
+	struct module *owner;
+	struct proc_dir_entry *next, *parent, *subdir;
+	void *data;
+	read_proc_t *read_proc;
+	write_proc_t *write_proc;
+	atomic_t count;		/* use count */
+	int deleted;		/* delete flag */
+	void *set;
+};
+
+extern struct proc_dir_entry proc_root;
+extern struct proc_dir_entry *proc_root_fs;
+extern struct proc_dir_entry *proc_net;
+extern struct proc_dir_entry *proc_net_stat;
+extern struct proc_dir_entry *proc_bus;
+extern struct proc_dir_entry *proc_root_driver;
+extern struct proc_dir_entry *proc_root_kcore;
+
+extern void proc_root_init(void);
+extern void proc_misc_init(void);
+
+extern struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,
+						struct proc_dir_entry *parent);
+extern void remove_proc_entry(const char *name, struct proc_dir_entry *parent);
+
+extern struct vfsmount *proc_sysinfo_mnt;
+
+extern int proc_sysinfo_fill_super(struct super_block *,void *,int);
+extern struct inode *proc_sysinfo_get_inode(struct super_block *, unsigned int, struct proc_dir_entry *);
+
+extern int proc_match(int, const char *,struct proc_dir_entry *);
+
+/*
+ * These are generic /proc routines that use the internal
+ * "struct proc_dir_entry" tree to traverse the filesystem.
+ *
+ */
+
+extern struct file_operations proc_kcore_operations;
+extern struct file_operations proc_kmsg_operations;
+extern struct file_operations ppc_htab_operations;
+
+/*
+ * proc_tty.c
+ */
+struct tty_driver;
+extern void proc_tty_init(void);
+extern void proc_tty_register_driver(struct tty_driver *driver);
+extern void proc_tty_unregister_driver(struct tty_driver *driver);
+
+/*
+ * proc_devtree.c
+ */
+#ifdef CONFIG_PROC_DEVICETREE
+struct device_node;
+struct property;
+extern void proc_device_tree_init(void);
+extern void proc_device_tree_add_node(struct device_node *, struct proc_dir_entry *);
+extern void proc_device_tree_add_prop(struct proc_dir_entry *pde, struct property *prop);
+extern void proc_device_tree_remove_prop(struct proc_dir_entry *pde,
+					 struct property *prop);
+extern void proc_device_tree_update_prop(struct proc_dir_entry *pde,
+					 struct property *newprop,
+					 struct property *oldprop);
+#endif /* CONFIG_PROC_DEVICETREE */
+
+extern struct proc_dir_entry *proc_symlink(const char *,
+		struct proc_dir_entry *, const char *);
+extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
+extern struct proc_dir_entry *proc_mkdir_mode(const char *name, mode_t mode,
+			struct proc_dir_entry *parent);
+
+static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, 
+	read_proc_t *read_proc, void * data)
+{
+	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
+	if (res) {
+		res->read_proc=read_proc;
+		res->data=data;
+	}
+	return res;
+}
+ 
+static inline struct proc_dir_entry *create_proc_info_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
+{
+	struct proc_dir_entry *res=create_proc_entry(name,mode,base);
+	if (res) res->get_info=get_info;
+	return res;
+}
+ 
+static inline struct proc_dir_entry *proc_net_create(const char *name,
+	mode_t mode, get_info_t *get_info)
+{
+	return create_proc_info_entry(name,mode,proc_net,get_info);
+}
+
+static inline struct proc_dir_entry *proc_net_fops_create(const char *name,
+	mode_t mode, struct file_operations *fops)
+{
+	struct proc_dir_entry *res = create_proc_entry(name, mode, proc_net);
+	if (res)
+		res->proc_fops = fops;
+	return res;
+}
+
+static inline void proc_net_remove(const char *name)
+{
+	remove_proc_entry(name,proc_net);
+}
+
+#else /* CONFIG_PROC_SYSINFO_FS */
+
+#define proc_root_driver NULL
+#define proc_net NULL
+#define proc_bus NULL
+
+#define proc_net_fops_create(name, mode, fops)  ({ (void)(mode), NULL; })
+#define proc_net_create(name, mode, info)	({ (void)(mode), NULL; })
+static inline void proc_net_remove(const char *name) {}
+
+
+static inline struct proc_dir_entry *create_proc_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *parent) { return NULL; }
+
+#define remove_proc_entry(name, parent) do {} while (0)
+
+static inline struct proc_dir_entry *proc_symlink(const char *name,
+		struct proc_dir_entry *parent,const char *dest) {return NULL;}
+static inline struct proc_dir_entry *proc_mkdir(const char *name,
+	struct proc_dir_entry *parent) {return NULL;}
+
+static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, 
+	read_proc_t *read_proc, void * data) { return NULL; }
+static inline struct proc_dir_entry *create_proc_info_entry(const char *name,
+	mode_t mode, struct proc_dir_entry *base, get_info_t *get_info)
+	{ return NULL; }
+
+struct tty_driver;
+static inline void proc_tty_register_driver(struct tty_driver *driver) {};
+static inline void proc_tty_unregister_driver(struct tty_driver *driver) {};
+
+extern struct proc_dir_entry proc_root;
+
+#endif /* CONFIG_PROC_SYSINFO_FS */
+
+#if !defined(CONFIG_PROC_KCORE)
+static inline void kclist_add(struct kcore_list *new, void *addr, size_t size)
+{
+}
+#else
+extern void kclist_add(struct kcore_list *, void *, size_t);
+#endif
+
+static inline struct proc_dir_entry *PDE(const struct inode *inode)
+{
+	return inode->u.generic_ip;
+}
+
+#endif /* _LINUX_PROC_SYSINFO_FS_H */
diff --git a/include/linux/pspace.h b/include/linux/pspace.h
index 950393a..3be247f 100644
--- a/include/linux/pspace.h
+++ b/include/linux/pspace.h
@@ -24,6 +24,7 @@ struct pspace
 	int last_pid;
 	int min;
 	int max;
+	struct vfsmount *proc_mnt;
 	struct pidmap pidmap[PIDMAP_ENTRIES];
 	char name[1]; /* For use in debugging print statements */
 };
diff --git a/kernel/pid.c b/kernel/pid.c
index 221585d..8732176 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -22,6 +22,7 @@
 
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
@@ -249,6 +250,7 @@ static struct pspace *new_pspace(struct 
 	pspace->nr_threads   = 0;
 	pspace->nr_processes = 0;
 	pspace->last_pid     = 0;
+	pspace->proc_mnt     = NULL;
 	pspace->min          = RESERVED_PIDS;
 	pspace->max          = PID_MAX_DEFAULT;
 	for (i = 0; i < PIDMAP_ENTRIES; i++) {
@@ -303,6 +305,8 @@ void __put_pspace(struct pspace *pspace)
 
 	pspace->child_reaper.pspace->nr_processes--;
 	detach_any_pid(&pspace->child_reaper, PIDTYPE_PID);
+	if (pspace->proc_mnt)
+		mntput(pspace->proc_mnt);
 	parent = pspace->child_reaper.pspace;
 	map    = pspace->pidmap;
 	for (i = 0; i < PIDMAP_ENTRIES; i++) {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4ae834d..f0e148b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -41,7 +41,7 @@
 #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/ext2_fs.h>
-#include <linux/proc_fs.h>
+#include <linux/proc_sysinfo_fs.h>
 #include <linux/kd.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/netfilter_ipv6.h>
@@ -530,7 +530,7 @@ static int superblock_doinit(struct supe
 		}
 	}
 
-	if (strcmp(sb->s_type->name, "proc") == 0)
+	if (strcmp(sb->s_type->name, "proc_sysinfo") == 0)
 		sbsec->proc = 1;
 
 	sbsec->initialized = 1;
@@ -700,7 +700,7 @@ static int selinux_proc_get_sid(struct p
 		path = end;
 		de = de->parent;
 	}
-	rc = security_genfs_sid("proc", path, tclass, sid);
+	rc = security_genfs_sid("proc_sysinfo", path, tclass, sid);
 	free_page((unsigned long)buffer);
 	return rc;
 }
@@ -849,8 +849,8 @@ static int inode_doinit_with_dentry(stru
 		isec->sid = sbsec->sid;
 
 		if (sbsec->proc) {
-			struct proc_inode *proci = PROC_I(inode);
-			if (proci->pde) {
+			struct proc_dir_entry *pde = PDE(inode);
+			if (pde) {
 				isec->sclass = inode_mode_to_security_class(inode->i_mode);
 				rc = selinux_proc_get_sid(proci->pde,
 							  isec->sclass,
-- 
1.1.5.g3480

