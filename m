Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264322AbUEDMBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbUEDMBf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 08:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264318AbUEDMBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 08:01:35 -0400
Received: from ozlabs.org ([203.10.76.45]:25494 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264316AbUEDMBb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 08:01:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16535.34322.714345.393951@cargo.ozlabs.ibm.com>
Date: Tue, 4 May 2004 22:01:22 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org, trini@kernel.crashing.org, olh@suse.de,
       linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Updated boot fix
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes booting on some PPC32 machines, notably CHRP and
powermac machines.  This is a modified version of Tom Rini's patch
that addresses the concerns I had with it.

The problem was that the linker script was getting included in the
list of things that got put together to make some of the sorts of
bootable images that we produce.  This removes ld.script in cases
where it wasn't appropriate and changes the rules in others so that
although we have the dependency on ld.script, it doesn't get included
in the list of things to link.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc/boot/openfirmware/Makefile pmac-2.5/arch/ppc/boot/openfirmware/Makefile
--- linux-2.5/arch/ppc/boot/openfirmware/Makefile	2004-04-28 07:31:34.000000000 +1000
+++ pmac-2.5/arch/ppc/boot/openfirmware/Makefile	2004-05-04 13:46:36.000000000 +1000
@@ -89,13 +89,14 @@
 	$(call if_changed_dep,as_o_S)
 
 quiet_cmd_gencoffb = COFF    $@
-      cmd_gencoffb = $(LD) -o $@ $(COFF_LD_ARGS) $(filter-out FORCE,$^) && \
+      cmd_gencoffb = $(LD) -o $@ $(COFF_LD_ARGS) $(COFFOBJS) $< $(LIBS) && \
                      $(OBJCOPY) $@ $@ -R .comment $(del-ramdisk-sec)
 targets += coffboot
-$(obj)/coffboot: $(COFFOBJS) $(obj)/image.o $(LIBS) FORCE
+$(obj)/coffboot: $(obj)/image.o $(COFFOBJS) $(LIBS) $(boot)/ld.script FORCE
 	$(call if_changed,gencoffb)
 targets += coffboot.initrd
-$(obj)/coffboot.initrd: $(COFFOBJS) $(obj)/image.initrd.o $(LIBS) FORCE
+$(obj)/coffboot.initrd: $(obj)/image.initrd.o $(COFFOBJS) $(LIBS) \
+			$(boot)/ld.script FORCE
 	$(call if_changed,gencoffb)
 
 
@@ -104,10 +105,10 @@
 			$(HACKCOFF) $@ && \
 			ln -sf $(notdir $@) $(images)/zImage$(initrd).pmac
 
-$(images)/vmlinux.coff: $(obj)/coffboot $(boot)/ld.script
+$(images)/vmlinux.coff: $(obj)/coffboot
 	$(call cmd,gen-coff)
 
-$(images)/vmlinux.initrd.coff: $(obj)/coffboot.initrd $(boot)/ld.script
+$(images)/vmlinux.initrd.coff: $(obj)/coffboot.initrd
 	$(call cmd,gen-coff)
 
 quiet_cmd_gen-elf-pmac = ELF     $@
@@ -116,19 +117,21 @@
 			$(OBJCOPY) $@ $@ --add-section=.note=$(obj)/note \
 					 -R .comment $(del-ramdisk-sec)
 
-$(images)/vmlinux.elf-pmac: $(obj)/image.o $(NEWWORLDOBJS) $(LIBS) $(obj)/note $(boot)/ld.script
+$(images)/vmlinux.elf-pmac: $(obj)/image.o $(NEWWORLDOBJS) $(LIBS) \
+			$(obj)/note $(boot)/ld.script
 	$(call cmd,gen-elf-pmac)
 $(images)/vmlinux.initrd.elf-pmac: $(obj)/image.initrd.o $(NEWWORLDOBJS) \
 				   $(LIBS) $(obj)/note $(boot)/ld.script
 	$(call cmd,gen-elf-pmac)
 
 quiet_cmd_gen-chrp = CHRP    $@
-      cmd_gen-chrp = $(LD) $(CHRP_LD_ARGS) -o $@ $^ && \
+      cmd_gen-chrp = $(LD) $(CHRP_LD_ARGS) -o $@ $(CHRPOBJS) $< $(LIBS) && \
 			$(OBJCOPY) $@ $@ -R .comment $(del-ramdisk-sec)
 
-$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS) $(boot)/ld.script
+$(images)/zImage.chrp: $(obj)/image.o $(CHRPOBJS) $(LIBS) $(boot)/ld.script
 	$(call cmd,gen-chrp)
-$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS) $(boot)/ld.script
+$(images)/zImage.initrd.chrp: $(obj)/image.initrd.o $(CHRPOBJS) $(LIBS) \
+			$(boot)/ld.script
 	$(call cmd,gen-chrp)
 
 quiet_cmd_addnote = ADDNOTE $@
