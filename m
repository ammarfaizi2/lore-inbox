Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262178AbTC1ELo>; Thu, 27 Mar 2003 23:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262187AbTC1ELn>; Thu, 27 Mar 2003 23:11:43 -0500
Received: from [12.47.58.223] ([12.47.58.223]:26904 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id <S262178AbTC1ELm>; Thu, 27 Mar 2003 23:11:42 -0500
Date: Thu, 27 Mar 2003 20:23:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: task_struct slab cache use after free in 2.5.66
Message-Id: <20030327202348.75021c5d.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.50.0303272211180.2884-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303272211180.2884-100000@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Mar 2003 04:22:50.0212 (UTC) FILETIME=[B1792240:01C2F4E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> I'm having a few stability problems with 2.5.66 under test loads. I 
> can't quite parse the slab debugging stuff. Is this actually useful to 
> anyone?
> 
> Slab corruption: start=c1f23380, expend=c1f2399f, problemat=c1f23388
> Data: ********6A 
> ******************************************************************************************************* 
> Next: ********************************
> slab error in check_poison_obj(): cache `task_struct': object was modified after freeing
> Call Trace:
>  [<c0142953>] check_poison_obj+0x123/0x170
>  [<c0144337>] kmem_cache_alloc+0x117/0x160
>  [<c011fdde>] dup_task_struct+0x9e/0xc0
>  [<c011fdde>] dup_task_struct+0x9e/0xc0
>  [<c0120b82>] copy_process+0x82/0xe30
>  [<c0126d3b>] do_softirq+0xbb/0xc0
>  [<c012196f>] do_fork+0x3f/0x170
>  [<c01077b7>] sys_fork+0x17/0x30
>  [<c0109497>] syscall_call+0x7/0xb
> 

That's the second report of this.  Someone did a put_task_struct against a
freed task_struct.  I'll cook up a debug patch to trap it.  Something like
this:


diff -puN include/linux/sched.h~put_task_struct-debug include/linux/sched.h
--- 25/include/linux/sched.h~put_task_struct-debug	2003-03-27 20:21:16.000000000 -0800
+++ 25-akpm/include/linux/sched.h	2003-03-27 20:22:49.000000000 -0800
@@ -443,12 +443,17 @@ struct task_struct {
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+	long debug;
 };
 
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
-#define put_task_struct(tsk) \
-do { if (atomic_dec_and_test(&(tsk)->usage)) __put_task_struct(tsk); } while(0)
+#define put_task_struct(tsk)					\
+	do {							\
+		BUG_ON((tsk)->debug == 0x6b6b6b6b);		\
+		if (atomic_dec_and_test(&(tsk)->usage))		\
+			__put_task_struct(tsk);			\
+	} while (0)
 
 /*
  * Per process flags

_

