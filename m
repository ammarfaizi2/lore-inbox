Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262979AbVCXB45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbVCXB45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbVCXB45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:56:57 -0500
Received: from mail.renesas.com ([202.234.163.13]:56733 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262979AbVCXBzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:55:51 -0500
Date: Thu, 24 Mar 2005 10:55:44 +0900 (JST)
Message-Id: <20050324.105544.521600653.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, inaoka.kazuhiro@renesas.com,
       fujiwara@linux-m32r.org, takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc1] m32r: Update MMU-less support (3/3)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050324.104815.304093279.takata.hirokazu@renesas.com>
References: <20050324.104815.304093279.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is for updating m32r's MMU-less support.

	* arch/m32r/boot/compressed/Makefile: 
	Use m32r-elf-gcc for MMU-less targets; change ELF object format
	from elf32-m32r-linux to elf32-m32r for !CONFIG_MMU.

	* arch/m32r/boot/compressed/head.S: Set up cache for M32102 chip.
	* arch/m32r/boot/setup.S: ditto.

	* arch/m32r/kernel/module.c: Module support for !CONFIG_MMU.

Signed-off-by: Kazuhiro Inaoka <inaoka.kazuhiro@renesas.com>
Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/boot/compressed/Makefile |    5 +++++
 arch/m32r/boot/compressed/head.S   |    5 +++++
 arch/m32r/boot/setup.S             |    5 +++++
 arch/m32r/kernel/module.c          |    6 ++++++
 arch/m32r/mm/fault-nommu.c         |    1 +
 5 files changed, 22 insertions(+)


diff -ruNp a/arch/m32r/boot/compressed/Makefile b/arch/m32r/boot/compressed/Makefile
--- a/arch/m32r/boot/compressed/Makefile	2004-12-25 06:33:49.000000000 +0900
+++ b/arch/m32r/boot/compressed/Makefile	2005-03-23 20:05:40.301333686 +0900
@@ -30,7 +30,12 @@ $(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bi
 
 CFLAGS_misc.o += -fpic
 
+ifdef CONFIG_MMU
 LDFLAGS_piggy.o := -r --format binary --oformat elf32-m32r-linux -T
+else
+LDFLAGS_piggy.o := -r --format binary --oformat elf32-m32r -T
+endif
+
 OBJCOPYFLAGS += -R .empty_zero_page
 
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.gz FORCE
diff -ruNp a/arch/m32r/boot/compressed/head.S b/arch/m32r/boot/compressed/head.S
--- a/arch/m32r/boot/compressed/head.S	2004-12-25 06:34:26.000000000 +0900
+++ b/arch/m32r/boot/compressed/head.S	2005-03-23 20:05:40.310332299 +0900
@@ -138,6 +138,11 @@ startup:
 	ldi	r0, -1
 	ldi	r1, 0xd0	; invalidate i-cache, copy back d-cache
 	stb	r1, @r0
+#elif defined(CONFIG_CHIP_M32102)
+	/* Cache flush */
+	ldi	r0, -2
+	ldi	r1, 0x0100	; invalidate
+	stb	r1, @r0
 #else
 #error "put your cache flush function, please"
 #endif
diff -ruNp a/arch/m32r/boot/setup.S b/arch/m32r/boot/setup.S
--- a/arch/m32r/boot/setup.S	2004-12-25 06:34:45.000000000 +0900
+++ b/arch/m32r/boot/setup.S	2005-03-23 20:05:40.326329834 +0900
@@ -75,6 +75,11 @@ ENTRY(boot)
 	ldi	r1, #0x73		; cache on (with invalidation)
 ;	ldi	r1, #0x00		; cache off
 	st	r1, @r0
+#elif defined(CONFIG_CHIP_M32102)
+	ldi	r0, #-4              ;LDIMM	(r0, M32R_MCCR)
+	ldi	r1, #0x101		; cache on (with invalidation)
+;	ldi	r1, #0x00		; cache off
+	st	r1, @r0
 #else
 #error unknown chip configuration
 #endif
diff -ruNp a/arch/m32r/kernel/module.c b/arch/m32r/kernel/module.c
--- a/arch/m32r/kernel/module.c	2004-12-25 06:35:49.000000000 +0900
+++ b/arch/m32r/kernel/module.c	2005-03-23 20:05:40.356325211 +0900
@@ -14,6 +14,8 @@
     along with this program; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
+
+#include <linux/config.h>
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
 #include <linux/vmalloc.h>
@@ -31,7 +33,11 @@ void *module_alloc(unsigned long size)
 {
 	if (size == 0)
 		return NULL;
+#ifdef CONFIG_MMU
 	return vmalloc_exec(size);
+#else
+	return vmalloc(size);
+#endif
 }
 
 
diff -ruNp a/arch/m32r/mm/fault-nommu.c b/arch/m32r/mm/fault-nommu.c
--- a/arch/m32r/mm/fault-nommu.c	2004-12-25 06:34:31.000000000 +0900
+++ b/arch/m32r/mm/fault-nommu.c	2005-03-23 20:05:56.192265581 +0900
@@ -23,6 +23,7 @@
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/vt_kern.h>              /* For unblank_screen() */
 
 #include <asm/m32r.h>
 #include <asm/system.h>

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
