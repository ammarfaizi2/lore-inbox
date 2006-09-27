Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWI0BAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWI0BAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 21:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWI0BAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 21:00:45 -0400
Received: from mx1.suse.de ([195.135.220.2]:26804 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932189AbWI0BAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 21:00:44 -0400
Date: Tue, 26 Sep 2006 18:00:46 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI patches for 2.6.18
Message-ID: <20060927010046.GA9134@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI patches for 2.6.18.  Big things here include the MSI rework,
the PCI express error handling framework, and some other pci hotplug driver
changes to handle new hardware.

All of these patches have been in the -mm tree for a bit.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/pcieaer-howto.txt             |  253 +++++++++
 arch/ia64/pci/pci.c                         |    3 
 arch/powerpc/sysdev/mpic.c                  |    2 
 drivers/infiniband/hw/ipath/ipath_iba6110.c |    5 
 drivers/pci/bus.c                           |   22 +
 drivers/pci/hotplug/acpiphp.h               |    5 
 drivers/pci/hotplug/acpiphp_glue.c          |  127 ++++-
 drivers/pci/hotplug/fakephp.c               |   18 -
 drivers/pci/hotplug/pci_hotplug.h           |    4 
 drivers/pci/hotplug/pci_hotplug_core.c      |  157 ++++--
 drivers/pci/hotplug/pciehp_ctrl.c           |   12 
 drivers/pci/hotplug/pcihp_skeleton.c        |    9 
 drivers/pci/hotplug/shpchp.h                |    2 
 drivers/pci/hotplug/shpchp_core.c           |    6 
 drivers/pci/hotplug/shpchp_sysfs.c          |    4 
 drivers/pci/msi.c                           |   51 +-
 drivers/pci/pci-driver.c                    |   11 
 drivers/pci/pci-sysfs.c                     |  153 ++++-
 drivers/pci/pci.c                           |   50 ++
 drivers/pci/pci.h                           |    2 
 drivers/pci/pcie/Kconfig                    |    1 
 drivers/pci/pcie/Makefile                   |    3 
 drivers/pci/pcie/aer/Kconfig                |   12 
 drivers/pci/pcie/aer/Makefile               |    8 
 drivers/pci/pcie/aer/aerdrv.c               |  346 ++++++++++++
 drivers/pci/pcie/aer/aerdrv.h               |  125 ++++
 drivers/pci/pcie/aer/aerdrv_acpi.c          |   68 ++
 drivers/pci/pcie/aer/aerdrv_core.c          |  758 +++++++++++++++++++++++++++
 drivers/pci/pcie/aer/aerdrv_errprint.c      |  248 +++++++++
 drivers/pci/pcie/portdrv.h                  |    2 
 drivers/pci/pcie/portdrv_bus.c              |    1 
 drivers/pci/pcie/portdrv_core.c             |   11 
 drivers/pci/pcie/portdrv_pci.c              |  211 +++++++-
 drivers/pci/probe.c                         |   16 -
 drivers/pci/quirks.c                        |  104 +++-
 drivers/pci/remove.c                        |   37 +
 drivers/pci/setup-bus.c                     |   13 
 include/linux/aer.h                         |   24 +
 include/linux/pci.h                         |    5 
 include/linux/pci_ids.h                     |    1 
 include/linux/pci_regs.h                    |    2 
 include/linux/pcieport_if.h                 |    6 
 kernel/resource.c                           |   32 +
 43 files changed, 2719 insertions(+), 211 deletions(-)
 create mode 100644 Documentation/pcieaer-howto.txt
 create mode 100644 drivers/pci/pcie/aer/Kconfig
 create mode 100644 drivers/pci/pcie/aer/Makefile
 create mode 100644 drivers/pci/pcie/aer/aerdrv.c
 create mode 100644 drivers/pci/pcie/aer/aerdrv.h
 create mode 100644 drivers/pci/pcie/aer/aerdrv_acpi.c
 create mode 100644 drivers/pci/pcie/aer/aerdrv_core.c
 create mode 100644 drivers/pci/pcie/aer/aerdrv_errprint.c
 create mode 100644 include/linux/aer.h

---------------

Adrian Bunk:
      PCI: drivers/pci/hotplug/acpiphp_glue.c: make a function static

Alan Cox:
      PCI: Multiprobe sanitizer

Brice Goglin:
      MSI: Cleanup existing MSI quirks
      MSI: Factorize common code in pci_msi_supported()
      MSI: Export the PCI_BUS_FLAGS_NO_MSI flag in sysfs
      MSI: Rename PCI_CAP_ID_HT_IRQCONF into PCI_CAP_ID_HT
      MSI: Blacklist PCI-E chipsets depending on Hypertransport MSI capability

Greg Kroah-Hartman:
      SHPCHP: fix __must_check warnings
      PCI Hotplug: fix __must_check warnings
      PCI: fix __must_check warnings

Kenji Kaneshige:
      pciehp - fix wrong return value

Matthew Wilcox:
      Resources: insert identical resources above existing resources

Michael S. Tsirkin:
      PCI: Restore PCI Express capability registers after PM event

Randy Dunlap:
      PCIE: check and return bus_register errors

Satoru Takeuchi:
      PCI Hotplug: cleanup pcihp skeleton code.
      acpiphp: set hpp values before starting devices
      acpiphp: initialize ioapics before starting devices
      acpiphp: do not initialize existing ioapics
      PCI: add pci_stop_bus_device
      acpiphp: stop bus device before acpi_bus_trim
      acpiphp: disable bridges
      PCI: assign ioapic resource at hotplug
      acpiphp: add support for ioapic hot-remove
      IA64: PCI: dont disable irq which is not enabled

Zhang, Yanmin:
      PCI-Express AER implemetation: aer howto document
      PCI-Express AER implemetation: export pcie_port_bus_type
      PCI-Express AER implemetation: AER core and aerdriver
      PCI-Express AER implemetation: pcie_portdrv error handler

