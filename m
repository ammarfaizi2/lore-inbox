Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbUKMAz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbUKMAz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUKLXqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:46:20 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18325 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262665AbUKLXVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:21:09 -0500
Date: Fri, 12 Nov 2004 15:20:57 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI fixes for 2.6.10-rc1
Message-ID: <20041112232057.GA16964@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some PCI patches for 2.6.10-rc1.  They include:
	- pci roms ysfs interface
	- lots of some pci_find_device fixes
	- other minor stuff.

Almost all of these patches  lot of these have been in the past few -mm
releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.6

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 arch/i386/pci/changelog                |   62 -----
 Documentation/kernel-parameters.txt    |   12 +
 arch/i386/kernel/acpi/boot.c           |   10 
 arch/i386/kernel/quirks.c              |    4 
 arch/i386/pci/acpi.c                   |   32 +-
 arch/i386/pci/common.c                 |    4 
 arch/i386/pci/fixup.c                  |  129 ++++++++++
 arch/i386/pci/irq.c                    |   41 ++-
 arch/i386/pci/mmconfig.c               |    5 
 arch/ia64/pci/pci.c                    |   66 ++++-
 arch/ppc/platforms/chrp_pci.c          |    2 
 arch/ppc/platforms/gemini_pci.c        |    2 
 arch/ppc/platforms/k2.c                |    3 
 arch/ppc/platforms/lopec.c             |    3 
 arch/ppc/platforms/mcpn765.c           |    7 
 arch/ppc/platforms/pcore.c             |    3 
 arch/ppc/platforms/pmac_pci.c          |    4 
 arch/ppc/platforms/pplus.c             |    9 
 arch/ppc/platforms/prep_pci.c          |   15 -
 arch/ppc/platforms/prpmc750.c          |    3 
 arch/ppc/platforms/sandpoint.c         |    3 
 arch/sh/drivers/pci/fixups-dreamcast.c |    2 
 arch/sparc/kernel/ebus.c               |    6 
 arch/sparc64/kernel/isa.c              |    2 
 arch/sparc64/kernel/pci_iommu.c        |    3 
 arch/v850/kernel/rte_mb_a_pci.c        |    2 
 arch/x86_64/kernel/pci-gart.c          |    2 
 arch/x86_64/pci/mmconfig.c             |    3 
 drivers/atm/idt77252.c                 |   12 -
 drivers/char/agp/sis-agp.c             |    2 
 drivers/char/cyclades.c                |    4 
 drivers/char/drm/drm_drv.h             |    3 
 drivers/char/watchdog/scx200_wdt.c     |   12 -
 drivers/ide/ide.c                      |   14 +
 drivers/isdn/tpam/tpam_main.c          |    4 
 drivers/media/video/zr36120.c          |    5 
 drivers/misc/ibmasm/module.c           |    6 
 drivers/net/tulip/de4x5.c              |    8 
 drivers/pci/Makefile                   |    8 
 drivers/pci/bus.c                      |   31 +-
 drivers/pci/hotplug/acpiphp_glue.c     |    4 
 drivers/pci/hotplug/cpcihp_generic.c   |   18 -
 drivers/pci/hotplug/fakephp.c          |  128 ++++++++++
 drivers/pci/hotplug/ibmphp_core.c      |   10 
 drivers/pci/hotplug/pciehp.h           |   21 +
 drivers/pci/hotplug/pciehp_core.c      |   18 -
 drivers/pci/hotplug/pciehp_ctrl.c      |  391 +++++++++++++++++++++------------
 drivers/pci/hotplug/pciehp_hpc.c       |   36 ++-
 drivers/pci/hotplug/pciehp_pci.c       |    8 
 drivers/pci/hotplug/pciehprm_acpi.c    |   43 +++
 drivers/pci/hotplug/shpchp_ctrl.c      |   34 ++
 drivers/pci/hotplug/shpchp_hpc.c       |    1 
 drivers/pci/pci-acpi.c                 |  209 +++++++++++++++++
 drivers/pci/pci-driver.c               |   15 -
 drivers/pci/pci-sysfs.c                |  120 ++++++++++
 drivers/pci/pci.c                      |   12 +
 drivers/pci/pci.h                      |    6 
 drivers/pci/probe.c                    |   33 +-
 drivers/pci/quirks.c                   |   19 +
 drivers/pci/remove.c                   |    2 
 drivers/pci/rom.c                      |  225 ++++++++++++++++++
 drivers/pci/setup-res.c                |    2 
 drivers/video/matrox/matroxfb_base.c   |    7 
 include/asm-generic/vmlinux.lds.h      |    3 
 include/linux/ioport.h                 |    5 
 include/linux/pci-acpi.h               |   61 +++++
 include/linux/pci.h                    |   43 ++-
 include/linux/pci_ids.h                |    8 
 sound/pci/cmipci.c                     |    7 
 69 files changed, 1613 insertions(+), 424 deletions(-)
-----

<jdittmer:ppp0.net>:
  o fakephp: add pci bus rescan ability
  o fakephp: introduce pci_bus_add_device

<thockin:google.com>:
  o PCI: small PCI probe patch for odd 64 bit BARs

Adrian Bunk:
  o PCI: kill old PCI changelog

Bjorn Helgaas:
  o PCI: remove unconditional PCI ACPI IRQ routing
  o PCI: propagate pci_enable_device() errors
  o acpi: better encapsulate eisa_set_level_irq()

Dely Sy:
  o PCI: ASPM patch for
  o PCI: Updated patch to fix adapter speed mismatch for 2.6 kernel
  o PCI: Updated patch to add ExpressCard support

Greg Kroah-Hartman:
  o PCI Hotplug: fix up remaining MODULE_PARAM usage in pci hotplug drivers
  o PCI: remove kernel log message about drivers not calling pci_disable_device()
  o PCI: use pci_dev_present() in irq.c check

Hanna V. Linder:
  o prep_pci.c: replace pci_find_device with pci_get_device
  o pplus.c: replace pci_find_device with pci_get_device
  o pmac_pci.c: replace pci_find_device with pci_get_device
  o pcore.c: replace pci_find_device with pci_get_device
  o mcpn765.c: replace pci_find_device with pci_get_device
  o prpmc750.c: replace pci_find_device with pci_get_device
  o sandpoint.c: replace pci_find_device with pci_get_device
  o fixups-dreamcast.c: replace pci_find_device with pci_get_device
  o ebus.c: replace pci_find_device with pci_get_device
  o isa.c: replace pci_find_device with pci_get_device
  o pci_iommu.c: replace pci_find_device with pci_get_device
  o ret_mb_a_pci.c: replace pci_find_device with pci_get_device
  o pci-gart.c: replace pci_find_device with pci_get_device
  o sis-agp.c: replace pci_find_device with pci_get_device
  o drm_drv.h: replace pci_find_device
  o cmipci.c: convert pci_find_device to pci_get_device
  o k2.c: replace pci_find_device with pci_get_device
  o lopec.c: replace pci_find_device with pci_get_device
  o matroxfb_base.c: convert pci_find_device to pci_get_device
  o gemini_pci.c: replace pci_find_device with for_each_pci_dev
  o chrp_pci.c: replace pci_find_device with for_each_pci_dev
  o ibmphp_core.c: replace pci_get_device with pci_dev_present
  o scx200_wdt.c: replace pci_find_device with pci_dev_present
  o ide.c: replace pci_find_device with pci_dev_present
  o zr36120.c: Convert pci_find_device to pci_dev_present
  o cyclades.c: replace pci_find_device
  o PCI: Changed pci_find_device to pci_get_device

Ivan Kokshaysky:
  o PCI: add pci_fixup_early

Jon Smirl:
  o PCI: add PCI ROMs to sysfs

Kenji Kaneshige:
  o PCI: add hook for PCI resource deallocation

Thomas Gleixner:
  o Lock initializer unifying Batch 2 (PCI)

Tom L. Nguyen:
  o PCI: pci-mmconfig fix

