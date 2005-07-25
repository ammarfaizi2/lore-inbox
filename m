Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVGYRIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVGYRIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 13:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVGYRIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 13:08:34 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:2504 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S261357AbVGYRId convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 13:08:33 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6.13-rc3-git4] VIA686A polymorphs into VIA586!
Date: Mon, 25 Jul 2005 10:08:19 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C33D28A2@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.13-rc3-git4] VIA686A polymorphs into VIA586!
thread-index: AcWPbu27z/C92KHcQvSrg+GbMtPYLwByquwQ
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Giancarlo Formicuccia" <giancarlo.formicuccia@gmail.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jul 2005 17:08:30.0762 (UTC) FILETIME=[7B4C40A0:01C5913B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Giancarlo Formicuccia [mailto:giancarlo.formicuccia@gmail.com] 
>Sent: Saturday, July 23, 2005 3:20 AM
>To: linux-kernel@vger.kernel.org
>Cc: Aleksey Gorelov
>Subject: [2.6.13-rc3-git4] VIA686A polymorphs into VIA586!
>
>[Please CC me in any reply]
>
>Hi *,
>
>I'm getting many "irq routing conflict" with kernel 2.6.13-rc3-git4.
>I have a quite old k7m with a VIA vt82c686a south
>bridge; no apic, no acpi.
>
>After some digging, I found the culprit in this - apparently
>unrelated - patch:
>
>http://marc.theaimsgroup.com/?l=bk-commits-head&m=111955644929114&w=2
>
>On my system, the function via_router_probe is called
>with device==0x586 (PCI_DEVICE_ID_VIA_82C586_0).
>
>Then, I looked at these lines in function pirq_find_router:
>
>	for( h = pirq_routers; h->vendor; h++) {
>		/* First look for a router match */
>		if (rt->rtr_vendor == h->vendor && h->probe(r, 
>pirq_router_dev, rt->rtr_device))
>			break;
>		/* Fall back to a device match */
>		if (pirq_router_dev->vendor == h->vendor && 
>h->probe(r, pirq_router_dev, pirq_router_dev->device))
>			break;
>	}
>
>Here,  rt->rtr_device==0x586 and  pirq_router_dev->device==0x686!
>There is _no_ device 0x586 on my board:
>
>00:00.0 Class 0600: 1022:7006 (rev 25)
>00:01.0 Class 0604: 1022:7007 (rev 01)
>00:04.0 Class 0601: 1106:0686 (rev 1b) <<<
>00:04.1 Class 0101: 1106:0571 (rev 06)
>00:04.2 Class 0c03: 1106:3038 (rev 0e)
>00:04.3 Class 0c03: 1106:3038 (rev 0e)
>00:04.4 Class 0c05: 1106:3057 (rev 20)
>00:04.5 Class 0401: 1106:3058 (rev 21)
>00:0f.0 Class 0200: 10ec:8029
>00:10.0 Class 0400: 109e:036e (rev 02)
>00:10.1 Class 0480: 109e:0878 (rev 02)
>01:05.0 Class 0300: 121a:0005 (rev 01)

Be irq routing table definition, rtr_vendor:rtr_device should contain
COMPATIBLE pci Interrupt Router, and rtr_bus & rtr_devfn - location of
the actual device (pirq_router_dev). So,
1. Apparently, there is a bug in the BIOS - 586 & 686 are not compatible
(different mapping)
2. Does anybody know why compatible device is probed first, and actual
one afterwards ? In other words, is swapping probes in the code above
would give more correct behavior ?

>
>
>This patch brings my board back to the correct behaviour
>[Aleksey Gorelov CC'd for review/comments/suggestions]:
>
>--- linux-2.6.13-git4/arch/i386/pci/irq.c.org	2005-07-23 
>11:15:12.000000000 +0200
>+++ linux-2.6.13-git4/arch/i386/pci/irq.c	2005-07-23 
>11:55:50.000000000 +0200
>@@ -553,10 +553,12 @@
> 	switch(device)
> 	{
> 		case PCI_DEVICE_ID_VIA_82C586_0:
>-			r->name = "VIA";
>-			r->get = pirq_via586_get;
>-			r->set = pirq_via586_set;
>-			return 1;
>+			if 
>(router->device==PCI_DEVICE_ID_VIA_82C586_0) {
>+				r->name = "VIA";
>+				r->get = pirq_via586_get;
>+				r->set = pirq_via586_set;
>+				return 1;
>+			}
> 		case PCI_DEVICE_ID_VIA_82C596:
> 		case PCI_DEVICE_ID_VIA_82C686:
> 		case PCI_DEVICE_ID_VIA_8231:
>
Probably, comments on buggy BIOS would be nice here.. 

Aleks.

>
>Can someone explain me what's going on and maybe cook a better fix?
>
>Thanks,
>
>Giancarlo
>
