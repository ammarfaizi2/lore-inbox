Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262084AbSJNSgI>; Mon, 14 Oct 2002 14:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262089AbSJNSgI>; Mon, 14 Oct 2002 14:36:08 -0400
Received: from h-64-105-137-41.SNVACAID.covad.net ([64.105.137.41]:4821 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S262084AbSJNSgE>; Mon, 14 Oct 2002 14:36:04 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 14 Oct 2002 11:41:46 -0700
Message-Id: <200210141841.LAA19982@baldur.yggdrasil.com>
To: ebiederm@xmission.com
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: eblade@blackmagik.dynup.net, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
>"Adam J. Richter" <adam@yggdrasil.com> writes:

>> Eric W. Biederman wrote:
>> >Russell King <rmk@arm.linux.org.uk> writes:
>> 
>> >> "rebooting" in this particular case is "turn MMU off, jump to location 0"
>> >And for x86 it is turn MMU off, jump to location 0xffff0.
>> 
>> 	The default reboot method of linux-2.5.42 on x86 is to have the
>> keyboard controller do a reset.  

>Resetting the cpu != resetting the system.  And the keyboard controller
>only does a cpu level reset.  Which is basically a convoluted way to jump
>to: 0xfffffff0.

	I would be quite surprised if that reset was not wired
to eventually ground RST# on the PCI bus.


[...]
>>         if(!reboot_thru_bios) {
>>                 /* rebooting needs to touch the page at absolute addr 0 */
>>                 *((unsigned short *)__va(0x472)) = reboot_mode;
>>                 for (;;) {
>>                         int i;
>>                         for (i=0; i<100; i++) {
>>                                 kb_wait();
>>                                 udelay(50);
>>                                 outb(0xfe,0x64);         /* pulse reset low */
>>                                 udelay(50);
>>                         }
>>                         /* That didn't work - force a triple fault.. */
>>                         __asm__ __volatile__("lidt %0": :"m" (no_idt));
>>                         __asm__ __volatile__("int3");
>>                 }
>>         }

>Please note the write to: 0x40:0x72.  If this was a full machine reset
>this would not make sense as memory would need to be reinitialized
>making it unsafe to keep values in ram.

	The issue is not how you define the term "full machine reset."
The issue is whether the PCI bus is eventually reset as a result of
this procedure before by BIOS Power On Self Test starts executing at
0xffff00.  If it is, then most of the device cleanup is unnecessary.
Even if it does not, it would make a lot more sense to just have
machine_reset assert RST# after those few devices that really need
cleanup are done.

>> In another message, you wrote:
>> >Exactly an in spec, PC does not need to ground RST# on reboot.
>> 
>> 	By "as in spec", were you referring to my quotation from _PCI
>> System Architecture, 4th Ed._ by Shanley and Anderson or are saying
>> that there is a specification that supports your statement that "a PC
>> does not need to ground RST# on reboot."  If the latter, I would
>> appreciate it if you would identify that specification and the
>> appropriate section with it for verification.

>I'd love to but mostly I was referring to the de facto standard for
>pc architecture.  Which I don't know if anyone ever wrote down, all
>in one place.

	Please do not say "as in spec" if you are not actually
referrring to a specification document (electronic form is OK).  It is
extremely misleading as to how reliable your claims are.  Instead,
please indicate what you remember about where you learned this
information.


>> Elsewhere you wrote:
>> >Additionally it was decided quite a
>> >while ago that calling device->remove() was the correct way to
>> >accomplish this.
>> 
>> 	Do you remember where this "was decided?"  If it was on an
>> archived mailing list, do you remember approximately when and what the
>> subject line might be?  I'd like to look at this discussion both to
>> verify you statement and to avoid repetition.

>No.  I was not in on that conversation.  However given the fact it
>is all over the documentation.  And has been in the kernel for quite
>a while now.  I tracked it as early as 2.5.30.

	Making stuff up just to win an argument is unlikely to produce
the best Linux kernel.  If you don't remember things, if you're not
sure of something, please just admit it instead of wasting an
iteration of email by faking authoratitive references.


>This is both device_shutdown in the reboot path,
>and device_shutdown calling ->remove()
> 
>> In another message you wrote:
>> >machine_restart returns control to the BIOS.  
>> >It works this way on both x86 and alpha.  And the BIOS does
>> >not always toggle the RESET line on the machine.  The frequent case
>> >of devices not working in Linux after rebooting from windows, and
>> >visa versa is evidence of this.  On alpha the SRM doesn't even
>> >pretend to reset the machine.
>> 
>> 	Here you are talk first about doing a warm reboot from Windows
>> to Linux and the device does not work.  That sounds like a quirky
>> device.  

>No it sounds like a driver that either can or cannot handle devices
>in an arbitrary state.

>> Also, you have failed to show that this is a device where the
>> Linux driver's ->remove() function solves the problem and that there
>> are so many of these devices that (where the remove function *does*
>> solve the problem and there is no reboot notifier) that it would be
>> impractical change those drivers.

>I do not feel I need to defend the status quo.  It is you who are proposing
>a change that needs to support why using ->remove() is a bad way to go.

	sys_reboot does not call device_shutdown in 2.4.19 and it was
added to 2.5 in 2.5.8, so calling it status quo to the point where you
think there is no need to defend it is pretty iffy.  If most Linux
systems are running 2.4 these days, then it appears that most are
running without the ->remove() call just fine.

	Also, it's not just a question of whether you should feel a
need to defend the status quo.  The reality is that you made some
factual claims ("frequent case of devices not working in Linux after
rebooting from windows") and you seem to be unable to support,
espeically with regard to the question of how many of these devices
actually started to work correctly with ->remove() and which do not
work without it (i.e., do not work in 2.4.19 but do work in 2.5.8+).
I wouldn't have a problem with it if you would just admit that you
don't remember or that you may have accidentally made this up or that
you were repeating something you heard elsewhere but never checked,
and we could weight that information accordingly.

>I will just say that shutting devices in a depth first manner is a lot safer,
>and more reliable than a random walk, you will get with a reboot notifier.

	I already said that I don't have a problem with having a
reboot notifier call in struct device for those devices that need some
sort of specific shutdown code that cannot be handled by resetting
their parent bus or something similar.

>> 	If the problem is that the warm reboot procedure failed to
>> "stop any ongoing DMA, etc." as you put it, then failure mode that you
>> would more typically expect would be memory corruption, manifesting
>> itself as random of other programs, not getting through the reboot
>> process half of the time, etc.

>You would only see it on the boot up side.  Not placing devices in
>a consistent state so another os can talk to them is significant as well.

	I quite don't understand what you're saying here.  Are you
saying people usually cannot boot from linux-2.4.19 into Windows?

>> 	The underlying trade-off is that if I want to reboot fast, I
>> should not have to call a bunch of hotplug routines that have to do a
>> lot of book keeping because they have to assume that the computer may
>> continue to run user level programs indefinitely after they return
>> (things like deallocating memory, unregistering devfs inodes, etc.).

>I would be very surprised if this showed up in practice.  If Russell King
>makes the argument about excess book keeping slowing things down.  I
>will buy it because he runs on some very slow machines.  Personally I
>doubt anything will be user noticeable.

	When you want to optimize for resources like speed and space,
one is generally happy if an optimizations by a percent or two at a
time.  These calls can do IO.  It could add up.  Also, for code
compiled into the kernel (or non-unloadable modules if anyone
implements them, I suppose), it means that otherwise could be compiled
out with __exit, so you have a bigger kernel foot print.  Finally,
from a reliability standpoint, in the case of rebooting because of a
kernel bug, it means that the reboot process wants to execute code and
walk through data structures in many more drivers.


>> On the other hand, if I want to halt, I really do want the disks to be
>> spun down even if my motherboard does not do a master power-off from
>> software.  Doing that requires that the power management request that
>> reboot makes differ from the one that halt makes.  So they could
>> not both be just "device_shtudown();".

>So you want to send device_suspend(?, SUSPEND_POWER_DOWN) on a halt.
>Or do a software shutdown thing.  

>Whoever mapped the SUSPEND_SHUT_DOWN to SUSPEND_POWER_DOWN very much
>had it wrong when that code was merged with 2.5.42.

>Mostly it looks to me that you have a problem with IDE driver spinning
>down disks on reboot.  That change also is new in 2.5.41.

	You do not understand.  The fundamental problem is that
sys_reboot in linux-2.5.42/kernel/sys.c makes exactly the same power
management call for a reboot and for a halt (device_shutdown()).  I
want my IDE, SCSI, USB, and FireWire hard disks to spin down if I do a
halt.  I do not want them to do that when I reboot.  I also do not
want my reboot to wait for an interrupt from a sound card because
remove() needs to determine if it is being called because the device
had just been unplugged.  It is not just about IDE disk drives.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

