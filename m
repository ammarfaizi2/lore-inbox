Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbSLMTMQ>; Fri, 13 Dec 2002 14:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbSLMTMQ>; Fri, 13 Dec 2002 14:12:16 -0500
Received: from polaris.galacticasoftware.com ([206.45.95.222]:21007 "EHLO
	polaris.galacticasoftware.com") by vger.kernel.org with ESMTP
	id <S265205AbSLMTML>; Fri, 13 Dec 2002 14:12:11 -0500
From: "Adam Majer" <adamm@galacticasoftware.com>
Date: Fri, 13 Dec 2002 13:19:42 -0600
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise Ultra100 TX2 driver problems
Message-ID: <20021213191942.GA12276@mira.lan.galacticasoftware.com>
References: <20021111192648.GA31966@galacticasoftware.com> <1037054288.2887.49.camel@irongate.swansea.linux.org.uk> <20021111231126.GA1689@galacticasoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111231126.GA1689@galacticasoftware.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is just a followup, if anyone cares. The problem is
probably _not_ in the APIC code but most probably it's 
fucked up hardware. When any card, even ISA, is switched
to use IRQ 10 and APIC is enabled, it will cause thousands
of interrupts to be generated. Moving all cards from IRQ 10
to something else solved the problem completely. Yes,
even when APIC is enabled :)

adamm@polaris:/proc$ cat interrupts
           CPU0       CPU1       
  0:   24768091   22109926    IO-APIC-edge  timer
  1:       3856       3201    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  7:          0          0    IO-APIC-edge  soundblaster
  8:      15815      15414    IO-APIC-edge  rtc
  9:    1314813    1317096   IO-APIC-level  ide2, ide3, sym53c8xx
 12:    7903733    7886885   IO-APIC-level  eth1, eth0
NMI:          0          0 
LOC:   46877866   46877865 
ERR:          0
MIS:      14052

- Adam

PS. This is for an old Compaq proliant 800 dual PPro but
it might be helpful to others.


On Mon, Nov 11, 2002 at 05:11:26PM -0600, Adam Majer wrote:
> On Mon, Nov 11, 2002 at 10:38:08PM +0000, Alan Cox wrote:
> > On Mon, 2002-11-11 at 19:26, adamm@galacticasoftware.com wrote:
> > > Hi all,
> > > 
> > > There seems to be a major problem with the promise drivers.
> > > It is detected and seems to work, but there is a very 
> > > large number of interrupts being generated:
> > 
> > Im dubious those interrupts are coming from the TX2 - what happens if
> > you boot with the "noapic" option ?
> 
> Yes, you are right. It is the APIC problem...
> 
> polaris:/proc# cat interrupts
>            CPU0       CPU1
>   0:     155563          0          XT-PIC  timer
>   1:       2510          0          XT-PIC  keyboard
>   2:          0          0          XT-PIC  cascade
>   5:       3421          0          XT-PIC  eth0
>   8:         23          0          XT-PIC  rtc
>   9:      26243          0          XT-PIC  sym53c8xx, eth1
>  10:     301052          0          XT-PIC  ide2, ide3
> NMI:          0          0
> LOC:     155501     155500
> ERR:       1427
> MIS:          0
> 
> 
> I'm not sure if the following will make the problem abvious
> for people that know anything about the APIC, but here it goes.
> The following are the relevant boot message for APIC. It was fine with
> all of the cards in there except for that Promise controller.
> Maybe the interrupt should have triggered on edge not on level?
> 
> PS. This is for 2.4.18 kernel
> 
> dmesg snip:
> 
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: COMPAQ   Product ID: PROLIANT     APIC at: 0xFEE00000
> Processor #1 Pentium(tm) Pro APIC version 16
> Processor #0 Pentium(tm) Pro APIC version 16
> I/O APIC #2 Version 17 at 0xFEC00000.
> 
> [...]
> 
> ENABLING IO-APIC IRQs
> Setting 2 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=0
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ...
> ..... (found pin 0) ...works.
> number of MP IRQ sources: 16.
> number of IO-APIC #2 registers: 24.
> testing the IO APIC.......................
> 
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .... register #01: 00170011
> .......     : max redirection entries: 0017
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 0011
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
>  00 003 03  0    0    0   0   0    1    1    31
>  01 003 03  0    0    0   0   0    1    1    39
>  02 000 00  1    0    0   0   0    0    0    00
>  03 003 03  0    0    0   0   0    1    1    41
>  04 003 03  0    0    0   0   0    1    1    49
>  05 003 03  1    1    0   1   0    1    1    51
>  06 003 03  0    0    0   0   0    1    1    59
>  07 003 03  0    0    0   0   0    1    1    61
>  08 003 03  0    0    0   0   0    1    1    69
>  09 003 03  1    1    0   1   0    1    1    71
>  0a 003 03  1    1    0   1   0    1    1    79
>  0b 003 03  0    0    0   0   0    1    1    81
>  0c 003 03  0    0    0   0   0    1    1    89
>  0d 003 03  0    0    0   0   0    1    1    91
>  0e 003 03  0    0    0   0   0    1    1    99
>  0f 003 03  0    0    0   0   0    1    1    A1
>  10 000 00  1    0    0   0   0    0    0    00
>  11 000 00  1    0    0   0   0    0    0    00
>  12 000 00  1    0    0   0   0    0    0    00
>  13 000 00  1    0    0   0   0    0    0    00
>  14 000 00  1    0    0   0   0    0    0    00
>  15 000 00  1    0    0   0   0    0    0    00
>  16 000 00  1    0    0   0   0    0    0    00
>  17 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ5 -> 0:5
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:9
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 179.6287 MHz.
> ..... host bus clock speed is 59.8760 MHz.
> cpu: 0, clocks: 598760, slice: 199586
> CPU0<T0:598752,T1:399152,D:14,S:199586,C:598760>
> cpu: 1, clocks: 598760, slice: 199586
> CPU1<T0:598752,T1:199568,D:12,S:199586,C:598760>
> checking TSC synchronization across CPUs: passed.
> Waiting on wait_init_idle (map = 0x2)
> All processors have done init_idle
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---

www.GalacticaSoftware.com
