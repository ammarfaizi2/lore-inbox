Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262021AbSJNQkc>; Mon, 14 Oct 2002 12:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262023AbSJNQkc>; Mon, 14 Oct 2002 12:40:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50296 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262021AbSJNQk3>; Mon, 14 Oct 2002 12:40:29 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210141525.IAA01355@adam.yggdrasil.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Oct 2002 10:44:43 -0600
In-Reply-To: <200210141525.IAA01355@adam.yggdrasil.com>
Message-ID: <m1y991j7gk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:

> Eric W. Biederman wrote:
> >Russell King <rmk@arm.linux.org.uk> writes:
> 
> >> "rebooting" in this particular case is "turn MMU off, jump to location 0"
> >And for x86 it is turn MMU off, jump to location 0xffff0.
> 
> 
> 	The default reboot method of linux-2.5.42 on x86 is to have the
> keyboard controller do a reset.  

Resetting the cpu != resetting the system.  And the keyboard controller
only does a cpu level reset.  Which is basically a convoluted way to jump
to: 0xfffffff0.

> If you want to reboot by jumping to ffff00,
> you have to pass "reboot=b" unless you are running on one of three specific
> models of computers: the Dell PowerEdge 300, 1300 or 2400
> (linux-2.5.42/arch/i386/kernel/dmi-scan.c line 522).  Here is the
> relevant excerpt from machine_restart in linux-2.5.42/arch/i386/reboot.c:
> 
>         if(!reboot_thru_bios) {
>                 /* rebooting needs to touch the page at absolute addr 0 */
>                 *((unsigned short *)__va(0x472)) = reboot_mode;
>                 for (;;) {
>                         int i;
>                         for (i=0; i<100; i++) {
>                                 kb_wait();
>                                 udelay(50);
>                                 outb(0xfe,0x64);         /* pulse reset low */
>                                 udelay(50);
>                         }
>                         /* That didn't work - force a triple fault.. */
>                         __asm__ __volatile__("lidt %0": :"m" (no_idt));
>                         __asm__ __volatile__("int3");
>                 }
>         }

Please note the write to: 0x40:0x72.  If this was a full machine reset
this would not make sense as memory would need to be reinitialized
making it unsafe to keep values in ram.
 
> In another message, you wrote:
> >Exactly an in spec, PC does not need to ground RST# on reboot.
> 
> 	By "as in spec", were you referring to my quotation from _PCI
> System Architecture, 4th Ed._ by Shanley and Anderson or are saying
> that there is a specification that supports your statement that "a PC
> does not need to ground RST# on reboot."  If the latter, I would
> appreciate it if you would identify that specification and the
> appropriate section with it for verification.

I'd love to but mostly I was referring to the de facto standard for
pc architecture.  Which I don't know if anyone ever wrote down, all
in one place.

> Elsewhere you wrote:
> >Additionally it was decided quite a
> >while ago that calling device->remove() was the correct way to
> >accomplish this.
> 
> 	Do you remember where this "was decided?"  If it was on an
> archived mailing list, do you remember approximately when and what the
> subject line might be?  I'd like to look at this discussion both to
> verify you statement and to avoid repetition.

No.  I was not in on that conversation.  However given the fact it
is all over the documentation.  And has been in the kernel for quite
a while now.  I tracked it as early as 2.5.30.

This is both device_shutdown in the reboot path,
and device_shutdown calling ->remove()
 
> In another message you wrote:
> >machine_restart returns control to the BIOS.  
> >It works this way on both x86 and alpha.  And the BIOS does
> >not always toggle the RESET line on the machine.  The frequent case
> >of devices not working in Linux after rebooting from windows, and
> >visa versa is evidence of this.  On alpha the SRM doesn't even
> >pretend to reset the machine.
> 
> 	Here you are talk first about doing a warm reboot from Windows
> to Linux and the device does not work.  That sounds like a quirky
> device.  

No it sounds like a driver that either can or cannot handle devices
in an arbitrary state.

> Also, you have failed to show that this is a device where the
> Linux driver's ->remove() function solves the problem and that there
> are so many of these devices that (where the remove function *does*
> solve the problem and there is no reboot notifier) that it would be
> impractical change those drivers.

I do not feel I need to defend the status quo.  It is you who are proposing
a change that needs to support why using ->remove() is a bad way to go.

I will just say that shutting devices in a depth first manner is a lot safer,
and more reliable than a random walk, you will get with a reboot notifier.
 
> 	If the problem is that the warm reboot procedure failed to
> "stop any ongoing DMA, etc." as you put it, then failure mode that you
> would more typically expect would be memory corruption, manifesting
> itself as random of other programs, not getting through the reboot
> process half of the time, etc.

You would only see it on the boot up side.  Not placing devices in
a consistent state so another os can talk to them is significant as well.

> 	The underlying trade-off is that if I want to reboot fast, I
> should not have to call a bunch of hotplug routines that have to do a
> lot of book keeping because they have to assume that the computer may
> continue to run user level programs indefinitely after they return
> (things like deallocating memory, unregistering devfs inodes, etc.).

I would be very surprised if this showed up in practice.  If Russell King
makes the argument about excess book keeping slowing things down.  I
will buy it because he runs on some very slow machines.  Personally I
doubt anything will be user noticeable.

> On the other hand, if I want to halt, I really do want the disks to be
> spun down even if my motherboard does not do a master power-off from
> software.  Doing that requires that the power management request that
> reboot makes differ from the one that halt makes.  So they could
> not both be just "device_shtudown();".

So you want to send device_suspend(?, SUSPEND_POWER_DOWN) on a halt.
Or do a software shutdown thing.  

Whoever mapped the SUSPEND_SHUT_DOWN to SUSPEND_POWER_DOWN very much
had it wrong when that code was merged with 2.5.42.

Mostly it looks to me that you have a problem with IDE driver spinning
down disks on reboot.  That change also is new in 2.5.41.

Eric
