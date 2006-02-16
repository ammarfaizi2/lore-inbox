Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWBPW0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWBPW0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWBPW0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:26:39 -0500
Received: from terminus.zytor.com ([192.83.249.54]:22937 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750743AbWBPW0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:26:38 -0500
Message-ID: <43F4FC0B.7040109@zytor.com>
Date: Thu, 16 Feb 2006 14:26:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] "make isoimage" support; FDINITRD= support; minor cleanups
Content-Type: multipart/mixed;
 boundary="------------050108030401060503060702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050108030401060503060702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------050108030401060503060702
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

"make isoimage" support; FDINITRD= support; minor cleanups

This patch adds a "make isoimage" to i386 and x86-64, which allows the
automatic creation of a bootable CD image.  It also adds an option
FDINITRD= to include an initrd of the user's choice in generated floppy-
or CD boot images.  Finally, some minor cleanups of the image generation
code.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

 arch/i386/Makefile        |    9 ++++++---
 arch/i386/boot/Makefile   |   36 ++++++++++++++++++++++++++++++++----
 arch/x86_64/Makefile      |   17 +++++++++++------
 arch/x86_64/boot/Makefile |   36 ++++++++++++++++++++++++++++++++----
 4 files changed, 81 insertions(+), 17 deletions(-)

diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index 36bef65..efb32be 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -100,7 +100,7 @@ AFLAGS += $(mflags-y)
 boot := arch/i386/boot
 
 .PHONY: zImage bzImage compressed zlilo bzlilo \
-	zdisk bzdisk fdimage fdimage144 fdimage288 install
+	zdisk bzdisk fdimage fdimage144 fdimage288 isoimage install
 
 all: bzImage
 
@@ -119,7 +119,7 @@ zlilo bzlilo: vmlinux
 zdisk bzdisk: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) zdisk
 
-fdimage fdimage144 fdimage288: vmlinux
+fdimage fdimage144 fdimage288 isoimage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
 
 install:
@@ -136,6 +136,9 @@ define archhelp
   echo  '		   install to $$(INSTALL_PATH) and run lilo'
   echo  '  bzdisk       - Create a boot floppy in /dev/fd0'
   echo  '  fdimage      - Create a boot floppy image'
+  echo  '  isoimage     - Create a boot CD-ROM image'
 endef
 
-CLEAN_FILES += arch/$(ARCH)/boot/fdimage arch/$(ARCH)/boot/mtools.conf
+CLEAN_FILES += arch/$(ARCH)/boot/fdimage \
+	       arch/$(ARCH)/boot/image.iso \
+	       arch/$(ARCH)/boot/mtools.conf
diff --git a/arch/i386/boot/Makefile b/arch/i386/boot/Makefile
index f136752..33e5547 100644
--- a/arch/i386/boot/Makefile
+++ b/arch/i386/boot/Makefile
@@ -62,8 +62,12 @@ $(obj)/setup $(obj)/bootsect: %: %.o FOR
 $(obj)/compressed/vmlinux: FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed IMAGE_OFFSET=$(IMAGE_OFFSET) $@
 
-# Set this if you want to pass append arguments to the zdisk/fdimage kernel
+# Set this if you want to pass append arguments to the zdisk/fdimage/isoimage kernel
 FDARGS = 
+# Set this if you want an initrd included with the zdisk/fdimage/isoimage kernel
+FDINITRD =
+
+image_cmdline = default linux $(FDARGS) $(if $(FDINITRD),initrd=initrd.img,)
 
 $(obj)/mtools.conf: $(src)/mtools.conf.in
 	sed -e 's|@OBJ@|$(obj)|g' < $< > $@
@@ -72,8 +76,11 @@ $(obj)/mtools.conf: $(src)/mtools.conf.i
 zdisk: $(BOOTIMAGE) $(obj)/mtools.conf
 	MTOOLSRC=$(obj)/mtools.conf mformat a:			; sync
 	syslinux /dev/fd0					; sync
-	echo 'default linux $(FDARGS)' | \
+	echo '$(image_cmdline)' | \
 		MTOOLSRC=$(src)/mtools.conf mcopy - a:syslinux.cfg
+	if [ -f '$(FDINITRD)' ] ; then \
+		MTOOLSRC=$(obj)/mtools.conf mcopy '$(FDINITRD)' a:initrd.img ; \
+	fi
 	MTOOLSRC=$(obj)/mtools.conf mcopy $(BOOTIMAGE) a:linux	; sync
 
 # These require being root or having syslinux 2.02 or higher installed
@@ -81,18 +88,39 @@ fdimage fdimage144: $(BOOTIMAGE) $(obj)/
 	dd if=/dev/zero of=$(obj)/fdimage bs=1024 count=1440
 	MTOOLSRC=$(obj)/mtools.conf mformat v:			; sync
 	syslinux $(obj)/fdimage					; sync
-	echo 'default linux $(FDARGS)' | \
+	echo '$(image_cmdline)' | \
 		MTOOLSRC=$(obj)/mtools.conf mcopy - v:syslinux.cfg
+	if [ -f '$(FDINITRD)' ] ; then \
+		MTOOLSRC=$(obj)/mtools.conf mcopy '$(FDINITRD)' v:initrd.img ; \
+	fi
 	MTOOLSRC=$(obj)/mtools.conf mcopy $(BOOTIMAGE) v:linux	; sync
 
 fdimage288: $(BOOTIMAGE) $(obj)/mtools.conf
 	dd if=/dev/zero of=$(obj)/fdimage bs=1024 count=2880
 	MTOOLSRC=$(obj)/mtools.conf mformat w:			; sync
 	syslinux $(obj)/fdimage					; sync
-	echo 'default linux $(FDARGS)' | \
+	echo '$(image_cmdline)' | \
 		MTOOLSRC=$(obj)/mtools.conf mcopy - w:syslinux.cfg
+	if [ -f '$(FDINITRD)' ] ; then \
+		MTOOLSRC=$(obj)/mtools.conf mcopy '$(FDINITRD)' w:initrd.img ; \
+	fi
 	MTOOLSRC=$(obj)/mtools.conf mcopy $(BOOTIMAGE) w:linux	; sync
 
+isoimage: $(BOOTIMAGE)
+	-rm -rf $(obj)/isoimage
+	mkdir $(obj)/isoimage
+	cp `echo /usr/lib*/syslinux/isolinux.bin | awk '{ print $1; }'` \
+		$(obj)/isoimage
+	cp $(BOOTIMAGE) $(obj)/isoimage/linux
+	echo '$(image_cmdline)' > $(obj)/isoimage/isolinux.cfg
+	if [ -f '$(FDINITRD)' ] ; then \
+		cp '$(FDINITRD)' $(obj)/isoimage/initrd.img ; \
+	fi
+	mkisofs -J -r -o $(obj)/image.iso -b isolinux.bin -c boot.cat \
+		-no-emul-boot -boot-load-size 4 -boot-info-table \
+		$(obj)/isoimage
+	rm -rf $(obj)/isoimage
+
 zlilo: $(BOOTIMAGE)
 	if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
 	if [ -f $(INSTALL_PATH)/System.map ]; then mv $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi
diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
index d7fd464..a1857e4 100644
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -68,7 +68,7 @@ drivers-$(CONFIG_OPROFILE)		+= arch/x86_
 boot := arch/x86_64/boot
 
 .PHONY: bzImage bzlilo install archmrproper \
-	fdimage fdimage144 fdimage288 archclean
+	fdimage fdimage144 fdimage288 isoimage archclean
 
 #Default target when executing "make"
 all: bzImage
@@ -85,7 +85,7 @@ bzlilo: vmlinux
 bzdisk: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) zdisk
 
-fdimage fdimage144 fdimage288: vmlinux
+fdimage fdimage144 fdimage288 isoimage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(BOOTIMAGE) $@
 
 install:
@@ -97,11 +97,16 @@ archclean:
 define archhelp
   echo  '* bzImage	- Compressed kernel image (arch/$(ARCH)/boot/bzImage)'
   echo  '  install	- Install kernel using'
-  echo  '                  (your) ~/bin/installkernel or'
-  echo  '                  (distribution) /sbin/installkernel or'
-  echo  '        	  install to $$(INSTALL_PATH) and run lilo'
+  echo  '		   (your) ~/bin/installkernel or'
+  echo  '		   (distribution) /sbin/installkernel or'
+  echo  '		   install to $$(INSTALL_PATH) and run lilo'
+  echo  '  bzdisk       - Create a boot floppy in /dev/fd0'
+  echo  '  fdimage      - Create a boot floppy image'
+  echo  '  isoimage     - Create a boot CD-ROM image'
 endef
 
-CLEAN_FILES += arch/$(ARCH)/boot/fdimage arch/$(ARCH)/boot/mtools.conf
+CLEAN_FILES += arch/$(ARCH)/boot/fdimage \
+	       arch/$(ARCH)/boot/image.iso \
+	       arch/$(ARCH)/boot/mtools.conf
 
 
diff --git a/arch/x86_64/boot/Makefile b/arch/x86_64/boot/Makefile
index 29f8396..43ee6c5 100644
--- a/arch/x86_64/boot/Makefile
+++ b/arch/x86_64/boot/Makefile
@@ -60,8 +60,12 @@ $(obj)/setup $(obj)/bootsect: %: %.o FOR
 $(obj)/compressed/vmlinux: FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed IMAGE_OFFSET=$(IMAGE_OFFSET) $@
 
-# Set this if you want to pass append arguments to the zdisk/fdimage kernel
+# Set this if you want to pass append arguments to the zdisk/fdimage/isoimage kernel
 FDARGS = 
+# Set this if you want an initrd included with the zdisk/fdimage/isoimage kernel
+FDINITRD =
+
+image_cmdline = default linux $(FDARGS) $(if $(FDINITRD),initrd=initrd.img,)
 
 $(obj)/mtools.conf: $(src)/mtools.conf.in
 	sed -e 's|@OBJ@|$(obj)|g' < $< > $@
@@ -70,8 +74,11 @@ $(obj)/mtools.conf: $(src)/mtools.conf.i
 zdisk: $(BOOTIMAGE) $(obj)/mtools.conf
 	MTOOLSRC=$(obj)/mtools.conf mformat a:			; sync
 	syslinux /dev/fd0					; sync
-	echo 'default linux $(FDARGS)' | \
+	echo '$(image_cmdline)' | \
 		MTOOLSRC=$(obj)/mtools.conf mcopy - a:syslinux.cfg
+	if [ -f '$(FDINITRD)' ] ; then \
+		MTOOLSRC=$(obj)/mtools.conf mcopy '$(FDINITRD)' a:initrd.img ; \
+	fi
 	MTOOLSRC=$(obj)/mtools.conf mcopy $(BOOTIMAGE) a:linux	; sync
 
 # These require being root or having syslinux 2.02 or higher installed
@@ -79,18 +86,39 @@ fdimage fdimage144: $(BOOTIMAGE) $(obj)/
 	dd if=/dev/zero of=$(obj)/fdimage bs=1024 count=1440
 	MTOOLSRC=$(obj)/mtools.conf mformat v:			; sync
 	syslinux $(obj)/fdimage					; sync
-	echo 'default linux $(FDARGS)' | \
+	echo '$(image_cmdline)' | \
 		MTOOLSRC=$(obj)/mtools.conf mcopy - v:syslinux.cfg
+	if [ -f '$(FDINITRD)' ] ; then \
+		MTOOLSRC=$(obj)/mtools.conf mcopy '$(FDINITRD)' v:initrd.img ; \
+	fi
 	MTOOLSRC=$(obj)/mtools.conf mcopy $(BOOTIMAGE) v:linux	; sync
 
 fdimage288: $(BOOTIMAGE) $(obj)/mtools.conf
 	dd if=/dev/zero of=$(obj)/fdimage bs=1024 count=2880
 	MTOOLSRC=$(obj)/mtools.conf mformat w:			; sync
 	syslinux $(obj)/fdimage					; sync
-	echo 'default linux $(FDARGS)' | \
+	echo '$(image_cmdline)' | \
 		MTOOLSRC=$(obj)/mtools.conf mcopy - w:syslinux.cfg
+	if [ -f '$(FDINITRD)' ] ; then \
+		MTOOLSRC=$(obj)/mtools.conf mcopy '$(FDINITRD)' w:initrd.img ; \
+	fi
 	MTOOLSRC=$(obj)/mtools.conf mcopy $(BOOTIMAGE) w:linux	; sync
 
+isoimage: $(BOOTIMAGE)
+	-rm -rf $(obj)/isoimage
+	mkdir $(obj)/isoimage
+	cp `echo /usr/lib*/syslinux/isolinux.bin | awk '{ print $1; }'` \
+		$(obj)/isoimage
+	cp $(BOOTIMAGE) $(obj)/isoimage/linux
+	echo '$(image_cmdline)' > $(obj)/isoimage/isolinux.cfg
+	if [ -f '$(FDINITRD)' ] ; then \
+		cp '$(FDINITRD)' $(obj)/isoimage/initrd.img ; \
+	fi
+	mkisofs -J -r -o $(obj)/image.iso -b isolinux.bin -c boot.cat \
+		-no-emul-boot -boot-load-size 4 -boot-info-table \
+		$(obj)/isoimage
+	rm -rf $(obj)/isoimage
+
 zlilo: $(BOOTIMAGE)
 	if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
 	if [ -f $(INSTALL_PATH)/System.map ]; then mv $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi

--------------050108030401060503060702--
