Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263316AbTIVUNB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTIVUNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:13:01 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:15489 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S263316AbTIVUM4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:12:56 -0400
Date: Mon, 22 Sep 2003 13:12:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: [PATCH] Add 'make uImage' for PPC32
Message-ID: <20030922201254.GP7443@ip68-0-152-218.tc.ph.cox.net>
References: <20030922182928.GM7443@ip68-0-152-218.tc.ph.cox.net> <20030922190723.GN7443@ip68-0-152-218.tc.ph.cox.net> <20030922200054.GB983@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922200054.GB983@mars.ravnborg.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 10:00:54PM +0200, Sam Ravnborg wrote:
> On Mon, Sep 22, 2003 at 12:07:23PM -0700, Tom Rini wrote:
> > On Mon, Sep 22, 2003 at 11:29:28AM -0700, Tom Rini wrote:
> > 
> > > Hello.  The following BK patch adds support for a 'uImage' target on
> > > PPC32.  This will create an image for the U-Boot (and formerly
> > > PPCBoot) firmware.  The patch adds a scripts/mkuboot.sh as a wrapper for
> > > the U-Boot mkimage program.  We put mkuboot.sh into scripts/ because
> > > U-Boot works on a number of other platforms, and it's likely that they
> > > will add a uImage target at some point.  Please apply.
> > 
> > And since I don't use U-Boot I didn't fully test this until I did the
> > 2.6 forward port (coming soon), so the following is also needed to get
> > all of the dependancies correct.  Please apply.
> 
> Could you please send normal looking patches.
> I cannot follow the bk style (at least not at this time of the day).

Certainly:
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1131  -> 1.1133 
#	   arch/ppc/Makefile	1.21    -> 1.22   
#	arch/ppc/boot/images/Makefile	1.3     -> 1.4    
#	arch/ppc/boot/Makefile	1.10    -> 1.12   
#	arch/ppc/boot/utils/mkimage.wrapper	1.1     ->         (deleted)      
#	               (new)	        -> 1.1     scripts/mkuboot.sh
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/22	trini@kernel.crashing.org	1.1132
# PPC32: Add a 'uImage' target for U-Boot.
# --------------------------------------------
# 03/09/22	trini@kernel.crashing.org	1.1133
# PPC32: Fix dependancies on uImage.
# --------------------------------------------
#
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	Mon Sep 22 13:12:43 2003
+++ b/arch/ppc/Makefile	Mon Sep 22 13:12:43 2003
@@ -85,7 +85,7 @@
 checks:
 	@$(MAKE) -C arch/$(ARCH)/kernel checks
 
-BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd
+BOOT_TARGETS = zImage zImage.initrd znetboot znetboot.initrd uImage
 
 # All the instructions talk about "make bzImage".
 bzImage: zImage
diff -Nru a/arch/ppc/boot/Makefile b/arch/ppc/boot/Makefile
--- a/arch/ppc/boot/Makefile	Mon Sep 22 13:12:43 2003
+++ b/arch/ppc/boot/Makefile	Mon Sep 22 13:12:43 2003
@@ -17,7 +17,7 @@
 AFLAGS	+= -D__BOOTER__
 OBJCOPY_ARGS = -O elf32-powerpc
 
-MKIMAGE				:= ./utils/mkimage.wrapper
+MKIMAGE				:= $(TOPDIR)/scripts/mkuboot.sh
 
 lib/zlib.a: lib/zlib.c
 	$(MAKE) -C lib
@@ -61,12 +61,14 @@
 	gzip $(GZIP_FLAGS) images/vmapus
 endif
 
-# Make an image for PPCBoot
-pImage: images/vmlinux.gz
-	$(MKIMAGE) -A ppc -O linux -T kernel -C gzip -a 00000000 -e 00000000 \
+# Make an image for PPCBoot / U-Boot.
+uImage: $(MKIMAGE) images/vmlinux.gz
+	$(CONFIG_SHELL) $(MKIMAGE) -A ppc -O linux -T kernel \
+	-C gzip -a 00000000 -e 00000000 \
 	-n 'Linux-$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)' \
-	-d $< images/vmlinux.PPCBoot
-	ln -sf vmlinux.PPCBoot images/pImage
+	-d images/vmlinux.gz images/vmlinux.UBoot
+	ln -sf vmlinux.UBoot images/uImage
+	rm -f ./mkuboot
 
 # These are subdirs with files not normally rm'ed. -- Tom
 clean:
diff -Nru a/arch/ppc/boot/images/Makefile b/arch/ppc/boot/images/Makefile
--- a/arch/ppc/boot/images/Makefile	Mon Sep 22 13:12:43 2003
+++ b/arch/ppc/boot/images/Makefile	Mon Sep 22 13:12:43 2003
@@ -9,4 +9,4 @@
 	gzip -vf9 vmlinux
 
 clean:
-	rm -f sImage vmapus vmlinux* miboot* zImage* zvmlinux*
+	rm -f sImage vmapus vmlinux* miboot* zImage* zvmlinux* uImage
diff -Nru a/arch/ppc/boot/utils/mkimage.wrapper b/arch/ppc/boot/utils/mkimage.wrapper
--- a/arch/ppc/boot/utils/mkimage.wrapper	Mon Sep 22 13:12:43 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,16 +0,0 @@
-#!/bin/bash
-
-#
-# Build PPCBoot image when `mkimage' tool is available.
-#
-
-MKIMAGE=$(type -path mkimage)
-
-if [ -z "${MKIMAGE}" ]; then
-	# Doesn't exist
-	echo '"mkimage" command not found - PPCBoot images will not be built' >&2
-	exit 0;
-fi
-
-# Call "mkimage" to create PPCBoot image
-${MKIMAGE} "$@"
diff -Nru a/scripts/mkuboot.sh b/scripts/mkuboot.sh
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/scripts/mkuboot.sh	Mon Sep 22 13:12:43 2003
@@ -0,0 +1,16 @@
+#!/bin/bash
+
+#
+# Build U-Boot image when `mkimage' tool is available.
+#
+
+MKIMAGE=$(type -path mkimage)
+
+if [ -z "${MKIMAGE}" ]; then
+	# Doesn't exist
+	echo '"mkimage" command not found - U-Boot images will not be built' >&2
+	exit 0;
+fi
+
+# Call "mkimage" to create U-Boot image
+${MKIMAGE} "$@"

-- 
Tom Rini
http://gate.crashing.org/~trini/
