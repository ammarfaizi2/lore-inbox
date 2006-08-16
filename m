Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWHPTTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWHPTTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWHPTTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:19:04 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:2979 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750918AbWHPTTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:19:03 -0400
Date: Wed, 16 Aug 2006 21:19:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] kbuild: correct assingment to CFLAGS with CROSS_COMPILE
Message-ID: <20060816191902.GA14529@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg.

Please pull following change for 2.6.18.
Pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-2.6.18.git


	Sam


commit c9eca0b91015bc685c2f35a50efc63d73fdf943a
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Wed Aug 16 21:14:08 2006 +0200

    kbuild: correct assingment to CFLAGS with CROSS_COMPILE
    
    Some architectures change $CC in arch/$(ARCH)/Makefile
    mips is one example.
    
    That have impact on what options are supported by gcc so move all
    $(call cc-option, ...) after include of arch specific Makefile.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/Makefile b/Makefile
index e71fefd..1589085 100644
--- a/Makefile
+++ b/Makefile
@@ -309,9 +309,6 @@ CPPFLAGS        := -D__KERNEL__ $(LINUXI
 
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                    -fno-strict-aliasing -fno-common
-# Force gcc to behave correct even for buggy distributions
-CFLAGS          += $(call cc-option, -fno-stack-protector)
-
 AFLAGS          := -D__ASSEMBLY__
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
@@ -486,6 +483,8 @@ else
 CFLAGS		+= -O2
 endif
 
+include $(srctree)/arch/$(ARCH)/Makefile
+
 ifdef CONFIG_FRAME_POINTER
 CFLAGS		+= -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
 else
@@ -500,7 +499,8 @@ ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
 
-include $(srctree)/arch/$(ARCH)/Makefile
+# Force gcc to behave correct even for buggy distributions
+CFLAGS          += $(call cc-option, -fno-stack-protector)
 
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
