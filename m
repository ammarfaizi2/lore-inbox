Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbTGDUK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266156AbTGDUK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:10:59 -0400
Received: from [213.39.233.138] ([213.39.233.138]:25277 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266153AbTGDUK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:10:57 -0400
Date: Fri, 4 Jul 2003 22:24:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@osdl.org>, benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030704202444.GI22152@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0307041217180.1748-100000@home.osdl.org> <Pine.LNX.4.55.0307041231350.5132@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.55.0307041231350.5132@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 July 2003 12:39:16 -0700, Davide Libenzi wrote:
> 
> Yes, GNU Pth :
> 
> http://www.gnu.org/software/pth/
> 
> and, for example :
> 
> http://www.xmailserver.org/libpcl.html
> 
> They use the generic POSIX stack setup described here :
> 
> http://www.gnu.org/software/pth/rse-pmt.ps

If I read that paper correctly, my patch should not break this
specific design.  In fact, it explicitly states the possibility of an
equivalent of my patch: "the signal handler scope is often just a flag
in the process control block (PCB) ..."

As Linus pointed out, there might be other cases though.

> My Pine's 'd' key deleted his patch before I could take an exhaustive
> look, but it should be fine though. They both do use to enter the signal
> handler simply to get a snapshot of the context, and they exit the handler
> by letting the kernel to clean the on-sig-stack flag. try to search
> archives to take a better look at the patch ...

The patches are small, so read below for convenience.

Jörn

-- 
It's just what we asked for, but not what we want!
-- anonymous

--- linux-2.5.73/include/linux/sched.h~ss_generic	2003-07-04 18:57:01.000000000 +0200
+++ linux-2.5.73/include/linux/sched.h	2003-07-04 18:59:03.000000000 +0200
@@ -480,6 +480,7 @@
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
+#define PF_SS_ACTIVE	0x00100000	/* Executing on signal stack now */
 #define PF_LESS_THROTTLE 0x01000000	/* Throttle me less: I clena memory */
 
 #ifdef CONFIG_SMP

--- linux-2.5.73/arch/i386/kernel/signal.c~ss_i386	2003-07-04 18:57:01.000000000 +0200
+++ linux-2.5.73/arch/i386/kernel/signal.c	2003-07-04 18:59:04.000000000 +0200
@@ -181,6 +181,9 @@
 		}
 	}
 
+	if (sas_ss_flags(regs->esp) == 0)
+		current->flags &= ~PF_SS_ACTIVE;
+
 	err |= __get_user(*peax, &sc->eax);
 	return err;
 
@@ -317,9 +320,22 @@
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
+		if (current->flags & PF_SS_ACTIVE) {
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
