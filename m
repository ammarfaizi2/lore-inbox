Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTEUOqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 10:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTEUOqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 10:46:34 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:40591
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S262150AbTEUOqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 10:46:08 -0400
Date: Wed, 21 May 2003 10:58:57 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Russell King <rmk@arm.linux.org.uk>
cc: Vladimir Serov <vserov@infratel.com>, <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
In-Reply-To: <20030521104355.C17709@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305211055400.1785-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 May 2003, Russell King wrote:

> On Wed, May 21, 2003 at 10:29:23AM +0100, Russell King wrote:
> > On Mon, May 19, 2003 at 05:20:27PM +0400, Vladimir Serov wrote:
> > > My current kernel is 2.4.21-pre6 based with patches from 2.4.19-rmk7 
> > > applied (well partially, except ide and pci cause i don't have them, 
> > > board is mostly brutus). I'm using HARD mounted nfs
> > > volume now !!! The tail of dmesg is following.
> > 
> > Looking back on stuff which happened a long time ago, there's a
> > possibility that there's an ordering issue with set_current_state.
> > 
> > Please note that this is affects _all_ 2.4 architectures.
> > 
> > I think this was discussed about 6 months ago, so I'm surprised this
> > hasn't made it into the 2.4.2x kernel (or no one else has seen the
> > problem.)
> 
> Yes, it was first discovered 7 months ago, but it seems Marcelo didn't
> merge the fix:
> 
> > Date: Fri, 18 Oct 2002 23:00:58 -0400 (EDT)
> > From: Nicolas Pitre <nico@cam.org>
> > To: Marcelo Tosatti <marcelo@conectiva.com.br>
> > Subject: [PATCH] set_task_state() UP memory barriers
> 
> Nicolas included a more complete fix which updates all 2.4 architectures.
> Nico - could you re-send your fix please?

Here it is, again.

---------- Forwarded message ----------
>From nico@cam.org Wed May 21 10:55:10 2003
Date: Fri, 18 Oct 2002 23:00:58 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] set_task_state() UP memory barriers

This fixes the UP set_task_state and set_current_state to ensure that we
don't re-order loads around the store for setting task->state.

The patch below has just been merged into 2.5 by Linus but 2.4 needs this 
as well, especially if gcc-3.2.x is used to compile the kernel.


diff -ur linux-2.4.20-pre11/include/asm-arm/system.h linux/include/asm-arm/system.h
--- linux-2.4.20-pre11/include/asm-arm/system.h	Mon Nov 27 20:07:59 2000
+++ linux/include/asm-arm/system.h	Fri Oct 18 22:13:49 2002
@@ -39,6 +39,8 @@
 #define mb() __asm__ __volatile__ ("" : : : "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define set_mb(var, value)  do { var = value; mb(); } while (0)
+#define set_wmb(var, value) do { var = value; wmb(); } while (0)
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
 #define prepare_to_switch()    do { } while(0)
diff -ur linux-2.4.20-pre11/include/asm-cris/system.h linux/include/asm-cris/system.h
--- linux-2.4.20-pre11/include/asm-cris/system.h	Fri Aug  2 20:39:45 2002
+++ linux/include/asm-cris/system.h	Fri Oct 18 22:13:49 2002
@@ -150,6 +150,8 @@
 #define mb() __asm__ __volatile__ ("" : : : "memory")
 #define rmb() mb()
 #define wmb() mb()
+#define set_mb(var, value)  do { var = value; mb(); } while (0)
+#define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 #ifdef CONFIG_SMP
 #define smp_mb()        mb()
diff -ur linux-2.4.20-pre11/include/asm-i386/system.h linux/include/asm-i386/system.h
--- linux-2.4.20-pre11/include/asm-i386/system.h	Fri Oct 18 22:11:16 2002
+++ linux/include/asm-i386/system.h	Fri Oct 18 22:13:49 2002
@@ -305,13 +305,14 @@
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
 #define smp_wmb()	wmb()
+#define set_mb(var, value) do { xchg(&var, value); } while (0)
 #else
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
+#define set_mb(var, value) do { var = value; barrier(); } while (0)
 #endif
 
-#define set_mb(var, value) do { xchg(&var, value); } while (0)
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 /* interrupt control.. */
Only in linux/include/asm-i386: system.h.orig
diff -ur linux-2.4.20-pre11/include/asm-m68k/system.h linux/include/asm-m68k/system.h
--- linux-2.4.20-pre11/include/asm-m68k/system.h	Fri Aug  2 20:39:45 2002
+++ linux/include/asm-m68k/system.h	Fri Oct 18 22:24:57 2002
@@ -82,7 +82,7 @@
 #define mb()		barrier()
 #define rmb()		barrier()
 #define wmb()		barrier()
-#define set_mb(var, value)    do { xchg(&var, value); } while (0)
+#define set_mb(var, value)     do { var = value; mb(); } while (0)
 #define set_wmb(var, value)    do { var = value; wmb(); } while (0)
 
 #define smp_mb()	barrier()
Only in linux/include/asm-parisc: system.h.orig
diff -ur linux-2.4.20-pre11/include/asm-sh/system.h linux/include/asm-sh/system.h
--- linux-2.4.20-pre11/include/asm-sh/system.h	Sat Sep  8 15:29:09 2001
+++ linux/include/asm-sh/system.h	Fri Oct 18 22:13:49 2002
@@ -100,7 +100,7 @@
 #define smp_wmb()	barrier()
 #endif
 
-#define set_mb(var, value) do { xchg(&var, value); } while (0)
+#define set_mb(var, value)  do { var = value; mb(); } while (0)
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 /* Interrupt Control */
Only in linux/include/asm-sh: system.h.orig
diff -ur linux-2.4.20-pre11/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.4.20-pre11/include/linux/sched.h	Fri Oct 18 22:11:19 2002
+++ linux/include/linux/sched.h	Fri Oct 18 22:14:04 2002
@@ -94,23 +94,13 @@
 
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state = (state_value); } while (0)
-#ifdef CONFIG_SMP
 #define set_task_state(tsk, state_value)		\
 	set_mb((tsk)->state, (state_value))
-#else
-#define set_task_state(tsk, state_value)		\
-	__set_task_state((tsk), (state_value))
-#endif
 
 #define __set_current_state(state_value)			\
 	do { current->state = (state_value); } while (0)
-#ifdef CONFIG_SMP
 #define set_current_state(state_value)		\
 	set_mb(current->state, (state_value))
-#else
-#define set_current_state(state_value)		\
-	__set_current_state(state_value)
-#endif
 
 /*
  * Scheduling policies


