Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131599AbRASAQY>; Thu, 18 Jan 2001 19:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132678AbRASAQO>; Thu, 18 Jan 2001 19:16:14 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:22394 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131599AbRASAQE>; Thu, 18 Jan 2001 19:16:04 -0500
Date: Fri, 19 Jan 2001 01:16:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.1pre8 slowdown on dbench tests
Message-ID: <20010119011629.C32087@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0101181449240.4124-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0101181449240.4124-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Jan 18, 2001 at 03:17:13PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 03:17:13PM -0200, Marcelo Tosatti wrote:
> Jens, can be the -blk patch the reason for the slowdown I'm seeing?

This heuristic is way too aggressive:

	/*
	 * Try to keep 128MB max hysteris. If not possible,
	 * use half of RAM
	 */
	high_queued_sectors = (total_ram * 2) / 3;
	low_queued_sectors = high_queued_sectors - MB(128);
	if (low_queued_sectors < 0)
		low_queued_sectors = total_ram / 2;

	/*
	 * for big RAM machines (>= 384MB), use more for I/O
	 */
	if (total_ram >= MB(384)) {
		high_queued_sectors = (total_ram * 4) / 5;
		low_queued_sectors = high_queued_sectors - MB(128);
	}

2/3 of ram locked down in the I/O queue is way too much. 1/3 should be ok. big
RAM machines needs way less than 1/3 locked down.

Marcelo can you give a try with `high_queued_sectors = total_ram / 3' and
low_queued_sectors = high_queued_sectors / 2 and drop the big ram machine
check?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
