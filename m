Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUH0PPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUH0PPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUH0POE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:14:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29917 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266117AbUH0PLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:11:11 -0400
Message-ID: <412F4EC9.7050003@sgi.com>
Date: Fri, 27 Aug 2004 10:10:01 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Gefre <pfg@sgi.com>
CC: Christoph Hellwig <hch@infradead.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Latest Altix I/O code reorganization code
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com>
In-Reply-To: <411AAABB.8070707@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an update to our last set of patches. I've added some comments from the
last review and another synopsis of the patches. The individual patches will
follow this email.

Comments from the last review:

Christoph Hellwig <hch@infradead.org> wrote:
  >>
  >> The PCIIO_ flags are designed for usage at the Device Driver layer,
  >> while the PCIBR_ flags are designed to be the actual hardware bits that needed
  >> setting.  However, with the latest code, we have deleted the PCIIO_ and
  >> PCIBR_ flags that are not used.
  >
  >
  > There still are tons that are used in the code, but never logically set from
  > the exported interfaces.

Should be gone.


  >> and tries to export
  >> the many hardware features that are available on our system.  However, not
  >> all of these features are "reachable" via the standard Linux PCI mapping
  >> interfaces.  We have removed all unreacheable features.  However, we can
  >> still support future requirements with these new interfaces when needed.
  >>
  >> Yes, we did look at your patch dated: December 4th 2003.  It was very good, but
  >
  >
  > I mean a more recent patch I sent to Colin.

That patch contains xbridge structs which don't belong in our 2.6 code.

  >+xtalk_provider_t hub_provider = {
  >> +
  >> +    (xtalk_intr_alloc_f *) sal_xtalk_intr_alloc,
  >> +    (xtalk_intr_free_f *) sal_xtalk_intr_free,
  >> +
  >> +};
  >> +
  >> +xtalk_provider_t tio_provider = {
  >> +
  >> +    (xtalk_intr_alloc_f *) sal_xtalk_intr_alloc,
  >> +    (xtalk_intr_free_f *) sal_xtalk_intr_free,
  >> +
  >> +};
  >
  >
  > you still have it in this patch.

Should be gone - the last patch was my fault - I had grabbed an older file.

We also flattened our directory structure:

$ ls -R arch/ia64/sn/ioif
arch/ia64/sn/ioif:
io_init.c  iomv.c  Makefile  pci  pci_dma.c  pci_extension.c

arch/ia64/sn/ioif/pci:
Makefile  pcibr_ate.c  pcibr_dma.c  pcibr_provider.c  pcibr_reg.c  xtalk_providers.c

Note the diffstat output - we are purging a lot of code:
   114 files changed, 4679 insertions(+), 46952 deletions(-)

We made some changes to our SAL call interface - once we get ACPI going,
we will remove all these SAL calls. EFI 1.10 and ACPI compliance will
be the next 2 phases in our development.





Patch synopsis:


We have reorganized the I/O layer in the Altix code.

We are posting this code for review before submitting for inclusion in
the 2.6 tree.

The patch set is at: ftp://oss.sgi.com/projects/sn2/sn2-update/

It is based off http://lia64.bkbits.net/linux-ia64-test-2.6.8.1


The general changes are:

I/O discovery and initialization was moved to prom to enable us to move
towards EFI 1.10 and ACPI compliance.  EFI 1.10 and ACPI compliance will
be the next 2 phases in our development.  Since prom is now performing
all I/O discovery and initialization, we had to re-architect the Altix
platform specific code in Linux - basically deleting all code related to
discovery and initialization and leaving DMA mapping which was rewritten.

Until we can implement ACPI in our prom, we will use platform specific
SAL calls to retrieve any PCI configuration that is needed during the
PCI fixup phase.


diffstat of all patches:

   arch/ia64/sn/io/Makefile                       |   13
   arch/ia64/sn/io/cdl.c                          |   79
   arch/ia64/sn/io/drivers/Makefile               |   10
   arch/ia64/sn/io/drivers/ioconfig_bus.c         |  382
   arch/ia64/sn/io/hwgfs/Makefile                 |   10
   arch/ia64/sn/io/hwgfs/hcl.c                    |  702 -
   arch/ia64/sn/io/hwgfs/hcl_util.c               |  175
   arch/ia64/sn/io/hwgfs/interface.c              |  325
   arch/ia64/sn/io/hwgfs/labelcl.c                |  656 -
   arch/ia64/sn/io/hwgfs/ramfs.c                  |  208
   arch/ia64/sn/io/io.c                           |  739 -
   arch/ia64/sn/io/machvec/Makefile               |   10
   arch/ia64/sn/io/machvec/iomv.c                 |   76
   arch/ia64/sn/io/machvec/pci.c                  |   52
   arch/ia64/sn/io/machvec/pci_bus_cvlink.c       |  909 -
   arch/ia64/sn/io/machvec/pci_dma.c              |  677 -
   arch/ia64/sn/io/platform_init/Makefile         |   10
   arch/ia64/sn/io/platform_init/sgi_io_init.c    |  174
   arch/ia64/sn/io/sn2/Makefile                   |   14
   arch/ia64/sn/io/sn2/bte_error.c                |  217
   arch/ia64/sn/io/sn2/geo_op.c                   |  311
   arch/ia64/sn/io/sn2/klconflib.c                |  572
   arch/ia64/sn/io/sn2/klgraph.c                  |  577
   arch/ia64/sn/io/sn2/l1_command.c               |  131
   arch/ia64/sn/io/sn2/ml_SN_init.c               |  109
   arch/ia64/sn/io/sn2/ml_SN_intr.c               |  320
   arch/ia64/sn/io/sn2/ml_iograph.c               |  770 -
   arch/ia64/sn/io/sn2/module.c                   |  236
   arch/ia64/sn/io/sn2/pcibr/Makefile             |   16
   arch/ia64/sn/io/sn2/pcibr/pcibr_ate.c          |  178
   arch/ia64/sn/io/sn2/pcibr/pcibr_config.c       |  195
   arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c          | 2662 ----
   arch/ia64/sn/io/sn2/pcibr/pcibr_error.c        | 1873 ---
   arch/ia64/sn/io/sn2/pcibr/pcibr_hints.c        |  175
   arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c         |  700 -
   arch/ia64/sn/io/sn2/pcibr/pcibr_reg.c          |  879 -
   arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c          |  887 -
   arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c         | 1842 ---
   arch/ia64/sn/io/sn2/pciio.c                    | 1004 -
   arch/ia64/sn/io/sn2/pic.c                      |  835 -
   arch/ia64/sn/io/sn2/shub.c                     |  246
   arch/ia64/sn/io/sn2/shub_intr.c                |  259
   arch/ia64/sn/io/sn2/shuberror.c                |  822 -
   arch/ia64/sn/io/sn2/shubio.c                   |  490
   arch/ia64/sn/io/sn2/xbow.c                     | 1020 -
   arch/ia64/sn/io/sn2/xtalk.c                    |  927 -
   arch/ia64/sn/io/snia_if.c                      |  108
   arch/ia64/sn/io/xswitch.c                      |  168
   include/asm-ia64/sn/pci/bridge.h               | 1895 ---
   include/asm-ia64/sn/pci/pci_bus_cvlink.h       |   70
   include/asm-ia64/sn/pci/pci_defs.h             |  414
   include/asm-ia64/sn/pci/pcibr.h                |  535
   include/asm-ia64/sn/pci/pcibr_private.h        |  811 -
   include/asm-ia64/sn/pci/pciio.h                |  746 -
   include/asm-ia64/sn/pci/pciio_private.h        |  145
   include/asm-ia64/sn/sn2/shub_md.h              |  275
   include/asm-ia64/sn/sn2/shub_mmr_t.h           |14829 -------------------------
   include/asm-ia64/sn/sn2/sn_private.h           |  245
   include/asm-ia64/sn/xtalk/xswitch.h            |   56
   include/asm-ia64/sn/xtalk/xtalk.h              |  360
   include/asm-ia64/sn/xtalk/xtalk_private.h      |   79
   include/asm-ia64/sn/xtalk/xtalkaddrs.h         |  106
   include/asm-ia64/sn/xtalk/xwidget.h            |  240
   arch/ia64/sn/Makefile                          |    2
   arch/ia64/sn/ioif/Makefile                     |   16
   arch/ia64/sn/ioif/io_init.c                    |  438
   arch/ia64/sn/ioif/iomv.c                       |   76
   arch/ia64/sn/ioif/pci/Makefile                 |   12
   arch/ia64/sn/ioif/pci/pcibr_ate.c              |  187
   arch/ia64/sn/ioif/pci/pcibr_dma.c              |  305
   arch/ia64/sn/ioif/pci/pcibr_provider.c         |  225
   arch/ia64/sn/ioif/pci/pcibr_reg.c              |  332
   arch/ia64/sn/ioif/pci/xtalk_providers.c        |   50
   arch/ia64/sn/ioif/pci_dma.c                    |  573
   arch/ia64/sn/ioif/pci_extension.c              |   33
   arch/ia64/sn/kernel/irq.c                      |  436
   arch/ia64/sn/kernel/setup.c                    |  333
   include/asm-ia64/sn/addrs.h                    |   23
   include/asm-ia64/sn/arch.h                     |    5
   include/asm-ia64/sn/geo.h                      |   31
   include/asm-ia64/sn/hcl.h                      |   52
   include/asm-ia64/sn/intr.h                     |    2
   include/asm-ia64/sn/io.h                       |    2
   include/asm-ia64/sn/iograph.h                  |   26
   include/asm-ia64/sn/klconfig.h                 |  208
   include/asm-ia64/sn/ksys/l1.h                  |    4
   include/asm-ia64/sn/module.h                   |   55
   include/asm-ia64/sn/nodepda.h                  |   60
   include/asm-ia64/sn/pci/pcibr_provider.h       |  188
   include/asm-ia64/sn/pci/pcibus_provider_defs.h |  120
   include/asm-ia64/sn/pci/pcidev.h               |   58
   include/asm-ia64/sn/pci/pic.h                  |  360
   include/asm-ia64/sn/pci/tiocp.h                |  256
   include/asm-ia64/sn/pda.h                      |    3
   include/asm-ia64/sn/router.h                   |    7
   include/asm-ia64/sn/sgi.h                      |   23
   include/asm-ia64/sn/sn2/addrs.h                |   58
   include/asm-ia64/sn/sn2/arch.h                 |    3
   include/asm-ia64/sn/sn2/geo.h                  |    7
   include/asm-ia64/sn/sn2/intr.h                 |   29
   include/asm-ia64/sn/sn2/shub.h                 |    3
   include/asm-ia64/sn/sn2/shubio.h               | 1669 +-
   include/asm-ia64/sn/sn2/tio.h                  |   45
   include/asm-ia64/sn/sn_cpuid.h                 |    8
   include/asm-ia64/sn/sn_sal.h                   |   63
   include/asm-ia64/sn/sndrv.h                    |    1
   include/asm-ia64/sn/types.h                    |    2
   include/asm-ia64/sn/xtalk/corelet.h            |   22
   include/asm-ia64/sn/xtalk/hubdev.h             |   61
   include/asm-ia64/sn/xtalk/xbow.h               |  456
   include/asm-ia64/sn/xtalk/xbow_info.h          |    2
   include/asm-ia64/sn/xtalk/xtalk_provider.h     |   52
   include/asm-ia64/sn/xtalk/xtalk_sal.h          |   20
   include/asm-ia64/sn/xtalk/xwidgetdev.h         |   73
   114 files changed, 4679 insertions(+), 46952 deletions(-)


The patches and a short comment for each:

001-kill-files
002-kill-files
003-kill-files
004-kill-files
005-kill-files
#    contains deleted files

006-pci-fixup
#   The io_init.c file replaces the pci_bus_cvlink.c. A diff of the files
#   would not make much sense as the functionalities provided in pci_bus_cvlink.c
#   are no longer needed. The new functions needed are:
#
#        1. Getting Platform Specific Information for PCI Buses/Devices.
#        2. Getting Hardware Workaround Information.
#        3. Getting I/O Hub Information.
#
#   The io_init.c file basically contains all the routines that are needed to
#   allow a PCI Device Driver to perform Interrupts, PIOs and DMAs.

007-pci-support
#   There are some minor changes in these files. The biggest change is that we have
#   broken up the SN Platform Specific DMA mapping interfaces into 3 different
#   routines:
#
#        1.  32Bit Direct Mapping.
#        2.  32Bit PMU Mapping.
#        3.  64Bit Direct Mapping.
#
#   The SN Platform has 3 different PCI/PCIX Bridges. They are not all exactly the
#   same, however they do provide the same functionality. We have abstracted
#   the DMA mapping calls so that the caller will not have to be aware of the
#   hardware differences. Example:
#
#        *dma_handle = (*provider->dmatrans_direct64)(pcidev_info, phys_addr,
#                                  PCIIO_DMA_CMD | PCIIO_DMA_A64);
#
#   The Bus Driver for this card, determines the appropriate method.
#

008-pci-bridge-drivers-new
009-pci-bridge-drivers-kill
010-pci-bridge-drivers-new
#   This set of new files supports 2 of our 3 PCI Bridges, PIC and TIOCP.

011-misc-sources
#   code cleanup
#   ran thru Lindent
#   changes needed for new I/O structure

012-new-includes-pci
013-new-includes-xtalk
#   New includes with definitions for PCI devices, buses, and I/O hubs

014-include-changes
015-include-changes
016-include-changes
017-include-changes
#   code cleanup
#   misc changes needed for new I/O structure

018-new-include-tio
#   New include for TIO defs

019-kill-hwgraph
#   kill the hwgraph code

020-kill-files
#   more file zapping

021-Makefile-cleanup
#   fix upper level Makefile for new directory

022-Makefile-killing
023-pci-include-killing
024-sn2-include-killing
025-new-include-tiocp
026-xtalk-include-killing
#   more file purging - add one new include for tiocp

