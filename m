Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271356AbTGQIwz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 04:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271357AbTGQIwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 04:52:55 -0400
Received: from mail.convergence.de ([212.84.236.4]:57009 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271355AbTGQIwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 04:52:03 -0400
Message-ID: <3F16672F.2090806@convergence.de>
Date: Thu, 17 Jul 2003 11:06:55 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-ac2: multiple definitions of hexium_*
References: <200307161816.h6GIGKH09243@devserv.devel.redhat.com> <20030716230425.GB1407@fs.tum.de>
In-Reply-To: <20030716230425.GB1407@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------030900080704030603090407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030900080704030603090407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Adrian, Alan,

> I got the following compile error:
> 
> <--  snip  -->
>   LD      drivers/media/video/built-in.o
> drivers/media/video/hexium_gemini.o(.data+0x4): multiple definition of 
> `hexium_num'
> drivers/media/video/hexium_orion.o(.data+0x4): first defined here
> drivers/media/video/hexium_gemini.o(.init.text+0x0): In function 
> `hexium_init_module':
> : multiple definition of `hexium_init_module'
> drivers/media/video/hexium_orion.o(.init.text+0x0): first defined here
> drivers/media/video/hexium_gemini.o(.exit.text+0x0): In function 
> `hexium_cleanup_module':
> : multiple definition of `hexium_cleanup_module'
> drivers/media/video/hexium_orion.o(.exit.text+0x0): first defined here
> make[3]: *** [drivers/media/video/built-in.o] Error 1
> make[2]: *** [drivers/media/video] Error 2
> make[1]: *** [drivers/media] Error 2
> make: *** [drivers] Error 2
> 
> <--  snip  -->

Thanks for reporting!

Some stuff was not delared static, additionaly some dependencies to i2c 
and between saa7146 and hexium were missing, the following patch fixes 
all this.

> cu
> Adrian

@ Alan: Many thanks for adding the patches to your ac tree! This makes 
my life a lot easier!

CU
Michael.

--------------030900080704030603090407
Content-Type: text/plain;
 name="19-DVB-fix-hexium-build.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="19-DVB-fix-hexium-build.diff"

[V4L] - fix static build for hexium_gemini and hexium_orion drivers (Thanks to Adrian Bunk <bunk@fs.tum.de> for reporting this)
[V4L] - set debug verbosity to 0 for hexium_gemini and hexium_orion drivers
[V4L] - make hexium_gemini and hexium_orion drivers depdend on i2c module
[V4L] - make saa7146 module depend on hexium_gemini and hexium_orion drivers 
[V4L] - let the saa7146 i2c bus report itself as I2C_ADAP_CLASS_TV_ANALOG
diff -urwb linux-2.6.0-test1.patch/drivers/media/common/Kconfig linux-2.6.0-test1.work/drivers/media/common/Kconfig
--- linux-2.6.0-test1.patch/drivers/media/common/Kconfig	2003-07-17 10:46:51.000000000 +0200
+++ linux-2.6.0-test1.work/drivers/media/common/Kconfig	2003-07-17 10:38:17.000000000 +0200
@@ -1,8 +1,8 @@
 config VIDEO_SAA7146
         tristate
-        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y || VIDEO_MXB=y || VIDEO_DPC=y
-        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m || VIDEO_MXB=m || VIDEO_DPC=m
-        depends on VIDEO_DEV && PCI
+        default y if DVB_AV7110=y || DVB_BUDGET=y || DVB_BUDGET_AV=y || VIDEO_MXB=y || VIDEO_DPC=y || VIDEO_HEXIUM_ORION=y || VIDEO_HEXIUM_GEMINI=y
+        default m if DVB_AV7110=m || DVB_BUDGET=m || DVB_BUDGET_AV=m || VIDEO_MXB=m || VIDEO_DPC=m || VIDEO_HEXIUM_ORION=m || VIDEO_HEXIUM_GEMINI=m
+        depends on VIDEO_DEV && PCI && I2C
 
 config VIDEO_VIDEOBUF
         tristate
diff -urwb linux-2.6.0-test1.patch/drivers/media/common/saa7146_i2c.c linux-2.6.0-test1.work/drivers/media/common/saa7146_i2c.c
--- linux-2.6.0-test1.patch/drivers/media/common/saa7146_i2c.c	2003-07-17 10:48:14.000000000 +0200
+++ linux-2.6.0-test1.work/drivers/media/common/saa7146_i2c.c	2003-07-16 12:54:26.000000000 +0200
@@ -419,6 +419,7 @@
 		i2c_adapter->id 	   = I2C_ALGO_SAA7146;
 		i2c_adapter->timeout = SAA7146_I2C_TIMEOUT;
 		i2c_adapter->retries = SAA7146_I2C_RETRIES;
+		i2c_adapter->class = I2C_ADAP_CLASS_TV_ANALOG;
 	}
 	
 	return 0;
diff -urwb linux-2.6.0-test1.patch/drivers/media/video/Kconfig linux-2.6.0-test1.work/drivers/media/video/Kconfig
--- linux-2.6.0-test1.patch/drivers/media/video/Kconfig	2003-07-17 10:50:21.000000000 +0200
+++ linux-2.6.0-test1.work/drivers/media/video/Kconfig	2003-07-17 10:38:05.000000000 +0200
@@ -259,7 +259,7 @@
 
 config VIDEO_HEXIUM_ORION
 	tristate "Hexium HV-PCI6 and Orion frame grabber"
-	depends on VIDEO_DEV && PCI
+	depends on VIDEO_DEV && PCI && I2C
 	---help---
 	  This is a video4linux driver for the Hexium HV-PCI6 and
 	  Orion frame grabber cards by Hexium.
@@ -271,7 +271,7 @@
 
 config VIDEO_HEXIUM_GEMINI
 	tristate "Hexium Gemini frame grabber"
-	depends on VIDEO_DEV && PCI
+	depends on VIDEO_DEV && PCI && I2C
 	---help---
 	  This is a video4linux driver for the Hexium Gemini frame
 	  grabber card by Hexium. Please note that the Gemini Dual
diff -urwb linux-2.6.0-test1.patch/drivers/media/video/hexium_gemini.c linux-2.6.0-test1.work/drivers/media/video/hexium_gemini.c
--- linux-2.6.0-test1.patch/drivers/media/video/hexium_gemini.c	2003-07-17 10:50:21.000000000 +0200
+++ linux-2.6.0-test1.work/drivers/media/video/hexium_gemini.c	2003-07-17 10:31:52.000000000 +0200
@@ -25,12 +25,12 @@
 
 #include <media/saa7146_vv.h>
 
-static int debug = 255;
+static int debug = 0;
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "debug verbosity");
 
 /* global variables */
-int hexium_num = 0;
+static int hexium_num = 0;
 
 #include "hexium_gemini.h"
 
@@ -388,7 +388,7 @@
 	.irq_func = NULL,
 };
 
-int __init hexium_init_module(void)
+static int __init hexium_init_module(void)
 {
 	if (0 != saa7146_register_extension(&hexium_extension)) {
 		DEB_S(("failed to register extension.\n"));
@@ -398,7 +398,7 @@
 	return 0;
 }
 
-void __exit hexium_cleanup_module(void)
+static void __exit hexium_cleanup_module(void)
 {
 	saa7146_unregister_extension(&hexium_extension);
 }
diff -urwb linux-2.6.0-test1.patch/drivers/media/video/hexium_orion.c linux-2.6.0-test1.work/drivers/media/video/hexium_orion.c
--- linux-2.6.0-test1.patch/drivers/media/video/hexium_orion.c	2003-07-17 10:50:21.000000000 +0200
+++ linux-2.6.0-test1.work/drivers/media/video/hexium_orion.c	2003-07-17 10:30:54.000000000 +0200
@@ -25,7 +25,7 @@
 
 #include <media/saa7146_vv.h>
 
-static int debug = 255;
+static int debug = 0;
 MODULE_PARM(debug, "i");
 MODULE_PARM_DESC(debug, "debug verbosity");
 

--------------030900080704030603090407--

