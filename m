Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261826AbSJNPTk>; Mon, 14 Oct 2002 11:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261835AbSJNPTk>; Mon, 14 Oct 2002 11:19:40 -0400
Received: from h-64-105-137-41.SNVACAID.covad.net ([64.105.137.41]:52426 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261826AbSJNPTf>; Mon, 14 Oct 2002 11:19:35 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 14 Oct 2002 08:25:08 -0700
Message-Id: <200210141525.IAA01355@adam.yggdrasil.com>
To: ebiederm@xmission.com
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>Russell King <rmk@arm.linux.org.uk> writes:

>> "rebooting" in this particular case is "turn MMU off, jump to location 0"
>And for x86 it is turn MMU off, jump to location 0xffff0.


	The default reboot method of linux-2.5.42 on x86 is to have the
keyboard controller do a reset.  If you want to reboot by jumping to ffff00,
you have to pass "reboot=b" unless you are running on one of three specific
models of computers: the Dell PowerEdge 300, 1300 or 2400
(linux-2.5.42/arch/i386/kernel/dmi-scan.c line 522).  Here is the
relevant excerpt from machine_restart in linux-2.5.42/arch/i386/reboot.c:

        if(!reboot_thru_bios) {
                /* rebooting needs to touch the page at absolute addr 0 */
                *((unsigned short *)__va(0x472)) = reboot_mode;
                for (;;) {
                        int i;
                        for (i=0; i<100; i++) {
                                kb_wait();
                                udelay(50);
                                outb(0xfe,0x64);         /* pulse reset low */
                                udelay(50);
                        }
                        /* That didn't work - force a triple fault.. */
                        __asm__ __volatile__("lidt %0": :"m" (no_idt));
                        __asm__ __volatile__("int3");
                }
        }

In another message, you wrote:
>Exactly an in spec, PC does not need to ground RST# on reboot.

	By "as in spec", were you referring to my quotation from _PCI
System Architecture, 4th Ed._ by Shanley and Anderson or are saying
that there is a specification that supports your statement that "a PC
does not need to ground RST# on reboot."  If the latter, I would
appreciate it if you would identify that specification and the
appropriate section with it for verification.

Elsewhere you wrote:
>Additionally it was decided quite a
>while ago that calling device->remove() was the correct way to
>accomplish this.

	Do you remember where this "was decided?"  If it was on an
archived mailing list, do you remember approximately when and what the
subject line might be?  I'd like to look at this discussion both to
verify you statement and to avoid repetition.

In another message you wrote:
>machine_restart returns control to the BIOS.  
>It works this way on both x86 and alpha.  And the BIOS does
>not always toggle the RESET line on the machine.  The frequent case
>of devices not working in Linux after rebooting from windows, and
>visa versa is evidence of this.  On alpha the SRM doesn't even
>pretend to reset the machine.

	Here you are talk first about doing a warm reboot from Windows
to Linux and the device does not work.  That sounds like a quirky
device.  Also, you have failed to show that this is a device where the
Linux driver's ->remove() function solves the problem and that there
are so many of these devices that (where the remove function *does*
solve the problem and there is no reboot notifier) that it would be
impractical change those drivers.

	If the problem is that the warm reboot procedure failed to
"stop any ongoing DMA, etc." as you put it, then failure mode that you
would more typically expect would be memory corruption, manifesting
itself as random of other programs, not getting through the reboot
process half of the time, etc.

	The underlying trade-off is that if I want to reboot fast, I
should not have to call a bunch of hotplug routines that have to do a
lot of book keeping because they have to assume that the computer may
continue to run user level programs indefinitely after they return
(things like deallocating memory, unregistering devfs inodes, etc.).
On the other hand, if I want to halt, I really do want the disks to be
spun down even if my motherboard does not do a master power-off from
software.  Doing that requires that the power management request that
reboot makes differ from the one that halt makes.  So they could
not both be just "device_shtudown();".

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
