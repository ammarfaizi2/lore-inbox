Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUH1TsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUH1TsC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 15:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267703AbUH1Trt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 15:47:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:18304 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267666AbUH1TrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 15:47:10 -0400
Date: Sat, 28 Aug 2004 12:45:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Osterlund <petero2@telia.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Speed up the cdrw packet writing driver
Message-Id: <20040828124519.0caf23bf.akpm@osdl.org>
In-Reply-To: <m3zn4ff6jy.fsf@telia.com>
References: <m33c2py1m1.fsf@telia.com>
	<20040823114329.GI2301@suse.de>
	<m3llg5dein.fsf@telia.com>
	<20040824202951.GA24280@suse.de>
	<m3hdqsckoo.fsf@telia.com>
	<20040825065055.GA2321@suse.de>
	<m3u0unwplj.fsf@telia.com>
	<20040828130757.GA2397@suse.de>
	<m3zn4ff6jy.fsf@telia.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> wrote:
>
> Is this a general VM limitation? Has anyone been able to saturate the
>  write bandwidth of two different block devices at the same time, when
>  they operate at vastly different speeds (45MB/s vs 5MB/s), and when
>  the writes are large enough to cause memory pressure?

I haven't explicitly tested the pdflush code in a while, and I never tested
on devices with such disparate bandwidth.  But it _should_ work.

The basic deign of the pdflush writeback path is:

	for ( ; ; ) {
		for (each superblock) {
			if (no pdflush thread is working this sb's queue &&
			    the superblock's backingdev is not congested) {
				do some writeout, up to congestion, trying
				to not block on request queue exhaustion
			}
		}
		blk_congestion_wait()
	}

So it basically spins around all the queues keeping them full in a
non-blocking manner.

There _are_ times when pdflush will accidentally block.  Say, doing a
metadata read.  In that case other pdflush instances will keep other queues
busy.

I tested it up to 12 disks.  Works OK.
