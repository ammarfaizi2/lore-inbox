Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135735AbRDYOGA>; Wed, 25 Apr 2001 10:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135737AbRDYOFu>; Wed, 25 Apr 2001 10:05:50 -0400
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:43790 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S135735AbRDYOFk>; Wed, 25 Apr 2001 10:05:40 -0400
Date: Wed, 25 Apr 2001 16:05:27 +0200 (CEST)
From: Herbert Valerio Riedel <hvr@hvrlab.org>
X-X-Sender: <hvr@janus.txd.hvrlab.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
cc: <linux-crypto@nl.linux.org>, <linux-kernel@vger.kernel.org>, <ak@suse.de>,
        <axboe@suse.de>, <astor@fast.no>
Subject: Re: Announce: cryptoapi-2.4.3 [aka international crypto (non-)patch]
In-Reply-To: <3AE56615.C53CE33A@pp.inet.fi>
Message-ID: <Pine.LNX.4.33.0104251552320.14365-100000@janus.txd.hvrlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

On Tue, 24 Apr 2001, Jari Ruusu wrote:
> linux-2.4.3-cryptoapi-hvr4/drivers/block/loop.c lines 270...279 after your
> kernel patch:
>
> static int lo_read_actor(read_descriptor_t * desc, struct page *page, unsigned long offset, unsigned long size)
> {
> 	char *kaddr;
> 	unsigned long count = desc->count;
> 	struct lo_read_data *p = (struct lo_read_data*)desc->buf;
> 	struct loop_device *lo = p->lo;
> 	unsigned long IV = loop_get_iv(lo, (page->index * PAGE_CACHE_SIZE + offset - lo->lo_offset) >> LO_IV_SECTOR_BITS);
>                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 	if (size > count)
> 		size = count;
>
> Have you tested that code with partitions or files that are larger than
> 4 gigs? On systems where int is 32 bits, that computation overflows.
you're right, I actually had it right in the first place, but stupidly
rewrote it to overflow C:-)

it should have been more or less:

unsigned long IV = loop_get_iv(lo,
  page->index * (PAGE_CACHE_SIZE >> LO_IV_SECTOR_BITS)
  + (offset - lo->lo_offset) >> LO_IV_SECTOR_BITS));


I'll be fixed in cryptoapi-2.4.3-hvr6 (see http://www.hvrlab.org/crypto/)

oh, and btw, it should only concern file backed loop's... block devices,
as partitions, should have worked fine...

> If you want 512 byte based IV computation without modifying your kernel at
> all, you can use the loop.o module from my loop-AES package. I haven't tried
> using your modules based cryptoapi and my loop-AES drivers together, but I
> don't see any obvious reason why they couldn't be used simultaneously.

erm... I've looked at your patch... you do just the same thing as I do, as
it concerns 'changing the kernel'... but you do it in a 'static' way... I
want it to be changeable at runtime... and letting the way open to add
more IV calculation variants in the future, which every filter can choose
among at initialization...

> Linux-crypto:  cryptography in and on the Linux system
> Archive:       http://mail.nl.linux.org/linux-crypto/

greetings,
-- 
Herbert Valerio Riedel      /     Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F 4142

