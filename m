Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbVEHTpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbVEHTpS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 15:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVEHTof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 15:44:35 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:8855 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262947AbVEHTKf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:35 -0400
Message-Id: <20050508184348.956360000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:57 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-twinhan-ca.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 28/37] DST: reorganize Twinhan DST driver to support CI
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- reorganize Twinhan DST driver to support CI
- add support for more cards
(Manu Abraham)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 Documentation/dvb/ci.txt             |  219 ++++++++
 drivers/media/dvb/bt8xx/Kconfig      |    3 
 drivers/media/dvb/bt8xx/Makefile     |    4 
 drivers/media/dvb/bt8xx/bt878.c      |   18 
 drivers/media/dvb/bt8xx/dst.c        |  842 ++++++++++++++++++++++-----------
 drivers/media/dvb/bt8xx/dst.h        |   40 -
 drivers/media/dvb/bt8xx/dst_ca.c     |  868 +++++++++++++++++++++++++++++++++++
 drivers/media/dvb/bt8xx/dst_ca.h     |   58 ++
 drivers/media/dvb/bt8xx/dst_common.h |  153 ++++++
 drivers/media/dvb/bt8xx/dst_priv.h   |    1 
 drivers/media/dvb/bt8xx/dvb-bt8xx.c  |   95 ++-
 drivers/media/dvb/bt8xx/dvb-bt8xx.h  |    2 
 12 files changed, 1924 insertions(+), 379 deletions(-)

Index: linux-2.6.12-rc4/Documentation/dvb/ci.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc4/Documentation/dvb/ci.txt	2005-05-08 18:13:30.000000000 +0200
@@ -0,0 +1,219 @@
+* For the user
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+NOTE: This document describes the usage of the high level CI API as
+in accordance to the Linux DVB API. This is a not a documentation for the,
+existing low level CI API.  
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To utilize the High Level CI capabilities,
+
+(1*) This point is valid only for the Twinhan/clones
+  For the Twinhan/Twinhan clones, the dst_ca module handles the CI
+  hardware handling.This module is loaded automatically if a CI
+  (Common Interface, that holds the CAM (Conditional Access Module)
+  is detected. 
+
+(2) one requires a userspace application, ca_zap. This small userland
+  application is in charge of sending the descrambling related information
+  to the CAM.
+
+This application requires the following to function properly as of now.
+
+	(a) Tune to a valid channel, with szap.
+	  eg: $ szap -c channels.conf -r "TMC" -x
+
+	(b) a channels.conf containing a valid PMT PID
+
+	  eg: TMC:11996:h:0:27500:278:512:650:321
+
+	  here 278 is a valid PMT PID. the rest of the values are the
+	  same ones that szap uses.
+
+	(c) after running a szap, you have to run ca_zap, for the
+	  descrambler to function,
+
+	  eg: $ ca_zap patched_channels.conf "TMC"
+
+	  The patched means a patch to apply to scan, such that scan can
+	  generate a channels.conf_with pmt, which has this PMT PID info
+	  (NOTE: szap cannot use this channels.conf with the PMT_PID)
+	  
+	  
+	(d) Hopeflly Enjoy your favourite subscribed channel as you do with
+	  a FTA card.
+
+(3) Currently ca_zap, and dst_test, both are meant for demonstration
+  purposes only, they can become full fledged applications if necessary.
+
+
+* Cards that fall in this category
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+At present the cards that fall in this category are the Twinhan and it's
+clones, these cards are available as VVMER, Tomato, Hercules, Orange and
+so on.
+
+* CI modules that are supported
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The CI module support is largely dependant upon the firmware on the cards
+Some cards do support almost all of the available CI modules. There is
+nothing much that can be done in order to make additional CI modules
+working with these cards.
+
+Modules that have been tested by this driver at present are
+
+(1) Irdeto 1 and 2 from SCM
+(2) Viaccess from SCM
+(3) Dragoncam
+
+* The High level CI API 
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+* For the programmer
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+With the High Level CI approach any new card with almost any random
+architecture can be implemented with this style, the definitions
+insidethe switch statement can be easily adapted for any card, thereby
+eliminating the need for any additional ioctls.
+
+The disadvantage is that the driver/hardware has to manage the rest. For
+the application programmer it would be as simple as sending/receiving an
+array to/from the CI ioctls as defined in the Linux DVB API. No changes
+have been made in the API to accomodate this feature.
+
+
+* Why the need for another CI interface ?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+This is one of the most commonly asked question. Well a nice question.
+Strictly speaking this is not a new interface.
+
+The CI interface is defined in the DVB API in ca.h as
+
+typedef struct ca_slot_info {
+	int num;               /* slot number */
+
+	int type;              /* CA interface this slot supports */
+#define CA_CI            1     /* CI high level interface */
+#define CA_CI_LINK       2     /* CI link layer level interface */
+#define CA_CI_PHYS       4     /* CI physical layer level interface */
+#define CA_DESCR         8     /* built-in descrambler */
+#define CA_SC          128     /* simple smart card interface */
+
+	unsigned int flags;
+#define CA_CI_MODULE_PRESENT 1 /* module (or card) inserted */
+#define CA_CI_MODULE_READY   2
+} ca_slot_info_t;
+
+
+
+This CI interface follows the CI high level interface, which is not
+implemented by most applications. Hence this area is revisited.
+
+This CI interface is quite different in the case that it tries to
+accomodate all other CI based devices, that fall into the other categories
+
+This means that this CI interface handles the EN50221 style tags in the
+Application layer only and no session management is taken care of by the
+application. The driver/hardware will take care of all that.
+
+This interface is purely an EN50221 interface exchanging APDU's. This
+means that no session management, link layer or a transport layer do
+exist in this case in the application to driver communication. It is
+as simple as that. The driver/hardware has to take care of that.
+
+
+With this High Level CI interface, the interface can be defined with the
+regular ioctls.
+
+All these ioctls are also valid for the High level CI interface
+
+#define CA_RESET          _IO('o', 128)
+#define CA_GET_CAP        _IOR('o', 129, ca_caps_t)
+#define CA_GET_SLOT_INFO  _IOR('o', 130, ca_slot_info_t)
+#define CA_GET_DESCR_INFO _IOR('o', 131, ca_descr_info_t)
+#define CA_GET_MSG        _IOR('o', 132, ca_msg_t)
+#define CA_SEND_MSG       _IOW('o', 133, ca_msg_t)
+#define CA_SET_DESCR      _IOW('o', 134, ca_descr_t)
+#define CA_SET_PID        _IOW('o', 135, ca_pid_t)
+
+
+On querying the device, the device yields information thus
+
+CA_GET_SLOT_INFO
+----------------------------
+Command = [info]
+APP: Number=[1]
+APP: Type=[1]
+APP: flags=[1]
+APP: CI High level interface
+APP: CA/CI Module Present
+
+CA_GET_CAP
+----------------------------
+Command = [caps]
+APP: Slots=[1]
+APP: Type=[1]
+APP: Descrambler keys=[16]
+APP: Type=[1]
+
+CA_SEND_MSG
+----------------------------
+Descriptors(Program Level)=[ 09 06 06 04 05 50 ff f1]
+Found CA descriptor @ program level
+
+(20) ES type=[2] ES pid=[201]  ES length =[0 (0x0)]
+(25) ES type=[4] ES pid=[301]  ES length =[0 (0x0)]
+ca_message length is 25 (0x19) bytes
+EN50221 CA MSG=[ 9f 80 32 19 03 01 2d d1 f0 08 01 09 06 06 04 05 50 ff f1 02 e0 c9 00 00 04 e1 2d 00 00]
+
+
+Not all ioctl's are implemented in the driver from the API, the other
+features of the hardware that cannot be implemented by the API are achieved
+using the CA_GET_MSG and CA_SEND_MSG ioctls. An EN50221 style wrapper is
+used to exchange the data to maintain compatibility with other hardware.
+
+
+/* a message to/from a CI-CAM */
+typedef struct ca_msg {
+	unsigned int index;
+	unsigned int type;
+	unsigned int length;
+	unsigned char msg[256];
+} ca_msg_t;
+
+
+The flow of data can be described thus,
+
+
+
+
+
+	App (User)
+	-----
+	parse
+	  |
+	  |
+	  v
+	en50221 APDU (package)
+   --------------------------------------
+   |	  |				| High Level CI driver
+   |	  |				|
+   |	  v				|
+   |	en50221 APDU (unpackage)	|
+   |	  |				|
+   |	  |				|
+   |	  v				|
+   |	sanity checks			|
+   |	  |				|
+   |	  |				|
+   |	  v				|
+   |	do (H/W dep)			|
+   --------------------------------------
+	  |    Hardware
+	  |
+	  v
+
+
+
+
+The High Level CI interface uses the EN50221 DVB standard, following a
+standard ensures futureproofness.
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/Makefile
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/Makefile	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/Makefile	2005-05-08 18:13:30.000000000 +0200
@@ -1,5 +1,3 @@
-
-obj-$(CONFIG_DVB_BT8XX) += bt878.o dvb-bt8xx.o dst.o
+obj-$(CONFIG_DVB_BT8XX) += bt878.o dvb-bt8xx.o dst.o dst_ca.o
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/ -Idrivers/media/video -Idrivers/media/dvb/frontends
-
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/bt878.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/bt878.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/bt878.c	2005-05-08 18:13:30.000000000 +0200
@@ -4,8 +4,8 @@
  * Copyright (C) 2002 Peter Hettkamp <peter.hettkamp@t-online.de>
  *
  * large parts based on the bttv driver
- * Copyright (C) 1996,97,98 Ralph  Metzler (rjkm@thp.uni-koeln.de)
- *                        & Marcus Metzler (mocm@thp.uni-koeln.de)
+ * Copyright (C) 1996,97,98 Ralph  Metzler (rjkm@metzlerbros.de)
+ *                        & Marcus Metzler (mocm@metzlerbros.de)
  * (c) 1999,2000 Gerd Knorr <kraxel@goldbach.in-berlin.de>
  *
  * This program is free software; you can redistribute it and/or
@@ -461,9 +461,9 @@ static int __devinit bt878_probe(struct 
 	pci_set_drvdata(dev, bt);
 
 /*        if(init_bt878(btv) < 0) {
-                bt878_remove(dev);
-                return -EIO;
-        }
+		bt878_remove(dev);
+		return -EIO;
+	}
 */
 
 	if ((result = bt878_mem_alloc(bt))) {
@@ -536,10 +536,10 @@ static struct pci_device_id bt878_pci_tb
 MODULE_DEVICE_TABLE(pci, bt878_pci_tbl);
 
 static struct pci_driver bt878_pci_driver = {
-      .name 	= "bt878",
+      .name	= "bt878",
       .id_table = bt878_pci_tbl,
-      .probe 	= bt878_probe,
-      .remove 	= bt878_remove,
+      .probe	= bt878_probe,
+      .remove	= bt878_remove,
 };
 
 static int bt878_pci_driver_registered = 0;
@@ -558,7 +558,7 @@ static int bt878_init_module(void)
 	       (BT878_VERSION_CODE >> 8) & 0xff,
 	       BT878_VERSION_CODE & 0xff);
 /*
-        bt878_check_chipset();
+	bt878_check_chipset();
 */
 	/* later we register inside of bt878_find_audio_dma()
 	 * because we may want to ignore certain cards */
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst.c	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.c	2005-05-08 18:13:30.000000000 +0200
@@ -1,25 +1,25 @@
 /*
-    Frontend-driver for TwinHan DST Frontend
-
-    Copyright (C) 2003 Jamie Honan
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 
+	Frontend/Card driver for TwinHan DST Frontend
+	Copyright (C) 2003 Jamie Honan
+	Copyright (C) 2004, 2005 Manu Abraham (manu@kromtek.com)
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful,
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the Free Software
+	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
+
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -31,59 +31,28 @@
 
 #include "dvb_frontend.h"
 #include "dst_priv.h"
-#include "dst.h"
+#include "dst_common.h"
 
-struct dst_state {
 
-	struct i2c_adapter* i2c;
+static unsigned int verbose = 1;
+module_param(verbose, int, 0644);
+MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");
 
-	struct bt878* bt;
+static unsigned int debug = 1;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "debug messages, default is 0 (yes)");
 
-	struct dvb_frontend_ops ops;
-
-	/* configuration settings */
-	const struct dst_config* config;
-
-	struct dvb_frontend frontend;
-
-	/* private demodulator data */
-	u8 tx_tuna[10];
-	u8 rx_tuna[10];
-	u8 rxbuffer[10];
-	u8 diseq_flags;
-	u8 dst_type;
-	u32 type_flags;
-	u32 frequency;		/* intermediate frequency in kHz for QPSK */
-	fe_spectral_inversion_t inversion;
-	u32 symbol_rate;	/* symbol rate in Symbols per second */
-	fe_code_rate_t fec;
-	fe_sec_voltage_t voltage;
-	fe_sec_tone_mode_t tone;
-	u32 decode_freq;
-	u8 decode_lock;
-	u16 decode_strength;
-	u16 decode_snr;
-	unsigned long cur_jiff;
-	u8 k22;
-	fe_bandwidth_t bandwidth;
-};
+static unsigned int dst_addons;
+module_param(dst_addons, int, 0644);
+MODULE_PARM_DESC(dst_addons, "CA daughterboard, default is 0 (no)");
+
+static unsigned int new_fw;
+module_param(new_fw, int, 0644);
+MODULE_PARM_DESC(new_fw, "Support for the new interface firmware, default 0");
 
-static unsigned int dst_verbose = 0;
-module_param(dst_verbose, int, 0644);
-MODULE_PARM_DESC(dst_verbose, "verbose startup messages, default is 1 (yes)");
-static unsigned int dst_debug = 0;
-module_param(dst_debug, int, 0644);
-MODULE_PARM_DESC(dst_debug, "debug messages, default is 0 (no)");
-
-#define dprintk	if (dst_debug) printk
-
-#define DST_TYPE_IS_SAT		0
-#define DST_TYPE_IS_TERR	1
-#define DST_TYPE_IS_CABLE	2
-
-#define DST_TYPE_HAS_NEWTUNE	1
-#define DST_TYPE_HAS_TS204	2
-#define DST_TYPE_HAS_SYMDIV	4
+
+
+#define dprintk	if (debug) printk
 
 #define HAS_LOCK	1
 #define ATTEMPT_TUNE	2
@@ -97,7 +66,7 @@ static void dst_packsize(struct dst_stat
 	bt878_device_control(state->bt, DST_IG_TS, &bits);
 }
 
-static int dst_gpio_outb(struct dst_state* state, u32 mask, u32 enbb, u32 outhigh)
+int dst_gpio_outb(struct dst_state* state, u32 mask, u32 enbb, u32 outhigh, int delay)
 {
 	union dst_gpio_packet enb;
 	union dst_gpio_packet bits;
@@ -105,26 +74,35 @@ static int dst_gpio_outb(struct dst_stat
 
 	enb.enb.mask = mask;
 	enb.enb.enable = enbb;
+	if (verbose > 4)
+		dprintk("%s: mask=[%04x], enbb=[%04x], outhigh=[%04x]\n", __FUNCTION__, mask, enbb, outhigh);
+
 	if ((err = bt878_device_control(state->bt, DST_IG_ENABLE, &enb)) < 0) {
-		dprintk("%s: dst_gpio_enb error (err == %i, mask == 0x%02x, enb == 0x%02x)\n", __FUNCTION__, err, mask, enbb);
+		dprintk("%s: dst_gpio_enb error (err == %i, mask == %02x, enb == %02x)\n", __FUNCTION__, err, mask, enbb);
 		return -EREMOTEIO;
 	}
 
+	msleep(1);
+
 	/* because complete disabling means no output, no need to do output packet */
 	if (enbb == 0)
 		return 0;
 
+	if (delay)
+		msleep(10);
+
 	bits.outp.mask = enbb;
 	bits.outp.highvals = outhigh;
 
 	if ((err = bt878_device_control(state->bt, DST_IG_WRITE, &bits)) < 0) {
-		dprintk("%s: dst_gpio_outb error (err == %i, enbb == 0x%02x, outhigh == 0x%02x)\n", __FUNCTION__, err, enbb, outhigh);
+		dprintk("%s: dst_gpio_outb error (err == %i, enbb == %02x, outhigh == %02x)\n", __FUNCTION__, err, enbb, outhigh);
 		return -EREMOTEIO;
 	}
 	return 0;
 }
+EXPORT_SYMBOL(dst_gpio_outb);
 
-static int dst_gpio_inb(struct dst_state *state, u8 * result)
+int dst_gpio_inb(struct dst_state *state, u8 * result)
 {
 	union dst_gpio_packet rd_packet;
 	int err;
@@ -139,135 +117,211 @@ static int dst_gpio_inb(struct dst_state
 	*result = (u8) rd_packet.rd.value;
 	return 0;
 }
+EXPORT_SYMBOL(dst_gpio_inb);
 
-#define DST_I2C_ENABLE	1
-#define DST_8820	2
-
-static int dst_reset8820(struct dst_state *state)
+int rdc_reset_state(struct dst_state *state)
 {
-	int retval;
-	/* pull 8820 gpio pin low, wait, high, wait, then low */
-	// dprintk ("%s: reset 8820\n", __FUNCTION__);
-	retval = dst_gpio_outb(state, DST_8820, DST_8820, 0);
-	if (retval < 0)
-		return retval;
+	if (verbose > 1)
+		dprintk("%s: Resetting state machine\n", __FUNCTION__);
+
+	if (dst_gpio_outb(state, RDC_8820_INT, RDC_8820_INT, 0, NO_DELAY) < 0) {
+		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		return -1;
+	}
+
 	msleep(10);
-	retval = dst_gpio_outb(state, DST_8820, DST_8820, DST_8820);
-	if (retval < 0)
-		return retval;
-	/* wait for more feedback on what works here *
-	   msleep(10);
-	   retval = dst_gpio_outb(dst, DST_8820, DST_8820, 0);
-	   if (retval < 0)
-	   return retval;
-	 */
+
+	if (dst_gpio_outb(state, RDC_8820_INT, RDC_8820_INT, RDC_8820_INT, NO_DELAY) < 0) {
+		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		msleep(10);
+		return -1;
+	}
+
 	return 0;
 }
+EXPORT_SYMBOL(rdc_reset_state);
 
-static int dst_i2c_enable(struct dst_state *state)
+int rdc_8820_reset(struct dst_state *state)
 {
-	int retval;
-	/* pull I2C enable gpio pin low, wait */
-	// dprintk ("%s: i2c enable\n", __FUNCTION__);
-	retval = dst_gpio_outb(state, ~0, DST_I2C_ENABLE, 0);
-	if (retval < 0)
-		return retval;
-	// dprintk ("%s: i2c enable delay\n", __FUNCTION__);
-	msleep(33);
+	if (verbose > 1)
+		dprintk("%s: Resetting DST\n", __FUNCTION__);
+
+	if (dst_gpio_outb(state, RDC_8820_RESET, RDC_8820_RESET, 0, NO_DELAY) < 0) {
+		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		return -1;
+	}
+	msleep(1);
+
+	if (dst_gpio_outb(state, RDC_8820_RESET, RDC_8820_RESET, RDC_8820_RESET, DELAY) < 0) {
+		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		return -1;
+	}
+
 	return 0;
 }
+EXPORT_SYMBOL(rdc_8820_reset);
 
-static int dst_i2c_disable(struct dst_state *state)
+int dst_pio_enable(struct dst_state *state)
 {
-	int retval;
-	/* release I2C enable gpio pin, wait */
-	// dprintk ("%s: i2c disable\n", __FUNCTION__);
-	retval = dst_gpio_outb(state, ~0, 0, 0);
-	if (retval < 0)
-		return retval;
-	// dprintk ("%s: i2c disable delay\n", __FUNCTION__);
-	msleep(33);
+	if (dst_gpio_outb(state, ~0, RDC_8820_PIO_0_ENABLE, 0, NO_DELAY) < 0) {
+		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		return -1;
+	}
+	msleep(1);
+
 	return 0;
 }
+EXPORT_SYMBOL(dst_pio_enable);
 
-static int dst_wait_dst_ready(struct dst_state *state)
+int dst_pio_disable(struct dst_state *state)
+{
+	if (dst_gpio_outb(state, ~0, RDC_8820_PIO_0_DISABLE, RDC_8820_PIO_0_DISABLE, NO_DELAY) < 0) {
+		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		return -1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(dst_pio_disable);
+
+int dst_wait_dst_ready(struct dst_state *state, u8 delay_mode)
 {
 	u8 reply;
-	int retval;
 	int i;
+
 	for (i = 0; i < 200; i++) {
-		retval = dst_gpio_inb(state, &reply);
-		if (retval < 0)
-			return retval;
-		if ((reply & DST_I2C_ENABLE) == 0) {
-			dprintk("%s: dst wait ready after %d\n", __FUNCTION__, i);
+		if (dst_gpio_inb(state, &reply) < 0) {
+			dprintk("%s: dst_gpio_inb ERROR !\n", __FUNCTION__);
+			return -1;
+		}
+
+		if ((reply & RDC_8820_PIO_0_ENABLE) == 0) {
+			if (verbose > 4)
+				dprintk("%s: dst wait ready after %d\n", __FUNCTION__, i);
 			return 1;
 		}
-		msleep(10);
+		msleep(1);
+	}
+	if (verbose > 1)
+		dprintk("%s: dst wait NOT ready after %d\n", __FUNCTION__, i);
+
+	return 0;
+}
+EXPORT_SYMBOL(dst_wait_dst_ready);
+
+int dst_error_recovery(struct dst_state *state)
+{
+	dprintk("%s: Trying to return from previous errors...\n", __FUNCTION__);
+	dst_pio_disable(state);
+	msleep(10);
+	dst_pio_enable(state);
+	msleep(10);
+
+	return 0;
+}
+EXPORT_SYMBOL(dst_error_recovery);
+
+int dst_error_bailout(struct dst_state *state)
+{
+	dprintk("%s: Trying to bailout from previous error...\n", __FUNCTION__);
+	rdc_8820_reset(state);
+	dst_pio_disable(state);
+	msleep(10);
+
+	return 0;
+}
+EXPORT_SYMBOL(dst_error_bailout);
+
+
+int dst_comm_init(struct dst_state* state)
+{
+	if (verbose > 1)
+		dprintk ("%s: Initializing DST..\n", __FUNCTION__);
+	if ((dst_pio_enable(state)) < 0) {
+		dprintk("%s: PIO Enable Failed.\n", __FUNCTION__);
+		return -1;
+	}
+	if ((rdc_reset_state(state)) < 0) {
+		dprintk("%s: RDC 8820 State RESET Failed.\n", __FUNCTION__);
+		return -1;
 	}
-	dprintk("%s: dst wait NOT ready after %d\n", __FUNCTION__, i);
 	return 0;
 }
+EXPORT_SYMBOL(dst_comm_init);
+
 
-static int write_dst(struct dst_state *state, u8 * data, u8 len)
+int write_dst(struct dst_state *state, u8 *data, u8 len)
 {
 	struct i2c_msg msg = {
 		.addr = state->config->demod_address,.flags = 0,.buf = data,.len = len
 	};
+
 	int err;
 	int cnt;
-
-	if (dst_debug && dst_verbose) {
+	if (debug && (verbose > 4)) {
 		u8 i;
-		dprintk("%s writing", __FUNCTION__);
-		for (i = 0; i < len; i++) {
-			dprintk(" 0x%02x", data[i]);
+		if (verbose > 4) {
+			dprintk("%s writing", __FUNCTION__);
+			for (i = 0; i < len; i++)
+				dprintk(" %02x", data[i]);
+			dprintk("\n");
 		}
-		dprintk("\n");
 	}
-	msleep(30);
-	for (cnt = 0; cnt < 4; cnt++) {
+	for (cnt = 0; cnt < 2; cnt++) {
 		if ((err = i2c_transfer(state->i2c, &msg, 1)) < 0) {
-			dprintk("%s: write_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)\n", __FUNCTION__, err, len, data[0]);
-			dst_i2c_disable(state);
-			msleep(500);
-			dst_i2c_enable(state);
-			msleep(500);
+			dprintk("%s: _write_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)\n", __FUNCTION__, err, len, data[0]);
+			dst_error_recovery(state);
 			continue;
 		} else
 			break;
 	}
-	if (cnt >= 4)
-		return -EREMOTEIO;
+
+	if (cnt >= 2) {
+		if (verbose > 1)
+			printk("%s: RDC 8820 RESET...\n", __FUNCTION__);
+		dst_error_bailout(state);
+
+		return -1;
+	}
+
 	return 0;
 }
+EXPORT_SYMBOL(write_dst);
 
-static int read_dst(struct dst_state *state, u8 * ret, u8 len)
+int read_dst(struct dst_state *state, u8 * ret, u8 len)
 {
 	struct i2c_msg msg = {.addr = state->config->demod_address,.flags = I2C_M_RD,.buf = ret,.len = len };
 	int err;
 	int cnt;
 
-	for (cnt = 0; cnt < 4; cnt++) {
+	for (cnt = 0; cnt < 2; cnt++) {
 		if ((err = i2c_transfer(state->i2c, &msg, 1)) < 0) {
+
 			dprintk("%s: read_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)\n", __FUNCTION__, err, len, ret[0]);
-			dst_i2c_disable(state);
-			dst_i2c_enable(state);
+			dst_error_recovery(state);
+
 			continue;
 		} else
 			break;
 	}
-	if (cnt >= 4)
-		return -EREMOTEIO;
-	dprintk("%s reply is 0x%x\n", __FUNCTION__, ret[0]);
-	if (dst_debug && dst_verbose) {
+	if (cnt >= 2) {
+		if (verbose > 1)
+			printk("%s: RDC 8820 RESET...\n", __FUNCTION__);
+		dst_error_bailout(state);
+
+		return -1;
+	}
+	if (debug && (verbose > 4)) {
+		dprintk("%s reply is 0x%x\n", __FUNCTION__, ret[0]);
 		for (err = 1; err < len; err++)
 			dprintk(" 0x%x", ret[err]);
 		if (err > 1)
 			dprintk("\n");
 	}
+
 	return 0;
 }
+EXPORT_SYMBOL(read_dst);
 
 static int dst_set_freq(struct dst_state *state, u32 freq)
 {
@@ -422,7 +476,7 @@ static int dst_set_symbolrate(struct dst
 	return 0;
 }
 
-static u8 dst_check_sum(u8 * buf, u32 len)
+u8 dst_check_sum(u8 * buf, u32 len)
 {
 	u32 i;
 	u8 val = 0;
@@ -433,28 +487,7 @@ static u8 dst_check_sum(u8 * buf, u32 le
 	}
 	return ((~val) + 1);
 }
-
-struct dst_types {
-	char *mstr;
-	int offs;
-	u8 dst_type;
-	u32 type_flags;
-};
-
-static struct dst_types dst_tlist[] = {
-	{"DST-020", 0, DST_TYPE_IS_SAT, DST_TYPE_HAS_SYMDIV},
-	{"DST-030", 0, DST_TYPE_IS_SAT, DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE},
-	{"DST-03T", 0, DST_TYPE_IS_SAT, DST_TYPE_HAS_SYMDIV | DST_TYPE_HAS_TS204},
-	{"DST-MOT", 0, DST_TYPE_IS_SAT, DST_TYPE_HAS_SYMDIV},
-	{"DST-CI",  1, DST_TYPE_IS_SAT, DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE},
-	{"DSTMCI",  1, DST_TYPE_IS_SAT, DST_TYPE_HAS_NEWTUNE},
-	{"DSTFCI",  1, DST_TYPE_IS_SAT, DST_TYPE_HAS_NEWTUNE},
-	{"DCTNEW",  1, DST_TYPE_IS_CABLE, DST_TYPE_HAS_NEWTUNE},
-	{"DCT-CI",  1, DST_TYPE_IS_CABLE, DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_TS204},
-	{"DTTDIG",  1, DST_TYPE_IS_TERR, 0}
-};
-
-/* DCTNEW and DCT-CI are guesses */
+EXPORT_SYMBOL(dst_check_sum);
 
 static void dst_type_flags_print(u32 type_flags)
 {
@@ -465,93 +498,260 @@ static void dst_type_flags_print(u32 typ
 		printk(" 0x%x ts204", DST_TYPE_HAS_TS204);
 	if (type_flags & DST_TYPE_HAS_SYMDIV)
 		printk(" 0x%x symdiv", DST_TYPE_HAS_SYMDIV);
+	if (type_flags & DST_TYPE_HAS_FW_1)
+		printk(" 0x%x firmware version = 1", DST_TYPE_HAS_FW_1);
+	if (type_flags & DST_TYPE_HAS_FW_2)
+		printk(" 0x%x firmware version = 2", DST_TYPE_HAS_FW_2);
+	if (type_flags & DST_TYPE_HAS_FW_3)
+		printk(" 0x%x firmware version = 3", DST_TYPE_HAS_FW_3);
+
 	printk("\n");
 }
 
-static int dst_type_print(u8 type)
+
+static int dst_type_print (u8 type)
 {
 	char *otype;
 	switch (type) {
 	case DST_TYPE_IS_SAT:
 		otype = "satellite";
 		break;
+
 	case DST_TYPE_IS_TERR:
 		otype = "terrestrial";
 		break;
+
 	case DST_TYPE_IS_CABLE:
 		otype = "cable";
 		break;
+
 	default:
 		printk("%s: invalid dst type %d\n", __FUNCTION__, type);
 		return -EINVAL;
 	}
 	printk("DST type : %s\n", otype);
+
 	return 0;
 }
 
-static int dst_check_ci(struct dst_state *state)
+/*
+	Known cards list
+	Satellite
+	-------------------
+
+	VP-1020   DST-MOT	LG(old), TS=188
+
+	VP-1020   DST-03T	LG(new), TS=204
+	VP-1022   DST-03T	LG(new), TS=204
+	VP-1025   DST-03T	LG(new), TS=204
+
+	VP-1030   DSTMCI,	LG(new), TS=188
+	VP-1032   DSTMCI,	LG(new), TS=188
+
+	Cable
+	-------------------
+	VP-2030   DCT-CI,	Samsung, TS=204
+	VP-2021   DCT-CI,	Unknown, TS=204
+	VP-2031   DCT-CI,	Philips, TS=188
+	VP-2040   DCT-CI,	Philips, TS=188, with CA daughter board
+	VP-2040   DCT-CI,	Philips, TS=204, without CA daughter board
+
+	Terrestrial
+	-------------------
+	VP-3050  DTTNXT			 TS=188
+	VP-3040  DTT-CI,	Philips, TS=188
+	VP-3040  DTT-CI,	Philips, TS=204
+
+	ATSC
+	-------------------
+	VP-3220  ATSCDI,		 TS=188
+	VP-3250  ATSCAD,		 TS=188
+
+*/
+
+struct dst_types dst_tlist[] = {
+	{
+		.device_id = "DST-020",
+		.offset = 0,
+		.dst_type =  DST_TYPE_IS_SAT,
+		.type_flags = DST_TYPE_HAS_SYMDIV | DST_TYPE_HAS_FW_1,
+		.dst_feature = 0
+	},	/*	obsolete	*/
+
+	{
+		.device_id = "DST-030",
+		.offset =  0,
+		.dst_type = DST_TYPE_IS_SAT,
+		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_1,
+		.dst_feature = 0
+	},	/*	obsolete	*/
+
+	{
+		.device_id = "DST-03T",
+		.offset = 0,
+		.dst_type = DST_TYPE_IS_SAT,
+		.type_flags = DST_TYPE_HAS_SYMDIV | DST_TYPE_HAS_TS204 | DST_TYPE_HAS_FW_2,
+		.dst_feature = DST_TYPE_HAS_DISEQC3 | DST_TYPE_HAS_DISEQC4 | DST_TYPE_HAS_DISEQC5
+							 | DST_TYPE_HAS_MAC | DST_TYPE_HAS_MOTO
+	 },
+
+	{
+		.device_id = "DST-MOT",
+		.offset =  0,
+		.dst_type = DST_TYPE_IS_SAT,
+		.type_flags = DST_TYPE_HAS_SYMDIV | DST_TYPE_HAS_FW_1,
+		.dst_feature = 0
+	},	/*	obsolete	*/
+
+	{
+		.device_id = "DST-CI",
+		.offset = 1,
+		.dst_type = DST_TYPE_IS_SAT,
+		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_1,
+		.dst_feature = DST_TYPE_HAS_CA
+	},	/* unknown to vendor	*/
+
+	{
+		.device_id = "DSTMCI",
+		.offset = 1,
+		.dst_type = DST_TYPE_IS_SAT,
+		.type_flags = DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_2,
+		.dst_feature = DST_TYPE_HAS_CA | DST_TYPE_HAS_DISEQC3 | DST_TYPE_HAS_DISEQC4
+							| DST_TYPE_HAS_MOTO | DST_TYPE_HAS_MAC
+	},
+
+	{
+		.device_id = "DSTFCI",
+		.offset = 1,
+		.dst_type = DST_TYPE_IS_SAT,
+		.type_flags = DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_1,
+		.dst_feature = 0
+	},	/* unknown to vendor	*/
+
+	{
+		.device_id = "DCT-CI",
+		.offset = 1,
+		.dst_type = DST_TYPE_IS_CABLE,
+		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_1									| DST_TYPE_HAS_FW_2,
+		.dst_feature = DST_TYPE_HAS_CA
+	},
+
+	{
+		.device_id = "DCTNEW",
+		.offset = 1,
+		.dst_type = DST_TYPE_IS_CABLE,
+		.type_flags = DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_3,
+		.dst_feature = 0
+	},
+
+	{
+		.device_id = "DTT-CI",
+		.offset = 1,
+		.dst_type = DST_TYPE_IS_TERR,
+		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_FW_2,
+		.dst_feature = 0
+	},
+
+	{
+		.device_id = "DTTDIG",
+		.offset = 1,
+		.dst_type = DST_TYPE_IS_TERR,
+		.type_flags = DST_TYPE_HAS_FW_2,
+		.dst_feature = 0
+	},
+
+	{
+		.device_id = "DTTNXT",
+		.offset = 1,
+		.dst_type = DST_TYPE_IS_TERR,
+		.type_flags = DST_TYPE_HAS_FW_2,
+		.dst_feature = DST_TYPE_HAS_ANALOG
+	},
+
+	{
+		.device_id = "ATSCDI",
+		.offset = 1,
+		.dst_type = DST_TYPE_IS_ATSC,
+		.type_flags = DST_TYPE_HAS_FW_2,
+		.dst_feature = 0
+	},
+
+	{
+		.device_id = "ATSCAD",
+		.offset = 1,
+		.dst_type = DST_TYPE_IS_ATSC,
+		.type_flags = DST_TYPE_HAS_FW_2,
+		.dst_feature = 0
+	},
+
+	{ }
+
+};
+
+
+static int dst_get_device_id(struct dst_state *state)
 {
-	u8 txbuf[8];
-	u8 rxbuf[8];
-	int retval;
+	u8 reply;
+
 	int i;
-	struct dst_types *dsp;
-	u8 use_dst_type;
-	u32 use_type_flags;
-
-	memset(txbuf, 0, sizeof(txbuf));
-	txbuf[1] = 6;
-	txbuf[7] = dst_check_sum(txbuf, 7);
-
-	dst_i2c_enable(state);
-	dst_reset8820(state);
-	retval = write_dst(state, txbuf, 8);
-	if (retval < 0) {
-		dst_i2c_disable(state);
-		dprintk("%s: write not successful, maybe no card?\n", __FUNCTION__);
-		return retval;
-	}
-	msleep(3);
-	retval = read_dst(state, rxbuf, 1);
-	dst_i2c_disable(state);
-	if (retval < 0) {
-		dprintk("%s: read not successful, maybe no card?\n", __FUNCTION__);
-		return retval;
-	}
-	if (rxbuf[0] != 0xff) {
-		dprintk("%s: write reply not 0xff, not ci (%02x)\n", __FUNCTION__, rxbuf[0]);
-		return retval;
-	}
-	if (!dst_wait_dst_ready(state))
-		return 0;
-	// dst_i2c_enable(i2c); Dimitri
-	retval = read_dst(state, rxbuf, 8);
-	dst_i2c_disable(state);
-	if (retval < 0) {
-		dprintk("%s: read not successful\n", __FUNCTION__);
-		return retval;
+	struct dst_types *p_dst_type;
+	u8 use_dst_type = 0;
+	u32 use_type_flags = 0;
+
+	static u8 device_type[8] = {0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff};
+
+	device_type[7] = dst_check_sum(device_type, 7);
+
+	if (write_dst(state, device_type, FIXED_COMM))
+		return -1;		/*	Write failed		*/
+
+	if ((dst_pio_disable(state)) < 0)
+		return -1;
+
+	if (read_dst(state, &reply, GET_ACK))
+		return -1;		/*	Read failure		*/
+
+	if (reply != ACK) {
+		dprintk("%s: Write not Acknowledged! [Reply=0x%02x]\n", __FUNCTION__, reply);
+		return -1;		/*	Unack'd write		*/
 	}
-	if (rxbuf[7] != dst_check_sum(rxbuf, 7)) {
-		dprintk("%s: checksum failure\n", __FUNCTION__);
-		return retval;
+
+	if (!dst_wait_dst_ready(state, DEVICE_INIT))
+		return -1;		/*	DST not ready yet	*/
+
+	if (read_dst(state, state->rxbuffer, FIXED_COMM))
+		return -1;
+
+	dst_pio_disable(state);
+
+	if (state->rxbuffer[7] != dst_check_sum(state->rxbuffer, 7)) {
+		dprintk("%s: Checksum failure! \n", __FUNCTION__);
+		return -1;		/*	Checksum failure	*/
 	}
-	rxbuf[7] = '\0';
-	for (i = 0, dsp = &dst_tlist[0]; i < sizeof(dst_tlist) / sizeof(dst_tlist[0]); i++, dsp++) {
-		if (!strncmp(&rxbuf[dsp->offs], dsp->mstr, strlen(dsp->mstr))) {
-			use_type_flags = dsp->type_flags;
-			use_dst_type = dsp->dst_type;
-			printk("%s: recognize %s\n", __FUNCTION__, dsp->mstr);
+
+	state->rxbuffer[7] = '\0';
+
+	for (i = 0, p_dst_type = dst_tlist; i < ARRAY_SIZE (dst_tlist); i++, p_dst_type++) {
+		if (!strncmp (&state->rxbuffer[p_dst_type->offset], p_dst_type->device_id, strlen (p_dst_type->device_id))) {
+			use_type_flags = p_dst_type->type_flags;
+			use_dst_type = p_dst_type->dst_type;
+
+			/*	Card capabilities	*/
+			state->dst_hw_cap = p_dst_type->dst_feature;
+			printk ("%s: Recognise [%s]\n", __FUNCTION__, p_dst_type->device_id);
+
 			break;
 		}
 	}
-	if (i >= sizeof(dst_tlist) / sizeof(dst_tlist[0])) {
-		printk("%s: unable to recognize %s or %s\n", __FUNCTION__, &rxbuf[0], &rxbuf[1]);
-		printk("%s please email linux-dvb@linuxtv.org with this type in\n", __FUNCTION__);
+
+	if (i >= sizeof (dst_tlist) / sizeof (dst_tlist [0])) {
+		printk("%s: Unable to recognize %s or %s\n", __FUNCTION__, &state->rxbuffer[0], &state->rxbuffer[1]);
+		printk("%s: please email linux-dvb@linuxtv.org with this type in\n", __FUNCTION__);
 		use_dst_type = DST_TYPE_IS_SAT;
 		use_type_flags = DST_TYPE_HAS_SYMDIV;
 	}
-	dst_type_print(use_dst_type);
 
+	dst_type_print(use_dst_type);
 	state->type_flags = use_type_flags;
 	state->dst_type = use_dst_type;
 	dst_type_flags_print(state->type_flags);
@@ -559,50 +759,89 @@ static int dst_check_ci(struct dst_state
 	if (state->type_flags & DST_TYPE_HAS_TS204) {
 		dst_packsize(state, 204);
 	}
+
 	return 0;
 }
 
-static int dst_command(struct dst_state* state, u8 * data, u8 len)
+static int dst_probe(struct dst_state *state)
+{
+	if ((rdc_8820_reset(state)) < 0) {
+		dprintk("%s: RDC 8820 RESET Failed.\n", __FUNCTION__);
+		return -1;
+	}
+	msleep(4000);
+	if ((dst_comm_init(state)) < 0) {
+		dprintk("%s: DST Initialization Failed.\n", __FUNCTION__);
+		return -1;
+	}
+
+	if (dst_get_device_id(state) < 0) {
+		dprintk("%s: unknown device.\n", __FUNCTION__);
+		return -1;
+	}
+
+	return 0;
+}
+
+int dst_command(struct dst_state* state, u8 * data, u8 len)
 {
-	int retval;
 	u8 reply;
+	if ((dst_comm_init(state)) < 0) {
+		dprintk("%s: DST Communication Initialization Failed.\n", __FUNCTION__);
+		return -1;
+	}
 
-	dst_i2c_enable(state);
-	dst_reset8820(state);
-	retval = write_dst(state, data, len);
-	if (retval < 0) {
-		dst_i2c_disable(state);
-		dprintk("%s: write not successful\n", __FUNCTION__);
-		return retval;
+	if (write_dst(state, data, len)) {
+		if (verbose > 1)
+			dprintk("%s: Tring to recover.. \n", __FUNCTION__);
+		if ((dst_error_recovery(state)) < 0) {
+			dprintk("%s: Recovery Failed.\n", __FUNCTION__);
+			return -1;
+		}
+		return -1;
 	}
-	msleep(33);
-	retval = read_dst(state, &reply, 1);
-	dst_i2c_disable(state);
-	if (retval < 0) {
-		dprintk("%s: read verify  not successful\n", __FUNCTION__);
-		return retval;
+	if ((dst_pio_disable(state)) < 0) {
+		dprintk("%s: PIO Disable Failed.\n", __FUNCTION__);
+		return -1;
 	}
-	if (reply != 0xff) {
-		dprintk("%s: write reply not 0xff 0x%02x \n", __FUNCTION__, reply);
-		return 0;
+
+	if (read_dst(state, &reply, GET_ACK)) {
+		if (verbose > 1)
+			dprintk("%s: Trying to recover.. \n", __FUNCTION__);
+		if ((dst_error_recovery(state)) < 0) {
+			dprintk("%s: Recovery Failed.\n", __FUNCTION__);
+			return -1;
+		}
+		return -1;
+	}
+
+	if (reply != ACK) {
+		dprintk("%s: write not acknowledged 0x%02x \n", __FUNCTION__, reply);
+		return -1;
 	}
 	if (len >= 2 && data[0] == 0 && (data[1] == 1 || data[1] == 3))
 		return 0;
-	if (!dst_wait_dst_ready(state))
-		return 0;
-	// dst_i2c_enable(i2c); Per dimitri
-	retval = read_dst(state, state->rxbuffer, 8);
-	dst_i2c_disable(state);
-	if (retval < 0) {
-		dprintk("%s: read not successful\n", __FUNCTION__);
-		return 0;
+	if (!dst_wait_dst_ready(state, NO_DELAY))
+		return -1;
+
+	if (read_dst(state, state->rxbuffer, FIXED_COMM)) {
+		if (verbose > 1)
+			dprintk("%s: Trying to recover.. \n", __FUNCTION__);
+		if ((dst_error_recovery(state)) < 0) {
+			dprintk("%s: Recovery failed.\n", __FUNCTION__);
+			return -1;
+		}
+		return -1;
 	}
+
 	if (state->rxbuffer[7] != dst_check_sum(state->rxbuffer, 7)) {
 		dprintk("%s: checksum failure\n", __FUNCTION__);
-		return 0;
+		return -1;
 	}
+
 	return 0;
 }
+EXPORT_SYMBOL(dst_command);
 
 static int dst_get_signal(struct dst_state* state)
 {
@@ -646,11 +885,17 @@ static int dst_tone_power_cmd(struct dst
 		paket[4] = 0;
 	else
 		paket[4] = 1;
+
 	if (state->tone == SEC_TONE_ON)
-		paket[2] = state->k22;
+		paket[2] = 0x02;
 	else
 		paket[2] = 0;
-	paket[7] = dst_check_sum(&paket[0], 7);
+	if (state->minicmd == SEC_MINI_A)
+		paket[3] = 0x02;
+	else
+		paket[3] = 0;
+
+	paket[7] = dst_check_sum (paket, 7);
 	dst_command(state, paket, 8);
 	return 0;
 }
@@ -658,21 +903,28 @@ static int dst_tone_power_cmd(struct dst
 static int dst_get_tuna(struct dst_state* state)
 {
 	int retval;
+
 	if ((state->diseq_flags & ATTEMPT_TUNE) == 0)
 		return 0;
+
 	state->diseq_flags &= ~(HAS_LOCK);
-	if (!dst_wait_dst_ready(state))
+	if (!dst_wait_dst_ready(state, NO_DELAY))
 		return 0;
+
+	msleep(10);
+
 	if (state->type_flags & DST_TYPE_HAS_NEWTUNE) {
 		/* how to get variable length reply ???? */
 		retval = read_dst(state, state->rx_tuna, 10);
 	} else {
-		retval = read_dst(state, &state->rx_tuna[2], 8);
+		retval = read_dst(state, &state->rx_tuna[2], FIXED_COMM);
 	}
+
 	if (retval < 0) {
 		dprintk("%s: read not successful\n", __FUNCTION__);
 		return 0;
 	}
+
 	if (state->type_flags & DST_TYPE_HAS_NEWTUNE) {
 		if (state->rx_tuna[9] != dst_check_sum(&state->rx_tuna[0], 9)) {
 			dprintk("%s: checksum failure?\n", __FUNCTION__);
@@ -717,32 +969,41 @@ static int dst_write_tuna(struct dvb_fro
 			dst_set_voltage(fe, SEC_VOLTAGE_13);
 	}
 	state->diseq_flags &= ~(HAS_LOCK | ATTEMPT_TUNE);
-	dst_i2c_enable(state);
+
+	if ((dst_comm_init(state)) < 0) {
+		dprintk("%s: DST Communication initialization failed.\n", __FUNCTION__);
+		return -1;
+	}
+
 	if (state->type_flags & DST_TYPE_HAS_NEWTUNE) {
-		dst_reset8820(state);
 		state->tx_tuna[9] = dst_check_sum(&state->tx_tuna[0], 9);
 		retval = write_dst(state, &state->tx_tuna[0], 10);
+
 	} else {
 		state->tx_tuna[9] = dst_check_sum(&state->tx_tuna[2], 7);
-		retval = write_dst(state, &state->tx_tuna[2], 8);
+		retval = write_dst(state, &state->tx_tuna[2], FIXED_COMM);
 	}
 	if (retval < 0) {
-		dst_i2c_disable(state);
+		dst_pio_disable(state);
 		dprintk("%s: write not successful\n", __FUNCTION__);
 		return retval;
 	}
-	msleep(3);
-	retval = read_dst(state, &reply, 1);
-	dst_i2c_disable(state);
-	if (retval < 0) {
-		dprintk("%s: read verify  not successful\n", __FUNCTION__);
-		return retval;
+
+	if ((dst_pio_disable(state)) < 0) {
+		dprintk("%s: DST PIO disable failed !\n", __FUNCTION__);
+		return -1;
 	}
-	if (reply != 0xff) {
-		dprintk("%s: write reply not 0xff 0x%02x \n", __FUNCTION__, reply);
+
+	if ((read_dst(state, &reply, GET_ACK) < 0)) {
+		dprintk("%s: read verify not successful.\n", __FUNCTION__);
+		return -1;
+	}
+	if (reply != ACK) {
+		dprintk("%s: write not acknowledged 0x%02x \n", __FUNCTION__, reply);
 		return 0;
 	}
 	state->diseq_flags |= ATTEMPT_TUNE;
+
 	return dst_get_tuna(state);
 }
 
@@ -796,22 +1057,25 @@ static int dst_set_voltage(struct dvb_fr
 			need_cmd = 1;
 		state->diseq_flags |= HAS_POWER;
 		break;
+
 	case SEC_VOLTAGE_18:
 		if ((state->diseq_flags & HAS_POWER) == 0)
 			need_cmd = 1;
 		state->diseq_flags |= HAS_POWER;
 		val[8] |= 0x40;
 		break;
+
 	case SEC_VOLTAGE_OFF:
 		need_cmd = 1;
 		state->diseq_flags &= ~(HAS_POWER | HAS_LOCK | ATTEMPT_TUNE);
 		break;
+
 	default:
 		return -EINVAL;
 	}
-	if (need_cmd) {
+	if (need_cmd)
 		dst_tone_power_cmd(state);
-	}
+
 	return 0;
 }
 
@@ -832,13 +1096,16 @@ static int dst_set_tone(struct dvb_front
 	switch (tone) {
 	case SEC_TONE_OFF:
 		break;
+
 	case SEC_TONE_ON:
 		val[8] |= 1;
 		break;
+
 	default:
 		return -EINVAL;
 	}
 	dst_tone_power_cmd(state);
+
 	return 0;
 }
 
@@ -913,10 +1180,16 @@ static int dst_set_frontend(struct dvb_f
 	struct dst_state* state = (struct dst_state*) fe->demodulator_priv;
 
 	dst_set_freq(state, p->frequency);
+	if (verbose > 4)
+		dprintk("Set Frequency = [%d]\n", p->frequency);
+
 	dst_set_inversion(state, p->inversion);
 	if (state->dst_type == DST_TYPE_IS_SAT) {
 		dst_set_fec(state, p->u.qpsk.fec_inner);
 		dst_set_symbolrate(state, p->u.qpsk.symbol_rate);
+		if (verbose > 4)
+			dprintk("Set Symbolrate = [%d]\n", p->u.qpsk.symbol_rate);
+
 	} else if (state->dst_type == DST_TYPE_IS_TERR) {
 		dst_set_bandwidth(state, p->u.ofdm.bandwidth);
 	} else if (state->dst_type == DST_TYPE_IS_CABLE) {
@@ -958,50 +1231,47 @@ static struct dvb_frontend_ops dst_dvbt_
 static struct dvb_frontend_ops dst_dvbs_ops;
 static struct dvb_frontend_ops dst_dvbc_ops;
 
-struct dvb_frontend* dst_attach(const struct dst_config* config,
-				struct i2c_adapter* i2c,
-				struct bt878 *bt)
-{
-	struct dst_state* state = NULL;
-
-	/* allocate memory for the internal state */
-	state = (struct dst_state*) kmalloc(sizeof(struct dst_state), GFP_KERNEL);
-	if (state == NULL) goto error;
-
-	/* setup the state */
-	state->config = config;
-	state->i2c = i2c;
-	state->bt = bt;
+struct dst_state* dst_attach(struct dst_state *state, struct dvb_adapter *dvb_adapter)
+{
 
-	/* check if the demod is there */
-	if (dst_check_ci(state) < 0) goto error;
+	/* check if the ASIC is there */
+	if (dst_probe(state) < 0) {
+		if (state)
+			kfree(state);
 
+		return NULL;
+	}
 	/* determine settings based on type */
 	switch (state->dst_type) {
 	case DST_TYPE_IS_TERR:
 		memcpy(&state->ops, &dst_dvbt_ops, sizeof(struct dvb_frontend_ops));
 		break;
+
 	case DST_TYPE_IS_CABLE:
 		memcpy(&state->ops, &dst_dvbc_ops, sizeof(struct dvb_frontend_ops));
 		break;
+
 	case DST_TYPE_IS_SAT:
 		memcpy(&state->ops, &dst_dvbs_ops, sizeof(struct dvb_frontend_ops));
 		break;
+
 	default:
-		printk("dst: unknown frontend type. please report to the LinuxTV.org DVB mailinglist.\n");
-		goto error;
+		printk("%s: unknown DST type. please report to the LinuxTV.org DVB mailinglist.\n", __FUNCTION__);
+		if (state)
+			kfree(state);
+
+		return NULL;
 	}
 
 	/* create dvb_frontend */
 	state->frontend.ops = &state->ops;
 	state->frontend.demodulator_priv = state;
-	return &state->frontend;
 
-error:
-	kfree(state);
-	return NULL;
+	return state;				/*	Manu (DST is a card not a frontend)	*/
 }
 
+EXPORT_SYMBOL(dst_attach);
+
 static struct dvb_frontend_ops dst_dvbt_ops = {
 
 	.info = {
@@ -1051,6 +1321,7 @@ static struct dvb_frontend_ops dst_dvbs_
 	.read_signal_strength = dst_read_signal_strength,
 	.read_snr = dst_read_snr,
 
+	.diseqc_send_burst = dst_set_tone,
 	.diseqc_send_master_cmd = dst_set_diseqc,
 	.set_voltage = dst_set_voltage,
 	.set_tone = dst_set_tone,
@@ -1082,8 +1353,7 @@ static struct dvb_frontend_ops dst_dvbc_
 	.read_snr = dst_read_snr,
 };
 
+
 MODULE_DESCRIPTION("DST DVB-S/T/C Combo Frontend driver");
-MODULE_AUTHOR("Jamie Honan");
+MODULE_AUTHOR("Jamie Honan, Manu Abraham");
 MODULE_LICENSE("GPL");
-
-EXPORT_SYMBOL(dst_attach);
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst.h	2005-05-08 18:09:01.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,40 +0,0 @@
-/*
-    Frontend-driver for TwinHan DST Frontend
-
-    Copyright (C) 2003 Jamie Honan
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-*/
-
-#ifndef DST_H
-#define DST_H
-
-#include <linux/dvb/frontend.h>
-#include <linux/device.h>
-#include "bt878.h"
-
-struct dst_config
-{
-	/* the demodulator's i2c address */
-	u8 demod_address;
-};
-
-extern struct dvb_frontend* dst_attach(const struct dst_config* config,
-				       struct i2c_adapter* i2c,
-				       struct bt878 *bt);
-
-#endif // DST_H
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_ca.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_ca.c	2005-05-08 18:13:30.000000000 +0200
@@ -0,0 +1,868 @@
+/*
+	CA-driver for TwinHan DST Frontend/Card
+
+	Copyright (C) 2004, 2005 Manu Abraham (manu@kromtek.com)
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful,
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the Free Software
+	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <linux/dvb/ca.h>
+#include "dvbdev.h"
+#include "dvb_frontend.h"
+
+#include "dst_ca.h"
+#include "dst_common.h"
+
+static unsigned int verbose = 1;
+module_param(verbose, int, 0644);
+MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");
+
+static unsigned int debug = 1;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(dst_ca_debug, "debug messages, default is 0 (yes)");
+
+static unsigned int session;
+module_param(session, int, 0644);
+MODULE_PARM_DESC(session, "Support for hardware that has multiple sessions, default 0");
+
+static unsigned int new_ca;
+module_param(new_ca, int, 0644);
+MODULE_PARM_DESC(new_ca, "Support for the new CA interface firmware, default 0");
+
+#define dprintk if (debug) printk
+
+
+static int ca_set_slot_descr(void)
+{
+	/*	We could make this more graceful ?	*/
+	return -EOPNOTSUPP;
+}
+
+static int ca_set_pid(void)
+{
+	/*	We could make this more graceful ?	*/
+	return -EOPNOTSUPP;
+}
+
+
+static int put_checksum(u8 *check_string, int length)
+{
+	u8 i = 0, checksum = 0;
+
+	if (verbose > 3) {
+		dprintk("%s: ========================= Checksum calculation ===========================\n", __FUNCTION__);
+		dprintk("%s: String Length=[0x%02x]\n", __FUNCTION__, length);
+
+		dprintk("%s: String=[", __FUNCTION__);
+	}
+	while (i < length) {
+		if (verbose > 3)
+			dprintk(" %02x", check_string[i]);
+		checksum += check_string[i];
+		i++;
+	}
+	if (verbose > 3) {
+		dprintk(" ]\n");
+		dprintk("%s: Sum=[%02x]\n", __FUNCTION__, checksum);
+	}
+	check_string[length] = ~checksum + 1;
+	if (verbose > 3) {
+		dprintk("%s: Checksum=[%02x]\n", __FUNCTION__, check_string[length]);
+		dprintk("%s: ==========================================================================\n", __FUNCTION__);
+	}
+
+	return 0;
+}
+
+static int dst_ci_command(struct dst_state* state, u8 * data, u8 *ca_string, u8 len, int read)
+{
+	u8 reply;
+
+	dst_comm_init(state);
+	msleep(65);
+
+	if (write_dst(state, data, len)) {
+		dprintk("%s: Write not successful, trying to recover\n", __FUNCTION__);
+		dst_error_recovery(state);
+		return -1;
+	}
+
+	if ((dst_pio_disable(state)) < 0) {
+		dprintk("%s: DST PIO disable failed.\n", __FUNCTION__);
+		return -1;
+	}
+
+	if (read_dst(state, &reply, GET_ACK) < 0) {
+		dprintk("%s: Read not successful, trying to recover\n", __FUNCTION__);
+		dst_error_recovery(state);
+		return -1;
+	}
+
+	if (read) {
+		if (! dst_wait_dst_ready(state, LONG_DELAY)) {
+			dprintk("%s: 8820 not ready\n", __FUNCTION__);
+			return -1;
+		}
+
+		if (read_dst(state, ca_string, 128) < 0) {	/*	Try to make this dynamic	*/
+			dprintk("%s: Read not successful, trying to recover\n", __FUNCTION__);
+			dst_error_recovery(state);
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+
+static int dst_put_ci(struct dst_state *state, u8 *data, int len, u8 *ca_string, int read)
+{
+	u8 dst_ca_comm_err = 0;
+
+	while (dst_ca_comm_err < RETRIES) {
+		dst_comm_init(state);
+		if (verbose > 2)
+			dprintk("%s: Put Command\n", __FUNCTION__);
+		if (dst_ci_command(state, data, ca_string, len, read)) {	// If error
+			dst_error_recovery(state);
+			dst_ca_comm_err++; // work required here.
+		}
+		break;
+	}
+
+	return 0;
+}
+
+
+
+static int ca_get_app_info(struct dst_state *state)
+{
+	static u8 command[8] = {0x07, 0x40, 0x01, 0x00, 0x01, 0x00, 0x00, 0xff};
+
+	put_checksum(&command[0], command[0]);
+	if ((dst_put_ci(state, command, sizeof(command), state->messages, GET_REPLY)) < 0) {
+		dprintk("%s: -->dst_put_ci FAILED !\n", __FUNCTION__);
+		return -1;
+	}
+	if (verbose > 1) {
+		dprintk("%s: -->dst_put_ci SUCCESS !\n", __FUNCTION__);
+
+		dprintk("%s: ================================ CI Module Application Info ======================================\n", __FUNCTION__);
+		dprintk("%s: Application Type=[%d], Application Vendor=[%d], Vendor Code=[%d]\n%s: Application info=[%s]\n",
+			__FUNCTION__, state->messages[7], (state->messages[8] << 8) | state->messages[9],
+			(state->messages[10] << 8) | state->messages[11], __FUNCTION__, (char *)(&state->messages[11]));
+		dprintk("%s: ==================================================================================================\n", __FUNCTION__);
+	}
+
+	return 0;
+}
+
+static int ca_get_slot_caps(struct dst_state *state, struct ca_caps *p_ca_caps, void *arg)
+{
+	int i;
+	u8 slot_cap[256];
+	static u8 slot_command[8] = {0x07, 0x40, 0x02, 0x00, 0x02, 0x00, 0x00, 0xff};
+
+	put_checksum(&slot_command[0], slot_command[0]);
+	if ((dst_put_ci(state, slot_command, sizeof (slot_command), slot_cap, GET_REPLY)) < 0) {
+		dprintk("%s: -->dst_put_ci FAILED !\n", __FUNCTION__);
+		return -1;
+	}
+	if (verbose > 1)
+		dprintk("%s: -->dst_put_ci SUCCESS !\n", __FUNCTION__);
+
+	/*	Will implement the rest soon		*/
+
+	if (verbose > 1) {
+		dprintk("%s: Slot cap = [%d]\n", __FUNCTION__, slot_cap[7]);
+		dprintk("===================================\n");
+		for (i = 0; i < 8; i++)
+			dprintk(" %d", slot_cap[i]);
+		dprintk("\n");
+	}
+
+	p_ca_caps->slot_num = 1;
+	p_ca_caps->slot_type = 1;
+	p_ca_caps->descr_num = slot_cap[7];
+	p_ca_caps->descr_type = 1;
+
+
+	if (copy_to_user((struct ca_caps *)arg, p_ca_caps, sizeof (struct ca_caps))) {
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+
+static int ca_get_slot_descr(struct dst_state *state, struct ca_msg *p_ca_message, void *arg)
+{
+	return -EOPNOTSUPP;
+}
+
+
+static int ca_get_slot_info(struct dst_state *state, struct ca_slot_info *p_ca_slot_info, void *arg)
+{
+	int i;
+	static u8 slot_command[8] = {0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0xff};
+
+	u8 *slot_info = state->rxbuffer;
+
+	put_checksum(&slot_command[0], 7);
+	if ((dst_put_ci(state, slot_command, sizeof (slot_command), slot_info, GET_REPLY)) < 0) {
+		dprintk("%s: -->dst_put_ci FAILED !\n", __FUNCTION__);
+		return -1;
+	}
+	if (verbose > 1)
+		dprintk("%s: -->dst_put_ci SUCCESS !\n", __FUNCTION__);
+
+	/*	Will implement the rest soon		*/
+
+	if (verbose > 1) {
+		dprintk("%s: Slot info = [%d]\n", __FUNCTION__, slot_info[3]);
+		dprintk("===================================\n");
+		for (i = 0; i < 8; i++)
+			dprintk(" %d", slot_info[i]);
+		dprintk("\n");
+	}
+
+	if (slot_info[4] & 0x80) {
+		p_ca_slot_info->flags = CA_CI_MODULE_PRESENT;
+		p_ca_slot_info->num = 1;
+		p_ca_slot_info->type = CA_CI;
+	}
+	else if (slot_info[4] & 0x40) {
+		p_ca_slot_info->flags = CA_CI_MODULE_READY;
+		p_ca_slot_info->num = 1;
+		p_ca_slot_info->type = CA_CI;
+	}
+	else {
+		p_ca_slot_info->flags = 0;
+	}
+
+	if (copy_to_user((struct ca_slot_info *)arg, p_ca_slot_info, sizeof (struct ca_slot_info))) {
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+
+
+
+static int ca_get_message(struct dst_state *state, struct ca_msg *p_ca_message, void *arg)
+{
+	u8 i = 0;
+	u32 command = 0;
+
+	if (copy_from_user(p_ca_message, (void *)arg, sizeof (struct ca_msg)))
+		return -EFAULT;
+
+
+	if (p_ca_message->msg) {
+		if (verbose > 3)
+			dprintk("Message = [%02x %02x %02x]\n", p_ca_message->msg[0], p_ca_message->msg[1], p_ca_message->msg[2]);
+
+		for (i = 0; i < 3; i++) {
+			command = command | p_ca_message->msg[i];
+			if (i < 2)
+				command = command << 8;
+		}
+		if (verbose > 3)
+			dprintk("%s:Command=[0x%x]\n", __FUNCTION__, command);
+
+		switch (command) {
+			case CA_APP_INFO:
+				memcpy(p_ca_message->msg, state->messages, 128);
+				if (copy_to_user((void *)arg, p_ca_message, sizeof (struct ca_msg)) )
+					return -EFAULT;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int handle_en50221_tag(struct ca_msg *p_ca_message, struct ca_msg *hw_buffer)
+{
+	if (session) {
+		hw_buffer->msg[2] = p_ca_message->msg[1];		/*		MSB			*/
+		hw_buffer->msg[3] = p_ca_message->msg[2];		/*		LSB			*/
+	}
+	else {
+		hw_buffer->msg[2] = 0x03;
+		hw_buffer->msg[3] = 0x00;
+	}
+	return 0;
+}
+
+static int debug_8820_buffer(struct ca_msg *hw_buffer)
+{
+	unsigned int i;
+
+	dprintk("%s:Debug=[", __FUNCTION__);
+	for (i = 0; i < (hw_buffer->msg[0] + 1); i++)
+		dprintk(" %02x", hw_buffer->msg[i]);
+	dprintk("]\n");
+
+	return 0;
+}
+
+static int write_to_8820(struct dst_state *state, struct ca_msg *hw_buffer, u8 reply)
+{
+	if ((dst_put_ci(state, hw_buffer->msg, (hw_buffer->length + 1), hw_buffer->msg, reply)) < 0) {
+		dprintk("%s: DST-CI Command failed.\n", __FUNCTION__);
+		dprintk("%s: Resetting DST.\n", __FUNCTION__);
+		rdc_reset_state(state);
+		return -1;
+	}
+	if (verbose > 2)
+		dprintk("%s: DST-CI Command succes.\n", __FUNCTION__);
+
+	return 0;
+}
+
+
+static int ca_set_pmt(struct dst_state *state, struct ca_msg *p_ca_message, struct ca_msg *hw_buffer, u8 reply, u8 query)
+{
+	u32 hw_offset, buf_offset, i, k;
+	u32 program_info_length = 0, es_info_length = 0, length = 0, words = 0;
+	u8 found_prog_ca_desc = 0, found_stream_ca_desc = 0, error_condition = 0, hw_buffer_length = 0;
+
+	if (verbose > 3)
+		dprintk("%s, p_ca_message length %d (0x%x)\n", __FUNCTION__,p_ca_message->length,p_ca_message->length );
+
+	handle_en50221_tag(p_ca_message, hw_buffer);			/*	EN50221 tag		*/
+
+	/*	Handle the length field (variable)	*/
+	if (!(p_ca_message->msg[3] & 0x80)) {				/*	Length = 1		*/
+		length = p_ca_message->msg[3] & 0x7f;
+		words = 0;						/*	domi's suggestion	*/
+	}
+	else {								/*	Length = words		*/
+		words = p_ca_message->msg[3] & 0x7f;
+		for (i = 0; i < words; i++) {
+			length = length << 8;
+			length = length | p_ca_message->msg[4 + i];
+		}
+	}
+	if (verbose > 4) {
+		dprintk("%s:Length=[%d (0x%x)], Words=[%d]\n", __FUNCTION__, length,length, words);
+
+		/*	Debug Input string		*/
+		for (i = 0; i < length; i++)
+			dprintk(" %02x", p_ca_message->msg[i]);
+		dprintk("]\n");
+	}
+
+	hw_offset = 7;
+	buf_offset = words + 4;
+
+	/*		Program Header			*/
+	if (verbose > 4)
+		dprintk("\n%s:Program Header=[", __FUNCTION__);
+	for (i = 0; i < 6; i++) {
+		hw_buffer->msg[hw_offset] = p_ca_message->msg[buf_offset];
+		if (verbose > 4)
+			dprintk(" %02x", p_ca_message->msg[buf_offset]);
+		hw_offset++, buf_offset++, hw_buffer_length++;
+	}
+	if (verbose > 4)
+		dprintk("]\n");
+
+	program_info_length = 0;
+	program_info_length = (((program_info_length | p_ca_message->msg[words + 8]) & 0x0f) << 8) | p_ca_message->msg[words + 9];
+	if (verbose > 4)
+		dprintk("%s:Program info Length=[%d][%02x], hw_offset=[%d], buf_offset=[%d] \n",
+			__FUNCTION__, program_info_length, program_info_length, hw_offset, buf_offset);
+
+	if (program_info_length && (program_info_length < 256)) {	/*	If program_info_length		*/
+		hw_buffer->msg[11] = hw_buffer->msg[11] & 0x0f;		/*	req only 4 bits			*/
+		hw_buffer->msg[12] = hw_buffer->msg[12] + 1;		/*	increment! ASIC bug!		*/
+
+		if (p_ca_message->msg[buf_offset + 1] == 0x09) {	/*	Check CA descriptor		*/
+			found_prog_ca_desc = 1;
+			if (verbose > 4)
+				dprintk("%s: Found CA descriptor @ Program level\n", __FUNCTION__);
+		}
+
+		if (found_prog_ca_desc) {				/*	Command only if CA descriptor	*/
+			hw_buffer->msg[13] = p_ca_message->msg[buf_offset];	/*	CA PMT command ID	*/
+			hw_offset++, buf_offset++, hw_buffer_length++;
+		}
+
+		/*			Program descriptors				*/
+		if (verbose > 4) {
+			dprintk("%s:**********>buf_offset=[%d], hw_offset=[%d]\n", __FUNCTION__, buf_offset, hw_offset);
+			dprintk("%s:Program descriptors=[", __FUNCTION__);
+		}
+		while (program_info_length && !error_condition) {		/*	Copy prog descriptors	*/
+			if (program_info_length > p_ca_message->length) {	/*	Error situation		*/
+				dprintk ("%s:\"WARNING\" Length error, line=[%d], prog_info_length=[%d]\n",
+								__FUNCTION__, __LINE__, program_info_length);
+				dprintk("%s:\"WARNING\" Bailing out of possible loop\n", __FUNCTION__);
+				error_condition = 1;
+				break;
+			}
+
+			hw_buffer->msg[hw_offset] = p_ca_message->msg[buf_offset];
+			dprintk(" %02x", p_ca_message->msg[buf_offset]);
+			hw_offset++, buf_offset++, hw_buffer_length++, program_info_length--;
+		}
+		if (verbose > 4) {
+			dprintk("]\n");
+			dprintk("%s:**********>buf_offset=[%d], hw_offset=[%d]\n", __FUNCTION__, buf_offset, hw_offset);
+		}
+		if (found_prog_ca_desc) {
+			if (!reply) {
+				hw_buffer->msg[13] = 0x01;		/*	OK descrambling			*/
+				if (verbose > 1)
+					dprintk("CA PMT Command = OK Descrambling\n");
+			}
+			else {
+				hw_buffer->msg[13] = 0x02;		/*	Ok MMI				*/
+				if (verbose > 1)
+					dprintk("CA PMT Command = Ok MMI\n");
+			}
+			if (query) {
+				hw_buffer->msg[13] = 0x03;		/*	Query				*/
+				if (verbose > 1)
+					dprintk("CA PMT Command = CA PMT query\n");
+			}
+		}
+	}
+	else {
+		hw_buffer->msg[11] = hw_buffer->msg[11] & 0xf0;		/*	Don't write to ASIC		*/
+		hw_buffer->msg[12] = hw_buffer->msg[12] = 0x00;
+	}
+	if (verbose > 4)
+		dprintk("%s:**********>p_ca_message->length=[%d], buf_offset=[%d], hw_offset=[%d]\n",
+					__FUNCTION__, p_ca_message->length, buf_offset, hw_offset);
+
+	while ((buf_offset  < p_ca_message->length)  && !error_condition) {
+		/*	Bail out in case of an indefinite loop		*/
+		if ((es_info_length > p_ca_message->length) || (buf_offset > p_ca_message->length)) {
+			dprintk("%s:\"WARNING\" Length error, line=[%d], prog_info_length=[%d], buf_offset=[%d]\n",
+							__FUNCTION__, __LINE__, program_info_length, buf_offset);
+
+			dprintk("%s:\"WARNING\" Bailing out of possible loop\n", __FUNCTION__);
+			error_condition = 1;
+			break;
+		}
+
+		/*		Stream Header				*/
+
+		for (k = 0; k < 5; k++) {
+			hw_buffer->msg[hw_offset + k] = p_ca_message->msg[buf_offset + k];
+		}
+
+		es_info_length = 0;
+		es_info_length = (es_info_length | (p_ca_message->msg[buf_offset + 3] & 0x0f)) << 8 | p_ca_message->msg[buf_offset + 4];
+
+		if (verbose > 4) {
+			dprintk("\n%s:----->Stream header=[%02x %02x %02x %02x %02x]\n", __FUNCTION__,
+				p_ca_message->msg[buf_offset + 0], p_ca_message->msg[buf_offset + 1],
+				p_ca_message->msg[buf_offset + 2], p_ca_message->msg[buf_offset + 3],
+				p_ca_message->msg[buf_offset + 4]);
+
+			dprintk("%s:----->Stream type=[%02x], es length=[%d (0x%x)], Chars=[%02x] [%02x], buf_offset=[%d]\n", __FUNCTION__,
+				p_ca_message->msg[buf_offset + 0], es_info_length, es_info_length,
+				p_ca_message->msg[buf_offset + 3], p_ca_message->msg[buf_offset + 4], buf_offset);
+		}
+
+		hw_buffer->msg[hw_offset + 3] &= 0x0f;			/*	req only 4 bits			*/
+
+		if (found_prog_ca_desc) {
+			hw_buffer->msg[hw_offset + 3] = 0x00;
+			hw_buffer->msg[hw_offset + 4] = 0x00;
+		}
+
+		hw_offset += 5, buf_offset += 5, hw_buffer_length += 5;
+
+		/*		Check for CA descriptor			*/
+		if (p_ca_message->msg[buf_offset + 1] == 0x09) {
+			if (verbose > 4)
+				dprintk("%s:Found CA descriptor @ Stream level\n", __FUNCTION__);
+			found_stream_ca_desc = 1;
+		}
+
+		/*		ES descriptors				*/
+
+		if (es_info_length && !error_condition && !found_prog_ca_desc && found_stream_ca_desc) {
+//			if (!ca_pmt_done) {
+				hw_buffer->msg[hw_offset] = p_ca_message->msg[buf_offset];	/*	CA PMT cmd(es)	*/
+				if (verbose > 4)
+					printk("%s:----->CA PMT Command ID=[%02x]\n", __FUNCTION__, p_ca_message->msg[buf_offset]);
+//				hw_offset++, buf_offset++, hw_buffer_length++, es_info_length--, ca_pmt_done = 1;
+				hw_offset++, buf_offset++, hw_buffer_length++, es_info_length--;
+//			}
+			if (verbose > 4)
+				dprintk("%s:----->ES descriptors=[", __FUNCTION__);
+
+			while (es_info_length && !error_condition) {	/*	ES descriptors			*/
+				if ((es_info_length > p_ca_message->length) || (buf_offset > p_ca_message->length)) {
+					if (verbose > 4) {
+						dprintk("%s:\"WARNING\" ES Length error, line=[%d], es_info_length=[%d], buf_offset=[%d]\n",
+										__FUNCTION__, __LINE__, es_info_length, buf_offset);
+
+						dprintk("%s:\"WARNING\" Bailing out of possible loop\n", __FUNCTION__);
+					}
+					error_condition = 1;
+					break;
+				}
+
+				hw_buffer->msg[hw_offset] = p_ca_message->msg[buf_offset];
+				if (verbose > 3)
+					dprintk("%02x ", hw_buffer->msg[hw_offset]);
+				hw_offset++, buf_offset++, hw_buffer_length++, es_info_length--;
+			}
+			found_stream_ca_desc = 0;			/*	unset for new streams		*/
+			dprintk("]\n");
+		}
+	}
+
+	/*		MCU Magic words					*/
+
+	hw_buffer_length += 7;
+	hw_buffer->msg[0] = hw_buffer_length;
+	hw_buffer->msg[1] = 64;
+	hw_buffer->msg[4] = 3;
+	hw_buffer->msg[5] = hw_buffer->msg[0] - 7;
+	hw_buffer->msg[6] = 0;
+
+
+	/*      Fix length      */
+	hw_buffer->length = hw_buffer->msg[0];
+
+	put_checksum(&hw_buffer->msg[0], hw_buffer->msg[0]);
+	/*      Do the actual write     */
+	if (verbose > 4) {
+		dprintk("%s:======================DEBUGGING================================\n", __FUNCTION__);
+		dprintk("%s: Actual Length=[%d]\n", __FUNCTION__, hw_buffer_length);
+	}
+	/*      Only for debugging!     */
+	if (verbose > 2)
+		debug_8820_buffer(hw_buffer);
+	if (verbose > 3)
+		dprintk("%s: Reply = [%d]\n", __FUNCTION__, reply);
+	write_to_8820(state, hw_buffer, reply);
+
+	return 0;
+}
+
+/*	Board supports CA PMT reply ?		*/
+static int dst_check_ca_pmt(struct dst_state *state, struct ca_msg *p_ca_message, struct ca_msg *hw_buffer)
+{
+	int ca_pmt_reply_test = 0;
+
+	/*	Do test board			*/
+	/*	Not there yet but soon		*/
+
+
+	/*	CA PMT Reply capable		*/
+	if (ca_pmt_reply_test) {
+		if ((ca_set_pmt(state, p_ca_message, hw_buffer, 1, GET_REPLY)) < 0) {
+			dprintk("%s: ca_set_pmt.. failed !\n", __FUNCTION__);
+			return -1;
+		}
+
+	/*	Process CA PMT Reply		*/
+	/*	will implement soon		*/
+		dprintk("%s: Not there yet\n", __FUNCTION__);
+	}
+	/*	CA PMT Reply not capable	*/
+	if (!ca_pmt_reply_test) {
+		if ((ca_set_pmt(state, p_ca_message, hw_buffer, 0, NO_REPLY)) < 0) {
+			dprintk("%s: ca_set_pmt.. failed !\n", __FUNCTION__);
+			return -1;
+		}
+		if (verbose > 3)
+			dprintk("%s: ca_set_pmt.. success !\n", __FUNCTION__);
+	/*	put a dummy message		*/
+
+	}
+	return 0;
+}
+
+static int ca_send_message(struct dst_state *state, struct ca_msg *p_ca_message, void *arg)
+{
+	int i = 0;
+	unsigned int ca_message_header_len;
+
+	u32 command = 0;
+	struct ca_msg *hw_buffer;
+
+	if ((hw_buffer = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
+		printk("%s: Memory allocation failure\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+	if (verbose > 3)
+		dprintk("%s\n", __FUNCTION__);
+
+	if (copy_from_user(p_ca_message, (void *)arg, sizeof (struct ca_msg)))
+		return -EFAULT;
+
+	if (p_ca_message->msg) {
+		ca_message_header_len = p_ca_message->length;	/*	Restore it back when you are done	*/
+		/*	EN50221 tag	*/
+		command = 0;
+
+		for (i = 0; i < 3; i++) {
+			command = command | p_ca_message->msg[i];
+			if (i < 2)
+				command = command << 8;
+		}
+		if (verbose > 3)
+			dprintk("%s:Command=[0x%x]\n", __FUNCTION__, command);
+
+		switch (command) {
+			case CA_PMT:
+				if (verbose > 3)
+					dprintk("Command = SEND_CA_PMT\n");
+				if ((ca_set_pmt(state, p_ca_message, hw_buffer, 0, 0)) < 0) {
+					dprintk("%s: -->CA_PMT Failed !\n", __FUNCTION__);
+					return -1;
+				}
+				if (verbose > 3)
+					dprintk("%s: -->CA_PMT Success !\n", __FUNCTION__);
+//				retval = dummy_set_pmt(state, p_ca_message, hw_buffer, 0, 0);
+
+				break;
+
+			case CA_PMT_REPLY:
+				if (verbose > 3)
+					dprintk("Command = CA_PMT_REPLY\n");
+				/*      Have to handle the 2 basic types of cards here  */
+				if ((dst_check_ca_pmt(state, p_ca_message, hw_buffer)) < 0) {
+					dprintk("%s: -->CA_PMT_REPLY Failed !\n", __FUNCTION__);
+					return -1;
+				}
+				if (verbose > 3)
+					dprintk("%s: -->CA_PMT_REPLY Success !\n", __FUNCTION__);
+
+				/*      Certain boards do behave different ?            */
+//				retval = ca_set_pmt(state, p_ca_message, hw_buffer, 1, 1);
+
+			case CA_APP_INFO_ENQUIRY:		// only for debugging
+				if (verbose > 3)
+					dprintk("%s: Getting Cam Application information\n", __FUNCTION__);
+
+				if ((ca_get_app_info(state)) < 0) {
+					dprintk("%s: -->CA_APP_INFO_ENQUIRY Failed !\n", __FUNCTION__);
+					return -1;
+				}
+				if (verbose > 3)
+					printk("%s: -->CA_APP_INFO_ENQUIRY Success !\n", __FUNCTION__);
+
+				break;
+		}
+	}
+	return 0;
+}
+
+static int dst_ca_ioctl(struct inode *inode, struct file *file, unsigned int cmd, void *arg)
+{
+	struct dvb_device* dvbdev = (struct dvb_device*) file->private_data;
+	struct dst_state* state = (struct dst_state*) dvbdev->priv;
+	struct ca_slot_info *p_ca_slot_info;
+	struct ca_caps *p_ca_caps;
+	struct ca_msg *p_ca_message;
+
+	if ((p_ca_message = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
+		printk("%s: Memory allocation failure\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+
+	if ((p_ca_slot_info = (struct ca_slot_info *) kmalloc(sizeof (struct ca_slot_info), GFP_KERNEL)) == NULL) {
+		printk("%s: Memory allocation failure\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+
+	if ((p_ca_caps = (struct ca_caps *) kmalloc(sizeof (struct ca_caps), GFP_KERNEL)) == NULL) {
+		printk("%s: Memory allocation failure\n", __FUNCTION__);
+		return -ENOMEM;
+	}
+
+	/*	We have now only the standard ioctl's, the driver is upposed to handle internals.	*/
+	switch (cmd) {
+		case CA_SEND_MSG:
+			if (verbose > 1)
+				dprintk("%s: Sending message\n", __FUNCTION__);
+			if ((ca_send_message(state, p_ca_message, arg)) < 0) {
+				dprintk("%s: -->CA_SEND_MSG Failed !\n", __FUNCTION__);
+				return -1;
+			}
+
+			break;
+
+		case CA_GET_MSG:
+			if (verbose > 1)
+				dprintk("%s: Getting message\n", __FUNCTION__);
+			if ((ca_get_message(state, p_ca_message, arg)) < 0) {
+				dprintk("%s: -->CA_GET_MSG Failed !\n", __FUNCTION__);
+				return -1;
+			}
+			if (verbose > 1)
+				dprintk("%s: -->CA_GET_MSG Success !\n", __FUNCTION__);
+
+			break;
+
+		case CA_RESET:
+			if (verbose > 1)
+				dprintk("%s: Resetting DST\n", __FUNCTION__);
+			dst_error_bailout(state);
+			msleep(4000);
+
+			break;
+
+		case CA_GET_SLOT_INFO:
+			if (verbose > 1)
+				dprintk("%s: Getting Slot info\n", __FUNCTION__);
+			if ((ca_get_slot_info(state, p_ca_slot_info, arg)) < 0) {
+				dprintk("%s: -->CA_GET_SLOT_INFO Failed !\n", __FUNCTION__);
+				return -1;
+			}
+			if (verbose > 1)
+				dprintk("%s: -->CA_GET_SLOT_INFO Success !\n", __FUNCTION__);
+
+			break;
+
+		case CA_GET_CAP:
+			if (verbose > 1)
+				dprintk("%s: Getting Slot capabilities\n", __FUNCTION__);
+			if ((ca_get_slot_caps(state, p_ca_caps, arg)) < 0) {
+				dprintk("%s: -->CA_GET_CAP Failed !\n", __FUNCTION__);
+				return -1;
+			}
+			if (verbose > 1)
+				dprintk("%s: -->CA_GET_CAP Success !\n", __FUNCTION__);
+
+			break;
+
+		case CA_GET_DESCR_INFO:
+			if (verbose > 1)
+				dprintk("%s: Getting descrambler description\n", __FUNCTION__);
+			if ((ca_get_slot_descr(state, p_ca_message, arg)) < 0) {
+				dprintk("%s: -->CA_GET_DESCR_INFO Failed !\n", __FUNCTION__);
+				return -1;
+			}
+			if (verbose > 1)
+				dprintk("%s: -->CA_GET_DESCR_INFO Success !\n", __FUNCTION__);
+
+			break;
+
+		case CA_SET_DESCR:
+			if (verbose > 1)
+				dprintk("%s: Setting descrambler\n", __FUNCTION__);
+			if ((ca_set_slot_descr()) < 0) {
+				dprintk("%s: -->CA_SET_DESCR Failed !\n", __FUNCTION__);
+				return -1;
+			}
+			if (verbose > 1)
+				dprintk("%s: -->CA_SET_DESCR Success !\n", __FUNCTION__);
+
+			break;
+
+		case CA_SET_PID:
+			if (verbose > 1)
+				dprintk("%s: Setting PID\n", __FUNCTION__);
+			if ((ca_set_pid()) < 0) {
+				dprintk("%s: -->CA_SET_PID Failed !\n", __FUNCTION__);
+				return -1;
+			}
+			if (verbose > 1)
+				dprintk("%s: -->CA_SET_PID Success !\n", __FUNCTION__);
+
+		default:
+			return -EOPNOTSUPP;
+		};
+
+	return 0;
+}
+
+static int dst_ca_open(struct inode *inode, struct file *file)
+{
+	if (verbose > 4)
+		dprintk("%s:Device opened [%p]\n", __FUNCTION__, file);
+	try_module_get(THIS_MODULE);
+
+	return 0;
+}
+
+static int dst_ca_release(struct inode *inode, struct file *file)
+{
+	if (verbose > 4)
+		dprintk("%s:Device closed.\n", __FUNCTION__);
+	module_put(THIS_MODULE);
+
+	return 0;
+}
+
+static int dst_ca_read(struct file *file, char __user * buffer, size_t length, loff_t * offset)
+{
+	int bytes_read = 0;
+
+	if (verbose > 4)
+		dprintk("%s:Device read.\n", __FUNCTION__);
+
+	return bytes_read;
+}
+
+static int dst_ca_write(struct file *file, const char __user * buffer, size_t length, loff_t * offset)
+{
+	if (verbose > 4)
+		dprintk("%s:Device write.\n", __FUNCTION__);
+
+	return 0;
+}
+
+static struct file_operations dst_ca_fops = {
+	.owner = THIS_MODULE,
+	.ioctl = (void *)dst_ca_ioctl,
+	.open = dst_ca_open,
+	.release = dst_ca_release,
+	.read = dst_ca_read,
+	.write = dst_ca_write
+};
+
+static struct dvb_device dvbdev_ca = {
+	.priv = NULL,
+	.users = 1,
+	.readers = 1,
+	.writers = 1,
+	.fops = &dst_ca_fops
+};
+
+int dst_ca_attach(struct dst_state *dst, struct dvb_adapter *dvb_adapter)
+{
+	struct dvb_device *dvbdev;
+	if (verbose > 4)
+		dprintk("%s:registering DST-CA device\n", __FUNCTION__);
+	dvb_register_device(dvb_adapter, &dvbdev, &dvbdev_ca, dst, DVB_DEVICE_CA);
+	return 0;
+}
+
+EXPORT_SYMBOL(dst_ca_attach);
+
+MODULE_DESCRIPTION("DST DVB-S/T/C Combo CA driver");
+MODULE_AUTHOR("Manu Abraham");
+MODULE_LICENSE("GPL");
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_ca.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_ca.h	2005-05-08 18:13:30.000000000 +0200
@@ -0,0 +1,58 @@
+/*
+	CA-driver for TwinHan DST Frontend/Card
+
+	Copyright (C) 2004, 2005 Manu Abraham (manu@kromtek.com)
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful,
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the Free Software
+	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#ifndef _DST_CA_H_
+#define _DST_CA_H_
+
+#define RETRIES			5
+
+
+#define	CA_APP_INFO_ENQUIRY	0x9f8020
+#define	CA_APP_INFO		0x9f8021
+#define	CA_ENTER_MENU		0x9f8022
+#define CA_INFO_ENQUIRY		0x9f8030
+#define	CA_INFO			0x9f8031
+#define CA_PMT			0x9f8032
+#define CA_PMT_REPLY		0x9f8033
+
+#define CA_CLOSE_MMI		0x9f8800
+#define CA_DISPLAY_CONTROL	0x9f8801
+#define CA_DISPLAY_REPLY	0x9f8802
+#define CA_TEXT_LAST		0x9f8803
+#define CA_TEXT_MORE		0x9f8804
+#define CA_KEYPAD_CONTROL	0x9f8805
+#define CA_KEYPRESS		0x9f8806
+
+#define CA_ENQUIRY		0x9f8807
+#define CA_ANSWER		0x9f8808
+#define CA_MENU_LAST		0x9f8809
+#define CA_MENU_MORE		0x9f880a
+#define CA_MENU_ANSWER		0x9f880b
+#define CA_LIST_LAST		0x9f880c
+#define CA_LIST_MORE		0x9f880d
+
+
+struct dst_ca_private {
+	struct dst_state *dst;
+	struct dvb_device *dvbdev;
+};
+
+
+#endif
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_common.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_common.h	2005-05-08 18:13:30.000000000 +0200
@@ -0,0 +1,153 @@
+/*
+	Frontend-driver for TwinHan DST Frontend
+
+	Copyright (C) 2003 Jamie Honan
+	Copyright (C) 2004, 2005 Manu Abraham (manu@kromtek.com)
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful,
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the Free Software
+	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#ifndef DST_COMMON_H
+#define DST_COMMON_H
+
+#include <linux/dvb/frontend.h>
+#include <linux/device.h>
+#include "bt878.h"
+
+#include "dst_ca.h"
+
+
+#define NO_DELAY		0
+#define LONG_DELAY		1
+#define DEVICE_INIT		2
+
+#define DELAY			1
+
+#define DST_TYPE_IS_SAT		0
+#define DST_TYPE_IS_TERR	1
+#define DST_TYPE_IS_CABLE	2
+#define DST_TYPE_IS_ATSC	3
+
+#define DST_TYPE_HAS_NEWTUNE	1
+#define DST_TYPE_HAS_TS204	2
+#define DST_TYPE_HAS_SYMDIV	4
+#define DST_TYPE_HAS_FW_1	8
+#define DST_TYPE_HAS_FW_2	16
+#define DST_TYPE_HAS_FW_3	32
+
+
+
+/*	Card capability list	*/
+
+#define DST_TYPE_HAS_MAC	1
+#define DST_TYPE_HAS_DISEQC3	2
+#define DST_TYPE_HAS_DISEQC4	4
+#define DST_TYPE_HAS_DISEQC5	8
+#define DST_TYPE_HAS_MOTO	16
+#define DST_TYPE_HAS_CA		32
+#define	DST_TYPE_HAS_ANALOG	64	/*	Analog inputs	*/
+
+
+#define RDC_8820_PIO_0_DISABLE	0
+#define RDC_8820_PIO_0_ENABLE	1
+#define RDC_8820_INT		2
+#define RDC_8820_RESET		4
+
+/*	DST Communication	*/
+#define GET_REPLY		1
+#define NO_REPLY		0
+
+#define GET_ACK			1
+#define FIXED_COMM		8
+
+#define ACK			0xff
+
+struct dst_state {
+
+	struct i2c_adapter* i2c;
+
+	struct bt878* bt;
+
+	struct dvb_frontend_ops ops;
+
+	/* configuration settings */
+	const struct dst_config* config;
+
+	struct dvb_frontend frontend;
+
+	/* private ASIC data */
+	u8 tx_tuna[10];
+	u8 rx_tuna[10];
+	u8 rxbuffer[10];
+	u8 diseq_flags;
+	u8 dst_type;
+	u32 type_flags;
+	u32 frequency;		/* intermediate frequency in kHz for QPSK */
+	fe_spectral_inversion_t inversion;
+	u32 symbol_rate;	/* symbol rate in Symbols per second */
+	fe_code_rate_t fec;
+	fe_sec_voltage_t voltage;
+	fe_sec_tone_mode_t tone;
+	u32 decode_freq;
+	u8 decode_lock;
+	u16 decode_strength;
+	u16 decode_snr;
+	unsigned long cur_jiff;
+	u8 k22;
+	fe_bandwidth_t bandwidth;
+	u8 dst_hw_cap;
+	u8 dst_fw_version;
+	fe_sec_mini_cmd_t minicmd;
+	u8 messages[256];
+};
+
+struct dst_types {
+	char *device_id;
+	int offset;
+	u8 dst_type;
+	u32 type_flags;
+	u8 dst_feature;
+};
+
+
+
+struct dst_config
+{
+	/* the ASIC i2c address */
+	u8 demod_address;
+};
+
+
+int rdc_reset_state(struct dst_state *state);
+int rdc_8820_reset(struct dst_state *state);
+
+int dst_wait_dst_ready(struct dst_state *state, u8 delay_mode);
+int dst_pio_enable(struct dst_state *state);
+int dst_pio_disable(struct dst_state *state);
+int dst_error_recovery(struct dst_state* state);
+int dst_error_bailout(struct dst_state *state);
+int dst_comm_init(struct dst_state* state);
+
+int write_dst(struct dst_state *state, u8 * data, u8 len);
+int read_dst(struct dst_state *state, u8 * ret, u8 len);
+u8 dst_check_sum(u8 * buf, u32 len);
+struct dst_state* dst_attach(struct dst_state* state, struct dvb_adapter *dvb_adapter);
+int dst_ca_attach(struct dst_state *state, struct dvb_adapter *dvb_adapter);
+int dst_gpio_outb(struct dst_state* state, u32 mask, u32 enbb, u32 outhigh, int delay);
+
+int dst_command(struct dst_state* state, u8 * data, u8 len);
+
+
+#endif // DST_COMMON_H
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_priv.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst_priv.h	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_priv.h	2005-05-08 18:13:30.000000000 +0200
@@ -33,4 +33,3 @@ union dst_gpio_packet {
 struct bt878;
 
 int bt878_device_control(struct bt878 *bt, unsigned int cmd, union dst_gpio_packet *mp);
-
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dvb-bt8xx.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-05-08 18:12:25.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dvb-bt8xx.c	2005-05-08 18:13:30.000000000 +0200
@@ -142,7 +142,7 @@ static int thomson_dtt7579_demod_init(st
 	mt352_write(fe, mt352_adc_ctl_1_cfg, sizeof(mt352_adc_ctl_1_cfg));
 
 	mt352_write(fe, mt352_agc_cfg, sizeof(mt352_agc_cfg));
-        mt352_write(fe, mt352_gpp_ctl_cfg, sizeof(mt352_gpp_ctl_cfg));
+	mt352_write(fe, mt352_gpp_ctl_cfg, sizeof(mt352_gpp_ctl_cfg));
 	mt352_write(fe, mt352_capt_range_cfg, sizeof(mt352_capt_range_cfg));
 
 	return 0;
@@ -161,7 +161,7 @@ static int thomson_dtt7579_pll_set(struc
 	else if (params->frequency < 771000000) cp = 0xbc;
 	else cp = 0xf4;
 
-        if (params->frequency == 0) bs = 0x03;
+	if (params->frequency == 0) bs = 0x03;
 	else if (params->frequency < 443250000) bs = 0x02;
 	else bs = 0x08;
 
@@ -190,44 +190,44 @@ static int cx24108_pll_set(struct dvb_fr
 
 
    u32 osci[]={950000,1019000,1075000,1178000,1296000,1432000,
-               1576000,1718000,1856000,2036000,2150000};
+	       1576000,1718000,1856000,2036000,2150000};
    u32 bandsel[]={0,0x00020000,0x00040000,0x00100800,0x00101000,
-               0x00102000,0x00104000,0x00108000,0x00110000,
-               0x00120000,0x00140000};
+	       0x00102000,0x00104000,0x00108000,0x00110000,
+	       0x00120000,0x00140000};
 
 #define XTAL 1011100 /* Hz, really 1.0111 MHz and a /10 prescaler */
-        printk("cx24108 debug: entering SetTunerFreq, freq=%d\n",freq);
+	printk("cx24108 debug: entering SetTunerFreq, freq=%d\n",freq);
 
-        /* This is really the bit driving the tuner chip cx24108 */
+	/* This is really the bit driving the tuner chip cx24108 */
 
-        if(freq<950000) freq=950000; /* kHz */
-        if(freq>2150000) freq=2150000; /* satellite IF is 950..2150MHz */
+	if(freq<950000) freq=950000; /* kHz */
+	if(freq>2150000) freq=2150000; /* satellite IF is 950..2150MHz */
 
-        /* decide which VCO to use for the input frequency */
-        for(i=1;(i<sizeof(osci)/sizeof(osci[0]))&&(osci[i]<freq);i++);
-        printk("cx24108 debug: select vco #%d (f=%d)\n",i,freq);
-        band=bandsel[i];
-        /* the gain values must be set by SetSymbolrate */
-        /* compute the pll divider needed, from Conexant data sheet,
-           resolved for (n*32+a), remember f(vco) is f(receive) *2 or *4,
-           depending on the divider bit. It is set to /4 on the 2 lowest
-           bands  */
-        n=((i<=2?2:1)*freq*10L)/(XTAL/100);
-        a=n%32; n/=32; if(a==0) n--;
-        pump=(freq<(osci[i-1]+osci[i])/2);
-        pll=0xf8000000|
-            ((pump?1:2)<<(14+11))|
-            ((n&0x1ff)<<(5+11))|
-            ((a&0x1f)<<11);
-        /* everything is shifted left 11 bits to left-align the bits in the
-           32bit word. Output to the tuner goes MSB-aligned, after all */
-        printk("cx24108 debug: pump=%d, n=%d, a=%d\n",pump,n,a);
-        cx24110_pll_write(fe,band);
-        /* set vga and vca to their widest-band settings, as a precaution.
-           SetSymbolrate might not be called to set this up */
-        cx24110_pll_write(fe,0x500c0000);
-        cx24110_pll_write(fe,0x83f1f800);
-        cx24110_pll_write(fe,pll);
+	/* decide which VCO to use for the input frequency */
+	for(i=1;(i<sizeof(osci)/sizeof(osci[0]))&&(osci[i]<freq);i++);
+	printk("cx24108 debug: select vco #%d (f=%d)\n",i,freq);
+	band=bandsel[i];
+	/* the gain values must be set by SetSymbolrate */
+	/* compute the pll divider needed, from Conexant data sheet,
+	   resolved for (n*32+a), remember f(vco) is f(receive) *2 or *4,
+	   depending on the divider bit. It is set to /4 on the 2 lowest
+	   bands  */
+	n=((i<=2?2:1)*freq*10L)/(XTAL/100);
+	a=n%32; n/=32; if(a==0) n--;
+	pump=(freq<(osci[i-1]+osci[i])/2);
+	pll=0xf8000000|
+	    ((pump?1:2)<<(14+11))|
+	    ((n&0x1ff)<<(5+11))|
+	    ((a&0x1f)<<11);
+	/* everything is shifted left 11 bits to left-align the bits in the
+	   32bit word. Output to the tuner goes MSB-aligned, after all */
+	printk("cx24108 debug: pump=%d, n=%d, a=%d\n",pump,n,a);
+	cx24110_pll_write(fe,band);
+	/* set vga and vca to their widest-band settings, as a precaution.
+	   SetSymbolrate might not be called to set this up */
+	cx24110_pll_write(fe,0x500c0000);
+	cx24110_pll_write(fe,0x83f1f800);
+	cx24110_pll_write(fe,pll);
 /*        writereg(client,0x56,0x7f);*/
 
 	return 0;
@@ -299,7 +299,7 @@ static int advbt771_samsung_tdtc9251dh0_
 	static u8 mt352_reset [] = { 0x50, 0x80 };
 	static u8 mt352_adc_ctl_1_cfg [] = { 0x8E, 0x40 };
 	static u8 mt352_agc_cfg [] = { 0x67, 0x10, 0x23, 0x00, 0xFF, 0xFF,
-	                               0x00, 0xFF, 0x00, 0x40, 0x40 };
+				       0x00, 0xFF, 0x00, 0x40, 0x40 };
 	static u8 mt352_av771_extra[] = { 0xB5, 0x7A };
 	static u8 mt352_capt_range_cfg[] = { 0x75, 0x32 };
 
@@ -463,6 +463,9 @@ static struct nxt6000_config vp3021_alps
 
 static void frontend_init(struct dvb_bt8xx_card *card, u32 type)
 {
+	int ret;
+	struct dst_state* state = NULL;
+
 	switch(type) {
 #ifdef BTTV_DVICO_DVBT_LITE
 	case BTTV_DVICO_DVBT_LITE:
@@ -503,7 +506,25 @@ static void frontend_init(struct dvb_bt8
 		break;
 
 	case BTTV_TWINHAN_DST:
-		card->fe = dst_attach(&dst_config, card->i2c_adapter, card->bt);
+		/*	DST is not a frontend driver !!!		*/
+		state = (struct dst_state *) kmalloc(sizeof (struct dst_state), GFP_KERNEL);
+		/*	Setup the Card					*/
+		state->config = &dst_config;
+		state->i2c = card->i2c_adapter;
+		state->bt = card->bt;
+
+		/*	DST is not a frontend, attaching the ASIC	*/
+		if ((dst_attach(state, &card->dvb_adapter)) == NULL) {
+			printk("%s: Could not find a Twinhan DST.\n", __FUNCTION__);
+			break;
+		}
+		card->fe = &state->frontend;
+
+		/*	Attach other DST peripherals if any		*/
+		/*	Conditional Access device			*/
+		if (state->dst_hw_cap & DST_TYPE_HAS_CA) {
+			ret = dst_ca_attach(state, &card->dvb_adapter);
+		}
 		if (card->fe != NULL) {
 			break;
 		}
@@ -648,7 +669,7 @@ static int dvb_bt8xx_probe(struct device
 	case BTTV_PINNACLESAT:
 		card->gpio_mode = 0x0400c060;
 		/* should be: BT878_A_GAIN=0,BT878_A_PWRDN,BT878_DA_DPM,BT878_DA_SBR,
-		              BT878_DA_IOM=1,BT878_DA_APP to enable serial highspeed mode. */
+			      BT878_DA_IOM=1,BT878_DA_APP to enable serial highspeed mode. */
 		card->op_sync_orin = 0;
 		card->irq_err_ignore = 0;
 		break;
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dvb-bt8xx.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-05-08 18:12:25.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dvb-bt8xx.h	2005-05-08 18:13:30.000000000 +0200
@@ -31,7 +31,7 @@
 #include "bttv.h"
 #include "mt352.h"
 #include "sp887x.h"
-#include "dst.h"
+#include "dst_common.h"
 #include "nxt6000.h"
 #include "cx24110.h"
 #include "or51211.h"
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/Kconfig
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/Kconfig	2005-05-08 18:09:01.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/Kconfig	2005-05-08 18:13:30.000000000 +0200
@@ -11,9 +11,8 @@ config DVB_BT8XX
 	  the Nebula cards, the Pinnacle PCTV cards, the Twinhan DST cards and
 	  pcHDTV HD2000 cards.
 
-          Since these cards have no MPEG decoder onboard, they transmit
+	  Since these cards have no MPEG decoder onboard, they transmit
 	  only compressed MPEG data over the PCI bus, so you need
 	  an external software decoder to watch TV on your computer.
 
 	  Say Y if you own such a device and want to use it.
-

--

