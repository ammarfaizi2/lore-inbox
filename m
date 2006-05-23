Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWEWHJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWEWHJX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 03:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWEWHJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 03:09:22 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:29143 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932070AbWEWHJW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 03:09:22 -0400
Date: Tue, 23 May 2006 03:09:20 -0400
From: Brice Goglin <brice@myri.com>
To: netdev@vger.kernel.org
Cc: gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] myri10ge - Myri-10G Ethernet driver - v3
Message-ID: <20060523070919.GB30499@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 0/5] myri10ge - Myri-10G Ethernet driver - v3

We think we have addressed all problems that have been reported after the
second submission. We would like this driver to be merged in the git-netdev
tree or in -mm, with the aim of being in 2.6.18.

The changes since the previous patchset are:
- drop all volatile, fix __iomem annotations and cleanup/remove some casts
- use kzalloc()
- use msleep() instead of udelay() or schedule_timeout()
- add an atomic flag to myri10ge_send_cmd() so that set_multicast_list
  (which may be called from an atomic context) does not end up using
  msleep when waiting for the command to complete
- split myri10ge_open() to make it more readable
- move Myricom vendor id to pci_ids.h
- place module_param and MODULE_PARM_DESC near the declaration of
  the module parameter variable
- fix missing printk levels
- #define explicit names for our 0xffffffff special values
- reduce MYRI10GE_MCP{_ETHER,}_ into the new firmare prefix MXGEFW_
- fix indentation of goto labels
- various trivial things

myri10ge_xmit() is still very long since there is no nice way to
split it in multiple functions.
We still use several printk instead of dev_err/warn/info/printk
since there are some place where it is better to speak about "eth2"
instead of a bus id in the kernel messages.

The changes that were made in the previous submission can be found
in http://lkml.org/lkml/2006/5/17/236



The following patches introduce the myri10ge driver for Myricom Myri-10G
boards in Ethernet mode. The driver is called myri10ge. The patches are
against 2.6.17-rc4-mm3.

[1/5]   add Myricom vendor id to pci_ids.h
[2/5]   revive pci_find_ext_capability
[3/5]	myri10ge driver header files.
[4/5]	myri10ge driver core.
[5/5]	add Kconfig and Makefile support for the myri10ge driver.

It also uses the following patches that have been sent on May 2
(http://lkml.org/lkml/2006/5/2/286 and 288) and merged into -mm.
add-__iowrite64_copy.patch
	Introduce __iowrite64_copy.
add-pci_cap_id_vndr.patch
	Add the vendor specific extended capability PCI_CAP_ID_VNDR.

The Myri-10G board operates as a regular PCI-Express Ethernet NIC.
If a firmware is available through hotplug, the driver will load it if its
version matches the driver requirements. If not, the driver will adopt the
running firmware that came in the board's eeprom if it is recent enough.

This driver supports in particular NAPI, power management, IPv4 and IPv6
checksum offload, 802.1q VLAN, and TCP Segmentation Offload.

Brice Goglin
