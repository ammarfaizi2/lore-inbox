Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313332AbSDYTny>; Thu, 25 Apr 2002 15:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313162AbSDYTnx>; Thu, 25 Apr 2002 15:43:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53235
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313339AbSDYTnv>; Thu, 25 Apr 2002 15:43:51 -0400
Date: Thu, 25 Apr 2002 12:43:46 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mark Peloquin <peloquin@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
Message-ID: <20020425194346.GN574@matchmail.com>
Mail-Followup-To: Mark Peloquin <peloquin@us.ibm.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <OFA8584441.22F71259-ON85256B9F.00627FAA@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 01:23:47PM -0500, Mark Peloquin wrote:
> 
> > Andrew Morton wrote:
> > >
> > > Mark Peloquin wrote:
> > > >
> > > ...
> > > > In EVMS, we are adding code to deal with BIO splitting, to
> > > > enable our feature modules, such as DriveLinking, LVM, & MD
> > > > Linear, etc to break large BIOs up on chunk size or lower
> > > > level device boundaries.
> > >
> > > Could I suggest that this code not be part of EVMS, but that
> > > you implement it as a library within the core kernel?  Lots of
> > > stuff is going to need BIO splitting - software RAID, ataraid,
> > > XFS, etc.  May as well talk with Jens, Martin Petersen, Arjan,
> > > Neil Brown.  Do it once, do it right...
> > >
> > I take that back.
> >
> > We really, really do not want to perform BIO splitting at all.
> > It requires that the kernel perform GFP_NOIO allocations at
> > the worst possible time, and it's just broken.
> >
> > What I would much prefer is that the top-level BIO assembly
> > code be able to find out, beforehand, what the maximum
> > permissible BIO size is at the chosen offset.  It can then
> > simple restrict the BIO to that size.
> >
> > Simply:
> >
> >  max = bio_max_bytes(dev, block);
> >
> > which gets passed down the exact path as the requests themselves.
> > Each layer does:
> >
> > int foo_max_bytes(sector_t sector)
> > {
> >  int my_maxbytes, his_maxbytes;
> >  sector_t my_sector;
> >
> >  my_sector = my_translation(sector);
> >  his_maxbytes = next_device(me)->max_bytes(my_sector);
> >  my_maxbytes = whatever(my_sector);
> >  return min(my_maxbytes, his_maxbytes);
> > }
> >
> > and, at the bottom:
> >
> > int ide_max_bytes(sector_t sector)
> > {
> >  return 248 * 512;
> > }
> >
> > BIO_MAX_SECTORS and request_queue.max_sectors go away.
> >
> > Tell me why this won't work?
> 
> This would require the BIO assembly code to make at least one
> call to find the current permissible BIO size at offset xyzzy.
> Depending on the actual IO size many foo_max_bytes calls may
> be required. Envision the LVM or RAID case where physical
> extents or chunks sizes can be as small as 8Kb I believe. For
> a 64Kb IO, its conceivable that 9 calls to foo_max_bytes may
> be required to package that IO into permissibly sized BIOs.
> 
> What your proposing is doable, but not without a cost.

Why not just put the smallest required BIO size in a struct for that device?
Then each read of that struct can be kept in cache...

Is the BIO max size going to change at different offsets?
