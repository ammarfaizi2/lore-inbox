Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269380AbUJLAlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269380AbUJLAlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269403AbUJLAV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:21:28 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:23171
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269394AbUJLATD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:19:03 -0400
Subject: [patch 01/10] uml: Set cflags before including arch Makefile
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:17:44 +0200
Message-Id: <20041012001745.11E3B8686@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If arch/$(ARCH)/Makefile is included before adding -O2 (and the rest) to
CFLAGS, I must duplicate the addition of it to USER_CFLAGS for UML.
So let's fix this.
Also, the below code is useless, since if CONFIG_DEBUG_INFO is y, then
CONFIG_FRAME_POINTER is always y.

ifeq ($(CONFIG_DEBUG_INFO),y)
CFLAGS := $(subst -fomit-frame-pointer,,$(CFLAGS))
endif


Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |   21 ---------------------
 1 files changed, 21 deletions(-)

diff -puN arch/um/Makefile~uml-Set_cflags_before_arch_Makefile arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-Set_cflags_before_arch_Makefile	2004-10-12 01:06:01.579248144 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-12 01:06:01.582247688 +0200
@@ -13,10 +13,6 @@ OS := $(shell uname -s)
 # EXTRAVERSION...
 MODLIB := $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
 
-ifeq ($(CONFIG_DEBUG_INFO),y)
-CFLAGS := $(subst -fomit-frame-pointer,,$(CFLAGS))
-endif
-
 core-y			+= $(ARCH_DIR)/kernel/		 \
 			   $(ARCH_DIR)/drivers/          \
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
@@ -135,23 +131,6 @@ USER_CFLAGS := $(patsubst -D__KERNEL__,,
 # To get a definition of F_SETSIG
 USER_CFLAGS += -D_GNU_SOURCE
 
-# From main Makefile, these options are set after including the ARCH makefile.
-# So copy them here.
-
-ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-USER_CFLAGS		+= -Os
-else
-USER_CFLAGS		+= -O2
-endif
-
-ifndef CONFIG_FRAME_POINTER
-USER_CFLAGS		+= -fomit-frame-pointer
-endif
-
-ifdef CONFIG_DEBUG_INFO
-USER_CFLAGS		+= -g
-endif
-
 CLEAN_FILES += linux x.i gmon.out $(ARCH_DIR)/uml.lds \
 	$(ARCH_DIR)/dyn_link.ld.s $(ARCH_DIR)/include/uml-config.h \
 	$(GEN_HEADERS)
_
