Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUDFPIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbUDFPIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:08:53 -0400
Received: from usea-naimss2.unisys.com ([192.61.61.104]:22279 "EHLO
	usea-naimss2.unisys.com") by vger.kernel.org with ESMTP
	id S263850AbUDFPIl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:08:41 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.6.5- es7000 subarch update
Date: Tue, 6 Apr 2004 10:08:27 -0500
Message-ID: <452548B29F0CCE48B8ABB094307EBA1C04220139@USRV-EXCH2.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6.5- es7000 subarch update
Thread-Index: AcQboKLug29YRjVkT9O6a1N/TXiS8QAQ6Avg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
X-OriginalArrivalTime: 06 Apr 2004 15:08:28.0125 (UTC) FILETIME=[03F9D0D0:01C41BE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

