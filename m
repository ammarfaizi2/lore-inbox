Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314377AbSDRRf4>; Thu, 18 Apr 2002 13:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSDRRfz>; Thu, 18 Apr 2002 13:35:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9476 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314377AbSDRRfy>;
	Thu, 18 Apr 2002 13:35:54 -0400
Message-ID: <3CBF03DE.CD212965@zip.com.au>
Date: Thu, 18 Apr 2002 10:35:26 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
CC: Jens Axboe <axboe@suse.de>
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <OFCEC9D152.09A1A6B2-ON85256B9F.0047D732@pok.ibm.com> <3CBEF18D.F18BAA76@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Mark Peloquin wrote:
> >
> ...
> > In EVMS, we are adding code to deal with BIO splitting, to
> > enable our feature modules, such as DriveLinking, LVM, & MD
> > Linear, etc to break large BIOs up on chunk size or lower
> > level device boundaries.
> 
> Could I suggest that this code not be part of EVMS, but that
> you implement it as a library within the core kernel?  Lots of
> stuff is going to need BIO splitting - software RAID, ataraid,
> XFS, etc.  May as well talk with Jens, Martin Petersen, Arjan,
> Neil Brown.  Do it once, do it right...
> 

I take that back.

We really, really do not want to perform BIO splitting at all.
It requires that the kernel perform GFP_NOIO allocations at
the worst possible time, and it's just broken.

What I would much prefer is that the top-level BIO assembly
code be able to find out, beforehand, what the maximum 
permissible BIO size is at the chosen offset.  It can then
simple restrict the BIO to that size.

Simply:

	max = bio_max_bytes(dev, block);

which gets passed down the exact path as the requests themselves.
Each layer does:

int foo_max_bytes(sector_t sector)
{
	int my_maxbytes, his_maxbytes;
	sector_t my_sector;
	
	my_sector = my_translation(sector);
	his_maxbytes = next_device(me)->max_bytes(my_sector);
	my_maxbytes = whatever(my_sector);
	return min(my_maxbytes, his_maxbytes);
}

and, at the bottom:

int ide_max_bytes(sector_t sector)
{
	return 248 * 512;
}

BIO_MAX_SECTORS and request_queue.max_sectors go away.

Tell me why this won't work?

-
