Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUDLRAo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 13:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUDLRAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 13:00:44 -0400
Received: from usea-naimss3.unisys.com ([192.61.61.105]:29457 "EHLO
	usea-naimss3.unisys.com") by vger.kernel.org with ESMTP
	id S262951AbUDLRAi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 13:00:38 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.6.5- es7000 subarch update
Date: Mon, 12 Apr 2004 12:00:24 -0500
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C0422014B@USRV-EXCH2.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.5- es7000 subarch update
Thread-Index: AcQboKLug29YRjVkT9O6a1N/TXiS8QAQ6AvgATGPYYA=
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andrew Morton" <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>
Cc: <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
X-OriginalArrivalTime: 12 Apr 2004 17:00:25.0582 (UTC) FILETIME=[A65EE8E0:01C420AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Martin,
I was able to reproduce the timer problem on a Xeon generic box, where my patch caused the same thing: a duplicate entry for the timer was programmed in the IO-APIC. The fact that it worked for es7000 was unfortunately just a coincidence :( I investigated it more and found that the legacy irq overwrite code had a bit of deficiency, which was revealed with our overwrite case. Please consider the following problem.
 
mp_config_acpi_legacy_irqs() constructs legacy irq table (irq<16), namely the default mp_irqs[] array which initially has one to one correspondence of a pin and a bus irq (pin=bus irq, for general case).

ACPI: IOAPIC (id[0x81] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 129
IOAPIC[0]: apic_id 129, version 4, address 0xfec00000, IRQ 0-23
Int: entry 0, type 0, pol 0, trig 0, bus 0, irq 0, 129-0
Int: entry 1, type 0, pol 0, trig 0, bus 0, irq 1, 129-1
Int: entry 3, type 0, pol 0, trig 0, bus 0, irq 3, 129-3
Int: entry 4, type 0, pol 0, trig 0, bus 0, irq 4, 129-4
Int: entry 5, type 0, pol 0, trig 0, bus 0, irq 5, 129-5
Int: entry 6, type 0, pol 0, trig 0, bus 0, irq 6, 129-6
Int: entry 7, type 0, pol 0, trig 0, bus 0, irq 7, 129-7
Int: entry 8, type 0, pol 0, trig 0, bus 0, irq 8, 129-8
Int: entry 9, type 0, pol 0, trig 0, bus 0, irq 9, 129-9
Int: entry 10, type 0, pol 0, trig 0, bus 0, irq 10, 129-10
Int: entry 11, type 0, pol 0, trig 0, bus 0, irq 11, 129-11
Int: entry 12, type 0, pol 0, trig 0, bus 0, irq 12, 129-12
Int: entry 13, type 0, pol 0, trig 0, bus 0, irq 13, 129-13
Int: entry 14, type 0, pol 0, trig 0, bus 0, irq 14, 129-14
Int: entry 15, type 0, pol 0, trig 0, bus 0, irq 15, 129-15

The override function mp_override_legacy_irq() parses ACPI INT_SRC_OVR entries, and each override entry results in a change of corresponding mp_irqs[] array element.
The problem happens when the dest_irq (pin) numerically smaller than the bus irq and is assigned higher array element (we index of the srcbus_irq) that the original bus irq with default correspondence. The mp_irqs[] element with new bus irq gets changed allright, but there is still the original (unmodified) element with default one-to-one assignment above it in the array: 
...
Int: mp_irq 7, type 0, pol 3, trig 1, bus 0, irq 8, 129-18
Int: mp_irq 8, type 0, pol 1, trig 3, bus 0, irq 9, 129-23
Int: mp_irq 9, type 0, pol 0, trig 0, bus 0, irq 10, 129-10
Int: mp_irq 10, type 0, pol 0, trig 0, bus 0, irq 11, 129-11
Int: mp_irq 11, type 0, pol 1, trig 1, bus 0, irq 12, 129-19
Int: mp_irq 12, type 0, pol 0, trig 0, bus 0, irq 13, 129-13 <-- original entry for bus irq (and pin) 13
Int: mp_irq 13, type 0, pol 1, trig 1, bus 0, irq 14, 129-15
Int: mp_irq 14, type 0, pol 1, trig 1, bus 0, irq 15, 129-13 <-- modified entry for bus irq 15, with override for pin 13
...

Since it is a valid entry, find_irq_entry() in setup_IO_APIC_irqs() searches the mp_irqs[] by the pin number and runs into this element first. It uses it to program the pin and never gets to the element down below that contains modified entry with a correct overwrite in it. 
I was able to get rid of this problem on the ES7000 with the following code:

        for (i = 0; i < mp_irq_entries; i++) {
                if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus)
                      && (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
                        mp_irqs[i] = intsrc;
  +                     if (intsrc.mpc_srcbusirq > pin) {
  +                            int j;
  +                            for (j = 0; j < i; j++) 
  +                                   if (mp_irqs[j].mpc_dstirq == intsrc.mpc_dstirq)  
  +                                         mp_irqs[j].mpc_irqtype = -1;
  +                     }
                        found = 1;
                        break;
                }
        }

This resulted in the following array changes:
...
Int: mp_irq 10, type 0, pol 0, trig 0, bus 0, irq 11, 129-11
Int: mp_irq 11, type 0, pol 1, trig 1, bus 0, irq 12, 129-19
Int: mp_irq 12, type 255, pol 0, trig 0, bus 0, irq 13, 129-13 <-- invalidated element
Int: mp_irq 13, type 0, pol 1, trig 1, bus 0, irq 14, 129-15
Int: mp_irq 14, type 0, pol 1, trig 1, bus 0, irq 15, 129-13 <-- valid element
...

... and find_irq_entry() skipped the first element of mp_irqs[] with the pin 13 and went on searching until found the correct one.

This code did not affect my generic Xeon system.
Please let me know if it appears a viable solution to you. I can think of a couple other possible ways, this one seems to be the easiest... 

I will appreciate any feedback and suggestions.
Thanks,
--Natalie


-----Original Message-----
From: Protasevich, Natalie 
Sent: Tuesday, April 06, 2004 9:08 AM
To: 'Andrew Morton'
Cc: linux-kernel@vger.kernel.org; lse-tech@lists.sourceforge.net
Subject: RE: [PATCH] 2.6.5- es7000 subarch update


Hi Andrew,

The only line that is outside the es7000 code and could cause this is:

> --- linux6.5/arch/i386/kernel/mpparse.c	2004-04-04 18:22:39.000000000 -0400
> +++ linux-2.6.5/arch/i386/kernel/mpparse.c	2004-04-05 00:07:13.000000000 -0400
> @@ -969,7 +969,7 @@
>  	 */
>  	for (i = 0; i < mp_irq_entries; i++) {
>  		if ((mp_irqs[i].mpc_srcbus == intsrc.mpc_srcbus) 
> -			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
> +			&& (mp_irqs[i].mpc_dstirq == intsrc.mpc_dstirq)) {
>  			mp_irqs[i] = intsrc;
>  			found = 1;

(The one that Martin asked me about)
The code is for the legacy/overwrites, and used to have this line (and I am researching it now).
ES7000 has pretty extensive overrides:
ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 12 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 13 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 4 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 15 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 6 global_irq 16 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 7 global_irq 17 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 18 low edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 12 global_irq 19 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 20 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 23 high level)

The only device that fails to set the line correctly with the code as it is now is the IDE (line 4) and works fine with the suggested line. In the case below, the clock gets mapped to the cascade...
I will do more testing on the generic Xeon then, it should be a good solution there. Maybe, this is something that the hook might be needed for es7000.
Thanks,
--Natalie

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org]
Sent: Tuesday, April 06, 2004 12:30 AM
To: Protasevich, Natalie
Cc: linux-kernel@vger.kernel.org; lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] 2.6.5- es7000 subarch update


"Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com> wrote:
>
> ES7000 was failing to boot since first couple revisions of 2.6. The patch fixes the boot problem. 
>  In the patch, some maintenance and cleanup was done for es7000 subarch, such as APIC destinations were corrected, missing initialization for the variable was added, extraneous file was removed, etc.
>  The patch was created against 2.6.5, compiled  cleanly, and tested on the ES7000 system.

This patch appears to cause the local-apic based time interrupts to run too
fast on my old 4-way Xeon server.  A `sleep 10' takes about five seconds.

Diffing the dmesg output shows the changes which your patch caused:

--- without	2004-04-05 22:18:41.061198208 -0700
+++ with	2004-04-05 22:17:15.000000000 -0700
@@ -1,4 +1,4 @@
- IO-APIC (apicid-pin) 4-0, 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23, 4-24, 4-25, 4-26, 4-27, 4-28, 4-29, 4-30, 4-31, 4-32, 4-33, 4-34, 4-35, 4-36, 4-37, 4-38, 4-39, 4-40, 4-41, 4-42, 4-43, 4-44, 4-45, 4-46, 4-47, 4-48, 4-49, 4-50, 4-51, 4-52, 4-53, 4-54, 4-55, 4-56, 4-57, 4-58, 4-59, 4-60, 4-61, 4-62, 4-63 not connected.
-..TIMER: vector=0x31 pin1=2 pin2=-1
+ IO-APIC (apicid-pin) 4-16, 4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23, 4-24, 4-25, 4-26, 4-27, 4-28, 4-29, 4-30, 4-31, 4-32, 4-33, 4-34, 4-35, 4-36, 4-37, 4-38, 4-39, 4-40, 4-41, 4-42, 4-43, 4-44, 4-45, 4-46, 4-47, 4-48, 4-49, 4-50, 4-51, 4-52, 4-53, 4-54, 4-55, 4-56, 4-57, 4-58, 4-59, 4-60, 4-61, 4-62, 4-63 not connected.
+..TIMER: vector=0x31 pin1=0 pin2=-1


-number of MP IRQ sources: 15.
+number of MP IRQ sources: 16.


 .... IRQ redirection table:
  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
- 00 000 00  1    0    0   0   0    0    0    00
+ 00 00F 0F  0    0    0   0   0    1    1    31
  01 00F 0F  0    0    0   0   0    1    1    39
  02 00F 0F  0    0    0   0   0    1    1    31
  03 00F 0F  0    0    0   0   0    1    1    41
@@ -368,7 +368,7 @@
  3e 000 00  1    0    0   0   0    0    0    00
  3f 000 00  1    0    0   0   0    0    0    00
 IRQ to pin mappings:
-IRQ0 -> 0:2
+IRQ0 -> 0:0-> 0:2
 IRQ1 -> 0:1
 IRQ3 -> 0:3
 IRQ4 -> 0:4

