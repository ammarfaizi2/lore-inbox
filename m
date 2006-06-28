Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWF1Qyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWF1Qyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbWF1Qyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:54:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30980 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751410AbWF1Qy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:26 -0400
Date: Wed, 28 Jun 2006 18:54:25 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: linux-kernel@vger.kernel.org, pazke@donpac.ru,
       linux-visws-devel@lists.sourceforge.net,
       Chris Wright <chrisw@sous-sol.org>
Subject: [-mm patch] fix sgivwfb compile
Message-ID: <20060628165425.GK13915@stusta.de>
References: <20060624061914.202fbfb5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624061914.202fbfb5.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error caused by 
clean-up-and-refactor-i386-sub-architecture-setup.patch:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `sgivwfb_set_par':
sgivwfb.c:(.text+0x88583): undefined reference to `sgivwfb_mem_phys'
sgivwfb.c:(.text+0x88596): undefined reference to `sgivwfb_mem_phys'
sgivwfb.c:(.text+0x885a8): undefined reference to `sgivwfb_mem_phys'
drivers/built-in.o: In function `sgivwfb_check_var':
sgivwfb.c:(.text+0x88ad0): undefined reference to `sgivwfb_mem_size'
drivers/built-in.o: In function `sgivwfb_mmap':
sgivwfb.c:(.text+0x88c75): undefined reference to `sgivwfb_mem_size'
sgivwfb.c:(.text+0x88c7f): undefined reference to `sgivwfb_mem_phys'
drivers/built-in.o: In function `sgivwfb_probe':
sgivwfb.c:(.init.text+0x4060): undefined reference to `sgivwfb_mem_size'
sgivwfb.c:(.init.text+0x4065): undefined reference to `sgivwfb_mem_phys'
sgivwfb.c:(.init.text+0x4076): undefined reference to `sgivwfb_mem_phys'
sgivwfb.c:(.init.text+0x409c): undefined reference to `sgivwfb_mem_size'
sgivwfb.c:(.init.text+0x410e): undefined reference to `sgivwfb_mem_size'
sgivwfb.c:(.init.text+0x4113): undefined reference to `sgivwfb_mem_phys'
sgivwfb.c:(.init.text+0x4162): undefined reference to `sgivwfb_mem_size'
sgivwfb.c:(.init.text+0x4168): undefined reference to `sgivwfb_mem_phys'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/mach-visws/setup.c             |    4 ++--
 drivers/video/sgivwfb.c                  |    6 ++----
 include/asm-i386/mach-visws/setup_arch.h |    3 +++
 3 files changed, 7 insertions(+), 6 deletions(-)

--- linux-2.6.17-mm2-full/include/asm-i386/mach-visws/setup_arch.h.old	2006-06-27 00:35:55.000000000 +0200
+++ linux-2.6.17-mm2-full/include/asm-i386/mach-visws/setup_arch.h	2006-06-27 00:36:10.000000000 +0200
@@ -1,5 +1,8 @@
 /* Hook to call BIOS initialisation function */
 
+extern unsigned long sgivwfb_mem_phys;
+extern unsigned long sgivwfb_mem_size;
+
 /* no action for visws */
 
 #define ARCH_SETUP
--- linux-2.6.17-mm2-full/arch/i386/mach-visws/setup.c.old	2006-06-27 00:28:06.000000000 +0200
+++ linux-2.6.17-mm2-full/arch/i386/mach-visws/setup.c	2006-06-27 00:28:20.000000000 +0200
@@ -140,8 +140,8 @@
 
 #define MB (1024 * 1024)
 
-static unsigned long sgivwfb_mem_phys;
-static unsigned long sgivwfb_mem_size;
+unsigned long sgivwfb_mem_phys;
+unsigned long sgivwfb_mem_size;
 
 long long mem_size __initdata = 0;
 
--- linux-2.6.17-mm2-full/drivers/video/sgivwfb.c.old	2006-06-27 00:29:03.000000000 +0200
+++ linux-2.6.17-mm2-full/drivers/video/sgivwfb.c	2006-06-27 00:36:37.000000000 +0200
@@ -23,6 +23,8 @@
 #include <asm/io.h>
 #include <asm/mtrr.h>
 
+#include <setup_arch.h>
+
 #define INCLUDE_TIMING_TABLE_DATA
 #define DBE_REG_BASE par->regs
 #include <video/sgivw.h>
@@ -42,10 +44,6 @@
  *  The default can be overridden if the driver is compiled as a module
  */
 
-/* set by arch/i386/kernel/setup.c */
-extern unsigned long sgivwfb_mem_phys;
-extern unsigned long sgivwfb_mem_size;
-
 static int ypan = 0;
 static int ywrap = 0;
 

