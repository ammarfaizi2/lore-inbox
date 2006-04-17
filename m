Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWDQQY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWDQQY6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWDQQY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:24:58 -0400
Received: from uproxy.gmail.com ([66.249.92.175]:46941 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751149AbWDQQY5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:24:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UBNuGEjrlRUtpmfjZnTO0mAUC+DZuJebh76gWAQhYLyvqvbI9O4UybTcp/PtRwAwiiFvhbKNeLsdBu0OFNKZulaasbIs41CcZN+qowWBdDsYozFNEMGmp8ykeqEN7d72q+8icsAh++9wCwfpY2EHY7kF9OYDIoObrzJ+bm3D1uo=
Message-ID: <82ecf08e0604170924y48deb5d1n1fdcfaaac9e257fe@mail.gmail.com>
Date: Mon, 17 Apr 2006 13:24:56 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: [PATCH] Remove unnecessary kmalloc/kfree calls in mtdchar
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1145290249.13200.17.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <82ecf08e0604141938w4b29259av797e3115b79042a0@mail.gmail.com>
	 <625fc13d0604170506n53147772vec944cdd7f2daef7@mail.gmail.com>
	 <82ecf08e0604170619i582bfa19r19a3da0d7d0904b1@mail.gmail.com>
	 <1145285434.13200.9.camel@pmac.infradead.org>
	 <82ecf08e0604170803u620c67e0nf98312bd90e1e14c@mail.gmail.com>
	 <1145290249.13200.17.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes repeated calls to kmalloc / kfree in mtd_write /
mtd_read functions, replacing them by a single kmalloc / kfree pair.

Signed-off-by: Thiago Galesi <thiagogalesi@gmail.com>

---

Index: linux-2.6.16.2/drivers/mtd/mtdchar.c
===================================================================
--- linux-2.6.16.2.orig/drivers/mtd/mtdchar.c
+++ linux-2.6.16.2/drivers/mtd/mtdchar.c
@@ -170,16 +170,22 @@ static ssize_t mtd_read(struct file *fil

 	/* FIXME: Use kiovec in 2.5 to lock down the user's buffers
 	   and pass them directly to the MTD functions */
+
+	if (count > MAX_KMALLOC_SIZE)
+		kbuf=kmalloc(MAX_KMALLOC_SIZE, GFP_KERNEL);
+	else
+		kbuf=kmalloc(count, GFP_KERNEL);
+
+	if (!kbuf)
+		return -ENOMEM;
+
 	while (count) {
+
 		if (count > MAX_KMALLOC_SIZE)
 			len = MAX_KMALLOC_SIZE;
 		else
 			len = count;

-		kbuf=kmalloc(len,GFP_KERNEL);
-		if (!kbuf)
-			return -ENOMEM;
-
 		switch (MTD_MODE(file)) {
 		case MTD_MODE_OTP_FACT:
 			ret = mtd->read_fact_prot_reg(mtd, *ppos, len, &retlen, kbuf);
@@ -215,9 +221,9 @@ static ssize_t mtd_read(struct file *fil
 			return ret;
 		}

-		kfree(kbuf);
 	}

+	kfree(kbuf);
 	return total_retlen;
 } /* mtd_read */

@@ -241,18 +247,21 @@ static ssize_t mtd_write(struct file *fi
 	if (!count)
 		return 0;

+	if (count > MAX_KMALLOC_SIZE)
+		kbuf=kmalloc(MAX_KMALLOC_SIZE, GFP_KERNEL);
+	else
+		kbuf=kmalloc(count, GFP_KERNEL);
+
+	if (!kbuf)
+		return -ENOMEM;
+
 	while (count) {
+
 		if (count > MAX_KMALLOC_SIZE)
 			len = MAX_KMALLOC_SIZE;
 		else
 			len = count;

-		kbuf=kmalloc(len,GFP_KERNEL);
-		if (!kbuf) {
-			printk("kmalloc is null\n");
-			return -ENOMEM;
-		}
-
 		if (copy_from_user(kbuf, buf, len)) {
 			kfree(kbuf);
 			return -EFAULT;
@@ -282,10 +291,9 @@ static ssize_t mtd_write(struct file *fi
 			kfree(kbuf);
 			return ret;
 		}
-
-		kfree(kbuf);
 	}

+	kfree(kbuf);
 	return total_retlen;
 } /* mtd_write */
