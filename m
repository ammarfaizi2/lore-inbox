Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135861AbRDZSa4>; Thu, 26 Apr 2001 14:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135853AbRDZSar>; Thu, 26 Apr 2001 14:30:47 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:57845 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S135861AbRDZSag>; Thu, 26 Apr 2001 14:30:36 -0400
Message-ID: <3AE868C6.23C25119@pp.inet.fi>
Date: Thu, 26 Apr 2001 21:28:22 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Valerio Riedel <hvr@hvrlab.org>
CC: linux-crypto@nl.linux.org, linux-kernel@vger.kernel.org, ak@suse.de,
        axboe@suse.de, astor@fast.no
Subject: Re: Announce: cryptoapi-2.4.3 [aka international crypto (non-)patch]
In-Reply-To: <Pine.LNX.4.33.0104261358460.493-100000@janus.txd.hvrlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Valerio Riedel wrote:
> do you have any objections about...
> 
> unsigned long IV = loop_get_iv(lo,
>    page->index * (PAGE_CACHE_SIZE >> LO_IV_SECTOR_BITS)
>    + (offset >> LO_IV_SECTOR_BITS)
>    - (lo->lo_offset >> LO_IV_SECTOR_BITS));
> 
> ...then? ;-)

Looks fine.

> > Have you ever observed the sizes of the transfer requests? The sizes of
> > transfer requests change on the fly (and I'm not not talking about the last
> > partial block of a file). Meaning, any IV computation that depends on the
> > block size of a filesystem, is broken and must die! We do not have an option
> > here.
> I know that issue, I've already pointed that out some time ago, but there
> are compatibility problems as well, at first I thought the international
> crypto patch was the only filter to make use of that IV, but then I
> learned there were a few others as well...
> (btw, the int crypto patch had the compatibility option for absolute block
> numbers for quite some time too... just for the sake of compatibility...)
> 
> and btw, many people seem to be quite happy with their non-512 based IV
> encrypted volumes... so why forcing them to switch?

They are time bombs. Can you be sure that upper layers in the kernel won't
pass a transfer size that is not same as filesystem block size? I have seen
that happen. If you haven't, you have been lucky. I'd rather not depend on
luck.

> btw, depending on the filesystem using the loop device, and the underlying
> file or device, the transfer requests size may be constant... e.g. at 4k
> blocks... but other filesystems, such as XFS do have different sections
> with different blocksizes... they clearly break things...
> 
> breaking up transfers into 512 bytes _everytime_ isn't a solution
> either... it is unefficient, especially for filters not making use of the
> IV at all...

There is no point to limit transfers to 512 bytes. Transfer function just
needs to increment the original IV and reinitialize the cipher block
chaining process after every 512 bytes transferred.

> > Just for the record, loop-AES package does 512 byte based IV and does not
> > care about filesystem block size. loop-AES package does not change kernel
> > sources and is almost immune to kernel source changes made by distro
> > vendors. Look, here I'm building loop-AES on almost vanilla 2.2.19aa2.
> :-)
> 
> what I'm trying to say, you just take the kernel's loop.c, patch it to do
> 512 byte IV calculation (and 512 byte requests) and requiring the user to
> load it... you actually require the user to not have the loop.c device
> compiled into the kernel... and when your loop module is loaded into the
> kernel the stock loop module can't be at the same time... it's an XOR
> solution...

Transfer size is not altered, see previous comment. No need for user to load
the loop.o module, kmod does that automatically if CONFIG_KMOD=y. Build
instructions in a README file say that loop must be disabled the kernel
config for this externally compiled loop.o to work at all.

> two different minds -- two different approaches :-)

Ok.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
