Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265145AbTFFItC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 04:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbTFFItC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 04:49:02 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:10950 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S265145AbTFFIs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 04:48:58 -0400
Message-ID: <3EE0586F.9060108@wipro.com>
Date: Fri, 06 Jun 2003 14:31:35 +0530
From: Arvind Kandhare <arvind.kan@wipro.com>
Reply-To: arvind.kan@wipro.com
Organization: Wipro Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: "indou.takao" <indou.takao@jp.fujitsu.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RFC][PATCH 2.5.70] Static tunable semvmx and semaem
References: <3EE02C53.1040800@wipro.com> <20030606065023.GB8978@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2003 09:02:17.0033 (UTC) FILETIME=[54317B90:01C32C0A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> 
> Your MUA ate the whitespace in the patch.


Please user --ignore-whitespace for patching. I use Mozilla for email activities and
can not change to pine etc. Sorry for the inconvenience caused.

> 
> Also, I'm not convinced it's useful to pollute init/main.c here.
> Something under /proc/sys/kernel/ with the other shm bits should do.
> 

As we have discussed earlier, making it dynamic can cause some race conditions in the system
(Please refer thread "Changing SEMVMX to a tunable parameter" on 28 May 2003).

> I might look deeper into whether the audit for signedness and other
> size issues is complete once those are dealt with.
> 

I am not very clear about this. Is there a standard procedure for the audit?
I reviewed the code and did not find any issues related to signedness / boundary conditions.
Can you please explain more about it ??

Thanks and regards,
Arvind ..
P.S. Please find the patch with the implementation as dynamic tunable parameter,
but I've some reservations about it.Making it dynamic will be ideal solution but it may
lead to unavoidable races.


diff -Naur linux-2.5.70/include/linux/sysctl.h linux-2.5.70.n/include/linux/sysctl.h
--- linux-2.5.70/include/linux/sysctl.h	Tue May 27 06:30:40 2003
+++ linux-2.5.70.n/include/linux/sysctl.h	Fri Jun  6 13:42:54 2003
@@ -130,6 +130,8 @@
  	KERN_PIDMAX=55, 
	/* int: PID # limit */
    	KERN_CORE_PATTERN=56,	/* string: pattern for core-file names */
  	KERN_PANIC_ON_OOPS=57,  /* int: whether we will panic on an oops */
+ 
KERN_SEMVMX=58,  	/* int: maximum limit on semval */
+ 
KERN_SEMAEM=59, 
	/* int: maximun limit on semaem */
  };


diff -Naur linux-2.5.70/ipc/sem.c linux-2.5.70.n/ipc/sem.c
--- linux-2.5.70/ipc/sem.c	Tue May 27 06:30:38 2003
+++ linux-2.5.70.n/ipc/sem.c	Fri Jun  6 13:42:54 2003
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
- 
		if (undo < (-SEMAEM - 1) || undo > SEMAEM)
+ 
		if (undo < (-semaem - 1) || undo > semaem)
  	 
	{
  	 
		/* Don't undo the undo */
  	 
		sop->sem_flg &= ~SEM_UNDO;
@@ -290,7 +293,7 @@
  		}
  		if (curr->semval < 0)
  	 
	goto would_block;
- 
	if (curr->semval > SEMVMX)
+ 
	if (curr->semval > semvmx)
  	 
	goto out_of_range;
  	}

@@ -482,7 +485,7 @@
  		seminfo.semmns = sc_semmns;
  		seminfo.semmsl = sc_semmsl;
  		seminfo.semopm = sc_semopm;
- 
	seminfo.semvmx = SEMVMX;
+ 
	seminfo.semvmx = semvmx;
  		seminfo.semmnu = SEMMNU;
  		seminfo.semmap = SEMMAP;
  		seminfo.semume = SEMUME;
@@ -492,7 +495,7 @@
  	 
	seminfo.semaem = used_sems;
  		} else {
  	 
	seminfo.semusz = SEMUSZ;
- 
		seminfo.semaem = SEMAEM;
+ 
		seminfo.semaem = semaem;
  		}
  		max_id = sem_ids.max_id;
  		up(&sem_ids.sem);
@@ -613,7 +616,7 @@
  		}

  		for (i = 0; i < nsems; i++) {
- 
		if (sem_io[i] > SEMVMX) {
+ 
		if (sem_io[i] > semvmx) {
  	 
		err = -ERANGE;
  	 
		goto out_free;
  	 
	}
@@ -672,7 +675,7 @@
  		int val = arg.val;
  		struct sem_undo *un;
  		err = -ERANGE;
- 
	if (val > SEMVMX || val < 0)
+ 
	if (val > semvmx || val < 0)
  	 
	goto out_unlock;

  		for (un = sma->undo; un; un = un->id_next)
diff -Naur linux-2.5.70/kernel/sysctl.c linux-2.5.70.n/kernel/sysctl.c
--- linux-2.5.70/kernel/sysctl.c	Tue May 27 06:30:23 2003
+++ linux-2.5.70.n/kernel/sysctl.c	Fri Jun  6 13:47:46 2003
@@ -79,6 +79,8 @@
  extern int msg_ctlmnb;
  extern int msg_ctlmni;
  extern int sem_ctls[];
+extern unsigned int  semvmx;
+extern int semaem;
  #endif

  #ifdef __sparc__
@@ -146,6 +148,14 @@
  static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
  #endif

+/* Constants for minimum and maximum testing in vm_table.
+ *    We use these as one-element integer vectors. */
+static int zero = 0;
+static int one = 1;
+static int one_hundred = 100;
+static int signed_short_max=32767;
+
+
  /* The default sysctl tables: */

  static ctl_table root_table[] = {
@@ -237,6 +247,10 @@
  	 0644, NULL, &proc_dointvec},
  	{KERN_SEM, "sem", &sem_ctls, 4*sizeof (int),
  	 0644, NULL, &proc_dointvec},
+ 
{KERN_SEMVMX, "semvmx", &semvmx, sizeof (int),
+ 
0644, NULL, &proc_dointvec_minmax,NULL,NULL,&zero,NULL},
+ 
{KERN_SEMAEM, "semaem", &semaem, sizeof (int),
+ 
0644, NULL, &proc_dointvec,NULL,NULL,&zero,&signed_short_max},
  #endif
  #ifdef CONFIG_MAGIC_SYSRQ
  	{KERN_SYSRQ, "sysrq", &sysrq_enabled, sizeof (int),
@@ -268,12 +282,6 @@
  	{0}
  };

-/* Constants for minimum and maximum testing in vm_table.
-   We use these as one-element integer vectors. */
-static int zero = 0;
-static int one = 1;
-static int one_hundred = 100;
-

  static ctl_table vm_table[] = {
  	{VM_OVERCOMMIT_MEMORY, "overcommit_memory", &sysctl_overcommit_memory,


