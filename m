Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWBUXjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWBUXjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWBUXjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:39:18 -0500
Received: from pcls2.std.com ([192.74.137.142]:31196 "EHLO TheWorld.com")
	by vger.kernel.org with ESMTP id S932175AbWBUXjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:39:16 -0500
From: Alan Curry <pacman@TheWorld.com>
Message-Id: <200602212339.SAA1138491@shell.TheWorld.com>
Subject: [PATCH] powerpc: fix altivec_unavailable_exception Oopses
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Feb 2006 18:39:03 -0500 (EST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

altivec_unavailable_exception is called without setting r3... it looks like
the r3 that actually gets passed in as struct pt_regs *regs is the
undisturbed value of r3 at the time the altivec instruction was encountered.
The user actually gets to choose the pt_regs printed in the Oops!

After applying the following patch to 2.6.16-rc4, I can no longer cause an
Oops by executing an altivec instruction with CONFIG_ALTIVEC=n. The same
change would probably also be good for arch/ppc/kernel/head.S to fix the same
Oops in 2.6.15.4, though I haven't tested that.

--- arch/powerpc/kernel/head_32.S.orig	2006-02-21 15:58:18.000000000 -0500
+++ arch/powerpc/kernel/head_32.S	2006-02-21 15:59:23.000000000 -0500
@@ -714,6 +714,7 @@
 #ifdef CONFIG_ALTIVEC
 	bne	load_up_altivec		/* if from user, just load it up */
 #endif /* CONFIG_ALTIVEC */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0xf20, altivec_unavailable_exception)
 
 PerformanceMonitor:
