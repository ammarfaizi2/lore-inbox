Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <154015-18252>; Thu, 19 Nov 1998 16:54:59 -0500
Received: from neon-best.transmeta.com ([206.184.214.10]:26433 "EHLO neon.transmeta.com" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <155243-18252>; Thu, 19 Nov 1998 12:05:34 -0500
Date: Thu, 19 Nov 1998 10:01:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@e-mind.com>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: entry.S mess with %ebx (&current pointer)
In-Reply-To: <Pine.LNX.3.96.981119112030.27027A-100000@dragon.bogus>
Message-ID: <Pine.LNX.3.95.981119095352.2684C-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



On Thu, 19 Nov 1998, Andrea Arcangeli wrote:
> 
> I am sure that the kernel run do_signal() from signal_return, even if
> sigpending is 0.  This mean that %ebx got corrupted somewhere (and this
> explain very well also the need_resched flood I suspected some days ago).
> A patch for 2.1.128 that fix the UP hang fine here is this: 

Good debugging, but the fix is incorrect (or at least unnecessarily slow).

I see where the problem is, and I also see why it _only_ happens on UP.

The problem is that the fork return point to the new process does not
initialize %ebx in the UP case.

It _does_ initialize it in the SMP case, and this is basically just an
oversight. 

This patch should fix it properly, please tell me whether that is true..

		Linus

-----
diff -u --recursive --new-file v2.1.129/linux/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- v2.1.129/linux/arch/i386/kernel/entry.S	Sun Nov  8 14:02:42 1998
+++ linux/arch/i386/kernel/entry.S	Thu Nov 19 09:53:08 1998
@@ -150,14 +150,14 @@
 	jmp ret_from_sys_call
 
 
-#ifdef __SMP__
 	ALIGN
 	.globl	ret_from_smpfork
-ret_from_smpfork:
+ret_from_fork:
 	GET_CURRENT(%ebx)
+#ifdef __SMP__
 	btrl	$0, SYMBOL_NAME(scheduler_lock)
-	jmp	ret_from_sys_call
 #endif /* __SMP__ */
+	jmp	ret_from_sys_call
 
 /*
  * Return to user mode is not as complex as all this looks,
diff -u --recursive --new-file v2.1.129/linux/arch/i386/kernel/process.c linux/arch/i386/kernel/process.c
--- v2.1.129/linux/arch/i386/kernel/process.c	Fri Oct  9 13:27:05 1998
+++ linux/arch/i386/kernel/process.c	Thu Nov 19 09:53:35 1998
@@ -50,11 +50,7 @@
 
 spinlock_t semaphore_wake_lock = SPIN_LOCK_UNLOCKED;
 
-#ifdef __SMP__
-asmlinkage void ret_from_fork(void) __asm__("ret_from_smpfork");
-#else
-asmlinkage void ret_from_fork(void) __asm__("ret_from_sys_call");
-#endif
+asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
 
 #ifdef CONFIG_APM
 extern int  apm_do_idle(void);



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
