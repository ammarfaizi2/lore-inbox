Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTEFJ5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbTEFJ5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:57:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37188 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262494AbTEFJ5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:57:03 -0400
To: Thomas Horsten <thomas@horsten.com>
Cc: Adam Sulmicki <adam@cfar.umd.edu>,
       Halil Demirezen <nitrium@bilmuh.ege.edu.tr>,
       <linux-kernel@vger.kernel.org>
Subject: Re: about bios
References: <Pine.LNX.4.40.0305060946450.8287-100000@jehova.dsm.dk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 May 2003 04:06:01 -0600
In-Reply-To: <Pine.LNX.4.40.0305060946450.8287-100000@jehova.dsm.dk>
Message-ID: <m1u1c89ypi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Horsten <thomas@horsten.com> writes:

> On Mon, 5 May 2003, Adam Sulmicki wrote:
> 
> > 'was working'? The project is alive and well.
> 
> Sorry, didn't mean it as "the project is now dead", just "been a while
> since I checked its status" :-)
> 
> >[..]
> > By the way. Yes you can burn the linux kernel into flash (together with
> > linuxBIOS) and boot it this way. But given that many motherboards limit
> > your flash size to 256KiB you probably want to put the kernel on the
> > CompactFlash over ide nevertheless. Interestingly enough if not this size
> > limit we might have ended up using Linux Kernel as hardware initalizator
> > to some degree.
> 
> A couple of years ago I was doing a Linux port to a MIPS based embedded
> system, and while we did set up the SDRAM controller, chip select timings
> etc. in the flash bootloader, most of these were settings overwritten
> again by the kernel (that way, a kernel would work with any version of the
> bootloader, and the bootloader would not have to be updated if something
> had to be changed or a timing improved for performance).

In LinuxBIOS this is true for things like IDE timings.  We just allocate
the resources and enable the IDE device.  Our bootloader uses pio mode
and the kernel can setup what is reasonable for an optimized IDE timing.
3MB/s is generally fast enough to load a kernel without a noticeable delay.

> This approach seems to me to make sense, and it would be interesting if
> the kernel would include direct support for various chipsets and
> (optional?) code to set them up from scratch (or almost, e.g. SDRAM
> working but not much else), that way a truly minimal BIOS stub could be
> used and the kernel could provide interfaces to tune the chipsets in
> various ways.

In essence that is what LinuxBIOS is.  Though we are slowly developing
several interesting bootloaders that can do interesting things.  ADLO
uses a derivative of the bochs BIOS to look like a normal BIOS.  etherboot
provides super small drivers for lots of hardware.

In addition things like DRAM timing cannot be changed as that is generally
an operation you can only perform once after reset on most chipsets.
 
> That would probably mean the limit on kernel command line length would
> have to be dropped (if it hasn't already) to allow for things like
> "sis_enable_fdc=1"  (to get back to the original question), but it would
> certainly be flexible on the chipsets that were supported.

There is a major difference between Linux on embedded systems and linux
on general purpose commodity hardware.

On general purpose commodity hardware the kernel makes the assumption
that if it does not know what is going the BIOS set things up properly.  So
for handling resource conflicts and such the pci bridges the assumptions
are dramatically different. 

But beyond that the big service LinuxBIOS provides is that it has hard coded
information on what all of the non enumerable devices on the motherboard are.
Things like a winbond superio chips, and i2c clock controllers.

I am in the middle of a major revision and I hope to yield a code base that
is clean enough that I can reliably generate a table of the onboard devices.
Until that or something equivalent is done the kernel simply does not have
enough information to work with.  Probing devices that don't have
a standardized enumeration method is simply too unreliable.

Eric
