Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWFQSdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWFQSdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWFQSdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:33:25 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:17520 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750813AbWFQSdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:33:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FAA43nf0NP6UNnZq3twHLK3sJ9XRpReipB56K42P+UDE7gOMj/LX5/W7pGA6c/zgqf/wH2G6trlNGUjD/4JqDmg2Ef8YuygSJi8r+3KUleDx2gUwbCN7wJPKk92+L79DG9zmHtBhCSdrRce4bWIGWUGheJkiFsdlXXSzfAr0+o8=
Message-ID: <44944AF1.7080200@gmail.com>
Date: Sat, 17 Jun 2006 12:33:21 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 12/20] chardev: GPIO for SCx200 & PC-8736x: migrate gpio_dump
 to common module
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

12/20. patch.common-dump

Since the meaning of config-bits is the same for scx200 and pc8736x
_gpios, we can share a function to deliver this to user.  Since it is
called via the vtable, its also completely replaceable.
For now, we keep using printk...


Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.common-dump
 arch/i386/kernel/scx200.c  |   16 ----------------
 drivers/char/nsc_gpio.c    |   16 +++++++++++++++-
 drivers/char/scx200_gpio.c |    4 ++--
 3 files changed, 17 insertions(+), 19 deletions(-)

diff -ruNp -X dontdiff -X exclude-diffs ax-11/arch/i386/kernel/scx200.c ax-12/arch/i386/kernel/scx200.c
--- ax-11/arch/i386/kernel/scx200.c	2006-06-17 01:17:11.000000000 -0600
+++ ax-12/arch/i386/kernel/scx200.c	2006-06-17 01:36:56.000000000 -0600
@@ -110,21 +110,6 @@ u32 scx200_gpio_configure(unsigned index
 	return config;
 }
 
-void scx200_gpio_dump(unsigned index)
-{
-        u32 config = scx200_gpio_configure(index, ~0, 0);
-
-        printk(KERN_INFO NAME ": GPIO-%02u: 0x%08lx %s %s %s %s %s %s %s\n",
-               index, (unsigned long) config,
-               (config & 1) ? "OE"      : "TS",		/* output enabled / tristate */
-               (config & 2) ? "PP"      : "OD",		/* push pull / open drain */
-               (config & 4) ? "PUE"     : "PUD",	/* pull up enabled/disabled */
-               (config & 8) ? "LOCKED"  : "",		/* locked / unlocked */
-               (config & 16) ? "LEVEL"  : "EDGE",	/* level/edge input */
-               (config & 32) ? "HI"     : "LO",		/* trigger on rising/falling edge */ 
-               (config & 64) ? "DEBOUNCE" : "");	/* debounce */
-}
-
 static int __init scx200_init(void)
 {
 	printk(KERN_INFO NAME ": NatSemi SCx200 Driver\n");
@@ -144,5 +129,4 @@ module_exit(scx200_cleanup);
 EXPORT_SYMBOL(scx200_gpio_base);
 EXPORT_SYMBOL(scx200_gpio_shadow);
 EXPORT_SYMBOL(scx200_gpio_configure);
-EXPORT_SYMBOL(scx200_gpio_dump);
 EXPORT_SYMBOL(scx200_cb_base);
diff -ruNp -X dontdiff -X exclude-diffs ax-11/drivers/char/nsc_gpio.c ax-12/drivers/char/nsc_gpio.c
--- ax-11/drivers/char/nsc_gpio.c	2006-06-17 01:33:50.000000000 -0600
+++ ax-12/drivers/char/nsc_gpio.c	2006-06-17 01:36:56.000000000 -0600
@@ -19,6 +19,19 @@
 
 #define NAME "nsc_gpio"
 
+void nsc_gpio_dump(unsigned index, u32 config)
+{
+	printk(KERN_INFO NAME ": GPIO-%02u: 0x%08lx %s %s %s %s %s %s %s\n",
+	       index, (unsigned long)config,
+	       (config & 1) ? "OE" : "TS",      /* output-enabled/tristate */
+	       (config & 2) ? "PP" : "OD",      /* push pull / open drain */
+	       (config & 4) ? "PUE" : "PUD",    /* pull up enabled/disabled */
+	       (config & 8) ? "LOCKED" : "",    /* locked / unlocked */
+	       (config & 16) ? "LEVEL" : "EDGE",/* level/edge input */
+	       (config & 32) ? "HI" : "LO",     /* trigger on rise/fall edge */
+               (config & 64) ? "DEBOUNCE" : "");        /* debounce */
+}
+
 ssize_t nsc_gpio_write(struct file *file, const char __user *data,
 		       size_t len, loff_t *ppos)
 {
@@ -99,9 +112,10 @@ ssize_t nsc_gpio_read(struct file *file,
 	return 1;
 }
 
-/* common routines for both scx200_gpio and pc87360_gpio */
+/* common file-ops routines for both scx200_gpio and pc87360_gpio */
 EXPORT_SYMBOL(nsc_gpio_write);
 EXPORT_SYMBOL(nsc_gpio_read);
+EXPORT_SYMBOL(nsc_gpio_dump);
 
 static int __init nsc_gpio_init(void)
 {
diff -ruNp -X dontdiff -X exclude-diffs ax-11/drivers/char/scx200_gpio.c ax-12/drivers/char/scx200_gpio.c
--- ax-11/drivers/char/scx200_gpio.c	2006-06-17 01:33:50.000000000 -0600
+++ ax-12/drivers/char/scx200_gpio.c	2006-06-17 01:36:56.000000000 -0600
@@ -35,7 +35,7 @@ static int major = 0;		/* default to dyn
 module_param(major, int, 0);
 MODULE_PARM_DESC(major, "Major device number");
 
-extern void scx200_gpio_dump(unsigned index);
+extern void nsc_gpio_dump(unsigned index);
 
 extern ssize_t nsc_gpio_write(struct file *file, const char __user *data,
 			      size_t len, loff_t *ppos);
@@ -46,7 +46,7 @@ extern ssize_t nsc_gpio_read(struct file
 struct nsc_gpio_ops scx200_access = {
 	.owner		= THIS_MODULE,
 	.gpio_config	= scx200_gpio_configure,
-	.gpio_dump	= scx200_gpio_dump,
+	.gpio_dump	= nsc_gpio_dump,
 	.gpio_get	= scx200_gpio_get,
 	.gpio_set	= scx200_gpio_set,
 	.gpio_set_high	= scx200_gpio_set_high,


