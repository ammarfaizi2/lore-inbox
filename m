Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWAIUzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWAIUzq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWAIUzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:55:46 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8455 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751353AbWAIUzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:55:45 -0500
Date: Mon, 9 Jan 2006 21:55:20 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Drop vmlinux dependency from "make install"
Message-ID: <20060109205520.GA13489@mars.ravnborg.org>
References: <43C06420.1080300@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C06420.1080300@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 05:00:16PM -0800, H. Peter Anvin wrote:

> [i386, x86_64] Remove the dependency vmlinux -> install
> 
> This removes the dependency from vmlinux to install, thus avoiding the
> current situation where "make install" has a nasty tendency to leave
> root-turds in the working directory.
> 
> It also updates x86-64 to be in sync with i386.
> 
> Signed-off-by: H. Peter Anvin <hpa@zytor.com>

I have applied the following patch.
It is take 2 edited a bit by me.

	Sam


diff-tree 0d20babd86b40fa5ac55d9ebf31d05f6f7082161 (from 63b794bfd898899cc8b6d4679d4fdc486606194b)
Author: H. Peter Anvin <hpa@zytor.com>
Date:   Sat Jan 7 17:38:39 2006 -0800

    kbuild: drop vmlinux dependency from "make install"
    
    This removes the dependency from vmlinux to install, thus avoiding the
    current situation where "make install" has a nasty tendency to leave
    root-turds in the working directory.
    
    It also updates x86-64 to be in sync with i386.
    
    Signed-off-by: H. Peter Anvin <hpa@zytor.com>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index 8f6b90e..d3c0409 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -101,11 +101,11 @@ CFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
 
 boot := arch/i386/boot
 
 .PHONY: zImage bzImage compressed zlilo bzlilo \
-	zdisk bzdisk fdimage fdimage144 fdimage288 install kernel_install
+	zdisk bzdisk fdimage fdimage144 fdimage288 install
 
 all: bzImage
 
 # KBUILD_IMAGE specify target image being built
                     KBUILD_IMAGE := $(boot)/bzImage
@@ -123,12 +123,11 @@ zdisk bzdisk: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) zdisk
 
 fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
 
-install: vmlinux
-install kernel_install:
+install:
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
 
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/i386/boot
 
diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
index 1e71382..0fea75d 100644
--- a/arch/i386/boot/Makefile
+++ b/arch/i386/boot/Makefile
@@ -98,7 +98,7 @@ zlilo: $(BOOTIMAGE)
 	if [ -f $(INSTALL_PATH)/System.map ]; then mv $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi
 	cat $(BOOTIMAGE) > $(INSTALL_PATH)/vmlinuz
 	cp System.map $(INSTALL_PATH)/
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
-install: $(BOOTIMAGE)
+install:
 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"
diff --git a/arch/i386/boot/install.sh b/arch/i386/boot/install.sh
index f17b40d..5e44c73 100644
--- a/arch/i386/boot/install.sh
+++ b/arch/i386/boot/install.sh
@@ -17,10 +17,24 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 #
 
+verify () {
+	if [ ! -f "$1" ]; then
+		echo ""                                                   1>&2
+		echo " *** Missing file: $1"                              1>&2
+		echo ' *** You need to run "make" before "make install".' 1>&2
+		echo ""                                                   1>&2
+		exit 1
+ 	fi
+}
+
+# Make sure the files actually exist
+verify "$2"
+verify "$3"
+
 # User may have a custom install script
 
 if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
 if [ -x /sbin/${CROSS_COMPILE}installkernel ]; then exec /sbin/${CROSS_COMPILE}installkernel "$@"; fi
 
diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
index a9cd42e..51d8328 100644
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -78,13 +78,16 @@ bzlilo: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zlilo
 
 bzdisk: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zdisk
 
-install fdimage fdimage144 fdimage288: vmlinux
+fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
 
+install:
+	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@ 
+
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
 define archhelp
   echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
diff --git a/arch/x86_64/boot/Makefile b/arch/x86_64/boot/Makefile
index 18c6e91..29f8396 100644
--- a/arch/x86_64/boot/Makefile
+++ b/arch/x86_64/boot/Makefile
@@ -96,7 +96,7 @@ zlilo: $(BOOTIMAGE)
 	if [ -f $(INSTALL_PATH)/System.map ]; then mv $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi
 	cat $(BOOTIMAGE) > $(INSTALL_PATH)/vmlinuz
 	cp System.map $(INSTALL_PATH)/
 	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
 
-install: $(BOOTIMAGE)
+install:
 	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
diff --git a/arch/x86_64/boot/install.sh b/arch/x86_64/boot/install.sh
index 198af15..baaa236 100644
--- a/arch/x86_64/boot/install.sh
+++ b/arch/x86_64/boot/install.sh
@@ -1,40 +1,2 @@
 #!/bin/sh
-#
-# arch/x86_64/boot/install.sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-#
-# "make install" script for i386 architecture
-#
-# Arguments:
-#   $1 - kernel version
-#   $2 - kernel image file
-#   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
-#
-
-# User may have a custom install script
-
-if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
-if [ -x /sbin/${CROSS_COMPILE}installkernel ]; then exec /sbin/${CROSS_COMPILE}installkernel "$@"; fi
-
-# Default install - same as make zlilo
-
-if [ -f $4/vmlinuz ]; then
-	mv $4/vmlinuz $4/vmlinuz.old
-fi
-
-if [ -f $4/System.map ]; then
-	mv $4/System.map $4/System.old
-fi
-
-cat $2 > $4/vmlinuz
-cp $3 $4/System.map
-
-if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
+. $srctree/arch/i386/boot/install.sh

> 
> diff --git a/arch/i386/Makefile b/arch/i386/Makefile
> index d121ea1..77bb67b 100644
> --- a/arch/i386/Makefile
> +++ b/arch/i386/Makefile
> @@ -125,7 +125,6 @@ zdisk bzdisk: vmlinux
>  fdimage fdimage144 fdimage288: vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
>  
> -install: vmlinux
>  install kernel_install:
>  	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) install
>  
> diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
> index 1e71382..0fea75d 100644
> --- a/arch/i386/boot/Makefile
> +++ b/arch/i386/boot/Makefile
> @@ -100,5 +100,5 @@ zlilo: $(BOOTIMAGE)
>  	cp System.map $(INSTALL_PATH)/
>  	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
>  
> -install: $(BOOTIMAGE)
> +install:
>  	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"
> diff --git a/arch/i386/boot/install.sh b/arch/i386/boot/install.sh
> index f17b40d..ee336cb 100644
> --- a/arch/i386/boot/install.sh
> +++ b/arch/i386/boot/install.sh
> @@ -19,6 +19,17 @@
>  #   $4 - default install path (blank if root directory)
>  #
>  
> +verify () {
> +	if [ ! -f "$1" ]; then
> +		echo "Missing file: $1" 1>&2
> +		exit 1
> + 	fi
> +}
> +
> +# Make sure the files actually exist
> +verify "$2"
> +verify "$3"
> +
>  # User may have a custom install script
>  
>  if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi
> diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
> index a9cd42e..1d6e735 100644
> --- a/arch/x86_64/Makefile
> +++ b/arch/x86_64/Makefile
> @@ -80,9 +80,12 @@ bzlilo: vmlinux
>  bzdisk: vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zdisk
>  
> -install fdimage fdimage144 fdimage288: vmlinux
> +fdimage fdimage144 fdimage288: vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
>  
> +install kernel_install:
> +	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) install
> +
>  archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
>  
> diff --git a/arch/x86_64/boot/Makefile b/arch/x86_64/boot/Makefile
> index 18c6e91..29f8396 100644
> --- a/arch/x86_64/boot/Makefile
> +++ b/arch/x86_64/boot/Makefile
> @@ -98,5 +98,5 @@ zlilo: $(BOOTIMAGE)
>  	cp System.map $(INSTALL_PATH)/
>  	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
>  
> -install: $(BOOTIMAGE)
> +install:
>  	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(BOOTIMAGE) System.map "$(INSTALL_PATH)"
> diff --git a/arch/x86_64/boot/install.sh b/arch/x86_64/boot/install.sh
> index 198af15..1f87544 100644
> --- a/arch/x86_64/boot/install.sh
> +++ b/arch/x86_64/boot/install.sh
> @@ -19,6 +19,17 @@
>  #   $4 - default install path (blank if root directory)
>  #
>  
> +verify () {
> +	if [ ! -f "$1" ]; then
> +		echo "Missing file: $1" 1>&2
> +		exit 1
> + 	fi
> +}
> +
> +# Make sure the files actually exist
> +verify "$2"
> +verify "$3"
> +
>  # User may have a custom install script
>  
>  if [ -x ~/bin/${CROSS_COMPILE}installkernel ]; then exec ~/bin/${CROSS_COMPILE}installkernel "$@"; fi

