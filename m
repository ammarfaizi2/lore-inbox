Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbULOKyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbULOKyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbULOKxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:53:41 -0500
Received: from mail.renesas.com ([202.234.163.13]:60144 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262325AbULOKxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:53:03 -0500
Date: Wed, 15 Dec 2004 19:52:51 +0900 (JST)
Message-Id: <20041215.195251.229742227.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sakugawa@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Support pgprot_noncached()
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch updates include/asm-m32r/pgtable.h to add pgprot_noncached().
It is required to fix a problem of an userspace application, which mmaps
io registers.

This patch also modifies drivers/video/fbmem.c to support noncachable
framebuffer access for m32r.
In this routine, pgprot_writecombine() is used hopefully, even though
the current m32r never does write-combining or write-coalescing...

Please apply this.

	* include/asm-m32r/pgtable.h
	  (pgprot_noncached, pgprot_writecombine): Newly added.

	* drivers/video/fbmem.c (fb_mmap): Add m32r support.

Thanks,

Signed-off-by: Mamoru Sakugawa <sakugawa@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/video/fbmem.c      |    3 ++-
 include/asm-m32r/pgtable.h |   13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)


diff -ruNp a/include/asm-m32r/pgtable.h b/include/asm-m32r/pgtable.h
--- a/include/asm-m32r/pgtable.h	2004-12-15 12:56:47.000000000 +0900
+++ b/include/asm-m32r/pgtable.h	2004-12-15 18:15:30.000000000 +0900
@@ -341,6 +341,19 @@ static __inline__ void ptep_mkdirty(pte_
 }
 
 /*
+ * Macro and implementation to make a page protection as uncachable.
+ */
+static __inline__ pgprot_t pgprot_noncached(pgprot_t _prot)
+{
+	unsigned long prot = pgprot_val(_prot);
+
+	prot |= _PAGE_NONCACHABLE;
+	return __pgprot(prot);
+}
+
+#define pgprot_writecombine(prot) pgprot_noncached(prot)
+
+/*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
diff -ruNp a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-12-15 12:56:38.000000000 +0900
+++ b/drivers/video/fbmem.c	2004-12-15 18:17:50.000000000 +0900
@@ -938,7 +938,8 @@ fb_mmap(struct file *file, struct vm_are
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 #elif defined(__hppa__)
 	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
-#elif defined(__ia64__) || defined(__arm__) || defined(__sh__)
+#elif defined(__ia64__) || defined(__arm__) || defined(__sh__) || \
+      defined(__m32r__)
 	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 #else
 #warning What do we have to do here??

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
