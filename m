Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965314AbVKBWaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965314AbVKBWaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 17:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbVKBWaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 17:30:21 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:21673 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S965314AbVKBWaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 17:30:19 -0500
Date: Thu, 3 Nov 2005 00:30:18 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] sh: Drop deprecated support for custom ramdisk embedding.
Message-ID: <20051102223018.GB27200@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sh had its own support for embedding ramdisk images in to the kernel
binary, but people are using initramfs for this now, so we drop the
ramdisk embedding.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/Kconfig           |   18 ------------------
 arch/sh/Makefile          |    8 --------
 arch/sh/ramdisk/Makefile  |   20 --------------------
 arch/sh/ramdisk/ld.script |    9 ---------
 4 files changed, 0 insertions(+), 55 deletions(-)
 delete mode 100644 arch/sh/ramdisk/Makefile
 delete mode 100644 arch/sh/ramdisk/ld.script

applies-to: e55015f93ae413d03a2100c932978f510ef89284
dd7c534fe405434948818a6f27abfc8e35d26075
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 3e804c7..7d31d62 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -770,24 +770,6 @@ source "fs/Kconfig.binfmt"
 
 endmenu
 
-menu "SH initrd options"
-	depends on BLK_DEV_INITRD
-
-config EMBEDDED_RAMDISK
-	bool "Embed root filesystem ramdisk into the kernel"
-
-config EMBEDDED_RAMDISK_IMAGE
-	string "Filename of gziped ramdisk image"
-	depends on EMBEDDED_RAMDISK
-	default "ramdisk.gz"
-	help
-	  This is the filename of the ramdisk image to be built into the
-	  kernel.  Relative pathnames are relative to arch/sh/ramdisk/.
-	  The ramdisk image is not part of the kernel distribution; you must
-	  provide one yourself.
-
-endmenu
-
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 4a30490..67192d6 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -60,14 +60,6 @@ LIBGCC := $(shell $(CC) $(CFLAGS) -print
 
 core-y				+= arch/sh/kernel/ arch/sh/mm/
 
-#
-# ramdisk/initrd support
-# You need a compressed ramdisk image, named
-# CONFIG_EMBEDDED_RAMDISK_IMAGE. Relative pathnames
-# are relative to arch/sh/ramdisk/.
-#
-core-$(CONFIG_EMBEDDED_RAMDISK)	+= arch/sh/ramdisk/
-
 # Boards
 machdir-$(CONFIG_SH_SOLUTION_ENGINE)		:= se/770x
 machdir-$(CONFIG_SH_7751_SOLUTION_ENGINE)	:= se/7751
diff --git a/arch/sh/ramdisk/Makefile b/arch/sh/ramdisk/Makefile
deleted file mode 100644
index 99e1c68..0000000
--- a/arch/sh/ramdisk/Makefile
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# Makefile for a ramdisk image
-#
-
-obj-y += ramdisk.o
-
-
-O_FORMAT = $(shell $(OBJDUMP) -i | head -n 2 | grep elf32)
-img := $(subst ",,$(CONFIG_EMBEDDED_RAMDISK_IMAGE))
-# add $(src) when $(img) is relative
-img := $(subst $(src)//,/,$(src)/$(img))
-
-quiet_cmd_ramdisk = LD      $@
-define cmd_ramdisk
-	$(LD) -T $(srctree)/$(src)/ld.script -b binary --oformat $(O_FORMAT) \
-		-o $@ $(img)
-endef
-
-$(obj)/ramdisk.o: $(img) $(srctree)/$(src)/ld.script
-	$(call cmd,ramdisk)
diff --git a/arch/sh/ramdisk/ld.script b/arch/sh/ramdisk/ld.script
deleted file mode 100644
index 94beee2..0000000
--- a/arch/sh/ramdisk/ld.script
+++ /dev/null
@@ -1,9 +0,0 @@
-OUTPUT_ARCH(sh)
-SECTIONS
-{
-  .initrd :
-  {
-       *(.data)
-  }
-}
-
---
0.99.8.GIT
