Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWEQWCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWEQWCW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWEQWCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:02:21 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:43680 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1751175AbWEQWCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:02:21 -0400
Date: Wed, 17 May 2006 18:02:19 -0400
From: Brice Goglin <brice@myri.com>
To: netdev@vger.kernel.org
Cc: gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] myri10ge - Myri-10G Ethernet driver - v2
Message-ID: <20060517220218.GA13411@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 0/4] myri10ge - Myri-10G Ethernet driver - v2

The following patches introduce the myri10ge driver for Myricom Myri-10G
boards in Ethernet mode. The driver is called myri10ge. The patches are
against 2.6.17-rc4-mm1.

[1/4]   revive pci_find_ext_capability
[2/4]	myri10ge driver header files.
[3/4]	myri10ge driver core.
[4/4]	Add Kconfig and Makefile support for the myri10ge driver.

It also uses the following patches that have been sent on May 2
(http://lkml.org/lkml/2006/5/2/286 and 288) and merged into -mm.
add-__iowrite64_copy.patch
	Introduce __iowrite64_copy.
add-pci_cap_id_vndr.patch
	Add the vendor specific extended capability PCI_CAP_ID_VNDR.

We think we have addressed will problems that have been reported after
the first submission. Major changes include:
- We have dropped the "does msi work on this chipset ?" detection code
  and we simply enable msi by default. We are working on patches to
  improve MSI detection in the core PCI code.
- The spinlock that was held during up to 2s has been replaced with
  using rtnl_lock (and the delay has been reduced to 15ms).
- no X86||X86_64 specific code anymore
- non-NAPI support has been dropped
- TSO is enabled by default
- some comments have been added to justify some design choices

Other changes:
- use netdev_priv, setup_timer and skb_checksum_help helps
- PCI_DEVICE, ALIGN, DMA_MASK and ETH_ALEN macros
- use wait_event_timeout in the close routine
- fix cksum regarding to vlan and tso
- rename MYRI10GE_MCP_M{IN,AJ}OR into MYRI10GE_MCP_VERSION_M{IN,AJ}OR
- only add NETIF_F_HIGHDMA only if dma_mask bas been set
- add MODULE_PARM_DESC
- check/use myri10ge_send_cmd return status
- return pci_register_driver return value init the driver init function
- drop empty functions (set_setting, init and ioctl)
- add __init and __exit to module init and exit routines
- add missing static and const, remove useless volatile
- do not typedef struct and enum
- {u,s}{8,16,32,64} instead of {u,}int{8,16,32,64}_t
- remove useless casts
- uppercase _myri10ge_mcp_h and _myri10ge_mcp_gen_header_h
- drop unused ugly macro in the headers
- fix multiple indentation problems

We still have some chipset specific code to deal with alignment of PCI-E
completions. When aligned, we can get much better performance by using an
optimized firmware. The HT2000 chipset is known to provide aligned completions.
See myri10ge_select_firmware() for details. For other chipsets, we try to
enable ECRC if the board is attached to a root port (so that we do not
disturb any other device that would not like ECRC).
We don't think that this ECRC and PCI-E completion alignment code has to
be moved to the PCI core since it is very specific to our driver.

Enabling ECRC on the nVidia CK804 PCI-E bridge is problematic since the
PCI_EXT_CAP_ID_ERR capability is not linked as it is supposed. We didn't
find any way to do this with a quirk. So we work around it with a local fix.
See myri10ge_enable_ecrc() for details.





The Myri-10G board operates as a regular PCI-Express Ethernet NIC.
If a firmware is available through hotplug, the driver will load it if its
version matches the driver requirements. If not, the driver will adopt the
running firmware that came in the board's eeprom if it is recent enough.

This driver supports in particular NAPI, power management, IPv4 and IPv6
checksum offload, 802.1q VLAN, and TCP Segmentation Offload.

Brice Goglin
