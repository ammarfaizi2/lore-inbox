Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314404AbSDRSYa>; Thu, 18 Apr 2002 14:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314405AbSDRSXs>; Thu, 18 Apr 2002 14:23:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54682 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314404AbSDRSXk>;
	Thu, 18 Apr 2002 14:23:40 -0400
Importance: Normal
Sensitivity: 
Subject: Re: Bio pool & scsi scatter gather pool usage
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFA8584441.22F71259-ON85256B9F.00627FAA@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 18 Apr 2002 13:23:47 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.9a |January 28, 2002) at
 04/18/2002 02:23:32 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Andrew Morton wrote:
> >
> > Mark Peloquin wrote:
> > >
> > ...
> > > In EVMS, we are adding code to deal with BIO splitting, to
> > > enable our feature modules, such as DriveLinking, LVM, & MD
> > > Linear, etc to break large BIOs up on chunk size or lower
> > > level device boundaries.
> >
> > Could I suggest that this code not be part of EVMS, but that
> > you implement it as a library within the core kernel?  Lots of
> > stuff is going to need BIO splitting - software RAID, ataraid,
> > XFS, etc.  May as well talk with Jens, Martin Petersen, Arjan,
> > Neil Brown.  Do it once, do it right...
> >
> I take that back.
>
> We really, really do not want to perform BIO splitting at all.
> It requires that the kernel perform GFP_NOIO allocations at
> the worst possible time, and it's just broken.
>
> What I would much prefer is that the top-level BIO assembly
> code be able to find out, beforehand, what the maximum
> permissible BIO size is at the chosen offset.  It can then
> simple restrict the BIO to that size.
>
> Simply:
>
>  max = bio_max_bytes(dev, block);
>
> which gets passed down the exact path as the requests themselves.
> Each layer does:
>
> int foo_max_bytes(sector_t sector)
> {
>  int my_maxbytes, his_maxbytes;
>  sector_t my_sector;
>
>  my_sector = my_translation(sector);
>  his_maxbytes = next_device(me)->max_bytes(my_sector);
>  my_maxbytes = whatever(my_sector);
>  return min(my_maxbytes, his_maxbytes);
> }
>
> and, at the bottom:
>
> int ide_max_bytes(sector_t sector)
> {
>  return 248 * 512;
> }
>
> BIO_MAX_SECTORS and request_queue.max_sectors go away.
>
> Tell me why this won't work?

This would require the BIO assembly code to make at least one
call to find the current permissible BIO size at offset xyzzy.
Depending on the actual IO size many foo_max_bytes calls may
be required. Envision the LVM or RAID case where physical
extents or chunks sizes can be as small as 8Kb I believe. For
a 64Kb IO, its conceivable that 9 calls to foo_max_bytes may
be required to package that IO into permissibly sized BIOs.

What your proposing is doable, but not without a cost.

This cost would be incurred to some degree on every IO, rather
than just on the exception case. Certain underlying storage
layouts would pay a higher cost, but they also had a higher
cost if they had to split BIOs themselves.

Perhaps foo_max_bytes also accept a size and could be coded
to return a list of sizes, only one call would be required
to determine all the permissible BIO sizes needed to package
an IO of a specified size.

What your proposal guarantees is that BIOs would never have
to split up at all.

Mark

