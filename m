Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285261AbRLFWld>; Thu, 6 Dec 2001 17:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285255AbRLFWlR>; Thu, 6 Dec 2001 17:41:17 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36367 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285266AbRLFWk4>; Thu, 6 Dec 2001 17:40:56 -0500
Date: Thu, 6 Dec 2001 14:34:28 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <E16C76m-0003Kk-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0112061422040.12667-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Dec 2001, Alan Cox wrote:
>
> Ok so kdev_t will split into structs for char and block device which are
> seperate things ?

Yes. And the name will change to reflect that.

(Ie once char and block are separate, like they logically are in the
namespace anyway, there's no "dev_t" at all, it's all "struct char_device"
or "struct block_device" and they have nothing in common).

We already have pretty much all the infrastructure in place for this, it's
just that a lot of calling conventions have "kdev_t" still (which is
actually ambiguous as-is - you have to look at the function name etc to
figure out if it is a character device or a block device).

The main ones are things like "bread()" down all the way to the bottom of
the IO path. The sad thing is that along the whole path, we actually end
up needing the structure pointer in different places, so the IO code
(which is supposed to be timing-critical) ends up doing various lookups on
the kdev_t several times (both at a higher level and deep down in the IO
submit layer).

So now we have to do "bdfind()" *kdev_t -> block_device", and
"get_gendisk()" for "kdev_t -> struct gendisk" and about 5 different
"index various arrays using the MAJOR number" on the way to actually doing
the IO.

Even though the filesystems that want to _do_ the IO actually already have
the structure pointer available, and all the indexing off major would
actually fairly trivially just be about reading off the fields off that
structure.

(Ugh, just _look_ at the code looking up block size, sector size,
"readonly" status, queue finding, statistics gathering etc. The
ro_bits thing seems to "know" that "long" is 32 bits etc. It's enough to
make you cry ;)

Oh, well. It _is_ going to be quite painful to switch things around.

		Linus

