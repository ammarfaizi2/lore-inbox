Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131032AbQKGQQV>; Tue, 7 Nov 2000 11:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131058AbQKGQQL>; Tue, 7 Nov 2000 11:16:11 -0500
Received: from hvmta01-ext.us.psimail.psi.net ([38.202.36.29]:53952 "EHLO
	hvmta01-stg.us.psimail.psi.net") by vger.kernel.org with ESMTP
	id <S131032AbQKGQQA>; Tue, 7 Nov 2000 11:16:00 -0500
From: "Chris Swiedler" <chris.swiedler@sevista.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
        "Rik van Riel" <riel@conectiva.com.br>
Subject: [PATCH] protect processes from OOM killer
Date: Tue, 7 Nov 2000 11:19:37 -0500
Message-ID: <NDBBIAJKLMMHOGKNMGFNMEADCPAA.chris.swiedler@sevista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a small patch to allow a user to protect certain PIDs from death-
by-OOM-killer. It uses the proc entry '/proc/sys/vm/oom_protect'; echo the
PIDs to be protected:

echo 1 516 > /proc/sys/vm/oom_protect

The idea is that sysadmins can mark some daemon processes as off-limits for
the OOM killer. Stuff like syslogd, init, etc. Incidentally, this answers
Andrea's concern about the init process getting killed. In fact, it might
be a good idea to default the list of protected PIDs to be { 1 }.


Things I'd like to add:

- ability to append PIDs. Using the 'echo >>' syntax would be nice, but
/proc
files don't seem to support appending. (is this true?)

- symbolic process names as well as PIDs, maybe process groups too?

- perhaps a more complex interface, where instead of just marking a PID as
absolutely protected, you could specify a 'weight' which factored into the
OOM algorithm. Something like "nice":

-20 : unkillable
-19 to -1: try not to kill
1 to 19: try to kill these first

echo netscape:10 > /proc/sys/vm/oom_protect

...would suggest that "netscape" is a process which is a good candidate
for OOM killing.

I don't think that we should make the OOM heuristic any more complex.
However,
letting the user make suggestions about what should and should not be killed
is a Good Thing.

This is my very first patch, so please be considerate.

Against 2.4.0-test10. Comments and suggestions appreciated!

chris

--- official/linux-2.4.0-test10/mm/oom_kill.c	Mon Nov  6 23:40:52 2000
+++ work/linux-2.4.0-test10/mm/oom_kill.c	Mon Nov  6 23:37:47 2000
@@ -20,9 +20,32 @@
 #include <linux/swap.h>
 #include <linux/swapctl.h>
 #include <linux/timex.h>
+#include <linux/ctype.h>
+
+#define MAX_OOM_PROTECTS 256
+
+int sysctl_oom_protects[MAX_OOM_PROTECTS];

 /* #define DEBUG */

+int is_oom_protected(int pid)
+{
+	int i;
+	for (i = 0; i < MAX_OOM_PROTECTS; i++) {
+		int ppid = sysctl_oom_protects[i];
+
+		#ifdef DEBUG
+		printk("Protected pid: %d\n",ppid);
+		#endif
+
+		if (ppid == pid)
+			return 1;
+		if (ppid == 0)
+			return 0;
+	}
+	return 0;
+}
+
 /**
  * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
  * @x: integer of which to calculate the sqrt
@@ -124,6 +147,19 @@
 	read_lock(&tasklist_lock);
 	for_each_task(p)
 	{
+		#ifdef DEBUG
+		printk("Testing pid %d\n",p->pid);
+		#endif
+
+		if (is_oom_protected(p->pid))
+

+			#ifdef DEBUG
+			printk("Pid %d is protected\n",p->pid);
+			#endif
+
+			continue;
+		}
+
 		if (p->pid)
 			points = badness(p);
 		if (points > maxpoints) {
--- official/linux-2.4.0-test10/kernel/sysctl.c	Mon Nov  6 23:40:52 2000
+++ work/linux-2.4.0-test10/kernel/sysctl.c	Mon Nov  6 23:30:08 2000
@@ -85,6 +85,8 @@

 extern int pgt_cache_water[];

+extern int sysctl_oom_protects [];
+
 static int parse_table(int *, int, void *, size_t *, void *, size_t,
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
@@ -241,6 +243,10 @@
 	 &bdflush_min, &bdflush_max},
 	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,
 	 sizeof(sysctl_overcommit_memory), 0644, NULL, &proc_dointvec},
+
+	{VM_OVERCOMMIT_MEMORY, "oom_protect", &sysctl_oom_protects,
+	 256, 0644, NULL, &proc_dointvec},
+
 	{VM_BUFFERMEM, "buffermem",
 	 &buffer_mem, sizeof(buffer_mem_t), 0644, NULL, &proc_dointvec},
 	{VM_PAGECACHE, "pagecache",

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
