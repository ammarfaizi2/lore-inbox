Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWIYRPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWIYRPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWIYRPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:15:30 -0400
Received: from khc.piap.pl ([195.187.100.11]:41384 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751291AbWIYRP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:15:29 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: NV SATA breakage: jgarzik/libata-dev#upstream etc
References: <m3wt7tm6sh.fsf@defiant.localdomain> <451721F8.4060600@pobox.com>
	<m3vencjeit.fsf@defiant.localdomain>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 25 Sep 2006 19:15:27 +0200
Message-ID: <m364fbrhow.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, rebooted it.

After that commit (fea63e38013ec628ab3f7fddc4c2148064b7910a), it does:

ata1: SATA max UDMA/133 cmd 0xC800 ctl 0xC482 bmdma 0xC000 irq 225

GPF: 0 [1]
RIP: ata_device_add+0x19a/0x530
RAX: 48000002d0b38d48
R14: ffff81003f7cc7e0

Call trace:
nv_init_one+0x190/0x1f0
pci_match_device
pci_device_probe
driver_probe_device
__driver_attach
__driver_attach
bus_for_each_dev
driver_register
__pci_register_driver
nv_init
etc.

ata_device_add:
...
 193:   49 8b 46 08             mov    0x8(%r14),%rax <<<< ap->ops = invalid
 197:   4c 89 f7                mov    %r14,%rdi      <<<< ap
 19a:   ff 90 f8 00 00 00       callq  *0xf8(%rax)    <<<< ap->ops->port_start
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
And it GPFs here (ap->ops->port_start(ap)).

Actually it seems the ap->ops = RAX is invalid but not exactly a NULL ptr.

Now, sata_nv.c: nv_init_one():
	struct ata_port_info *ppi;
	ppi = &nv_port_info[ent->driver_data];
	probe_ent = ata_pci_init_native_mode(pdev, &ppi,
        	ATA_PORT_PRIMARY | ATA_ PORT_SECONDARY);

while
/**
 *      ata_pci_init_native_mode - Initialize native-mode driver
 *      @pdev:  pci device to be initialized
 *      @port:  array[2] of pointers to port info structures.
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Not sure... should the nv_init_one() just read:
	struct ata_port_info *ppi[2];
	ppi[0] = ppi[1] = &nv_port_info[ent->driver_data];
	probe_ent = ata_pci_init_native_mode(pdev, ppi,
        	ATA_PORT_PRIMARY | ATA_ PORT_SECONDARY);

or should
	ppi[1] = NULL?
-- 
Krzysztof Halasa
