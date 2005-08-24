Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbVHXGWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbVHXGWD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 02:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVHXGWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 02:22:03 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51638 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751477AbVHXGWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 02:22:01 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc7 qla2xxx unaligned accesses
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Aug 2005 16:21:57 +1000
Message-ID: <13194.1124864517@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.13-rc7 + kdb on ia64.  The qla2xxx drivers are getting unaligned
accesses at startup.

qla2300 0000:01:02.0: Found an ISP2312, irq 66, iobase 0xc00000080f300000
qla2300 0000:01:02.0: Configuring PCI space...
PCI: slot 0000:01:02.0 has incorrect PCI cache line size of 0 bytes, correcting to 128
qla2300 0000:01:02.0: Configure NVRAM parameters...
qla2300 0000:01:02.0: Verifying loaded RISC code...
qla2300 0000:01:02.0: Waiting for LIP to complete...
qla2300 0000:01:02.0: Cable is unplugged...
scsi1 : qla2xxx
kernel unaligned access to 0xe00000300667800c, ip=0xa0000001005cd0b1
qla2300 0000:01:02.0:
 QLogic Fibre Channel HBA Driver: 8.01.00b5-k
  QLogic QLA2342 -
  ISP2312: PCI (66 MHz) @ 0000:01:02.0 hdma+, host#=1, fw=3.03.15 IPX
ACPI: PCI Interrupt 0000:01:02.1[B]: no GSI
qla2300 0000:01:02.1: Found an ISP2312, irq 67, iobase 0xc00000080f301000
qla2300 0000:01:02.1: Configuring PCI space...
PCI: slot 0000:01:02.1 has incorrect PCI cache line size of 0 bytes, correcting to 128
qla2300 0000:01:02.1: Configure NVRAM parameters...
qla2300 0000:01:02.1: Verifying loaded RISC code...
qla2300 0000:01:02.1: Waiting for LIP to complete...
qla2300 0000:01:02.1: Cable is unplugged...
scsi2 : qla2xxx
kernel unaligned access to 0xe0000030066a400c, ip=0xa0000001005cd0b1
qla2300 0000:01:02.1:
 QLogic Fibre Channel HBA Driver: 8.01.00b5-k
  QLogic QLA2342 -
  ISP2312: PCI (66 MHz) @ 0000:01:02.1 hdma+, host#=2, fw=3.03.15 IPX
ACPI: PCI Interrupt 0000:02:02.0[A]: no GSI
qla2300 0000:02:02.0: Found an ISP2312, irq 63, iobase 0xc00000080fa40000
qla2300 0000:02:02.0: Configuring PCI space...
qla2300 0000:02:02.0: Configure NVRAM parameters...
qla2300 0000:02:02.0: Verifying loaded RISC code...
qla2300 0000:02:02.0: Waiting for LIP to complete...
qla2300 0000:02:02.0: Cable is unplugged...
scsi3 : qla2xxx
kernel unaligned access to 0xe0000030066c000c, ip=0xa0000001005cd0b1
qla2300 0000:02:02.0:
 QLogic Fibre Channel HBA Driver: 8.01.00b5-k
  QLogic QLA2342 -
  ISP2312: PCI-X (133 MHz) @ 0000:02:02.0 hdma+, host#=3, fw=3.03.15 IPX
ACPI: PCI Interrupt 0000:02:02.1[B]: no GSI
qla2300 0000:02:02.1: Found an ISP2312, irq 64, iobase 0xc00000080fa41000
qla2300 0000:02:02.1: Configuring PCI space...
qla2300 0000:02:02.1: Configure NVRAM parameters...
qla2300 0000:02:02.1: Verifying loaded RISC code...
qla2300 0000:02:02.1: Waiting for LIP to complete...
qla2300 0000:02:02.1: Cable is unplugged...
scsi4 : qla2xxx
kernel unaligned access to 0xe0000030066d000c, ip=0xa0000001005cd0b1

0xa0000001005cd0b1 is qla2x00_init_host_attr+0x71.

void
qla2x00_init_host_attr(scsi_qla_host_t *ha)
{
        fc_host_node_name(ha->host) =
            be64_to_cpu(*(uint64_t *)ha->init_cb->node_name);
        fc_host_port_name(ha->host) =
            be64_to_cpu(*(uint64_t *)ha->init_cb->port_name);
}

It looks like ha->init_cb->port_name.


