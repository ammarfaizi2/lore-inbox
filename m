Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422774AbWHSUW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbWHSUW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 16:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422775AbWHSUW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 16:22:26 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:16621 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1422774AbWHSUW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 16:22:26 -0400
Date: Sat, 19 Aug 2006 16:17:01 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] block: fix queue bounce limit calculation
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>, Andi Kleen <ak@suse.de>
Message-ID: <200608191619_MC3-1-C8A4-9408@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200608190612_MC3-1-C895-98A8@compuserve.com>

On Sat, 19 Aug 2006 06:11:34 -0400, Chuck Ebbert wrote:

> Could this explain reported slowdown on x86_64 after limit was
> changed in 2.6.16.7?

Oops, I meant 2.6.17.7:

| Date: Wed, 2 Aug 2006 13:20:02 -0700
| From: "Robin H. Johnson" <robbat2@orbis-terrarum.net>
| Subject: 2.6.17.7 leading to doubling system CPU usage?
| To: linux-kernel@vger.kernel.org
| Message-ID: <20060802202002.GH31144@curie-int.orbis-terrarum.net>

And the patch only fixes the problem on my CDROM.  The system only has 512 MB
of RAM, so DMA should always be enabled.  I applied the below debugging patch
and got this (how do I find the dev for the unknown ones?):

# dmesg | fgrep -v debounce | fgrep -B 2 bounce
[   16.971945] Probing IDE interface ide0...
[   17.260734] hda: IC25N060ATMR04-0, ATA DISK drive
[   17.931625] isa bounce pool size: 16 pages
[   17.931672] q = ffff81001da606a0, dma = 1, bounce_pfn = 122608, max = 122608
[   17.931745] q = ffff81001da606a0, dma = 0, bounce_pfn = 1048575, max = 122608
--
[   17.932039] Probing IDE interface ide1...
[   18.666664] hdc: MATSHITAUJ-840D, ATAPI CD/DVD-ROM drive
[   19.002080] q = ffff81001da60050, dma = 1, bounce_pfn = 122608, max = 122608
[   19.002142] q = ffff81001da60050, dma = 1, bounce_pfn = 122608, max = 122608
--
[   21.726613] KBC0 MSE0  P2P AUDO 
[   21.726804] ACPI: (supports S0 S3 S4 S5)
[   21.727335] q = ffff81001db23990, dma = 1, bounce_pfn = 122608, max = 122608 <= unknown dev
--
[   25.001150] EXT3 FS on hda7, internal journal
[   25.001156] EXT3-fs: mounted filesystem with ordered data mode.
[   25.620562] q = ffff81001db23340, dma = 1, bounce_pfn = 122608, max = 122608 <== unknown dev
[   25.620587] q = ffff81001db23340, dma = 0, bounce_pfn = 1048575, max = 122608
--
[   25.676213] sd 0:0:0:0: Attached scsi disk sda
[   25.692273] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   25.692372] q = ffff81001db22cf0, dma = 1, bounce_pfn = 122608, max = 122608  <== sda: 
[   25.692396] q = ffff81001db22cf0, dma = 0, bounce_pfn = 1048575, max = 122608     why 14 times???
[   25.693374] q = ffff81001db22cf0, dma = 1, bounce_pfn = 122608, max = 122608
[   25.693394] q = ffff81001db22cf0, dma = 0, bounce_pfn = 1048575, max = 122608
[   25.693485] q = ffff81001db22cf0, dma = 1, bounce_pfn = 122608, max = 122608
[   25.693503] q = ffff81001db22cf0, dma = 0, bounce_pfn = 1048575, max = 122608
[   25.695692] q = ffff81001db22cf0, dma = 1, bounce_pfn = 122608, max = 122608
[   25.695714] q = ffff81001db22cf0, dma = 0, bounce_pfn = 1048575, max = 122608
[   25.695997] q = ffff81001db22cf0, dma = 1, bounce_pfn = 122608, max = 122608
[   25.696015] q = ffff81001db22cf0, dma = 0, bounce_pfn = 1048575, max = 122608
[   25.696316] q = ffff81001db22cf0, dma = 1, bounce_pfn = 122608, max = 122608
[   25.696335] q = ffff81001db22cf0, dma = 0, bounce_pfn = 1048575, max = 122608
[   25.696416] q = ffff81001db22cf0, dma = 1, bounce_pfn = 122608, max = 122608
[   25.696434] q = ffff81001db22cf0, dma = 0, bounce_pfn = 1048575, max = 122608
[   25.699613] usb-storage: device scan complete
[   27.331383] eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
[   35.361254] q = ffff81001da606a0, dma = 0, bounce_pfn = 1048575, max = 122608 <== hda again ???
[   35.361289] q = ffff81001da606a0, dma = 0, bounce_pfn = 1048575, max = 122608
[   35.867099] q = ffff81001da60050, dma = 1, bounce_pfn = 122608, max = 122608 <== hdc again ???
[   35.867136] q = ffff81001da60050, dma = 1, bounce_pfn = 122608, max = 122608


--- 2.6.17.9-32.orig/block/ll_rw_blk.c
+++ 2.6.17.9-32/block/ll_rw_blk.c
@@ -651,6 +651,15 @@ void blk_queue_bounce_limit(request_queu
 		q->bounce_gfp = GFP_NOIO | GFP_DMA;
 		q->bounce_pfn = bounce_pfn;
 	}
+
+	printk(KERN_ERR "q = %p, dma = %d, bounce_pfn = %lu, max = %lu\n",
+			q, dma, bounce_pfn,
+#if BITS_PER_LONG == 64
+			(unsigned long)(min_t(u64,0xffffffff,BLK_BOUNCE_HIGH) >> PAGE_SHIFT)
+#else
+			blk_max_low_pfn
+#endif
+			);
 }
 
 EXPORT_SYMBOL(blk_queue_bounce_limit);
-- 
Chuck
