Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTFFOug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 10:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbTFFOug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 10:50:36 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:18347 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S261807AbTFFOu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 10:50:28 -0400
Subject: Re: [RFC][PATCH 2.5.70] Static tunable semvmx and semaem
From: Arvind Kandhare <arvind.kan@wipro.com>
To: wli@holomorphy.com, linux-kernel@vger.kernel.org
Cc: indou.takao@jp.fujitsu.com, davej@suse.de, manfred@colorfullife.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 06 Jun 2003 20:32:53 +0530
Message-Id: <1054911774.1917.21.camel@m2-arvind>
Mime-Version: 1.0
X-OriginalArrivalTime: 06 Jun 2003 15:03:33.0605 (UTC) FILETIME=[CC6FE150:01C32C3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:


> I think the __setup()'s should be moved to ipc/sem.c;


It is always better if all the initializations related to
IPC V semaphores are in ipc/sem.c file. Thanks for the suggestion.
Below is the updated patch with __setup()calls in ipc/sem.c.

Thanks,
Arvind
P.S. I've changed my mail client to evaluation and cross checked whether
the patches works. Please get back to me in case there are any issues
while patching.

diff -Naur linux-2.5.70/include/linux/sysctl.h linux-2.5.70.n/include/linux/sysctl.h
--- linux-2.5.70/include/linux/sysctl.h	Tue May 27 06:30:40 2003
+++ linux-2.5.70.n/include/linux/sysctl.h	Fri Jun  6 19:33:19 2003
@@ -130,6 +130,8 @@
 	KERN_PIDMAX=55,		/* int: PID # limit */
   	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
 	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
+	KERN_SEMVMX=58,  	/* int: maximum limit on semval */
+	KERN_SEMAEM=59,		/* int: maximun limit on semaem */
 };
 

diff -Naur linux-2.5.70/ipc/sem.c linux-2.5.70.n/ipc/sem.c
--- linux-2.5.70/ipc/sem.c	Tue May 27 06:30:38 2003
+++ linux-2.5.70.n/ipc/sem.c	Fri Jun  6 19:35:19 2003
@@ -102,6 +102,9 @@
 #define sc_semopm	(sem_ctls[2])
 #define sc_semmni	(sem_ctls[3])
 
+unsigned int semvmx=32767;
+int semaem=16384;
+
 static int used_sems;
 
 void __init sem_init (void)
@@ -280,7 +283,7 @@
 			/*
 	 		 *	Exceeding the undo range is an error.
 			 */
-			if (undo < (-SEMAEM - 1) || undo > SEMAEM)
+			if (undo < (-semaem - 1) || undo > semaem)
 			{
 				/* Don't undo the undo */
 				sop->sem_flg &= ~SEM_UNDO;
@@ -290,7 +293,7 @@
 		}
 		if (curr->semval < 0)
 			goto would_block;
-		if (curr->semval > SEMVMX)
+		if (curr->semval > semvmx)
 			goto out_of_range;
 	}
 
@@ -482,7 +485,7 @@
 		seminfo.semmns = sc_semmns;
 		seminfo.semmsl = sc_semmsl;
 		seminfo.semopm = sc_semopm;
-		seminfo.semvmx = SEMVMX;
+		seminfo.semvmx = semvmx;
 		seminfo.semmnu = SEMMNU;
 		seminfo.semmap = SEMMAP;
 		seminfo.semume = SEMUME;
@@ -492,7 +495,7 @@
 			seminfo.semaem = used_sems;
 		} else {
 			seminfo.semusz = SEMUSZ;
-			seminfo.semaem = SEMAEM;
+			seminfo.semaem = semaem;
 		}
 		max_id = sem_ids.max_id;
 		up(&sem_ids.sem);
@@ -613,7 +616,7 @@
 		}
 
 		for (i = 0; i < nsems; i++) {
-			if (sem_io[i] > SEMVMX) {
+			if (sem_io[i] > semvmx) {
 				err = -ERANGE;
 				goto out_free;
 			}
@@ -672,7 +675,7 @@
 		int val = arg.val;
 		struct sem_undo *un;
 		err = -ERANGE;
-		if (val > SEMVMX || val < 0)
+		if (val > semvmx || val < 0)
 			goto out_unlock;
 
 		for (un = sma->undo; un; un = un->id_next)
@@ -1295,6 +1298,29 @@
 	unlock_kernel();
 }
 
+static int __init _semvmx(char *str)
+{
+	get_option(&str, &semvmx);
+	if(semvmx>65535 || semvmx <=0)
+	{
+		semvmx=32767;
+	}
+	return 1;
+}
+__setup("semvmx=", _semvmx);
+
+static int __init _semaem(char *str)
+{
+	get_option(&str, &semaem);
+	if(semaem>32767 || semaem <=0)
+	{
+		semaem=16384;
+	}
+	return 1;
+}
+__setup("semaem=", _semaem);
+
+
 #ifdef CONFIG_PROC_FS
 static int sysvipc_sem_read_proc(char *buffer, char **start, off_t offset, int length, int *eof, void *data)
 {
diff -Naur linux-2.5.70/kernel/sysctl.c linux-2.5.70.n/kernel/sysctl.c
--- linux-2.5.70/kernel/sysctl.c	Tue May 27 06:30:23 2003
+++ linux-2.5.70.n/kernel/sysctl.c	Fri Jun  6 19:49:30 2003
@@ -79,6 +79,8 @@
 extern int msg_ctlmnb;
 extern int msg_ctlmni;
 extern int sem_ctls[];
+extern unsigned int  semvmx;
+extern int semaem;
 #endif
 
 #ifdef __sparc__
@@ -237,6 +239,10 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_SEM, "sem", &sem_ctls, 4*sizeof (int),
 	 0644, NULL, &proc_dointvec},
+	{KERN_SEMVMX, "semvmx", &semvmx, sizeof (int),
+	0444, NULL, &proc_dointvec},
+	{KERN_SEMAEM, "semaem", &semaem, sizeof (int),
+	0444, NULL, &proc_dointvec},
 #endif
 #ifdef CONFIG_MAGIC_SYSRQ
 	{KERN_SYSRQ, "sysrq", &sysrq_enabled, sizeof (int),


