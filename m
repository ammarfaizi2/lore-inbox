Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbULCTvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbULCTvw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbULCTvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:51:09 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:21764
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262483AbULCT3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:29:33 -0500
Message-Id: <200412032145.iB3LjYZW004715@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - correctly restore extramask in sigreturn
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:45:34 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Restoring of current->blocked in sys_sigreturn is wrong.
The first (long ) of the mask correctly is fetched from sc->oldmask.
The further longs again come from there, but correctly should be
taken from frame->extramask.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/sys-i386/signal.c
===================================================================
--- 2.6.9.orig/arch/um/sys-i386/signal.c	2004-12-01 14:03:31.000000000 -0500
+++ 2.6.9/arch/um/sys-i386/signal.c	2004-12-01 14:10:26.000000000 -0500
@@ -307,11 +307,12 @@
 	struct sigframe __user *frame = (struct sigframe *)(sp - 8);
 	sigset_t set;
 	struct sigcontext __user *sc = &frame->sc;
-	unsigned long __user *mask = &sc->oldmask;
+	unsigned long __user *oldmask = &sc->oldmask;
+	unsigned long __user *extramask = frame->extramask;
 	int sig_size = (_NSIG_WORDS - 1) * sizeof(unsigned long);
 
-	if(copy_from_user(&set.sig[0], mask, sizeof(&set.sig[0])) ||
-	   copy_from_user(&set.sig[1], mask, sig_size))
+	if(copy_from_user(&set.sig[0], oldmask, sizeof(&set.sig[0])) ||
+	   copy_from_user(&set.sig[1], extramask, sig_size))
 		goto segfault;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);

