Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422706AbWCXMKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422706AbWCXMKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWCXMKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:10:12 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:15248 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932607AbWCXMKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:10:10 -0500
Date: Fri, 24 Mar 2006 13:09:57 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] use select for GART_IOMMU to enable AGP
In-Reply-To: <20060323133741.21a72249.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603241233530.16802@scrub.home>
References: <20060323014046.2ca1d9df.akpm@osdl.org> <20060323175822.GA7816@redhat.com>
 <20060323133741.21a72249.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 23 Mar 2006, Andrew Morton wrote:

> We suspect the culprit is git-intelfb, which does
> 
>  config FB_INTEL
>  	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
> -	depends on FB && EXPERIMENTAL && PCI && X86_32
> +	depends on FB && EXPERIMENTAL && PCI && X86
>  	select AGP
>  	select AGP_INTEL
>  	select FB_MODE_HELPERS
> 
> It's rather nasty that this can break the build.
> 
> It also seems plain wrong to me that a "select AGP" can force CONFIG_AGP=y
> into CONFIG_AGP=m.  There's no sense in that.

select and default don't really mix very well, a default is only active if 
nothing else enables the symbol, but select already enables here AGP, so 
the AGP default isn't needed/used anymore.
It's somewhat related to the other default behaviour, without changing 
that I don't see a clean and simple way to change this right now.
The easiest solution is to simply remove the default and let GART_IOMMU 
select AGP too.

bye, Roman




The AGP default doesn't work well with other selects, so use a select for 
GART_IOMMU as well. Remove a redundant default for SWIOTLB as well.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/x86_64/Kconfig      |    5 ++---
 drivers/char/agp/Kconfig |    3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)

Index: linux-2.6-mm/arch/x86_64/Kconfig
===================================================================
--- linux-2.6-mm.orig/arch/x86_64/Kconfig	2006-03-24 01:58:56.000000000 +0100
+++ linux-2.6-mm/arch/x86_64/Kconfig	2006-03-24 12:58:23.000000000 +0100
@@ -389,6 +389,7 @@ config GART_IOMMU
 	bool "K8 GART IOMMU support"
 	default y
 	select SWIOTLB
+	select AGP
 	depends on PCI
 	help
 	  Support for hardware IOMMU in AMD's Opteron/Athlon64 Processors
@@ -414,11 +415,9 @@ config CALGARY_IOMMU
 	  will make the right choice by iteself.
 	  If unsure, say Y.
 
-# need this always enabled with GART_IOMMU for the VIA workaround
+# need this always selected by GART_IOMMU for the VIA workaround
 config SWIOTLB
 	bool
-	default y
-	depends on GART_IOMMU
 
 config X86_MCE
 	bool "Machine check support" if EMBEDDED
Index: linux-2.6-git/drivers/char/agp/Kconfig
===================================================================
--- linux-2.6-git.orig/drivers/char/agp/Kconfig	2006-03-24 01:59:00.000000000 +0100
+++ linux-2.6-git/drivers/char/agp/Kconfig	2006-03-24 12:59:27.000000000 +0100
@@ -1,7 +1,6 @@
 config AGP
-	tristate "/dev/agpgart (AGP Support)" if !GART_IOMMU
+	tristate "/dev/agpgart (AGP Support)"
 	depends on ALPHA || IA64 || PPC || X86
-	default y if GART_IOMMU
 	---help---
 	  AGP (Accelerated Graphics Port) is a bus system mainly used to
 	  connect graphics cards to the rest of the system.
