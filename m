Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268363AbTBNLn3>; Fri, 14 Feb 2003 06:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268365AbTBNLn3>; Fri, 14 Feb 2003 06:43:29 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:20311
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268363AbTBNLn1>; Fri, 14 Feb 2003 06:43:27 -0500
Date: Fri, 14 Feb 2003 06:51:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Richard T Henderson <rth@twiddle.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] Protect smp_call_function_data w/ spinlocks on Alpha
Message-ID: <Pine.LNX.4.50.0302140634000.3518-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,
	This is an untested patch to remove the custom mutex, however it 
doesn't maintain the same semantics wrt 'retry' and unconditionally 
blocks on contention. A version of this patch is in the 
smp_call_function_on_cpu patch i posted for Alpha so they are mutually 
exclusive.

Index: linux-2.5.60-uml/arch/alpha/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.60/arch/alpha/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 smp.c
--- linux-2.5.60-uml/arch/alpha/kernel/smp.c	10 Feb 2003 22:14:47 -0000	1.1.1.1
+++ linux-2.5.60-uml/arch/alpha/kernel/smp.c	14 Feb 2003 11:49:53 -0000
@@ -668,38 +667,7 @@
 };
 
 static struct smp_call_struct *smp_call_function_data;
-
-/* Atomicly drop data into a shared pointer.  The pointer is free if
-   it is initially locked.  If retry, spin until free.  */
-
-static int
-pointer_lock (void *lock, void *data, int retry)
-{
-	void *old, *tmp;
-
-	mb();
- again:
-	/* Compare and swap with zero.  */
-	asm volatile (
-	"1:	ldq_l	%0,%1\n"
-	"	mov	%3,%2\n"
-	"	bne	%0,2f\n"
-	"	stq_c	%2,%1\n"
-	"	beq	%2,1b\n"
-	"2:"
-	: "=&r"(old), "=m"(*(void **)lock), "=&r"(tmp)
-	: "r"(data)
-	: "memory");
-
-	if (old == 0)
-		return 0;
-	if (! retry)
-		return -EBUSY;
-
-	while (*(void **)lock)
-		barrier();
-	goto again;
-}
+static spinlock_t call_lock = SPIN_LOCK_UNLOCKED;
 
 void
 handle_ipi(struct pt_regs *regs)
@@ -829,9 +797,8 @@
 	atomic_set(&data.unstarted_count, num_cpus_to_call);
 	atomic_set(&data.unfinished_count, num_cpus_to_call);
 
-	/* Acquire the smp_call_function_data mutex.  */
-	if (pointer_lock(&smp_call_function_data, &data, retry))
-		return -EBUSY;
+	spin_lock(&call_lock);
+	smp_call_function_data = &data;
 
 	/* Send a message to the requested CPUs.  */
 	send_ipi_message(to_whom, IPI_CALL_FUNC);
@@ -865,7 +832,8 @@
 
 	/* We either got one or timed out -- clear the lock. */
 	mb();
-	smp_call_function_data = 0;
+	smp_call_function_data = NULL;
+	spin_unlock(&call_lock);
 
 	/* 
 	 * If after both the initial and long timeout periods we still don't
