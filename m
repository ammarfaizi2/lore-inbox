Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266427AbUIEI77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266427AbUIEI77 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 04:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266449AbUIEI77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 04:59:59 -0400
Received: from av7-2-sn1.fre.skanova.net ([81.228.11.114]:40847 "EHLO
	av7-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S266427AbUIEI7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 04:59:32 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
References: <20040903014811.6247d47d.akpm@osdl.org> <m3brgncphy.fsf@telia.com>
	<20040903093727.5810bb7d.akpm@osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 05 Sep 2004 10:59:27 +0200
In-Reply-To: <20040903093727.5810bb7d.akpm@osdl.org>
Message-ID: <m3brglay6o.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Andrew Morton <akpm@osdl.org> writes:

> Peter Osterlund <petero2@telia.com> wrote:
> >
> > One problem that does remain though, is that when dumping huge amounts
> >  of data to a CD or DVD disc (so that you get memory pressure), the
> >  effective writing speed of other block devices (like IDE hard disks)
> >  is reduced to the same speed as the packet device.
> > 
> >  I have posted a patch that fixes this problem by limiting the amount
> >  of writeback data in the packet driver, but unfortunately it makes the
> >  effective writing speed of the packet device suffer a lot. The proper
> >  fix is probably to improve the filesystem and/or VM code to start I/O
> >  operations in sequential order a lot more often than it currently
> >  does.
> 
> If you decrease /proc/sys/vm/dirty_ratio and dirty_background_ratio to much
> smaller levels, does that fix things up? 

No, it seems to slow the packet device down without improving the hard
disk speed.

I wrote a patch that logs what I/O operations are received by the
packet driver. For my test case, which does

        time cp -av /testdata /udf ; time sync

where /testdata contains 120MB of data in 29 files, the I/O pattern
looks like this:

    10:06:03   421 - 1905
    10:06:03   1906 - 2482
    10:06:03   4255 - 6031
    10:06:03   6032 - 6320
    10:06:03   8514 - 10277
    10:06:03   10278 - 10566
    10:06:03   13773 - 15821
    10:06:03   16520 - 18568
    10:06:03   19021 - 21068
    10:06:03   21069 - 23117
    10:06:03   23208 - 24869
    10:06:03   24870 - 25286
    10:06:03   27120 - 28714
    10:06:03   28715 - 29195
    10:06:03   30307 - 32355
    10:06:03   32732 - 34704
    10:06:03   34705 - 34801
    10:06:03   36905 - 38953
    10:06:03   39390 - 41283
    10:06:03   41284 - 41444
    10:06:03   43663 - 45008
    10:06:03   45009 - 45713
    10:06:03   46719 - 48678
    10:06:03   48679 - 48775
    10:06:03   51004 - 53052
    10:06:03   53497 - 55545
    10:06:03   2482 - 4254
    10:06:03   55581 - 55869
    10:06:03   6320 - 8368
    10:06:03   57527 - 59529
    10:06:03   10566 - 10630
    10:06:03   59530 - 61578
    10:06:03   15821 - 16466
    10:06:03   16474 - 16519
    10:06:03   18568 - 19020
    10:06:03   23117 - 23207
    10:06:03   25286 - 26118
    10:06:03   29195 - 30306
    10:06:03   32355 - 32731
    10:06:03   34801 - 35377
    10:06:03   38953 - 39389
    10:06:03   41444 - 43076
    10:06:03   45713 - 46718
    10:06:03   48775 - 49831
    10:06:03   53052 - 53496
    10:06:03   55545 - 55579
    10:06:03   55869 - 57469
    10:06:03   8368 - 8513
    10:06:03   10630 - 12550
    10:06:03   61578 - 62086
    10:06:03   26118 - 27119
    10:06:03   35377 - 35921
    10:06:03   43076 - 43662
    10:06:04   49831 - 51003
    10:06:04   57469 - 57526
    10:06:04   12550 - 12806
    10:06:04   35921 - 36904
    10:06:04   12806 - 13772
    10:06:04   273 - 278
    10:06:04   417 - 418
    10:06:04   419 - 421
    10:06:04   1905 - 1906
    10:06:04   4254 - 4255
    10:06:04   6031 - 6032
    10:06:04   8513 - 8514
    10:06:04   10277 - 10278
    10:06:04   13772 - 13773
    10:06:04   16519 - 16520
    10:06:04   19020 - 19021
    10:06:04   21068 - 21069
    10:06:04   23207 - 23208
    10:06:04   24869 - 24870
    10:06:04   27119 - 27120
    10:06:04   28714 - 28715
    10:06:04   30306 - 30307
    10:06:04   32731 - 32732
    10:06:04   34704 - 34705
    10:06:04   36904 - 36905
    10:06:04   39389 - 39390
    10:06:04   41283 - 41284
    10:06:04   43662 - 43663
    10:06:04   45008 - 45009
    10:06:04   46718 - 46719
    10:06:04   48678 - 48679
    10:06:04   51003 - 51004
    10:06:04   53496 - 53497
    10:06:04   55579 - 55581
    10:06:04   57526 - 57527
    10:06:31   59529 - 59530
    10:06:31   273 - 274

See attachment for a graph of this data. The X axis corresponds to the
I/O submission order and the Y axis corresponds to the sector numbers.


--=-=-=
Content-Type: image/png
Content-Disposition: attachment; filename=iopattern.png
Content-Transfer-Encoding: base64
Content-Description: IO_pattern.png

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
--=-=-=


diff -puN drivers/block/pktcdvd.c~packet-io-log drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~packet-io-log	2004-09-05 10:35:24.697900200 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2004-09-05 10:35:24.701899592 +0200
@@ -896,6 +896,27 @@ static inline void pkt_set_state(struct 
 	pkt->state = state;
 }
 
+static void pkt_io_log(struct bio *bio)
+{
+	static sector_t start, stop;
+	typedef unsigned long long ull;
+
+	if (bio) {
+		if (stop == bio->bi_sector) {
+			stop = stop + bio_sectors(bio);
+		} else {
+			if (start != stop)
+				printk("pkt: %lld - %lld\n", (ull)(start >> 2), (ull)(stop >> 2));
+			start = bio->bi_sector;
+			stop = start + bio_sectors(bio);
+		}
+	} else {
+		if (start != stop)
+			printk("pkt: %lld - %lld\n", (ull)(start >> 2), (ull)(stop >> 2));
+		start = stop = 0;
+	}
+}
+
 /*
  * Scan the work queue to see if we can start a new packet.
  * returns non-zero if any work was done.
@@ -949,6 +970,8 @@ try_next_bio:
 	spin_unlock(&pd->lock);
 	if (!bio) {
 		VPRINTK("handle_queue: no bio\n");
+		if (list_empty(&pd->cdrw.pkt_active_list))
+			pkt_io_log(NULL);
 		return 0;
 	}
 
@@ -2197,6 +2220,8 @@ static int pkt_make_request(request_queu
 		}
 	}
 
+	pkt_io_log(bio);
+
 	/*
 	 * If we find a matching packet in state WAITING or READ_WAIT, we can
 	 * just append this bio to that packet.
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

--=-=-=--
