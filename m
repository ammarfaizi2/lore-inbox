Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWDQNTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWDQNTw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 09:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWDQNTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 09:19:52 -0400
Received: from uproxy.gmail.com ([66.249.92.175]:31862 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750747AbWDQNTv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 09:19:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dkmgkrUXzP7dcjVZME+6yBCDoeCOZjCAJfpYaIgTDmKGzj7XxhEhMprMaIq6eIX0PUu3/V3czPY9GU9O9C5NxLKCGL4jQbN/HdB7BkzyAB6iBfCPpIjc1pQHxbV//r8nhNWF4YQspB/sWkobwccJTefqYqDm3soLpdYAMTnxQW8=
Message-ID: <82ecf08e0604170619i582bfa19r19a3da0d7d0904b1@mail.gmail.com>
Date: Mon, 17 Apr 2006 10:19:49 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Subject: [PATCH] Remove unnecessary kmalloc/kfree calls in mtdchar
Cc: "David Woodhouse" <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <625fc13d0604170506n53147772vec944cdd7f2daef7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <82ecf08e0604141938w4b29259av797e3115b79042a0@mail.gmail.com>
	 <625fc13d0604170506n53147772vec944cdd7f2daef7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh

Thank you for your feedback! You're right, and both read and write had
the problem. It's probably better to kmalloc once but calculate len in
the old way. Hopefully I got it right this time.

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

@@ -241,18 +247,23 @@ static ssize_t mtd_write(struct file *fi
 	if (!count)
 		return 0;

+	if (count > MAX_KMALLOC_SIZE)
+		kbuf=kmalloc(MAX_KMALLOC_SIZE, GFP_KERNEL);
+	else
+		kbuf=kmalloc(count, GFP_KERNEL);
+
+	if (!kbuf) {
+		printk("kmalloc is null\n");
+		return -ENOMEM;
+	}
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
@@ -282,10 +293,9 @@ static ssize_t mtd_write(struct file *fi
 			kfree(kbuf);
 			return ret;
 		}
-
-		kfree(kbuf);
 	}

+	kfree(kbuf);
 	return total_retlen;
 } /* mtd_write */
