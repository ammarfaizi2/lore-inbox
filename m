Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbWCAJzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWCAJzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 04:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbWCAJzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 04:55:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50477 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932695AbWCAJzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 04:55:35 -0500
Date: Wed, 1 Mar 2006 10:55:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       davej@redhat.com, linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060301095501.GD4816@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393C0AD@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C270393C0AD@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01 2006, Andy Chittenden wrote:
> Jens
> 
> > I guess that definitely doesn't work, then :-)
> > Let me doctor up a quick debug patch for ide-dma, then.
> > 
> How's that patch coming along?

Something like this.

diff --git a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
index 0523da7..9ee8c5c 100644
--- a/drivers/ide/ide-dma.c
+++ b/drivers/ide/ide-dma.c
@@ -221,6 +221,20 @@ int ide_build_sglist(ide_drive_t *drive,
 
 EXPORT_SYMBOL_GPL(ide_build_sglist);
 
+static void dump_dma_table(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	request_queue_t *q = drive->queue;
+	int i;
+
+	printk("ide dma table, %d entries, bounce pfn %lu\n", hwif->sg_nents, q->bounce_pfn);
+	for (i = 0; i < hwif->sg_nents; i++) {
+		struct scatterlist *sg = &hwif->sg_table[i];
+
+		printk("sg%d: dma=%llx, len=%u/%u, pfn=%lu\n", i, (unsigned long long) sg->dma_address, sg->length, sg->offset, page_to_pfn(sg->page));
+	}
+}
+
 /**
  *	ide_build_dmatable	-	build IDE DMA table
  *
@@ -311,6 +325,7 @@ use_pio_instead:
 		     hwif->sg_table,
 		     hwif->sg_nents,
 		     hwif->sg_dma_direction);
+	dump_dma_table(drive);
 	return 0; /* revert to PIO for this request */
 }
 

-- 
Jens Axboe

