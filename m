Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWAIUhz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWAIUhz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWAIUhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:37:55 -0500
Received: from mail.kroah.org ([69.55.234.183]:35276 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751326AbWAIUhy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:37:54 -0500
Date: Mon, 9 Jan 2006 12:37:11 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [GIT PATCH] PCI patches for 2.6.15 - retry
Message-ID: <20060109203711.GA25023@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI patches against your latest git tree.  They have all
been in the -mm tree for a while with no problems.  I've pulled out all
of the offending patches that people objected to, or ones that crashed
older machines from the last series I sent you.

The thing that touches so many different files are the change from the
pci_module_init() to pci_register_driver() that was done by Richard
Knutsson.  Other big stuff is the addition of the pci error recovery
framework, after many different revisions and reworks.
There are also some pci hotplug fixes, and quirks added.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/pci-2.6.git/

The full patches will be sent to the linux-pci mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/filesystems/sysfs-pci.txt      |   21 +-
 Documentation/pci-error-recovery.txt         |  246 +++++++++++++++++++++++++++
 MAINTAINERS                                  |    7 
 arch/alpha/kernel/sys_alcor.c                |    3 
 arch/alpha/kernel/sys_sio.c                  |    6 
 arch/frv/mb93090-mb00/pci-frv.c              |    8 
 arch/frv/mb93090-mb00/pci-irq.c              |    4 
 arch/i386/kernel/scx200.c                    |    2 
 arch/i386/pci/acpi.c                         |    2 
 arch/i386/pci/fixup.c                        |    7 
 arch/i386/pci/irq.c                          |   42 ++--
 arch/mips/vr41xx/common/vrc4173.c            |    2 
 arch/ppc/kernel/pci.c                        |   21 +-
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |   11 -
 arch/sparc64/kernel/ebus.c                   |   15 -
 drivers/acpi/pci_irq.c                       |    7 
 drivers/block/DAC960.c                       |    2 
 drivers/block/cciss.c                        |    2 
 drivers/block/sx8.c                          |    2 
 drivers/block/umem.c                         |    2 
 drivers/hwmon/vt8231.c                       |    2 
 drivers/media/radio/radio-gemtek-pci.c       |    2 
 drivers/media/radio/radio-maxiradio.c        |    2 
 drivers/media/video/bttv-driver.c            |    2 
 drivers/media/video/saa7134/saa7134-core.c   |    2 
 drivers/parport/parport_serial.c             |    2 
 drivers/pci/hotplug/acpiphp_glue.c           |    6 
 drivers/pci/hotplug/cpqphp.h                 |    8 
 drivers/pci/hotplug/cpqphp_core.c            |  127 +++++++------
 drivers/pci/hotplug/cpqphp_ctrl.c            |   28 ---
 drivers/pci/hotplug/cpqphp_sysfs.c           |  138 ++++++++++++---
 drivers/pci/hotplug/ibmphp_pci.c             |    2 
 drivers/pci/hotplug/pciehp_core.c            |   92 +++++-----
 drivers/pci/hotplug/pciehp_hpc.c             |   19 +-
 drivers/pci/hotplug/pciehp_pci.c             |   52 +++--
 drivers/pci/hotplug/pciehprm_acpi.c          |   13 -
 drivers/pci/hotplug/rpadlpar_core.c          |   27 --
 drivers/pci/hotplug/rpaphp_pci.c             |   47 -----
 drivers/pci/hotplug/shpchp.h                 |    4 
 drivers/pci/hotplug/shpchp_core.c            |   16 +
 drivers/pci/hotplug/shpchp_ctrl.c            |   37 ----
 drivers/pci/hotplug/shpchp_hpc.c             |  138 +++++++++------
 drivers/pci/hotplug/shpchp_pci.c             |   19 +-
 drivers/pci/pci.c                            |    7 
 drivers/pci/pci.h                            |    5 
 drivers/pci/pcie/portdrv_core.c              |    4 
 drivers/pci/probe.c                          |   49 ++++-
 drivers/pci/proc.c                           |    3 
 drivers/pci/quirks.c                         |   26 ++
 drivers/pci/remove.c                         |    3 
 drivers/pcmcia/vrc4173_cardu.c               |    2 
 drivers/serial/serial_txx9.c                 |    2 
 drivers/video/cyblafb.c                      |    1 
 include/linux/pci.h                          |   69 +++++++
 sound/oss/ad1889.c                           |    2 
 sound/oss/btaudio.c                          |    2 
 sound/oss/cmpci.c                            |    2 
 sound/oss/cs4281/cs4281m.c                   |    2 
 sound/oss/cs46xx.c                           |    2 
 sound/oss/emu10k1/main.c                     |    2 
 sound/oss/es1370.c                           |    2 
 sound/oss/es1371.c                           |    2 
 sound/oss/ite8172.c                          |    2 
 sound/oss/kahlua.c                           |    2 
 sound/oss/maestro.c                          |    2 
 sound/oss/nec_vrc5477.c                      |    2 
 sound/oss/nm256_audio.c                      |    2 
 sound/oss/rme96xx.c                          |    2 
 sound/oss/sonicvibes.c                       |    2 
 sound/oss/ymfpci.c                           |    2 
 70 files changed, 956 insertions(+), 444 deletions(-)

Adrian Bunk:
      PCI Hotplug: cpqphp_ctrl.c: remove dead code
      PCI: drivers/pci: some cleanups

Benjamin Herrenschmidt:
      PCI: Export pci_cfg_space_size

Daniel Marjamäki:
      PCI: irq.c: trivial printk and DBG updates

Daniel Yeisley:
      PCI Quirk: 1K I/O space granularity on Intel P64H2

Dominik Brodowski:
      PCI: use bus numbers sparsely, if necessary

Greg Kroah-Hartman:
      PCI Hotplug: fix up the sysfs file in the compaq pci hotplug driver
      drivers/sound/oss: Replace pci_module_init() with pci_register_driver()

Hanna Linder:
      PCI: arch/i386/pci/acpi.c: use for_each_pci_dev

Jesper Juhl:
      PCI: Reduce nr of ptr derefs in drivers/pci/hotplug/cpqphp_core.c
      PCI: Reduce nr of ptr derefs in drivers/pci/hotplug/rpaphp_pci.c
      PCI: Reduce nr of ptr derefs in drivers/pci/hotplug/pciehp_core.c
      PCI: Reduce nr of ptr derefs in drivers/pci/hotplug/pciehprm_acpi.c

Jesse Barnes:
      PCI: document sysfs rom file interface
      PCI: update Toshiba ohci quirk DMI table

Jiri Slaby:
      PCI: pci_find_device remove (ppc/platforms/85xx/mpc85xx_cds_common.c)
      PCI: pci_find_device remove (alpha/kernel/sys_sio.c)
      PCI: pci_find_device remove (alpha/kernel/sys_alcor.c)
      PCI: pci_find_device remove (ppc/kernel/pci.c)
      PCI: arch: pci_find_device remove (frv/mb93090-mb00/pci-irq.c)
      PCI: pci_find_device remove (frv/mb93090-mb00/pci-frv.c)
      PCI: pci_find_device remove (sparc64/kernel/ebus.c)

Jordan, William P:
      PCI Hotplug: ibmphp_pci.c copy-n-paste fix

Kenji Kaneshige:
      shpchp: fix improper reference to Slot Avail Regsister
      shpchp: fix improper reference to Mode 1 ECC Capability" bit
      shpchp: replace pci_find_slot() with pci_get_slot()
      shpchp: fix improper mmio mapping
      shpchp: fix improper wait for command completion
      shpchp: fix improper write to Command Completion Detect bit
      shpchp: Implement get_address callback

Kristen Accardi:
      pci: use pin stored in pci_dev
      apci: use pin stored in pci_dev
      pci: store PCI_INTERRUPT_PIN in pci_dev
      pci: call pci_read_irq for bridges
      acpiphp: only size new bus

linas:
      PCI Error Recovery: header file patch

linas@austin.ibm.com:
      PCI Hotplug/powerpc: remove duplicated code
      PCI Hotplug/powerpc: more removal of duplicated code
      PCI Error Recovery: documentation

Rajesh Shah:
      pciehp: allow bridged card hotplug

Richard Knutsson:
      arch: Replace pci_module_init() with pci_register_driver()
      drivers/block: Replace pci_module_init() with pci_register_driver()
      drivers/*rest*: Replace pci_module_init() with pci_register_driver()

Sergey Vlasov:
      PCIE: make bus_id for PCI Express devices unique

Thomas Schaefer:
      pciehp: handle sticky power-fault status

