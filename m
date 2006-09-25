Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWIYMvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWIYMvK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWIYMvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:51:10 -0400
Received: from khc.piap.pl ([195.187.100.11]:34244 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751022AbWIYMvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:51:09 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: NV SATA breakage: jgarzik/libata-dev#upstream etc
References: <m3wt7tm6sh.fsf@defiant.localdomain> <451721F8.4060600@pobox.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 25 Sep 2006 14:51:06 +0200
In-Reply-To: <451721F8.4060600@pobox.com> (Jeff Garzik's message of "Sun, 24 Sep 2006 20:25:28 -0400")
Message-ID: <m3vencjeit.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

>> libata-core.c
>> int ata_device_add(const struct ata_probe_ent *ent)
>> {
>> ...
>>         /* register each port bound to this device */
>>         for (i = 0; i < host->n_ports; i++) {
>> ...
>>                 /* start port */
>>                 rc = ap->ops->port_start(ap);
>>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> The problematic commit is fea63e38013ec628ab3f7fddc4c2148064b7910a:
>> "[PATCH] libata: fix non-uniform ports handling
>> Non-uniform ports handling got broken while updating libata to handle
>> those in the same host.  Only separate irq for the non-uniform
>> secondary port was implemented while all other fields (host flags,
>> transfer mode...) of the secondary port simply shared those of the
>> first.
>
> What's broken, and how does it affect NV sata?

NV SATA initialization fails with NULL pointer dereference in
ata_device_add (= kernel panic).

> That's the chipset on my main dev workstation, and there are no
> problems here...

I'm a bit surprised... I'm using x86_64 with only one SATA "controller"
enabled (ports 0 and 1 only, ports 2-5 are disabled in BIOS). Only
port 0 is in use. Gcc 4.1.1.

With a64f97f2c351410dfb3099c2369eacf7154b5532 (2.6.18-rc7+, "Merge branch
'tmp' into upstream", just before the commit in question) it works fine:

libata version 2.00 loaded.
sata_nv 0000:00:05.0: version 2.0
ACPI: PCI Interrupt Link [LSA0] enabled at IRQ 23
GSI 16 sharing vector 0xE1 and IRQ 16
ACPI: PCI Interrupt 0000:00:05.0[A] -> Link [LSA0] -> GSI 23 (level, low) -> IRQ
 225
PCI: Setting latency timer of device 0000:00:05.0 to 64
ata1: SATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC000 irq 225
ata2: SATA max UDMA/133 cmd 0xC400 ctl 0xC082 bmdma 0xC008 irq 225
scsi0 : sata_nv
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
ata2: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0xC407
  Vendor: ATA       Model: ST3250823AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
-- 
Krzysztof Halasa
