Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTLPHSR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 02:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264345AbTLPHSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 02:18:17 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:57358 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263472AbTLPHSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 02:18:13 -0500
Message-ID: <3FDEB1C2.8040106@nishanet.com>
Date: Tue, 16 Dec 2003 02:18:26 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic,
 io-apic, udma133 covered
References: <200312132040.00875.ross@datscreative.com.au> <3FDAFF79.5080509@nishanet.com> <Pine.LNX.4.55.0312151403190.26565@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0312151403190.26565@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

apic.c patch needs reload:%lu instead of %u  ---------->
printk("..APIC TIMER ack delay, reload:%lu, safe:%u\n",



amd xp3000+, 1:1 333mhz fsb to ram, 166mhz cpu
bus clock x dual channel 2-512mb pc3200 tested cas2
sticks, 1:1 fsb to ram for 333mhz, Award bios with
update that works for non-crashing but not for edge
timer without patch.  MSI K7N2 Delta MCP2-T mbo
linux-2.6.0-test11

This was with 3ware controller and unpatched 2.6.0-test11
Note low MIS score but PIC timer and no nmi--

          CPU0       0:  244393560          XT-PIC  timer
 1:      31963    IO-APIC-edge  i8042
 2:          0          XT-PIC  cascade
 8:          1    IO-APIC-edge  rtc
 9:          0   IO-APIC-level  acpi
12:     251884    IO-APIC-edge  i8042
14:         22    IO-APIC-edge  ide0
15:         24    IO-APIC-edge  ide1
16:    4290216   IO-APIC-level  3ware Storage Controller, yenta, yenta
17:    5929405   IO-APIC-level  eth0
21:          0   IO-APIC-level  NVidia nForce2
NMI:          0
LOC:  244378698
ERR:          0
MIS:          6

Next is with the first edge timer patch, nmi_watchdog=2
works but =1 does not, MIS really high("noisy bus"),
replacing 3ware with promise cards and hdparm udma133
causes apic error logged to console during bonnie++ test--

>>APIC error on CPU0: 02(02)
>>what?? no crash though.
>>    
>>
>>bob@where cat /proc/interrupts
>>           CPU0      
>>  0:    3350153    IO-APIC-edge  timer
>>  1:       5775    IO-APIC-edge  i8042
>>  2:          0          XT-PIC  cascade
>>  8:          1    IO-APIC-edge  rtc
>>  9:          0   IO-APIC-level  acpi
>> 12:       5385    IO-APIC-edge  i8042
>> 14:         10    IO-APIC-edge  ide0
>> 15:         10    IO-APIC-edge  ide1
>> 16:    1717957   IO-APIC-level  ide2, ide3, eth0
>> 19:     472929   IO-APIC-level  ide4, ide5
>> 21:          0   IO-APIC-level  NVidia nForce2
>>NMI:        822
>>LOC:    3350073
>>ERR:         35
>>MIS:      15818
>>    
>>

now with promise controllers again, new edge timer patch
permits nmi_watchdog=1 not =2, lots of nmi ticks, MIS count
is only half with first timer patch, NMI ticks = LOC?


bob@where cat /proc/interrupts
           CPU0      
  0:   46188571    IO-APIC-edge  timer
  1:      12396    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     147429    IO-APIC-edge  i8042
 14:         10    IO-APIC-edge  ide0
 15:         10    IO-APIC-edge  ide1
 16:    1413705   IO-APIC-level  ide2, ide3, eth0
 17:          0   IO-APIC-level  yenta, yenta
 19:     258804   IO-APIC-level  ide4, ide5
 21:          0   IO-APIC-level  NVidia nForce2
NMI:   46188592
LOC:   46188482
ERR:         36
MIS:       6877

Now I'll try 800UL/100ndelay to see if it helps with
MIS count(pseudo-sci masochism), be back in a while.

Oh, by the way, I set debug 1 in apic.h but I don't
see anything, and I thought I saw a compile error
flash by, so now I'll compile > logfile 2>&1 and
might see why I don't see--

"..APIC TIMER ack delay, predelay count: 20769"

I don't see any of that debug stuff. Maybe the compile
errors I found were it, see my previous message about
"unsigned in format", maybe printk needs %lu(I don't
know hardly nuffing yet). I'm going to boot 800UL/100ndelay
now.


it needs reload:%lu instead of %u  ---------->
printk("..APIC TIMER ack delay, reload:%lu, safe:%u\n",

Ross: "Can you also advise if your bios setting of the
"C1 disconnect" is set"

I can only guess by my 41C low load 48C high load
temps exactly equal to range for "2.1Ghz 333mhz"
of Ian Kumlien(his?) which is same speed as mine,
that probably cpu disconnect is not on. I have
no visible choice in setup for cpu disconnect.
I'll try athcool to see how disconnect is set.

Ross:"I have heard lockups are not supposed to happen
at all if the fsb (host bus clock speed) matches the
ddr speed. One of my systems went about 4 hours (xp2500
333fsb, DDR333) without the apic delay patch on a phoenix 
bios before lockup"

A couple of months ago I was overly optimistic a couple
of times before the bios update, and it seemed to work
to use 1:1 and only amd74xx onboard hd controller, no
hd cards, and pre-emptive, anticipatory sched not
deadline, apic off in setup but on in linux, lapic
off, acpi on. It was almost stable if using only one
drive, but I really can't go without hd cards for
software raid, so the first fsck on boot if using hd
card, and crash. I could finesse stability by using
options but never quite reach reliability without a
bios update, and certain functions need patching, and
I still have "MIS count, noisy bus" and agp8 crash(I can
use the X nv driver and agpgart no problem, but not nvidia
drivers for X and agp8).


