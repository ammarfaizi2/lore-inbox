Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbWDOCib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbWDOCib (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 22:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWDOCib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 22:38:31 -0400
Received: from uproxy.gmail.com ([66.249.92.172]:5838 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030207AbWDOCia convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 22:38:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LtuafFpfbf4kAjxCtQcKK8ZAKHpkmxBb+PWKCTexhnqZrosAr1cllfWZf7CBA46R1BiiZr50MUR1+DOuTxL2O1BclMyVfMUNyp1ipHLefq+IfMugGQLc/Bl5TGD0bFv+y/J6X/ZiqwZtfsfAV1mM0MOAK/3K+QzdvG0H7PVn5FE=
Message-ID: <82ecf08e0604141938w4b29259av797e3115b79042a0@mail.gmail.com>
Date: Fri, 14 Apr 2006 23:38:29 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: [PATCH] Remove unnecessary kmalloc/kfree calls in mtdchar
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the use of repeated calls to kmalloc / kfree when
writing / reading from a MTD char device. Not the ideal solution
mentioned in the driver, but nonetheless better.

Signed-off by Thiago Galesi <thiagogalesi@gmail.com>

---

(Please CC me as I'm not subscribed to linux-mtd)

Index: linux-2.6.16.2/drivers/mtd/mtdchar.c
===================================================================
--- linux-2.6.16.2.orig/drivers/mtd/mtdchar.c
+++ linux-2.6.16.2/drivers/mtd/mtdchar.c
@@ -170,15 +170,18 @@ static ssize_t mtd_read(struct file *fil

 	/* FIXME: Use kiovec in 2.5 to lock down the user's buffers
 	   and pass them directly to the MTD functions */
-	while (count) {
-		if (count > MAX_KMALLOC_SIZE)
-			len = MAX_KMALLOC_SIZE;
-		else
-			len = count;

-		kbuf=kmalloc(len,GFP_KERNEL);
-		if (!kbuf)
-			return -ENOMEM;
+	if (count > MAX_KMALLOC_SIZE)
+		len = MAX_KMALLOC_SIZE;
+	else
+		len = count;
+
+	kbuf=kmalloc(len,GFP_KERNEL);
+
+	if (!kbuf)
+		return -ENOMEM;
+
+	while (count) {

 		switch (MTD_MODE(file)) {
 		case MTD_MODE_OTP_FACT:
@@ -215,9 +218,9 @@ static ssize_t mtd_read(struct file *fil
 			return ret;
 		}

-		kfree(kbuf);
 	}

+	kfree(kbuf);
 	return total_retlen;
 } /* mtd_read */

@@ -241,17 +244,18 @@ static ssize_t mtd_write(struct file *fi
 	if (!count)
 		return 0;

-	while (count) {
-		if (count > MAX_KMALLOC_SIZE)
-			len = MAX_KMALLOC_SIZE;
-		else
-			len = count;
+	if (count > MAX_KMALLOC_SIZE)
+		len = MAX_KMALLOC_SIZE;
+	else
+		len = count;
+
+	kbuf=kmalloc(len,GFP_KERNEL);
+	if (!kbuf) {
+		printk("kmalloc is null\n");
+		return -ENOMEM;
+	}

-		kbuf=kmalloc(len,GFP_KERNEL);
-		if (!kbuf) {
-			printk("kmalloc is null\n");
-			return -ENOMEM;
-		}
+	while (count) {

 		if (copy_from_user(kbuf, buf, len)) {
 			kfree(kbuf);
@@ -282,10 +286,9 @@ static ssize_t mtd_write(struct file *fi
 			kfree(kbuf);
 			return ret;
 		}
-
-		kfree(kbuf);
 	}

+	kfree(kbuf);
 	return total_retlen;
 } /* mtd_write */
