Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWB1QHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWB1QHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 11:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWB1QHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 11:07:16 -0500
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:16549 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751832AbWB1QHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 11:07:15 -0500
Message-ID: <44047523.2040307@comcast.net>
Date: Tue, 28 Feb 2006 11:06:59 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Memory compression (again). . help?
References: <4403A14D.4050303@comcast.net> <4403CAE9.5020007@ums.usu.ru> <44043F8C.7070500@comcast.net> <44044438.5000309@sannes.org>
In-Reply-To: <44044438.5000309@sannes.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Asbjørn Sannes wrote:
> John Richard Moser wrote:
>>>>> I'm not quite sure what I'm doing or when I have time, but I'm looking
>>>>> into writing in some hooks and a compression routine to manage
>>>>> compressed memory.
> <snip>
>> I'm actually looking to submit to mainline in the end ;P  It'd be a very
>> good permenant feature.  RAM is cheap, but CPU is even cheaper; if I buy
>> a gig of RAM and get 200M free, woohoo?
> 
> Nitin Gupta and myself has already started working on a implementation
> for 2.6, you are of course welcome to join our effort. Nitin has already
> made some code available where you can clearly see where such things
> could be done. I can recommend "Understanding the Linux kernel (3rd
> Edition)" by Daniel P. Bovet & Marco Cesati. Also, you could take a look
> at http://www.kernelnewbies.org/ under recommended books.
> 

That's cool.  How are you designing it?  I was planning on structuring
it such that I made the swapping system interruptible via hooks, and
wrote all the code in mm/compress.c; the swapping and vmscan code would
be only slightly touched to allow me to break out of it into compress.c,
where accounting of compressed pages would take place.  I had also
considered that I would need hooks in the disk cache system for it to
make an assumption that disk cache "may be in swap" or similar, as I
want to compress disk cache as well.

I considered that I would have to account my compressed pages to be
"Persistent" (program memory, anonymous memory) and "Transient" (disk
cache, can be freed when memory is low); this would allow for
"Transient" pages to be recognized and simply invalidated when memory
pressure is far too high, effectively allowing for the freeing of disk
cache after it's compressed without decompressing it.  This would of
course require "Transient" pages be designated a destructor so that when
freed they can alert the corresponding system to the action (i.e. tell
disk cache it can no longer access these "swapped" (compressed) pages).

Which compression algorithms are you using?  I did tests with Castro's
patch on 2.4, tweaking it up to 128K pages.  I found that efficiency
increased significantly at each binary step (4K, 8K, 16K...) up to 32K
blocks; beyond that, the gains were minimal.  I recommend WKdm or WK4x4
from Castro's patch, working on sets of 8 pages (32KiB) by default.  In
any case, compressed data should be tailed together; if it uses 9KiB
compressed, then there should be 2 full pages and one page with 3KiB
left, and that 3KiB should be used to store more compressed data.

The algorithm should be in a separate source file and register itself
with the compression system; it should be called indirectly via hook in
the compression code through the registration system.  This will allow
new compression venues to be used; for example heavier systems where the
processor is several orders of magnitude faster than disk may be able to
benefit from future LZMA compression on 64 blocks.

The {algorithm,blocksize} pair should be somehow derivable from the
accounting information to allow for algorithmic changes at runtime
including switching the algorithms used and the block size.  This would
allow for best-size-searching, where in a pinch the system can be
allowed to compress with heavier algorithms or even use multiple
algorithms to determine the best gains.

I had also considered what to do during extreme memory pressure.  My
original thoughts were to set soft and hard limits on how much memory is
used for compressed storage.  When the system encounters memory
pressure, it then attempts to compress memory and keep it in ram until
it hits the soft limit; then it starts swapping (preferably, swapping
the pages holding compressed data out).  If it reaches memory and swap
pressure (i.e. no swap file), it then begins to approach the hard limit.
 This means that if you have a 4M swap file and allow 25% soft limit and
90% hard limit, then you'll use 25% of RAM for compressed store until
the swap file fills; approach 90% of RAM holding a compressed store; and
then freak out and start OOM killing things because too much memory
pressure is happening.

At least, those are my thoughts.  How are you guys doing it?  Is there a
project page I can look into?

> 
> Mvh,
> Asbjørn Sannes
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                                     -- Evil alien overlord from Blasto
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEBHTrhDd4aOud5P8RAupLAJ4tS3t12gGqpSzNKtrgGoVwH3dRQgCcCAbe
D+T30PxooDojPXdJzuebC9U=
=8cPZ
-----END PGP SIGNATURE-----
