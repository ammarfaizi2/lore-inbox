Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422700AbWKHTtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422700AbWKHTtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422701AbWKHTtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:49:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:7348 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422700AbWKHTtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:49:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=WfC4Zr9JObj+Gy6g0KkLNNDGR5krN/5le6QGmfCeI+ZHgwpmtksQ5byOjBDcCmLiQb5e4U9q6FilXT2hWAnnty/STjIMURNol16IZ8f6nD0MnKMyoCsnFrVANEnWIW5wEGQpcadFdIX899O0RqclZR0dlrZfrytUqa+OAayBgzk=
Date: Wed, 8 Nov 2006 20:49:06 +0100
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/1 update8] drivers: add LCD support
Message-Id: <20061108204906.70748e63.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, another one for drivers-add-lcd-support saga. Thanks you.
---

 - add "depends on x86" until some solution to d-cache
   aliasing is provided

 - use the new and simpler vm_insert_page()
     instead of nopage() related code

 drivers/auxdisplay/Kconfig        |    1 +
 drivers/auxdisplay/cfag12864bfb.c |   21 ++-------------------
 2 files changed, 3 insertions(+), 19 deletions(-)

drivers-add-lcd-support-update8.patch
Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index ee30c48..8d41f72 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -64,6 +64,7 @@ config KS0108_DELAY
 
 config CFAG12864B
 	tristate "CFAG12864B LCD"
+	depends on X86
 	depends on KS0108
 	default n
 	---help---
diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index 87b86af..94765e7 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -65,27 +65,10 @@ static struct fb_var_screeninfo cfag1286
 	.vmode = FB_VMODE_NONINTERLACED,
 };
 
-static struct page *cfag12864bfb_vma_nopage(struct vm_area_struct *vma,
-	unsigned long address, int *type)
-{
-	struct page *page = virt_to_page(cfag12864b_buffer);
-	get_page(page);
-
-	if (type)
-		*type = VM_FAULT_MINOR;
-
-	return page;
-}
-
-static struct vm_operations_struct cfag12864bfb_vm_ops = {
-	.nopage = cfag12864bfb_vma_nopage,
-};
-
 static int cfag12864bfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
-	vma->vm_ops = &cfag12864bfb_vm_ops;
-	vma->vm_flags |= VM_RESERVED;
-	return 0;
+	return vm_insert_page(vma, vma->vm_start,
+		virt_to_page(cfag12864b_buffer));
 }
 
 static struct fb_ops cfag12864bfb_ops = {
