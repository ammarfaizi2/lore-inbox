Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264598AbTLQWum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 17:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbTLQWum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 17:50:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14302 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264598AbTLQWuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 17:50:32 -0500
Date: Wed, 17 Dec 2003 23:50:07 +0100
From: Jens Axboe <axboe@suse.de>
To: mikem@beardog.cca.cpqcorp.net
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       mike.miller@hp.com, scott.benesh@hp.com
Subject: Re: cciss update for 2.4.24-pre1, 2 of 2
Message-ID: <20031217225007.GN2495@suse.de>
References: <Pine.LNX.4.58.0312161750290.30010@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312161750290.30010@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16 2003, mikem@beardog.cca.cpqcorp.net wrote:
> Some older cciss controllers may take a long time to become ready after
> hot replacing the controller. This patch addresses that problem by adding
> a check of the scratchpad register. This patch is intended to supplement
> the monitor thread when cciss is used in an md environment. In the event
> of a controller failure the failed board can now be more reliably
> replaced. This is patch #2 of 2.
> Please consider this patch for inclusion in the 2.4.24 kernel.
> 
> Thanks,
> mikem
> mike.miller@hp.com
> ------------------------------------------------------------------------------
> diff -burN lx2424pre1-p01/drivers/block/cciss.c lx2424pre1/drivers/block/cciss.c
> --- lx2424pre1-p01/drivers/block/cciss.c	2003-12-16 17:25:50.000000000 -0600
> +++ lx2424pre1/drivers/block/cciss.c	2003-12-16 17:30:41.000000000 -0600
> @@ -2537,8 +2537,8 @@
>  static int cciss_pci_init(ctlr_info_t *c, struct pci_dev *pdev)
>  {
>  	ushort subsystem_vendor_id, subsystem_device_id, command;
> -	unchar irq = pdev->irq;
> -	__u32 board_id;
> +	unchar irq = pdev->irq, revision, ready = 0;
> +	__u32 board_id, scratchpad;
>  	__u64 cfg_offset;
>  	__u32 cfg_base_addr;
>  	__u64 cfg_base_addr_index;
> @@ -2609,6 +2609,21 @@
>  	printk("address 0 = %x\n", c->paddr);
>  #endif /* CCISS_DEBUG */
>  	c->vaddr = remap_pci_mem(c->paddr, 200);
> +	/* Wait for the board to become ready.  (PCI hotplug needs this.)
> +	 * We poll for up to 120 secs, once per 100ms. */
> +	for (i=0; i < 1200; i++) {
> +		scratchpad = readl(c->vaddr + SA5_SCRATCHPAD_OFFSET);
> +		if (scratchpad == 0xffff0000) {
> +			ready = 1;
> +			break;
> +		}
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(HZ / 10); /* wait 100ms */
> +	}
> +	if (!ready) {
> +		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
> +		return -1;
> +	}

Fine as well, aren't you happy you changed this to schedule_timeout()
instead of busy looping? :)

-- 
Jens Axboe

