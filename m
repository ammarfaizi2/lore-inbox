Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUIABAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUIABAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 21:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269066AbUIAA4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:56:14 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35233 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266183AbUIAAzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 20:55:05 -0400
Date: Wed, 1 Sep 2004 02:55:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: CONFIG_ACPI totally broken (2.6.9-rc1-mm2)
In-Reply-To: <231570000.1093979338@flay>
Message-ID: <Pine.LNX.4.61.0409010250060.981@scrub.home>
References: <231570000.1093979338@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 31 Aug 2004, Martin J. Bligh wrote:

> scripts/kconfig/mconf arch/i386/Kconfig
> Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_AC
> Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_POWERNOW_K7_ACPI
> Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_POWERNOW_K8_ACPI
> Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_EC
> Warning! Found recursive dependency: ACPI PCI_MMCONFIG ACPI ACPI_PROCESSOR X86_SPEEDSTEP_CENTRINO_ACPI
> Warning! Found recursive dependency: DRM_I830 DRM_I915 DRM_I830

The patch below fixes these warnings. This usage of select is really bad, 
as it made it impossible to just enable PCI_BIOS and PCI_DIRECT without 
turning on ACPI.
I seriously consider to add a timeout after such warnings or even turn 
them into errors, currently they are too easily ignored. :(

bye, Roman

diff -ur linux-2.6.org/arch/i386/Kconfig linux-2.6/arch/i386/Kconfig
--- linux-2.6.org/arch/i386/Kconfig	2004-08-31 21:26:53.000000000 +0200
+++ linux-2.6/arch/i386/Kconfig	2004-09-01 01:35:31.000000000 +0200
@@ -1120,6 +1120,7 @@
 
 config PCI_GOMMCONFIG
 	bool "MMConfig"
+	depends on ACPI
 
 config PCI_GODIRECT
 	bool "Direct"
@@ -1130,20 +1131,14 @@
 endchoice
 
 config PCI_BIOS
-	bool
-	depends on !X86_VISWS && PCI && (PCI_GOBIOS || PCI_GOANY)
-	default y
+	def_bool PCI_GOBIOS || PCI_GOANY
 
 config PCI_DIRECT
-	bool
- 	depends on PCI && ((PCI_GODIRECT || PCI_GOANY) || X86_VISWS)
-	default y
+	def_bool PCI_GODIRECT || PCI_GOANY || X86_VISWS
 
 config PCI_MMCONFIG
-	bool
-	depends on PCI && (PCI_GOMMCONFIG || (PCI_GOANY && ACPI))
-	select ACPI
-	default y
+	def_bool PCI_GOMMCONFIG || PCI_GOANY
+	depends on ACPI
 
 source "drivers/pci/Kconfig"
 
diff -ur linux-2.6.org/drivers/char/drm/Kconfig linux-2.6/drivers/char/drm/Kconfig
--- linux-2.6.org/drivers/char/drm/Kconfig	2004-08-31 21:27:01.000000000 +0200
+++ linux-2.6/drivers/char/drm/Kconfig	2004-09-01 01:45:13.000000000 +0200
@@ -55,9 +55,13 @@
 	  selected, the module will be called i810.  AGP support is required
 	  for this driver to work.
 
+choice
+	prompt "Intel 830M, 845G, 852GM, 855GM, 865G (915G)"
+	depends on DRM && AGP && AGP_INTEL
+	optional
+
 config DRM_I830
-	tristate "Intel 830M, 845G, 852GM, 855GM, 865G"
-	depends on DRM && AGP && AGP_INTEL && !(DRM_I915=y)
+	tristate "Old driver"
 	help
 	  Choose this option if you have a system that has Intel 830M, 845G,
 	  852GM, 855GM or 865G integrated graphics.  If M is selected, the
@@ -67,15 +71,15 @@
 	  or previous releases.
 
 config DRM_I915
-	tristate "Intel 830M, 845G, 852GM, 855GM, 865G, 915G"
-	depends on DRM && AGP && AGP_INTEL && !(DRM_I830=y)
+	tristate "New driver"
 	help
 	  Choose this option if you have a system that has Intel 830M, 845G,
 	  852GM, 855GM 865G or 915G integrated graphics.  If M is selected, the
 	  module will be called i915.  AGP support is required for this driver
 	  to work. This driver should be used for systems running Xorg 6.8 and
 	  XFree86 releases after (but not including 4.4).
-	
+
+endchoice
 
 config DRM_MGA
 	tristate "Matrox g200/g400"
