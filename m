Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314512AbSEBOxq>; Thu, 2 May 2002 10:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314504AbSEBOxp>; Thu, 2 May 2002 10:53:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9833 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314499AbSEBOxn>; Thu, 2 May 2002 10:53:43 -0400
To: Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.12] x86 Boot enhancements, linker fixes 2/11
In-Reply-To: <m11ycuzk4q.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 May 2002 08:45:51 -0600
Message-ID: <m1wuumy5eo.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uNr linux-2.5.12.boot.boot_params/arch/i386/Makefile linux-2.5.12.boot.vmlinuxlds/arch/i386/Makefile
--- linux-2.5.12.boot.boot_params/arch/i386/Makefile	Thu Apr 12 13:20:31 2001
+++ linux-2.5.12.boot.vmlinuxlds/arch/i386/Makefile	Wed May  1 09:38:47 2002
@@ -18,7 +18,7 @@
 
 LD=$(CROSS_COMPILE)ld -m elf_i386
 OBJCOPY=$(CROSS_COMPILE)objcopy -O binary -R .note -R .comment -S
-LDFLAGS=-e stext
+LDFLAGS=
 LINKFLAGS =-T $(TOPDIR)/arch/i386/vmlinux.lds $(LDFLAGS)
 
 CFLAGS += -pipe
diff -uNr linux-2.5.12.boot.boot_params/arch/i386/kernel/head.S linux-2.5.12.boot.vmlinuxlds/arch/i386/kernel/head.S
--- linux-2.5.12.boot.boot_params/arch/i386/kernel/head.S	Mon Apr 29 00:17:11 2002
+++ linux-2.5.12.boot.vmlinuxlds/arch/i386/kernel/head.S	Wed May  1 09:38:47 2002
@@ -41,7 +41,7 @@
  *
  * On entry, %esi points to the real-mode code as a 32-bit pointer.
  */
-startup_32:
+ENTRY(startup_32)
 /*
  * Set segments to known values
  */
diff -uNr linux-2.5.12.boot.boot_params/arch/i386/vmlinux.lds linux-2.5.12.boot.vmlinuxlds/arch/i386/vmlinux.lds
--- linux-2.5.12.boot.boot_params/arch/i386/vmlinux.lds	Sun Mar 10 20:09:08 2002
+++ linux-2.5.12.boot.vmlinuxlds/arch/i386/vmlinux.lds	Wed May  1 09:38:47 2002
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
 
@@ -73,8 +79,16 @@
   __bss_start = .;		/* BSS */
   .bss : {
 	*(.bss)
+        _end = . ;
+	/* Reserve space for the bootmem bitmap,
+	 * With a start at 0xC0000000 this is just 32k in the worst case.
+	 *
+	 * Ideally this would be in an initdata segment but that causes
+	 * problems with memory being reserved twice.
+	 */
+	. = ALIGN(4096);
+	. = . + 32768;
 	}
-  _end = . ;
 
   /* Sections to be discarded */
   /DISCARD/ : {
