Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265310AbRF0Jmc>; Wed, 27 Jun 2001 05:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265312AbRF0JmW>; Wed, 27 Jun 2001 05:42:22 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:23584 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265310AbRF0JmN>; Wed, 27 Jun 2001 05:42:13 -0400
Date: Wed, 27 Jun 2001 11:41:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "ZINKEVICIUS,MATT (HP-Loveland,ex1)" <matt_zinkevicius@hp.com>
Subject: Re: patch: highmem zero-bounce
Message-ID: <20010627114155.A31910@athlon.random>
In-Reply-To: <20010626182215.C14460@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010626182215.C14460@suse.de>; from axboe@suse.de on Tue, Jun 26, 2001 at 06:22:15PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 06:22:15PM +0200, Jens Axboe wrote:
> Hi,
> 
> I updated the patches to 2.4.6-pre5, and removed the zone-dma32
> addition. This means that machines with > 4GB of RAM will need to go all

good, we can relax the ZONE_NORMAL later, that's a separate problem with
skipping the bounces.

I can see one mm corruption race condition in the patch, you missed
nested irq in the for kmap_irq_bh (PIO).  You must _always_
__cli/__save_flags before accessing the KMAP_IRQ_BH slot, in case the
remapping is required (so _only_ when the page is in the highmem zone).
Otherwise memory corruption will happen when the race triggers (for
example two ide disks in PIO mode doing I/O at the same time connected
to different irq sources).

Andrea
