Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUDNT56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDNT56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:57:58 -0400
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:29623 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261500AbUDNT5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:57:54 -0400
From: Christian =?iso-8859-1?q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH]
Date: Wed, 14 Apr 2004 21:57:34 +0200
User-Agent: KMail/1.6.1
Cc: Len Brown <len.brown@intel.com>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       ross@datscreative.com.au
References: <200404131117.31306.ross@datscreative.com.au> <1081893978.2251.653.camel@dhcppc4> <200404141502.14023.ross@datscreative.com.au>
In-Reply-To: <200404141502.14023.ross@datscreative.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404142157.34502.christian.kroener@tu-harburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just would like to add that if we cannot get Maciej's 8259 ack patch
> back into the distro then we need an if statement in the check_timer()
> to turn off timer_ack for nforce2 or Christian might get his hi-load back
> and certainly nmi_debug=1 won't work.
>
> e.g. for 2.4.26-rc2 io_apic.c line 1613 or 2.6.5 line 2180
> 	if (pin1 != -1) {
> 		/*
> 		 * Ok, does IRQ0 through the IOAPIC work?
> 		 */
> +		if(acpi_skip_timer_override)
> +			timer_ack=0;
> 		unmask_IO_APIC_irq(0);
>

Well it seems that if at least on -mm this isn't necessary.

Len, I simply applied your patch against 2.6.5-mm5-1 and it just works, great 
work! Having finally read http://bugme.osdl.org/show_bug.cgi?id=1203 I must 
say that my nforce2-board (MSI K7N2-Delta) never ever hung, wether I had the 
wrong timer setup or APIC on/off didn't harm any.

What I get now:

cat /proc/interrupts

           CPU0
  0:   25978569    IO-APIC-edge  timer
  1:       2102    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  7:          0    IO-APIC-edge  parport0
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:     147962    IO-APIC-edge  i8042
 14:     405977    IO-APIC-edge  ide0
 15:         93    IO-APIC-edge  ide1
 16:      60192   IO-APIC-level  ide2, saa7134[0]
 17:        155   IO-APIC-level  CMI8738
 19:    2209002   IO-APIC-level  nvidia
 20:    7538158   IO-APIC-level  ohci_hcd, eth0
 21:          0   IO-APIC-level  ehci_hcd
 22:         78   IO-APIC-level  ohci_hcd
NMI:          0
LOC:   25946237
ERR:          0
MIS:          0


timer setup:

ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-2, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not 
connected.
..TIMER: vector=0x31 pin1=0 pin2=-1
Using local APIC timer interrupts.
calibrating APIC timer ...


irq routing:

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 001 01  0    0    0   0   0    1    1    31
 01 001 01  0    0    0   0   0    1    1    39
 02 000 00  1    0    0   0   0    0    0    00
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    1    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 001 01  1    1    0   0   0    1    1    D1
 11 001 01  1    1    0   0   0    1    1    D9
 12 001 01  1    1    0   0   0    1    1    E1
 13 001 01  1    1    0   0   0    1    1    C9
 14 001 01  1    1    0   0   0    1    1    B1
 15 001 01  1    1    0   0   0    1    1    C1
 16 001 01  1    1    0   0   0    1    1    B9
 17 001 01  1    1    0   0   0    1    1    A9
IRQ to pin mappings:
IRQ0 -> 0:0
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
IRQ20 -> 0:20
IRQ21 -> 0:21
IRQ22 -> 0:22
IRQ23 -> 0:23
.................................... done.


This is simply great, any uncommon hi-load disappeared.
Will something like this get into mainline soon, maybe with automatic chipset 
detection?

Once again, thanks, christian.

P.S.: I will test the patch against mainline 2.6.5 kernel now and post the 
results later.
