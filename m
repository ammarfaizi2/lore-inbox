Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbTHVSZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263951AbTHVSZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:25:19 -0400
Received: from corky.net ([212.150.53.130]:8924 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S263926AbTHVSZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:25:05 -0400
Date: Fri, 22 Aug 2003 21:25:01 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Livio Baldini Soares <livio@ime.usp.br>
Cc: mason@suse.com, <andrea@suse.de>, <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: io-stalls again (was "Re: Bug in drivers/block/ll_rw_blk.c")
In-Reply-To: <20030822153501.GB31360@ime.usp.br>
Message-ID: <Pine.LNX.4.44.0308222028150.27026-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, Livio Baldini Soares wrote:

[...snip...]

[ for people who jump in, my original description of the problem can be
found here: http://lkml.org/lkml/2003/8/19/259 ]

>   From  this description  it seems  that you  are hitting  a bug  which was
> discussed to death here on the  list. Here's a thread with 143 messages for
> you:
>
> http://marc.theaimsgroup.com/?t=105400721000001&r=5&w=2
>
>   And here are the threads in which a solution was dicussed:
>
> http://marc.theaimsgroup.com/?t=105519528200001&r=1&w=2
> http://marc.theaimsgroup.com/?t=105769525800005&r=3&w=2
>
>   Notice, however, that  the patch Chris, Andrea, Jens  and others made for
> this  problem is _already_  included in  2.4 (so,  yes, 2.4.22-rc2  has the
> fix).
>

Yes, I guess its related to the same problem.  I think the patch actually
broke something.  I see that it was introduced in 2.4.22-pre3, and thats
exactly where the problem became much worse.  I switched back to
2.4.22-pre2 and it mostly works.  It still stalls on extreme conditions
but not as easily as with later kernels.  With pre7 and rc2 which I tested
lately, it happens very quickly under heavy load.

>   So, you are  probably hitting the same bug, which was  not fixed 100%. If
> you think  that your  test is  very easily reproducible  and can  shed more
> light on this  problem, perhaps you should write to  Chris, Andrea and Jens
> (with Cc: to the list), and show  them the test. I don't know if they would
> be willing to spend more time  on this issue, specially with 2.6 around the
> corner...
>

Not only did the patch fail to fix it 100%, but it actually made it a lot
worse in my case.

Its easily reproducable once you have a big cloop image in place, but I
guess that doesn't qualify as easy reproduction for busy kernel
developers.  I hope someone will still take the time to look into it.

If someone has some speculations/suggestions but no time to test it, send
it to me and I'll run the tests and post the results.

The easiest way to trigger it with recent kernels is to download a large
cloop image such as the large file called KNOPPIX in the Knoppix ISO
image, attach it, and create a lot or load on it.

If someone wishes to try this, here's how I reproduce it:
* Download the latest ISO from http://knoppix.net/get.php
* mount -o loop the image and extract the file KNOPPIX/KNOPPIX
* Download cloop from
  http://developer.linuxtag.net/knoppix/sources/cloop_1.0-2.tar.gz
* extract cloop, make, insmod cloop.o, mknod /dev/cloop b 200 0
* losetup /dev/cloop /path/to/KNOPPIX && mount /dev/cloop /mnt
* tar cf - /mnt >/dev/null
* while tar is running, access some random files in /mnt.

With 2.4.22-rc2 the above will stall in less than a minute and will remain
stalled until another process accesses other files in the filesystem
storing KNOPPIX.

It may be possible to reproduce the same stall with loop.o but takes much
longer.  Could be related to the fact that cloop.o is a single thread
while loop.o has a separate reader thread.  Could this affect the problem ?

Anyway, if someone has a suggested test/patch, post it and I'll post the
results.  Hopefully we can nail this next-to-last bug :)

>   best regards,
>
> --
>   Livio B. Soares
>

Thanks,
	Yoav Weiss

