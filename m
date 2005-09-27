Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVI0NwH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVI0NwH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 09:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVI0NwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 09:52:06 -0400
Received: from mx.laposte.net ([81.255.54.11]:6423 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S964945AbVI0NwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 09:52:05 -0400
Message-ID: <43392BF9.30906@laposte.net>
Date: Tue, 27 Sep 2005 13:24:41 +0200
From: Laurent Meunier <meunier.laurent@laposte.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mmcclell@bigfoot.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ov511-2.28 patch for 2.6.12 kernel compat.
Content-Type: multipart/mixed;
 boundary="------------040606030309040102020203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040606030309040102020203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear Mark,

Here is a patch for you to apply to your ov511-2.28 driver. It's based 
on the patch made by Vassilli Khachaturov 
(http://lkml.org/lkml/2005/6/8/242).

This patch basically remove references to the 'id' field from the static 
struct i2c_client client_template in ovcamchip_core.c, tda7313.c and 
saa7111-new.c) and update a deprecated function (usb_unlink_urb -> 
usb_kill_urb).

Tested on ArchLinux 0.7 with kernel v2.6.12 and webcam philips toucam II.

Regards,
Laurent


PS: I haven't subscribed to the linux-kernel mailing list and I would 
like to be personally CC'ed the answers/comments posted to the list

--------------040606030309040102020203
Content-Type: text/plain;
 name="ov511-2.28_linux-2.6.12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ov511-2.28_linux-2.6.12.patch"

diff -rbup ov511-2.28-orig/ov511_core.c ov511-2.28-new/ov511_core.c
--- ov511-2.28-orig/ov511_core.c	2004-07-13 13:54:22.000000000 +0200
+++ ov511-2.28-new/ov511_core.c	2005-09-24 13:59:04.000000000 +0200
@@ -3547,7 +3547,11 @@ ov51x_unlink_isoc(struct usb_ov511 *ov)
 	/* Unschedule all of the iso td's */
 	for (n = OV511_NUMSBUF - 1; n >= 0; n--) {
 		if (ov->sbuf[n].urb) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 12)
+			usb_kill_urb(ov->sbuf[n].urb);
+#else
 			usb_unlink_urb(ov->sbuf[n].urb);
+#endif
 			usb_free_urb(ov->sbuf[n].urb);
 			ov->sbuf[n].urb = NULL;
 		}
@@ -4881,12 +4885,18 @@ ov51x_mmap(struct file *file, struct vm_
 
 	pos = (unsigned long)ov->fbuf;
 	while (size > 0) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 11)
+		page = vmalloc_to_pfn((void *)pos);
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE,
+				     PAGE_SHARED)) {
+#else
 		page = kvirt_to_pa(pos);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 3) || defined(RH9_REMAP)
+# if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 3) || defined(RH9_REMAP)
 		if (remap_page_range(vma, start, page, PAGE_SIZE,
 				     PAGE_SHARED)) {
-#else
+# else
 		if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED)) {
+# endif
 #endif
 			up(&ov->lock);
 			return -EAGAIN;
diff -rbup ov511-2.28-orig/ovcamchip_core.c ov511-2.28-new/ovcamchip_core.c
--- ov511-2.28-orig/ovcamchip_core.c	2004-07-16 12:58:25.000000000 +0200
+++ ov511-2.28-new/ovcamchip_core.c	2005-09-24 13:54:11.000000000 +0200
@@ -582,7 +582,9 @@ static struct i2c_driver driver = {
 
 static struct i2c_client client_template = {
 	I2C_DEVNAME("(unset)"),
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 12)
 	.id =		-1,
+#endif
 	.driver =	&driver,
 };
 
diff -rbup ov511-2.28-orig/ovfx2.c ov511-2.28-new/ovfx2.c
--- ov511-2.28-orig/ovfx2.c	2004-07-16 01:32:08.000000000 +0200
+++ ov511-2.28-new/ovfx2.c	2005-09-24 14:00:12.000000000 +0200
@@ -1678,7 +1678,11 @@ ovfx2_unlink_bulk(struct usb_ovfx2 *ov)
 	/* Unschedule all of the bulk td's */
 	for (n = OVFX2_NUMSBUF - 1; n >= 0; n--) {
 		if (ov->sbuf[n].urb) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 12)
 			usb_unlink_urb(ov->sbuf[n].urb);
+#else
+			usb_unlink_urb(ov->sbuf[n].urb);
+#endif
 			usb_free_urb(ov->sbuf[n].urb);
 			ov->sbuf[n].urb = NULL;
 		}
@@ -2502,12 +2506,18 @@ ovfx2_mmap(struct file *file, struct vm_
 
 	pos = (unsigned long)ov->fbuf;
 	while (size > 0) {
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 11)
+		page = vmalloc_to_pfn((void *)pos);
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE,
+				     PAGE_SHARED)) {
+#else
 		page = kvirt_to_pa(pos);
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 3) || defined(RH9_REMAP)
+# if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 5, 3) || defined(RH9_REMAP)
 		if (remap_page_range(vma, start, page, PAGE_SIZE,
 				     PAGE_SHARED)) {
-#else
+# else
 		if (remap_page_range(start, page, PAGE_SIZE, PAGE_SHARED)) {
+# endif
 #endif
 			up(&ov->lock);
 			return -EAGAIN;
diff -rbup ov511-2.28-orig/saa7111-new.c ov511-2.28-new/saa7111-new.c
--- ov511-2.28-orig/saa7111-new.c	2004-07-13 14:04:46.000000000 +0200
+++ ov511-2.28-new/saa7111-new.c	2005-09-24 13:54:56.000000000 +0200
@@ -520,7 +520,9 @@ static struct i2c_driver driver = {
 
 static struct i2c_client client_template = {
 	I2C_DEVNAME("(unset)"),
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 12)
 	.id =		-1,
+#endif
 	.driver =	&driver
 };
 
diff -rbup ov511-2.28-orig/tda7313.c ov511-2.28-new/tda7313.c
--- ov511-2.28-orig/tda7313.c	2004-07-15 12:06:44.000000000 +0200
+++ ov511-2.28-new/tda7313.c	2005-09-24 13:56:13.000000000 +0200
@@ -202,7 +202,9 @@ static struct i2c_driver driver = {
 
 static struct i2c_client client_template = {
 	I2C_DEVNAME("tda7313"),
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 12)
 	.id      = -1,
+#endif
 	.driver  = &driver,
 };
 

--------------040606030309040102020203--
