Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310214AbSDQQ4h>; Wed, 17 Apr 2002 12:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310241AbSDQQ4g>; Wed, 17 Apr 2002 12:56:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15694 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310214AbSDQQ4g>; Wed, 17 Apr 2002 12:56:36 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 boot enhancements, link enhancements 2/11
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Apr 2002 10:49:19 -0600
Message-ID: <m14riai834.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#2  2.5.8.boot.vmlinuxlds
============================================================
- i386/Makefile remove bogus linker command line of -e stext
- Fix vmlinux.lds so vmlinux knows it loads at 0x100000 (1MB)
- Fix vmlinux.lds so we correctly use startup_32 for our entry point
- Make startup_32 global


diff -uNr linux-2.5.8.boot.boot_params/arch/i386/Makefile linux-2.5.8.boot.vmlinuxlds/arch/i386/Makefile
--- linux-2.5.8.boot.boot_params/arch/i386/Makefile	Thu Apr 12 13:20:31 2001
+++ linux-2.5.8.boot.vmlinuxlds/arch/i386/Makefile	Tue Apr 16 12:14:31 2002
@@ -18,7 +18,7 @@
 
 LD=$(CROSS_COMPILE)ld -m elf_i386
 OBJCOPY=$(CROSS_COMPILE)objcopy -O binary -R .note -R .comment -S
-LDFLAGS=-e stext
+LDFLAGS=
 LINKFLAGS =-T $(TOPDIR)/arch/i386/vmlinux.lds $(LDFLAGS)
 
 CFLAGS += -pipe
diff -uNr linux-2.5.8.boot.boot_params/arch/i386/kernel/head.S linux-2.5.8.boot.vmlinuxlds/arch/i386/kernel/head.S
--- linux-2.5.8.boot.boot_params/arch/i386/kernel/head.S	Wed Mar 20 07:18:31 2002
+++ linux-2.5.8.boot.vmlinuxlds/arch/i386/kernel/head.S	Tue Apr 16 12:14:31 2002
@@ -41,7 +41,7 @@
  *
  * On entry, %esi points to the real-mode code as a 32-bit pointer.
  */
-startup_32:
+ENTRY(startup_32)
 /*
  * Set segments to known values
  */
diff -uNr linux-2.5.8.boot.boot_params/arch/i386/vmlinux.lds linux-2.5.8.boot.vmlinuxlds/arch/i386/vmlinux.lds
--- linux-2.5.8.boot.boot_params/arch/i386/vmlinux.lds	Sun Mar 10 20:09:08 2002
+++ linux-2.5.8.boot.vmlinuxlds/arch/i386/vmlinux.lds	Tue Apr 16 12:14:31 2002
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
 
