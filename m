Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265323AbTFFFlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 01:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265324AbTFFFlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 01:41:16 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:12513 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id S265323AbTFFFlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 01:41:12 -0400
Message-ID: <3EE02C53.1040800@wipro.com>
Date: Fri, 06 Jun 2003 11:23:23 +0530
From: Arvind Kandhare <arvind.kan@wipro.com>
Reply-To: arvind.kan@wipro.com
Organization: Wipro Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: manfreds <manfreds@colorfullife.com>,
       William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, akpm@digeo.com,
       "indou.takao" <indou.takao@jp.fujitsu.com>, Dave Jones <davej@suse.de>,
       Arvind Kandhare <arvind.kan@wipro.com>
Subject: [RFC][PATCH 2.5.70] Static tunable semvmx and semaem 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jun 2003 05:54:04.0550 (UTC) FILETIME=[09595260:01C32BF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please find below patch(RFC) for implementing semvmx and semaem
as static tunable parameters.

These can be modified at boot time using command line interface.

Please comment/suggest.

cheers,
Arvind

diff -Naur linux-2.5.70/include/linux/sysctl.h linux-2.5.70.n/include/linux/sysctl.h
--- linux-2.5.70/include/linux/sysctl.h	Tue May 27 06:30:40 2003
+++ linux-2.5.70.n/include/linux/sysctl.h	Wed Jun  4 16:21:19 2003
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


diff -Naur linux-2.5.70/init/main.c linux-2.5.70.n/init/main.c
--- linux-2.5.70/init/main.c	Tue May 27 06:30:25 2003
+++ linux-2.5.70.n/init/main.c	Wed Jun  4 16:19:46 2003
@@ -67,6 +67,9 @@

  extern char *linux_banner;

+extern unsigned int semvmx;
+extern unsigned int semaem;
+
  static int init(void *);

  extern void init_IRQ(void);
@@ -141,6 +144,29 @@

  __setup("maxcpus=", maxcpus);

+static int __init _semvmx(char *str)
+{
+ 
get_option(&str, &semvmx);
+ 
if(semvmx>65535 || semvmx <=0)
+ 
{
+ 
	semvmx=32767;
+ 
}
+ 
return 1;
+}
+__setup("semvmx=", _semvmx);
+
+static int __init _semaem(char *str)
+{
+ 
get_option(&str, &semaem);
+ 
if(semaem>32767 || semaem <=0)
+ 
{
+ 
	semaem=16384;
+ 
}
+ 
return 1;
+}
+__setup("semaem=", _semaem);
+
+
  static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
  char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };

diff -Naur linux-2.5.70/ipc/sem.c linux-2.5.70.n/ipc/sem.c
--- linux-2.5.70/ipc/sem.c	Tue May 27 06:30:38 2003
+++ linux-2.5.70.n/ipc/sem.c	Wed Jun  4 17:01:46 2003
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
+++ linux-2.5.70.n/kernel/sysctl.c	Wed Jun  4 17:02:52 2003
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
+ 
{KERN_SEMVMX, "semvmx", &semvmx, sizeof (int),
+ 
0444, NULL, &proc_dointvec},
+ 
{KERN_SEMAEM, "semaem", &semaem, sizeof (int),
+ 
0444, NULL, &proc_dointvec},
  #endif
  #ifdef CONFIG_MAGIC_SYSRQ
  	{KERN_SYSRQ, "sysrq", &sysrq_enabled, sizeof (int),


