Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268015AbRG3VJ5>; Mon, 30 Jul 2001 17:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268003AbRG3VJs>; Mon, 30 Jul 2001 17:09:48 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:61701 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S267992AbRG3VJg>; Mon, 30 Jul 2001 17:09:36 -0400
Date: Mon, 30 Jul 2001 14:09:28 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [CFT] initramfs patch
Message-ID: <20010730140928.D20284@bluemug.com>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1010730153712.7347D-100000@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1010730153712.7347D-100000@mandrakesoft.mandrakesoft.com>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 03:50:33PM -0500, Jeff Garzik wrote:
> On Mon, 30 Jul 2001, Mike Touloumtzis wrote:
> > 
> > One thing that would make embedded systems developers very happy
> > is the ability to map a romfs or cramfs filesystem directly from
> > the kernel image, avoiding the extra copy necessitated by the cpio
> > archive.  Are there problems with this approach?
> 
> Yes -- you need to at that point store initialized structures.  Store
> the dcache in its unpacked state on the ROM image, etc.  That's the only
> way to "map" a romfs directly.  Otherwise there is ALWAYS an unpacking
> or translation step between filesystem image and in-memory image.
> 
> Mapping an in-memory image directly may seem like a good idea, but it is
> really not.  ESPECIALLY for embedded folks.

I think you're misunderstanding what I propose.  I'm talking about
having a device in /dev that would allow access to a filesystem
image (cramfs or romfs) that would be embedded in the in-memory
kernel image.

So yes, there would be an unpacking/translation step to get at the
file data, but it would be the normal memory map/page fault process
combined with the filesystem functionality already in cramfs/romfs,
and (more importantly) it would allow text pages to be dropped and
later reloaded from the kernel image, instead of duplicating data
from the kernel image into a nonpageable ramfs.  There would still
be a RAM hit but it would just be the dcache, icache, and other
such in-core metadata, not the entire contents of the files.

The reasons to integrate this into an infrastructure like the new
initramfs (instead of, say, catting the fs image onto the end of
the kernel) are:

a) The filesystem will have alignment requirements, which are
   easily specified in a linker script, and

b) We would want a block device to perform the process I describe
   above (it essentially just be a readonly ramdisk which knows
   where in the kernel image the filesystem resides, probably
   based on symbols inserted by the linker).

miket
