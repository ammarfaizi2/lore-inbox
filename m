Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262615AbVG2P0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262615AbVG2P0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262628AbVG2P0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:26:38 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12203 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S262615AbVG2PYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:24:44 -0400
Message-Id: <200507291513.j6TFDEml008056@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - Fix vsyscall brokenness
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jul 2005 11:13:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The #if/#ifdef cleanup exposed a bug in UML's ELF header processing.  With 
this bug fixed, UML recognizes the vsyscall info coming from the host.  On
FC4, there is a vsyscall page low in the address space, which UML doesn't
provide.  This causes an infinite page fault loop and a hang on boot.

This patch works around that by making this look like a no-vsyscall system.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc3-mm2/arch/um/os-Linux/elf_aux.c
===================================================================
--- linux-2.6.12-rc3-mm2.orig/arch/um/os-Linux/elf_aux.c	2005-07-28 12:08:54.000000000 -0400
+++ linux-2.6.12-rc3-mm2/arch/um/os-Linux/elf_aux.c	2005-07-28 18:47:31.000000000 -0400
@@ -9,9 +9,10 @@
  */
 #include <elf.h>
 #include <stddef.h>
+#include <asm/elf.h>
 #include "init.h"
 #include "elf_user.h"
-#include <asm/elf.h>
+#include "mem_user.h"
 
 #if ELF_CLASS == ELFCLASS32
 typedef Elf32_auxv_t elf_auxv_t;
@@ -41,6 +42,9 @@
 				break;
 			case AT_SYSINFO_EHDR:
 				vsyscall_ehdr = auxv->a_un.a_val;
+				/* See if the page is under TASK_SIZE */
+				if (vsyscall_ehdr < (unsigned long) envp) 
+					vsyscall_ehdr = 0;
 				break;
 			case AT_HWCAP:
 				elf_aux_hwcap = auxv->a_un.a_val;

