Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVHKV4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVHKV4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVHKV4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:56:50 -0400
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:53522 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S932289AbVHKV4t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:56:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC][2.6.12.3] IRQ compression/sharing patch
Date: Thu, 11 Aug 2005 16:55:40 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACCE04CB4@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][2.6.12.3] IRQ compression/sharing patch
Thread-Index: AcWemV79kQjIaGfdSlew8Bno2bQ6BgAJhCVg
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: <jamesclv@us.ibm.com>
Cc: "Andi Kleen" <ak@suse.de>, "Russ Weight" <rweight@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 11 Aug 2005 21:55:40.0796 (UTC) FILETIME=[6A388BC0:01C59EBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After sleeping on it, maybe the original code can be patched 
> without having to hack assign_irq_vector(), etc.  How about:
> 
> --- io_apic.c	2005-08-11 10:14:33.564748923 -0700
> +++ io_apic.c.new	2005-08-11 10:15:55.412331115 -0700
> @@ -617,7 +617,7 @@ int gsi_irq_sharing(int gsi)
>  	 * than PCI.
>  	 */
>  	for (i = 0; i < NR_IRQS; i++)
> -		if (IO_APIC_VECTOR(i) == vector) {
> +		if (IO_APIC_VECTOR(i) == vector && i != gsi) {
>  			if (!platform_legacy_irq(i))
>  				break;			/* got one */
>  			IO_APIC_VECTOR(gsi) = 0;
> 
> 
Yes that did it, on my small system it looked just right:

<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 0:16
<7>IRQ17 -> 0:17
<7>IRQ18 -> 0:18
<7>IRQ19 -> 0:19
<7>IRQ20 -> 0:20
<7>IRQ21 -> 0:23
<7>IRQ22 -> 1:2
<7>IRQ23 -> 1:3
<7>IRQ24 -> 1:4
<7>IRQ25 -> 1:5
<7>IRQ26 -> 2:0
<7>IRQ27 -> 2:1
<7>IRQ28 -> 2:2
<7>IRQ29 -> 2:3
<7>IRQ30 -> 2:4
<7>IRQ31 -> 2:5
<7>IRQ32 -> 2:6
<7>IRQ33 -> 2:7
<7>IRQ34 -> 2:8
:!cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:      12621      15007      12781      20921    IO-APIC-edge  timer
  1:         72          0          2        175    IO-APIC-edge  i8042
  2:          0          0          0          0          XT-PIC
cascade
  8:          0          0          0          1    IO-APIC-edge  rtc
  9:          0          0          0          0    IO-APIC-edge  acpi
 12:          4        272          0        110    IO-APIC-edge  i8042
 15:          4          0          0         39    IO-APIC-edge  ide1
 16:          0          0          0          0   IO-APIC-level
uhci_hcd:usb1, uhci_hcd:usb4
 17:          0          0          0          2   IO-APIC-level
ohci1394
 18:        730       2407        932       2083   IO-APIC-level
libata, uhci_hcd:usb3
 19:          0          0          0          0   IO-APIC-level
uhci_hcd:usb2
 21:          0          0          0          0   IO-APIC-level
ehci_hcd:usb5
 26:        416          0          0          4   IO-APIC-level  eth0
NMI:        116         71         73         51
LOC:      61280      61258      61236      61214
ERR:          3
MIS:          0

Looks good! I will try the patch also on the ES7000 hopefully big enough
to exercise some vector sharing.

Regards,
--Natalie
