Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265333AbTBFD6b>; Wed, 5 Feb 2003 22:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbTBFD6b>; Wed, 5 Feb 2003 22:58:31 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:39696 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265333AbTBFD62>;
	Wed, 5 Feb 2003 22:58:28 -0500
Date: Wed, 5 Feb 2003 20:03:41 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI Hotplug changes for 2.5.59
Message-ID: <20030206040341.GA23658@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a series of PCI Hotplug patches, a few related PCI core patches,
and two small, related sysfs patches.

The hotplug driver patches consist of a lot of bug fixes due to problems
found by the smatch and checker projects, and a big patch to remove
pcihpfs and use sysfs instead from Stanley Wang.  I've also moved the
few functions in drivers/hotplug/pci_hotplug_util.c to
drivers/pci/hotplug.c which is a better place for them.

There are some sysfs updates for pci devices from Dan Stekloff and a new
function was added to sysfs to support the move from pcihpfs to sysfs.
This sysfs patch was blessed by Pat Mochel.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/pci_hp-2.5

thanks,

greg k-h


 drivers/hotplug/pci_hotplug_util.c  |  217 ------
 drivers/hotplug/Makefile            |    3 
 drivers/hotplug/acpiphp_glue.c      |    5 
 drivers/hotplug/cpci_hotplug_core.c |    4 
 drivers/hotplug/cpci_hotplug_pci.c  |    2 
 drivers/hotplug/cpqphp_core.c       |    2 
 drivers/hotplug/cpqphp_ctrl.c       |   16 
 drivers/hotplug/cpqphp_nvram.c      |   67 +-
 drivers/hotplug/cpqphp_pci.c        |    4 
 drivers/hotplug/cpqphp_proc.c       |    2 
 drivers/hotplug/ibmphp_core.c       |   10 
 drivers/hotplug/ibmphp_ebda.c       |  209 ++----
 drivers/hotplug/ibmphp_pci.c        |   25 
 drivers/hotplug/pci_hotplug.h       |   43 -
 drivers/hotplug/pci_hotplug_core.c  | 1177 ++++++++----------------------------
 drivers/pci/Makefile                |    3 
 drivers/pci/hotplug.c               |  180 +++++
 drivers/pci/pci-sysfs.c             |   84 ++
 drivers/pci/pci.h                   |    2 
 drivers/pci/proc.c                  |   28 
 fs/sysfs/inode.c                    |   42 +
 include/linux/pci.h                 |   31 
 include/linux/sysfs.h               |    3 
 23 files changed, 773 insertions(+), 1386 deletions(-)
-----

ChangeSet@1.970, 2003-02-06 14:49:36+11:00, greg@kroah.com
  sysfs: remember to add EXPORT_SYMBOL() for sysfs_update_file.

 fs/sysfs/inode.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.947.23.15, 2003-02-06 13:33:46+11:00, greg@kroah.com
  [PATCH] IBM PCI Hotplug: fix a load of memory leak errors found by the checker project.

 drivers/hotplug/ibmphp_ebda.c |  132 ++++++++++++++++++++----------------------
 1 files changed, 65 insertions(+), 67 deletions(-)
------

ChangeSet@1.947.23.14, 2003-02-06 11:23:20+11:00, greg@kroah.com
  [PATCH] IBM PCI Hotplug: fix memory leak found by checker project.

 drivers/hotplug/ibmphp_pci.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.947.23.13, 2003-02-06 11:09:25+11:00, greg@kroah.com
  [PATCH] Compaq PCI Hotplug: fix checker memory leak bugs.

 drivers/hotplug/cpqphp_nvram.c |   67 ++++++++++++++++++++++++-----------------
 1 files changed, 40 insertions(+), 27 deletions(-)
------

ChangeSet@1.947.23.12, 2003-02-06 10:14:04+11:00, randy.dunlap@verizon.net
  [PATCH] PCI Hotplug: memory leaks in acpiphp_glue
  
  Here's the memory leaks patch for acpiphp_glue.c.

 drivers/hotplug/acpiphp_glue.c |    5 +++++
 1 files changed, 5 insertions(+)
------

ChangeSet@1.947.23.11, 2003-02-06 10:04:49+11:00, greg@kroah.com
  [PATCH] PCI:  put proper field sizes on sysfs files, and add class file.

 drivers/pci/pci-sysfs.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)
------

ChangeSet@1.947.23.10, 2003-02-06 10:03:53+11:00, stekloff@w-stekloff.beaverton.ibm.com
  [PATCH] pci patch for sysfs files
  
  The patch is modeled after your method for creating files for usb. It
  makes a single file for pci sysfs files (except for pool, which I haven't
  touched yet). It also exposes more pci information to User Space
  through sysfs. Finally, it removes the dependence on the proc pci code
  for sysfs files.

 drivers/pci/Makefile    |    3 +
 drivers/pci/hotplug.c   |    2 +
 drivers/pci/pci-sysfs.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h       |    2 -
 drivers/pci/proc.c      |   28 ------------------
 5 files changed, 79 insertions(+), 30 deletions(-)
------

ChangeSet@1.947.23.9, 2003-02-05 17:20:29+11:00, rddunlap@osdl.org
  [PATCH] PCI Hotplug: checker patches
  
  Fixes problems found by the CHECKER program in the pci hotplug drivers

 drivers/hotplug/cpqphp_pci.c |    2 +-
 drivers/hotplug/ibmphp_pci.c |   24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)
------

ChangeSet@1.947.23.8, 2003-02-05 17:19:49+11:00, greg@kroah.com
  [PATCH] PCI Hotplug: moved the some stuff into the pci core
  
  Moved functions from drivers/hotplug/pci_hotplug_util.c to
  drivers/pci/hotplug.c, which is a better place for them.

 drivers/hotplug/pci_hotplug_util.c |  217 -------------------------------------
 drivers/hotplug/Makefile           |    3 
 drivers/hotplug/pci_hotplug.h      |   32 -----
 drivers/pci/hotplug.c              |  178 ++++++++++++++++++++++++++++++
 include/linux/pci.h                |   31 +++++
 5 files changed, 208 insertions(+), 253 deletions(-)
------

ChangeSet@1.947.23.7, 2003-02-05 17:19:09+11:00, greg@kroah.com
  [PATCH] PCI Hotplug: Make pci_hp_change_slot_info() work again
  
  Relies on sysfs_update_file() to be present in the kernel.

 drivers/hotplug/pci_hotplug_core.c |  130 +++++++++++++++++++++++++++++++------
 1 files changed, 111 insertions(+), 19 deletions(-)
------

ChangeSet@1.947.23.6, 2003-02-05 17:18:17+11:00, greg@kroah.com
  [PATCH] sysfs: add sysfs_update_file() function.

 fs/sysfs/inode.c      |   41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/sysfs.h |    3 +++
 2 files changed, 44 insertions(+)
------

ChangeSet@1.947.23.5, 2003-02-05 17:17:39+11:00, greg@kroah.com
  [PATCH] PCI Hotplug: change pci_hp_change_slot_info() to take a hotplug_slot and not a string.

 drivers/hotplug/cpci_hotplug_core.c |    4 ++--
 drivers/hotplug/cpqphp_ctrl.c       |    4 +---
 drivers/hotplug/ibmphp_core.c       |    4 +---
 drivers/hotplug/pci_hotplug.h       |    2 +-
 drivers/hotplug/pci_hotplug_core.c  |    6 +++---
 5 files changed, 8 insertions(+), 12 deletions(-)
------

ChangeSet@1.947.23.4, 2003-02-05 17:17:06+11:00, stanley.wang@linux.co.intel.com
  [PATCH] PCI Hotplug: Remove procfs stuff from pci_hotplug_core
  
  Here is a little patch that remove procfs stuff in pci_hotplug_core.c
  Remove /proc entry for pci_hotplug_core.

 drivers/hotplug/pci_hotplug_core.c |   17 -----------------
 1 files changed, 17 deletions(-)
------

ChangeSet@1.947.23.3, 2003-02-05 17:16:30+11:00, stanley.wang@linux.co.intel.com
  [PATCH] PCI Hotplug: Replace pcihpfs with sysfs.

 drivers/hotplug/pci_hotplug.h      |    9 
 drivers/hotplug/pci_hotplug_core.c | 1024 +++++--------------------------------
 2 files changed, 160 insertions(+), 873 deletions(-)
------

ChangeSet@1.947.23.2, 2003-02-05 17:15:55+11:00, greg@kroah.com
  [PATCH] IBM PCI Hotplug driver: Clean up the slot filename generation logic a lot.

 drivers/hotplug/ibmphp_ebda.c |   77 +++---------------------------------------
 1 files changed, 6 insertions(+), 71 deletions(-)
------

ChangeSet@1.947.23.1, 2003-02-05 17:15:13+11:00, greg@kroah.com
  [PATCH] PCI Hotplug: dereference null variable cleanup patches.
  
  These were pointed out by "dan carpenter" <error27@email.com>
  from his smatch tool.

 drivers/hotplug/cpci_hotplug_pci.c |    2 ++
 drivers/hotplug/cpqphp_core.c      |    2 ++
 drivers/hotplug/cpqphp_ctrl.c      |   12 ++++++++++++
 drivers/hotplug/cpqphp_pci.c       |    2 ++
 drivers/hotplug/cpqphp_proc.c      |    2 ++
 drivers/hotplug/ibmphp_core.c      |    6 ++++++
 6 files changed, 26 insertions(+)
------

