Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTBYBKt>; Mon, 24 Feb 2003 20:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTBYBKt>; Mon, 24 Feb 2003 20:10:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48399 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262780AbTBYBKq>;
	Mon, 24 Feb 2003 20:10:46 -0500
Date: Mon, 24 Feb 2003 17:13:03 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com, scottm@somanetworks.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI hotplug changes for 2.5.63
Message-ID: <20030225011303.GA5182@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some patches that clean up the remove logic a lot for the PCI
hotplug drivers.  The main PCI patches were done by Russell King and
Christoph Hellwig, and then I went and cleaned up the PCI Hotplug
drivers a lot based on their changes.  I also fixed up some exit logic
in the IBM PCI hotplug driver, as it was a mess.

Scott, I modified the cPCI core in order to get it to build and link
properly again, but as I don't have the hardware to test it, you should
probably look over the change and see if I messed anything up or not.
Also, I think you are the last user of the pci_visit structure, make
sure you really need it, otherwise we can get rid of it entirely from
the PCI core.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/pci-2.5

thanks,

greg k-h


 drivers/hotplug/cpqphp_proc.c      |  143 ---------
 drivers/hotplug/Makefile           |    2 
 drivers/hotplug/acpiphp_pci.c      |  191 -------------
 drivers/hotplug/cpci_hotplug_pci.c |   34 --
 drivers/hotplug/cpqphp.h           |   27 -
 drivers/hotplug/cpqphp_core.c      |   18 -
 drivers/hotplug/cpqphp_pci.c       |  204 --------------
 drivers/hotplug/cpqphp_proc.c      |   96 +-----
 drivers/hotplug/cpqphp_sysfs.c     |  143 +++++++++
 drivers/hotplug/ibmphp.h           |    6 
 drivers/hotplug/ibmphp_core.c      |  538 +++++++++----------------------------
 drivers/hotplug/ibmphp_hpc.c       |    2 
 drivers/hotplug/pci_hotplug_core.c |   18 -
 drivers/pci/hotplug.c              |   63 +++-
 drivers/pci/probe.c                |    1 
 include/linux/pci.h                |    4 
 16 files changed, 380 insertions(+), 1110 deletions(-)
-----

ChangeSet@1.1022.1.14, 2003-02-24 16:35:48-08:00, greg@kroah.com
  [PATCH] CPCI core: remove unneeded visit device on unconfigure.
  
  The driver now links properly, but this is untested due to my
  lack of cPCI hardware.

 drivers/hotplug/cpci_hotplug_pci.c |   34 ----------------------------------
 1 files changed, 34 deletions(-)
------

ChangeSet@1.1022.1.13, 2003-02-24 16:33:09-08:00, greg@kroah.com
  [PATCH] PCI: export pci_scan_bus_parented which is needed by the IBM pci hotplug driver.

 drivers/pci/probe.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.1022.1.12, 2003-02-24 16:32:16-08:00, greg@kroah.com
  [PATCH] IBM PCI Hotplug: convert driver to use pci_bus_remove_device()
  
  Also cleaned up a lot of unnecessary bus walking on device startup
  and shutdown.

 drivers/hotplug/ibmphp_core.c |  136 ------------------------------------------
 1 files changed, 3 insertions(+), 133 deletions(-)
------

ChangeSet@1.1022.1.11, 2003-02-24 16:31:00-08:00, greg@kroah.com
  [PATCH] ACPI PCI hotplug: convert to use pci_remove_bus_device()
  
  Also got rid of some unneeded bus walking on device init and shutdown.

 drivers/hotplug/acpiphp_pci.c |  146 ------------------------------------------
 1 files changed, 3 insertions(+), 143 deletions(-)
------

ChangeSet@1.1022.1.10, 2003-02-24 16:30:40-08:00, greg@kroah.com
  [PATCH] Compaq PCI Hotplug: remove unused walk of the device on insertion.

 drivers/hotplug/cpqphp_pci.c |   54 -------------------------------------------
 1 files changed, 54 deletions(-)
------

ChangeSet@1.1022.1.9, 2003-02-24 16:29:53-08:00, greg@kroah.com
  [PATCH] Compaq PCI Hotplug: convert to use pci_remove_bus_device instead of custom code.

 drivers/hotplug/cpqphp_pci.c |  104 +------------------------------------------
 1 files changed, 3 insertions(+), 101 deletions(-)
------

ChangeSet@1.1022.1.8, 2003-02-24 16:28:58-08:00, rmk@arm.linux.org.uk
  [PATCH] PCI: Make hot unplugging of PCI buses work
  
  Here's the updated patch:
  
  - Scott spotted a leak my handling of procfs wrt buses.
  - I've also killed pci_remove_device() entirely - it is now inlined.
  - After one of Alan's mails, I decided that pci_remove_behind_bridge()
    is a much better name than pci_remove_all_bus_devices()

 drivers/pci/hotplug.c |   63 ++++++++++++++++++++++++++++++++++++++++++++------
 include/linux/pci.h   |    3 +-
 2 files changed, 58 insertions(+), 8 deletions(-)
------

ChangeSet@1.1022.1.7, 2003-02-24 16:27:59-08:00, hch@lst.de
  [PATCH] PCI: remove check_region abuse (and code duplication) from pci hp code
  
  We have a function pci_dev_driver() to check whether a pci_dev has an
  driver attached to it.  It's handling of legacy devices is a bit simpler
  than what the hotplug code did (duplicated in various places), but if
  that stuff is really needed the generic code should be updated.

 drivers/hotplug/acpiphp_pci.c |   45 +----------------------------------------
 drivers/hotplug/cpqphp_pci.c  |   46 +-----------------------------------------
 drivers/hotplug/ibmphp_core.c |   37 +--------------------------------
 include/linux/pci.h           |    1 
 4 files changed, 6 insertions(+), 123 deletions(-)
------

ChangeSet@1.1022.1.6, 2003-02-24 16:27:32-08:00, greg@kroah.com
  [PATCH] Compaq PCI Hotplug: rename cpqphp_proc.c to cpqphp_sysfs.c

 drivers/hotplug/cpqphp_proc.c  |  143 -----------------------------------------
 drivers/hotplug/Makefile       |    2 
 drivers/hotplug/cpqphp_sysfs.c |  143 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+), 144 deletions(-)
------

ChangeSet@1.1022.1.5, 2003-02-24 16:26:59-08:00, greg@kroah.com
  [PATCH] Compaq PCI Hotplug: move /proc files to sysfs

 drivers/hotplug/cpqphp.h      |   27 -----------
 drivers/hotplug/cpqphp_core.c |   18 -------
 drivers/hotplug/cpqphp_proc.c |   96 +++++++++---------------------------------
 3 files changed, 25 insertions(+), 116 deletions(-)
------

ChangeSet@1.1022.1.4, 2003-02-24 16:26:14-08:00, greg@kroah.com
  [PATCH] PCI Hotplug: remove the list_lock, as we rely on sysfs to detect any duplicate slot names.

 drivers/hotplug/pci_hotplug_core.c |   18 +-----------------
 1 files changed, 1 insertion(+), 17 deletions(-)
------

ChangeSet@1.1022.1.3, 2003-02-24 16:25:54-08:00, greg@kroah.com
  [PATCH] IBM PCI Hotplug: get rid of unneeded ops structure and surrounding logic.

 drivers/hotplug/ibmphp.h      |    5 ---
 drivers/hotplug/ibmphp_core.c |   69 +++++++++---------------------------------
 2 files changed, 15 insertions(+), 59 deletions(-)
------

ChangeSet@1.1022.1.2, 2003-02-24 16:25:28-08:00, greg@kroah.com
  [PATCH] IBM PCI Hotplug: fix typo in previous patch.

 drivers/hotplug/ibmphp_core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1022.1.1, 2003-02-24 16:24:48-08:00, greg@kroah.com
  [PATCH] IBM PCI Hotplug: Clean up the error handling logic for a number of functions, and fix a locking mess.

Push file://home/greg/linux/BK/pci-2.5 -> file://home/greg/linux/BK/bleed-2.5
 drivers/hotplug/ibmphp.h      |    1 
 drivers/hotplug/ibmphp_core.c |  294 ++++++++++++++++--------------------------
 drivers/hotplug/ibmphp_hpc.c  |    2 
 3 files changed, 120 insertions(+), 177 deletions(-)
------

