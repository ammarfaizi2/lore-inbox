Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSEFX3k>; Mon, 6 May 2002 19:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315261AbSEFX3j>; Mon, 6 May 2002 19:29:39 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:11278 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315259AbSEFX3h>;
	Mon, 6 May 2002 19:29:37 -0400
Date: Mon, 6 May 2002 15:25:07 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: [BK PATCH] PCI reorg changes for 2.5.14
Message-ID: <20020506222506.GA8718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here is a series of changesets that reorganize the core and i386 PCI
files.  It splits the current big files up into smaller pieces,
according to the different function and platform type (removing lots of
#ifdefs in the process.)  Pat Mochel did 99.9% of this work, and I've
tested it out and forward ported it to your most recent kernel version.

Due to there not being a active PCI maintainer (Martin Mares has
abdicated the maintainership for 2.5 work), would you please apply these
to your tree?

Pull from:  bk://ldm.bkbits.net/linux-2.5-pci


For the non-bitkeeper users, this patch is available against 2.5.14 at:
	kernel.org/pub/linux/kernel/people/gregkh/misc/pci-reorg-2.5.14.patch

thanks,

greg k-h



 arch/i386/kernel/pci-dma.c     |   37 
 arch/i386/kernel/pci-i386.c    |  384 ----------
 arch/i386/kernel/pci-i386.h    |   73 -
 arch/i386/kernel/pci-irq.c     |  866 -----------------------
 arch/i386/kernel/pci-pc.c      | 1423 --------------------------------------
 arch/i386/kernel/pci-visws.c   |  141 ---
 arch/i386/kernel/Makefile      |   18 
 arch/i386/kernel/pci/Makefile  |   29 
 arch/i386/kernel/pci/acpi.c    |   70 +
 arch/i386/kernel/pci/changelog |   62 +
 arch/i386/kernel/pci/common.c  |  206 +++++
 arch/i386/kernel/pci/direct.c  |  366 +++++++++
 arch/i386/kernel/pci/dma.c     |   37 
 arch/i386/kernel/pci/fixup.c   |  163 ++++
 arch/i386/kernel/pci/i386.c    |  323 ++++++++
 arch/i386/kernel/pci/irq.c     |  810 +++++++++++++++++++++
 arch/i386/kernel/pci/legacy.c  |   53 +
 arch/i386/kernel/pci/numa.c    |  119 +++
 arch/i386/kernel/pci/pcbios.c  |  559 +++++++++++++++
 arch/i386/kernel/pci/pci.h     |   75 ++
 arch/i386/kernel/pci/visws.c   |  141 +++
 drivers/acpi/acpi_osl.c        |    3 
 drivers/hotplug/cpqphp_core.c  |    2 
 drivers/hotplug/cpqphp_pci.c   |    2 
 drivers/hotplug/ibmphp_core.c  |    2 
 drivers/pci/Makefile           |    8 
 drivers/pci/access.c           |   46 +
 drivers/pci/hotplug.c          |  132 +++
 drivers/pci/pci-driver.c       |  136 +++
 drivers/pci/pci.c              | 1522 -----------------------------------------
 drivers/pci/pool.c             |  335 +++++++++
 drivers/pci/power.c            |  164 ++++
 drivers/pci/probe.c            |  603 ++++++++++++++++
 drivers/pci/proc.c             |   12 
 drivers/pci/search.c           |  110 ++
 include/linux/pci.h            |    1 
 36 files changed, 4565 insertions(+), 4468 deletions(-)
------

ChangeSet@1.552, 2002-05-06 15:43:42-07:00, greg@kroah.com
  PCI hotplug update 
  
  include file location changed due to pci changes

 drivers/hotplug/cpqphp_core.c |    2 +-
 drivers/hotplug/cpqphp_pci.c  |    2 +-
 drivers/hotplug/ibmphp_core.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.551, 2002-05-06 14:37:30-07:00, greg@kroah.com
  hand merge of davej's x86 pci-pc janitor work

 arch/i386/kernel/pci/direct.c |   10 ++++++----
 arch/i386/kernel/pci/fixup.c  |    2 +-
 arch/i386/kernel/pci/legacy.c |    2 +-
 arch/i386/kernel/pci/pcbios.c |   12 ++++++------
 4 files changed, 14 insertions(+), 12 deletions(-)
------

ChangeSet@1.550, 2002-05-06 14:24:45-07:00, greg@kroah.com
  add back NCR53c810 PCI quirk code from davej that was lost in the merge

 arch/i386/kernel/pci/fixup.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)
------

ChangeSet@1.549, 2002-05-06 14:15:27-07:00, greg@kroah.com
  merge

 arch/i386/kernel/pci-pc.c     | 1423 ------------------------------------------
 arch/i386/kernel/pci/common.c |  206 ++++++
 2 files changed, 206 insertions(+), 1423 deletions(-)
------

ChangeSet@1.447.26.3, 2002-04-16 16:52:54-07:00, mochel@segfault.osdl.org
  Fix NUMA compile after PCI cleanup

 arch/i386/kernel/pci/Makefile |    6 ++++--
 arch/i386/kernel/pci/numa.c   |    7 ++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)
------

ChangeSet@1.447.14.10, 2002-04-16 16:11:33-07:00, mochel@segfault.osdl.org
  don't enable debug in arch/i386/kernel/pci/

 arch/i386/kernel/pci/pci.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.447.14.8, 2002-04-16 13:26:35-07:00, mochel@segfault.osdl.org
  Further break-up-age
  Make ACPI PCI IRQ routing work a bit better...

 arch/i386/kernel/pci/Makefile |   11 ++++-
 arch/i386/kernel/pci/acpi.c   |   70 +++++++++++++++++++++++++++++++++++
 arch/i386/kernel/pci/common.c |   44 ----------------------
 arch/i386/kernel/pci/irq.c    |   82 ++++++------------------------------------
 arch/i386/kernel/pci/legacy.c |   53 +++++++++++++++++++++++++++
 arch/i386/kernel/pci/numa.c   |    4 +-
 arch/i386/kernel/pci/pci.h    |    5 +-
 drivers/acpi/acpi_osl.c       |    3 +
 8 files changed, 152 insertions(+), 120 deletions(-)
------

ChangeSet@1.447.14.7, 2002-04-16 09:03:57-07:00, mochel@segfault.osdl.org
  Further split/cleanup of x86 PCI code

 arch/i386/kernel/pci/Makefile  |   18 
 arch/i386/kernel/pci/changelog |   62 ++
 arch/i386/kernel/pci/common.c  | 1170 -----------------------------------------
 arch/i386/kernel/pci/direct.c  |  364 ++++++++++++
 arch/i386/kernel/pci/fixup.c   |  150 +++++
 arch/i386/kernel/pci/i386.c    |   61 --
 arch/i386/kernel/pci/numa.c    |  114 +++
 arch/i386/kernel/pci/pcbios.c  |  559 +++++++++++++++++++
 arch/i386/kernel/pci/pci.h     |    1 
 drivers/pci/pci.c              |    2 
 include/linux/pci.h            |    1 
 11 files changed, 1271 insertions(+), 1231 deletions(-)
------

ChangeSet@1.447.14.6, 2002-04-15 15:25:54-07:00, mochel@segfault.osdl.org
  Move arch/i386/kernel/pci-*.c to arch/i386/kernel/pci/; prepare for further cleanups

 arch/i386/kernel/pci-dma.c    |   37 -
 arch/i386/kernel/pci-i386.c   |  384 -----------
 arch/i386/kernel/pci-i386.h   |   73 --
 arch/i386/kernel/pci-irq.c    |  866 -------------------------
 arch/i386/kernel/pci-pc.c     | 1400 ------------------------------------------
 arch/i386/kernel/pci-visws.c  |  141 ----
 arch/i386/kernel/Makefile     |   18 
 arch/i386/kernel/pci/Makefile |   16 
 arch/i386/kernel/pci/common.c | 1400 ++++++++++++++++++++++++++++++++++++++++++
 arch/i386/kernel/pci/dma.c    |   37 +
 arch/i386/kernel/pci/i386.c   |  384 +++++++++++
 arch/i386/kernel/pci/irq.c    |  866 +++++++++++++++++++++++++
 arch/i386/kernel/pci/pci.h    |   73 ++
 arch/i386/kernel/pci/visws.c  |  141 ++++
 14 files changed, 2923 insertions(+), 2913 deletions(-)
------

