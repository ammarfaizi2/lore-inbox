Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267240AbUF0CJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267240AbUF0CJq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 22:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267241AbUF0CJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 22:09:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:24263 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267240AbUF0CJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 22:09:34 -0400
Date: Sat, 26 Jun 2004 19:08:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Luca Risolia <luca.risolia@studio.unibo.it>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [BUG 2.6.7-mm1] sysfs - possible bug
Message-Id: <20040626190835.68eb63cb.akpm@osdl.org>
In-Reply-To: <20040627065816.11c3e28d.luca.risolia@studio.unibo.it>
References: <20040627065816.11c3e28d.luca.risolia@studio.unibo.it>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Risolia <luca.risolia@studio.unibo.it> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> This code causes some problems:
> 
> static ssize_t sn9c102_show_i2c_val(struct class_device* cd, char* buf)
> {
> 	return -EIO;
> }
> static CLASS_DEVICE_ATTR(i2c_val, S_IRUGO | S_IWUSR, sn9c102_show_i2c_val, sn9c102_store_i2c_val);

Indeed it does.

> kernel BUG at fs/sysfs/file.c:93!

	BUG_ON(count > PAGE_SIZE);

isn't right, because PAGE_SIZE is unsigned.

I'll send the below fix to Linus.

--- 25/fs/sysfs/file.c~sysfs-fill_read_buffer-fix	2004-06-26 19:03:11.821870464 -0700
+++ 25-akpm/fs/sysfs/file.c	2004-06-26 19:03:20.119609016 -0700
@@ -83,7 +83,7 @@ static int fill_read_buffer(struct file 
 		return -ENOMEM;
 
 	count = ops->show(kobj,attr,buffer->page);
-	BUG_ON(count > PAGE_SIZE);
+	BUG_ON(count > (ssize_t)PAGE_SIZE);
 	if (count >= 0)
 		buffer->count = count;
 	else
_

