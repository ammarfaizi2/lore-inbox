Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318881AbSIIWOj>; Mon, 9 Sep 2002 18:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318886AbSIIWOj>; Mon, 9 Sep 2002 18:14:39 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:10763 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318881AbSIIWOi>;
	Mon, 9 Sep 2002 18:14:38 -0400
Date: Mon, 9 Sep 2002 15:16:27 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [BK PATCH] PCI hotplug changes for 2.5.34
Message-ID: <20020909221627.GE7433@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains the following things:
	- fixes the __FUNCTION__ mess in the Compaq PCI hotplug driver
	- changes the pci core to always call /sbin/hotplug when new
	  devices are found
	- lots of updates to the IBM PCI hotplug driver from Irene
	  Zubarev to work on older IBM machines (and work better on the
	  current machines)
	- fixes to get the drivers working again due to the pci_ops
	  changes.
	  
Pull from:  bk://linuxusb.bkbits.net/pci_hp-2.5

thanks,

greg k-h


 drivers/hotplug/cpqphp.h       |   13 
 drivers/hotplug/cpqphp_core.c  |   72 ++--
 drivers/hotplug/cpqphp_ctrl.c  |  181 ++++++-----
 drivers/hotplug/cpqphp_nvram.c |   11 
 drivers/hotplug/cpqphp_pci.c   |  185 ++++++-----
 drivers/hotplug/cpqphp_proc.c  |   10 
 drivers/hotplug/ibmphp.h       |   41 ++
 drivers/hotplug/ibmphp_core.c  |  294 ++++++++++++------
 drivers/hotplug/ibmphp_ebda.c  |  646 +++++++++++++++++++++++++++++++++--------
 drivers/hotplug/ibmphp_hpc.c   |  260 +++++++++++-----
 drivers/hotplug/ibmphp_pci.c   |  268 +++++++++--------
 drivers/hotplug/ibmphp_res.c   |  333 +++++++++++++--------
 drivers/hotplug/pci_hotplug.h  |   15 
 drivers/pci/Makefile           |    4 
 drivers/pci/hotplug.c          |   22 -
 drivers/pci/probe.c            |    7 
 drivers/pci/proc.c             |    9 
 include/linux/pci.h            |    1 
 18 files changed, 1595 insertions(+), 777 deletions(-)
-----

ChangeSet@1.633, 2002-09-09 15:00:49-07:00, greg@kroah.com
  IBM PCI Hotplug driver: changed calls to pci_*_nodev() to pci_bus_*()

 drivers/hotplug/ibmphp.h      |    3 
 drivers/hotplug/ibmphp_core.c |   67 +++++++------
 drivers/hotplug/ibmphp_pci.c  |  215 ++++++++++++++++++++++--------------------
 drivers/hotplug/ibmphp_res.c  |   33 +++---
 4 files changed, 175 insertions(+), 143 deletions(-)
------

ChangeSet@1.632, 2002-09-09 14:59:11-07:00, greg@kroah.com
  Compaq PCI Hotplug driver: changed calls to pci_*_nodev() to pci_bus_*()

 drivers/hotplug/cpqphp.h       |    6 -
 drivers/hotplug/cpqphp_core.c  |   40 ++++++---
 drivers/hotplug/cpqphp_ctrl.c  |  113 +++++++++++++++-----------
 drivers/hotplug/cpqphp_nvram.c |    9 +-
 drivers/hotplug/cpqphp_pci.c   |  173 ++++++++++++++++++++++-------------------
 drivers/hotplug/cpqphp_proc.c  |   10 +-
 6 files changed, 198 insertions(+), 153 deletions(-)
------

ChangeSet@1.631, 2002-09-09 14:45:40-07:00, greg@kroah.com
  PCI Hotplug: remove pci_*_nodev() prototypes as the functions are gone.
  
  The pci_bus_* functions should be used instead.

 drivers/hotplug/pci_hotplug.h |   15 ---------------
 1 files changed, 15 deletions(-)
------

ChangeSet@1.630, 2002-09-09 14:41:48-07:00, greg@kroah.com
  PCI: export pci_scan_bus() as the IBM PCI Hotplug driver needs it.

 drivers/pci/probe.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.629, 2002-09-09 14:40:30-07:00, zubarev@us.ibm.com
  [PATCH] IBM PCI Hotplug driver update for PCI based controllers
  

 drivers/hotplug/ibmphp.h      |    1 
 drivers/hotplug/ibmphp_core.c |    5 ++
 drivers/hotplug/ibmphp_ebda.c |   71 ++++++++++++++++++++++++++++++++++++++----
 drivers/hotplug/ibmphp_hpc.c  |   26 +++++++++++++++
 4 files changed, 97 insertions(+), 6 deletions(-)
------

ChangeSet@1.628, 2002-09-09 14:39:59-07:00, zubarev@us.ibm.com
  [PATCH] IBM PCI Hotplug driver update for ISA based controllers
  

 drivers/hotplug/ibmphp_ebda.c |   13 ++++++++++---
 drivers/hotplug/ibmphp_hpc.c  |   34 ++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)
------

ChangeSet@1.627, 2002-09-09 14:38:14-07:00, zubarev@us.ibm.com
  [PATCH] IBM PCI Hotplug driver update
  
  - fix polling logic
  - add ability to write [chassis/rxe]#slot# instead of just slot#

 drivers/hotplug/ibmphp.h      |   37 ++
 drivers/hotplug/ibmphp_core.c |  222 +++++++++++-----
 drivers/hotplug/ibmphp_ebda.c |  562 ++++++++++++++++++++++++++++++++++--------
 drivers/hotplug/ibmphp_hpc.c  |  200 +++++++++-----
 drivers/hotplug/ibmphp_pci.c  |   53 ++-
 drivers/hotplug/ibmphp_res.c  |  300 ++++++++++++++--------
 6 files changed, 992 insertions(+), 382 deletions(-)
------

ChangeSet@1.626, 2002-09-09 14:34:37-07:00, greg@kroah.com
  PCI: hotplug core cleanup to get pci hotplug working again
  
  - removed pci_announce_device_to_drivers() prototype as the function is long gone
  - always call /sbin/hotplug when pci devices are added to the system if
    so configured (this includes during the system bring up.)

 drivers/pci/Makefile  |    4 +---
 drivers/pci/hotplug.c |   22 ++++++++++++++--------
 drivers/pci/probe.c   |    6 +++---
 drivers/pci/proc.c    |    9 +++++++++
 include/linux/pci.h   |    1 -
 5 files changed, 27 insertions(+), 15 deletions(-)
------

ChangeSet@1.625, 2002-09-09 14:10:00-07:00, greg@kroah.com
  Compaq PCI Hotplug driver: fixed __FUNCTION__ usages

 drivers/hotplug/cpqphp.h       |    7 ++--
 drivers/hotplug/cpqphp_core.c  |   32 +++++++++----------
 drivers/hotplug/cpqphp_ctrl.c  |   68 ++++++++++++++++++++---------------------
 drivers/hotplug/cpqphp_nvram.c |    2 -
 drivers/hotplug/cpqphp_pci.c   |   12 +++----
 5 files changed, 61 insertions(+), 60 deletions(-)
------

