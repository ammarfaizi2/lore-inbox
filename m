Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbTDCTxR 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261492AbTDCTxR 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:53:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:46050 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263573AbTDCTvd 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:51:33 -0500
Date: Thu, 3 Apr 2003 12:03:08 +0000
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: arrays@hp.com, steve.cameron@hp.com
Subject: [PATCH] reduce stack in cpqarray.c::ida_ioctl()
Message-Id: <20030403120308.620e5a14.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch to 2.5.66 reduces stack usage in ida_ioctl() by about
0x500 bytes (on x86).

There is a possibility that the allocation here should be done one time
only and the buffer pointer saved for re-use instead of allocating it
on each call to ida_ioctl.  If that's desirable, I'll have a few
questions.

Comments on the patch?

Thanks,
--
~Randy


patch_name:	cpqarray-stack.patch
patch_version:	2003-04-02.21:10:01
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	reduce stack in block/cqparray.c::ida_ioctl()
		from 0x550 to 0x48;
product:	Linux
product_versions: linux-2566
changelog:	allocate and free <ida_ioctl_t>
maintainer:	Steve Cameron: arrays@hp.com, steve.cameron@hp.com
diffstat:	=
 drivers/block/cpqarray.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)


diff -Naur ./drivers/block/cpqarray.c%IDAIOC ./drivers/block/cpqarray.c
--- ./drivers/block/cpqarray.c%IDAIOC	2003-03-24 14:00:03.000000000 -0800
+++ ./drivers/block/cpqarray.c	2003-04-02 20:05:57.000000000 -0800
@@ -1021,7 +1021,7 @@
 	int diskinfo[4];
 	struct hd_geometry *geo = (struct hd_geometry *)arg;
 	ida_ioctl_t *io = (ida_ioctl_t*)arg;
-	ida_ioctl_t my_io;
+	ida_ioctl_t *my_io;
 
 	switch(cmd) {
 	case HDIO_GETGEO:
@@ -1046,11 +1046,19 @@
 		return 0;
 	case IDAPASSTHRU:
 		if (!capable(CAP_SYS_RAWIO)) return -EPERM;
-		if (copy_from_user(&my_io, io, sizeof(my_io)))
-			return -EFAULT;
-		error = ida_ctlr_ioctl(ctlr, dsk, &my_io);
-		if (error) return error;
-		return copy_to_user(io, &my_io, sizeof(my_io)) ? -EFAULT : 0;
+		my_io = kmalloc(sizeof(ida_ioctl_t), GFP_KERNEL);
+		if (!my_io)
+			return -ENOMEM;
+		if (copy_from_user(my_io, io, sizeof(*my_io))) {
+			error = -EFAULT;
+			goto iocfree;
+		}
+		error = ida_ctlr_ioctl(ctlr, dsk, my_io);
+		if (error) goto iocfree;
+		error = copy_to_user(io, my_io, sizeof(*my_io)) ? -EFAULT : 0;
+  iocfree:
+		kfree(my_io);
+		return error;
 	case IDAGETCTLRSIG:
 		if (!arg) return -EINVAL;
 		put_user(hba[ctlr]->ctlr_sig, (int*)arg);
