Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbVCXB4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbVCXB4Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 20:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbVCXB4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 20:56:16 -0500
Received: from mail.renesas.com ([202.234.163.13]:10164 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262977AbVCXBzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 20:55:25 -0500
Date: Thu, 24 Mar 2005 10:55:20 +0900 (JST)
Message-Id: <20050324.105520.35010222.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, ysato@users.sourceforge.jp,
       takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc1] m32r: Update MMU-less support (2/3) 
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

	* arch/m32r/boot/compressed/m32r_sio.c:
	- Fix serial output routine

	* include/asm-m32r/mmu.h:
	- Update mm_context_t definition

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/boot/compressed/m32r_sio.c |    7 ++++++-
 include/asm-m32r/mmu.h               |   18 ++----------------
 2 files changed, 8 insertions(+), 17 deletions(-)


diff -ruNp a/arch/m32r/boot/compressed/m32r_sio.c b/arch/m32r/boot/compressed/m32r_sio.c
--- a/arch/m32r/boot/compressed/m32r_sio.c	2004-12-25 06:34:58.000000000 +0900
+++ b/arch/m32r/boot/compressed/m32r_sio.c	2005-03-23 20:28:24.846369405 +0900
@@ -46,9 +46,14 @@ static void putc(char c)
 	}
 	*BOOT_SIO0TXB = c;
 }
-#else
+#else /* defined(CONFIG_PLAT_M32700UT_Alpha) || defined(CONFIG_PLAT_M32700UT) */
+#ifdef CONFIG_MMU
 #define SIO0STS	(volatile unsigned short *)(0xa0efd000 + 14)
 #define SIO0TXB	(volatile unsigned short *)(0xa0efd000 + 30)
+#else
+#define SIO0STS	(volatile unsigned short *)(0x00efd000 + 14)
+#define SIO0TXB	(volatile unsigned short *)(0x00efd000 + 30)
+#endif
 
 static void putc(char c)
 {
diff -ruNp a/include/asm-m32r/mmu.h b/include/asm-m32r/mmu.h
--- a/include/asm-m32r/mmu.h	2004-12-25 06:34:44.000000000 +0900
+++ b/include/asm-m32r/mmu.h	2005-03-23 20:26:57.473769245 +0900
@@ -1,25 +1,12 @@
 #ifndef _ASM_M32R_MMU_H
 #define _ASM_M32R_MMU_H
 
-/* $Id$ */
-
 #include <linux/config.h>
 
 #if !defined(CONFIG_MMU)
-struct mm_rblock_struct {
-  int     size;
-  int     refcount;
-  void    *kblock;
-};
-
-struct mm_tblock_struct {
-  struct mm_rblock_struct *rblock;
-  struct mm_tblock_struct *next;
-};
-
 typedef struct {
-  struct mm_tblock_struct tblock;
-  unsigned long           end_brk;
+	struct vm_list_struct	*vmlist;
+	unsigned long		end_brk;
 } mm_context_t;
 #else
 
@@ -32,4 +19,3 @@ typedef unsigned long mm_context_t[NR_CP
 
 #endif  /* CONFIG_MMU */
 #endif  /* _ASM_M32R_MMU_H */
-

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
