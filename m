Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270709AbTHJWHl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270714AbTHJWHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:07:41 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:47518 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S270709AbTHJWHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:07:37 -0400
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
From: Christophe Saout <christophe@saout.de>
To: Fruhwirth Clemens <clemens-dated-1061413386.7d8e@endorphin.org>
Cc: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, kernel@gozer.org,
       axboe@suse.de
In-Reply-To: <20030810210306.GA2235@ghanima.endorphin.org>
References: <20030810023606.GA15356@ghanima.endorphin.org>
	 <20030810140912.6F7224007E9@mwinf0301.wanadoo.fr>
	 <1060525667.14835.4.camel@chtephan.cs.pocnet.net>
	 <20030810210306.GA2235@ghanima.endorphin.org>
Content-Type: text/plain
Message-Id: <1060553236.25524.49.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 11 Aug 2003 00:07:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, 2003-08-10 um 23.03 schrieb Fruhwirth Clemens:

> cipher_null does not ignore the IV. The CBC processing takes place no matter
> what mapping function (aka electronic codebook) is used. The fact that
> cipher_null is an identity mapping does not stop CBC. 

The main problem with CBC is that you can't really do it. It only works
when you have a constant stream of data because you always need the
result from the previous encryption which you don't have when doing
something in the middle of the block device.

Before encryption the data to be encrypted gets xor'ed with the result
from the previous encrypted block. The idea in cryptoloop is that not
the result from the previous run gets used but a specially constructed
dummy block that has the sector number (little-endian encoded) in the
first four bytes and is null every where else. So you simply get some
additional perturbation based on the sector number, so that zero-filled
sectors always looked differently after encoding.

When decoding this means that the sector number is xor'ed over the
encrypted block. If, when decoding, the sector number doesn't match that
one that was put in the iv while encoding that sector, you will get
errors in the first four bytes, mostly one or few bits flipped.

> > I personally think that the only way to get things right is to do
> > encryption sector by sector (not bvec by bvec) since every sector can
> > have its own iv.
> 
> That's done anyway. Per convention the transformation module is allowed to
> increase the IV every 512 bytes. The IV parameter is only the initial
> initial vector ;). 

Yes, but as I described above, to get things right, the iv must be set
correctly on every sector.

Warning: A long analysis of obvious things is following. I think most of
you know everything I'm writing here, I'm just looking through the code
myself and trying to explain what's happening. On the end I'll find the
bug you fixed. I think that was the only bug regarding IV handling.

The cryptoloop code is doing things correctly. In ecb mode, every bio
could get converted at once, or every bvec. If this would have been done
with cbc mode as will, it could happen that 8 sectors get written at a
time, one full page, the cryptoloop encodes this into one scatterlist
entry (because only one bvec is used) and thus the iv from the first
sector will be used to encode all 8 sectors.

When reading a single sector in the middle of those a different iv would
be used to decrypt this data, some bits will be flipped (as described
above). Even worse things could have happened when several bvecs would
have been encoded one after the other without resetting the iv each time
(that's obvious).

============ analysis start ============

cryptoloop is getting this right:

const int sz = min(size, LOOP_IV_SECTOR_SIZE);
u32 iv[4] = { 0, };
iv[0] = cpu_to_le32(IV & 0xffffffff);

So the maximum block size can be a sector (LOOP_IV_SECTOR_SIZE is 512),
and the minimum block size too because auf the bio layer. So that's
fine.

IV++;
...

IV, the sector number is incremented after each run. Fine.

So, what's loop.c doing? do_lo_send:

index = pos >> PAGE_CACHE_SHIFT;
offset = pos & ((pgoff_t)PAGE_CACHE_SIZE - 1);
loop {
  IV = ((sector_t)index << (PAGE_CACHE_SHIFT - 9))+(offset >> 9);

So IV is basically pos >> 9 (position in file), the sector number.
That's fine.

  transfer(blabla);

  index++;
  pos += size;
  offset = 0;

pos isn't used be the iv code anymore, index is incremented by one page,
offset set to 0. Because size is always the remaining size to the end of
the cache page, that should be fine.
}

So encoding into a loop file should be fine.

lo_read_actor:

Mostly the same game, uses the page index and offset from sendfile,
that's the offset inside the file mapping. Should be correct. There's no
page looping done here, sendfile does it for us.

The loop over blockdevice uses a different function. loop_transfer_bio:

IV = from_bio->bi_sector + (lo->lo_offset >> 9);

The sector inside the device + the beginning on the block device gives
us the sector number on the block device. That's what we want.

__bio_for_each_segment(from_bvec, from_bio, i, 0) {
  ...
  ret |= lo_do_transfer(lo, bio_data_dir(to_bio), vto, vfrom,
               from_bvec->bv_len, IV);
  ...
}

Whoops... there is clearly something missing. IV is not a pointer That's
what you fixed. It seems to me that's the only bug. It also explains why
there are some bits flipped and nothing else.

========== analysis end ========== ;)

> > I've implemented a crypto target for device-mapper that does this and it
> > doesn't seem to suffer from these corruption problems:
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=105967481007242&w=2 and a
> > slightly updated patch: http://www.saout.de/misc/dm-crypt.diff
> 
> Nice! It's definitely a feature worth merging. loop.c used to be the place
> where to put this stuff, but why not replace it by newer in-kernel
> techniques?

Yes, I think putting this into loop.c adds unnecessary complexity.
Especially the IV handling is ugly. Sometimes the IV is calculated in
loop.c (three times) and sometimes it gets incremented in cryptoloop.c.
Wow. Error prone and ugly.

The device-mapper is just where this should go, I think. With
device-mapper it's also possible to resize the device on the fly which
is needed if the could should get integrated into a volume manager. The
cryptoloop implementation would only be able to encrypt the whole
partition volume that's fixed in size.

And, it's a lot simpler. And it doesn't do this page -> virtual address
-> page ping-pong translation between loop.c/cryptoloop.c and cryptoapi.

It also passed the swap-on-dm-crypt-under-memory-pressuse test, at least
for me.

And you can still use dm over loop device if you want to encrypt a file.

> > Should I repost the patch (inline this time) with an additional [PATCH]
> > or am I being annoying? Joe Thornber (the dm maintainer) would like to
> > see this patch merged.
> 
> If you can't get attention for your patch, try to convince someone "more
> important". DM maintainer is a good place to start :)

Yes, the DM maintainer helped me write the patch and would like to see
it merged. Convincing some more important persons would be easier if I
would get any reaction from them. ;)

I've also written a file backed target for dm, this one is inspired from
loop.c and also copies some code, especially the file handling functions
itself. It's not as safe under extreme memory pressure though, it
produces a lot of page allocation failures. That must be somewhere in
the vfs layer. If someone is interested in this target I could try to
find out how this can be avoided.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

