Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVDWV21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVDWV21 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 17:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVDWV20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 17:28:26 -0400
Received: from mail.dif.dk ([193.138.115.101]:22160 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261959AbVDWV0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 17:26:53 -0400
Date: Sat, 23 Apr 2005 23:30:03 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Robert Love <rml@novell.com>, kpreempt-tech@lists.sourceforge.net
Subject: preempt-count oddities
Message-ID: <Pine.LNX.4.62.0504232254050.2474@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While looking through the tree and checking out possible signedness issues 
pointed out to me by gcc -W I came across this one : 
  kernel/timer.c:464: warning: comparison between signed and unsigned
The issue there is this little bit of code :
  [...]
  462        u32 preempt_count = preempt_count();
  463        fn(data);
  464        if (preempt_count != preempt_count()) {
  [...]
gcc is complaining about that since preempt_count in struct thread_info 
(which is what preempt_count() returns) is a signed integer. Initially I 
thought "that's a bit sloppy, I'll just make the local variable a s32 and 
that should be that", but then I looked a little closer at struct 
thread_info for the different archs, and found that the type used differs 
between archs and it's not even a signed type on all (s390 being the 
unsigned exception). So all of a sudden fixing up this little warning was 
not so simple after all.
The different types used for struct thread_info.preempt_count are 
__s32, int and unsigned int.

Why are different types used for struct thread_info.preempt_count? Would 
it not make sense to make it a __s32 or plain int on all archs? I would 
think that consistency here would be a good thing.
And why on earth is it an unsigned int on s390? It seems to me that that 
makes it impossible to catch bugs where preempt_count is decremented below 
zero.

Any reason not to apply a patch like this one? 
my choice of 'int' over '__s32' was pretty arbitrary - as far as I know we 
don't support any archs where 'int' is less than 32bits, do we? So I 
figured that using a plain int type should give us at least 32 bits 
everywhere as well as using the given platforms fastest type. If any of 
the archs have <32bit int types, then I guess __s32 would be a better 
choice.

Signed-of-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm3-orig/include/asm-arm/thread_info.h	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-arm/thread_info.h	2005-04-23 23:16:04.000000000 +0200
@@ -45,7 +45,7 @@
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
-	__s32			preempt_count;	/* 0 => preemptable, <0 => bug */
+	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 	mm_segment_t		addr_limit;	/* address limit */
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
--- linux-2.6.12-rc2-mm3-orig/include/asm-arm26/thread_info.h	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-arm26/thread_info.h	2005-04-23 23:16:22.000000000 +0200
@@ -44,7 +44,7 @@
  */
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
-	__s32			preempt_count;	/* 0 => preemptable, <0 => bug */
+	int			preempt_count;	/* 0 => preemptable, <0 => bug */
 	mm_segment_t		addr_limit;	/* address limit */
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain      *exec_domain;   /* execution domain */
--- linux-2.6.12-rc2-mm3-orig/include/asm-cris/thread_info.h	2005-03-02 08:38:32.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-cris/thread_info.h	2005-04-23 23:16:29.000000000 +0200
@@ -31,7 +31,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user-thead
--- linux-2.6.12-rc2-mm3-orig/include/asm-frv/thread_info.h	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-frv/thread_info.h	2005-04-23 23:16:37.000000000 +0200
@@ -33,7 +33,7 @@
 	unsigned long		flags;		/* low level flags */
 	unsigned long		status;		/* thread-synchronous flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count;	/* 0 => preemptable, <0 => BUG */
+	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user-thead
--- linux-2.6.12-rc2-mm3-orig/include/asm-i386/thread_info.h	2005-04-05 21:21:48.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-i386/thread_info.h	2005-04-23 23:16:50.000000000 +0200
@@ -31,7 +31,7 @@
 	unsigned long		flags;		/* low level flags */
 	unsigned long		status;		/* thread-synchronous flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 
 	mm_segment_t		addr_limit;	/* thread address space:
--- linux-2.6.12-rc2-mm3-orig/include/asm-ia64/thread_info.h	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-ia64/thread_info.h	2005-04-23 23:17:04.000000000 +0200
@@ -25,7 +25,7 @@
 	__u32 flags;			/* thread_info flags (see TIF_*) */
 	__u32 cpu;			/* current CPU */
 	mm_segment_t addr_limit;	/* user-level address space limit */
-	__s32 preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
+	int preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
 	struct restart_block restart_block;
 	struct {
 		int signo;
--- linux-2.6.12-rc2-mm3-orig/include/asm-m32r/thread_info.h	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-m32r/thread_info.h	2005-04-23 23:17:21.000000000 +0200
@@ -28,7 +28,7 @@
 	unsigned long		flags;		/* low level flags */
 	unsigned long		status;		/* thread-synchronous flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user-thread
--- linux-2.6.12-rc2-mm3-orig/include/asm-m68k/thread_info.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-m68k/thread_info.h	2005-04-23 23:17:29.000000000 +0200
@@ -8,7 +8,7 @@
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 	__u32 cpu; /* should always be 0 on m68k */
 	struct restart_block    restart_block;
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-mips/thread_info.h	2005-03-02 08:37:30.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-mips/thread_info.h	2005-04-23 23:17:47.000000000 +0200
@@ -27,7 +27,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user-thead
--- linux-2.6.12-rc2-mm3-orig/include/asm-parisc/thread_info.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-parisc/thread_info.h	2005-04-23 23:17:55.000000000 +0200
@@ -12,7 +12,7 @@
 	unsigned long flags;		/* thread_info flags (see TIF_*) */
 	mm_segment_t addr_limit;	/* user-level address space limit */
 	__u32 cpu;			/* current CPU */
-	__s32 preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
+	int preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
 	struct restart_block restart_block;
 };
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-s390/thread_info.h	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-s390/thread_info.h	2005-04-23 23:18:12.000000000 +0200
@@ -50,7 +50,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned int		cpu;		/* current CPU */
-	unsigned int		preempt_count; /* 0 => preemptable */
+	int			preempt_count; /* 0 => preemptable */
 	struct restart_block	restart_block;
 };
 
--- linux-2.6.12-rc2-mm3-orig/include/asm-sh/thread_info.h	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-sh/thread_info.h	2005-04-23 23:18:20.000000000 +0200
@@ -20,7 +20,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	__u32			flags;		/* low level flags */
 	__u32			cpu;
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 	struct restart_block	restart_block;
 	__u8			supervisor_stack[0];
 };
--- linux-2.6.12-rc2-mm3-orig/include/asm-sh64/thread_info.h	2005-04-05 21:21:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/include/asm-sh64/thread_info.h	2005-04-23 23:18:27.000000000 +0200
@@ -22,7 +22,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	/* Put the 4 32-bit fields together to make asm offsetting easier. */
-	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
+	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 	__u16			cpu;
 
 	mm_segment_t		addr_limit;
--- linux-2.6.12-rc2-mm3-orig/include/asm-um/thread_info.h	2005-03-02 08:37:54.000000000 +0100
+++ linux-2.6.12-rc2-mm3/include/asm-um/thread_info.h	2005-04-23 23:18:50.000000000 +0200
@@ -17,7 +17,7 @@
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	__u32			cpu;		/* current CPU */
-	__s32			preempt_count;  /* 0 => preemptable, 
+	int			preempt_count;  /* 0 => preemptable, 
 						   <0 => BUG */
 	mm_segment_t		addr_limit;	/* thread address space:
 					 	   0-0xBFFFFFFF for user


and then the litle detail in kernel/timer.c can be fixed nicely like this: 

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc2-mm3-orig/kernel/timer.c	2005-04-11 21:20:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3/kernel/timer.c	2005-04-23 23:19:21.000000000 +0200
@@ -459,7 +459,7 @@ static inline void __run_timers(tvec_bas
 			detach_timer(timer, 1);
 			spin_unlock_irq(&base->t_base.lock);
 			{
-				u32 preempt_count = preempt_count();
+				int preempt_count = preempt_count();
 				fn(data);
 				if (preempt_count != preempt_count()) {
 					printk("huh, entered %p with %08x, exited with %08x?\n", fn, preempt_count, preempt_count());


or is there some good reason I'm missing that make the above a bad idea?


-- 
Jesper Juhl

PS. Please CC: me on replies.


