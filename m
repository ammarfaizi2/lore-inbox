Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWDXI2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWDXI2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWDXI2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:28:08 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:32169 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751175AbWDXI2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:28:06 -0400
Subject: Re: [patch 02/22] powerpc: fix incorrect SA_ONSTACK behaviour for
	64-bit processes
From: Laurent MEYER <meyerlau@fr.ibm.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20060413230659.GC5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
	 <20060413230659.GC5613@kroah.com>
Content-Type: multipart/mixed; boundary="=-KAFT4fcukLkuHwPCFonW"
Date: Mon, 24 Apr 2006 10:27:45 +0200
Message-Id: <1145867270.4022.12.camel@donkey.lab.meiosys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KAFT4fcukLkuHwPCFonW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> From: Laurent MEYER <meyerlau@fr.ibm.com>
> 
> *) When setting a sighandler using sigaction() call, if the flag
> SA_ONSTACK is set and no alternate stack is provided via sigaltstack(),
> the kernel still try to install the alternate stack. This behavior is
> the opposite of the one which is documented in Single Unix
> Specifications V3.
> 
> *) Also when setting an alternate stack using sigaltstack() with the
> flag SS_DISABLE, the kernel try to install the alternate stack on
> signal delivery.
> 
> These two use cases makes the process crash at signal delivery.
> 
> This fixes it.
> 


As we got the bug on powerpc64 and s390 i checked others architecture,
and the same bug seems to appear on arch: 
- alpha
- frv
- h8300
- m68knommu
- m68k
- parisc
- sh64
- v850
- xtensa

Please find enclosed the patch that fixes it. Forgive me i have not
tested this patch as i don't have all the corresponding machines. But
the bug seems to be quite the same.

Regards

Signed-off-by: Laurent Meyer <meyerlau@fr.ibm.com>


--=-KAFT4fcukLkuHwPCFonW
Content-Disposition: attachment; filename=multiarch.sigaltstack.patch
Content-Type: text/x-patch; name=multiarch.sigaltstack.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: 2.6.16.5/arch/alpha/kernel/signal.c
===================================================================
--- 2.6.16.5.orig/arch/alpha/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16.5/arch/alpha/kernel/signal.c	2006-04-17 15:17:58.000000000 +0200
@@ -375,7 +375,7 @@
 static inline void __user *
 get_sigframe(struct k_sigaction *ka, unsigned long sp, size_t frame_size)
 {
-	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! on_sig_stack(sp))
+	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! sas_ss_flags(sp))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
 	return (void __user *)((sp - frame_size) & -32ul);
Index: 2.6.16.5/arch/frv/kernel/signal.c
===================================================================
--- 2.6.16.5.orig/arch/frv/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16.5/arch/frv/kernel/signal.c	2006-04-17 15:25:01.000000000 +0200
@@ -233,7 +233,7 @@
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (! on_sig_stack(sp))
+		if (! sas_ss_flags(sp))
 			sp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
Index: 2.6.16.5/arch/h8300/kernel/signal.c
===================================================================
--- 2.6.16.5.orig/arch/h8300/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16.5/arch/h8300/kernel/signal.c	2006-04-17 15:35:15.000000000 +0200
@@ -307,7 +307,7 @@
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (!on_sig_stack(usp))
+		if (!sas_ss_flags(usp))
 			usp = current->sas_ss_sp + current->sas_ss_size;
 	}
 	return (void *)((usp - frame_size) & -8UL);
Index: 2.6.16.5/arch/m68knommu/kernel/signal.c
===================================================================
--- 2.6.16.5.orig/arch/m68knommu/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16.5/arch/m68knommu/kernel/signal.c	2006-04-17 15:46:30.000000000 +0200
@@ -553,7 +553,7 @@
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (!on_sig_stack(usp))
+		if (!sas_ss_flags(usp))
 			usp = current->sas_ss_sp + current->sas_ss_size;
 	}
 	return (void *)((usp - frame_size) & -8UL);
Index: 2.6.16.5/arch/m68k/kernel/signal.c
===================================================================
--- 2.6.16.5.orig/arch/m68k/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16.5/arch/m68k/kernel/signal.c	2006-04-17 15:42:20.000000000 +0200
@@ -763,7 +763,7 @@
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (!on_sig_stack(usp))
+		if (!sas_ss_flags(usp))
 			usp = current->sas_ss_sp + current->sas_ss_size;
 	}
 	return (void __user *)((usp - frame_size) & -8UL);
Index: 2.6.16.5/arch/parisc/kernel/signal.c
===================================================================
--- 2.6.16.5.orig/arch/parisc/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16.5/arch/parisc/kernel/signal.c	2006-04-17 15:55:13.000000000 +0200
@@ -248,7 +248,7 @@
 	DBG(1,"get_sigframe: ka = %#lx, sp = %#lx, frame_size = %#lx\n",
 			(unsigned long)ka, sp, frame_size);
 	
-	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! on_sig_stack(sp))
+	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! sas_ss_flags(sp))
 		sp = current->sas_ss_sp; /* Stacks grow up! */
 
 	DBG(1,"get_sigframe: Returning sp = %#lx\n", (unsigned long)sp);
Index: 2.6.16.5/arch/sh64/kernel/signal.c
===================================================================
--- 2.6.16.5.orig/arch/sh64/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16.5/arch/sh64/kernel/signal.c	2006-04-17 16:02:30.000000000 +0200
@@ -407,7 +407,7 @@
 static inline void __user *
 get_sigframe(struct k_sigaction *ka, unsigned long sp, size_t frame_size)
 {
-	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! on_sig_stack(sp))
+	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! sas_ss_flags(sp))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
 	return (void __user *)((sp - frame_size) & -8ul);
Index: 2.6.16.5/arch/v850/kernel/signal.c
===================================================================
--- 2.6.16.5.orig/arch/v850/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16.5/arch/v850/kernel/signal.c	2006-04-17 16:11:25.000000000 +0200
@@ -274,7 +274,7 @@
 	/* Default to using normal stack */
 	unsigned long sp = regs->gpr[GPR_SP];
 
-	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! on_sig_stack(sp))
+	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! sas_ss_flags(sp))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
 	return (void *)((sp - frame_size) & -8UL);
Index: 2.6.16.5/arch/xtensa/kernel/signal.c
===================================================================
--- 2.6.16.5.orig/arch/xtensa/kernel/signal.c	2006-03-20 06:53:29.000000000 +0100
+++ 2.6.16.5/arch/xtensa/kernel/signal.c	2006-04-17 16:16:40.000000000 +0200
@@ -433,7 +433,7 @@
 static inline void *
 get_sigframe(struct k_sigaction *ka, unsigned long sp, size_t frame_size)
 {
-	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! on_sig_stack(sp))
+	if ((ka->sa.sa_flags & SA_ONSTACK) != 0 && ! sas_ss_flags(sp))
 		sp = current->sas_ss_sp + current->sas_ss_size;
 
 	return (void *)((sp - frame_size) & -16ul);


--=-KAFT4fcukLkuHwPCFonW--

