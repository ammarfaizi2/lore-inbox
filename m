Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSJNRkw>; Mon, 14 Oct 2002 13:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbSJNRkw>; Mon, 14 Oct 2002 13:40:52 -0400
Received: from chaos.analogic.com ([204.178.40.224]:16003 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261973AbSJNRku>; Mon, 14 Oct 2002 13:40:50 -0400
Date: Mon, 14 Oct 2002 13:48:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
In-Reply-To: <m1y991j7gk.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.95.1021014130129.15441A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Oct 2002, Eric W. Biederman wrote:

> "Adam J. Richter" <adam@yggdrasil.com> writes:
> 
> > Eric W. Biederman wrote:
> > >Russell King <rmk@arm.linux.org.uk> writes:
> > 
> > >> "rebooting" in this particular case is "turn MMU off, jump to location 0"
> > >And for x86 it is turn MMU off, jump to location 0xffff0.
> > 
> > 
> > 	The default reboot method of linux-2.5.42 on x86 is to have the
> > keyboard controller do a reset.  
> 
> Resetting the cpu != resetting the system.  And the keyboard controller
> only does a cpu level reset.  Which is basically a convoluted way to jump
> to: 0xfffffff0.
> 

If you really do get to 0xfffffff0, in real mode, you reset the CPU and
the BIOS will perform a complete reinitialization of everything unless
data at absolute address 0x0472 tells the BIOS not to. If the entry
is 0x1234, the BIOS will bypass the memory test, but this does not
guarantee that memory contents are saved. It just speeds up the boot.
If the entry is 0x4321, the BIOS will not initialize memory nor its
controller. RAM contents will be saved.

This is all documented in "System BIOS for IBM PC/XT/AT Computers
and Compatibles", Phoenix Technologies, Ltd.  Addison-Wesley Publishing
Company, Inc. ISBN 0-201-51806-6.  This is the "bible" of the BIOS
industry because Phoenix was the first to document what IBM BIOS
did, and then, using "clean-room" techniques, write a BIOS from that
documentation.
[SNIPPED...]

> 
> Please note the write to: 0x40:0x72.  If this was a full machine reset
> this would not make sense as memory would need to be reinitialized
> making it unsafe to keep values in ram.
>  

This effectively hits the reset button. This will reset anything that
is connected to the reset line which includes the memory controller.
You don't want to do this if you intend to preserve RAM contents.

[SNIPPED...]


> 
> I'd love to but mostly I was referring to the de facto standard for
> pc architecture.  Which I don't know if anyone ever wrote down, all
> in one place.

See above. It's documented well enough so you can "roll your own"
from the specification alone.

[SNIPPED...]
> 
> No it sounds like a driver that either can or cannot handle devices
> in an arbitrary state.
> 

Some drivers don't work after a "warm-boot" because the I/O resources
shown in the PCI initialization have changed. It's only after they
get hit with a reset that they put their default resource type and
length back into their registers. I am told that some lap-tops have
semi-documented methods of sending a hardware reset to the PCI bridge(s)
only. This is needed to get them into a restartable state.

[SNIPPED...]
> 
> I will just say that shutting devices in a depth first manner is a lot safer,
> and more reliable than a random walk, you will get with a reboot notifier.
>  

Shutting down devices seldom (perhaps never) restores the reset-entries
of the PCI devices. If this was done, it might make warm-boot restarts
more reliable. Emphasis on the 'might'.


> > 	If the problem is that the warm reboot procedure failed to
> > "stop any ongoing DMA, etc." as you put it, then failure mode that you
> > would more typically expect would be memory corruption, manifesting
> > itself as random of other programs, not getting through the reboot
> > process half of the time, etc.
>

A processor reset will get the processor onto the bus even if there is
an ongoing DMA operation. Since the first of many instructions are
fetched from ROM, it is quite likely that any DMA activity would have
stopped before the ROM is shadowed by the BIOS. I don't see "ongoing"
DMA as being a problem, which you can verify by forcing a reset in
the FDC code (easiest to do) while waiting for read DMA to complete.
FDC DMA is slow, so you can catch it 100% of the time.

 
> You would only see it on the boot up side.  Not placing devices in
> a consistent state so another os can talk to them is significant as well.
> 

The BIOS is the only thing that can really put the devices into
a consistant state because, in the case of PCI initialization, if
the device requests no resources upon startup, it's not going to
get any. The only "known" way to get the devices to write their
true resource requests into their registers is a hardware reset.

[SNIPPED...]



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

