Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSGVDSr>; Sun, 21 Jul 2002 23:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSGVDSr>; Sun, 21 Jul 2002 23:18:47 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:39351 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315544AbSGVDSq>; Sun, 21 Jul 2002 23:18:46 -0400
Message-Id: <5.1.0.14.2.20020722040423.042eb710@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 22 Jul 2002 04:22:42 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: O_DIRECT read and holes in 2.5.26
Cc: Stephen Lord <lord@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D3B6D57.BB5C0F38@zip.com.au>
References: <1026981790.1258.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

At 03:26 22/07/02, Andrew Morton wrote:
>Stephen Lord wrote:
> > Did you realize that the new O_DIRECT code in 2.5 cannot read over holes
> > in a file.
>
>Well that was intentional, although I confess to not having
>put a lot of thought into the decision.  The user wants
>O_DIRECT and we cannot do that.  The CPU has to clear the
>memory by hand.  Bad.
>
>Obviously it's easy enough to put in the code to clear the
>memory out.  Do you think that should be done?

I would vote for yes because whether a file is sparse or not cannot be 
trivially controlled by the file creator (unless you actually write the 
whole file with non-zero content) but is dependent on the underlying file 
system... And on the grounds that a memset() is going to be a lot faster 
than a read from device I don't see why it shouldn't be done.

> >  The old code filled the user buffer with zeros, the new code
> > returned EINVAL if the getblock function returns an unmapped buffer.
> > With this exception, XFS does work with the new code - with more cpu
> > overhead than before due to the once per page getblock calls.
>
>OK, thanks.  Presumably XFS has a fairly heavyweight get_block()?
>
>I'd be interested in seeing just how expensive that O_DIRECT
>I/O is, and whether we need to get down and implement a
>many-block get_block() interface.

For NTFS get_block() is extremely expensive and grows O(n) with the 
position / length / fragmentation of the file being accessed. So doing 8 * 
get_block() for one page cache page versus 1 * get_blocks() would make a 
factor 8 and higher difference in speed in get_block() CPU time.

To give an idea of how heavy it is, get_block() may easily be linearly 
searching and array of several hundred kilobytes and several thousand/tens 
of thousand of entries in it, for _each_ get_block() call. And each time we 
have to start from scratch due to having dropped the read lock we were 
holding to give us access to the block mapping details.

Note I actually have ideas how to optimize the search algorithm using a 
binary search but even then a get_blocks() would remain 8 * faster than a 
single one.

At present instead of using get_block(), I reimplement all the VFS helpers 
completely just for this change, so I can optimize away the "having to 
restart the search for each block" bit. And this seems to improve the speed 
of accessing highly fragmented files but I haven't actually done 
measurements, so take this with a pinch of salt... "It feels faster" but it 
could be wishful thinking...

>Any numbers/profiles available?

Sorry no but since I don't have an SMP machine any numbers I produce would 
not be terribly exciting, at least for NTFS where the multiple block 
optimization has massive influence on how locking is done at present. In 
fact a get_blocks() interface would allow me to optimize the locking quite 
a bit even further while making NTFS more conformant to the VFS concept of 
having a get_block() function...

Just my 2p.

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

