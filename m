Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTKBAfh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 19:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTKBAfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 19:35:37 -0500
Received: from SteeleMR-loadb-NAT-49.caltech.edu ([131.215.49.69]:24437 "EHLO
	earth-ox.its.caltech.edu") by vger.kernel.org with ESMTP
	id S261298AbTKBAfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 19:35:13 -0500
Date: Sat, 1 Nov 2003 16:35:11 -0800 (PST)
From: "Noah J. Misch" <noah@caltech.edu>
X-X-Sender: noah@sue
To: linux-ia64@linuxia64.org
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] Clean up Kconfig logic for IA64 ACPI
Message-ID: <Pine.GSO.4.58.0310251706470.15711@inky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I found the Kconfig logic for ACPI and IA64, as defined in arch/ia64/Kconfig and
drivers/acpi/Kconfig to be a bit redundant and hard to follow.  It appears to do
the following:

1) Set ACPI=y, ACPI_INTERPRETER=y, ACPI_EFI=y, and ACPI_KERNEL_CONFIG=y if and
only if not configuring for the HP simulator (arch/ia64/Kconfig).

2) Show the configs in drivers/acpi/Kconfig unless configuring for the HP
simulator (arch/IA64/Kconfig).

3) Set ACPI_BOOT=y under the same conditions as #1 (drivers/acpi/Kconfig).

4) Set ACPI_INTERPRETER=y if and only if !IA64_SGI_SN (drivers/acpi/Kconfig).

5) Automatically set or allow a number of specific ACPI options if
ACPI_INTERPRETER but not IA64_SGI_SN (drivers/acpi/Kconfig).

6) Set ACPI_EFI=y if ACPI_INTERPRETER (drivers/acpi/Kconfig).

There's a fair amount of textual and logical redundancy there, as well as
dependencies on and selections of obsolete options.  This had even caused
compilation failures in certain corner cases.  This patch corrects that:

1) Remove the copies of ACPI, ACPI_INTERPRETER, and ACPI_EFI from
arch/ia64/Kconfig and instead make IA64 select ACPI unless configuring for the
HP simulator.

2) Delete ACPI_KERNEL_CONFIG from arch/ia64/Kconfig.  It no longer affects any
part of the kernel, and it appears as though ACPI_BOOT has fully superseded it.

3) Remove all dependencies in drivers/acpi/Kconfig that reference IA64_SGI_SN.
That option no longer exists, and even if it did, only ACPI_INTERPRETER need
depend on it, and the rest of the options it currently guards would follow suit.

I have compiled a wide variety of IA64 kernels with this patch applied, so I am
fairly confident that it is not introducing new problems.  The patch applies to
linux-2.5 BK and linux-ia64-2.5 BK as of 2003-11-02 at 0000 UTC.

This should not change any user-visible configuration semantics.  Indeed, the
only user-visible change is the visible defaulting of ACPI.  Please let me know
what you think.  I consider this 2.7 material.

Thanks,
Noah

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1296.83.15 -> 1.1296.83.16
#	   arch/ia64/Kconfig	1.46    -> 1.47
#	drivers/acpi/Kconfig	1.26    -> 1.27
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/10/27	noah@caltech.edu	1.1296.83.16
# Merge ACPI Kconfig entries from arch/ia64/Kconfig into drivers/acpi/Kconfig.
# Eliminate references to obsolete ACPI_KERNEL_CONFIG and IA64_SGI_SN config
# variables.  Add help text to ACPI_BOOT, for the benefit of developers
# perusing drivers/acpi/Kconfig.
# --------------------------------------------
#
diff -Nru a/arch/ia64/Kconfig b/arch/ia64/Kconfig
--- a/arch/ia64/Kconfig	Sat Nov  1 14:43:25 2003
+++ b/arch/ia64/Kconfig	Sat Nov  1 14:43:25 2003
@@ -11,6 +11,7 @@

 config IA64
 	bool
+	select ACPI if !IA64_HP_SIM
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
@@ -130,57 +131,6 @@
 	bool "64KB"

 endchoice
-
-config ACPI
-	bool
-	depends on !IA64_HP_SIM
-	default y
-	---help---
-	  ACPI/OSPM support for Linux is currently under development. As such,
-	  this support is preliminary and EXPERIMENTAL.  Configuring ACPI
-	  support enables kernel interfaces that allow higher level software
-	  (OSPM) to manipulate ACPI defined hardware and software interfaces,
-	  including the evaluation of ACPI control methods.  If unsure, choose
-	  N here.  Note, this option will enlarge your kernel by about 120K.
-
-	  This support requires an ACPI compliant platform (hardware/firmware).
-	  If both ACPI and Advanced Power Management (APM) support are
-	  configured, whichever is loaded first shall be used.
-
-	  This code DOES NOT currently provide a complete OSPM implementation
-	  -- it has not yet reached APM's level of functionality.  When fully
-	  implemented, Linux ACPI/OSPM will provide a more robust functional
-	  replacement for legacy configuration and power management
-	  interfaces, including the Plug-and-Play BIOS specification (PnP
-	  BIOS), the Multi-Processor Specification (MPS), and the Advanced
-	  Power Management specification (APM).
-
-	  Linux support for ACPI/OSPM is based on Intel Corporation's ACPI
-	  Component Architecture (ACPI CA). The latest ACPI CA source code,
-	  documentation, debug builds, and implementation status information
-	  can be downloaded from:
-	  <http://developer.intel.com/technology/iapc/acpi/downloads.htm>.
-
-	  The ACPI Sourceforge project may also be of interest:
-	  <http://sf.net/projects/acpi/>
-
-config ACPI_EFI
-	bool
-	depends on !IA64_HP_SIM
-	default y
-
-config ACPI_INTERPRETER
-	bool
-	depends on !IA64_HP_SIM
-	default y
-
-config ACPI_KERNEL_CONFIG
-	bool
-	depends on !IA64_HP_SIM
-	default y
-	help
-	  If you say `Y' here, Linux's ACPI support will use the
-	  hardware-level system descriptions found on IA-64 systems.

 config IA64_BRL_EMU
 	bool
diff -Nru a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig	Sat Nov  1 14:43:25 2003
+++ b/drivers/acpi/Kconfig	Sat Nov  1 14:43:25 2003
@@ -9,7 +9,7 @@

 config ACPI
 	bool "ACPI Support"
-	depends on IA64 || X86
+	depends on IA64 && !IA64_HP_SIM || X86

 	default y
 	---help---
@@ -44,11 +44,15 @@
 	bool
 	depends on ACPI || X86_HT
 	default y
+	help
+	  If you say `Y' here, Linux will read the ACPI tables at boot to
+	  discover system characteristics such as processors, APICs, and
+	  PCI IRQ routing.  This replaces traditional mechanisms for
+	  discovering those properties.

 config ACPI_INTERPRETER
 	bool
 	depends on ACPI
-	depends on !IA64_SGI_SN
 	default y

 config ACPI_SLEEP
@@ -101,7 +105,6 @@
 config ACPI_BUTTON
 	tristate "Button"
 	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
 	default m
 	help
 	  This driver registers for events based on buttons, such as the
@@ -113,7 +116,6 @@
 config ACPI_FAN
 	tristate "Fan"
 	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
 	default m
 	help
 	  This driver adds support for ACPI fan devices, allowing user-mode
@@ -122,7 +124,6 @@
 config ACPI_PROCESSOR
 	tristate "Processor"
 	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
 	default m
 	help
 	  This driver installs ACPI as the idle handler for Linux, and uses
@@ -207,7 +208,6 @@
 config ACPI_DEBUG
 	bool "Debug Statements"
 	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
 	default n
 	help
 	  The ACPI driver can optionally report errors with a great deal
@@ -217,7 +217,6 @@
 config ACPI_BUS
 	bool
 	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
 	default y

 config ACPI_EC
@@ -233,19 +232,16 @@
 config ACPI_POWER
 	bool
 	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
 	default y

 config ACPI_PCI
 	bool
 	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
 	default PCI

 config ACPI_SYSTEM
 	bool
 	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
 	default y
 	help
 	  This driver will enable your system to shut down using ACPI, and
@@ -260,7 +256,6 @@
 config ACPI_RELAXED_AML
 	bool "Relaxed AML"
 	depends on ACPI_INTERPRETER
-	depends on !IA64_SGI_SN
 	default n
 	help
 	  If you say `Y' here, the ACPI interpreter will relax its checking

