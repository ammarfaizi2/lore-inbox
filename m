Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVAMWEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVAMWEI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbVAMWCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:02:14 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:46853 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261766AbVAMV6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:58:32 -0500
Subject: [patch 11/11] uml: update ld scripts to newer binutils
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 22:01:13 +0100
Message-Id: <20050113210113.D81F91FEFD@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that linker script for userspace software are quite
toolchain-depending, at least because what we use is a merge between builtin
LD scripts (see strings /usr/bin/ld) and normal kernel linking scripts.

Plus, a number of people are having toolchain-related troubles building UML
(even assertion failures on linking, with Gentoo and Fedora 2).

So, let's try to make UML nicer for binutils.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/kernel/dyn.lds.S |    3 +++
 linux-2.6.11-paolo/arch/um/kernel/uml.lds.S |   10 +++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/uml.lds.S~uml-update-lds-to-ld-version arch/um/kernel/uml.lds.S
--- linux-2.6.11/arch/um/kernel/uml.lds.S~uml-update-lds-to-ld-version	2005-01-13 05:53:48.582270064 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/uml.lds.S	2005-01-13 05:56:06.458309720 +0100
@@ -7,8 +7,12 @@ jiffies = jiffies_64;
 
 SECTIONS
 {
+  /*This must contain the right address - not quite the default ELF one.*/
+  PROVIDE (__executable_start = START);
   . = START + SIZEOF_HEADERS;
 
+  /* Used in arch/um/kernel/mem.c. Any memory between START and __binary_start
+   * is remapped.*/
   __binary_start = .;
 #ifdef MODE_TT
   .thread_private : {
@@ -20,9 +24,13 @@ SECTIONS
   }
   . = ALIGN(4096);
   .remap : { arch/um/kernel/tt/unmap_fin.o (.text) }
-#endif
+
+  /* We want it only if we are in MODE_TT. In both cases, however, when MODE_TT
+   * is off the resulting binary segfaults.*/
 
   . = ALIGN(4096);		/* Init code and data */
+#endif
+
   _stext = .;
   __init_begin = .;
   .init.text : {
diff -puN arch/um/kernel/dyn.lds.S~uml-update-lds-to-ld-version arch/um/kernel/dyn.lds.S
--- linux-2.6.11/arch/um/kernel/dyn.lds.S~uml-update-lds-to-ld-version	2005-01-13 05:53:48.583269912 +0100
+++ linux-2.6.11-paolo/arch/um/kernel/dyn.lds.S	2005-01-13 05:53:48.616264896 +0100
@@ -7,8 +7,11 @@ jiffies = jiffies_64;
 
 SECTIONS
 {
+  PROVIDE (__executable_start = START);
   . = START + SIZEOF_HEADERS;
   .interp         : { *(.interp) }
+  /* Used in arch/um/kernel/mem.c. Any memory between START and __binary_start
+   * is remapped.*/
   __binary_start = .;
   . = ALIGN(4096);		/* Init code and data */
   _stext = .;
_
