Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313339AbSDYT75>; Thu, 25 Apr 2002 15:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313346AbSDYT74>; Thu, 25 Apr 2002 15:59:56 -0400
Received: from ns0.cobite.com ([208.222.80.10]:56843 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S313339AbSDYT7z>;
	Thu, 25 Apr 2002 15:59:55 -0400
Date: Thu, 25 Apr 2002 15:59:43 -0400 (EDT)
From: David Mansfield <david@cobite.com>
X-X-Sender: david@admin
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Mark Peloquin <peloquin@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <20020425194346.GN574@matchmail.com>
Message-ID: <Pine.LNX.4.44.0204251554150.2249-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > In EVMS, we are adding code to deal with BIO splitting, to
> > > > > enable our feature modules, such as DriveLinking, LVM, & MD
> > > > > Linear, etc to break large BIOs up on chunk size or lower
> > > > > level device boundaries.
> > > >
> > > > Could I suggest that this code not be part of EVMS, but that
> > > > you implement it as a library within the core kernel?  Lots of
> > > > stuff is going to need BIO splitting - software RAID, ataraid,
> > > > XFS, etc.  May as well talk with Jens, Martin Petersen, Arjan,
> > > > Neil Brown.  Do it once, do it right...
> > > >
> > > I take that back.
> > >
> > > We really, really do not want to perform BIO splitting at all.
> > > It requires that the kernel perform GFP_NOIO allocations at
> > > the worst possible time, and it's just broken.
> > >
> > > What I would much prefer is that the top-level BIO assembly
> > > code be able to find out, beforehand, what the maximum
> > > permissible BIO size is at the chosen offset.  It can then
> > > simple restrict the BIO to that size.
> > >

[snipped some ideas]

> 
> Why not just put the smallest required BIO size in a struct for that device?
> Then each read of that struct can be kept in cache...
> 
> Is the BIO max size going to change at different offsets?

My two cents as a non-guru: there are two different reasons for splitting 
a large BIO: 

1) some layer has hit some uncommon boundary condition, like spanning
linearly appended physical volumes in an LV or something like that

2) a fundamental 'maximum-chunkiness' allowed by some layer has been 
exceeded, like stripe size in a raid, or MAX_SECTORS in ide or something 
like that.

It would suck if the system generated large BIOS that needed to be split
for every IO operation, due to #2, but it would also suck to add overhead
to every IO operation for #1.

#1 is an exception, and I think it would be acceptible to have a splitting 
function/mempool for handling what should be a boundary condition only, 
and the concept of a call through the layers to find out #2 at open time 
would handle #2 one time per device or something like that.

David




-- 
/==============================\
| David Mansfield              |
| david@cobite.com             |
\==============================/

