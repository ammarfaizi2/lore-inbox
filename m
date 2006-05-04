Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWEDFHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWEDFHf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 01:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWEDFHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 01:07:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:16508 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751399AbWEDFHe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 01:07:34 -0400
X-IronPort-AV: i="4.05,86,1146466800"; 
   d="scan'208"; a="31261620:sNHT19774076"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Subject: RE: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Date: Thu, 4 May 2006 01:07:29 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB656C800@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [(repost) git Patch 1/1] avoid IRQ0 ioapic pin collision
Thread-index: AcZtsT6vgePsEi1vT3SuA0EDhIDZnQAAVFawAF4YQWA=
From: "Brown, Len" <len.brown@intel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Andi Kleen" <ak@suse.de>, <sergio@sergiomb.no-ip.org>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       <linux-kernel@vger.kernel.org>, <akpm@digeo.com>, <kmurray@redhat.com>,
       <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 04 May 2006 05:07:30.0461 (UTC) FILETIME=[A50D6CD0:01C66F38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> We should never have had a problem with un-connected interrupt lines
>>> consuming vectors, as the vectors are handed out at run-time
>>> only when interrupts are requested by drivers.
>>
>>Incorrect.  By being requested by drivers I assume you mean by
>>request_irq.  assign_irq_vector is called long before request_irq
>>and in fact there is currently not a call from request_irq to
>>assign_irq_vector.  Look where assign_irq_vector is called in 
>io_apic.c

Hmmm, on Natalie's ping, I looked at this again.

setup_IO_APIC_irqs() actually consumes only 16 vectors.
This is because it only sets up the IRQs for pins
found with find_irq_entry(), which searches mp_irqs[]
which at this point contains only the legacy identify mappings.

The PNP code then takes a swing at things, and it registers
a handful of gsi's, but they are all duplicates of the legacy
mappings already set-up, so no additional vectors are consumed.

So on a big system, the large quantity of vectors will not be consumed
at
IOAPIC initialization time, but later at device probe time.
Not via request_irq(), but via pci_enable_device():

pci_enable_device()
 pci_enable_device_bars()
  pcibios_enable_device()
   pcibios_enable_irq() -> acpi_pci_irq_enable()
    acpi_register_gsi()
     mp_register_gsi()
      io_apic_set_pci_routing()
       entry.vector = assign_irq_vector(irq)

So except for the legacy IRQs, we are already allocating the vectors
on-demand, and that doesn't need to be fixed.

-Len
