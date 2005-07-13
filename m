Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVGMSDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVGMSDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVGMSDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:03:04 -0400
Received: from [151.97.230.9] ([151.97.230.9]:19436 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261867AbVGMSAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:00:35 -0400
Subject: [patch 4/9] uml: gcc 2.95 fix and Makefile cleanup
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       raphael.bossek@gmx.de
From: blaisorblade@yahoo.it
Date: Wed, 13 Jul 2005 20:02:24 +0200
Message-Id: <20050713180224.8FD9A21E736@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Raphael Bossek <raphael.bossek@gmx.de>

 1) Cleanup an ugly hyper-nested code in Makefile (now only the arith.
 expression is passed through the host bash).

 2) Fix a problem with GCC 2.95: according to a report from Raphael Bossek,
  .remap_data : { arch/um/sys-SUBARCH/unmap_fin.o (.data .bss) }
 is expanded into:
  .remap_data : { arch/um/sys-i386 /unmap_fin.o (.data .bss) }

(because I didn't use ## to join the two tokens), thus stopping linking. Pass
the whole path from the Makefile as a simple and nice fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/arch/um/Makefile         |    9 +++++----
 linux-2.6.git-broken-paolo/arch/um/kernel/uml.lds.S |    4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/um/Makefile~uml-cleanup-Makefile-a-bit arch/um/Makefile
--- linux-2.6.git-broken/arch/um/Makefile~uml-cleanup-Makefile-a-bit	2005-07-13 19:41:17.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/Makefile	2005-07-13 19:41:17.000000000 +0200
@@ -116,13 +116,14 @@ CONFIG_KERNEL_STACK_ORDER ?= 2
 STACK_SIZE := $(shell echo $$[ 4096 * (1 << $(CONFIG_KERNEL_STACK_ORDER)) ] )
 
 ifndef START
-  START = $$(($(TOP_ADDR) - $(SIZE)))
+  START = $(shell echo $$[ $(TOP_ADDR) - $(SIZE) ] )
 endif
 
-CPPFLAGS_vmlinux.lds = $(shell echo -U$(SUBARCH) \
+CPPFLAGS_vmlinux.lds = -U$(SUBARCH) \
 	-DSTART=$(START) -DELF_ARCH=$(ELF_ARCH) \
-	-DELF_FORMAT=\"$(ELF_FORMAT)\" $(CPP_MODE-y) \
-	-DKERNEL_STACK_SIZE=$(STACK_SIZE) -DSUBARCH=$(SUBARCH))
+	-DELF_FORMAT="$(ELF_FORMAT)" $(CPP_MODE-y) \
+	-DKERNEL_STACK_SIZE=$(STACK_SIZE) \
+	-DUNMAP_PATH=arch/um/sys-$(SUBARCH)/unmap_fin.o
 
 #The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
diff -puN arch/um/kernel/uml.lds.S~uml-cleanup-Makefile-a-bit arch/um/kernel/uml.lds.S
--- linux-2.6.git-broken/arch/um/kernel/uml.lds.S~uml-cleanup-Makefile-a-bit	2005-07-13 19:41:17.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/kernel/uml.lds.S	2005-07-13 19:41:17.000000000 +0200
@@ -16,8 +16,8 @@ SECTIONS
   __binary_start = .;
 
 #ifdef MODE_TT
-  .remap_data : { arch/um/sys-SUBARCH/unmap_fin.o (.data .bss) }
-  .remap : { arch/um/sys-SUBARCH/unmap_fin.o (.text) }
+  .remap_data : { UNMAP_PATH (.data .bss) }
+  .remap : { UNMAP_PATH (.text) }
 
   . = ALIGN(4096);		/* Init code and data */
 #endif
_
