Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWDUQGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWDUQGc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWDUQGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:06:32 -0400
Received: from mail.parknet.jp ([210.171.160.80]:7432 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932382AbWDUQGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:06:31 -0400
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] X86_NUMAQ build fix
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 22 Apr 2006 01:06:23 +0900
Message-ID: <87irp2x69s.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes the build breakage of X86_NUMAQ. And this declares
xquad_portio on only X86_NUMAQ.

Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/i386/boot/compressed/misc.c |    4 +++-
 arch/i386/kernel/smpboot.c       |    2 +-
 arch/i386/pci/Makefile           |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff -puN arch/i386/pci/Makefile~numaq-build-fix arch/i386/pci/Makefile
--- linux-2.6/arch/i386/pci/Makefile~numaq-build-fix	2006-04-22 00:54:29.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/pci/Makefile	2006-04-22 00:55:27.000000000 +0900
@@ -5,10 +5,11 @@ obj-$(CONFIG_PCI_MMCONFIG)	+= mmconfig.o
 obj-$(CONFIG_PCI_DIRECT)	+= direct.o
 
 pci-y				:= fixup.o
-pci-$(CONFIG_ACPI)		+= acpi.o
 pci-y				+= legacy.o irq.o
 
 pci-$(CONFIG_X86_VISWS)		:= visws.o fixup.o
 pci-$(CONFIG_X86_NUMAQ)		:= numa.o irq.o
 
+pci-$(CONFIG_ACPI)		+= acpi.o
+
 obj-y				+= $(pci-y) common.o
diff -puN arch/i386/boot/compressed/misc.c~numaq-build-fix arch/i386/boot/compressed/misc.c
--- linux-2.6/arch/i386/boot/compressed/misc.c~numaq-build-fix	2006-04-22 00:54:29.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/boot/compressed/misc.c	2006-04-22 00:54:29.000000000 +0900
@@ -122,7 +122,9 @@ static int vidport;
 static int lines, cols;
 
 #ifdef CONFIG_X86_NUMAQ
-static void * xquad_portio = NULL;
+/* hack to avoid using xquad_portio=NULL */
+#undef outb_p
+#define outb_p		outb_local_p
 #endif
 
 #include "../../../../lib/inflate.c"
diff -puN arch/i386/kernel/smpboot.c~numaq-build-fix arch/i386/kernel/smpboot.c
--- linux-2.6/arch/i386/kernel/smpboot.c~numaq-build-fix	2006-04-22 00:54:29.000000000 +0900
+++ linux-2.6-hirofumi/arch/i386/kernel/smpboot.c	2006-04-22 00:54:29.000000000 +0900
@@ -1116,9 +1116,9 @@ static void smp_tune_scheduling (void)
  */
 
 static int boot_cpu_logical_apicid;
+#ifdef CONFIG_X86_NUMAQ
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
-#ifdef CONFIG_X86_NUMAQ
 EXPORT_SYMBOL(xquad_portio);
 #endif
 
_
