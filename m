Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVINWDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVINWDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVINWD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:03:26 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:57349 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S965027AbVINWDM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:03:12 -0400
Message-Id: <200509142156.j8ELuALt012164@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 8/10] UML - merge mem_user.c and mem.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Sep 2005 17:56:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The serial UML OS-abstraction layer patch (um/kernel dir).

This joins mem_user.c and mem.c files.

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm2/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/Makefile	2005-09-08 14:55:47.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/Makefile	2005-09-08 14:58:21.000000000 -0400
@@ -1,4 +1,4 @@
-# 
+#
 # Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
 # Licensed under the GPL
 #
@@ -7,11 +7,11 @@
 clean-files :=
 
 obj-y = config.o exec_kern.o exitcode.o \
-	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
-	physmem.o process_kern.o ptrace.o reboot.o resource.o sigio_user.o \
-	sigio_kern.o signal_kern.o signal_user.o smp.o syscall_kern.o sysrq.o \
-	time.o time_kern.o tlb.o trap_kern.o trap_user.o \
-	uaccess_user.o um_arch.o umid.o user_util.o
+	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o physmem.o \
+	process_kern.o ptrace.o reboot.o resource.o sigio_user.o sigio_kern.o \
+	signal_kern.o signal_user.o smp.o syscall_kern.o sysrq.o time.o \
+	time_kern.o tlb.o trap_kern.o trap_user.o uaccess_user.o um_arch.o \
+	umid.o user_util.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
Index: linux-2.6.13-mm2/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/mem.c	2005-09-08 14:52:15.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/mem.c	2005-09-08 14:56:35.000000000 -0400
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
  * Licensed under the GPL
  */
@@ -19,6 +19,10 @@
 #include "mem_user.h"
 #include "uml_uaccess.h"
 #include "os.h"
+#include "linux/types.h"
+#include "linux/string.h"
+#include "init.h"
+#include "kern_constants.h"
 
 extern char __binary_start;
 
@@ -368,6 +372,16 @@
 	return pte;
 }
 
+struct iomem_region *iomem_regions = NULL;
+int iomem_size = 0;
+
+extern int parse_iomem(char *str, int *add) __init;
+
+__uml_setup("iomem=", parse_iomem,
+"iomem=<name>,<file>\n"
+"    Configure <file> as an IO memory region named <name>.\n\n"
+);
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.13-mm2/arch/um/kernel/mem_user.c
===================================================================
--- linux-2.6.13-mm2.orig/arch/um/kernel/mem_user.c	2005-09-08 14:55:47.000000000 -0400
+++ linux-2.6.13-mm2/arch/um/kernel/mem_user.c	2005-09-08 05:17:51.187952264 -0400
@@ -1,70 +0,0 @@
-/*
- * arch/um/kernel/mem_user.c
- *
- * BRIEF MODULE DESCRIPTION
- * user side memory routines for supporting IO memory inside user mode linux
- *
- * Copyright (C) 2001 RidgeRun, Inc.
- * Author: RidgeRun, Inc.
- *         Greg Lonnon glonnon@ridgerun.com or info@ridgerun.com
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <stddef.h>
-#include <stdarg.h>
-#include <unistd.h>
-#include <errno.h>
-#include <string.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/mman.h>
-#include "kern_util.h"
-#include "user.h"
-#include "user_util.h"
-#include "mem_user.h"
-#include "init.h"
-#include "os.h"
-#include "tempfile.h"
-#include "kern_constants.h"
-
-struct iomem_region *iomem_regions = NULL;
-int iomem_size = 0;
-
-extern int parse_iomem(char *str, int *add) __init;
-
-__uml_setup("iomem=", parse_iomem,
-"iomem=<name>,<file>\n"
-"    Configure <file> as an IO memory region named <name>.\n\n"
-);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

