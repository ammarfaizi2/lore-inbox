Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUJVSyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUJVSyk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUJVSve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:51:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10941 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266216AbUJVSsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:48:00 -0400
Message-ID: <417955D3.5020206@pobox.com>
Date: Fri, 22 Oct 2004 14:47:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <4177DF15.8010007@techsource.com> <4177E50F.9030702@sover.net> <200410220238.13071.jk-lkml@sci.fi> <41793C94.3050909@techsource.com>
In-Reply-To: <41793C94.3050909@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've thought about this a bit already, and had some chip designers 
correct my thoughts on a few things.  Here are my comments, in no 
particular order:


1) I agree it probably wouldn't be cost effective without selling to 
OEMs in volume

2) AGP/PCI-Express is practically required, if you want OEM sales, IMO

3) Your main bottlenecks are video RAM bandwidth to/from the GPU, 
PCI/AGP bus bandwidth, and system RAM bandwidth.

4) I am a bit dubious that FPGA will perform at a useful clock speed.

5) Key question:  generic GPU or not?

 From what I've read in ARS Technica and other tech sites, ATI and 
NVIDIA chips are moving towards a more generic, programmable CPU model. 
  Presumably on current (or future?) chips, you will push bytecoded 
shaders direct to your video card.  Essentially some future GPUs will be 
highly specialized, yet generic, CPUs with their own ISA.

On the other hand, if you only support a small number of graphics 
operations, it may be easier for the first rev of your chip to do all 
the 2D operations in silicon.


6) My preference:  generic OpenGL programming interface.

I feel my own personal design for video hardware interface is better 
than ATI or NVIDIA:  present to the OS driver a generic, open, public 
OpenGL interface, that very rarely (if ever) changes.  This must be a 
simple interface:  only a few key operations, such as "transfer {display 
list | shader | texture | ...} data to card" or "execute display list" 
should be presented to the OS driver.

The interface should have a standard "fall back to software rendering" 
response message, for minimalist hardware.

If your hardware presents a standard GL interface to OS driver,

a) there is a high potential industry standardization, if it's done right

b) reduce complexity in the OS driver.

c) stop the "driver rat race".  After the OS driver is initially 
written, the only maintenance costs are keeping up to date with the 
latest OpenGL standards.  You have very low cross-hardware support 
costs, because all the hardware presents the same interface to the OS 
driver.

d) makes it possible to add value to your hardware without changing the 
OS driver

e) makes it possible for multiple video chip vendors to compete, without 
worrying about OS driver issues, or Linux support issues.

f) this isn't a terribly new idea :)  But it's a good one, IMHO.

g) even on minimalist 2D-only hardware, you can implement this interface


7) two-chip solution

One thing I have pondered, with regards to #6:  what about implementing 
a multi-core solution?  One core to handle the graphics operations and 
control the video, and one core a much more generic microcontroller that 
runs ucLinux, and handles the GL "slow path" stuff.  The advantage of 
this approach is

a) 100% of 2D and 3D GL is "done in hardware".  The portions of GL that 
are not handled by the GPU core are handled by the microcontroller core, 
which is running a generic firmware.

b) Since a microcontroller is included, you can upgrade the firmware 
quite easily to support new OpenGL features.

c) you don't necessarily have to follow my design of one purpose built 
GPU core, and one generic microcontroller core.  If your FPGA is big 
enough, you can have plenty of execution engines (that's the beauty of 
hardware, it's inherently parallel).

But OTOH, maybe a multi-core solution will add too much latency into the 
picture, I dunno.



8) I don't find an open source video BIOS terribly exciting.  Yes, I do 
think it should be open source, but the interest is largely theoretical. 
  A video BIOS only does a couple things...  implements VESA/etc. BIOS 
calls, and initializes the hardware based on characteristics specific to 
the video board (i.e. OEM not GPU details, such as video RAM setup and 
clocking, which video inputs are actually implemented on the board, 
...).  I don't see there being a big programmer or developer interest

Such a video BIOS would probably have to be BSD-licensed, since the 
video BIOS code may wind up being #included into an OEM's system BIOS.




