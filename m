Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263809AbUECSKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbUECSKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUECSKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:10:12 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:26361 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S263809AbUECSJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:09:46 -0400
Date: Mon, 3 May 2004 11:09:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>, olh@suse.de,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Fix booting some PPC32 machines
Message-ID: <20040503180945.GL26773@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  The following patch fixes booting on some PPC32 machines with
OpenFirmware, when booted without the aid of an additional bootloader.
The problem is that the linker script for the 'zImage' type targets was
put into the list of dependancies which objcopy would parse as a list of
files to copy into the resulting image.  The fix is to make the phony
zImage targets depend on the linker script.

===== arch/ppc/boot/openfirmware/Makefile 1.22 vs edited =====
--- 1.22/arch/ppc/boot/openfirmware/Makefile	Thu Apr  1 08:16:57 2004
+++ edited/arch/ppc/boot/openfirmware/Makefile	Mon May  3 10:24:35 2004
@@ -104,10 +104,10 @@
 			$(HACKCOFF) $@ && \
 			ln -sf $(notdir $@) $(images)/zImage$(initrd).pmac
 
-$(images)/vmlinux.coff: $(obj)/coffboot $(boot)/ld.script
+$(images)/vmlinux.coff: $(obj)/coffboot
 	$(call cmd,gen-coff)
 
-$(images)/vmlinux.initrd.coff: $(obj)/coffboot.initrd $(boot)/ld.script
+$(images)/vmlinux.initrd.coff: $(obj)/coffboot.initrd
 	$(call cmd,gen-coff)
 
 quiet_cmd_gen-elf-pmac = ELF     $@
@@ -116,19 +116,19 @@
 			$(OBJCOPY) $@ $@ --add-section=.note=$(obj)/note \
 					 -R .comment $(del-ramdisk-sec)
 
-$(images)/vmlinux.elf-pmac: $(obj)/image.o $(NEWWORLDOBJS) $(LIBS) $(obj)/note $(boot)/ld.script
+$(images)/vmlinux.elf-pmac: $(obj)/image.o $(NEWWORLDOBJS) $(LIBS) $(obj)/note
 	$(call cmd,gen-elf-pmac)
 $(images)/vmlinux.initrd.elf-pmac: $(obj)/image.initrd.o $(NEWWORLDOBJS) \
-				   $(LIBS) $(obj)/note $(boot)/ld.script
+				   $(LIBS) $(obj)/note
 	$(call cmd,gen-elf-pmac)
 
 quiet_cmd_gen-chrp = CHRP    $@
       cmd_gen-chrp = $(LD) $(CHRP_LD_ARGS) -o $@ $^ && \
 			$(OBJCOPY) $@ $@ -R .comment $(del-ramdisk-sec)
 
-$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS) $(boot)/ld.script
+$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS)
 	$(call cmd,gen-chrp)
-$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS) $(boot)/ld.script
+$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS)
 	$(call cmd,gen-chrp)
 
 quiet_cmd_addnote = ADDNOTE $@
@@ -153,13 +153,15 @@
 		 $(images)/vmlinux.elf-pmac	\
 		 $(images)/zImage.chrp		\
 		 $(images)/zImage.chrp-rs6k	\
-		 $(images)/miboot.image
+		 $(images)/miboot.image		\
+		 $(boot)/ld.script
 	@echo '  kernel: $@ is ready ($<)'
 zImage.initrd:	 $(images)/vmlinux.initrd.coff 		\
 		 $(images)/vmlinux.initrd.elf-pmac	\
 		 $(images)/zImage.initrd.chrp		\
 		 $(images)/zImage.initrd.chrp-rs6k	\
-		 $(images)/miboot.initrd.image
+		 $(images)/miboot.initrd.image		\
+		 $(boot)/ld.script
 	@echo '  kernel: $@ is ready ($<)'
 
 TFTPIMAGE	:= /tftpboot/zImage

-- 
Tom Rini
http://gate.crashing.org/~trini/
