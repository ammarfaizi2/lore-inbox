Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTI2Sgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 14:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbTI2Sey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 14:34:54 -0400
Received: from mail.convergence.de ([212.84.236.4]:62692 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264369AbTI2Sbx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 14:31:53 -0400
Message-ID: <3F787A90.7020706@convergence.de>
Date: Mon, 29 Sep 2003 20:31:44 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] select for drivers/media
References: <20030928160536.GJ15338@fs.tum.de> <3F774CCC.3040707@convergence.de> <20030928212630.GS15338@fs.tum.de> <20030929173021.GA1762@kroah.com>
In-Reply-To: <20030929173021.GA1762@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------050305010706090803030201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050305010706090803030201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Greg, Adrian,

> Your patch looks fine to me.

Ok, here comes my suggestion: 8-)

"VIDEO_SAA7146" consists of two parts: saa7146.o and saa7146_vv.o
The former contains the low level functions only, whereas the second
one has all the *v*ideo and *v*bi functions, too.

So I split the stuff into VIDEO_SAA7146 and VIDEO_SAA7146_VV.

The reason is, that the so-called DVB budget cards without MPEG-Deocder
only need the core functions, while the full-featured cards with
MPEG-Decoder need both modules plus Video4Linux support. The budget cards
work just fine without Video4Linux.

So here it comes: The idea is to allow the user to basically select
everything. If a subsystem or utitlity stuff is needed (NET, INET, PCI, USB, I2C)
it's selected automatically.

Before, users had to set all these things correctly, before they could
even see the drivers. A co-worked argued, that now stuff is automatically
selected and experienced user now have to find out which driver toggled which
setting. He said that this is almost as bad as before.

What do you think?

Ok, here are some comments to the patch:

diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/common/Kconfig linux-2.6.0-test6/drivers/media/common/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/common/Kconfig	2003-09-10 11:28:54.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/common/Kconfig	2003-09-29 14:17:09.000000000 +0200
@@ -1,11 +1,13 @@
  config VIDEO_SAA7146
+	select I2C
+	select PCI
          tristate
-        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y || VIDEO_MXB=y || VIDEO_DPC=y || VIDEO_HEXIUM_ORION=y || VIDEO_HEXIUM_GEMINI=y
-        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m || VIDEO_MXB=m || VIDEO_DPC=m || VIDEO_HEXIUM_ORION=m || VIDEO_HEXIUM_GEMINI=m
-        depends on VIDEO_DEV && PCI && I2C
+
+config VIDEO_SAA7146_VV
+        tristate
+	select VIDEO_BUF
+	select VIDEO_VIDEOBUF
+	select VIDEO_SAA7146

  config VIDEO_VIDEOBUF
          tristate
-        default y if VIDEO_SAA7134=y || VIDEO_BT848=y || VIDEO_SAA7146=y
-        default m if VIDEO_SAA7134=m || VIDEO_BT848=m || VIDEO_SAA7146=m
-        depends on VIDEO_DEV

VIDEO_SAA7146 needs I2C and PCI to function. VIDEO_SAA7146_VV needs VIDEO_BUF,
VIDEO_VIDEOBUF and VIDEO_SAA7146.

diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/Kconfig linux-2.6.0-test6/drivers/media/dvb/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/Kconfig	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/Kconfig	2003-09-29 14:38:43.000000000 +0200
@@ -3,16 +3,18 @@
  #

  menu "Digital Video Broadcasting Devices"
-	depends on NET && INET

  config DVB
  	bool "DVB For Linux"
+	select NET
+	select INET
+	select DVB_CORE
  	---help---
  	  Support Digital Video Broadcasting hardware.  Enable this if you
  	  own a DVB adapter and want to use it or if you compile Linux for
  	  a digital SetTopBox.

-	  API specs and user tools and are available for example from
+	  API specs and user tools are available from
  	  <http://www.linuxtv.org/>.

I simplified the handling here. Instead of relying that the user
has NET and INET set, DVB depends on this. Set DVB_CORE automatically
-- if somebody wants DVB support, he wants the DVB_CORE stuff, too...

@@ -33,18 +35,18 @@
  source "drivers/media/dvb/frontends/Kconfig"

  comment "Supported SAA7146 based PCI Adapters"
-	depends on DVB && PCI
+	depends on DVB_CORE

  source "drivers/media/dvb/ttpci/Kconfig"

  comment "Supported USB Adapters"
-	depends on DVB && USB
+	depends on DVB_CORE

  source "drivers/media/dvb/ttusb-budget/Kconfig"
  source "drivers/media/dvb/ttusb-dec/Kconfig"

  comment "Supported FlexCopII (B2C2) Adapters"
-	depends on DVB && PCI
+	depends on DVB_CORE
  source "drivers/media/dvb/b2c2/Kconfig"

Make every bigger "subsystem" depend on DVB_CORE. The drivers are all
selectable by default, they set the corresponding dependencies
(PCI or USB) later on.

  endmenu
diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/b2c2/Kconfig linux-2.6.0-test6/drivers/media/dvb/b2c2/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/b2c2/Kconfig	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/b2c2/Kconfig	2003-09-29 14:35:30.000000000 +0200
@@ -1,6 +1,7 @@
  config DVB_B2C2_SKYSTAR
  	tristate "Technisat Skystar2 PCI"
  	depends on DVB_CORE
+	select PCI
  	help
  	  Support for the Skystar2 PCI DVB card by Technisat, which
  	  is equipped with the FlexCopII chipset by B2C2.

B2C2 needs PCI.

diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/ttpci/Kconfig linux-2.6.0-test6/drivers/media/dvb/ttpci/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/ttpci/Kconfig	2003-09-29 13:58:00.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/ttpci/Kconfig	2003-09-29 14:28:39.000000000 +0200
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

This is the full-featured card which needs everything: VIDEO_DEV for Video4Linux,
VIDEO_SAA7146_VV for video&vbi saa7146 support.

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

The "budget" cards only need the core functionality of saa7146.

  config DVB_BUDGET_PATCH
  	tristate "AV7110 cards with Budget Patch"
-	depends on DVB_CORE && DVB_BUDGET
+	depends on DVB_BUDGET
+	select VIDEO_DEV
+	select VIDEO_SAA7146_VV
  	help
  	  Support for Budget Patch (full TS) modification on
  	  SAA7146+AV7110 based cards (DVB-S cards). This

This is basically the "full" av7110 card, but with hardware modifications to
behave like a "budget" card...

diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/ttusb-budget/Kconfig linux-2.6.0-test6/drivers/media/dvb/ttusb-budget/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/ttusb-budget/Kconfig	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/ttusb-budget/Kconfig	2003-09-29 14:35:15.000000000 +0200
@@ -1,6 +1,7 @@
  config DVB_TTUSB_BUDGET
  	tristate "Technotrend/Hauppauge Nova-USB devices"
-	depends on DVB_CORE && USB
+	depends on DVB_CORE
+	select USB
  	help
  	  Support for external USB adapters designed by Technotrend and
  	  produced by Hauppauge, shipped under the brand name 'Nova-USB'.
diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/ttusb-dec/Kconfig linux-2.6.0-test6/drivers/media/dvb/ttusb-dec/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/ttusb-dec/Kconfig	2003-09-10 11:29:20.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/ttusb-dec/Kconfig	2003-09-29 14:36:01.000000000 +0200
@@ -1,6 +1,8 @@
  config DVB_TTUSB_DEC
  	tristate "Technotrend/Hauppauge USB DEC2000-T devices"
-	depends on DVB_CORE && USB && !STANDALONE
+	depends on DVB_CORE
+	depends on !STANDALONE
+	select USB
  	help
  	  Support for external USB adapters designed by Technotrend and
  	  produced by Hauppauge, shipped under the brand name 'DEC2000-T'.

The USB drivers need USB to work. What does STANDALONE mean?

diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/video/Kconfig linux-2.6.0-test6/drivers/media/video/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/video/Kconfig	2003-09-29 13:58:00.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/video/Kconfig	2003-09-29 14:13:01.000000000 +0200
@@ -228,7 +228,7 @@

  config VIDEO_MXB
  	tristate "Siemens-Nixdorf 'Multimedia eXtension Board'"
-	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_SAA7146_VV
  	---help---
  	  This is a video4linux driver for the 'Multimedia eXtension Board'
  	  TV card by Siemens-Nixdorf.
@@ -238,7 +238,7 @@

  config VIDEO_DPC
  	tristate "Philips-Semiconductors 'dpc7146 demonstration board'"
-	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_SAA7146_VV
  	---help---
  	  This is a video4linux driver for the 'dpc7146 demonstration
  	  board' by Philips-Semiconductors. It's the reference design
@@ -251,7 +251,7 @@

[...]

These are the "analog" drivers using the saa7146. They all need VIDEO_SAA7146_VV.

Ok, that's it. I'm planning to submit a DVB patchset for Linus within the next days.
I can incorporated these changes within my patchset easily.

CU
Michael.


--------------050305010706090803030201
Content-Type: text/plain;
 name="media_kconfig.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="media_kconfig.diff"

diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/common/Kconfig linux-2.6.0-test6/drivers/media/common/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/common/Kconfig	2003-09-10 11:28:54.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/common/Kconfig	2003-09-29 14:17:09.000000000 +0200
@@ -1,11 +1,13 @@
 config VIDEO_SAA7146
+	select I2C
+	select PCI
         tristate
-        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y || VIDEO_MXB=y || VIDEO_DPC=y || VIDEO_HEXIUM_ORION=y || VIDEO_HEXIUM_GEMINI=y
-        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m || VIDEO_MXB=m || VIDEO_DPC=m || VIDEO_HEXIUM_ORION=m || VIDEO_HEXIUM_GEMINI=m
-        depends on VIDEO_DEV && PCI && I2C
+
+config VIDEO_SAA7146_VV
+        tristate
+	select VIDEO_BUF
+	select VIDEO_VIDEOBUF
+	select VIDEO_SAA7146
 
 config VIDEO_VIDEOBUF
         tristate
-        default y if VIDEO_SAA7134=y || VIDEO_BT848=y || VIDEO_SAA7146=y
-        default m if VIDEO_SAA7134=m || VIDEO_BT848=m || VIDEO_SAA7146=m
-        depends on VIDEO_DEV
diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/common/Makefile linux-2.6.0-test6/drivers/media/common/Makefile
--- xx-linux-2.6.0-test6/drivers/media/common/Makefile	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/common/Makefile	2003-09-29 14:08:58.000000000 +0200
@@ -1,5 +1,6 @@
 saa7146-objs    := saa7146_i2c.o saa7146_core.o 
 saa7146_vv-objs := saa7146_vv_ksyms.o saa7146_fops.o saa7146_video.o saa7146_hlp.o saa7146_vbi.o  
 
-obj-$(CONFIG_VIDEO_SAA7146) += saa7146.o saa7146_vv.o
+obj-$(CONFIG_VIDEO_SAA7146) += saa7146.o
+obj-$(CONFIG_VIDEO_SAA7146_VV) += saa7146_vv.o
 
diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/Kconfig linux-2.6.0-test6/drivers/media/dvb/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/Kconfig	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/Kconfig	2003-09-29 14:38:43.000000000 +0200
@@ -3,16 +3,18 @@
 #
 
 menu "Digital Video Broadcasting Devices"
-	depends on NET && INET 
 
 config DVB
 	bool "DVB For Linux"
+	select NET
+	select INET
+	select DVB_CORE
 	---help---
 	  Support Digital Video Broadcasting hardware.  Enable this if you 
 	  own a DVB adapter and want to use it or if you compile Linux for 
 	  a digital SetTopBox.
 
-	  API specs and user tools and are available for example from 
+	  API specs and user tools are available from
 	  <http://www.linuxtv.org/>. 
 
 	  Please report problems regarding this driver to the LinuxDVB 
@@ -33,18 +35,18 @@
 source "drivers/media/dvb/frontends/Kconfig"
 
 comment "Supported SAA7146 based PCI Adapters"
-	depends on DVB && PCI
+	depends on DVB_CORE
 
 source "drivers/media/dvb/ttpci/Kconfig"
 
 comment "Supported USB Adapters"
-	depends on DVB && USB
+	depends on DVB_CORE
 
 source "drivers/media/dvb/ttusb-budget/Kconfig"
 source "drivers/media/dvb/ttusb-dec/Kconfig"
 
 comment "Supported FlexCopII (B2C2) Adapters"
-	depends on DVB && PCI
+	depends on DVB_CORE
 source "drivers/media/dvb/b2c2/Kconfig"
 
 endmenu
diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/b2c2/Kconfig linux-2.6.0-test6/drivers/media/dvb/b2c2/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/b2c2/Kconfig	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/b2c2/Kconfig	2003-09-29 14:35:30.000000000 +0200
@@ -1,6 +1,7 @@
 config DVB_B2C2_SKYSTAR
 	tristate "Technisat Skystar2 PCI"
 	depends on DVB_CORE
+	select PCI
 	help
 	  Support for the Skystar2 PCI DVB card by Technisat, which
 	  is equipped with the FlexCopII chipset by B2C2.
diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/dvb-core/Kconfig linux-2.6.0-test6/drivers/media/dvb/dvb-core/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/dvb-core/Kconfig	2003-09-29 13:58:00.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/dvb-core/Kconfig	2003-09-29 15:50:51.000000000 +0200
@@ -4,5 +4,8 @@
 	select CRC32
 	help
 	  DVB core utility functions for device handling, software fallbacks etc.
+	  Say Y when you have a DVB card and want to use it. Say Y if your want
+	  to build your drivers outside the kernel, but need the DVB core. All 
+	  in-kernel drivers will select this automatically if needed.
+	  If unsure say N.
 
-	  Say Y when you have a DVB card and want to use it. If unsure say N.
diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/ttpci/Kconfig linux-2.6.0-test6/drivers/media/dvb/ttpci/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/ttpci/Kconfig	2003-09-29 13:58:00.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/ttpci/Kconfig	2003-09-29 14:28:39.000000000 +0200
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
diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/ttusb-budget/Kconfig linux-2.6.0-test6/drivers/media/dvb/ttusb-budget/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/ttusb-budget/Kconfig	2003-09-10 11:28:41.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/ttusb-budget/Kconfig	2003-09-29 14:35:15.000000000 +0200
@@ -1,6 +1,7 @@
 config DVB_TTUSB_BUDGET
 	tristate "Technotrend/Hauppauge Nova-USB devices"
-	depends on DVB_CORE && USB
+	depends on DVB_CORE
+	select USB
 	help
 	  Support for external USB adapters designed by Technotrend and
 	  produced by Hauppauge, shipped under the brand name 'Nova-USB'.
diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/dvb/ttusb-dec/Kconfig linux-2.6.0-test6/drivers/media/dvb/ttusb-dec/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/dvb/ttusb-dec/Kconfig	2003-09-10 11:29:20.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/dvb/ttusb-dec/Kconfig	2003-09-29 14:36:01.000000000 +0200
@@ -1,6 +1,8 @@
 config DVB_TTUSB_DEC
 	tristate "Technotrend/Hauppauge USB DEC2000-T devices"
-	depends on DVB_CORE && USB && !STANDALONE
+	depends on DVB_CORE
+	depends on !STANDALONE
+	select USB
 	help
 	  Support for external USB adapters designed by Technotrend and
 	  produced by Hauppauge, shipped under the brand name 'DEC2000-T'.
diff -uNrwB --new-file -uraN xx-linux-2.6.0-test6/drivers/media/video/Kconfig linux-2.6.0-test6/drivers/media/video/Kconfig
--- xx-linux-2.6.0-test6/drivers/media/video/Kconfig	2003-09-29 13:58:00.000000000 +0200
+++ linux-2.6.0-test6/drivers/media/video/Kconfig	2003-09-29 14:13:01.000000000 +0200
@@ -228,7 +228,7 @@
 
 config VIDEO_MXB
 	tristate "Siemens-Nixdorf 'Multimedia eXtension Board'"
-	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_SAA7146_VV
 	---help---
 	  This is a video4linux driver for the 'Multimedia eXtension Board'
 	  TV card by Siemens-Nixdorf.
@@ -238,7 +238,7 @@
 
 config VIDEO_DPC
 	tristate "Philips-Semiconductors 'dpc7146 demonstration board'"
-	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_SAA7146_VV
 	---help---
 	  This is a video4linux driver for the 'dpc7146 demonstration
 	  board' by Philips-Semiconductors. It's the reference design
@@ -251,7 +251,7 @@
 
 config VIDEO_HEXIUM_ORION
 	tristate "Hexium HV-PCI6 and Orion frame grabber"
-	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_SAA7146_VV
 	---help---
 	  This is a video4linux driver for the Hexium HV-PCI6 and
 	  Orion frame grabber cards by Hexium.
@@ -261,7 +261,7 @@
 
 config VIDEO_HEXIUM_GEMINI
 	tristate "Hexium Gemini frame grabber"
-	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_SAA7146_VV
 	---help---
 	  This is a video4linux driver for the Hexium Gemini frame
 	  grabber card by Hexium. Please note that the Gemini Dual

--------------050305010706090803030201--

