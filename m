Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUD3S1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUD3S1V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbUD3S1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:27:21 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:61343 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S265204AbUD3S0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:26:42 -0400
Date: Fri, 30 Apr 2004 14:26:41 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Simon Kelley <simon@thekelleys.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] Crash in atmel_cs due to fake device
Message-ID: <Pine.LNX.4.58.0404301413440.4502@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Simon and everybody!

Since PCMCIA devices are not devices for the kernel, atmel_cs uses a fake
device for calling request_firmware().  The fake device has .bus_id
initialized, but it's not enough for Linux 2.6.6-rc3.  The kernel would
oops while trying to create a link from /sys/class/firmware/pcmcia/device
to the location of the device in sysfs.

To work around this problem, .kobj.k_name should be defined in the fake
device.  I know, it's ugly as hell, but I don't see a better solution
until PCMCIA device drivers are converted to the device model.

The patch has been compile tested only, but I have tested a similar patch
with another driver, which is not in the kernel yet (spectrum_cs).  I'm
quite sure that atmel_cs is affected by this problem.

=============================
--- linux.orig/drivers/net/wireless/atmel_cs.c
+++ linux/drivers/net/wireless/atmel_cs.c
@@ -350,6 +350,9 @@ static struct {
 /* This is strictly temporary, until PCMCIA devices get integrated into the device model. */
 static struct device atmel_device = {
         .bus_id    = "pcmcia",
+	.kobj = {
+		.k_name = "atmel_cs"
+	}
 };

 static void atmel_config(dev_link_t *link)
=============================

-- 
Regards,
Pavel Roskin
