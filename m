Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291868AbSBHV4A>; Fri, 8 Feb 2002 16:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287781AbSBHVzt>; Fri, 8 Feb 2002 16:55:49 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:16539 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S291871AbSBHVzf>; Fri, 8 Feb 2002 16:55:35 -0500
Message-Id: <5.1.0.14.2.20020208211308.0385b910@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 08 Feb 2002 21:55:32 +0000
To: yodaiken@fsmlabs.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] New locking primitive for 2.5
Cc: nigel@nrg.org, Christoph Hellwig <hch@ns.caldera.de>,
        Ingo Molnar <mingo@elte.hu>, yodaiken <yodaiken@fsmlabs.com>,
        Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@zip.com.au>,
        torvalds <torvalds@transmeta.com>, rml <rml@tech9.net>
In-Reply-To: <20020208133851.B11590@hq.fsmlabs.com>
In-Reply-To: <5.1.0.14.2.20020208174632.00b0dad0@pop.cus.cam.ac.uk>
 <200202081231.g18CV7e31341@ns.caldera.de>
 <Pine.LNX.4.40.0202080838230.3883-100000@cosmic.nrg.org>
 <5.1.0.14.2.20020208174632.00b0dad0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 20:38 08/02/02, yodaiken@fsmlabs.com wrote:
>On Fri, Feb 08, 2002 at 08:14:32PM +0000, Anton Altaparmakov wrote:
> > The value of allowing multiple cpus to read the same data 
> simultaneously by
> > far offsets the priority problems IMVHO. At least the way I am using rw
> > semaphores in ntfs it is. Readlocks are grabbed loads and loads of 
> times to
> > serialize meta data access in the page cache while writelocks are a minute
> > number in comparison and because the data required to be accessed may not
>
>this is absolutely correct. However, once the decision has been made or
>fallen into to go to a priority inherit scheme, Linux will find itself
>in the same bind as Solaris.
>
> > be cached in memory (page cache page is not read in, is swapped out,
> > whatever) a disk access may be required which means a rw spin lock is no
> > good. In fact ntfs would be the perfect candidate for automatic rw combi
> > locks where the locking switches from spinning to sleeping if the code 
> path
> > reaches a disk access. I can't use a manually controlled lock as the page
>
>Seem like the lock is simply grabbed way to far up.

It cannot be taken any later. NTFS is a database both in memory and on disk 
and in fact the in memory meta data is the on-disk structures (i.e. no 
conversion between the two is performed, except in few speed optimization 
cases and in cases where meta data is compressed on disk).

Because everything is ogranized in database records, I need to grab the 
lock as soon as I intend to access the record (in fact the lock itself is 
taken by map_mft_record(READ or WRITE) which returns a locked record, that 
is mapped and pinned in memory, to the caller. I can then do all sorts of 
things with the record, like search it, parse data from it, etc. When 
finished I unmap_mft_record(READ or WRITE) which undoes everything 
map_mft_record() did, i.e. unpins the record, unmaps it and releases the lock.

All transactions with the on disk storage are done via the page cache and 
read_cache_page() using a special readpage() and a special async io 
completion handler.

Because of the abstraction of access layers it is undesirable to operate on 
the same locks in different layers, hence the top most layer is the one 
locking and unlocking the records. The lower layers don't even know the 
locks exist. Also pushing the lock deep into the layers is not actually 
possible as it would probably need to be taken in reac_cache_page() (the 
only place where the code knows if the page is present in memory or not and 
a disk access is required) which is a VFS/MM function and hence that is not 
an option.

Further, I may need to allocate memory in order to store decompressed 
metadata for example but I won't know if I need to do that until I have 
already locked the record and accessed it to determine if the metadata is 
compressed or not.

So basically I can only obtain sufficient info for deciding what lock I 
need after I have already accessed parts of the record, but to access it I 
need to have locked it. Chicken and egg situation... So the locks are 
always semaphores and are taken in the top layer.

A combi lock would allow spinning in the case where it turns out the code 
paths will not hit disk or sleep in kmalloc, etc and sleeping in the 
disk/kmalloc hit case.

(Yes I know atomic kmalloc exists but I actually need vmalloc in some cases 
depending how much memory I need to handle the metadata...)

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

