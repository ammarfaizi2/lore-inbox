Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWFQSgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWFQSgX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbWFQSgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:36:23 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:883 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750823AbWFQSgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:36:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qW0c4xdhYK8xdmKg+ho4k3ClCfJFPcNwXC6JwrFZO4SVgCsRwQkpEr9Sujfh5fgqLnLWR3I15cZt/Me9pOLfJ0BBbI1eKbISZFOiXyzIpoIBfOytHZh3F29nSv9mZUXGAQfzCOQCA2fkYRpM/Gm/jbN/wdMp7jAAgy25xW5aV8w=
Message-ID: <44944BA3.5090905@gmail.com>
Date: Sat, 17 Jun 2006 12:36:19 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 15/20] chardev: GPIO for SCx200 & PC-8736x: use dev_dbg
 in common module
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

15/20. patch.devdbg-nscgpio

Use of dev_dbg() and friends is considered good practice.  dev_dbg()
needs a struct device *devp, but nsc_gpio is only a helper module, so
it doesnt have/need its own.  To provide devp to the user-modules
(scx200 & pc8736x _gpio), we add it to the vtable, and set it during
init.

Also squeeze nsc_gpio_dump()'s format a little.

[  199.259879]  pc8736x_gpio.0: io09: 0x0044 TS OD PUE  EDGE LO DEBOUNCE


Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.devdbg-nscgpio
 drivers/char/nsc_gpio.c     |   45 ++++++++++++++++++++++++--------------------
 drivers/char/pc8736x_gpio.c |    3 +-
 drivers/char/scx200_gpio.c  |   11 ++--------
 include/linux/nsc_gpio.h    |    6 ++++-
 4 files changed, 35 insertions(+), 30 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-14/drivers/char/nsc_gpio.c ax-15/drivers/char/nsc_gpio.c
--- ax-14/drivers/char/nsc_gpio.c	2006-06-17 01:39:58.000000000 -0600
+++ ax-15/drivers/char/nsc_gpio.c	2006-06-17 01:45:49.000000000 -0600
@@ -14,22 +14,27 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/nsc_gpio.h>
+#include <linux/platform_device.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
 #define NAME "nsc_gpio"
 
-void nsc_gpio_dump(unsigned index, u32 config)
+void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index)
 {
-	printk(KERN_INFO NAME ": GPIO-%02u: 0x%08lx %s %s %s %s %s %s %s\n",
-	       index, (unsigned long)config,
-	       (config & 1) ? "OE" : "TS",      /* output-enabled/tristate */
-	       (config & 2) ? "PP" : "OD",      /* push pull / open drain */
-	       (config & 4) ? "PUE" : "PUD",    /* pull up enabled/disabled */
-	       (config & 8) ? "LOCKED" : "",    /* locked / unlocked */
-	       (config & 16) ? "LEVEL" : "EDGE",/* level/edge input */
-	       (config & 32) ? "HI" : "LO",     /* trigger on rise/fall edge */
-               (config & 64) ? "DEBOUNCE" : "");        /* debounce */
+	/* retrieve current config w/o changing it */
+	u32 config = amp->gpio_config(index, ~0, 0);
+
+	/* user requested via 'v' command, so its INFO */
+	dev_info(amp->dev, "io%02u: 0x%04x %s %s %s %s %s %s %s\n",
+		 index, config,
+		 (config & 1) ? "OE" : "TS",      /* output-enabled/tristate */
+		 (config & 2) ? "PP" : "OD",      /* push pull / open drain */
+		 (config & 4) ? "PUE" : "PUD",    /* pull up enabled/disabled */
+		 (config & 8) ? "LOCKED" : "",    /* locked / unlocked */
+		 (config & 16) ? "LEVEL" : "EDGE",/* level/edge input */
+		 (config & 32) ? "HI" : "LO",     /* trigger on rise/fall edge */
+		 (config & 64) ? "DEBOUNCE" : "");        /* debounce */
 }
 
 ssize_t nsc_gpio_write(struct file *file, const char __user *data,
@@ -37,6 +42,7 @@ ssize_t nsc_gpio_write(struct file *file
 {
 	unsigned m = iminor(file->f_dentry->d_inode);
 	struct nsc_gpio_ops *amp = file->private_data;
+	struct device *dev = amp->dev;
 	size_t i;
 	int err = 0;
 
@@ -52,42 +58,41 @@ ssize_t nsc_gpio_write(struct file *file
 			amp->gpio_set(m, 1);
 			break;
 		case 'O':
-			printk(KERN_INFO NAME ": GPIO%d output enabled\n", m);
+			dev_dbg(dev, "GPIO%d output enabled\n", m);
 			amp->gpio_config(m, ~1, 1);
 			break;
 		case 'o':
-			printk(KERN_INFO NAME ": GPIO%d output disabled\n", m);
+			dev_dbg(dev, "GPIO%d output disabled\n", m);
 			amp->gpio_config(m, ~1, 0);
 			break;
 		case 'T':
-			printk(KERN_INFO NAME ": GPIO%d output is push pull\n",
+			dev_dbg(dev, "GPIO%d output is push pull\n",
 			       m);
 			amp->gpio_config(m, ~2, 2);
 			break;
 		case 't':
-			printk(KERN_INFO NAME ": GPIO%d output is open drain\n",
+			dev_dbg(dev, "GPIO%d output is open drain\n",
 			       m);
 			amp->gpio_config(m, ~2, 0);
 			break;
 		case 'P':
-			printk(KERN_INFO NAME ": GPIO%d pull up enabled\n", m);
+			dev_dbg(dev, "GPIO%d pull up enabled\n", m);
 			amp->gpio_config(m, ~4, 4);
 			break;
 		case 'p':
-			printk(KERN_INFO NAME ": GPIO%d pull up disabled\n", m);
+			dev_dbg(dev, "GPIO%d pull up disabled\n", m);
 			amp->gpio_config(m, ~4, 0);
 			break;
 		case 'v':
 			/* View Current pin settings */
-			amp->gpio_dump(m);
+			amp->gpio_dump(amp, m);
 			break;
 		case '\n':
 			/* end of settings string, do nothing */
 			break;
 		default:
-			printk(KERN_ERR NAME
-			       ": GPIO-%2d bad setting: chr<0x%2x>\n", m,
-			       (int)c);
+			dev_err(dev, "io%2d bad setting: chr<0x%2x>\n",
+				m, (int)c);
 			err++;
 		}
 	}
diff -ruNp -X dontdiff -X exclude-diffs ax-14/drivers/char/pc8736x_gpio.c ax-15/drivers/char/pc8736x_gpio.c
--- ax-14/drivers/char/pc8736x_gpio.c	2006-06-17 01:42:57.000000000 -0600
+++ ax-15/drivers/char/pc8736x_gpio.c	2006-06-17 01:45:49.000000000 -0600
@@ -207,7 +207,7 @@ static void pc8736x_gpio_change(unsigned
 	pc8736x_gpio_set(index, !pc8736x_gpio_get(index));
 }
 
-extern void nsc_gpio_dump(unsigned iminor);
+extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned iminor);
 
 static struct nsc_gpio_ops pc8736x_access = {
 	.owner		= THIS_MODULE,
@@ -260,6 +260,7 @@ static int __init pc8736x_gpio_init(void
                 platform_device_put(pdev);
 		return -ENODEV;
 	}
+	pc8736x_access.dev = &pdev->dev;
 
 	/* Verify that chip and it's GPIO unit are both enabled.
 	   My BIOS does this, so I take minimum action here
diff -ruNp -X dontdiff -X exclude-diffs ax-14/drivers/char/scx200_gpio.c ax-15/drivers/char/scx200_gpio.c
--- ax-14/drivers/char/scx200_gpio.c	2006-06-17 01:36:56.000000000 -0600
+++ ax-15/drivers/char/scx200_gpio.c	2006-06-17 01:45:49.000000000 -0600
@@ -35,14 +35,6 @@ static int major = 0;		/* default to dyn
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 
-extern void nsc_gpio_dump(unsigned index);
-
-extern ssize_t nsc_gpio_write(struct file *file, const char __user *data,
-			      size_t len, loff_t *ppos);
-
-extern ssize_t nsc_gpio_read(struct file *file, char __user *buf,
-			     size_t len, loff_t *ppos);
-
 struct nsc_gpio_ops scx200_access = {
 	.owner		= THIS_MODULE,
 	.gpio_config	= scx200_gpio_configure,
@@ -101,6 +93,9 @@ static int __init scx200_gpio_init(void)
 	if (rc)
 		goto undo_platform_device_add;
 
+	/* nsc_gpio uses dev_dbg(), so needs this */
+	scx200_access.dev = &pdev->dev;
+
 	if (major)
 		rc = register_chrdev_region(dev, num_devs, "scx200_gpio");
 	else {
diff -ruNp -X dontdiff -X exclude-diffs ax-14/include/linux/nsc_gpio.h ax-15/include/linux/nsc_gpio.h
--- ax-14/include/linux/nsc_gpio.h	2006-06-17 01:33:50.000000000 -0600
+++ ax-15/include/linux/nsc_gpio.h	2006-06-17 01:45:49.000000000 -0600
@@ -22,13 +22,14 @@
 struct nsc_gpio_ops {
 	struct module*	owner;
 	u32	(*gpio_config)	(unsigned iminor, u32 mask, u32 bits);
-	void	(*gpio_dump)	(unsigned iminor);
+	void	(*gpio_dump)	(struct nsc_gpio_ops *amp, unsigned iminor);
 	int	(*gpio_get)	(unsigned iminor);
 	void	(*gpio_set)	(unsigned iminor, int state);
 	void	(*gpio_set_high)(unsigned iminor);
 	void	(*gpio_set_low)	(unsigned iminor);
 	void	(*gpio_change)	(unsigned iminor);
 	int	(*gpio_current)	(unsigned iminor);
+	struct device*	dev;	/* for dev_dbg() support, set in init  */
 };
 
 extern ssize_t nsc_gpio_write(struct file *file, const char __user *data,
@@ -36,3 +37,6 @@ extern ssize_t nsc_gpio_write(struct fil
 
 extern ssize_t nsc_gpio_read(struct file *file, char __user *buf,
 			     size_t len, loff_t *ppos);
+
+extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned index);
+


