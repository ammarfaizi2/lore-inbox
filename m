Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268404AbUHYTmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268404AbUHYTmk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 15:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUHYTmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 15:42:40 -0400
Received: from holomorphy.com ([207.189.100.168]:399 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268404AbUHYTmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 15:42:17 -0400
Date: Wed, 25 Aug 2004 12:42:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [1/4] move sigqueue to signal.h
Message-ID: <20040825194207.GE2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20040819143907.GA4236@redhat.com> <20040819150632.GP11200@holomorphy.com> <20040825180138.GA2793@holomorphy.com> <20040825180342.GB2793@holomorphy.com> <20040825193921.GC2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825193921.GC2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 12:39:21PM -0700, William Lee Irwin III wrote:
> This series removes the dependency of sched.h on signal.h
> Atop the just-posted user bits atop 2.6.8.1-mm4.

Sorry, this is the real 1/4.

Move sigqueue-related bits to include/linux/signal.h

Index: mm4-2.6.8.1/include/linux/sched.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/sched.h	2004-08-25 11:06:48.162899200 -0700
+++ mm4-2.6.8.1/include/linux/sched.h	2004-08-25 11:11:27.993358504 -0700
@@ -730,10 +730,6 @@
 extern int kill_pg(pid_t, int, int);
 extern int kill_sl(pid_t, int, int);
 extern int kill_proc(pid_t, int, int);
-extern struct sigqueue *sigqueue_alloc(void);
-extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(int, struct sigqueue *,  struct task_struct *);
-extern int send_group_sigqueue(int, struct sigqueue *,  struct task_struct *);
 extern int do_sigaction(int, const struct k_sigaction *, struct k_sigaction *);
 extern int do_sigaltstack(const stack_t __user *, stack_t __user *, unsigned long);
 
Index: mm4-2.6.8.1/include/linux/signal.h
===================================================================
--- mm4-2.6.8.1.orig/include/linux/signal.h	2004-08-25 11:06:48.149901176 -0700
+++ mm4-2.6.8.1/include/linux/signal.h	2004-08-25 11:13:45.762414424 -0700
@@ -214,6 +214,10 @@
 extern int group_send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
 extern long do_sigpending(void __user *, unsigned long);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
+struct sigqueue *sigqueue_alloc(void);
+void sigqueue_free(struct sigqueue *);
+int send_sigqueue(int, struct sigqueue *, struct task_struct *);
+int send_group_sigqueue(int, struct sigqueue *, struct task_struct *);
 
 #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER
 struct pt_regs;
Index: mm4-2.6.8.1/kernel/posix-timers.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/posix-timers.c	2004-08-25 11:06:48.175897224 -0700
+++ mm4-2.6.8.1/kernel/posix-timers.c	2004-08-25 11:12:37.178840712 -0700
@@ -45,6 +45,7 @@
 #include <linux/posix-timers.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
+#include <linux/signal.h>
 
 #ifndef div_long_long_rem
 #include <asm/div64.h>
Index: mm4-2.6.8.1/kernel/signal.c
===================================================================
--- mm4-2.6.8.1.orig/kernel/signal.c	2004-08-25 11:06:48.176897072 -0700
+++ mm4-2.6.8.1/kernel/signal.c	2004-08-25 11:12:49.517964880 -0700
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
+#include <linux/signal.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
