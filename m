Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTJTUGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 16:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbTJTUGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 16:06:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:5883 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262784AbTJTUGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 16:06:32 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: linux-kernel@vger.kernel.org
Subject: ide retry behavior
Date: Mon, 20 Oct 2003 22:06:27 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310202206.27418.hpj@urpla.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had a 80 GB Maxtor 6L080J4 ide disk crash last week.

While the data recovery task with dd_rescue was successful,
it took about 31 hours to read through the entire disk, and 
some tests has shown, that reverse reading was advantageous.
On the other hand, disabling DMA slowed down the read process
to a crawl in the error case, thus I kept DMA on.

Analyzing the syslogs showed, that a few retries are done.
This raises the question, is it possible to adjust the retry
count on the fly, since this would allow a more intelligent
datarecovery strategy:
first run: retry 0 and remember badblocks (persistent)
second run: retry 2 on all badblocks
and allow an arbitrary number of runs with increasing retries.

Looking into the kernel revealed the max_failures setting,
but since it is 1 by default, it's not the mechanism involved
here.

I'm open to experiments with this drive, before returning it
to the distributor. 

Again: is there an existing interface to modify the kernels 
retry behavior? I hope to reduce the recovery time by factor
5-10, if possible.

If you have an idea on this, please CC me, although I'm
subscribed.

TIA,
Pete

Summary for /dev/hdc -> /dev/hda:
dd_rescue: (info): ipos:         0.0k, opos:         0.0k, xferd:  78177792.0k
             -     errs:   2520, errxfer:      1260.0k, succxfer:  78176532.0k
             +curr.rate:     8034kB/s, avg.rate:      740kB/s, avg.load:  0.0%

An syslog excerpt:
Oct 17 22:36:00 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:36:00 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225470, sector=34225468
Oct 17 22:36:00 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225468
Oct 17 22:36:06 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:36:06 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225470, sector=34225470
Oct 17 22:36:06 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225470
Oct 17 22:36:17 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:36:17 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:36:17 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225448
Oct 17 22:36:23 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:36:23 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225450, sector=34225450
Oct 17 22:36:23 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225450
Oct 17 22:36:28 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:36:28 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225452, sector=34225452
Oct 17 22:36:28 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225452
Oct 17 22:36:34 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:36:34 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225454, sector=34225454
Oct 17 22:36:34 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225454
Oct 17 22:36:39 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:36:39 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:36:39 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225448
Oct 17 22:36:45 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:36:45 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225450, sector=34225450
Oct 17 22:36:45 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225450
Oct 17 22:36:51 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:36:51 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225452, sector=34225452
Oct 17 22:36:51 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225452
Oct 17 22:36:56 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:36:56 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225454, sector=34225454
Oct 17 22:36:56 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225454
Oct 17 22:37:02 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:02 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:37:02 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225448
Oct 17 22:37:07 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:07 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225450, sector=34225450
Oct 17 22:37:07 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225450
Oct 17 22:37:13 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:13 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225452, sector=34225452
Oct 17 22:37:13 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225452
Oct 17 22:37:19 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:19 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225454, sector=34225454
Oct 17 22:37:19 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225454
Oct 17 22:37:25 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:25 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:37:25 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225448
Oct 17 22:37:31 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:31 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225450, sector=34225450
Oct 17 22:37:31 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225450
Oct 17 22:37:36 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:36 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225452, sector=34225452
Oct 17 22:37:36 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225452
Oct 17 22:37:42 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:42 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225454, sector=34225454
Oct 17 22:37:42 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225454
Oct 17 22:37:48 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:48 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:37:48 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225448
Oct 17 22:37:53 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:53 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225450, sector=34225450
Oct 17 22:37:53 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225450
Oct 17 22:37:59 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:37:59 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225452, sector=34225452
Oct 17 22:37:59 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225452
Oct 17 22:38:05 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:38:05 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225454, sector=34225454
Oct 17 22:38:05 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225454
Oct 17 22:38:11 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:38:11 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:38:11 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225448
Oct 17 22:38:17 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:38:17 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225451, sector=34225450
Oct 17 22:38:17 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225450
Oct 17 22:38:22 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:38:22 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225452, sector=34225452
Oct 17 22:38:22 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225452
Oct 17 22:38:28 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:38:28 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225454, sector=34225454
Oct 17 22:38:28 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225454
Oct 17 22:38:34 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:38:34 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:38:34 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225448
Oct 17 22:38:40 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:38:40 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225450, sector=34225450
Oct 17 22:38:40 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225450
Oct 17 22:38:45 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:38:45 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225452, sector=34225452
Oct 17 22:38:45 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225452
Oct 17 22:38:51 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:38:51 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225454, sector=34225454
Oct 17 22:38:51 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225454
Oct 17 22:38:57 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:38:57 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225448, sector=34225448
Oct 17 22:38:57 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225448
Oct 17 22:39:02 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:02 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225450, sector=34225450
Oct 17 22:39:02 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225450
Oct 17 22:39:07 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:07 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225452, sector=34225452
Oct 17 22:39:07 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225452
Oct 17 22:39:13 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:13 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225454, sector=34225454
Oct 17 22:39:13 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225454
Oct 17 22:39:19 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:19 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225440, sector=34225440
Oct 17 22:39:19 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225440
Oct 17 22:39:25 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:25 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225442, sector=34225442
Oct 17 22:39:25 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225442
Oct 17 22:39:30 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:30 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225444, sector=34225444
Oct 17 22:39:30 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225444
Oct 17 22:39:36 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:36 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225446, sector=34225446
Oct 17 22:39:36 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225446
Oct 17 22:39:42 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:42 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225440, sector=34225440
Oct 17 22:39:42 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225440
Oct 17 22:39:48 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:48 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225442, sector=34225442
Oct 17 22:39:48 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225442
Oct 17 22:39:53 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:53 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225444, sector=34225444
Oct 17 22:39:53 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225444
Oct 17 22:39:59 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:39:59 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225446, sector=34225446
Oct 17 22:39:59 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225446
Oct 17 22:40:05 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:40:05 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225440, sector=34225440
Oct 17 22:40:05 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225440
Oct 17 22:40:10 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:40:10 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225442, sector=34225442
Oct 17 22:40:10 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225442
Oct 17 22:40:16 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:40:16 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225444, sector=34225444
Oct 17 22:40:16 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225444
Oct 17 22:40:22 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:40:22 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225446, sector=34225446
Oct 17 22:40:22 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225446
Oct 17 22:40:27 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:40:27 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225440, sector=34225440
Oct 17 22:40:27 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225440
Oct 17 22:40:33 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:40:33 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225442, sector=34225442
Oct 17 22:40:33 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225442
Oct 17 22:40:39 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:40:39 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225444, sector=34225444
Oct 17 22:40:39 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225444
Oct 17 22:40:45 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:40:45 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225446, sector=34225446
Oct 17 22:40:45 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225446
Oct 17 22:40:50 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:40:50 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225440, sector=34225440
Oct 17 22:40:50 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225440
Oct 17 22:40:56 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:40:56 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225442, sector=34225442
Oct 17 22:40:56 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225442
Oct 17 22:41:02 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:41:02 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225444, sector=34225444
Oct 17 22:41:02 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225444
Oct 17 22:41:13 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:41:13 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225440, sector=34225440
Oct 17 22:41:13 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225440
Oct 17 22:41:18 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:41:18 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225442, sector=34225442
Oct 17 22:41:18 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225442
Oct 17 22:41:24 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:41:24 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225444, sector=34225444
Oct 17 22:41:24 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225444
Oct 17 22:41:30 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:41:30 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225440, sector=34225440
Oct 17 22:41:30 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225440
Oct 17 22:41:35 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:41:35 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225442, sector=34225442
Oct 17 22:41:35 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225442
Oct 17 22:41:41 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:41:41 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225444, sector=34225444
Oct 17 22:41:41 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225444
Oct 17 22:41:46 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:41:46 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225440, sector=34225440
Oct 17 22:41:46 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225440
Oct 17 22:41:52 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:41:52 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34225442, sector=34225442
Oct 17 22:41:52 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34225442
Oct 17 22:42:11 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:42:11 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34224981, sector=34224960
Oct 17 22:42:11 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34224960
Oct 17 22:42:21 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:42:21 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34224837, sector=34224832
Oct 17 22:42:21 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34224832
Oct 17 22:42:27 kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Oct 17 22:42:27 kernel: hdc: dma_intr: error=0x40 { UncorrectableError }, LBAsect=34224837, sector=34224834
Oct 17 22:42:27 kernel: end_request: I/O error, dev 16:00 (hdc), sector 34224834


