Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbWGXQtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWGXQtl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWGXQtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:49:41 -0400
Received: from outbound-red.frontbridge.com ([216.148.222.49]:12115 "EHLO
	outbound1-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932213AbWGXQtj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:49:39 -0400
X-BigFish: V
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 2/2] [PATCH] Add a configuration option to avoid
 automatically probing VGA
Date: Mon, 24 Jul 2006 10:53:22 -0600
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blizzard@redhat.com, dwmw2@redhat.com
Message-ID: <20060724165322.18787.91037.stgit@cosmic.amd.com>
In-Reply-To: <20060724165046.18787.23690.stgit@cosmic.amd.com>
References: <20060724165046.18787.23690.stgit@cosmic.amd.com>
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 24 Jul 2006 16:49:20.0341 (UTC)
 FILETIME=[1BF4F050:01C6AF41]
MIME-Version: 1.0
X-WSS-ID: 68DA259A19S652152-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=fixed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jordan.crouse@amd.com>

Some x86 implementations don't have a built in VGA / VESA BIOS.  This
configuration option (enabled when EMBEDDED is selected), allows us to
avoid probing the VGA hardware during boot.  This option also disables
the VGA console option, which depends heavily on the VGA / VESA probing.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 arch/i386/Kconfig             |    9 +++++++++
 arch/i386/boot/setup.S        |    5 +++++
 drivers/video/Kconfig         |    6 +++---
 drivers/video/console/Kconfig |    4 ++--
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index daa75ce..d8935d9 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -735,6 +735,15 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config VGA_NOPROBE
+       bool "Don't probe VGA at boot" if EMBEDDED
+       default n
+       help
+         Saying Y here will cause the kernel to not probe VGA at boot time.
+         This will break everything that depends on the probed screen
+         data.  Say N here unless you are absolutely sure this is what you
+         want.
+
 source kernel/Kconfig.hz
 
 config KEXEC
diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
index d2b684c..d63bd9d 100644
--- a/arch/i386/boot/setup.S
+++ b/arch/i386/boot/setup.S
@@ -394,10 +394,13 @@ # Set the keyboard repeat rate to the ma
 	xorw	%bx, %bx
 	int	$0x16
 
+#ifndef CONFIG_VGA_NOPROBE
+
 # Check for video adapter and its parameters and allow the
 # user to browse video modes.
 	call	video				# NOTE: we need %ds pointing
 						# to bootsector
+#endif
 
 # Get hd0 data...
 	xorw	%ax, %ax
@@ -1006,9 +1009,11 @@ gdt_48:
 	.word	gdt_end - gdt - 1		# gdt limit
 	.word	0, 0				# gdt base (filled in later)
 
+#ifndef CONFIG_VGA_NOPROBE
 # Include video setup & detection code
 
 #include "video.S"
+#endif
 
 # Setup signature -- must be last
 setup_sig1:	.word	SIG1
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6533b0f..21bf515 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -540,7 +540,7 @@ config FB_TGA
 
 config FB_VESA
 	bool "VESA VGA graphics support"
-	depends on (FB = y) && X86
+	depends on (FB = y) && X86 && !VGA_NOPROBE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -828,7 +828,7 @@ config FB_I810_I2C
 
 config FB_INTEL
 	tristate "Intel 830M/845G/852GM/855GM/865G support (EXPERIMENTAL)"
-	depends on FB && EXPERIMENTAL && PCI && X86
+	depends on FB && EXPERIMENTAL && PCI && X86 && !VGA_NOPROBE
 	select AGP
 	select AGP_INTEL
 	select FB_MODE_HELPERS
@@ -1166,7 +1166,7 @@ config FB_SAVAGE_ACCEL
 
 config FB_SIS
 	tristate "SiS/XGI display support"
-	depends on FB && PCI
+	depends on FB && PCI && !VGA_NOPROBE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 4444bef..0be8e3b 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -5,8 +5,8 @@ #
 menu "Console display driver support"
 
 config VGA_CONSOLE
-	bool "VGA text console" if EMBEDDED || !X86
-	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE
+	bool "VGA text console" if (EMBEDDED || !X86)
+	depends on !ARCH_ACORN && !ARCH_EBSA110 && !4xx && !8xx && !SPARC && !M68K && !PARISC && !FRV && !ARCH_VERSATILE && !VGA_NOPROBE
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a


