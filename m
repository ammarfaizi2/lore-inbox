Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312134AbSDCQI4>; Wed, 3 Apr 2002 11:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312146AbSDCQIq>; Wed, 3 Apr 2002 11:08:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29492 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312134AbSDCQIe>; Wed, 3 Apr 2002 11:08:34 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 Boot enhancements, vmlinux.lds 2/9
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Apr 2002 09:02:07 -0700
Message-ID: <m1adsku5xc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please apply.

This patch corrects the vmlinux so it correctly reports the physical
load address of the kernel at 1MB, and the actual kernel entry point.
This is done with a small change to the linker script and removal of
the incorrect command line linker entry point specification.

Eric


diff -uNr linux-2.5.7.boot2.boot_params/arch/i386/Makefile linux-2.5.7.boot2.vmlinuxlds/arch/i386/Makefile
--- linux-2.5.7.boot2.boot_params/arch/i386/Makefile	Thu Apr 12 13:20:31 2001
+++ linux-2.5.7.boot2.vmlinuxlds/arch/i386/Makefile	Tue Apr  2 11:44:16 2002
@@ -18,7 +18,7 @@
 
 LD=$(CROSS_COMPILE)ld -m elf_i386
 OBJCOPY=$(CROSS_COMPILE)objcopy -O binary -R .note -R .comment -S
-LDFLAGS=-e stext
+LDFLAGS=
 LINKFLAGS =-T $(TOPDIR)/arch/i386/vmlinux.lds $(LDFLAGS)
 
 CFLAGS += -pipe
diff -uNr linux-2.5.7.boot2.boot_params/arch/i386/vmlinux.lds linux-2.5.7.boot2.vmlinuxlds/arch/i386/vmlinux.lds
--- linux-2.5.7.boot2.boot_params/arch/i386/vmlinux.lds	Sun Mar 10 20:09:08 2002
+++ linux-2.5.7.boot2.vmlinuxlds/arch/i386/vmlinux.lds	Tue Apr  2 11:44:16 2002
@@ -3,7 +3,13 @@
  */
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
-ENTRY(_start)
+physical_startup_32 = startup_32 - 0xC0000000;
+ENTRY(physical_startup_32)
+PHDRS
+{
+	text PT_LOAD AT(0x100000);
+
+}
 SECTIONS
 {
   . = 0xC0000000 + 0x100000;
@@ -12,7 +18,7 @@
 	*(.text)
 	*(.fixup)
 	*(.gnu.warning)
-	} = 0x9090
+	} :text = 0x9090
 
   _etext = .;			/* End of text section */
 
