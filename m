Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVLaTWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVLaTWe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 14:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbVLaTWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 14:22:34 -0500
Received: from bay103-f29.bay103.hotmail.com ([65.54.174.39]:26102 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S965041AbVLaTWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 14:22:34 -0500
Message-ID: <BAY103-F29FBDD5808DA08FBB21D39DF2B0@phx.gbl>
X-Originating-IP: [68.75.161.216]
X-Originating-Email: [dravet@hotmail.com]
In-Reply-To: <Pine.LNX.4.61.0512311830030.7910@yvahk01.tjqt.qr>
From: "Jason Dravet" <dravet@hotmail.com>
To: jengelh@linux01.gwdg.de
Cc: linux-kernel@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: RFC: add udev support to parport_pc
Date: Sat, 31 Dec 2005 13:22:33 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 31 Dec 2005 19:22:33.0491 (UTC) FILETIME=[8CD18E30:01C60E3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is version 2 of the patch.  It should address the issues pointed out so 
far.

Thanks,
Jason

--- /usr/src/linux-2.6.14/drivers/parport/parport_pc.c.orig	2005-12-30 
13:52:48.000000000 -0600
+++ /usr/src/linux-2.6.14/drivers/parport/parport_pc.c	2005-12-31 
13:17:42.000000000 -0600
@@ -14,6 +14,7 @@
  * More PCI support now conditional on CONFIG_PCI, 03/2001, Paul G.
  * Various hacks, Fred Barnes, 04/2001
  * Updated probing logic - Adam Belay <ambx1@neo.rr.com>
+ * Added sysfs and udev - Jason Dravet <dravet@hotmail.com>
  */

/* This driver should work with any hardware that is broadly compatible
@@ -55,6 +56,7 @@
#include <linux/pci.h>
#include <linux/pnp.h>
#include <linux/sysctl.h>
+#include <linux/sysfs.h>

#include <asm/io.h>
#include <asm/dma.h>
@@ -99,6 +101,9 @@ static struct superio_struct {	/* For Su
	int dma;
} superios[NR_SUPERIOS] __devinitdata = { {0,},};

+static struct class *parallel_class;
+int countports = 0;
+
static int user_specified;
#if defined(CONFIG_PARPORT_PC_SUPERIO) || \
        (defined(CONFIG_PARPORT_1284) && defined(CONFIG_PARPORT_PC_FIFO))
@@ -2232,6 +2237,11 @@ struct parport *parport_pc_probe_port (u
                                            is mandatory (see above) */
		p->dma = PARPORT_DMA_NONE;

+	parallel_class = class_create(THIS_MODULE, "lp");
+	class_device_create(parallel_class, NULL, MKDEV(6, countports), NULL, 
"lp%i", countports);
+	class_device_create(parallel_class, NULL, MKDEV(99, countports), NULL, 
"parport%i", countports);
+	countports++;
+
#ifdef CONFIG_PARPORT_PC_FIFO
	if (parport_ECP_supported(p) &&
	    p->dma != PARPORT_DMA_NOFIFO &&
@@ -3406,6 +3416,13 @@ static void __exit parport_pc_exit(void)
	if (pnp_registered_parport)
		pnp_unregister_driver (&parport_pc_pnp_driver);

+	printk (KERN_WARNING "countports = %i \n", countports);
+	for (countports--; countports >=0; countports--) {
+		printk (KERN_WARNING "countports loop = %i \n", countports);
+		class_device_destroy(parallel_class, MKDEV(99, countports));
+		class_device_destroy(parallel_class, MKDEV(6, countports));
+	}
+
	spin_lock(&ports_lock);
	while (!list_empty(&ports_list)) {
		struct parport_pc_private *priv;


