Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284586AbRLIWlR>; Sun, 9 Dec 2001 17:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284580AbRLIWlH>; Sun, 9 Dec 2001 17:41:07 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9268 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S284575AbRLIWlC>; Sun, 9 Dec 2001 17:41:02 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: torvalds@transmeta.com, marcelo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux/i386 boot protocol version 2.03
In-Reply-To: <200112090922.BAA11252@tazenda.transmeta.com>
	<m17krww8ky.fsf@frodo.biederman.org> <3C13DD48.3070206@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Dec 2001 15:20:56 -0700
In-Reply-To: <3C13DD48.3070206@zytor.com>
Message-ID: <m11yi4vxvb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> > A couple of notes:
> > 1) The minimum safe ramdisk address is 8MB (since 2.4.10).  On low
> >    mem machines you can get away with placing a ramdisk lower.  But we
> >    don't do any checking in our initial 8MB memory map.
> > 2) If we use units of kilobytes instead of bytes for this we don't
> >    loose any precision and gain the ability to put a ramdisk in high
> >    memory without bumping the protocol version.
> > 3) If we are going to export the maximum address we should also export
> >    the minimum address.
> >
> 
> (2) I guess I'm not so concerned with the ramdisk in highmem since it is
> extrememly unlikely any boot loader will be able to take advantage of that.  It
> could be an issue for x86-64, I guess.

I agree.  When you can spend a little extra time and get something working.
I find it nice.  If it doesn't work out oh, well.
 
> (3) Contradicts (1) as well as issues with older kernels.  Keep in mind what
> happens if you violate this limit: the bootloader should be loading the initrd
> as high as possible

Hmm.  Bootloaders have had lots of restrictions on getting up high.  
Plus in some real sense it make sense to pack the two as close
together as possible.  For 2.5.x and Al Viro's initfs work I'd like
to do that.

If you load your ramdisk at the same location every time, after
a point you have fewer surprises, and potentially a simpler bootloader.

>, so the only difference is if you get the error message from
> 
> the boot loader or from the kernel later.  If you're going to export a limit,
> you better make sure it's right; "8MB except on low memory configurations"
> doesn't cut it.  It's exactly on those low memory configurations that this limit
> 
> matters *at all*.

8MB is the safe limit.  The only worry some case right now is the
bootmem allocator with a darn huge bitmap.  It is allocated
dynamically, and it is extremely hard to predict where that will be
except in the initial page tables 8MB in size.  If the ugly bitmap
is allocated elsewhere the kernel can't use it.

On low memory configurations you have no choice.  But it will probably
work.  Getting better requires more work in setup.c than is likely to
go into 2.4.x.

On old kernels the big worry is the allocation of the struct page
array.  I have observed this array exceed 64MB in memory.  High enough
so that some older bootloaders can't load initrd high enough to cope.
I believe int 0x15 function ah=87 can't move blocks above that.

Either going high or going low with ramdisk placement requires
knowledge of how the kernel allocates it's memory.  And people don't
often reference bootloader docs when they change the policy so it is
fragile to depend upon how the kernel does it's allocations.

So if we are going to fix the fragility please let's handle both ends.
Then it will be o.k. to put the ramdisk where ever the kernel says
it is safe.  And we can stop this guessing and breaking game.

Eric
