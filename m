Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271313AbTHLSg0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271324AbTHLSg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:36:26 -0400
Received: from fmr06.intel.com ([134.134.136.7]:14804 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S271313AbTHLSgU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:36:20 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Updated MSI Patches
Date: Tue, 12 Aug 2003 11:36:17 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AE94@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcNg/uEGPn8q19q2TLObm4PfCyv3lgAAF0lg
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Zwane Mwaikambo" <zwane@linuxpower.ca>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "long" <tlnguyen@snoqualmie.dp.intel.com>
X-OriginalArrivalTime: 12 Aug 2003 18:36:17.0986 (UTC) FILETIME=[9E471A20:01C36100]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For the legacy devices, an irq_vector mapping should be sufficient as
you
> currently maintain. You could also possibly have a seperate do_MSI
which
> gets a vector pushed to it and then uses mesc_desc instead to do the
> handlers. You then install the IDT entry using the seperate MSI
interrupt
> stub; set_intr_gate(vector, msi_interrupt[msi_num]) where
msi_interrupt is
> a NR_MSI sized array. This way you can avoid touching do_IRQ entirely.

The issue with do_MSI() approach is that it's very similar to do_IRQ(),
and we may have maintenance issues there. However, if we make a common
do_MSI() code, that might be worth it, and I would expect much fewer
architecture-dependent issues there, compared to do_IRQ (the common
do_IRQ() hasn't happened yet as far as I know).

Thanks,
Jun

> -----Original Message-----
> From: Zwane Mwaikambo [mailto:zwane@linuxpower.ca]
> Sent: Tuesday, August 12, 2003 11:11 AM
> To: Nguyen, Tom L
> Cc: Linux Kernel; Nakajima, Jun; long
> Subject: RE: Updated MSI Patches
> 
> Your message would be easier to reply to and read if it was wrapped at
72
> characters, please look into fixing that for the sake of your
recipients.
> Thanks.
> 
> On Tue, 12 Aug 2003, Nguyen, Tom L wrote:
> 
> > I understand that mixing up vector and irq is very confusing.
However,
> > to support non-PCI legacy devices with IRQ less than 16, such as
> > keyboard and mouse for example, may be impossilbe to achieve without
> > mixing up. Some existing driver of legacy keyboard/mouse devices,
for
> > example, may use fixed IO ranges and fixed IRQs (as assigned to 1
for
> > keyboard and 12 for mouse). If these device drivers use these fixed
> > legacy IRQs and the interrupt routings for these non-PCI legacy
devices
> > use vectors, then the system may break. As you know, MSI support
> > requires vector allocation instead of IRQ allocation since MSI does
not
> > require a support of BIOS IRQ table. Mixing vector with IRQ to be
> > compatible with non-PCI legacy devices must be achieved. Last time,
> > your suggestion of changing variable name from irq to vector is the
> > good approach. I am looking at restructuring the code of the
> > vector-base patch. I will send you an update when I am done for your
> > feedback.
> 
> For the legacy devices, an irq_vector mapping should be sufficient as
you
> currently maintain. You could also possibly have a seperate do_MSI
which
> gets a vector pushed to it and then uses mesc_desc instead to do the
> handlers. You then install the IDT entry using the seperate MSI
interrupt
> stub; set_intr_gate(vector, msi_interrupt[msi_num]) where
msi_interrupt is
> a NR_MSI sized array. This way you can avoid touching do_IRQ entirely.
> 
> > Since the code determinces whether this entry is NULL or not, I
think
> any
> > locking for msi_desc may not be required.
> 
> Yes but there is other code which modifies msi_desc members. i think a
per
> msi_desc lock is needed. You could also use a kmem_cache to allocate
them,
> and perhaps utilise HWCACHE_ALIGN.
> 
> 	Zwane

