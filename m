Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312027AbSCQNlu>; Sun, 17 Mar 2002 08:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312028AbSCQNll>; Sun, 17 Mar 2002 08:41:41 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:14073 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S312025AbSCQNla>;
	Sun, 17 Mar 2002 08:41:30 -0500
Message-Id: <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 17 Mar 2002 13:41:37 +0000
To: Jeff Garzik <jgarzik@mandrakesoft.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: fadvise syscall?
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <3C945D7D.8040703@mandrakesoft.com>
In-Reply-To: <3C945635.4050101@mandrakesoft.com>
 <3C945A5A.9673053F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:10 17/03/02, Jeff Garzik wrote:
>Andrew Morton wrote:
>>Jeff Garzik wrote:
>>>So... we have madvise, why not fadvise?  I would love the capability for
>>>applications to provide hints to the OS like madvise, but for file
>>>descriptors...
>>
>>The one hint which I can think of which would be beneficial would
>>be an equivalent to MADV_SEQUENTIAL.  Something which says "this
>>is a big streaming read/write - don't go and evict other stuff because
>>of it".  O_STREAMING perhaps.  Or working dropbehind heuristics,
>>although I suspect that explicit controls will always do better.
>>
>>For MADV_RANDOM, readahead window scaling should get that right.
>>
>>What else were you thinking of?
>
>Hints for,
>* sequential read
>* sequential write
>* sequential write, where the application considers the data it's writing 
>to be unlikely to be read again any time soon (hopefully implying to the 
>page cache that these pages have low value as cacheable objects)
>* some sort of streaming hints, implying that the application cares a lot 
>about maintaining some minimum i/o rate.  note I said hint, not 
>requirement.  -not- guaranteed-rate-IO.
>
>I might even go so far as to advocate identifying common usage patterns, 
>and creating hint constants for them, even if we don't support them in the 
>kernel immediately (if ever).  Makes the interface much more future-proof, 
>at the expense of a few integers in a 32-bit numberspace, and a few more 
>bytes in the C compiler's symbol table.

We don't need fadvise IMHO. That is what open(2) is for. The streaming 
request you are asking for is just a normal open(2). It will do read ahead 
which is perfect for streaming (of data size << RAM size in its current form).

When you want large data streaming, i.e. you start getting worried about 
memory pressure, then you want open(2) + O_DIRECT. No caching done. Perfect 
for large data streams and we have that already. I agree that you may want 
some form of asynchronous read ahead with passed pages being dropped from 
the cache but that could be just a open(2) + O_SEQUENTIAL (doesn't exist yet).

All of what you are asking for exists in Windows and all the semantics are 
implemented through a very powerful open(2) equivalent. I don't see why we 
shouldn't do the same. It makes more sense to me than inventing yet another 
system call...

The Windows NT/2k/XP CreateFile() call is documented at below URL. Search 
for FILE_FLAG_* and there is a nice big table with all the possible access 
method hints one can give when opening or creating a file. Many of those 
make perfect sense to have in the Linux kernel, too and in fact with 
O_DIRECT we already have some of the functionality Windows offers (there it 
would be FILE_FLAG_NO_BUFFERING)

http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/filesio_7wmd.asp

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

