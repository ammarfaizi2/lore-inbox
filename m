Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSH3WEJ>; Fri, 30 Aug 2002 18:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSH3WEI>; Fri, 30 Aug 2002 18:04:08 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:28435 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317176AbSH3WEF>;
	Fri, 30 Aug 2002 18:04:05 -0400
Date: Fri, 30 Aug 2002 15:07:21 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, hannal@us.ibm.com, colpatch@us.ibm.com
Subject: [BK PATCH] PCI ops cleanups for 2.5.32-bk
Message-ID: <20020830220720.GA10783@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are the pci_ops cleanups that were discussed on lkml last week.  It
removes a lot of code from the arch specific implementation of
pci_*_config* functions, and removes lots of code from the pci_hotplug
core (yes, the pci_hotplug code is still broken, I'm working on that
next...) 

These patches includes fixups for almost all of the different
architecture specific code.  I have a number of patches that I will send
to some of the arch maintainers directly, that are not included in this
bk tree.

I would like to thank Matt Dobson and Hanna Linder for doing lots of
this work.

This series also includes a driverfs pci pool patch from David Brownell
(as long as we are making pci changes...)

Pull from:  http://linuxusb.bkbits.net/pci-2.5

thanks,

greg k-h

 arch/alpha/kernel/core_apecs.c            |  102 ++++-------
 arch/alpha/kernel/core_cia.c              |  101 ++++-------
 arch/alpha/kernel/core_irongate.c         |   81 +--------
 arch/alpha/kernel/core_lca.c              |  100 ++++-------
 arch/alpha/kernel/core_polaris.c          |   79 +--------
 arch/alpha/kernel/core_t2.c               |  101 ++++-------
 arch/i386/pci/common.c                    |    3 
 arch/i386/pci/direct.c                    |  193 +++++-----------------
 arch/i386/pci/numa.c                      |   34 +++
 arch/i386/pci/pcbios.c                    |   85 +--------
 arch/ia64/kernel/pci.c                    |   80 +--------
 arch/ia64/sn/io/pci.c                     |  157 ++----------------
 arch/mips/ddb5074/pci.c                   |  219 +++++++++++--------------
 arch/mips/ddb5476/pci.c                   |  215 ++++++++++---------------
 arch/mips/ddb5xxx/ddb5477/pci_ops.c       |  253 ++++++++++++-----------------
 arch/mips/gt64120/common/pci.c            |  258 ++++++++++--------------------
 arch/mips/ite-boards/generic/it8172_pci.c |  133 ++++-----------
 arch/mips/mips-boards/generic/pci.c       |  119 +++----------
 arch/mips/sni/pci.c                       |  124 ++++++--------
 arch/sh/kernel/pci-dc.c                   |  105 +++++-------
 arch/sh/kernel/pci-sh7751.c               |  180 +++++++-------------
 arch/sh/kernel/pci_st40.c                 |  112 ++++---------
 arch/x86_64/pci/direct.c                  |  165 +++----------------
 drivers/hotplug/pci_hotplug_util.c        |  245 ----------------------------
 drivers/pci/access.c                      |   54 ++++--
 drivers/pci/pool.c                        |   76 ++++++++
 drivers/pci/probe.c                       |    1 
 include/asm-i386/pci.h                    |    2 
 include/asm-ia64/pci.h                    |    2 
 include/linux/pci.h                       |   50 ++++-
 30 files changed, 1138 insertions(+), 2291 deletions(-)
-----

ChangeSet@1.553, 2002-08-30 14:56:40-07:00, greg@kroah.com
  PCI: compile time fix for the pci pool patch.

 drivers/pci/pool.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.552, 2002-08-30 14:52:18-07:00, david-b@pacbell.net
  [PATCH] show pci_pool stats in driverfs]
  
  This patch exposes basic allocation statistics for pci pools,
  very much like /proc/slabinfo but applying to DMA-consistent
  memory.  A file "pools" is created in the driverfs directory
  for the relevant pci device when the first pool is created, and
  removed when the last pool is destroyed.
  
  Please merge to 2.5.latest.  If it matters, DaveM said it
  looks fine.  It produces sane output for all the 2.5.30
  USB host controller drivers.

 drivers/pci/pool.c  |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c |    1 
 include/linux/pci.h |    1 
 3 files changed, 76 insertions(+)
------

ChangeSet@1.551, 2002-08-30 14:34:21-07:00, colpatch@us.ibm.com
  [PATCH] Fixed NUMA-Q PCI patch
  
  This patch fixes a bug in NUMA-Q PCI code where the kernel can't find PCI
  devices on any node other than the first.

 arch/i386/pci/numa.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)
------

ChangeSet@1.550, 2002-08-30 14:30:06-07:00, hannal@us.ibm.com
  [PATCH] PCI: sh pci_ops changes
  
  sh pci ops changes

 arch/sh/kernel/pci-dc.c     |  105 ++++++++++---------------
 arch/sh/kernel/pci-sh7751.c |  180 +++++++++++++++-----------------------------
 arch/sh/kernel/pci_st40.c   |  112 ++++++++++-----------------
 3 files changed, 146 insertions(+), 251 deletions(-)
------

ChangeSet@1.549, 2002-08-30 14:29:38-07:00, hannal@us.ibm.com
  [PATCH] PCI: mips pci_ops changes
  
  mips pci ops changes

 arch/mips/ddb5074/pci.c                   |  219 +++++++++++--------------
 arch/mips/ddb5476/pci.c                   |  215 ++++++++++---------------
 arch/mips/ddb5xxx/ddb5477/pci_ops.c       |  253 ++++++++++++-----------------
 arch/mips/gt64120/common/pci.c            |  258 ++++++++++--------------------
 arch/mips/ite-boards/generic/it8172_pci.c |  133 ++++-----------
 arch/mips/mips-boards/generic/pci.c       |  119 +++----------
 arch/mips/sni/pci.c                       |  124 ++++++--------
 7 files changed, 511 insertions(+), 810 deletions(-)
------

ChangeSet@1.548, 2002-08-30 14:29:11-07:00, hannal@us.ibm.com
  [PATCH] PCI: ia64 pci_ops changes
  
  ia64 pci ops changes

 arch/ia64/kernel/pci.c |   80 +++---------------------
 arch/ia64/sn/io/pci.c  |  157 +++++--------------------------------------------
 include/asm-ia64/pci.h |    2 
 3 files changed, 28 insertions(+), 211 deletions(-)
------

ChangeSet@1.547, 2002-08-30 14:28:47-07:00, greg@kroah.com
  [PATCH] PCI: alpha pci_ops changes
  
  pci_ops update for most of the alpha ports.

 arch/alpha/kernel/core_apecs.c    |  102 ++++++++++++++------------------------
 arch/alpha/kernel/core_cia.c      |  101 +++++++++++++++----------------------
 arch/alpha/kernel/core_irongate.c |   81 ++++--------------------------
 arch/alpha/kernel/core_lca.c      |  100 +++++++++++++++----------------------
 arch/alpha/kernel/core_polaris.c  |   79 ++++-------------------------
 arch/alpha/kernel/core_t2.c       |  101 ++++++++++++++-----------------------
 6 files changed, 184 insertions(+), 380 deletions(-)
------

ChangeSet@1.546, 2002-08-30 14:28:21-07:00, greg@kroah.com
  [PATCH] PCI: x86-64 pci_ops changes
  
  x86-64 pci changes

 arch/x86_64/pci/direct.c |  165 +++++++++--------------------------------------
 1 files changed, 33 insertions(+), 132 deletions(-)
------

ChangeSet@1.545, 2002-08-30 14:27:56-07:00, greg@kroah.com
  [PATCH] PCI Hotplug: removed the pci_*_nodev functions
  
  removed the pci_*_nodev functions, as the pci_bus_* functions should be used instead.

 drivers/hotplug/pci_hotplug_util.c |  245 -------------------------------------
 1 files changed, 245 deletions(-)
------

ChangeSet@1.544, 2002-08-30 14:27:34-07:00, greg@kroah.com
  [PATCH] PCI:  add pci_bus_* functions to replace the pci_read_* and pci_write_* functions.
  
  add pci_bus_* functions to replace the pci_read_* and pci_write_* functions.

 arch/i386/pci/direct.c |   28 ++++++++++++++--------------
 arch/i386/pci/pcbios.c |   12 ++++++------
 drivers/pci/access.c   |   22 ++++++++++++----------
 include/linux/pci.h    |   41 +++++++++++++++++++++++++++++++++--------
 4 files changed, 65 insertions(+), 38 deletions(-)
------

ChangeSet@1.543, 2002-08-30 14:27:12-07:00, colpatch@us.ibm.com
  [PATCH] PCI Cleanup
  
  The patch removes the pci_confN_(read|write)_config_(byte|word|dword) mess and
  pares it down to pci_confN_(read|write).  This change is reflected in the
  pci_ops structure, which only has read and write function pointers rather than
  the byte, word, and dword versions.  These changes happen in the pci_conf(1|2)
  and pci_bios read and write calls.
  
  This patch also removes the pci_config_(read|write) function pointers.  People
  shouldn't be using these (I don't think) and should be using the pci_ops
  structure linked through the pci_dev structure.  These end up calling the same
  functions that the pci_config_(read|write) pointers refer to anyway.

 arch/i386/pci/common.c |    3 
 arch/i386/pci/direct.c |  165 +++++++++----------------------------------------
 arch/i386/pci/pcbios.c |   73 ++-------------------
 drivers/pci/access.c   |   32 ++++++---
 include/asm-i386/pci.h |    2 
 include/linux/pci.h    |    8 --
 6 files changed, 68 insertions(+), 215 deletions(-)
------

