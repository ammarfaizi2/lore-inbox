Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbULCTzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbULCTzE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbULCTxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:53:36 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:13828
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262470AbULCT1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:27:50 -0500
Message-Id: <200412032143.iB3LhpZW004683@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - small vsyscall fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:43:51 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

As Jeff pointed out, the check for address wrapping in access_ok_skas
was wrong. Also, change vsyscall_ehdr and vsyscall_end to be
unsigned long and export them, since modules need them for access_ok_skas

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -puN arch/um/kernel/skas/include/uaccess-skas.h~fix-vsyscall arch/um/kernel/skas/include/uaccess-skas.h
--- linux-2.6.10-rc2/arch/um/kernel/skas/include/uaccess-skas.h~fix-vsyscall	2004-11-25 16:41:08.466254313 +0100
+++ linux-2.6.10-rc2-root/arch/um/kernel/skas/include/uaccess-skas.h	2004-11-25 16:41:08.478250517 +0100
@@ -14,9 +14,9 @@
 	 (((unsigned long) (addr) < TASK_SIZE) && \
 	  ((unsigned long) (addr) + (size) <= TASK_SIZE)) || \
 	 ((type == VERIFY_READ ) && \
-	  (size <= (FIXADDR_USER_END - FIXADDR_USER_START)) && \
 	  ((unsigned long) (addr) >= FIXADDR_USER_START) && \
-	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END)))
+	  ((unsigned long) (addr) + (size) <= FIXADDR_USER_END) && \
+	  ((unsigned long) (addr) + (size) >= (unsigned long)(addr))))
 
 static inline int verify_area_skas(int type, const void * addr,
 				   unsigned long size)
diff -puN arch/um/os-Linux/elf_aux.c~fix-vsyscall arch/um/os-Linux/elf_aux.c
--- linux-2.6.10-rc2/arch/um/os-Linux/elf_aux.c~fix-vsyscall	2004-11-25 16:41:08.469253364 +0100
+++ linux-2.6.10-rc2-root/arch/um/os-Linux/elf_aux.c	2004-11-25 16:41:08.478250517 +0100
@@ -20,10 +20,10 @@ typedef Elf64_auxv_t elf_auxv_t;
 char * elf_aux_platform;
 long elf_aux_hwcap;
 
-long vsyscall_ehdr;
-long vsyscall_end;
+unsigned long vsyscall_ehdr;
+unsigned long vsyscall_end;
 
-long __kernel_vsyscall;
+unsigned long __kernel_vsyscall;
 
 
 __init void scan_elf_aux( char **envp)
diff -puN arch/um/os-Linux/user_syms.c~fix-vsyscall arch/um/os-Linux/user_syms.c
--- linux-2.6.10-rc2/arch/um/os-Linux/user_syms.c~fix-vsyscall	2004-11-25 16:41:08.471252731 +0100
+++ linux-2.6.10-rc2-root/arch/um/os-Linux/user_syms.c	2004-11-25 16:41:08.478250517 +0100
@@ -26,6 +26,9 @@ EXPORT_SYMBOL(printf);
 
 EXPORT_SYMBOL(strstr);
 
+EXPORT_SYMBOL(vsyscall_ehdr);
+EXPORT_SYMBOL(vsyscall_end);
+
 /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
  * However, the modules will use the CRC defined *here*, no matter if it is
  * good; so the versions of these symbols will always match
diff -puN include/asm-um/archparam-i386.h~fix-vsyscall include/asm-um/archparam-i386.h
--- linux-2.6.10-rc2/include/asm-um/archparam-i386.h~fix-vsyscall	2004-11-25 16:41:08.474251782 +0100
+++ linux-2.6.10-rc2-root/include/asm-um/archparam-i386.h	2004-11-25 16:41:08.479250201 +0100
@@ -58,9 +58,9 @@ typedef elf_greg_t elf_gregset_t[ELF_NGR
 } while(0);
 
 
-extern long vsyscall_ehdr;
-extern long vsyscall_end;
-extern long __kernel_vsyscall;
+extern unsigned long vsyscall_ehdr;
+extern unsigned long vsyscall_end;
+extern unsigned long __kernel_vsyscall;
 
 #define VSYSCALL_BASE vsyscall_ehdr
 #define VSYSCALL_END vsyscall_end
_

