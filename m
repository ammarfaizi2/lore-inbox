Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288864AbSANHYH>; Mon, 14 Jan 2002 02:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288882AbSANHX6>; Mon, 14 Jan 2002 02:23:58 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62473 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288864AbSANHXr>;
	Mon, 14 Jan 2002 02:23:47 -0500
Date: Mon, 14 Jan 2002 08:23:41 +0100
From: Jens Axboe <axboe@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linuxdiskcert.org>
Subject: Re: BIO Usage Error or Conflicting Designs
Message-ID: <20020114082341.F13929@suse.de>
In-Reply-To: <3C41F772.543C2F85@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C41F772.543C2F85@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13 2002, Manfred Spraul wrote:
> > 
> > Is this with the highmem debug stuff enabled? That's the only way I can
> > see this BUG triggering, otherwise q->bounce_pfn _cannot_ be smaller
> > than the max_pfn.
> > 
> Have you tested that?
> 
> Unless I misread arch/i386/kernel/setup.c, line 740 to 760, max_pfn is
> the upper end of the highmem area, if highmem is configured.
> For non-highmem setup, it's set to min(system_memory, 4 GB).
> It was a local variable within setup_arch, and someone made it a global
> variable.
> 
> I.e. max_pfn is 1 GB with Andre's setup.
> 
> His patch doesn't touch the bounce limit, the default limit from
> blk_queue_make_request() is used: BLK_BOUNCE_HIGH, which is max_low_pfn.
> 
> max_low_pfn is 896 MB.
> 
> --> BUG in create_bounce(), because a request comes in with a bounce
> limit less than the total system memory, and no highmem configured.

Indeed, I misread the max_pfn stuff when I added that.

--- /opt/kernel/linux-2.5.2-pre11/drivers/block/ll_rw_blk.c	Thu Jan 10 09:56:52 2002
+++ drivers/block/ll_rw_blk.c	Mon Jan 14 02:21:50 2002
@@ -1711,7 +1705,11 @@
 	printk("block: %d slots per queue, batch=%d\n", queue_nr_requests, batch_requests);
 
 	blk_max_low_pfn = max_low_pfn;
+#ifdef CONFIG_HIGHMEM
 	blk_max_pfn = max_pfn;
+#else
+	blk_max_pfn = max_low_pfn;
+#endif
 
 #if defined(CONFIG_IDE) && defined(CONFIG_BLK_DEV_IDE)
 	ide_init();		/* this MUST precede hd_init */
--- /opt/kernel/linux-2.5.2-pre11/mm/highmem.c	Thu Jan 10 09:56:53 2002
+++ mm/highmem.c	Mon Jan 14 02:20:53 2002
@@ -367,12 +367,6 @@
 		if (pfn >= blk_max_pfn)
 			return;
 
-#ifndef CONFIG_HIGHMEM
-		/*
-		 * should not hit for non-highmem case
-		 */
-		BUG();
-#endif
 		bio_gfp = GFP_NOHIGHIO;
 		pool = page_pool;
 	} else {

-- 
Jens Axboe

