Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbUCJQ4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUCJQ4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:56:30 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:10255 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262721AbUCJQ4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:56:22 -0500
Date: Wed, 10 Mar 2004 16:55:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: jt@hpl.hp.com
Cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
Message-ID: <20040310165548.A24693@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, jt@hpl.hp.com,
	"David S. Miller" <davem@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040304023524.GA19453@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040304023524.GA19453@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Wed, Mar 03, 2004 at 06:35:24PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 06:35:24PM -0800, Jean Tourrilhes wrote:
> 	Hi Dave & Jeff,
> 
> 	The attached .bz2 file is a patch for 2.6.3 adding the
> Intersil Prism54 wireless driver. Sorry for the attachement, the file
> is rather big, if you want inline+plaintext, I'll send that personal
> to you.
> 	I've been using this driver with great success on 2.6.3 and
> 2.6.4-rc1 (SMP). This driver support various popular CardBus and PCI
> 802.11g cards (54 Mb/s) based on the Intersil PrismGT/PrismDuette
> chipset.
> 	I would like this driver to go into 2.6.X. However, I
> understand that it's lot's of code to review.

Here's a few things I found.  It's not exactly a full review, there's
too much new snow to spend lots of time in front of a computer here :)

diff -Naur -X /home/mcgrof/lib/dontdiff linux-2.6.3/drivers/net/wireless/prism54/Makefile linux-2.6.3-prism54/drivers/net/wireless/prism54/Makefile
--- linux-2.6.3/drivers/net/wireless/prism54/Makefile	Thu Jan  1 00:00:00 1970
+++ linux-2.6.3-prism54/drivers/net/wireless/prism54/Makefile	Thu Mar  4 02:00:01 2004
@@ -0,0 +1,10 @@
+# $Id: Makefile.k26,v 1.7 2004/01/30 16:24:00 ajfa Exp $
+
+prism54-objs := islpci_eth.o islpci_mgt.o \
+                isl_38xx.o isl_ioctl.o islpci_dev.o \
+		islpci_hotplug.o isl_wds.o oid_mgt.o

	please use foo-y for new drivers.

+
+obj-$(CONFIG_PRISM54) += prism54.o
+
+EXTRA_CFLAGS = -I$(PWD) #-DCONFIG_PRISM54_WDS

	This is bogus, especially with srcdir != objdir.
	please fixup the includes instead

+#define __KERNEL_SYSCALLS__

	this shouldn't be used anymore.

+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+
+#include "isl_38xx.h"
+#include <linux/firmware.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>

	Please include headers in the following order <linux/*.h>,
	<asm/*.h>, driver-specific.

+#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,75))
+#include <linux/device.h>
+# define _REQ_FW_DEV_T struct device *
+#else
+# define _REQ_FW_DEV_T char *
+#endif

	Eeek, why don't you simply pass the pci_dev down?


+typedef struct isl38xx_cb isl38xx_control_block;

	No useless typedefs please.

+MODULE_PARM(init_mode, "i");
+MODULE_PARM_DESC(init_mode,
+		 "Set card mode:\n0: Auto\n1: Ad-Hoc\n2: Managed Client (Default)\n3: Master / Access Point\n4: Repeater (Not supported yet)\n5: Secondary (Not supported yet)\n6: Monitor");

	Please use module_param

diff -Naur -X /home/mcgrof/lib/dontdiff linux-2.6.3/drivers/net/wireless/prism54/isl_wds.c linux-2.6.3-prism54/drivers/net/wireless/prism54/isl_wds.c
--- linux-2.6.3/drivers/net/wireless/prism54/isl_wds.c	Thu Jan  1 00:00:00 1970
+++ linux-2.6.3-prism54/drivers/net/wireless/prism54/isl_wds.c	Thu Mar  4 02:00:01 2004

	WDS doesn't belong into a driver but in higher-level code.

