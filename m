Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266930AbTGGJQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 05:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266932AbTGGJQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 05:16:12 -0400
Received: from [213.39.233.138] ([213.39.233.138]:21484 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266930AbTGGJQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 05:16:06 -0400
Date: Mon, 7 Jul 2003 11:30:25 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.74] Signal stack safety #2 i386 specific
Message-ID: <20030707093025.GA2598@wohnheim.fh-wedel.de>
References: <20030705104428.GA19311@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0307051013140.5900-100000@home.osdl.org> <20030706125103.GB23341@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030706125103.GB23341@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 July 2003 14:51:03 +0200, Jörn Engel wrote:
> 
> My current best idea is to check, whether the stack pointer is valid
> before going to the signal stack.  As long as it points to memory that
> is writable for the current process, things are not completely
> hopeless.  When the stack is totally broken, kill that cancer cell.

Also stupid.  People use a segfault handler on a signal stack,
*because* the previous stack may be broken.

Since any trick we try appears to (possibly) break some existing
software, the next idea is to add yet another flag to signal.h.  With
this, the user can decide whether he want to get extra safety or not.

Comments?

Jörn

-- 
The only real mistake is the one from which we learn nothing.
-- John Powell

--- linux-2.5.74/arch/i386/kernel/signal.c~ss_i386	2003-07-07 10:30:30.000000000 +0200
+++ linux-2.5.74/arch/i386/kernel/signal.c	2003-07-07 10:31:09.000000000 +0200
@@ -181,6 +181,9 @@
 		}
 	}
 
+	if (sas_ss_flags(regs->esp) == 0)
+		current->flags &= ~PF_SS_ACTIVE;
+
 	err |= __get_user(*peax, &sc->eax);
 	return err;
 
@@ -317,9 +320,23 @@
 	esp = regs->esp;
 
 	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (sas_ss_flags(esp) == 0)
-			esp = current->sas_ss_sp + current->sas_ss_size;
+	if ((ka->sa.sa_flags & SA_ONSTACK) && (sas_ss_flags(esp) == 0)) {
+		/* If we have switches to the signal stack before,
+		 * something bad has happened to it, asking for a
+		 * segmentation fault.
+		 * If not, remember it for the next time
+		 */
+		if ((ka->sa.sa_flags & SA_KERNEL_RET) &&
+				(current->flags & PF_SS_ACTIVE)) {
+			ka->sa.sa_handler = SIG_DFL;
+			force_sig(SIGSEGV, current);
+			/* XXX would it be simpler to return some broken
+			 * value like NULL and have the calling function
+			 * signal the segv?
+			 */
+		}
+		current->flags |= PF_SS_ACTIVE;
+		esp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
 	/* This is the legacy signal stack switching. */
--- linux-2.5.74/include/asm-i386/signal.h~ss_i386	2003-07-07 10:30:30.000000000 +0200
+++ linux-2.5.74/include/asm-i386/signal.h	2003-07-07 11:29:42.000000000 +0200
@@ -76,6 +76,8 @@
  * SA_FLAGS values:
  *
  * SA_ONSTACK indicates that a registered stack_t will be used.
+ * SA_KERNEL_RET indices that the handler returns through the kernel, not
+ *               with longjmp or similar.
  * SA_INTERRUPT is a no-op, but left due to historical reasons. Use the
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NOCLDSTOP flag to turn off SIGCHLD when children stop.
@@ -89,6 +91,7 @@
 #define SA_NOCLDSTOP	0x00000001u
 #define SA_NOCLDWAIT	0x00000002u
 #define SA_SIGINFO	0x00000004u
+#define SA_KERNEL_RET	0x01000000u
 #define SA_ONSTACK	0x08000000u
 #define SA_RESTART	0x10000000u
 #define SA_NODEFER	0x40000000u
