Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265294AbSKFBdl>; Tue, 5 Nov 2002 20:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265303AbSKFBdl>; Tue, 5 Nov 2002 20:33:41 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:13840 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265294AbSKFBdg>;
	Tue, 5 Nov 2002 20:33:36 -0500
Date: Tue, 5 Nov 2002 17:36:16 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI hotplug changes for 2.5.46
Message-ID: <20021106013615.GQ18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some PCI hotplug driver updates for 2.5.46.  A lot of files are
touched, as some __init pci functions have been fixed to be __devinit,
as the pci hotplug drivers now use them.  Almost all of this work was
done by Scott Murray, who has also added some new cPCI Hotplug drivers.

There is still a warning from the driver core when a pci card is
removed, and I'm working on fixing that up.

Please pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5

thanks,

greg k-h


 CREDITS                             |   11 
 MAINTAINERS                         |   42 +
 arch/alpha/kernel/pci.c             |   16 
 arch/i386/pci/common.c              |    5 
 arch/i386/pci/fixup.c               |    4 
 arch/mips/ddb5074/pci.c             |    4 
 arch/mips/ddb5476/pci.c             |    4 
 arch/mips64/sgi-ip27/ip27-pci.c     |    2 
 arch/mips64/sgi-ip32/ip32-pci.c     |    4 
 arch/parisc/kernel/pci.c            |    2 
 arch/ppc/kernel/pci.c               |    2 
 arch/ppc64/kernel/pci.c             |    4 
 arch/sh/kernel/pci-dc.c             |    2 
 arch/sh/kernel/pci-sh7751.c         |    4 
 arch/sh/kernel/pci_st40.c           |    2 
 arch/sparc64/kernel/pci.c           |    4 
 drivers/hotplug/Kconfig             |   43 +
 drivers/hotplug/Makefile            |    8 
 drivers/hotplug/acpiphp.h           |    8 
 drivers/hotplug/acpiphp_core.c      |  163 +++---
 drivers/hotplug/acpiphp_glue.c      |  187 +++----
 drivers/hotplug/acpiphp_pci.c       |   65 +-
 drivers/hotplug/acpiphp_res.c       |   48 -
 drivers/hotplug/cpci_hotplug.h      |  100 +++
 drivers/hotplug/cpci_hotplug_core.c |  927 ++++++++++++++++++++++++++++++++++++
 drivers/hotplug/cpci_hotplug_pci.c  |  685 ++++++++++++++++++++++++++
 drivers/hotplug/cpcihp_generic.c    |  292 +++++++++++
 drivers/hotplug/cpcihp_zt5550.c     |  306 +++++++++++
 drivers/hotplug/cpcihp_zt5550.h     |   79 +++
 drivers/hotplug/pci_hotplug.h       |    4 
 drivers/hotplug/pci_hotplug_util.c  |   75 ++
 drivers/pci/Makefile                |    7 
 drivers/pci/hotplug.c               |    3 
 drivers/pci/pci.c                   |   98 +++
 drivers/pci/probe.c                 |    6 
 drivers/pci/quirks.c                |   50 -
 drivers/pci/search.c                |   40 +
 drivers/pci/setup-bus.c             |   17 
 include/linux/pci.h                 |   13 
 include/linux/pci_ids.h             |    3 
 40 files changed, 3031 insertions(+), 308 deletions(-)
-----

ChangeSet@1.913, 2002-11-05 16:21:21-08:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/pci_hp-2.5

 MAINTAINERS             |   21 +++++++++++++++++++++
 arch/alpha/kernel/pci.c |   14 ++++++++++++++
 drivers/pci/pci.c       |    5 +++++
 include/linux/pci.h     |    6 ++++++
 4 files changed, 46 insertions(+)
------

ChangeSet@1.875.1.10, 2002-11-03 00:08:36-08:00, t-kouchi@mvf.biglobe.ne.jp
  [PATCH] ACPI PCI hotplug updates
  
  These are updates of the acpiphp driver for 2.5.
    - change debug flag from 'acpiphp_debug' to 'debug' for insmod
    - whitespace cleanup
    - message cleanup

 drivers/hotplug/acpiphp.h      |    8 -
 drivers/hotplug/acpiphp_core.c |  163 ++++++++++++++++++-----------------
 drivers/hotplug/acpiphp_glue.c |  187 +++++++++++++++++++----------------------
 drivers/hotplug/acpiphp_pci.c  |   65 +++++++-------
 drivers/hotplug/acpiphp_res.c  |   48 +++++-----
 5 files changed, 234 insertions(+), 237 deletions(-)
------

ChangeSet@1.875.1.9, 2002-11-03 00:02:17-08:00, jung-ik.lee@intel.com
  [PATCH] Patch: 2.5.45 PCI Fixups for PCI HotPlug
  
  The following patch changes function scopes only but fixes kernel dump on
  Hot-Add of PCI bridge cards.

 arch/i386/pci/fixup.c |    4 ++--
 drivers/pci/quirks.c  |   50 +++++++++++++++++++++++++-------------------------
 2 files changed, 27 insertions(+), 27 deletions(-)
------

ChangeSet@1.875.1.8, 2002-11-02 23:43:53-08:00, greg@kroah.com
  [PATCH] PCI Hotplug: fix compiler warning.

 drivers/hotplug/pci_hotplug_util.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.875.1.7, 2002-11-02 23:40:07-08:00, greg@kroah.com
  [PATCH] PCI Hotplug: removed a compiler warning of a unused variable in the cpcihp_generic driver.

 drivers/hotplug/cpcihp_generic.c |    1 -
 1 files changed, 1 deletion(-)
------

ChangeSet@1.875.1.6, 2002-11-02 23:14:54-08:00, scottm@somanetworks.com
  [PATCH] 2.5.45 CompactPCI driver patch 4/4
  
  This is a patch 4 of 4 of my CompactPCI hotplug core and
  drivers, consisting of the generic port I/O cPCI hotplug driver.
  
  Let me know if the kernel parameter parsing code that's #ifndef MODULE is
  objectionable.  I spent quite a while today testing it, it seems reasonably
  robust.  Without it, this driver would only be useable as a module, which
  I've not figured out how to do with the new kernel configuration stuff.

 CREDITS                          |    2 
 MAINTAINERS                      |    7 
 drivers/hotplug/Kconfig          |   15 ++
 drivers/hotplug/Makefile         |    1 
 drivers/hotplug/cpcihp_generic.c |  291 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 315 insertions(+), 1 deletion(-)
------

ChangeSet@1.875.1.5, 2002-11-02 23:07:09-08:00, scottm@somanetworks.com
  [PATCH] 2.5.45 CompactPCI driver patch 3/4
  
  This is patch 3 of 4 of my CompactPCI hotplug core and
  drivers, consisting of the Ziatech ZT5550 hotplug driver.
  
  The hardware banging code in this driver started its life in the PICMG
  2.12 driver code that MontaVista released at the end of 2001.

 CREDITS                         |    1 
 MAINTAINERS                     |    7 
 drivers/hotplug/Kconfig         |   14 +
 drivers/hotplug/Makefile        |    1 
 drivers/hotplug/cpcihp_zt5550.c |  306 ++++++++++++++++++++++++++++++++++++++++
 drivers/hotplug/cpcihp_zt5550.h |   79 ++++++++++
 include/linux/pci_ids.h         |    3 
 7 files changed, 411 insertions(+)
------

ChangeSet@1.875.1.3, 2002-11-02 22:57:45-08:00, greg@kroah.com
  PCI: move EXPORT_SYMBOL for the pbus functions to the setup-bus.c file.
  
  This fixes a linking error if setup-bus.c isn't compiled into the kernel.

 drivers/pci/Makefile    |    2 +-
 drivers/pci/pci.c       |    2 --
 drivers/pci/setup-bus.c |    3 +++
 3 files changed, 4 insertions(+), 3 deletions(-)
------

ChangeSet@1.875.1.2, 2002-11-02 22:36:38-08:00, scottm@somanetworks.com
  [PATCH] 2.5.45 CompactPCI driver patch 1/4
  
  This is a patch 1 of 4 of my CompactPCI hotplug core and
  drivers, consisting of the required core PCI changes.
  
  The various arch file changes are to change pcibios_fixup_pbus_ranges to
  from __init to __devinit, so that pci_setup_bridge can be safely exported
  from drivers/pci/setup-bus.c.

 arch/alpha/kernel/pci.c         |    2 
 arch/i386/pci/common.c          |    5 ++
 arch/mips/ddb5074/pci.c         |    4 -
 arch/mips/ddb5476/pci.c         |    4 -
 arch/mips64/sgi-ip27/ip27-pci.c |    2 
 arch/mips64/sgi-ip32/ip32-pci.c |    4 -
 arch/parisc/kernel/pci.c        |    2 
 arch/ppc/kernel/pci.c           |    2 
 arch/ppc64/kernel/pci.c         |    4 -
 arch/sh/kernel/pci-dc.c         |    2 
 arch/sh/kernel/pci-sh7751.c     |    4 -
 arch/sh/kernel/pci_st40.c       |    2 
 arch/sparc64/kernel/pci.c       |    4 -
 drivers/pci/pci.c               |   91 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c             |    3 -
 drivers/pci/search.c            |   40 +++++++++++++++++
 drivers/pci/setup-bus.c         |   14 +++---
 include/linux/pci.h             |    7 +++
 18 files changed, 170 insertions(+), 26 deletions(-)
------

ChangeSet@1.875.1.1, 2002-11-02 22:25:32-08:00, rmk@arm.linux.org.uk
  [PATCH] PCI hotplug comment fixes
  
  Fix comments about /sbin/hotplug; pci_insert_device does not call
  /sbin/hotplug.

 drivers/pci/hotplug.c |    3 +--
 drivers/pci/probe.c   |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)
------

