Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWFGV2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWFGV2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 17:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWFGV2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 17:28:52 -0400
Received: from xenotime.net ([66.160.160.81]:22177 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932411AbWFGV2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 17:28:52 -0400
Date: Wed, 7 Jun 2006 14:31:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Paul Fulghum <paulkf@microgate.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, khc@pm.waw.pl
Subject: Re: [PATCH] fix generic HDLC synclink mismatch build error
Message-Id: <20060607143138.62855633.rdunlap@xenotime.net>
In-Reply-To: <1149694978.12920.14.camel@amdx2.microgate.com>
References: <1149694978.12920.14.camel@amdx2.microgate.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2006 10:42:58 -0500 Paul Fulghum wrote:

> Fix build errors caused by generic HDLC
> and synclink configuration mismatch. Generic HDLC
> symbols referenced from synclink drivers do not
> resolve if synclink drivers are built-in and generic
> HDLC is modularized.
> 
> kbuild depends statement to demote synclink can't be
> used because generic HDLC support is optional for
> synclink driver

See my new patch below.  All done in Kconfig, no
source file changes needed.  Highly preferable. :)

> kbuild select statement to promote generic HDLC can't
> be used because some kernel developers consider it
> ugly and believe it should never be used
> (so I surrender to the flow)
> 
> The last remaining alternative suppresses inclusion
> of generic HDLC support in the synclink drivers if
> the kernel configuration has synclink built-in and
> generic HDLC modularized.

---
From: Randy Dunlap <rdunlap@xenotime.net>

Fix missing symbol references to hdlc_generic functions.
Switch SYNCLINK drivers from using SELECT to using DEPENDS for HDLC.
However, the DEPENDS values must be restricted to the value
of HDLC (y or m).

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/Kconfig        |    6 +++---
 drivers/char/pcmcia/Kconfig |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2617-rc5mm3.orig/drivers/char/Kconfig
+++ linux-2617-rc5mm3/drivers/char/Kconfig
@@ -197,7 +197,6 @@ config ISI
 config SYNCLINK
 	tristate "SyncLink PCI/ISA support"
 	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
-	select HDLC if SYNCLINK_HDLC
 	help
 	  Driver for SyncLink ISA and PCI synchronous serial adapters.
 	  These adapters are no longer in production and have
@@ -206,6 +205,7 @@ config SYNCLINK
 config SYNCLINK_HDLC
 	bool "Generic HDLC support for SyncLink driver"
 	depends on SYNCLINK
+	depends on HDLC=y || HDLC=SYNCLINK
 	help
 	  Enable generic HDLC support for the SyncLink PCI/ISA driver.
 	  Generic HDLC implements multiple higher layer networking
@@ -214,7 +214,6 @@ config SYNCLINK_HDLC
 config SYNCLINKMP
 	tristate "SyncLink Multiport support"
 	depends on SERIAL_NONSTANDARD && PCI
-	select HDLC if SYNCLINKMP_HDLC
 	help
 	  Driver for SyncLink Multiport (2 or 4 ports) PCI synchronous serial adapter.
 	  These adapters are no longer in production and have
@@ -223,6 +222,7 @@ config SYNCLINKMP
 config SYNCLINKMP_HDLC
 	bool "Generic HDLC support for SyncLink Multiport"
 	depends on SYNCLINKMP
+	depends on HDLC=y || HDLC=SYNCLINKMP
 	help
 	  Enable generic HDLC support for the SyncLink Multiport driver.
 	  Generic HDLC implements multiple higher layer networking
@@ -231,7 +231,6 @@ config SYNCLINKMP_HDLC
 config SYNCLINK_GT
 	tristate "SyncLink GT/AC support"
 	depends on SERIAL_NONSTANDARD && PCI
-	select HDLC if SYNCLINK_GT_HDLC
 	help
 	  Support for SyncLink GT and SyncLink AC families of
 	  synchronous and asynchronous serial adapters
@@ -240,6 +239,7 @@ config SYNCLINK_GT
 config SYNCLINK_GT_HDLC
 	bool "Generic HDLC support for SyncLink GT/AC"
 	depends on SYNCLINK_GT
+	depends on HDLC=y || HDLC=SYNCLINK_GT
 	help
 	  Enable generic HDLC support for the SyncLink GT/AC driver.
 	  Generic HDLC implements multiple higher layer networking
--- linux-2617-rc5mm3.orig/drivers/char/pcmcia/Kconfig
+++ linux-2617-rc5mm3/drivers/char/pcmcia/Kconfig
@@ -8,13 +8,13 @@ menu "PCMCIA character devices"
 config SYNCLINK_CS
 	tristate "SyncLink PC Card support"
 	depends on PCMCIA
-	select HDLC if SYNCLINK_CS_HDLC
 	help
 	  Driver for SyncLink PC Card synchronous serial adapter.
 
 config SYNCLINK_CS_HDLC
 	bool "Generic HDLC support for SyncLink Multiport"
 	depends on SYNCLINK_CS
+	depends on HDLC=y || HDLC=SYNCLINK_CS
 	help
 	  Enable generic HDLC support for the SyncLink PC Card driver.
 	  Generic HDLC implements multiple higher layer networking
