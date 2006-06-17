Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWFQSeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWFQSeF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 14:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWFQSeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 14:34:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:39536 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750803AbWFQSeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 14:34:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=esN0+5azLeLXYCZ3sEUt9VFVl1RjJireRKPwo7wGleybZF0wTGD6kh5WMokGLZZyaVC221TkW0JdXfZtaaMhV3inkyd6vF1ViqMkXKCZ1vKfT8n2DwNlF7oyTYFsBfLcHKTiNx7hqgY3jpuBeu3jNfmlBBEF4A9umXQODZndZYA=
Message-ID: <44944B12.4080002@gmail.com>
Date: Sat, 17 Jun 2006 12:33:54 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [patch -mm 08/20] chardev: GPIO for SCx200 & PC-8736x:  add gpio-ops
 vtable
References: <448DB57F.2050006@gmail.com> <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
In-Reply-To: <cfe85dfa0606121150y369f6beeqc643a1fe5c7ce69b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

8/20. patch.access-vtable

Abstract the gpio operations into a new nsc_gpio_ops vtable.  

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>

---

diffstat gpio-scx/patch.access-vtable
 drivers/char/scx200_gpio.c |   13 +++++++++++++
 include/linux/nsc_gpio.h   |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff -ruNp -X dontdiff -X exclude-diffs ax-7/drivers/char/scx200_gpio.c ax-8/drivers/char/scx200_gpio.c
--- ax-7/drivers/char/scx200_gpio.c	2006-06-17 01:13:26.000000000 -0600
+++ ax-8/drivers/char/scx200_gpio.c	2006-06-17 01:20:34.000000000 -0600
@@ -20,6 +20,7 @@
 #include <linux/cdev.h>
 
 #include <linux/scx200_gpio.h>
+#include <linux/nsc_gpio.h>
 
 #define NAME "scx200_gpio"
 #define DEVNAME NAME
@@ -36,6 +37,18 @@ MODULE_PARM_DESC(major, "Major device nu
 
 extern void scx200_gpio_dump(unsigned index);
 
+struct nsc_gpio_ops scx200_access = {
+	.owner		= THIS_MODULE,
+	.gpio_config	= scx200_gpio_configure,
+	.gpio_dump	= scx200_gpio_dump,
+	.gpio_get	= scx200_gpio_get,
+	.gpio_set	= scx200_gpio_set,
+	.gpio_set_high	= scx200_gpio_set_high,
+	.gpio_set_low	= scx200_gpio_set_low,
+	.gpio_change	= scx200_gpio_change,
+	.gpio_current	= scx200_gpio_current
+};
+
 static ssize_t scx200_gpio_write(struct file *file, const char __user *data,
 				 size_t len, loff_t *ppos)
 {
diff -ruNp -X dontdiff -X exclude-diffs ax-7/include/linux/nsc_gpio.h ax-8/include/linux/nsc_gpio.h
--- ax-7/include/linux/nsc_gpio.h	1969-12-31 17:00:00.000000000 -0700
+++ ax-8/include/linux/nsc_gpio.h	2006-06-17 01:20:34.000000000 -0600
@@ -0,0 +1,33 @@
+/**
+   nsc_gpio.c
+
+   National Semiconductor GPIO common access methods.
+
+   struct nsc_gpio_ops abstracts the low-level access
+   operations for the GPIO units on 2 NSC chip families; the GEODE
+   integrated CPU, and the PC-8736[03456] integrated PC-peripheral
+   chips.
+
+   The GPIO units on these chips have the same pin architecture, but
+   the access methods differ.  Thus, scx200_gpio and pc8736x_gpio
+   implement their own versions of these routines; and use the common
+   file-operations routines implemented in nsc_gpio module.
+
+   Copyright (c) 2005 Jim Cromie <jim.cromie@gmail.com>
+
+   NB: this work was tested on the Geode SC-1100 and PC-87366 chips.
+   NSC sold the GEODE line to AMD, and the PC-8736x line to Winbond.
+*/
+
+struct nsc_gpio_ops {
+	struct module*	owner;
+	u32	(*gpio_config)	(unsigned iminor, u32 mask, u32 bits);
+	void	(*gpio_dump)	(unsigned iminor);
+	int	(*gpio_get)	(unsigned iminor);
+	void	(*gpio_set)	(unsigned iminor, int state);
+	void	(*gpio_set_high)(unsigned iminor);
+	void	(*gpio_set_low)	(unsigned iminor);
+	void	(*gpio_change)	(unsigned iminor);
+	int	(*gpio_current)	(unsigned iminor);
+};
+


