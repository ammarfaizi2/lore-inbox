Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267904AbUJDKPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267904AbUJDKPt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 06:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267934AbUJDKPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 06:15:49 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:64998 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267904AbUJDKPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 06:15:43 -0400
Date: Mon, 04 Oct 2004 19:17:24 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: take2: [Patch 0/3] Updated patches for PCI IRQ deallocation support
To: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Len Brown <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org
Message-id: <41612334.3070407@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: ja
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ja-JP; rv:1.4)
 Gecko/20030624 Netscape/7.1 (ax)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an updated set of patches for PCI IRQ resource deallocation
based on feedbacks. Change logs are described in each patch. This set
of patches has the following three patches:

    - [Patch 1/3]: This is for PCI code that has no dependencies. This
      patch is already included in 2.6.9-rc3-mm1 tree.

    - [Patch 2/3]: This is for ACPI code that has no dependencies.

    - [Patch 3/3]: This is for ia64 code. This depends on [patch 2/3].

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
      
    - void acpi_unregister_gsi (unsigned int gsi)

      This is a opposite portion of acpi_register_gsi(). This has a
      responsibility for deallocating IRQ resources associated with
      the specified linux IRQ number. 

For details of these interfaces, please see the description in each
patch.

For now, the following set of patches has ia64 implementation only.
i386 and x86_64 implementations are TBD.


