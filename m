Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbVC3SkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbVC3SkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVC3SkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:40:11 -0500
Received: from pin.if.uz.zgora.pl ([212.109.128.251]:11502 "EHLO
	pin.if.uz.zgora.pl") by vger.kernel.org with ESMTP id S262399AbVC3SjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:39:19 -0500
Message-ID: <424AE48C.8000805@pin.if.uz.zgora.pl>
Date: Wed, 30 Mar 2005 19:40:28 +0200
From: =?ISO-8859-2?Q?Jacek_=A3uczak?= <difrost@pin.if.uz.zgora.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: forkbombing Linux distributions
Content-Type: multipart/mixed;
 boundary="------------040408050305080008070506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040408050305080008070506
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi

I made some tests and almost all Linux distros brings down while freebsd 
survive!Forkbombing is a big problem but i don't think that something like

max_threads = mempages / (16 * THREAD_SIZE / PAGE_SIZE);

is good solution!!!
How about add max_user_threads to the kernel? It could be tunable via 
proc filesystem. Limit is set only for users.
I made a fast:) patch - see below - and test it on 2.6.11, 
2.6.11ac4,2.6.12rc1...works great!!!New forks are stoped in 
copy_process() before dup_task_struct() and EAGAIN is returned. System 
works without any problems and root can killall -9 forkbomb.

Regards,
	Jacek Luczak

--------------040408050305080008070506
Content-Type: text/plain;
 name="user_threads_limit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="user_threads_limit.patch"

--- linux-2.6.12-rc1/kernel/fork.c	2005-03-29 00:53:37.000000000 +0200
+++ linux/kernel/fork.c	2005-03-29 00:54:19.000000000 +0200
@@ -57,6 +57,8 @@
 
 int max_threads;		/* tunable limit on nr_threads */
 
+int max_user_threads;		/* tunable limit on nr_threads per user */
+
 DEFINE_PER_CPU(unsigned long, process_counts) = 0;
 
  __cacheline_aligned DEFINE_RWLOCK(tasklist_lock);  /* outer */
@@ -146,6 +148,21 @@
 	if(max_threads < 20)
 		max_threads = 20;
 
+	/*
+	 * The default maximum number of threads per user.
+	 * 
+	 * FIXME: this value is based on my experiments and is 
+	 * rather good on desktop system; it should be fixed to
+	 * the more universal value.
+	 */
+	max_user_threads = 300;
+	
+	/*
+	 * default value is too high - set to max_threads 
+	 */
+	if (max_threads < max_user_threads)
+		max_user_threads = max_threads;
+	
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.signal->rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
@@ -179,6 +196,16 @@
 	return tsk;
 }
 
+/*
+ * This is used to get number of user processes
+ * from current running task.
+ */
+static inline int get_user_processes(void)
+{
+	return atomic_read(&current->user->processes);
+}
+#define user_nr_processes get_user_processes()
+
 #ifdef CONFIG_MMU
 static inline int dup_mmap(struct mm_struct * mm, struct mm_struct * oldmm)
 {
@@ -869,6 +896,13 @@
 		goto fork_out;
 
 	retval = -ENOMEM;
+	
+	/*
+	 * Stop creation of new user process if limit is reached.
+	 */
+	if ( (current->user != &root_user) && (user_nr_processes >= max_user_threads) )
+		goto max_user_fork;
+	
 	p = dup_task_struct(current);
 	if (!p)
 		goto fork_out;
@@ -1109,6 +1143,9 @@
 		return ERR_PTR(retval);
 	return p;
 
+max_user_fork:
+	retval = -EAGAIN;
+	return ERR_PTR(retval);
 bad_fork_cleanup_namespace:
 	exit_namespace(p);
 bad_fork_cleanup_keys:
--- linux-2.6.12-rc1/kernel/sysctl.c	2005-03-29 00:53:38.000000000 +0200
+++ linux/kernel/sysctl.c	2005-03-29 00:54:19.000000000 +0200
@@ -56,6 +56,7 @@
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
 extern int max_threads;
+extern int max_user_threads;
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern char core_pattern[];
@@ -642,6 +643,14 @@
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= KERN_MAX_USER_THREADS,
+		.procname	= "user_threads_max",
+		.data		= &max_user_threads,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 
 	{ .ctl_name = 0 }
 };
--- linux-2.6.12-rc1/include/linux/sysctl.h	2005-03-29 00:54:06.000000000 +0200
+++ linux/include/linux/sysctl.h	2005-03-29 00:54:36.000000000 +0200
@@ -136,6 +136,7 @@
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
+	KERN_MAX_USER_THREADS=69,	/* int: Maximum nr of threads per user in the system */
 };
 
 

--------------040408050305080008070506
Content-Type: text/x-vcard; charset=utf-8;
 name="difrost.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="difrost.vcf"

begin:vcard
fn;quoted-printable:Jacek =C5=81uczak
n;quoted-printable:=C5=81uczak;Jacek
adr:;;Prof. Z. Szafrana 4a;Zielona Gora;;65-516;Poland
email;internet:difrost@pin.if.uz.zgora.pl
title:Linux Registered User # 337142
x-mozilla-html:FALSE
url:http://pin.if.uz.zgora.pl/~difrost
version:2.1
end:vcard


--------------040408050305080008070506--
