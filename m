Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbRE0LpF>; Sun, 27 May 2001 07:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261741AbRE0Lo4>; Sun, 27 May 2001 07:44:56 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:22267 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S261719AbRE0Lon>; Sun, 27 May 2001 07:44:43 -0400
Message-Id: <5.1.0.14.2.20010527123154.00a96640@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 27 May 2001 12:45:25 +0100
To: Martin von Loewis <loewis@informatik.hu-berlin.de>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [Linux-ntfs] Re: [Linux-NTFS-Dev] Re: ANN: NTFS new
  release available (1.1.15)
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org,
        Linux-ntfs@tiger.informatik.hu-berlin.de,
        linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <200105271123.NAA21828@pandora.informatik.hu-berlin.de>
In-Reply-To: <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010526000503.04716ec0@pop.cus.cam.ac.uk>
 <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:23 27/05/2001, Martin von Loewis wrote:
> > I would love to move inode metadata to the page cache. That would simplify
> > so much in the NTFS driver and would result in an incredible speed boost
> > due to getting rid of all the silly copying of data back and forth inside
> > the driver as we could just pass pointers around instead (to locked pages
> > or other form of internal locking).
>[...]
> > No thank you. I would rather have it contiguous or at least logically
> > contiguous. I don't care if the pages are physically contiguous as long as
> > I can see them as one piece... I mean, ok, I could break up run lists, as
> > they are arrays of fixed size structs and the boundary cases would be
> > predictable
>
>When you talk about avoiding copying, are you thinking of not copying
>the runlists, as well? If so, how can you avoid uncompressing them?
>That seems very complicated, plus you have to concatenate the pieces
>of the runlist if they span multiple MFT records, anyway.

No, you can't avoid uncompressing them. But you can avoid copying all 
attributes out of the record into separate memory locations and then back. 
The run list is not part of the attribute so obviously has to be kept 
separate. Also, it is pointless to parse all attributes and their run lists 
on opening an inode, chaces are some of the attributes will never be 
touched at all and maybe we are just running stat on the file but don't 
want to start reading/writing the data. My idea involves a different run 
list format (as I already use in the linux-ntfs project on SF) which keeps 
[VCN, LCN, Length] records thus allowing you to not have the whole run 
list, i.e. if user accesses only beginning of the file, we only need to 
decompress the run list for the first extent. Also, this format allows out 
of line attribute extent handling, so if we access data at a certain offset 
we only get that extent and later as required we get the others and insert 
them into the run list. (This is not implemented yet, but I have been 
thinking about it.) Although I have to say I am not sure I want to have the 
run list extents fused into one. That only causes headaches when writing 
back the inode. But perhaps we can fuse them and then discard them without 
write back. Only if the attribute size changes do we need to deal with the 
problem but still it remains a problem.

> > They are not. They are derived from compressed on-disk structures (which
> > are re-compressed when updating the inode). Runlists of such large size 
> are
> > only needed for A) huge files/directories, B) extremely fragmented
> > files/directories, or C) a combination of A and B. (Remembering that
> > metadata is stored as files, so the same applies for the metadata itself.)
>
>I guess this answers my question - you will continue to uncompress the
>runlist when opening the inode, right?

Yes and no. They will be uncompressed but not when opening the inode. It 
will be "uncompress required extent's run list on demand". The current 
driver with uncompressing everything and keeping copies of all attributes 
is A) very slow and B) eats incredible amounts of memory when you are 
operating on large partitions (talking tens of Gb partitions).

Best regards,

Anton


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sf.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

