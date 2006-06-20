Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965168AbWFTISl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWFTISl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965169AbWFTISl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:18:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965168AbWFTISk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:18:40 -0400
Date: Tue, 20 Jun 2006 01:17:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: torvalds@osdl.org, ak@suse.de, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-git build breakage
Message-Id: <20060620011738.d72147a8.akpm@osdl.org>
In-Reply-To: <4497A871.8000303@garzik.org>
References: <4497A871.8000303@garzik.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 03:49:05 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> On the latest 'git pull', on x86-64 SMP 'make allmodconfig', I get the 
> following build breakage:
> 
> 1) myri10ge: needs iowrite64_copy from -mm

Patch has been sent.

> 2) forcedeth: git tree conflict, Herbert sent a patch
> 
> 3) pci-gart (ouch!) link: no fix seen yet
> 
> [...]
>    LD      init/built-in.o
>    LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o: In function `pci_iommu_init':
> arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_amd64_init'
> arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_bridge'
> arch/x86_64/kernel/pci-gart.c:619: undefined reference to `agp_copy_info'
> make: *** [.tmp_vmlinux1] Error 1

hm.  I could swear we fixed that multiple times, but I don't seem to be
able to locate the patch.

This one, perhaps?

use select for GART_IOMMU to enable AGP

From: Roman Zippel <zippel@linux-m68k.org>

The AGP default doesn't work well with other selects, so use a select for
GART_IOMMU as well.  Remove a redundant default for SWIOTLB as well.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Andi Kleen <ak@muc.de>
Cc: Dave Jones <davej@codemonkey.org.uk>
Cc: Dave Airlie <airlied@linux.ie>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/x86_64/Kconfig      |    5 ++---
 drivers/char/agp/Kconfig |    3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

Index: linux/arch/x86_64/Kconfig
===================================================================
--- linux.orig/arch/x86_64/Kconfig
+++ linux/arch/x86_64/Kconfig
@@ -389,6 +389,7 @@ config GART_IOMMU
 	bool "K8 GART IOMMU support"
 	default y
 	select SWIOTLB
+	select AGP
 	depends on PCI
 	help
 	  Support for hardware IOMMU in AMD's Opteron/Athlon64 Processors
@@ -401,11 +402,9 @@ config GART_IOMMU
   	  northbridge and a software emulation used on other systems without
 	  hardware IOMMU.  If unsure, say Y.
 
-# need this always enabled with GART_IOMMU for the VIA workaround
+# need this always selected by GART_IOMMU for the VIA workaround
 config SWIOTLB
 	bool
-	default y
-	depends on GART_IOMMU
 
 config X86_MCE
 	bool "Machine check support" if EMBEDDED
Index: linux/drivers/char/agp/Kconfig
===================================================================
--- linux.orig/drivers/char/agp/Kconfig
+++ linux/drivers/char/agp/Kconfig
@@ -1,7 +1,6 @@
 config AGP
-	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
+	tristate "/dev/agpgart (AGP Support)"
 	depends on ALPHA || IA64 || PPC || X86
-	default y if GART_IOMMU
 	---help---
 	  AGP (Accelerated Graphics Port) is a bus system mainly used to
 	  connect graphics cards to the rest of the system.

