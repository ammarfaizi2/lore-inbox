Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTJAQk3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbTJAQk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:40:29 -0400
Received: from mail.convergence.de ([212.84.236.4]:1257 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262422AbTJAQj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:39:27 -0400
Message-ID: <3F7B0337.3010308@convergence.de>
Date: Wed, 01 Oct 2003 18:39:19 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select for drivers/media
References: <20030928160536.GJ15338@fs.tum.de> <3F774CCC.3040707@convergence.de> <20030928212630.GS15338@fs.tum.de> <20030929173021.GA1762@kroah.com> <3F787A90.7020706@convergence.de> <Pine.LNX.4.44.0309292100430.8124-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0309292100430.8124-100000@serv>
Content-Type: multipart/mixed;
 boundary="------------080303060907070207070203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080303060907070207070203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Roman, Greg, Adrian,

> Please don't use select for something like PCI or NET, if e.g. PCI is not 
> selected no pci driver should be visible or you annoy users which don't 
> have a pci bus, but have to wade through thousands of nonrelevant drivers.

Ok, I understand. Point taken. 8-)

Attached you can find my latest patch: DVB depends on NET && INET again,
the only subsystem that's getting SELECTed is I2C. All dvb drivers 
depend on DVB_CORE instead of DVB now, so the user is forced to select 
the dvb-core, which he'll need anyway.

> bye, Roman

If it's ok like that, I can include this patch within my next patchset.

CU
Michael.

--------------080303060907070207070203
Content-Type: text/plain;
 name="10-DVB-Kconfig-and-Makefile-updates.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="10-DVB-Kconfig-and-Makefile-updates.diff"

- [DVB] split up saa7146 compilation in core part (saa7146.o) and video+vbi part (saa7146_vv). some drivers need both (av7110.c), some drivers only need the core stuff (budget*.c)
- [DVB] add entry for sp887x DVB-T modulator to corresponding Kconfig
- [DVB] use new SELECT facility of Kconfig, first mentioned by Adrian Bunk and Roman Zippel in DVB subsystem
- [DVB] use SELECT in media/video/Kconfig, too.
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/common/Kconfig linux-2.6.0-test6-cvs/drivers/media/common/Kconfig
--- linux-2.6.0-test6/drivers/media/common/Kconfig	2003-10-01 12:25:26.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/common/Kconfig	2003-10-01 12:12:33.000000000 +0200
@@ -1,8 +1,12 @@
 config VIDEO_SAA7146
-	def_tristate DVB_AV7110 || DVB_BUDGET || DVB_BUDGET_AV || \
-		     VIDEO_MXB || VIDEO_DPC || VIDEO_HEXIUM_ORION || \
-		     VIDEO_HEXIUM_GEMINI
-        depends on VIDEO_DEV && PCI && I2C
+        tristate
+	select I2C
+
+config VIDEO_SAA7146_VV
+        tristate
+	select VIDEO_BUF
+	select VIDEO_VIDEOBUF
+	select VIDEO_SAA7146
+
 config VIDEO_VIDEOBUF
-	def_tristate VIDEO_SAA7134 || VIDEO_BT848 || VIDEO_SAA7146
-        depends on VIDEO_DEV
+        tristate
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/common/Makefile linux-2.6.0-test6-cvs/drivers/media/common/Makefile
--- linux-2.6.0-test6/drivers/media/common/Makefile	2003-10-01 12:20:38.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/common/Makefile	2003-09-29 14:08:58.000000000 +0200
@@ -1,5 +1,6 @@
 saa7146-objs    := saa7146_i2c.o saa7146_core.o 
 saa7146_vv-objs := saa7146_vv_ksyms.o saa7146_fops.o saa7146_video.o saa7146_hlp.o saa7146_vbi.o  
 
-obj-$(CONFIG_VIDEO_SAA7146) += saa7146.o saa7146_vv.o
+obj-$(CONFIG_VIDEO_SAA7146) += saa7146.o
+obj-$(CONFIG_VIDEO_SAA7146_VV) += saa7146_vv.o
 
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/Kconfig linux-2.6.0-test6-cvs/drivers/media/dvb/Kconfig
--- linux-2.6.0-test6/drivers/media/dvb/Kconfig	2003-10-01 12:20:38.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/Kconfig	2003-09-30 19:43:56.000000000 +0200
@@ -3,16 +3,16 @@
 #
 
 menu "Digital Video Broadcasting Devices"
-	depends on NET && INET 
 
 config DVB
 	bool "DVB For Linux"
+	depends on NET && INET
 	---help---
 	  Support Digital Video Broadcasting hardware.  Enable this if you 
 	  own a DVB adapter and want to use it or if you compile Linux for 
 	  a digital SetTopBox.
 
-	  API specs and user tools and are available for example from 
+	  API specs and user tools are available from
 	  <http://www.linuxtv.org/>. 
 
 	  Please report problems regarding this driver to the LinuxDVB 
@@ -33,18 +33,16 @@
 source "drivers/media/dvb/frontends/Kconfig"
 
 comment "Supported SAA7146 based PCI Adapters"
-	depends on DVB && PCI
-
+	depends on DVB_CORE && PCI
 source "drivers/media/dvb/ttpci/Kconfig"
 
 comment "Supported USB Adapters"
-	depends on DVB && USB
-
+	depends on DVB_CORE && USB
 source "drivers/media/dvb/ttusb-budget/Kconfig"
 source "drivers/media/dvb/ttusb-dec/Kconfig"
 
 comment "Supported FlexCopII (B2C2) Adapters"
-	depends on DVB && PCI
+	depends on DVB_CORE && PCI
 source "drivers/media/dvb/b2c2/Kconfig"
 
 endmenu
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/dvb-core/Kconfig linux-2.6.0-test6-cvs/drivers/media/dvb/dvb-core/Kconfig
--- linux-2.6.0-test6/drivers/media/dvb/dvb-core/Kconfig	2003-10-01 12:20:38.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/dvb-core/Kconfig	2003-09-29 15:50:51.000000000 +0200
@@ -4,5 +4,8 @@
 	select CRC32
 	help
 	  DVB core utility functions for device handling, software fallbacks etc.
+	  Say Y when you have a DVB card and want to use it. Say Y if your want
+	  to build your drivers outside the kernel, but need the DVB core. All 
+	  in-kernel drivers will select this automatically if needed.
+	  If unsure say N.
 
-	  Say Y when you have a DVB card and want to use it. If unsure say N.
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/dvb-core/Makefile.lib linux-2.6.0-test6-cvs/drivers/media/dvb/dvb-core/Makefile.lib
--- linux-2.6.0-test6/drivers/media/dvb/dvb-core/Makefile.lib	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/dvb-core/Makefile.lib	2002-11-08 18:13:22.000000000 +0100
@@ -0,0 +1 @@
+obj-$(CONFIG_DVB_CORE)		+= crc32.o
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/ttpci/Kconfig linux-2.6.0-test6-cvs/drivers/media/dvb/ttpci/Kconfig
--- linux-2.6.0-test6/drivers/media/dvb/ttpci/Kconfig	2003-10-01 12:20:38.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/ttpci/Kconfig	2003-09-29 14:28:39.000000000 +0200
@@ -1,6 +1,8 @@
 config DVB_AV7110
 	tristate "AV7110 cards"
-	depends on VIDEO_DEV && DVB_CORE
+	depends on DVB_CORE
+	select VIDEO_DEV
+	select VIDEO_SAA7146_VV
 	help
 	  Support for SAA7146 and AV7110 based DVB cards as produced 
 	  by Fujitsu-Siemens, Technotrend, Hauppauge and others.
@@ -26,6 +28,7 @@
 config DVB_BUDGET
 	tristate "Budget cards"
 	depends on DVB_CORE
+	select VIDEO_SAA7146
 	help
 	  Support for simple SAA7146 based DVB cards
 	  (so called Budget- or Nova-PCI cards) without onboard
@@ -38,7 +41,8 @@
 
 config DVB_BUDGET_CI
 	tristate "Budget cards with onboard CI connector"
-	depends on VIDEO_DEV && DVB_CORE && DVB_BUDGET
+	depends on DVB_CORE
+	select VIDEO_SAA7146
 	help
 	  Support for simple SAA7146 based DVB cards
 	  (so called Budget- or Nova-PCI cards) without onboard
@@ -51,7 +55,9 @@
 
 config DVB_BUDGET_AV
 	tristate "Budget cards with analog video inputs"
-	depends on VIDEO_DEV && DVB_CORE && DVB_BUDGET
+	depends on DVB_CORE
+	select VIDEO_DEV
+	select VIDEO_SAA7146_VV
 	help
 	  Support for simple SAA7146 based DVB cards
 	  (so called Budget- or Nova-PCI cards) without onboard
@@ -64,7 +70,9 @@
 
 config DVB_BUDGET_PATCH
 	tristate "AV7110 cards with Budget Patch"
-	depends on DVB_CORE && DVB_BUDGET
+	depends on DVB_BUDGET
+	select VIDEO_DEV
+	select VIDEO_SAA7146_VV
 	help
 	  Support for Budget Patch (full TS) modification on 
 	  SAA7146+AV7110 based cards (DVB-S cards). This
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/ttusb-budget/Kconfig linux-2.6.0-test6-cvs/drivers/media/dvb/ttusb-budget/Kconfig
--- linux-2.6.0-test6/drivers/media/dvb/ttusb-budget/Kconfig	2003-10-01 12:20:38.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/ttusb-budget/Kconfig	2003-09-30 19:45:20.000000000 +0200
@@ -1,6 +1,6 @@
 config DVB_TTUSB_BUDGET
 	tristate "Technotrend/Hauppauge Nova-USB devices"
-	depends on DVB_CORE && USB
+	depends on DVB_CORE
 	help
 	  Support for external USB adapters designed by Technotrend and
 	  produced by Hauppauge, shipped under the brand name 'Nova-USB'.
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/dvb/frontends/Kconfig linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/Kconfig
--- linux-2.6.0-test6/drivers/media/dvb/frontends/Kconfig	2003-10-01 13:36:35.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/dvb/frontends/Kconfig	2003-10-01 13:04:16.000000000 +0200
@@ -26,6 +26,16 @@
 	  DVB adapter simply enable all supported frontends, the 
 	  right one will get autodetected.
 
+config DVB_SP887X
+ 	tristate "Frontends with sp887x demodulators, e.g. Microtune DTF7072"
+ 	depends on DVB_CORE
+ 	help
+ 	  A DVB-T demodulator driver. Say Y when you want to support the sp887x.
+ 
+ 	  If you don't know what tuner module is soldered on your
+ 	  DVB adapter simply enable all supported frontends, the
+ 	  right one will get autodetected.
+
 config DVB_ALPS_TDLB7
 	tristate "Alps TDLB7 (OFDM)"
 	depends on DVB_CORE
diff -uNrwB --new-file -uraN linux-2.6.0-test6/drivers/media/video/Kconfig linux-2.6.0-test6-cvs/drivers/media/video/Kconfig
--- linux-2.6.0-test6/drivers/media/video/Kconfig	2003-10-01 13:36:35.000000000 +0200
+++ linux-2.6.0-test6-cvs/drivers/media/video/Kconfig	2003-09-30 19:40:39.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menu "Video For Linux"
-	depends on VIDEO_DEV!=n
+	depends on VIDEO_DEV
 
 comment "Video Adapters"
 
@@ -228,7 +228,8 @@
 
 config VIDEO_MXB
 	tristate "Siemens-Nixdorf 'Multimedia eXtension Board'"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI
+	select VIDEO_SAA7146_VV
 	---help---
 	  This is a video4linux driver for the 'Multimedia eXtension Board'
 	  TV card by Siemens-Nixdorf.
@@ -238,7 +239,8 @@
 
 config VIDEO_DPC
 	tristate "Philips-Semiconductors 'dpc7146 demonstration board'"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI
+	select VIDEO_SAA7146_VV
 	---help---
 	  This is a video4linux driver for the 'dpc7146 demonstration
 	  board' by Philips-Semiconductors. It's the reference design
@@ -251,7 +253,8 @@
 
 config VIDEO_HEXIUM_ORION
 	tristate "Hexium HV-PCI6 and Orion frame grabber"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI
+	select VIDEO_SAA7146_VV
 	---help---
 	  This is a video4linux driver for the Hexium HV-PCI6 and
 	  Orion frame grabber cards by Hexium.
@@ -261,7 +264,8 @@
 
 config VIDEO_HEXIUM_GEMINI
 	tristate "Hexium Gemini frame grabber"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI
+	select VIDEO_SAA7146_VV
 	---help---
 	  This is a video4linux driver for the Hexium Gemini frame
 	  grabber card by Hexium. Please note that the Gemini Dual

--------------080303060907070207070203--

