Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUIXFsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUIXFsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267810AbUIXFpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:45:50 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:13495 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267974AbUIXFng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:43:36 -0400
Date: Fri, 24 Sep 2004 14:45:22 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH] Updated patches for PCI IRQ resource deallocation support [0/3]
To: greg@kroah.com, len.brown@intel.com, tony.luck@intel.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
Message-id: <4153B472.5020109@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Len and Tony,

Here is an updated set of patches for PCI IRQ resource deallocation
based on some feedbacks. This set of patches has the following three
patches:

    - Patch [1/3]: This is for PCI code that has no dependencies. This
      is the latest version (against 2.6.9-rc2-mm1) of the patch
      posted in the other therad. Please see:
      http://marc.theaimsgroup.com/?l=linux-kernel&m=109533945101033&w=2

    - Patch [2/3]: This is for ACPI code that has no dependencies.

    - Patch [3/3]: This is for ia64 code that depends on patch [1/3]
      and patch [2/3].

Patch [3/3] is waiting for the others to be applied, because it
depends on patch [1/3] and patch [2/3].

Greg and Len, could you apply patch [1/3] and patch [2/3] onto each
your tree first?

Thanks,
Kenji Kaneshige

----
Architecture dependent IRQ resources such as interrupt vector for PCI
devices are allocated at pci_enable_device() time on i386, x86-64 and
ia64 platform. Today, however, these IRQ resources are never
deallocated even if they are no longer used. The following set of
patches adds supports to deallocate IRQ resources at
pci_disable_device() time.

The motivation of the set of patches is as follows:

    - IRQ resources such as interrupt vectors should be freed if they
      are no longer used because the amount of these resources are
      limited. By deallocating IRQ resources, we can recycle them.

    - I think some hardwares will support hot-pluggable I/O units with
      I/O xAPICs in the near future. So I/O xAPIC hot-plug support by
      OS will be needed soon. IRQ resouces deallocation will be one of
      the most important stuff for I/O xAPIC hot-plug.

To realize IRQ resource deallocation, the following set of patches
defines new interfaces:

    - void pcibios_disable_device (struct pci_dev *dev)

      This is a opposite portion of pcibios_enable_device(). It's a
      hook to call architecture specific code for deallocating PCI
      resources.
      
    - void acpi_unregister_gsi (int irq)

      This is a opposite portion of acpi_register_gsi(). This has a
      responsibility for deallocating IRQ resources associated with
      the specified linux IRQ number. 

For details of these interfaces, please see the description in each
patch.

The set of patches containes the following patches:

    - add_pcibios_disable_device_hook.patch

      This patch defines new a interface pcibios_disable_device(). It
      has already been posted to LKML before. Please see:
      http://marc.theaimsgroup.com/?l=linux-kernel&m=109533945101033&w=2

    - IRQ_deallocation_acpi.patch

      This is a acpi portion of IRQ resource deallocation. It defines
      a new interface acpi_unregister_gsi().

    - IRQ_deallocation_ia64.patch

      This is a ia64 portion of IRQ resource deallocation. It
      implements pcibios_disable_device() and acpi_unregister_gsi()
      for ia64.

For now, the following set of patches has ia64 implementation only.
i386 and x86_64 implementations are TBD.


