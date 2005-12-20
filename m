Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVLTVES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVLTVES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVLTVES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:04:18 -0500
Received: from 81-178-94-225.dsl.pipex.com ([81.178.94.225]:29401 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932112AbVLTVER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:04:17 -0500
Date: Tue, 20 Dec 2005 21:03:38 +0000
To: Greg KH <greg@kroah.com>, Martin Bligh <mbligh@google.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Matt Dobson <colpatch@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] pci device sysdata may be null check in pcibus_to_node
Message-ID: <20051220210338.GA20681@shadowen.org>
References: <20051216231752.GA2731@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <20051216231752.GA2731@kroah.com>
User-Agent: Mutt/1.5.11
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci device sysdata may be null, check in pcibus_to_node

We have been seeing panic's on NUMA systems in pci_call_probe() in
2.6.15-rc5-mm2 and -mm3.  It seems that some changes have occured
to the meaning of the 'sysdata' for a device such that it is no
longer just an integer containing the node, it is now a structure
containing the node and other data.  However, it seems that we do not
always initialise this sysdata before we probe the device.

Below are three examples from a boot with this checked for.  It is
not clear to me whether it is reasonable to attempt to probe this
device without the bus sysdata being initialised.  The attached
patch adds a safety check to pcibus_to_node() to avoid the panic,
this restores the 'call anytime' semantic for this function.

Someone who groks the bus initialisation better than I needs to look
this over and confirm whether its reasonable to have a null sysdata
or not.

	Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
	Copyright (c) 1999-2005 Intel Corporation.
	pci_call_probe: starting drv<c03d4be0> dev<dfd16800> id<c03d4734>
	pci_call_probe: dev->bus<dfce6800>
	pci_call_probe: dev->bus->sysdata<00000000>
	pci_call_probe: node<-1>
	e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection

	pci_call_probe: starting drv<c03ef220> dev<dfd17400> id<c03eed00>
	pci_call_probe: dev->bus<dfce6800>
	pci_call_probe: dev->bus->sysdata<00000000>
	pci_call_probe: node<-1>
	Linux Tulip driver version 1.1.13 (December 15, 2004)
	input: AT Translated Set 2 keyboard as /class/input/input0
	tulip0:  EEPROM default media type Autosense.
	tulip0:  Index #0 - Media 10baseT (#0) described by a
		21140 non-MII (0) block.
	tulip0:  Index #1 - Media 100baseTx (#3) described by a
		21140 non-MII (0) block.
	tulip0:  Index #2 - Media 10baseT-FDX (#4) described by a
		21140 non-MII (0) block.
	tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a
		21140 non-MII (0) block.
	eth1: Digital DS21140 Tulip rev 33 at 0001fc00,
		00:00:BC:0F:08:96, IRQ 28.

	pci_call_probe: starting drv<c040a360> dev<dfd14400> id<c040a0fc>
	pci_call_probe: dev->bus<dfce6600>
	pci_call_probe: dev->bus->sysdata<dfffafa0>
	pci_call_probe: node<0>
	qla1280: QLA1040 found on PCI bus 0, dev 11

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 topology.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
diff -upN reference/include/asm-i386/topology.h current/include/asm-i386/topology.h
--- reference/include/asm-i386/topology.h
+++ current/include/asm-i386/topology.h
@@ -60,7 +60,7 @@ static inline int node_to_first_cpu(int 
 	return first_cpu(mask);
 }
 
-#define pcibus_to_node(bus) ((struct pci_sysdata *)((bus)->sysdata))->node
+#define pcibus_to_node(bus) (((bus)->sysdata)? ((struct pci_sysdata *)((bus)->sysdata))->node : -1)
 #define pcibus_to_cpumask(bus) node_to_cpumask(pcibus_to_node(bus))
 
 /* sched_domains SD_NODE_INIT for NUMAQ machines */
