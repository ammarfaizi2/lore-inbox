Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSAESH0>; Sat, 5 Jan 2002 13:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288915AbSAESHN>; Sat, 5 Jan 2002 13:07:13 -0500
Received: from mustard.heime.net ([194.234.65.222]:33252 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S288914AbSAESHD>; Sat, 5 Jan 2002 13:07:03 -0500
Date: Sat, 5 Jan 2002 19:06:58 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: "Leech, Christopher" <christopher.leech@intel.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Error loading e1000.o - symbol not found
In-Reply-To: <BD9B60A108C4D511AAA10002A50708F22C13CF@orsmsx118.jf.intel.com>
Message-ID: <Pine.LNX.4.30.0201051831500.10133-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

First checked for symbols, and it all looked fine.
Then make distclean, copy back the .config file, make menuconfig, make
dep bzImage etc.

Then it finds the card, detects speed (it's linked up with a crossed TP
cable to a FreeBSD computer).

Well... It can't connect to the network, neither the Gbps network between
the two, or on lower speed. Not even the normal network.

Is this a know error?

Btw: The latest patch, patch_v3681, is an image file. Is this right? :-)

$ file patch_v3681
patch_v3681: PC bitmap data, Windows 3.x format, 61 x 47 x 8


roy

# grep _mmx_memcpy /proc/ksyms
c0288ee0 _mmx_memcpy_R__ver__mmx_memcpy

# grep _mmx_memcpy /usr/src/linux/include/linux/modules/i386_ksyms.ver
#define __ver__mmx_memcpy       15670e2d
#define _mmx_memcpy     _set_ver(_mmx_memcpy)

# objdump -r /usr/src/e1000-3.6.8/src/e1000.o | grep _mmx_memcpy
000012f5 R_386_PC32        _mmx_memcpy
0000132c R_386_PC32        _mmx_memcpy
00002d4b R_386_PC32        _mmx_memcpy
00002d85 R_386_PC32        _mmx_memcpy


On Fri, 4 Jan 2002, Leech, Christopher wrote:

> Based on there being only one symbol mismatch, I think the correct headers
> are being used.  If you're worried about that, you can pass in the location
> of the kernel source when building e1000 with a KSRC variable (make
> KSRC=/usr/src/linux or wherever the kernel tree is).
>
> Is it possible that some stale symbol version information was left from a
> previous kernel build, maybe from before a patch was applied?  In order to
> fully clean out the symbol versions I would try saving a copy of your
> .config, then do a "make mrproper" instead of "make clean", then move the
> .config back and run the normal make dep bzImage modules.
>
> It should be easy enough to see if this is the problem, just check the
> symbol version string for _mmx_memcpy in the kernel, the e1000 module, and
> in the kernel source tree.
>
>   running kernel : grep _mmx_memcpy /proc/ksyms
>   kernel source  : grep _mmx_memcpy include/linux/modules/i386_ksyms.ver
>   e1000 module   : objdump -r e1000.o | grep _mmx_memcpy
>
> All three should match ... but I'm guessing that in your case they don't.
> If your kernel and the i386_ksyms.ver file don't agree on the symbol
> version, the "make mrproper" idea should help.  If e1000 is the odd man out,
> we'll have to keep looking for something else.
>
> I was able to build a kernel with your configuration, then build e1000
> against it and run depmod using System.map.  However, I didn't actually try
> running the kernel as I don't have any AMD systems.
>
> - Chris Leech <christopher.leech@intel.com>
>
>
> Roy Sigurd Karlsbakk wrote:
>
> > I know this might be the wrong place, as the e1000 driver is custom made
> > by Intel, but I hope there's an easy way to fix it.
> >
> > After building a new 2.4.17 kernel with mjc1 and tux patches, I compile
> > the intel e1000 driver (downloaded from
> >
> http://downloadfinder.intel.com//scripts-df/Detail_Desc.asp?ProductID=749&Dw
> nldID=2897 \
> > ).
> >
> > When trying to insmod the driver, I get the following errors:
> >
> > /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: unresolved symbol
> _mmx_memcpy
> > /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: insmod \
> > /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o failed \
> > /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: insmod e1000 failed
> >
> > What's this? Is _mmx_memcpy only valid on Intel architecture? Does Athlon
> > have any equivalent system call?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

