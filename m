Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263108AbSJFCEb>; Sat, 5 Oct 2002 22:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263110AbSJFCEb>; Sat, 5 Oct 2002 22:04:31 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:18588 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S263108AbSJFCEa>; Sat, 5 Oct 2002 22:04:30 -0400
Date: Sat, 5 Oct 2002 21:10:06 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: linux-kernel@vger.kernel.org
Subject: kbuild news
Message-ID: <Pine.LNX.4.44.0210052048130.13557-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi arch maintainers,

I submitted a kbuild update to Linus which has the potential to break 
archs other than i386.

Two changes could affect you:
o the build process, while remaining recursive, does not cd into the 
  subdirs anymore. If you're just using the standard kbuild 
  infrastructure, you should be fine - however, things like
  custom include paths may have to be adapted
  (-I../../drivers/scsi -> -Idrivers/scsi).
  This change should not affect arch/$(ARCH)/boot and other custom stuff.
  However, I converted i386/boot as well, to give an example of how it can
  be done ;)

  If something goes wrong here, you'll most likely get a build failure,
  so you'll notice. The other point is a bit more subtle.

o The final link of vmlinux is now always done as a two step process:
  link a temporary .tmp_vmlinux out of $(HEAD) init/ kernel/ mm/ drivers/
  ... exactly as before. Then, potentially objects which need the
  vmlinux image to exist already are built (currently that would be
  .tmp_kallsyms.o, and possibly sparc's btfix stuff in the future).
  As a last step, the final vmlinux is linked from the .tmp_vmlinux +
  the additional objects that have just been built.

  Even when no kallsyms or other additional objects are built, the final
  vmlinux is now built with

  	ld <usual flags> -T arch/$(ARCH)/vmlinux.lds.s .tmp_vmlinux \
		-o vmlinux

  So you need to be sure that your arch's vmlinux.lds.S does not
  reorder sections in this final step.

  i386 needed the following patch:

--- ../linux-2.5.isdn/arch/i386/vmlinux.lds.S	Fri Oct  4 12:09:10 2002
+++ arch/i386/vmlinux.lds.S	Sat Oct  5 17:21:30 2002
@@ -49,6 +49,7 @@
   __setup_end = .;
   __initcall_start = .;
   .initcall.init : {
+	*(.initcall.init)
 	*(.initcall1.init) 
 	*(.initcall2.init) 
 	*(.initcall3.init) 
@@ -72,7 +73,7 @@
   __nosave_end = .;
 
   . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
+  .data.page_aligned : {  *(.data.page_aligned) *(.data.idt) }
 
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
since after the first link, all the initcalls are in .initcall.init, and
they're supposed to just remain there during the second one, same thing 
for data.page_aligned.

You've been warned, take a look at your vmlinux.lds.S, or just compare
objdump -h .tmp_vmlinux vs objdump -h vmlinux. You don't want to see 
differences there ;)

--Kai




