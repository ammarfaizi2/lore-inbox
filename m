Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWIVCyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWIVCyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWIVCys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:54:48 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:33412 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932233AbWIVCys
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:54:48 -0400
Subject: [Patch] i386 bootioremap / kexec fix
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: andrew <akpm@osdl.org>, Vivek goyal <vgoyal@in.ibm.com>,
       dave hansen <haveblue@us.ibm.com>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 21 Sep 2006 19:54:45 -0700
Message-Id: <1158893685.5657.72.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  With CONFIG_PHYSICAL_START set to a non default values the i386
boot_ioremap code calculated its pte index wrong and users of
boot_ioremap have their areas incorrectly mapped  (for me SRAT table not
mapped during early boot). This patch removes the addr < BOOT_PTE_PTRS
constraint. 

Signed-off-by: Keith Mannthey<kmannth@us.ibm.com>
---
 boot_ioremap.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff -urN linux-2.6.18-rc6-mm2-orig/arch/i386/mm/boot_ioremap.c
linux-2.6.17/arch/i386/mm/boot_ioremap.c
--- linux-2.6.18-rc6-mm2-orig/arch/i386/mm/boot_ioremap.c	2006-09-18
01:19:22.000000000 -0700
+++ linux-2.6.17/arch/i386/mm/boot_ioremap.c	2006-09-18
01:23:33.000000000 -0700
@@ -29,8 +29,11 @@
  */
 
 #define BOOT_PTE_PTRS (PTRS_PER_PTE*2)
-#define boot_pte_index(address) \
-	     (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
+
+static unsigned long boot_pte_index(unsigned long vaddr) 
+{
+	return __pa(vaddr) >> PAGE_SHIFT;
+}
 
 static inline boot_pte_t* boot_vaddr_to_pte(void *address)
 {


