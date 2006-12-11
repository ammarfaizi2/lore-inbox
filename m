Return-Path: <linux-kernel-owner+w=401wt.eu-S937385AbWLKTxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937385AbWLKTxK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 14:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937554AbWLKTxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 14:53:09 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:54399 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937385AbWLKTxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 14:53:08 -0500
Message-Id: <200612111948.kBBJmLF0023523@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH] Fix crossbuilding checkstack
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Dec 2006 14:48:21 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The previous checkstack fix for UML, which needs to use the host's tools, 
was wrong in the crossbuilding case.  It would use the build host's,
rather than the target's, toolchain.

This patch removes the old fix and adds an explicit special case for UML, 
leaving everyone else alone.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

---
 Makefile |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

Index: linux-2.6.18-mm/Makefile
===================================================================
--- linux-2.6.18-mm.orig/Makefile	2006-11-24 14:36:32.000000000 -0500
+++ linux-2.6.18-mm/Makefile	2006-12-05 13:08:20.000000000 -0500
@@ -1390,12 +1390,18 @@ endif #ifeq ($(mixed-targets),1)
 
 PHONY += checkstack kernelrelease kernelversion
 
-# Use $(SUBARCH) here instead of $(ARCH) so that this works for UML.
-# In the UML case, $(SUBARCH) is the name of the underlying
-# architecture, while for all other arches, it is the same as $(ARCH).
+# UML needs a little special treatment here.  It wants to use the host
+# toolchain, so needs $(SUBARCH) passed to checkstack.pl.  Everyone
+# else wants $(ARCH), including people doing cross-builds, which means
+# that $(SUBARCH) doesn't work here.
+ifeq ($(ARCH), um)
+CHECKSTACK_ARCH := $(SUBARCH)
+else
+CHECKSTACK_ARCH := $(ARCH)
+endif
 checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
-	$(PERL) $(src)/scripts/checkstack.pl $(SUBARCH)
+	$(PERL) $(src)/scripts/checkstack.pl $(CHECKSTACK_ARCH)
 
 kernelrelease:
 	$(if $(wildcard include/config/kernel.release), $(Q)echo $(KERNELRELEASE), \

