Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267592AbUHTG6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267592AbUHTG6r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 02:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267595AbUHTG6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 02:58:47 -0400
Received: from ozlabs.org ([203.10.76.45]:28358 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267592AbUHTG6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 02:58:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16677.41319.618728.238700@cargo.ozlabs.ibm.com>
Date: Fri, 20 Aug 2004 16:59:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2
In-Reply-To: <20040820061749.GA30850@in.ibm.com>
References: <20040819014204.2d412e9b.akpm@osdl.org>
	<20040820061749.GA30850@in.ibm.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri writes:

> Paul rightly pointed out that is should be +15 and not +16. My mistake.
> Updated ppc64-fix-v_regs-pointer-setup.patch below:

That patch applies on top of the previous one from Srivatsa.  Here is
a single patch that has the change we want against Linus' tree.

During some signal test, we found that v_regs pointer was not setup correctly.
v_regs was made to point to itself, as a result of which the pointer was
corrupted when vec registers were copied over. When the signal handler
returned, restore_sigcontext tried derefering the invalid pointer and in
the process killed the app with SIGSEGV.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/signal.c akpm/arch/ppc64/kernel/signal.c
--- linux-2.5/arch/ppc64/kernel/signal.c	2004-06-18 19:06:50.000000000 +1000
+++ akpm/arch/ppc64/kernel/signal.c	2004-08-20 16:56:55.040912736 +1000
@@ -127,7 +127,7 @@
 	 * v_regs pointer or not
 	 */
 #ifdef CONFIG_ALTIVEC
-	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)(((unsigned long)sc->vmx_reserve) & ~0xful);
+	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)(((unsigned long)sc->vmx_reserve + 15) & ~0xful);
 #endif
 	long err = 0;
 
