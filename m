Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWFQSaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWFQSaL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWFQSaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:30:11 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:46954 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750802AbWFQSaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:30:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=oz4ih4lb7J1xG9Ht2NY7Ytx9Ar7ZxsE79tkHdIhnZBUwpflkr7Bc1ecMoFtKLUvMJ74yW7JVCHWOWFIXbKe1GO9K9zuMT7r7dYrFX0eyauEhxDz3d+ZERR1Va+RjvQna1p3nyJHOCr6MPkiBCXBrLCqsSAZnQpiac4/MZmzHLb4=
Message-ID: <44944A2F.30208@gmail.com>
Date: Sat, 17 Jun 2006 12:30:07 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 09/20] chardev: GPIO for SCx200 & PC-8736x:  dispatch
 via vtable
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

9/20. patch.vtable-calls

Now actually call the gpio operations thru the vtable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.vtable-calls
 scx200_gpio.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-8/drivers/char/scx200_gpio.c ax-9/drivers/char/scx200_gpio.c
--- ax-8/drivers/char/scx200_gpio.c	2006-06-17 01:20:34.000000000 -0600
+++ ax-9/drivers/char/scx200_gpio.c	2006-06-17 01:23:47.000000000 -0600
@@ -53,6 +53,7 @@ static ssize_t scx200_gpio_write(struct 
 				 size_t len, loff_t *ppos)
 {
 	unsigned m = iminor(file->f_dentry->d_inode);
+	struct nsc_gpio_ops *amp = file->private_data;
 	size_t i;
 	int err = 0;
 
@@ -62,39 +63,39 @@ static ssize_t scx200_gpio_write(struct 
 			return -EFAULT;
 		switch (c) {
 		case '0':
-			scx200_gpio_set(m, 0);
+			amp->gpio_set(m, 0);
 			break;
 		case '1':
-			scx200_gpio_set(m, 1);
+			amp->gpio_set(m, 1);
 			break;
 		case 'O':
 			printk(KERN_INFO NAME ": GPIO%d output enabled\n", m);
-			scx200_gpio_configure(m, ~1, 1);
+			amp->gpio_config(m, ~1, 1);
 			break;
 		case 'o':
 			printk(KERN_INFO NAME ": GPIO%d output disabled\n", m);
-			scx200_gpio_configure(m, ~1, 0);
+			amp->gpio_config(m, ~1, 0);
 			break;
 		case 'T':
 			printk(KERN_INFO NAME ": GPIO%d output is push pull\n", m);
-			scx200_gpio_configure(m, ~2, 2);
+			amp->gpio_config(m, ~2, 2);
 			break;
 		case 't':
 			printk(KERN_INFO NAME ": GPIO%d output is open drain\n", m);
-			scx200_gpio_configure(m, ~2, 0);
+			amp->gpio_config(m, ~2, 0);
 			break;
 		case 'P':
 			printk(KERN_INFO NAME ": GPIO%d pull up enabled\n", m);
-			scx200_gpio_configure(m, ~4, 4);
+			amp->gpio_config(m, ~4, 4);
 			break;
 		case 'p':
 			printk(KERN_INFO NAME ": GPIO%d pull up disabled\n", m);
-			scx200_gpio_configure(m, ~4, 0);
+			amp->gpio_config(m, ~4, 0);
 			break;
 
 		case 'v':
 			/* View Current pin settings */
-			scx200_gpio_dump(m);
+			amp->gpio_dump(m);
 			break;
 		case '\n':
 			/* end of settings string, do nothing */
@@ -117,8 +118,9 @@ static ssize_t scx200_gpio_read(struct f
 {
 	unsigned m = iminor(file->f_dentry->d_inode);
 	int value;
+	struct nsc_gpio_ops *amp = file->private_data;
 
-	value = scx200_gpio_get(m);
+	value = amp->gpio_get(m);
 	if (put_user(value ? '1' : '0', buf))
 		return -EFAULT;
 
@@ -128,6 +130,8 @@ static ssize_t scx200_gpio_read(struct f
 static int scx200_gpio_open(struct inode *inode, struct file *file)
 {
 	unsigned m = iminor(inode);
+	file->private_data = &scx200_access;
+
 	if (m > 63)
 		return -EINVAL;
 	return nonseekable_open(inode, file);


