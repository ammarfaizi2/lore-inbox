Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbVJYPII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbVJYPII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 11:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVJYPII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 11:08:08 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:44423 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932169AbVJYPIH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 11:08:07 -0400
Subject: Re: reference code for non-PCI libata complaint SATA for ARM
	boards.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Deven Balani <devenbalani@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7a37e95e0510250511g631db9edoe4c739ed24b7a79b@mail.gmail.com>
References: <7a37e95e0510250511g631db9edoe4c739ed24b7a79b@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Oct 2005 16:37:12 +0100
Message-Id: <1130254633.25191.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-10-25 at 17:41 +0530, Deven Balani wrote:
> Hi All!
> 
> I am currently writing a low-level driver for non-PCI SATA controller
> in ARM platform.which uses libata-core.c for linux-2.4.25. Can any one
> tell me any reference code available under linux.

At the moment its a bit hard to do a non PCI driver because the core
code assumes that there is a device structure (or pci_dev structure) for
everything. Fixing that is a two line change for 2.6 (probably similar
for 2.4) but Jeff Garzik rejected it. A second problem is that it
doesn't return the host_set by default but 2.4 libata doesn't have the
changes for unloading SATA modules so that should be ignorable


With that patched something like this will do the job (you'll probably
be using MMIO while the example is PIO)

static __init int legacy_init_one(unsigned long io, unsigned long ctrl,
int irq)
{
        struct ata_probe_ent ae;
        int ret;

        memset(&ae, 0, sizeof(struct ata_probe_ent));
        ae.dev = NULL;
        ae.port_ops = &legacy_port_ops;
        ae.sht = &legacy_sht;
        ae.n_ports = 2;
        ae.pio_mask = 0x1F;
        ae.irq = irq;
        ae.irq_flags = 0;
        ae.host_flags = ATA_FLAG_SLAVE_POSS;
        ae.port[0].cmd_addr = io;
        ata_std_ports(&ae.port[0]);
        ae.port[0].altstatus_addr = ctrl;
        ae.port[0].ctl_addr =   ctrl;

        ret = ata_device_add(&ae);
        if(ret == 0)
                return -ENODEV;

        legacy_host[nr_legacy_host++] = ae.host_set;
        return 0;
}

