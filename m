Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268954AbUIQRDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbUIQRDn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 13:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268922AbUIQRCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 13:02:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43140 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268911AbUIQRAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 13:00:55 -0400
Date: Fri, 17 Sep 2004 18:00:51 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make make install install modules too
Message-ID: <20040917170051.GU642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I keep forgetting to run 'make modules_install' after make install.  Since
make now compiles modules too and there's no separate make modules step,
it seems to make sense that make install should also install modules.

Index: linux-2.6/arch/i386/Makefile
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/Makefile,v
retrieving revision 1.11
diff -u -p -r1.11 Makefile
--- linux-2.6/arch/i386/Makefile	13 Sep 2004 15:22:09 -0000	1.11
+++ linux-2.6/arch/i386/Makefile	17 Sep 2004 16:57:03 -0000
@@ -117,7 +117,7 @@ AFLAGS += $(mflags-y)
 boot := arch/i386/boot
 
 .PHONY: zImage bzImage compressed zlilo bzlilo \
-	zdisk bzdisk fdimage fdimage144 fdimage288 install
+	zdisk bzdisk fdimage fdimage144 fdimage288 install kernel_install
 
 all: bzImage
 
@@ -136,8 +136,10 @@ zlilo bzlilo: vmlinux
 zdisk bzdisk: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) zdisk
 
-install fdimage fdimage144 fdimage288: vmlinux
+kernel_install fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
+
+install: kernel_install modules_install
 
 prepare: include/asm-$(ARCH)/asm_offsets.h
 CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
Index: linux-2.6/arch/i386/boot/Makefile
===================================================================
RCS file: /var/cvs/linux-2.6/arch/i386/boot/Makefile,v
retrieving revision 1.5
diff -u -p -r1.5 Makefile
--- linux-2.6/arch/i386/boot/Makefile	13 Sep 2004 15:22:09 -0000	1.5
+++ linux-2.6/arch/i386/boot/Makefile	17 Sep 2004 16:57:03 -0000
@@ -100,5 +100,5 @@ zlilo: $(BOOTIMAGE)
 	cp System.map $(INSTALL_PATH)/
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
-install: $(BOOTIMAGE)
+kernel_install: $(BOOTIMAGE)
 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
