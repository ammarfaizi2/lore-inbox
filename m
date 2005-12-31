Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965029AbVLaRUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbVLaRUD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 12:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbVLaRUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 12:20:03 -0500
Received: from bay103-f5.bay103.hotmail.com ([65.54.174.15]:1496 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S965029AbVLaRUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 12:20:01 -0500
Message-ID: <BAY103-F5ABE5F52E47CC9DD71D21DF2B0@phx.gbl>
X-Originating-IP: [69.222.162.187]
X-Originating-Email: [dravet@hotmail.com]
From: "Jason Dravet" <dravet@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-parport@lists.infradead.org
Subject: RFC: add udev support to parport_pc
Date: Sat, 31 Dec 2005 11:20:00 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 31 Dec 2005 17:20:01.0073 (UTC) FILETIME=[6E6F9A10:01C60E2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to parport_pc.c that adds udev support.  Without it sysfs 
does not have enough information to give to udev so the lp and parport nodes 
can be created.  The only problem I have is the kernel_oops when I do the 
following: insmod parport, insmod parport_pc, rmmod parport_pc, rmmod 
parport, insmod parport, insmod parport_pc, rmmod parport_pc, kernel oops.  
>From the part of the traceback I can read the problem is in parport_pc_exit. 
  Any help in tracking down the problem would be appreciated.  If this is 
acceptable how can I get this added to the mainline?  This is my first patch 
so please be gentle.

Thanks,
Jason Dravet

Signed-off-by: Jason Dravet <dravet@hotmail.com>
--- /usr/src/linux-2.6.14/drivers/parport/parport_pc.c.orig	2005-12-30 
13:52:48.000000000 -0600
+++ /usr/src/linux-2.6.14/drivers/parport/parport_pc.c	2005-12-30 
19:56:20.000000000 -0600
@@ -55,6 +55,7 @@
#include <linux/pci.h>
#include <linux/pnp.h>
#include <linux/sysctl.h>
+#include <linux/sysfs.h>

#include <asm/io.h>
#include <asm/dma.h>
@@ -99,6 +100,8 @@ static struct superio_struct {	/* For Su
	int dma;
} superios[NR_SUPERIOS] __devinitdata = { {0,},};

+static struct class *parallel_class;
+
static int user_specified;
#if defined(CONFIG_PARPORT_PC_SUPERIO) || \
        (defined(CONFIG_PARPORT_1284) && defined(CONFIG_PARPORT_PC_FIFO))
@@ -2232,6 +2235,25 @@ struct parport *parport_pc_probe_port (u
                                            is mandatory (see above) */
		p->dma = PARPORT_DMA_NONE;

+	parallel_class = class_create(THIS_MODULE, "lp");
+	if (p->base == 888) /* 888 is dec for 378h */
+	{
+		class_device_create(parallel_class, NULL, MKDEV(6, 0), NULL, "lp0");
+		class_device_create(parallel_class, NULL, MKDEV(99, 0), NULL, 
"parport0");
+	}
+
+	if (p->base == 632) /* 632 is dec for 278h */
+	{
+		class_device_create(parallel_class, NULL, MKDEV(6, 1), NULL, "lp1");
+		class_device_create(parallel_class, NULL, MKDEV(99, 1), NULL, 
"parport1");
+	}
+
+	if (p->base == 956) /* 956 is dec for 3BCh */
+	{
+		class_device_create(parallel_class, NULL, MKDEV(6, 2), NULL, "lp2");
+		class_device_create(parallel_class, NULL, MKDEV(99, 2), NULL, 
"parport2");
+	}
+
#ifdef CONFIG_PARPORT_PC_FIFO
	if (parport_ECP_supported(p) &&
	    p->dma != PARPORT_DMA_NOFIFO &&
@@ -3406,6 +3428,13 @@ static void __exit parport_pc_exit(void)
	if (pnp_registered_parport)
		pnp_unregister_driver (&parport_pc_pnp_driver);

+	class_device_destroy(parallel_class, MKDEV(99, 2));
+	class_device_destroy(parallel_class, MKDEV(6, 2));
+	class_device_destroy(parallel_class, MKDEV(99, 1));
+	class_device_destroy(parallel_class, MKDEV(6, 1));
+	class_device_destroy(parallel_class, MKDEV(99, 0));
+	class_device_destroy(parallel_class, MKDEV(6, 0));
+
	spin_lock(&ports_lock);
	while (!list_empty(&ports_list)) {
		struct parport_pc_private *priv;


