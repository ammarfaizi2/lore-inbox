Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279963AbRKMOjz>; Tue, 13 Nov 2001 09:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279717AbRKMOjq>; Tue, 13 Nov 2001 09:39:46 -0500
Received: from 107.ppp1-8.ski.worldonline.dk ([213.237.84.235]:60291 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S279963AbRKMOji>; Tue, 13 Nov 2001 09:39:38 -0500
Date: Tue, 13 Nov 2001 15:39:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: Christoph Hellwig <hch@caldera.de>, dalecki@evision.ag,
        linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Re: Hardsector size support in 2.4 and 2.5
Message-ID: <20011113153900.A17933@suse.de>
In-Reply-To: <OF2769A354.FD887DD7-ON85256B03.004C650C@raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF2769A354.FD887DD7-ON85256B03.004C650C@raleigh.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13 2001, Mark Peloquin wrote:
> On Tue, Nov 13 2001, Jens Axboe wrote:
> > On Mon, Nov 12 2001, Christoph Hellwig wrote:
> > > On Mon, Nov 12, 2001 at 02:05:19PM -0600, Mark Peloquin wrote:
> > > > So any block device, can always expect to receive buffer heads
> > > > whose b_rsector value represents the offset from the beginning
> > > > of that device in 512 byte multiples? And this will continue
> > > > to hold true in 2.5 as well?
> > >
> > > There is a good chance that no 2.5 block driver will ever see a
> buffer_head,
> > > take a look at
> http://www.kernel.org/pub/linux/kernel/people/axboe/v2.5/ for
> > > details.
> 
> > To expand on the specific point -- in 2.5, what will change is that
> > b_rsector (or equiv field, bi_sector in bio) will be offset from the
> > beginning of the disk, not the beginning of the partition. This moves
> > toe partion remaps out of the driver itself.
> 
> This is an important difference, so I'd like to make sure I fully
> understand the scope. Ok, so bi_sector for partitions will be
> disk relative, not partition relative. I'll assume that bi_sector

Well, know you have b_rdev == MKDEV(3, 5) and b_rsector = 0 for the
first sector of /dev/hda5 -- with the new remapped approach, this would
be b_rdev = MKDEV(3, 0) b_rsector 123456 (imagined value, of course).

> will be set inside of submit_bh. So top level block devices always
> see something that is disk relative. Is this change ONLY for
> partitions? And if not, how will this affect what top and

Inside generic_make_request currentl, so stacking works.

> intermediate levels of stacked block devices receive for a
> bi_sector value? If I had MD on LVM on partitions, what would
> bi_sector value initially be relative to? The MD device, the
> LVM device, or the disk underlying the partitions? It seems it

Nothing changes for stacking. The only difference is that the remapping
for partition offset is now done above the driver. Drivers can still
remap b_rdev and b_rsector as they see fit.

-- 
Jens Axboe

