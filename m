Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSADXrs>; Fri, 4 Jan 2002 18:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285878AbSADXr3>; Fri, 4 Jan 2002 18:47:29 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:62912 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S285850AbSADXrV>; Fri, 4 Jan 2002 18:47:21 -0500
Message-ID: <BD9B60A108C4D511AAA10002A50708F22C13CF@orsmsx118.jf.intel.com>
From: "Leech, Christopher" <christopher.leech@intel.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Error loading e1000.o - symbol not found
Date: Fri, 4 Jan 2002 15:47:18 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on there being only one symbol mismatch, I think the correct headers
are being used.  If you're worried about that, you can pass in the location
of the kernel source when building e1000 with a KSRC variable (make
KSRC=/usr/src/linux or wherever the kernel tree is).

Is it possible that some stale symbol version information was left from a
previous kernel build, maybe from before a patch was applied?  In order to
fully clean out the symbol versions I would try saving a copy of your
.config, then do a "make mrproper" instead of "make clean", then move the
.config back and run the normal make dep bzImage modules.

It should be easy enough to see if this is the problem, just check the
symbol version string for _mmx_memcpy in the kernel, the e1000 module, and
in the kernel source tree.

  running kernel : grep _mmx_memcpy /proc/ksyms
  kernel source  : grep _mmx_memcpy include/linux/modules/i386_ksyms.ver
  e1000 module   : objdump -r e1000.o | grep _mmx_memcpy

All three should match ... but I'm guessing that in your case they don't.
If your kernel and the i386_ksyms.ver file don't agree on the symbol
version, the "make mrproper" idea should help.  If e1000 is the odd man out,
we'll have to keep looking for something else.

I was able to build a kernel with your configuration, then build e1000
against it and run depmod using System.map.  However, I didn't actually try
running the kernel as I don't have any AMD systems.

- Chris Leech <christopher.leech@intel.com>


Roy Sigurd Karlsbakk wrote:

> I know this might be the wrong place, as the e1000 driver is custom made
> by Intel, but I hope there's an easy way to fix it.
> 
> After building a new 2.4.17 kernel with mjc1 and tux patches, I compile
> the intel e1000 driver (downloaded from
>
http://downloadfinder.intel.com//scripts-df/Detail_Desc.asp?ProductID=749&Dw
nldID=2897 \
> ).
> 
> When trying to insmod the driver, I get the following errors:
> 
> /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: unresolved symbol
_mmx_memcpy
> /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: insmod \
> /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o failed \
> /lib/modules/2.4.17-srv3/kernel/drivers/net/e1000.o: insmod e1000 failed
> 
> What's this? Is _mmx_memcpy only valid on Intel architecture? Does Athlon
> have any equivalent system call?
