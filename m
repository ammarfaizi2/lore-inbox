Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315975AbSEGVXL>; Tue, 7 May 2002 17:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315976AbSEGVXK>; Tue, 7 May 2002 17:23:10 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:30212 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315975AbSEGVXG>;
	Tue, 7 May 2002 17:23:06 -0400
Date: Tue, 7 May 2002 13:23:17 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, mochel@osdl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] PCI reorg changes for 2.5.14
Message-ID: <20020507202317.GA2180@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0205071124310.1080-100000@home.transmeta.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 09 Apr 2002 17:56:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Greg, Pat - this changeset seems to completely break ACPI interrupt
> routing.
> 
> I suspect it's an ordering issue, with the new "pci_lookup_irq" getting
> assigned the wrong value (or the ACPI irq init not being done or
> whatever).
> 
> Please give this a good look.

Pat found the problem, it was due to the startup ordering issue (he
could give a better explanation than I could), and the update is checked
in.

Pull from:  bk://ldm.bkbits.net/linux-2.5-pci


For the non-bitkeeper users, this patch is available against 2.5.14 at:
        kernel.org/pub/linux/kernel/people/gregkh/misc/pci-reorg-2-2.5.14.patch



 arch/i386/kernel/pci-dma.c    |   37 -
 arch/i386/kernel/pci-i386.c   |  384 ----------
 arch/i386/kernel/pci-i386.h   |   73 --
 arch/i386/kernel/pci-irq.c    |  866 -----------------------
 arch/i386/kernel/pci-pc.c     | 1423 ---------------------------------------
 arch/i386/kernel/pci-visws.c  |  141 ---
 Makefile                      |    2 
 arch/alpha/kernel/pci.c       |    4 
 arch/i386/Makefile            |    5 
 arch/i386/kernel/Makefile     |   12 
 arch/i386/pci/Makefile        |   29 
 arch/i386/pci/acpi.c          |   70 +
 arch/i386/pci/changelog       |   62 +
 arch/i386/pci/common.c        |  206 +++++
 arch/i386/pci/direct.c        |  366 ++++++++++
 arch/i386/pci/dma.c           |   37 +
 arch/i386/pci/fixup.c         |  163 ++++
 arch/i386/pci/i386.c          |  323 ++++++++
 arch/i386/pci/irq.c           |  810 ++++++++++++++++++++++
 arch/i386/pci/legacy.c        |   53 +
 arch/i386/pci/numa.c          |  119 +++
 arch/i386/pci/pcbios.c        |  559 +++++++++++++++
 arch/i386/pci/pci.h           |   75 ++
 arch/i386/pci/visws.c         |  141 +++
 drivers/acpi/acpi_osl.c       |    3 
 drivers/hotplug/cpqphp_core.c |    2 
 drivers/hotplug/cpqphp_pci.c  |    2 
 drivers/hotplug/ibmphp_core.c |    2 
 drivers/pci/Makefile          |    8 
 drivers/pci/access.c          |   46 +
 drivers/pci/hotplug.c         |  132 +++
 drivers/pci/pci-driver.c      |  136 +++
 drivers/pci/pci.c             | 1526 ------------------------------------------
 drivers/pci/pool.c            |  336 +++++++++
 drivers/pci/power.c           |  164 ++++
 drivers/pci/probe.c           |  605 ++++++++++++++++
 drivers/pci/proc.c            |   13 
 drivers/pci/search.c          |  110 +++
 include/linux/pci.h           |    1 
 39 files changed, 4576 insertions(+), 4470 deletions(-)
------

ChangeSet@1.557, 2002-05-07 10:58:20-07:00, greg@kroah.com
  PCI hotplug drivers
  
  change due to moved location of i386's pci.h

 drivers/hotplug/cpqphp_core.c |    2 +-
 drivers/hotplug/cpqphp_pci.c  |    2 +-
 drivers/hotplug/ibmphp_core.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.556, 2002-05-07 10:27:30-07:00, mochel@segfault.osdl.org
  Merge bk://ldm@bkbits.net/linux-2.5-pci
  into segfault.osdl.org:/home/mochel/src/kernel/devel/linux-2.5-pci

 drivers/pci/pci.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.554.1.1, 2002-05-07 10:27:12-07:00, mochel@segfault.osdl.org
  PCI Update: Fix oops on boot w/ ACPI enabled

 Makefile               |    2 +-
 arch/i386/pci/Makefile |    4 ++--
 arch/i386/pci/acpi.c   |    2 +-
 arch/i386/pci/direct.c |    2 +-
 arch/i386/pci/pcbios.c |    2 +-
 drivers/pci/pci.c      |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)
------

ChangeSet@1.555, 2002-05-07 10:19:42-07:00, greg@kroah.com
  merge

 arch/i386/Makefile        |    4 ++--
 arch/i386/kernel/Makefile |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.552.1.1, 2002-05-07 09:54:45-07:00, ink@jurassic.park.msu.ru
  [PATCH] Fix missing #includes
  
  There are missing #includes which will break compilation on some non-x86
  platforms. With following patch this compiles and works on alpha.
  
  Ivan.

 arch/alpha/kernel/pci.c |    4 +++-
 drivers/pci/pci.c       |    2 ++
 drivers/pci/pool.c      |    1 +
 drivers/pci/probe.c     |    2 ++
 drivers/pci/proc.c      |    1 +
 5 files changed, 9 insertions(+), 1 deletion(-)
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

