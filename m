Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135386AbRDZMi7>; Thu, 26 Apr 2001 08:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135401AbRDZMis>; Thu, 26 Apr 2001 08:38:48 -0400
Received: from cm.med.3284844210.kabelnet.net ([195.202.190.178]:59916 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S135397AbRDZMiD>; Thu, 26 Apr 2001 08:38:03 -0400
Date: Thu, 26 Apr 2001 14:37:58 +0200 (CEST)
From: Herbert Valerio Riedel <hvr@hvrlab.org>
X-X-Sender: <hvr@janus.txd.hvrlab.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
cc: <linux-crypto@nl.linux.org>, <linux-kernel@vger.kernel.org>, <ak@suse.de>,
        <axboe@suse.de>, <astor@fast.no>
Subject: Re: Announce: cryptoapi-2.4.3 [aka international crypto (non-)patch]
In-Reply-To: <3AE7FCDE.C5B3385@pp.inet.fi>
Message-ID: <Pine.LNX.4.33.0104261358460.493-100000@janus.txd.hvrlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello!

On Thu, 26 Apr 2001, Jari Ruusu wrote:
> Herbert Valerio Riedel wrote:
> > On Tue, 24 Apr 2001, Jari Ruusu wrote:
> > it should have been more or less:
> >
> > unsigned long IV = loop_get_iv(lo,
> >   page->index * (PAGE_CACHE_SIZE >> LO_IV_SECTOR_BITS)
> >   + (offset - lo->lo_offset) >> LO_IV_SECTOR_BITS));
> I hope not exactly like that. What happens when "lo->lo_offset" is larger
> than "offset". Oops. Besides, the + operator takes precedence over the >>
> operator on the third line.
...you are right again :-)

do you have any objections about...

unsigned long IV = loop_get_iv(lo,
   page->index * (PAGE_CACHE_SIZE >> LO_IV_SECTOR_BITS)
   + (offset >> LO_IV_SECTOR_BITS)
   - (lo->lo_offset >> LO_IV_SECTOR_BITS));


...then? ;-)

the assumption is, offset % LO_IV_SECTOR_BITS == 0
this calculation may overflow anyway... for file sizes around terabytes or
so I guess... but another thing is, that every IV calculation should
overflow at the same boundary... since it's just an IV value...

(maybe that calculation should be done in a 64bit domain anyway)

> Have you ever observed the sizes of the transfer requests? The sizes of
> transfer requests change on the fly (and I'm not not talking about the last
> partial block of a file). Meaning, any IV computation that depends on the
> block size of a filesystem, is broken and must die! We do not have an option
> here.
I know that issue, I've already pointed that out some time ago, but there
are compatibility problems as well, at first I thought the international
crypto patch was the only filter to make use of that IV, but then I
learned there were a few others as well...
(btw, the int crypto patch had the compatibility option for absolute block
numbers for quite some time too... just for the sake of compatibility...)

and btw, many people seem to be quite happy with their non-512 based IV
encrypted volumes... so why forcing them to switch?

btw, depending on the filesystem using the loop device, and the underlying
file or device, the transfer requests size may be constant... e.g. at 4k
blocks... but other filesystems, such as XFS do have different sections
with different blocksizes... they clearly break things...

breaking up transfers into 512 bytes _everytime_ isn't a solution
either... it is unefficient, especially for filters not making use of the
IV at all...

> Just for the record, loop-AES package does 512 byte based IV and does not
> care about filesystem block size. loop-AES package does not change kernel
> sources and is almost immune to kernel source changes made by distro
> vendors. Look, here I'm building loop-AES on almost vanilla 2.2.19aa2.
:-)

what I'm trying to say, you just take the kernel's loop.c, patch it to do
512 byte IV calculation (and 512 byte requests) and requiring the user to
load it... you actually require the user to not have the loop.c device
compiled into the kernel... and when your loop module is loaded into the
kernel the stock loop module can't be at the same time... it's an XOR
solution...

[..build log...]
> Here I'm building loop-AES on 2.2.19aa2-bad where I intentionally changed
> loop.c in a way that makes the loop-AES patch fail, but Makefile has a
> working plan B.

[..build log2..]
>
> Result: Working loop.o module with AES cipher built in, and 512 byte IV.
>
> Here I'm building loop-AES on vanilla 2.4.3-ac14.
>
[...yet another build log...]
>
> Result: Working loop.o module with AES cipher built in, and 512 byte IV.
>
> Here I'm building loop-AES on 2.4.3-ac14-hvr5 with your kernel patch
> cryptoapi-2.4.3-hvr5/doc/loop-iv-2.4.3.patch applied, which makes the
> loop-AES patch fail, but Makefile has a working plan B.

[...guess what...]

> Result: Working loop.o module with AES cipher built in, and 512 byte IV.

two different minds -- two different approaches :-)

greetings,
-- 
Herbert Valerio Riedel      /     Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F 4142

