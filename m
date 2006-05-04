Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWEDHKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWEDHKj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWEDHKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:10:39 -0400
Received: from mail.bmlv.gv.at ([193.171.152.37]:20966 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id S1750728AbWEDHKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:10:39 -0400
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] kernel facilities for cache prefetching
Date: Thu, 4 May 2006 09:08:09 +0200
User-Agent: KMail/1.9.1
Cc: Linda Walsh <lkml@tlinx.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
References: <346556235.24875@ustc.edu.cn> <44594AA9.8020906@tlinx.org> <Pine.LNX.4.64.0605031829300.4086@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605031829300.4086@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605040908.10727.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 May 2006 03:31, Linus Torvalds wrote:
> On Wed, 3 May 2006, Linda Walsh wrote:
> > >  - it gives you only a very limited view into what is actually going
> > > on.
> >
> >    ???  In what way?  I don't think we need a *complex* view of what
> > is going on.
>
> The block-based view is a very simple one, but it's _too_ simple. It
> doesn't actually tell the user what is happening. It doesn't tell you why
> the request happened in the first place, so it leaves you no way to really
> do anything sane about it.
>
> You can't prefetch (because the indexing is wrong), and you can't actually
> even analyze it (because you don't know any background to what you're
> seeing). In short, you can't _do_ anything with it.

Please forgive me if I'm dumb, but what about the following reasoning:

The user as such (the person just *using* the computer) won't do anything 
with "program xyz uses block a, b, and c.".
But it wouldn't help much if he was told "program xyz uses files a, b, and d."
That's a task for package maintainers and distributions to optimize the 
*number* of accesses.


So the simple information which block numbers we need would not benefit the 
users (or the distribution developers), but it's enough for caching things:


Ascending block numbers on disk can be read very fast, as the disk needs no or 
less seeking. That's even true for stripes and mirrors. (I grant you that 
there are complicated setups out there, but these could be handled similar.)


If we know which blocks are read (directories, inodes, data), an early 
userspace application (possibly even from initrd) could
- read these blocks into a ramdisk device (linearly),
- define a device mapper as a mirror of 
  - the original root partition,
  - and a sparse device composed from parts of the ramdisk, interleaved by
    non-existing (error-producing) ranges, and
- setup the device mapper as a root device.
- In a specified point at startup the mapping device gets set to just
  a linear interpretation of the root partition, and the ramdisk gets
  discarded.



Example:
--------

N specifies a needed block, the numbers other blocks.

  Harddisk: 1 2 3 N N N 7 8 N 10 N 12 13 14 N 16 N ...
  RAM-Disk contains 4 5 6 9 11 15 17

The mirror set would look like this, 
with E representing an error-returning block:

  Harddisk:             1 2 3 N N N 7 8 N 10  N 12 13 14  N 16  N ...
  mapped from RAM-Disk: E E E 4 5 6 E E 9  E 11  E  E  E 15  E 17 ...


Advantages:
- As long as there's a good chance that the needed blocks are read from the
  ramdisk (which was filled linearly, with 20-60MB/sec as reported by others),
  *all* disk-access times (inodes, directories, data) should be nearly zero.
  Of course, there will be blocks which have now to be read which weren't
  needed the last boot, which will have to be taken from the harddisk,
  but the majority should be taken from the ramdisk.

Problems:
- We'd need to define a priority in the mirror set, so that *everything*
  possible is taken from the ramdisk
- There has to be a way to *not* disable the ram-disk when an error-block is
  read.


That's completely doable in userspace (except for knowing which blocks have to 
be read), and doesn't sound like much overhead to me.


Suggestions, ideas?
Does that work? Does it not?


Regards,

Phil
