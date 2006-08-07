Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWHGVMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWHGVMT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 17:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWHGVLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 17:11:53 -0400
Received: from xenotime.net ([66.160.160.81]:15067 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932381AbWHGVLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 17:11:12 -0400
Date: Mon, 7 Aug 2006 14:07:58 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, torvalds <torvalds@osdl.org>, geert@linux-m68k.org,
       zippel@linux-m68k.org, wli@holomorphy.com
Subject: [PATCH 8/9] Replace __ARCH_HAS_NO_PAGE_ZERO_MAPPED with
 CONFIG_NO_PAGE_ZERO_MAPPED
Message-Id: <20060807140758.aea1de6c.rdunlap@xenotime.net>
In-Reply-To: <20060807120928.c0fe7045.rdunlap@xenotime.net>
References: <20060807120928.c0fe7045.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Replace __ARCH_HAS_NO_PAGE_ZERO_MAPPED with CONFIG_NO_PAGE_ZERO_MAPPED.
Move it from header files to Kconfig space.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/m68k/Kconfig      |    3 +++
 arch/sparc/Kconfig     |    3 +++
 drivers/char/mem.c     |    8 ++++----
 include/asm-m68k/io.h  |    2 --
 include/asm-sparc/io.h |    2 --
 5 files changed, 10 insertions(+), 8 deletions(-)

--- linux-2618-rc4-arch.orig/drivers/char/mem.c
+++ linux-2618-rc4-arch/drivers/char/mem.c
@@ -115,7 +115,7 @@ static ssize_t read_mem(struct file * fi
 	if (!valid_phys_addr_range(p, count))
 		return -EFAULT;
 	read = 0;
-#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
+#ifdef CONFIG_NO_PAGE_ZERO_MAPPED
 	/* we don't have page 0 mapped on sparc and m68k.. */
 	if (p < PAGE_SIZE) {
 		sz = PAGE_SIZE - p;
@@ -175,7 +175,7 @@ static ssize_t write_mem(struct file * f
 
 	written = 0;
 
-#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
+#ifdef CONFIG_NO_PAGE_ZERO_MAPPED
 	/* we don't have page 0 mapped on sparc and m68k.. */
 	if (p < PAGE_SIZE) {
 		unsigned long sz = PAGE_SIZE - p;
@@ -333,7 +333,7 @@ static ssize_t read_kmem(struct file *fi
 		if (count > (unsigned long) high_memory - p)
 			low_count = (unsigned long) high_memory - p;
 
-#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
+#ifdef CONFIG_NO_PAGE_ZERO_MAPPED
 		/* we don't have page 0 mapped on sparc and m68k.. */
 		if (p < PAGE_SIZE && low_count > 0) {
 			size_t tmp = PAGE_SIZE - p;
@@ -411,7 +411,7 @@ do_write_kmem(void *p, unsigned long rea
 	unsigned long copied;
 
 	written = 0;
-#ifdef __ARCH_HAS_NO_PAGE_ZERO_MAPPED
+#ifdef CONFIG_NO_PAGE_ZERO_MAPPED
 	/* we don't have page 0 mapped on sparc and m68k.. */
 	if (realp < PAGE_SIZE) {
 		unsigned long sz = PAGE_SIZE - realp;
--- linux-2618-rc4-arch.orig/include/asm-m68k/io.h
+++ linux-2618-rc4-arch/include/asm-m68k/io.h
@@ -360,8 +360,6 @@ extern void dma_cache_inv(unsigned long 
 
 #endif /* __KERNEL__ */
 
-#define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
--- linux-2618-rc4-arch.orig/include/asm-sparc/io.h
+++ linux-2618-rc4-arch/include/asm-sparc/io.h
@@ -290,8 +290,6 @@ extern void sbus_iounmap(volatile void _
 
 #endif
 
-#define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
--- linux-2618-rc4-arch.orig/arch/m68k/Kconfig
+++ linux-2618-rc4-arch/arch/m68k/Kconfig
@@ -366,6 +366,9 @@ config 060_WRITETHROUGH
 	  is hardwired on.  The 53c710 SCSI driver is known to suffer from
 	  this problem.
 
+config NO_PAGE_ZERO_MAPPED
+	def_bool y
+
 source "mm/Kconfig"
 
 endmenu
--- linux-2618-rc4-arch.orig/arch/sparc/Kconfig
+++ linux-2618-rc4-arch/arch/sparc/Kconfig
@@ -229,6 +229,9 @@ config SUNOS_EMUL
 
 source "mm/Kconfig"
 
+config NO_PAGE_ZERO_MAPPED
+	def_bool y
+
 endmenu
 
 source "net/Kconfig"


---
