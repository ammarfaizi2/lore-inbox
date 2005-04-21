Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVDURrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVDURrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 13:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVDURqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 13:46:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44524 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261586AbVDURpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 13:45:03 -0400
Date: Thu, 21 Apr 2005 18:45:07 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jan Dittmer <jdittmer@ppp0.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050421174507.GA13052@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <42676B76.4010903@ppp0.net> <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be> <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421161106.GY13052@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	thread_info part 2:

encapsulates the rest of arch-dependent operations with thread_info access.
Two new helpers - setup_thread_info() and end_of_stack().  For normal
case the former consists of copying thread_info of parent to new thread_info
and the latter returns pointer immediately past the end of thread_info.

Again, normal platforms are obviously safe.  Note that end_of_stack() is
need since unlike the default case, m68k has only a single pointer in
stack - not the entire thread_info.  So DEBUG_STACK_USAGE needs to be
a bit different there.

diff -urN RC12-rc3-task_thread_info/include/linux/sched.h RC12-rc3-other_helpers/include/linux/sched.h
--- RC12-rc3-task_thread_info/include/linux/sched.h	Wed Apr 20 22:51:13 2005
+++ RC12-rc3-other_helpers/include/linux/sched.h	Wed Apr 20 22:51:15 2005
@@ -1104,6 +1104,16 @@
 
 #define task_thread_info(task) (task)->thread_info
 
+static inline void setup_thread_info(struct task_struct *p, struct thread_info *ti)
+{
+	*ti = *p->thread_info;
+}
+
+static inline unsigned long *end_of_stack(struct task_struct *p)
+{
+	return (unsigned long *)(p->thread_info + 1);
+}
+
 /* set thread flags in other task's structures
  * - see asm/thread_info.h for TIF_xxxx flags available
  */
diff -urN RC12-rc3-task_thread_info/kernel/fork.c RC12-rc3-other_helpers/kernel/fork.c
--- RC12-rc3-task_thread_info/kernel/fork.c	Wed Apr 20 22:51:13 2005
+++ RC12-rc3-other_helpers/kernel/fork.c	Wed Apr 20 22:51:15 2005
@@ -169,8 +169,8 @@
 		return NULL;
 	}
 
-	*ti = *orig->thread_info;
 	*tsk = *orig;
+	setup_thread_info(tsk, ti);
 	tsk->thread_info = ti;
 	ti->task = tsk;
 
diff -urN RC12-rc3-task_thread_info/kernel/sched.c RC12-rc3-other_helpers/kernel/sched.c
--- RC12-rc3-task_thread_info/kernel/sched.c	Wed Apr 20 22:51:13 2005
+++ RC12-rc3-other_helpers/kernel/sched.c	Wed Apr 20 22:51:15 2005
@@ -3945,10 +3945,10 @@
 #endif
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	{
-		unsigned long * n = (unsigned long *) (p->thread_info+1);
+		unsigned long * n = end_of_stack(p);
 		while (!*n)
 			n++;
-		free = (unsigned long) n - (unsigned long)(p->thread_info+1);
+		free = (unsigned long) n - (unsigned long) end_of_stack(p);
 	}
 #endif
 	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
