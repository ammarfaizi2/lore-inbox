Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTFEBQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 21:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264362AbTFEBQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 21:16:09 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:33022 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264358AbTFEBQE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 21:16:04 -0400
Date: Wed, 4 Jun 2003 18:31:47 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605013147.GA9804@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some PCI and PCI Hotplug changes that are against the latest
2.5.70 bk tree.  They contain the following:
	- dynamic id bug fixes from Matt Domsch
	- move drivers/hotplug/ to drivers/pci/hotplug/  I should have
	  done this originally, and I'm sorry for ignoring everyone who
	  told me about this, you were right :)
	- Because of the PCI Hotplug drivers moving, I was able to remove
	  about 70 lines from include/linux/pci.h, which should speed up
	  everyone's compile time some unmeasurable amount :)
	- Removed some exported PCI core variables and functions that
	  didn't need to be exported (no one was using them.)
	- Next step in the pci device list locking changes, now the pci
	  device's reference count is incremented when the pci driver is
	  probed, and decremented when the driver is done with the
	  device.
	- removed all users of pci_for_each_dev() which was a macro that
	  directly accessed the pci device lists.  This was replaced
	  with a call to pci_find_device() which will be later changed
	  to properly lock access to the pci device lists.
	- Some "hand made" pci functions were removed from the PCI
	  hotplug drivers and now they call the proper PCI core
	  functions.

Because of the pci_for_each_dev() changes, these patches touch a lot of
different files all over the tree, sorry, but it's necessary for us to
get proper pci device locking.

On the plus side, I ended up removing 58 lines of code from the tree :)

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h

p.s. I'll send these as patches in response to this email to lkml for
those who want to see them.


 drivers/hotplug/Kconfig                   |  120 -
 drivers/hotplug/Makefile                  |   44 
 drivers/hotplug/acpiphp.h                 |  262 --
 drivers/hotplug/acpiphp_core.c            |  505 ----
 drivers/hotplug/acpiphp_glue.c            | 1335 ------------
 drivers/hotplug/acpiphp_pci.c             |  510 ----
 drivers/hotplug/acpiphp_res.c             |  699 ------
 drivers/hotplug/cpci_hotplug.h            |  100 
 drivers/hotplug/cpci_hotplug_core.c       |  919 --------
 drivers/hotplug/cpci_hotplug_pci.c        |  647 ------
 drivers/hotplug/cpcihp_generic.c          |  290 --
 drivers/hotplug/cpcihp_zt5550.c           |  306 --
 drivers/hotplug/cpcihp_zt5550.h           |   79 
 drivers/hotplug/cpqphp.h                  |  912 --------
 drivers/hotplug/cpqphp_core.c             | 1541 --------------
 drivers/hotplug/cpqphp_ctrl.c             | 3084 ------------------------------
 drivers/hotplug/cpqphp_nvram.c            |  667 ------
 drivers/hotplug/cpqphp_nvram.h            |   57 
 drivers/hotplug/cpqphp_pci.c              | 1548 ---------------
 drivers/hotplug/cpqphp_sysfs.c            |  143 -
 drivers/hotplug/ibmphp.h                  |  772 -------
 drivers/hotplug/ibmphp_core.c             | 1417 -------------
 drivers/hotplug/ibmphp_ebda.c             | 1228 -----------
 drivers/hotplug/ibmphp_hpc.c              | 1228 -----------
 drivers/hotplug/ibmphp_pci.c              | 1758 -----------------
 drivers/hotplug/ibmphp_res.c              | 2157 --------------------
 drivers/hotplug/pci_hotplug.h             |  146 -
 drivers/hotplug/pci_hotplug_core.c        |  666 ------
 drivers/hotplug/pcihp_skeleton.c          |  432 ----
 arch/alpha/kernel/sys_sio.c               |    4 
 arch/arm/kernel/bios32.c                  |    4 
 arch/i386/Kconfig                         |    2 
 arch/i386/kernel/cpu/cpufreq/gx-suspmod.c |    4 
 arch/i386/pci/i386.c                      |    8 
 arch/i386/pci/irq.c                       |   11 
 arch/ia64/Kconfig                         |    2 
 arch/ia64/hp/common/sba_iommu.c           |    4 
 arch/ia64/sn/io/pci_bus_cvlink.c          |    2 
 arch/ia64/sn/io/pciba.c                   |    8 
 arch/ia64/sn/io/sn2/pci_bus_cvlink.c      |    2 
 arch/m68knommu/Kconfig                    |    2 
 arch/mips/ddb5074/pci.c                   |    8 
 arch/mips/ddb5476/pci.c                   |    8 
 arch/mips/ddb5xxx/ddb5477/pci.c           |    4 
 arch/mips/mips-boards/generic/pci.c       |    4 
 arch/mips/sni/pci.c                       |    4 
 arch/mips64/mips-boards/generic/pci.c     |    4 
 arch/mips64/sgi-ip32/ip32-pci.c           |   10 
 arch/ppc/kernel/pci.c                     |   12 
 arch/ppc/platforms/chrp_pci.c             |    4 
 arch/ppc/platforms/gemini_pci.c           |    4 
 arch/ppc/platforms/pmac_pci.c             |    8 
 arch/ppc/platforms/prep_pci.c             |    7 
 arch/ppc64/Kconfig                        |    9 
 arch/ppc64/kernel/iSeries_pci.c           |    4 
 arch/ppc64/kernel/pSeries_pci.c           |    4 
 arch/ppc64/kernel/pci.c                   |    4 
 arch/ppc64/kernel/pci_dma.c               |    4 
 arch/sh/kernel/pci-sh7751.c               |    8 
 arch/v850/Kconfig                         |    2 
 arch/v850/kernel/rte_mb_a_pci.c           |    4 
 arch/x86_64/Kconfig                       |    2 
 arch/x86_64/kernel/bluesmoke.c            |    4 
 arch/x86_64/kernel/pci-gart.c             |    3 
 arch/x86_64/pci/irq.c                     |   11 
 arch/x86_64/pci/x86-64.c                  |    8 
 drivers/Makefile                          |    1 
 drivers/acpi/pci_irq.c                    |    2 
 drivers/char/agp/amd-k8-agp.c             |    4 
 drivers/char/agp/generic.c                |    8 
 drivers/char/agp/isoch.c                  |    4 
 drivers/char/hw_random.c                  |    4 
 drivers/char/watchdog/amd7xx_tco.c        |    3 
 drivers/char/watchdog/i810-tco.c          |    4 
 drivers/hotplug/acpiphp_glue.c            |   26 
 drivers/hotplug/ibmphp_core.c             |   38 
 drivers/ide/pci/cs5530.c                  |   19 
 drivers/ide/pci/hpt366.c                  |    4 
 drivers/ide/pci/pdc202xx_new.c            |    4 
 drivers/ide/setup-pci.c                   |    4 
 drivers/macintosh/via-pmu.c               |   12 
 drivers/message/fusion/mptbase.c          |    7 
 drivers/message/i2o/i2o_core.c            |   12 
 drivers/net/e100/e100_main.c              |   47 
 drivers/net/e1000/e1000_main.c            |    2 
 drivers/net/ixgb/ixgb_main.c              |    2 
 drivers/parport/parport_pc.c              |    4 
 drivers/pci/Makefile                      |    3 
 drivers/pci/access.c                      |    3 
 drivers/pci/bus.c                         |    3 
 drivers/pci/hotplug.c                     |    8 
 drivers/pci/hotplug/Kconfig               |  120 +
 drivers/pci/hotplug/Makefile              |   44 
 drivers/pci/hotplug/acpiphp.h             |  262 ++
 drivers/pci/hotplug/acpiphp_core.c        |  505 ++++
 drivers/pci/hotplug/acpiphp_glue.c        | 1336 ++++++++++++
 drivers/pci/hotplug/acpiphp_pci.c         |  511 ++++
 drivers/pci/hotplug/acpiphp_res.c         |  699 ++++++
 drivers/pci/hotplug/cpci_hotplug.h        |  100 
 drivers/pci/hotplug/cpci_hotplug_core.c   |  919 ++++++++
 drivers/pci/hotplug/cpci_hotplug_pci.c    |  651 ++++++
 drivers/pci/hotplug/cpcihp_generic.c      |  290 ++
 drivers/pci/hotplug/cpcihp_zt5550.c       |  306 ++
 drivers/pci/hotplug/cpcihp_zt5550.h       |   79 
 drivers/pci/hotplug/cpqphp.h              |  912 ++++++++
 drivers/pci/hotplug/cpqphp_core.c         | 1541 ++++++++++++++
 drivers/pci/hotplug/cpqphp_ctrl.c         | 3084 ++++++++++++++++++++++++++++++
 drivers/pci/hotplug/cpqphp_nvram.c        |  667 ++++++
 drivers/pci/hotplug/cpqphp_nvram.h        |   57 
 drivers/pci/hotplug/cpqphp_pci.c          | 1549 +++++++++++++++
 drivers/pci/hotplug/cpqphp_sysfs.c        |  143 +
 drivers/pci/hotplug/ibmphp.h              |  772 +++++++
 drivers/pci/hotplug/ibmphp_core.c         | 1428 +++++++++++++
 drivers/pci/hotplug/ibmphp_ebda.c         | 1228 +++++++++++
 drivers/pci/hotplug/ibmphp_hpc.c          | 1228 +++++++++++
 drivers/pci/hotplug/ibmphp_pci.c          | 1758 +++++++++++++++++
 drivers/pci/hotplug/ibmphp_res.c          | 2157 ++++++++++++++++++++
 drivers/pci/hotplug/pci_hotplug.h         |  146 +
 drivers/pci/hotplug/pci_hotplug_core.c    |  666 ++++++
 drivers/pci/hotplug/pcihp_skeleton.c      |  432 ++++
 drivers/pci/pci-driver.c                  |   29 
 drivers/pci/pci.c                         |   16 
 drivers/pci/pci.h                         |   56 
 drivers/pci/pool.c                        |    2 
 drivers/pci/probe.c                       |    6 
 drivers/pci/proc.c                        |    5 
 drivers/pci/search.c                      |    4 
 drivers/pci/setup-irq.c                   |    4 
 drivers/pci/setup-res.c                   |    2 
 drivers/pnp/resource.c                    |    4 
 drivers/video/pm2fb.c                     |    4 
 drivers/video/sis/sis_main.c              |  105 -
 include/linux/pci.h                       |   75 
 sound/core/memalloc.c                     |   16 
 sound/oss/esssolo1.c                      |   16 
 sound/oss/maestro.c                       |    8 
 sound/oss/via82cxxx_audio.c               |   11 
 sound/pci/rme9652/hammerfall_mem.c        |   28 
 138 files changed, 23960 insertions(+), 24018 deletions(-)
-----

Greg Kroah-Hartman:
  o PCI: remove usage of pci_for_each_dev() in arch/ppc64/kernel/pci.c
  o PCI: finally remove pci_for_each_dev() now that all users of it are gone
  o PCI: remove usage of pci_for_each_dev() in arch/x86_64/pci/x86-64.c
  o PCI: remove usage of pci_for_each_dev() in arch/x86_64/pci/irq.c
  o PCI: remove usage of pci_for_each_dev() in arch/x86_64/kernel/pci-gart.c
  o PCI: remove usage of pci_for_each_dev() in arch/x86_64/kernel/bluesmoke.c
  o PCI: remove usage of pci_for_each_dev() in arch/v850/kernel/rte_mb_a_pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/sh/kernel/pci-sh7751.c
  o PCI: remove usage of pci_for_each_dev() in arch/ppc64/kernel/pci_dma.c
  o PCI: remove usage of pci_for_each_dev() in arch/ppc64/kernel/pSeries_pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/ppc64/kernel/iSeries_pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/ppc/platforms/prep_pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/ppc/platforms/pmac_pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/ppc/platforms/gemini_pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/ppc/platforms/chrp_pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/ppc/kernel/pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/mips64/sgi-ip32/ip32-pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/mips64/mips-boards/generic/pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/mips/sni/pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/mips/mips-boards/generic/pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/mips/ddb5xxx/ddb5477/pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/mips/ddb5476/pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/mips/ddb5074/pci.c
  o PCI: remove usage of pci_for_each_dev() in arch/ia64/sn/io/sn2/pci_bus_cvlink.c
  o PCI: remove usage of pci_for_each_dev() in arch/ia64/sn/io/pciba.c
  o PCI: remove usage of pci_for_each_dev() in arch/ia64/sn/io/pci_bus_cvlink.c
  o PCI: remove usage of pci_for_each_dev() in arch/ia64/hp/common/sba_iommu.c
  o PCI: remove usage of pci_for_each_dev() in arch/arm/kernel/bios32.c
  o PCI: remove usage of pci_for_each_dev() in arch/alpha/kernel/sys_sio.c
  o PCI: remove usage of pci_for_each_dev() in arch/i386/pci/i386.c
  o PCI: remove usage of pci_for_each_dev() in arch/i386/kernel/cpu/cpufreq/gx-suspmod.c
  o PCI: remove usage of pci_for_each_dev() in arch/i386/pci/irq.c
  o PCI: remove usage of pci_for_each_dev() in drivers/video/sis/sis_main.c
  o PCI: remove usage of pci_for_each_dev() in drivers/video/pm2fb.c
  o PCI: remove usage of pci_for_each_dev() in drivers/pnp/resource.c
  o PCI: remove usage of pci_for_each_dev() in drivers/pci/setup-irq.c
  o PCI: remove usage of pci_for_each_dev() in drivers/pci/search.c
  o PCI: remove usage of pci_for_each_dev() in drivers/pci/proc.c
  o PCI: remove usage of pci_for_each_dev() in drivers/pci/pci.c
  o PCI: remove usage of pci_for_each_dev() in drivers/pci/hotplug/ibmphp_core.c
  o PCI: remove usage of pci_for_each_dev() in drivers/parport/parport_pc.c
  o PCI: remove usage of pci_for_each_dev() in drivers/net/ixgb/ixgb_main.c
  o PCI: remove usage of pci_for_each_dev() in drivers/net/e1000/e1000_main.c
  o PCI: remove usage of pci_for_each_dev() in drivers/net/e100/e100_main.c
  o PCI: remove usage of pci_for_each_dev() in drivers/message/i2o/i2o_core.c
  o PCI: remove usage of pci_for_each_dev() in drivers/message/fusion/mptbase.c
  o PCI: remove usage of pci_for_each_dev() in drivers/macintosh/via-pmu.c
  o PCI: remove usage of pci_for_each_dev() in drivers/ide/setup-pci.c
  o PCI: remove usage of pci_for_each_dev() in drivers/ide/pci/pdc202xx_new.c
  o PCI: remove usage of pci_for_each_dev() in drivers/ide/pci/hp2366.c
  o PCI: remove usage of pci_for_each_dev() in drivers/ide/pci/cs5530.c
  o PCI: remove usage of pci_for_each_dev() in drivers/char/watchdog/i810-tco.c
  o PCI: remove usage of pci_for_each_dev() in drivers/char/watchdog/amd7xx_tco.c
  o PCI: remove usage of pci_for_each_dev() in drivers/char/hw_random.c
  o PCI: remove usage of pci_for_each_dev() in drivers/char/agp/isoch.c
  o PCI: remove usage of pci_for_each_dev() in drivers/char/agp/generic.c
  o PCI: remove usage of pci_for_each_dev() in drivers/char/agp/amd-k8-agp.c
  o PCI: remove usage of pci_for_each_dev() in drivers/acpi/pci_irq.c
  o PCI: remove usage of pci_for_each_dev() in sound/pci/rme9652/hammerfall_mem.c
  o PCI: remove usage of pci_for_each_dev() in sound/oss/via82cxxx_audio.c
  o PCI: remove usage of pci_for_each_dev() in sound/oss/maestro.c
  o PCI: remove usage of pci_for_each_dev() in sound/oss/esssolo1.c
  o PCI: remove usage of pci_for_each_dev() in sound/core/memalloc.c
  o PCI: Grab reference count on pci_dev if the pci driver binds to the device
  o PCI: Move more functions out of include/linux/pci.h that don't need to be there
  o PCI: remove CONFIG_PROC_FS checks in .c files
  o PCI: Remove a lot of PCI core only functions from include/linux/pci.h
  o PCI Hotplug: move drivers/hotplug/* to drivers/pci/hotplug/*
  o IBM PCI hotplug: remove direct access of pci_devices variable
  o IBM PCI hotplug: remove hand made pci_find_bus function
  o ACPI PCI Hotplug: remove hand made pci_find_bus function
  o PCI: make pools_lock and pci_lock static
  o PCI: make pci_setup_device(), pci_alloc_primary_bus() and pci_alloc_primary_bus_parented() static

Matt Domsch:
  o dynids: free dynids on driver unload
  o dynids: use list_add_tail

