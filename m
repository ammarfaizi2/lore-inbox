Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVDJNON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVDJNON (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 09:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDJNON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 09:14:13 -0400
Received: from hermes.domdv.de ([193.102.202.1]:16403 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261493AbVDJNOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 09:14:03 -0400
Message-ID: <42592697.8060909@domdv.de>
Date: Sun, 10 Apr 2005 15:13:59 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pavel@suse.cz, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH] zero disk pages used by swsusp on resume
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040704000506030306030407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040704000506030306030407
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

It may not be desireable to leave swsusp saved pages on disk after
resume as they may contain sensitive data that was never intended to be
stored on disk in an way (e.g. in-kernel dm-crypt keys, mlocked pages).

The attached simple patch against 2.6.11.2 should fix this by zeroing
the swap pages after reading them.

The patch is by no means perfect. Especially it isn't invoked on error
conditions. However it seems to work during regular operation.

Note that it is not possible to do this from userspace in a performant
way, one has to zero the whole swap partition used for swsusp to achive
a similar effect which quite often means clearing 2GB instead of about a
few 100MB. The difference in speed and power consumption is important
especially for laptops when resuming on battery. The userspace method
also allows for a window in which at least some of the data may still be
read.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de

--------------040704000506030306030407
Content-Type: text/plain;
 name="swsusp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp.diff"

--- linux-2.6.11.2/kernel/power/swsusp.c.ast	2005-04-10 14:08:55.000000000 +0200
+++ linux-2.6.11.2/kernel/power/swsusp.c	2005-04-10 14:24:10.000000000 +0200
@@ -112,6 +112,10 @@
 
 static struct swsusp_info swsusp_info;
 
+static struct swsusp_clear {
+	char zero[PAGE_SIZE];
+} __attribute__((packed, aligned(PAGE_SIZE))) swsusp_clear __initdata;
+
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
@@ -1169,6 +1173,29 @@
 
 }
 
+static int __init data_clear(void)
+{
+	struct pbe * p;
+	int error = 0;
+	int i;
+	int mod = nr_copy_pages / 100;
+
+	if (!mod)
+		mod = 1;
+
+	memset(&swsusp_clear, 0, sizeof(swsusp_clear));
+
+	printk( "Clearing disk data (%d pages):     ", nr_copy_pages );
+	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
+		error = bio_write_page(swp_offset(p->swap_address),
+				  (void *)&swsusp_clear);
+	}
+	printk(" %d done.\n",i);
+	return error;
+}
+
 extern dev_t __init name_to_dev_t(const char *line);
 
 static int __init read_pagedir(void)
@@ -1208,6 +1235,8 @@
 		return error;
 	if ((error = data_read()))
 		free_pages((unsigned long)pagedir_nosave, pagedir_order);
+	else
+		data_clear();
 	return error;
 }
 

--------------040704000506030306030407--
