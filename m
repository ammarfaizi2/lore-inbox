Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWABPjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWABPjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 10:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbWABPjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 10:39:51 -0500
Received: from bay103-f8.bay103.hotmail.com ([65.54.174.18]:47762 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S1750747AbWABPjv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 10:39:51 -0500
Message-ID: <BAY103-F835CFFD193D6F76C5527FDF2D0@phx.gbl>
X-Originating-IP: [70.228.26.64]
X-Originating-Email: [dravet@hotmail.com]
From: "Jason Dravet" <dravet@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-parport@lists.infradead.org
Subject: [RFC]: add sysfs support to parport_pc, v3
Date: Mon, 02 Jan 2006 09:39:50 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 02 Jan 2006 15:39:50.0661 (UTC) FILETIME=[C4C70350:01C60FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a new patch to parport_pc that adds sysfs and thus udev support to 
parport_pc.  I fixed my earilier problem of the kernel oops (I forgot the 
class_destory) and I can insmod and rmmod this module all day long with no 
side effects.  I do have one question why do both lp and parport nodes have 
to be created?

What do you think of this patch?  What would be the next step to get this 
into the kernel?

Thanks,
Jason Dravet

signed-off-by: Jason Dravet <dravet@hotmail.com>

--- /usr/src/linux-2.6.14/drivers/parport/parport_pc.c.orig	2005-12-30 
13:52:48.000000000 -0600
+++ /usr/src/linux-2.6.14/drivers/parport/parport_pc.c	2006-01-01 
11:29:05.000000000 -0600
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
@@ -3406,6 +3416,12 @@ static void __exit parport_pc_exit(void)
	if (pnp_registered_parport)
		pnp_unregister_driver (&parport_pc_pnp_driver);

+	for (countports--; countports >=0; countports--) {
+		class_device_destroy(parallel_class, MKDEV(99, countports));
+		class_device_destroy(parallel_class, MKDEV(6, countports));
+	}
+	class_destroy(parallel_class);
+
	spin_lock(&ports_lock);
	while (!list_empty(&ports_list)) {
		struct parport_pc_private *priv;


