Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992641AbWKAQfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992641AbWKAQfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 11:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992638AbWKAQew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 11:34:52 -0500
Received: from [198.99.130.12] ([198.99.130.12]:16306 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1946937AbWKAQet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 11:34:49 -0500
Message-Id: <200611011732.kA1HWfZt005499@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/2] UML - Fix I/O hang
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 Nov 2006 12:32:41 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a UML hang in which everything would just stop until
some I/O happened - a ping, someone whacking the keyboard - at which
point everything would start up again as though nothing had happened.

The cause was gcc reordering some code which absolutely needed to be
executed in the order in the source.  When unblock_signals switches
signals from off to on, it needs to see if any interrupts had happened
in the critical section.  The interrupt handlers check signals_enabled -
if it is zero, then the handler adds a bit to the "pending" bitmask
and returns.  unblock_signals checks this mask to see if any signals
need to be delivered.

The crucial part is this:
	signals_enabled = 1;
	save_pending = pending;
	if(save_pending == 0)
		return;
	pending = 0;

In order to avoid an interrupt arriving between reading pending and
setting it to zero, in which case, the record of the interrupt would
be erased, signals are enabled.

What happened was that gcc reordered this so that 'save_pending = pending'
came before 'signals_enabled = 1', creating a one-instruction window
within which an interrupt could arrive, set its bit in pending, and
have it be immediately erased.

When the I/O workload is purely disk-based, the loss of a block device
interrupt stops the entire I/O system because the next block request
will wait for the current one to finish.  Thus the system hangs until
something else causes some I/O to arrive, such as a network packet or
console input.

The fix to this particular problem is a memory barrier between
enabling signals and reading the pending signal mask.  An xchg would
also probably work.

Looking over this code for similar problems led me to do a few more
things -
	make signals_enabled and pending volatile so that they don't
get cached in registers
	add an mb() to the return paths of block_signals and
unblock_signals so that the modification of signals_enabled doesn't
get shuffled into the caller in the event that these are inlined in
the future.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/include/sysdep-i386/barrier.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/arch/um/include/sysdep-i386/barrier.h	2006-10-31 14:41:52.000000000 -0500
@@ -0,0 +1,9 @@
+#ifndef __SYSDEP_I386_BARRIER_H
+#define __SYSDEP_I386_BARRIER_H
+
+/* Copied from include/asm-i386 for use by userspace.  i386 has the option
+ * of using mfence, but I'm just using this, which works everywhere, for now.
+ */
+#define mb() asm volatile("lock; addl $0,0(%esp)")
+
+#endif
Index: linux-2.6.18-mm/arch/um/include/sysdep-x86_64/barrier.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/arch/um/include/sysdep-x86_64/barrier.h	2006-10-31 14:40:37.000000000 -0500
@@ -0,0 +1,7 @@
+#ifndef __SYSDEP_X86_64_BARRIER_H
+#define __SYSDEP_X86_64_BARRIER_H
+
+/* Copied from include/asm-x86_64 for use by userspace. */
+#define mb() 	asm volatile("mfence":::"memory")
+
+#endif
Index: linux-2.6.18-mm/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/signal.c	2006-10-31 14:09:54.000000000 -0500
+++ linux-2.6.18-mm/arch/um/os-Linux/signal.c	2006-10-31 14:44:01.000000000 -0500
@@ -15,6 +15,7 @@
 #include "user.h"
 #include "signal_kern.h"
 #include "sysdep/sigcontext.h"
+#include "sysdep/barrier.h"
 #include "sigcontext.h"
 #include "mode.h"
 #include "os.h"
@@ -34,8 +35,12 @@
 #define SIGALRM_BIT 2
 #define SIGALRM_MASK (1 << SIGALRM_BIT)
 
-static int signals_enabled = 1;
-static int pending = 0;
+/* These are used by both the signal handlers and
+ * block/unblock_signals.  I don't want modifications cached in a
+ * register - they must go straight to memory.
+ */
+static volatile int signals_enabled = 1;
+static volatile int pending = 0;
 
 void sig_handler(int sig, struct sigcontext *sc)
 {
@@ -152,6 +157,12 @@ int change_sig(int signal, int on)
 void block_signals(void)
 {
 	signals_enabled = 0;
+	/* This must return with signals disabled, so this barrier
+	 * ensures that writes are flushed out before the return.
+	 * This might matter if gcc figures out how to inline this and
+	 * decides to shuffle this code into the caller.
+	 */
+	mb();
 }
 
 void unblock_signals(void)
@@ -171,9 +182,23 @@ void unblock_signals(void)
 		 */
 		signals_enabled = 1;
 
+		/* Setting signals_enabled and reading pending must
+		 * happen in this order.
+		 */
+		mb();
+
 		save_pending = pending;
-		if(save_pending == 0)
+		if(save_pending == 0){
+			/* This must return with signals enabled, so
+			 * this barrier ensures that writes are
+			 * flushed out before the return.  This might
+			 * matter if gcc figures out how to inline
+			 * this (unlikely, given its size) and decides
+			 * to shuffle this code into the caller.
+			 */
+			mb();
 			return;
+		}
 
 		pending = 0;
 

