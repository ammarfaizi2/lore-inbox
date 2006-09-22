Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWIVG0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWIVG0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWIVG0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:26:34 -0400
Received: from web36714.mail.mud.yahoo.com ([209.191.85.48]:9821 "HELO
	web36714.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750774AbWIVG0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:26:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Iktn9n/c2XO0Ongf359wS09BjWldz79l20GZn16b4mRxOKarJFoZ00yJxu9IEmoONb7OtIr8LUuxjyj/+vPRx5YxsCmmA6nc0hsQxXkFigBhbV6Vz+crC/Y0mrzL3QHBY0nFeeb5P7f6kLsJ6qc5p1rtmTeJpAQWZqXhItlWAOs=  ;
Message-ID: <20060922062632.61792.qmail@web36714.mail.mud.yahoo.com>
Date: Thu, 21 Sep 2006 23:26:32 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: [PATCH 2/2 try 2] [MMC] Driver for TI FlashMedia card reader - Kconfig/Makefile
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, drzeus-list@drzeus.cx, rmk+lkml@arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Alex Dubov <oakad@yahoo.com>
---
 drivers/misc/Kconfig  |   32 ++++++++++++++++++++++++++++++--
 drivers/misc/Makefile |    4 +++-
 drivers/mmc/Kconfig   |   16 ++++++++++++++++
 drivers/mmc/Makefile  |    1 +
 4 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 7fc692a..3df0e7a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -18,7 +18,7 @@ config IBM_ASM
 	  service processor board as a regular serial port. To make use of
 	  this feature serial driver support (CONFIG_SERIAL_8250) must be
 	  enabled.
-	  
+
 	  WARNING: This software may not be supported or function
 	  correctly on your IBM server. Please consult the IBM ServerProven
 	  website <http://www.pc.ibm.com/ww/eserver/xseries/serverproven> for
@@ -28,5 +28,33 @@ config IBM_ASM
 
 	  If unsure, say N.
 
-endmenu
+config TIFM_CORE
+	tristate "TI Flash Media interface support (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+	  If you want support for Texas Instruments(R) Flash Media adapters
+	  you should select this option and then also choose an appropriate
+	  host adapter, such as 'TI Flash Media PCI74xx/PCI76xx host adapter
+	  support', if you have a TI PCI74xx compatible card reader, for
+	  example.
+	  You will also have to select some flash card format drivers. MMC/SD
+	  cards are supported via 'MMC/SD Card support: TI Flash Media MMC/SD
+	  Interface support (MMC_TIFM_SD)'.
+
+          To compile this driver as a module, choose M here: the module will
+	  be called tifm_core.
 
+config TIFM_7XX1
+	tristate "TI Flash Media PCI74xx/PCI76xx host adapter support (EXPERIMENTAL)"
+	depends on PCI && TIFM_CORE && EXPERIMENTAL
+	default TIFM_CORE
+	help
+	  This option enables support for Texas Instruments(R) PCI74xx and
+	  PCI76xx families of Flash Media adapters, found in many laptops.
+	  To make actual use of the device, you will have to select some
+	  flash card format drivers, as outlined in the TIFM_CORE Help.
+
+          To compile this driver as a module, choose M here: the module will
+	  be called tifm_7xx1.
+
+endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 19c2b85..b1a9d90 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -3,5 +3,7 @@ # Makefile for misc devices that really 
 #
 obj- := misc.o	# Dummy rule to force built-in.o to be made
 
-obj-$(CONFIG_IBM_ASM)	+= ibmasm/
+obj-$(CONFIG_IBM_ASM)		+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
+obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
+obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 45bcf09..21a301e 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -109,4 +109,20 @@ config MMC_IMX
 
 	  If unsure, say N.
 
+config MMC_TIFM_SD
+	tristate "TI Flash Media MMC/SD Interface support  (EXPERIMENTAL)"
+	depends on MMC && EXPERIMENTAL
+	select TIFM_CORE
+	help
+	  Say Y here if you want to be able to access MMC/SD cards with
+	  the Texas Instruments(R) Flash Media card reader, found in many
+	  laptops.
+	  This option 'selects' (turns on, enables) 'TIFM_CORE', but you
+	  probably also need appropriate card reader host adapter, such as
+	  'Misc devices: TI Flash Media PCI74xx/PCI76xx host adapter support
+	  (TIFM_7XX1)'.
+
+          To compile this driver as a module, choose M here: the
+	  module will be called tifm_sd.
+
 endmenu
diff --git a/drivers/mmc/Makefile b/drivers/mmc/Makefile
index d2957e3..e937ff6 100644
--- a/drivers/mmc/Makefile
+++ b/drivers/mmc/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
 obj-$(CONFIG_MMC_AU1X)		+= au1xmmc.o
 obj-$(CONFIG_MMC_OMAP)		+= omap.o
 obj-$(CONFIG_MMC_AT91RM9200)	+= at91_mci.o
+obj-$(CONFIG_MMC_TIFM_SD)	+= tifm_sd.o
 
 mmc_core-y := mmc.o mmc_queue.o mmc_sysfs.o
 
-- 
1.4.2.1



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
