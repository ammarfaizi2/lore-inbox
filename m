Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282605AbRKZWQo>; Mon, 26 Nov 2001 17:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282606AbRKZWQf>; Mon, 26 Nov 2001 17:16:35 -0500
Received: from brussel-ns1.xs4all.be ([195.144.67.168]:4869 "EHLO
	brussel-ns1.xs4all.be") by vger.kernel.org with ESMTP
	id <S282605AbRKZWQU>; Mon, 26 Nov 2001 17:16:20 -0500
Message-ID: <3C02BF41.1010303@xs4all.be>
Date: Mon, 26 Nov 2001 23:16:33 +0100
From: Didier Moens <moensd@xs4all.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Nicolas Aspert <Nicolas.Aspert@epfl.ch>, skraw@ithnet.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be> 	<3C022BB4.7080707@epfl.ch> <1006808870.817.0.camel@phantasy>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robert, Nicolas, Stephan,   :)


Robert Love wrote:

> On Mon, 2001-11-26 at 06:47, Nicolas Aspert wrote:
> 
> 
>>It seems like you have pointed out the problem... From what you had sent 
>>previously (the output of 'lspci' on your machine), and what the Intel 
>>doc says, it looks to me like the code for i830 initialization is not 
>>correct for your version of the chipset. But I am not too sure of what 
>>is to be done in that case... should we switch back to a 'classic' AGP 
>>initialization, similar to the other i8xx chipsets (820/840/860...) ? 
>>Robert (or somebody else), any clue about this one ?
>>
> 
> It looks like you got it right ... at any rate, you know as much as me
> about a chipset neither of us have (ie, we have docs), so its all a
> guess.
> 
> Has the user tried your patch?  Results?

I got two patches :


1. From Stephan, to test whether my assumption about the secondary 
device was right :

Stephan wrote :

But if you want you can check that out pretty simple: just add a "break" 
right
after the case :

                 case PCI_DEVICE_ID_INTEL_830_M_0:
---> break;

                         i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,


This patch left me with a loaded agpgart, and accelerated X (DRM/DRI). 
The acceleration is still not up to par with an ATI Mobility-128 (30% 
lower, while it should be at least 200% faster), but I suspect an X 
CVS-problem here.

Quitting and restarting X leaves me with a locked black screen.


2. And the one from Nicolas, in which I changed all references from 
830MG to 830M.


Results :

1a. Nicolas' patches yielded an oops, which was corrected by 
implementing Stephan's first patch :

+                       if(i810_dev && ( PCI_FUNC(i810_dev->devfn) != 0) ) {
-                       if(PCI_FUNC(i810_dev->devfn) != 0) {

1b. After Stephan's firsat patch, Nicolas' code loaded the agpgart, but 
left me with a messed-up X (XFree86 CVS 4.1.99.1 2001/11/26) : only a 
cursor, locked black screen, restart to ssh session.


(I need the CVS-version of X : standard 4.1.0 doesn't detect the LCD 
panel size, and bugs out).


Conclusion : Stephan's break-patch loads agpgart, loads X, and locks 
when reloading X ; Nicolas' patch (when combined with Stephan's first 
patch) loads agpgart and locks X hard.


FYI : Dell has an i830M-design (the new i8100, together with a NVidia 
Mobile), and Gateway, Compaq, ... should have them too, I guess.




The requested "lspci -vn" :


00:00.0 Class 0600: 8086:3575 (rev 02)
	Subsystem: 1014:021d
	Flags: bus master, fast devsel, latency 0
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [40] #09 [0105]
	Capabilities: [a0] AGP version 2.0

00:01.0 Class 0604: 8086:3576 (rev 02)
	Flags: bus master, 66Mhz, fast devsel, latency 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0100000-c01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff

00:1d.0 Class 0c03: 8086:2482 (rev 01)
	Subsystem: 1014:0220
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1800 [size=32]

00:1d.1 Class 0c03: 8086:2484 (rev 01)
	Subsystem: 1014:0220
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1820 [size=32]

00:1d.2 Class 0c03: 8086:2487 (rev 01)
	Subsystem: 1014:0220
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1840 [size=32]

00:1e.0 Class 0604: 8086:2448 (rev 41)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=08, sec-latency=64
	I/O behind bridge: 00004000-00008fff
	Memory behind bridge: c0200000-cfffffff
	Prefetchable memory behind bridge: e8000000-f00fffff

00:1f.0 Class 0601: 8086:248c (rev 01)
	Flags: bus master, medium devsel, latency 0

00:1f.1 Class 0101: 8086:248a (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: 1014:0220
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4
	I/O ports at 0170 [size=8]
	I/O ports at 0374
	I/O ports at 1860 [size=16]
	Memory at 20000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 Class 0c05: 8086:2483 (rev 01)
	Subsystem: 1014:0220
	Flags: medium devsel, IRQ 11
	I/O ports at 1880 [size=32]

00:1f.5 Class 0401: 8086:2485 (rev 01)
	Subsystem: 1014:0222
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at 1c00 [size=256]
	I/O ports at 18c0 [size=64]

00:1f.6 Class 0703: 8086:2486 (rev 01)
	Subsystem: 1014:0227
	Flags: medium devsel, IRQ 11
	I/O ports at 2400 [size=256]
	I/O ports at 2000 [size=128]

01:00.0 Class 0300: 1002:4c59
	Subsystem: 1014:0235
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, 
latency 66, IRQ 11
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	I/O ports at 3000 [size=256]
	Memory at c0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

02:00.0 Class 0607: 1180:0478 (rev a0)
	Subsystem: 1014:0184
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at c0202000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=05, sec-latency=176
	Memory window 0: e8000000-e83ff000 (prefetchable)
	Memory window 1: c0400000-c07ff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001

02:00.1 Class 0607: 1180:0478 (rev a0)
	Subsystem: 1014:0184
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at c0203000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=06, subordinate=08, sec-latency=176
	Memory window 0: e8400000-e87ff000 (prefetchable)
	Memory window 1: c0800000-c0bff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	16-bit legacy interface ports at 0001

02:00.2 Class 0c00: 1180:0522 (prog-if 10)
	Subsystem: 1014:01cf
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at c0201000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2

02:02.0 Class 0280: 1260:3873 (rev 01)
	Subsystem: 1668:0406
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at f0000000 (32-bit, prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

02:08.0 Class 0200: 8086:1031 (rev 41)
	Subsystem: 1014:0209
	Flags: bus master, medium devsel, latency 66, IRQ 11
	Memory at c0200000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 8000 [size=64]
	Capabilities: [dc] Power Management version 2



-[00]-+-00.0  8086:3575
       +-01.0-[01]----00.0  1002:4c59
       +-1d.0  8086:2482
       +-1d.1  8086:2484
       +-1d.2  8086:2487
       +-1e.0-[02-08]--+-00.0  1180:0478
       |               +-00.1  1180:0478
       |               +-00.2  1180:0522
       |               +-02.0  1260:3873
       |               \-08.0  8086:1031
       +-1f.0  8086:248c
       +-1f.1  8086:248a
       +-1f.3  8086:2483
       +-1f.5  8086:2485
       \-1f.6  8086:2486




Kind regards,

Didier



Didier Moens
-----
RUG/VIB - Dept. Molecular Biology - Core IT
tel ++32(9)2645309 fax ++32(9)2645348
http://www.dmb.rug.ac.be



