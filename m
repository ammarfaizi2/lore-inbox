Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTI1V0n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbTI1V0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:26:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6619 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262750AbTI1V0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:26:38 -0400
Date: Sun, 28 Sep 2003 23:26:30 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Michael Hunold <hunold@convergence.de>, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: [2.6 patch] select for drivers/media
Message-ID: <20030928212630.GS15338@fs.tum.de>
References: <20030928160536.GJ15338@fs.tum.de> <3F774CCC.3040707@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F774CCC.3040707@convergence.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 11:04:12PM +0200, Michael Hunold wrote:

> Hello Adrian,

Hi Michael,

> >The patch below switches drivers/mtd to use select where appropriate.
> 
> Ok.
> 
> >Could someone with a knowledge of the code please check the following:
> >
> >DVB_AV7110 and DVB_BUDGET select VIDEO_SAA7146 (without my patch 
> >VIDEO_SAA7146 depends on them) although they don't fulfill the 
> >VIDEO_SAA7146 dependencies VIDEO_DEV && PCI && I2C.
> 
> I admit that this is somewhat broken and might fail under certain 
> cirumstances. It's possible that someone sets DVB_AV7110, but does not 
> have I2C enabled. Then VIDEO_SAA7146 is not build, although it should. Doh!
> 
> Does your patch fix this issue as well?

No, it doesn't.

> >Is the intention to enable VIDEO_SAA7146 only when these options are 
> >enabled or should DVB_AV7110 and DVB_BUDGET depend on these options?
> 
> Both DVB_AV7110 and DVB_BUDGET need VIDEO_SAA7146 to work properly. Same 
> goes for the analog video drivers VIDEO_MXB, VIDEO_DPC and the other 
> saa7146 drivers.

The problem described doesn't exist with the other drivers (they have 
the appropriate dependencies).

> It's somewhat annoying that you have to enable I2C before all these 
> drivers can be build. The user needs to know that I2C is used somewhere 
> in the driver, although he won't see anything -- all i2c drivers are 
> compiled automatically, a "modprobe mxb" loads all i2c drivers it needs.
> 
> It would be better, if I2C would be enabled automatically if SAA7146 is 
> set. I admit that this sort of reversed-selection can introduce new 
> problems.
> 
> What do you think?

Below is an updated patch that does additionally:
- let DVB_BUDGET depend on VIDEO_DEV
- let DVB_AV7110 and DVB_BUDGET select PCI and I2C

Other possibilitties would be:
- let DVB_AV7110 and DVB_BUDGET depend on PCI and I2C
or
- let VIDEO_SAA7146 select PCI and I2C

I don't have any strong opinion which solution is the best one.

@Greg:
What's your opinion on this issue?


> CU
> Michael.

cu
Adrian

--- linux-2.6.0-test6-full/drivers/media/Kconfig.old	2003-09-28 17:40:12.000000000 +0200
+++ linux-2.6.0-test6-full/drivers/media/Kconfig	2003-09-28 17:49:12.000000000 +0200
@@ -34,20 +34,12 @@
 
 config VIDEO_TUNER
 	tristate
-	default y if VIDEO_BT848=y || VIDEO_SAA7134=y || VIDEO_MXB=y
-	default m if VIDEO_BT848=m || VIDEO_SAA7134=m || VIDEO_MXB=m
-	depends on VIDEO_DEV
 
 config VIDEO_BUF
 	tristate
-	default y if VIDEO_BT848=y || VIDEO_SAA7134=y || VIDEO_SAA7146=y
-	default m if VIDEO_BT848=m || VIDEO_SAA7134=m || VIDEO_SAA7146=m
-	depends on VIDEO_DEV
 
 config VIDEO_BTCX
 	tristate
-	default VIDEO_BT848
-	depends on VIDEO_DEV
 
 endmenu
 
--- linux-2.6.0-test6-full/drivers/media/video/Kconfig.old	2003-09-28 17:41:10.000000000 +0200
+++ linux-2.6.0-test6-full/drivers/media/video/Kconfig	2003-09-28 17:45:19.000000000 +0200
@@ -10,6 +10,10 @@
 config VIDEO_BT848
 	tristate "BT848 Video For Linux"
 	depends on VIDEO_DEV && PCI && I2C_ALGOBIT && SOUND
+	select VIDEO_TUNER
+	select VIDEO_BUF
+	select VIDEO_BTCX
+	select VIDEO_VIDEOBUF
 	---help---
 	  Support for BT848 based frame grabber/overlay boards. This includes
 	  the Miro, Hauppauge and STB boards. Please read the material in
@@ -219,6 +223,9 @@
 config VIDEO_SAA7134
 	tristate "Philips SAA7134 support"
 	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_TUNER
+	select VIDEO_BUF
+	select VIDEO_VIDEOBUF
 	---help---
 	  This is a video4linux driver for Philips SAA7130/7134 based
 	  TV cards.
@@ -229,6 +236,8 @@
 config VIDEO_MXB
 	tristate "Siemens-Nixdorf 'Multimedia eXtension Board'"
 	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_TUNER
+	select VIDEO_SAA7146
 	---help---
 	  This is a video4linux driver for the 'Multimedia eXtension Board'
 	  TV card by Siemens-Nixdorf.
@@ -239,6 +248,7 @@
 config VIDEO_DPC
 	tristate "Philips-Semiconductors 'dpc7146 demonstration board'"
 	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_SAA7146
 	---help---
 	  This is a video4linux driver for the 'dpc7146 demonstration
 	  board' by Philips-Semiconductors. It's the reference design
@@ -252,6 +262,7 @@
 config VIDEO_HEXIUM_ORION
 	tristate "Hexium HV-PCI6 and Orion frame grabber"
 	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_SAA7146
 	---help---
 	  This is a video4linux driver for the Hexium HV-PCI6 and
 	  Orion frame grabber cards by Hexium.
@@ -262,6 +273,7 @@
 config VIDEO_HEXIUM_GEMINI
 	tristate "Hexium Gemini frame grabber"
 	depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_SAA7146
 	---help---
 	  This is a video4linux driver for the Hexium Gemini frame
 	  grabber card by Hexium. Please note that the Gemini Dual
--- linux-2.6.0-test6-full/drivers/media/common/Kconfig.old	2003-09-28 17:39:34.000000000 +0200
+++ linux-2.6.0-test6-full/drivers/media/common/Kconfig	2003-09-28 23:16:54.000000000 +0200
@@ -1,11 +1,7 @@
 config VIDEO_SAA7146
         tristate
-        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y || VIDEO_MXB=y || VIDEO_DPC=y || VIDEO_HEXIUM_ORION=y || VIDEO_HEXIUM_GEMINI=y
-        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m || VIDEO_MXB=m || VIDEO_DPC=m || VIDEO_HEXIUM_ORION=m || VIDEO_HEXIUM_GEMINI=m
-        depends on VIDEO_DEV && PCI && I2C
+	select VIDEO_BUF
+	select VIDEO_VIDEOBUF
 
 config VIDEO_VIDEOBUF
         tristate
-        default y if VIDEO_SAA7134=y || VIDEO_BT848=y || VIDEO_SAA7146=y
-        default m if VIDEO_SAA7134=m || VIDEO_BT848=m || VIDEO_SAA7146=m
-        depends on VIDEO_DEV
--- linux-2.6.0-test6-full/drivers/media/dvb/ttpci/Kconfig.old	2003-09-28 17:46:33.000000000 +0200
+++ linux-2.6.0-test6-full/drivers/media/dvb/ttpci/Kconfig	2003-09-28 23:16:11.000000000 +0200
@@ -1,6 +1,9 @@
 config DVB_AV7110
 	tristate "AV7110 cards"
 	depends on VIDEO_DEV && DVB_CORE
+	select VIDEO_SAA7146
+	select PCI
+	select I2C
 	help
 	  Support for SAA7146 and AV7110 based DVB cards as produced 
 	  by Fujitsu-Siemens, Technotrend, Hauppauge and others.
@@ -25,7 +28,10 @@
 
 config DVB_BUDGET
 	tristate "Budget cards"
-	depends on DVB_CORE
+	depends on VIDEO_DEV && DVB_CORE
+	select VIDEO_SAA7146
+	select PCI
+	select I2C
 	help
 	  Support for simple SAA7146 based DVB cards
 	  (so called Budget- or Nova-PCI cards) without onboard
@@ -52,6 +58,7 @@
 config DVB_BUDGET_AV
 	tristate "Budget cards with analog video inputs"
 	depends on VIDEO_DEV && DVB_CORE && DVB_BUDGET
+	select VIDEO_SAA7146
 	help
 	  Support for simple SAA7146 based DVB cards
 	  (so called Budget- or Nova-PCI cards) without onboard
