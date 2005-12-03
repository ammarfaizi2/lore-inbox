Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbVLCSxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVLCSxN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVLCSxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:53:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40076 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932145AbVLCSxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:53:12 -0500
Date: Sat, 3 Dec 2005 10:52:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, jeffm@suse.com
Subject: Re: [PATCH] fs: remove s_old_blocksize from struct super_block
In-Reply-To: <Pine.LNX.4.64.0512031429360.11664@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.64.0512031044120.3099@g5.osdl.org>
References: <1133558437.31065.6.camel@localhost> 
 <Pine.LNX.4.64.0512031058350.11664@hermes-1.csi.cam.ac.uk>
 <1133609645.7989.3.camel@localhost> <Pine.LNX.4.64.0512031429360.11664@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Dec 2005, Anton Altaparmakov wrote:
> 
> This means we are now back to the old behaviour where fs utilities will 
> behave randomly/unpredictably depending on what fs was mounted (or even 
> was tried to be mounted!) on the device last.  So for example a failing 
> "mount -t auto" will leave the block size set to a random number when all 
> fs utilities (at least used to) asume the block size is 1k and strangeness 
> ensues.

No, an open() with a zero count should re-set the block size to the "best 
possible one". This gives you _consistently_ the blocksize you should get. 
See bd_set_size().

Which is basically the biggest possible one that we can handle that also 
handles the size of the device correctly (if the device has an odd number 
of sectors, you need to set blocksize to just 512).

So things are consistently "optimal", which is the whole point. An opener 
can then set it to some sub-optimal value (which may be bigger and faster, 
but will mean that the last odd sectors can't be reached) by hand if it 
cares.

And of course, if multiple openers exist, there is no consistent value at 
all. It's a bug in user space (and we don't allow that for mounted block 
devices, since the filesystem often _requires_ a particular blocksize).

> I have no idea why Jeff (Mahoney) considered the setting to be 
> unnecessary, when Al Viro added the resetting code a few years ago it 
> was done precisely because utilities were behaving randomly/erratically...

The old code was buggy. It caused both performance problems (lower 
blocksize than necessary when new openers came in, causing really bad 
throughput) and iirc correctness problems (it would stick a 1kB blocksize 
on a device that couldn't then read the last sector, so accessing the 
device with /dev/xyz wouldn't get all the data).

You can still set the blocksize explicitly, but you need to do it AFTER 
you've opened the device exclusively. 

It was a BUG to do anything else (eg set the blocksize at boot and expect 
that the broken blocksize would get restored after others realized they 
needed something else).

Now, it's entirely possible that we've introduced other breakage since, 
but unless you can show a real case, I think you're barking up the wrong 
tree. 

			Linus
