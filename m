Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752487AbWKFTZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbWKFTZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 14:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWKFTZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 14:25:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:33661 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752532AbWKFTZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 14:25:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=XJMF+TY9WVv6szdsiaXl8VKY8KUPGZAN9VtVoCuvB1WI5/emoSC6KqFbZNB6TaZmzShj9/5L5GXlqH+sCfLUP+2F6icIPBjWWTRShRlMBWPFTWgrJdKKMgL2JmGBqEVZ3sriUlwl06OBZKZSj96bXRaNH+LBCZH/8x6uWwh+efk=
Date: Mon, 6 Nov 2006 20:24:47 +0000
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH update7] drivers: add LCD support
Message-Id: <20061106202447.5770f95e.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, 3 improvements for the drivers-add-lcd-support saga. Thanks you.
---

 - use the new and simpler vm_insert_page()
     instead of nopage() related code
 - cfag12864b_work can and should be static
 - minor spelling and coding style

 drivers/auxdisplay/cfag12864b.c   |   11 +++++------
 drivers/auxdisplay/cfag12864bfb.c |   21 ++-------------------
 2 files changed, 7 insertions(+), 25 deletions(-)

drivers-add-lcd-support-update-7.patch
Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff -uprN -X dontdiff linux-mod4/drivers/auxdisplay/cfag12864b.c linux/drivers/auxdisplay/cfag12864b.c
--- linux-mod4/drivers/auxdisplay/cfag12864b.c	2006-11-01 19:49:47.000000000 +0000
+++ linux/drivers/auxdisplay/cfag12864b.c	2006-11-06 20:02:07.000000000 +0000
@@ -63,10 +63,10 @@ unsigned int cfag12864b_getrate(void)
  *		cfag12864b/ks0108 reads the command/data.
  *
  *	CS1 = First ks0108controller.
- *		If high, the first ks0108 receives commands/data.
+ *		If high, the first ks0108 controller receives commands/data.
  *
  *	CS2 = Second ks0108 controller
- *		If high, the second ks0108 receives commands/data.
+ *		If high, the second ks0108 controller receives commands/data.
  *
  *	DI = Data/Instruction
  *		If low, cfag12864b will expect commands.
@@ -223,7 +223,7 @@ static DEFINE_MUTEX(cfag12864b_mutex);
 static unsigned char cfag12864b_updating;
 static void cfag12864b_update(void *arg);
 static struct workqueue_struct *cfag12864b_workqueue;
-DECLARE_WORK(cfag12864b_work, cfag12864b_update, NULL);
+static DECLARE_WORK(cfag12864b_work, cfag12864b_update, NULL);
 
 static void cfag12864b_queue(void)
 {
@@ -241,8 +241,7 @@ unsigned char cfag12864b_enable(void)
 		cfag12864b_updating = 1;
 		cfag12864b_queue();
 		ret = 0;
-	}
-	else
+	} else
 		ret = 1;
 
 	mutex_unlock(&cfag12864b_mutex);
@@ -328,7 +327,7 @@ static int __init cfag12864b_init(void)
 		goto none;
 	}
 
-	cfag12864b_buffer = (unsigned char *) __get_free_page(GFP_KERNEL);
+	cfag12864b_buffer = (unsigned char *)__get_free_page(GFP_KERNEL);
 	if (cfag12864b_buffer == NULL) {
 		printk(KERN_ERR CFAG12864B_NAME ": ERROR: "
 			"can't get a free page\n");
diff -uprN -X dontdiff linux-mod4/drivers/auxdisplay/cfag12864bfb.c linux/drivers/auxdisplay/cfag12864bfb.c
--- linux-mod4/drivers/auxdisplay/cfag12864bfb.c	2006-11-01 19:49:47.000000000 +0000
+++ linux/drivers/auxdisplay/cfag12864bfb.c	2006-11-06 20:03:10.000000000 +0000
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
