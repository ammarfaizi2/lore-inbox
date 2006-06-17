Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWFQShK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWFQShK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWFQShJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:37:09 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:2676 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750828AbWFQShI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:37:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=elkrwMH04U/YffHPpyQWOaAX2SGFn7Vy9x0Bk99zpBIGr8ULP/4GKH0Gq59uJjkflGD1sDTwWRSphIW+R3SbJQs4f2RKJhU66zpk8sblm9JoJ4yG7AeDFB/kRFtQM1D7x5L9sN8zkjMzWgwMe65k2wapKHctghoB+xKcrL8aD8U=
Message-ID: <44944BD0.5050302@gmail.com>
Date: Sat, 17 Jun 2006 12:37:04 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 16/20] chardev: GPIO for SCx200 & PC-8736x:  fix gpio_current,
 use shadow regs
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

16/20. patch.shadow-current

Add a working gpio_current() to pc8736x_gpio.c (the previous
implementation just threw a dev_warn), and fix gpio_change() to use
gpio_current() rather than the incorrect (and temporary) gpio_get().
Initialize shadow-regs so this all works.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.shadow-current
 pc8736x_gpio.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-15/drivers/char/pc8736x_gpio.c ax-16/drivers/char/pc8736x_gpio.c
--- ax-15/drivers/char/pc8736x_gpio.c	2006-06-17 01:45:49.000000000 -0600
+++ ax-16/drivers/char/pc8736x_gpio.c	2006-06-17 01:48:50.000000000 -0600
@@ -33,6 +33,7 @@ MODULE_PARM_DESC(major, "Major device nu
 
 static DEFINE_SPINLOCK(pc8736x_gpio_config_lock);
 static unsigned pc8736x_gpio_base;
+static u8 pc8736x_gpio_shadow[4];
 
 #define SIO_BASE1       0x2E	/* 1st command-reg to check */
 #define SIO_BASE2       0x4E	/* alt command-reg to check */
@@ -184,6 +185,7 @@ static void pc8736x_gpio_set(unsigned mi
 	val = inb_p(pc8736x_gpio_base + port_offset[port] + PORT_IN);
 
 	dev_dbg(&pdev->dev, "wrote %x, read: %x\n", curval, val);
+	pc8736x_gpio_shadow[port] = val;
 }
 
 static void pc8736x_gpio_set_high(unsigned index)
@@ -196,15 +198,18 @@ static void pc8736x_gpio_set_low(unsigne
 	pc8736x_gpio_set(index, 0);
 }
 
-static int pc8736x_gpio_current(unsigned index)
+static int pc8736x_gpio_current(unsigned minor)
 {
-	dev_warn(&pdev->dev, "pc8736x_gpio_current unimplemented\n");
-	return 0;
+	int port, bit;
+	minor &= 0x1f;
+	port = minor >> 3;
+	bit = minor & 7;
+	return pc8736x_gpio_shadow[port] >> bit & 0x01;
 }
 
 static void pc8736x_gpio_change(unsigned index)
 {
-	pc8736x_gpio_set(index, !pc8736x_gpio_get(index));
+	pc8736x_gpio_set(index, !pc8736x_gpio_current(index));
 }
 
 extern void nsc_gpio_dump(struct nsc_gpio_ops *amp, unsigned iminor);
@@ -240,6 +245,18 @@ static struct file_operations pc8736x_gp
 	.read	= nsc_gpio_read,
 };
 
+static void __init pc8736x_init_shadow(void)
+{
+	int port;
+
+	/* read the current values driven on the GPIO signals */
+	for (port = 0; port < 4; ++port)
+		pc8736x_gpio_shadow[port]
+		    = inb_p(pc8736x_gpio_base + port_offset[port]
+			    + PORT_OUT);
+
+}
+
 static int __init pc8736x_gpio_init(void)
 {
 	int r, rc;
@@ -306,5 +323,7 @@ static void __exit pc8736x_gpio_cleanup(
 	unregister_chrdev(major, DEVNAME);
 }
 
+EXPORT_SYMBOL(pc8736x_access);
+
 module_init(pc8736x_gpio_init);
 module_exit(pc8736x_gpio_cleanup);


