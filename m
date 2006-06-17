Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWFQScj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWFQScj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWFQScj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:32:39 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:14703 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750780AbWFQSci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:32:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LDnaE1B63OBHkQ1AA8R2TYqq2fExUJ+lFzOZ0d8kSN9E7lZgmXdfnYpCIY3WuynGJfSVXB9tk7C8Mxx4/9MER2mYuo9nJiGD81iQiBMPNtKsuIPLx+CRvx7dXiZYkPu3WbYPN4aFuAvJyxoa6Gt27MPeLmfT2wpNHogAbIdLk5U=
Message-ID: <44944AC4.9050705@gmail.com>
Date: Sat, 17 Jun 2006 12:32:36 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 11/20] chardev: GPIO for SCx200 & PC-8736x: migrate file-ops
 to common module
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

11/20. patch.migrate-fops

Now that the read(), write() file-ops are dispatching gpio-ops via the
vtable, they are generic, and can be moved 'verbatim' to the nsc_gpio
common-support module.  After the move, various symbols are renamed to
update 'scx200_' to 'nsc_', and headers are adjusted accordingly.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.migrate-fops
 drivers/char/nsc_gpio.c    |   97 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/char/scx200_gpio.c |   88 +++-------------------------------------
 include/linux/nsc_gpio.h   |    5 ++
 3 files changed, 100 insertions(+), 90 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-10/drivers/char/nsc_gpio.c ax-11/drivers/char/nsc_gpio.c
--- ax-10/drivers/char/nsc_gpio.c	2006-06-17 01:27:04.000000000 -0600
+++ ax-11/drivers/char/nsc_gpio.c	2006-06-17 01:33:50.000000000 -0600
@@ -19,9 +19,89 @@
 
 #define NAME "nsc_gpio"
 
-MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
-MODULE_DESCRIPTION("NatSemi GPIO Common Methods");
-MODULE_LICENSE("GPL");
+ssize_t nsc_gpio_write(struct file *file, const char __user *data,
+		       size_t len, loff_t *ppos)
+{
+	unsigned m = iminor(file->f_dentry->d_inode);
+	struct nsc_gpio_ops *amp = file->private_data;
+	size_t i;
+	int err = 0;
+
+	for (i = 0; i < len; ++i) {
+		char c;
+		if (get_user(c, data + i))
+			return -EFAULT;
+		switch (c) {
+		case '0':
+			amp->gpio_set(m, 0);
+			break;
+		case '1':
+			amp->gpio_set(m, 1);
+			break;
+		case 'O':
+			printk(KERN_INFO NAME ": GPIO%d output enabled\n", m);
+			amp->gpio_config(m, ~1, 1);
+			break;
+		case 'o':
+			printk(KERN_INFO NAME ": GPIO%d output disabled\n", m);
+			amp->gpio_config(m, ~1, 0);
+			break;
+		case 'T':
+			printk(KERN_INFO NAME ": GPIO%d output is push pull\n",
+			       m);
+			amp->gpio_config(m, ~2, 2);
+			break;
+		case 't':
+			printk(KERN_INFO NAME ": GPIO%d output is open drain\n",
+			       m);
+			amp->gpio_config(m, ~2, 0);
+			break;
+		case 'P':
+			printk(KERN_INFO NAME ": GPIO%d pull up enabled\n", m);
+			amp->gpio_config(m, ~4, 4);
+			break;
+		case 'p':
+			printk(KERN_INFO NAME ": GPIO%d pull up disabled\n", m);
+			amp->gpio_config(m, ~4, 0);
+			break;
+
+		case 'v':
+			/* View Current pin settings */
+			amp->gpio_dump(m);
+			break;
+		case '\n':
+			/* end of settings string, do nothing */
+			break;
+		default:
+			printk(KERN_ERR NAME
+			       ": GPIO-%2d bad setting: chr<0x%2x>\n", m,
+			       (int)c);
+			err++;
+		}
+	}
+	if (err)
+		return -EINVAL;	/* full string handled, report error */
+
+	return len;
+}
+
+ssize_t nsc_gpio_read(struct file *file, char __user * buf,
+		      size_t len, loff_t * ppos)
+{
+	unsigned m = iminor(file->f_dentry->d_inode);
+	int value;
+	struct nsc_gpio_ops *amp = file->private_data;
+
+	value = amp->gpio_get(m);
+	if (put_user(value ? '1' : '0', buf))
+		return -EFAULT;
+
+	return 1;
+}
+
+/* common routines for both scx200_gpio and pc87360_gpio */
+EXPORT_SYMBOL(nsc_gpio_write);
+EXPORT_SYMBOL(nsc_gpio_read);
 
 static int __init nsc_gpio_init(void)
 {
@@ -34,12 +114,9 @@ static void __exit nsc_gpio_cleanup(void
 	printk(KERN_DEBUG NAME " cleanup\n");
 }
 
-/* prepare for
-   common routines for both scx200_gpio and pc87360_gpio
-EXPORT_SYMBOL(scx200_gpio_write);
-EXPORT_SYMBOL(scx200_gpio_read);
-EXPORT_SYMBOL(scx200_gpio_release);
-*/
-
 module_init(nsc_gpio_init);
 module_exit(nsc_gpio_cleanup);
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_DESCRIPTION("NatSemi GPIO Common Methods");
+MODULE_LICENSE("GPL");
diff -ruNp -X dontdiff -X exclude-diffs ax-10/drivers/char/scx200_gpio.c ax-11/drivers/char/scx200_gpio.c
--- ax-10/drivers/char/scx200_gpio.c	2006-06-17 01:23:47.000000000 -0600
+++ ax-11/drivers/char/scx200_gpio.c	2006-06-17 01:33:50.000000000 -0600
@@ -37,6 +37,12 @@ MODULE_PARM_DESC(major, "Major device nu
 
 extern void scx200_gpio_dump(unsigned index);
 
+extern ssize_t nsc_gpio_write(struct file *file, const char __user *data,
+			      size_t len, loff_t *ppos);
+
+extern ssize_t nsc_gpio_read(struct file *file, char __user *buf,
+			     size_t len, loff_t *ppos);
+
 struct nsc_gpio_ops scx200_access = {
 	.owner		= THIS_MODULE,
 	.gpio_config	= scx200_gpio_configure,
@@ -49,84 +55,6 @@ struct nsc_gpio_ops scx200_access = {
 	.gpio_current	= scx200_gpio_current
 };
 
-static ssize_t scx200_gpio_write(struct file *file, const char __user *data,
-				 size_t len, loff_t *ppos)
-{
-	unsigned m = iminor(file->f_dentry->d_inode);
-	struct nsc_gpio_ops *amp = file->private_data;
-	size_t i;
-	int err = 0;
-
-	for (i = 0; i < len; ++i) {
-		char c;
-		if (get_user(c, data + i))
-			return -EFAULT;
-		switch (c) {
-		case '0':
-			amp->gpio_set(m, 0);
-			break;
-		case '1':
-			amp->gpio_set(m, 1);
-			break;
-		case 'O':
-			printk(KERN_INFO NAME ": GPIO%d output enabled\n", m);
-			amp->gpio_config(m, ~1, 1);
-			break;
-		case 'o':
-			printk(KERN_INFO NAME ": GPIO%d output disabled\n", m);
-			amp->gpio_config(m, ~1, 0);
-			break;
-		case 'T':
-			printk(KERN_INFO NAME ": GPIO%d output is push pull\n", m);
-			amp->gpio_config(m, ~2, 2);
-			break;
-		case 't':
-			printk(KERN_INFO NAME ": GPIO%d output is open drain\n", m);
-			amp->gpio_config(m, ~2, 0);
-			break;
-		case 'P':
-			printk(KERN_INFO NAME ": GPIO%d pull up enabled\n", m);
-			amp->gpio_config(m, ~4, 4);
-			break;
-		case 'p':
-			printk(KERN_INFO NAME ": GPIO%d pull up disabled\n", m);
-			amp->gpio_config(m, ~4, 0);
-			break;
-
-		case 'v':
-			/* View Current pin settings */
-			amp->gpio_dump(m);
-			break;
-		case '\n':
-			/* end of settings string, do nothing */
-			break;
-		default:
-			printk(KERN_ERR NAME
-			       ": GPIO-%2d bad setting: chr<0x%2x>\n", m,
-			       (int)c);
-			err++;
-		}
-	}
-	if (err)
-		return -EINVAL;	/* full string handled, report error */
-
-	return len;
-}
-
-static ssize_t scx200_gpio_read(struct file *file, char __user *buf,
-				size_t len, loff_t *ppos)
-{
-	unsigned m = iminor(file->f_dentry->d_inode);
-	int value;
-	struct nsc_gpio_ops *amp = file->private_data;
-
-	value = amp->gpio_get(m);
-	if (put_user(value ? '1' : '0', buf))
-		return -EFAULT;
-
-	return 1;
-}
-
 static int scx200_gpio_open(struct inode *inode, struct file *file)
 {
 	unsigned m = iminor(inode);
@@ -145,8 +73,8 @@ static int scx200_gpio_release(struct in
 
 static struct file_operations scx200_gpio_fops = {
 	.owner   = THIS_MODULE,
-	.write   = scx200_gpio_write,
-	.read    = scx200_gpio_read,
+	.write   = nsc_gpio_write,
+	.read    = nsc_gpio_read,
 	.open    = scx200_gpio_open,
 	.release = scx200_gpio_release,
 };
diff -ruNp -X dontdiff -X exclude-diffs ax-10/include/linux/nsc_gpio.h ax-11/include/linux/nsc_gpio.h
--- ax-10/include/linux/nsc_gpio.h	2006-06-17 01:20:34.000000000 -0600
+++ ax-11/include/linux/nsc_gpio.h	2006-06-17 01:33:50.000000000 -0600
@@ -31,3 +31,8 @@ struct nsc_gpio_ops {
 	int	(*gpio_current)	(unsigned iminor);
 };
 
+extern ssize_t nsc_gpio_write(struct file *file, const char __user *data,
+			      size_t len, loff_t *ppos);
+
+extern ssize_t nsc_gpio_read(struct file *file, char __user *buf,
+			     size_t len, loff_t *ppos);


