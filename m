Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265204AbTLRPDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 10:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265207AbTLRPDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 10:03:53 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:36875 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S265204AbTLRPDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 10:03:50 -0500
Date: Thu, 18 Dec 2003 09:05:06 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: Jens Axboe <axboe@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, mike.miller@hp.com, scott.benesh@hp.com,
       jgarzik@pobox.com
Subject: Re: cciss update for 2.4.24-pre1, 2 of 2
In-Reply-To: <20031218074749.GO2495@suse.de>
Message-ID: <Pine.LNX.4.58.0312180858550.30641@beardog.cca.cpqcorp.net>
References: <Pine.LNX.4.58.0312161750290.30010@beardog.cca.cpqcorp.net>
 <20031217225007.GN2495@suse.de> <20031217154919.6ab61960.akpm@osdl.org>
 <20031218074749.GO2495@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a version of the patch with the flag changed to
TASK_UNINTERRUPTIBLE. Thanks for the input.

Thanks,
mikem
mike.miller@hp.com
-------------------------------------------------------------------------------
diff -burN lx2424pre1-p01/drivers/block/cciss.c lx2424pre1/drivers/block/cciss.c
--- lx2424pre1-p01/drivers/block/cciss.c	2003-12-16 17:25:50.000000000 -0600
+++ lx2424pre1/drivers/block/cciss.c	2003-12-16 17:30:41.000000000 -0600
@@ -2537,8 +2537,8 @@
 static int cciss_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
 {
 	ushort subsystem_vendor_id, subsystem_device_id, command;
-	unchar irq = pdev->irq;
-	__u32 board_id;
+	unchar irq = pdev->irq, ready = 0;
+	__u32 board_id, scratchpad;
 	__u64 cfg_offset;
 	__u32 cfg_base_addr;
 	__u64 cfg_base_addr_index;
@@ -2609,6 +2609,21 @@
 	printk("address 0 = %x\n", c->paddr);
 #endif /* CCISS_DEBUG */
 	c->vaddr = remap_pci_mem(c->paddr, 200);
+	/* Wait for the board to become ready.  (PCI hotplug needs this.)
+	 * We poll for up to 120 secs, once per 100ms. */
+	for (i=0; i < 1200; i++) {
+		scratchpad = readl(c->vaddr + SA5_SCRATCHPAD_OFFSET);
+		if (scratchpad == 0xffff0000) {
+			ready = 1;
+			break;
+		}
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ / 10); /* wait 100ms */
+	}
+	if (!ready) {
+		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
+		return -1;
+	}

 	/* get the address index number */
 	cfg_base_addr = readl(c->vaddr + SA5_CTCFG_OFFSET);
diff -burN lx2424pre1-p01/drivers/block/cciss.h lx2424pre1/drivers/block/cciss.h
--- lx2424pre1-p01/drivers/block/cciss.h	2003-11-28 12:26:19.000000000 -0600
+++ lx2424pre1/drivers/block/cciss.h	2003-12-16 17:30:41.000000000 -0600
@@ -137,6 +137,7 @@
 #define SA5_REPLY_INTR_MASK_OFFSET	0x34
 #define SA5_REPLY_PORT_OFFSET		0x44
 #define SA5_INTR_STATUS		0x30
+#define SA5_SCRATCHPAD_OFFSET	0xB0

 #define SA5_CTCFG_OFFSET	0xB4
 #define SA5_CTMEM_OFFSET	0xB8
-------------------------------------------------------------------------------
On Thu, 18 Dec 2003, Jens Axboe wrote:

> On Wed, Dec 17 2003, Andrew Morton wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > >
> > > > +	for (i=0; i < 1200; i++) {
> > > > +		scratchpad = readl(c->vaddr + SA5_SCRATCHPAD_OFFSET);
> > > > +		if (scratchpad == 0xffff0000) {
> > > > +			ready = 1;
> > > > +			break;
> > > > +		}
> > > > +		set_current_state(TASK_INTERRUPTIBLE);
> > > > +		schedule_timeout(HZ / 10); /* wait 100ms */
> > > > +	}
> > > > +	if (!ready) {
> > > > +		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
> > > > +		return -1;
> > > > +	}
> > >
> > > Fine as well, aren't you happy you changed this to schedule_timeout()
> > > instead of busy looping? :)
> >
> > It will still be a busy loop if this task has a signal pending.
> > TASK_UNINTERRUPTIBLE may be more appropriate...
>
> Agreed, that would be better.
>
> --
> Jens Axboe
>
