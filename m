Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268098AbTCFNqC>; Thu, 6 Mar 2003 08:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268090AbTCFNqC>; Thu, 6 Mar 2003 08:46:02 -0500
Received: from comtv.ru ([217.10.32.4]:2187 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S268098AbTCFNqB>;
	Thu, 6 Mar 2003 08:46:01 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.64-mm1
References: <20030305230712.5a0ec2d4.akpm@digeo.com>
	<m365qw3jcx.fsf@lexa.home.net>
	<20030306022140.7c816f32.akpm@digeo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 06 Mar 2003 16:50:01 +0300
In-Reply-To: <20030306022140.7c816f32.akpm@digeo.com>
Message-ID: <m3zno81u5y.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> hm, yes, it does look that way.

 AM> It could be that any task which travels that path ends up running
 AM> under lock_kernel() for the rest of its existence, and nobody
 AM> noticed.

Probably, this patch may help us. It checks current->lock_depth after
each syscall and prints warning.

diff -uNr linux/arch/i386/kernel/entry.S edited/arch/i386/kernel/entry.S
--- linux/arch/i386/kernel/entry.S	Thu Mar  6 14:57:38 2003
+++ edited/arch/i386/kernel/entry.S	Thu Mar  6 16:40:27 2003
@@ -282,6 +282,17 @@
 syscall_call:
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
+
+	movl TI_TASK(%ebp), %edx	# check current->lock_depth
+	movl 20(%edx), %ecx 
+	cmpl $0, %ecx
+	je   syscall_exit   
+	cmpl $-1, %ecx
+	je   syscall_exit
+
+	GET_THREAD_INFO(%ebp) 
+	call warn_invalid_lock_depth
+
 syscall_exit:
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
diff -uNr linux/arch/i386/kernel/l edited/arch/i386/kernel/l
--- linux/arch/i386/kernel/l	Thu Jan  1 03:00:00 1970
+++ edited/arch/i386/kernel/l	Thu Mar  6 13:44:03 2003
@@ -0,0 +1 @@
+make: *** No rule to make target `bzImage'.  Stop.
diff -uNr linux/arch/i386/kernel/process.c edited/arch/i386/kernel/process.c
--- linux/arch/i386/kernel/process.c	Thu Mar  6 14:57:25 2003
+++ edited/arch/i386/kernel/process.c	Thu Mar  6 16:32:17 2003
@@ -714,3 +714,14 @@
 	return 0;
 }
 
+asmlinkage void warn_invalid_lock_depth(void)
+{
+	struct task_struct * tsk = current;
+		        
+	if (!(tsk->flags & 0x10000000)) {
+		printk("WARNING: non-zero(%d) lock_depth, pid %u\n",
+			tsk->lock_depth, tsk->pid);
+		tsk->flags |= 0x10000000;
+	}
+}
+

