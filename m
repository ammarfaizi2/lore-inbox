Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262146AbVCERUC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbVCERUC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 12:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVCERSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 12:18:37 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:55815 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262161AbVCERPg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 12:15:36 -0500
Message-Id: <200503051945.j25JjIB5003539@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Blaisorblade <blaisorblade@yahoo.it>, lkml <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: Partial fix! - Was: Re: [BUG report] UML linux-2.6 latest BK doesn't compile 
In-Reply-To: Your message of "Mon, 14 Feb 2005 11:35:03 GMT."
             <1108380903.22656.9.camel@imp.csi.cam.ac.uk> 
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <200502081829.j18ITAs0003968@ccure.user-mode-linux.org> <200502081837.22519.blaisorblade@yahoo.it> <200502082223.j18MMxs0013724@ccure.user-mode-linux.org>  <1108380903.22656.9.camel@imp.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 Mar 2005 14:45:18 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aia21@cam.ac.uk said:
> Yes.  I finally found a way to get it to compile.  Compiling without
> TT mode and WITHOUT static build it still fails with the same problem
> (__bb_init_func problem I already reported).  But compiling without TT
> but WITH static build the __bb_init_func problem goes away but instead
> I get a __gcov_init missing symbol in my modules.
>
> Note I have gcc-3.3.4-11 (SuSE 9.2) and it defines __gcov_init.  So I
> added this as an export symbol and lo and behold the kernel and
> modules compiled and I am now up an running with UML and NTFS as a
> module.  (-: 

Can you try this patch?  It exports either __gcov_init or __bb_init_func
depending on your gcc version.

			Jeff

Index: linux-2.6.10/arch/um/kernel/gmon_syms.c
===================================================================
--- linux-2.6.10.orig/arch/um/kernel/gmon_syms.c	2005-02-28 17:22:29.000000000 -0500
+++ linux-2.6.10/arch/um/kernel/gmon_syms.c	2005-03-02 12:19:14.000000000 -0500
@@ -5,8 +5,14 @@
 
 #include "linux/module.h"
 
+#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
+	(__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ > 4)
+extern void __gcov_init(void *);
+EXPORT_SYMBOL(__gcov_init);
+#else
 extern void __bb_init_func(void *);
 EXPORT_SYMBOL(__bb_init_func);
+#endif
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.

