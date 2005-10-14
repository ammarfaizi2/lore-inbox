Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbVJNVDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbVJNVDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 17:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVJNVDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 17:03:50 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:12993 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750902AbVJNVDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 17:03:50 -0400
X-Envelope-From: stefan@lucke.in-berlin.de
From: Stefan Lucke <stefan@lucke.in-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: Re: touchkit PS/2 touchscreen driver
Date: Fri, 14 Oct 2005 23:03:45 +0200
User-Agent: KMail/1.5.4
References: <200510090926.24426.stefan@lucke.in-berlin.de> <20051010051016.GI32628@pazke>
In-Reply-To: <20051010051016.GI32628@pazke>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_x0BUDFwyI+2Mk93"
Message-Id: <200510142303.45694.stefan@lucke.in-berlin.de>
X-Spam-Score: (0.407) AWL,BAYES_50,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_x0BUDFwyI+2Mk93
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Montag, 10. Oktober 2005 07:10, Andrey Panin wrote:
> On 282, 10 09, 2005 at 09:26:24AM +0200, Stefan Lucke wrote:
> > Hi,
> > 
> > based on the touchkit USB and livebook PS/2 touchscreen driver,
> > I made a driver for the touchkit PS/2 version. The work is based upon
> > kernel 2.6.13.2 .
> > 
> > The egalax touchsreen controller (PS/2 or USB version) is used
> > in this 7" device:
> > http://www.cartft.com/catalog/il/449
> > 
> > Currently I'm using the PS/2 version in a DirectFB enviroment.
> > http://www.directfb.org/
> > http://mail.directfb.org/pipermail/directfb-dev/2005-September/000705.html
> > http://mail.directfb.org/pipermail/directfb-dev/2005-September/000706.html
> > 
> > 
> > Could you please have a look at it and tell my your comments on
> > what would be additional required to get it included into kernel tree.
> 
> Hi Stefan,
> 
> first if you want people to review your code please don't send such small
> patches in compressed form. In general patch looks good, but see comments
> below.
> 

Thanks for your review Andrey,

hopfully I got them all fixed.

Please CC me in relpies,as I'm still not subscribed.

> > --- linux-2.6.13.2.vanilla/drivers/input/mouse/psmouse-base.c       2005-09-17 03:02:12.000000000 +0200
> > +++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/psmouse-base.c  2005-09-23 19:10:42.000000000 +0200

> > @@ -518,6 +526,10 @@ static int psmouse_extensions(struct psm
> >  
> >     if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse, set_properties) == 0)
> >             return PSMOUSE_IMPS;
> > +#if 0
> > +   if (max_proto >= PSMOUSE_TOUCHKIT_PS2 && touchkit_ps2_detect(psmouse, set_properties) == 0)
> > +           return PSMOUSE_TOUCHKIT_PS2;
> > +#endif                
> 
> Hmm, is this part really needed ?

Not really, but that's now the place where detection and
initialisation is done.

> > +
> > +   param[0] = 1;
> > +   param[1] = 'A';
> > +
> > +   if (ps2_command(&psmouse->ps2dev, param, (2<<12)|(3<<8)|0x0A) == 0 &&
> 
> Can you add descriptive #define for (2<<12)|(3<<8)|0x0A) ? Bare magic
> numbers are ugly.
> 

Sending ps2_command() in other drivers is ugly too. Number of bytes 
to send is in nibble of upper byte (2 in this case) and number of 
bytes to receive is in lower nibble of upper byte. A bare magic define
of 0x230A does not help, so I use another define now.

--Boundary-00=_x0BUDFwyI+2Mk93
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="touchkit_ps2.pub02.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="touchkit_ps2.pub02.diff"

diff -uprN linux-2.6.13.2.vanilla/drivers/input/mouse/Makefile linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/Makefile
--- linux-2.6.13.2.vanilla/drivers/input/mouse/Makefile	2005-09-17 03:02:12.000000000 +0200
+++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/Makefile	2005-09-23 18:09:08.000000000 +0200
@@ -15,4 +15,4 @@ obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
 
-psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o
+psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o touchkit_ps2.o
diff -uprN linux-2.6.13.2.vanilla/drivers/input/mouse/psmouse-base.c linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/psmouse-base.c
--- linux-2.6.13.2.vanilla/drivers/input/mouse/psmouse-base.c	2005-09-17 03:02:12.000000000 +0200
+++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/psmouse-base.c	2005-10-14 22:36:34.000000000 +0200
@@ -25,6 +25,7 @@
 #include "logips2pp.h"
 #include "alps.h"
 #include "lifebook.h"
+#include "touchkit_ps2.h"
 
 #define DRIVER_DESC	"PS/2 mouse driver"
 
@@ -501,6 +502,7 @@ static int psmouse_extensions(struct psm
 		}
 	}
 
+
 	if (max_proto > PSMOUSE_IMEX && genius_detect(psmouse, set_properties) == 0)
 		return PSMOUSE_GENPS;
 
@@ -519,6 +521,13 @@ static int psmouse_extensions(struct psm
 	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse, set_properties) == 0)
 		return PSMOUSE_IMPS;
 
+	if (touchkit_ps2_detect(psmouse, set_properties) == 0) {
+		if (max_proto >= PSMOUSE_TOUCHKIT_PS2) {
+			if (!set_properties || touchkit_ps2_init(psmouse) == 0)
+				return PSMOUSE_TOUCHKIT_PS2;
+		}
+	}
+
 /*
  * Okay, all failed, we have a standard mouse here. The number of the buttons
  * is still a question, though. We assume 3.
@@ -600,6 +609,13 @@ static struct psmouse_protocol psmouse_p
 		.init		= lifebook_init,
 	},
 	{
+		.type		= PSMOUSE_TOUCHKIT_PS2,
+		.name		= "touchkitPS/2",
+		.alias		= "touchkit",
+		.detect		= touchkit_ps2_detect,
+		.init		= touchkit_ps2_init,
+	},
+	{
 		.type		= PSMOUSE_AUTO,
 		.name		= "auto",
 		.alias		= "any",
diff -uprN linux-2.6.13.2.vanilla/drivers/input/mouse/psmouse.h linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/psmouse.h
--- linux-2.6.13.2.vanilla/drivers/input/mouse/psmouse.h	2005-09-17 03:02:12.000000000 +0200
+++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/psmouse.h	2005-09-23 17:46:38.000000000 +0200
@@ -78,6 +78,7 @@ enum psmouse_type {
 	PSMOUSE_SYNAPTICS,
 	PSMOUSE_ALPS,
 	PSMOUSE_LIFEBOOK,
+	PSMOUSE_TOUCHKIT_PS2,
 	PSMOUSE_AUTO		/* This one should always be last */
 };
 
diff -uprN linux-2.6.13.2.vanilla/drivers/input/mouse/touchkit_ps2.c linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/touchkit_ps2.c
--- linux-2.6.13.2.vanilla/drivers/input/mouse/touchkit_ps2.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/touchkit_ps2.c	2005-10-14 22:39:13.000000000 +0200
@@ -0,0 +1,195 @@
+/* ----------------------------------------------------------------------------
+ * touchkit_ps2.c  --  Driver for eGalax TouchKit PS/2 Touchscreens
+ *
+ * Copyright (C) 2005 by Stefan Lucke
+ * Copyright (C) 2004 by Daniel Ritz
+ * Copyright (C) by Todd E. Johnson (mtouchusb.c)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Based upon touchkitusb.c
+ *
+ * Vendor documentation is available in support section of:
+ * http://www.egalax.com.tw/
+ *
+ */
+
+/*
+ * Changelog:
+ *
+ * 2005-10-14:	whitespace & indentaion cleanup
+ *		touchkit commands defined
+ * initial version 0.1
+ */
+ 
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <linux/input.h>
+#include <linux/serio.h>
+#include <linux/libps2.h>
+#include <linux/dmi.h>
+
+#include "psmouse.h"
+#include "touchkit_ps2.h"
+
+#define TOUCHKIT_MIN_XC			0x0
+#define TOUCHKIT_MAX_XC			0x07ff
+#define TOUCHKIT_XC_FUZZ		0x0
+#define TOUCHKIT_XC_FLAT		0x0
+#define TOUCHKIT_MIN_YC			0x0
+#define TOUCHKIT_MAX_YC			0x07ff
+#define TOUCHKIT_YC_FUZZ		0x0
+#define TOUCHKIT_YC_FLAT		0x0
+#define TOUCHKIT_REPORT_DATA_SIZE	8
+
+#define TOUCHKIT_CMD			0x0A
+#define TOUCHKIT_CMD_LENGTH		1
+
+#define TOUCHKIT_CMD_ACTIVE		'A'
+#define TOUCHKIT_CMD_FIRMWARE_VERSION	'D'
+#define TOUCHKIT_CMD_CONTROLLER_TYPE	'E'
+
+#define TOUCHKIT_SEND_PARMS(s,r,c)	((s) << 12 | (r) << 8 | (c))
+
+#define TOUCHKIT_DOWN			0x01
+#define TOUCHKIT_POINT_TOUCH		0x81
+#define TOUCHKIT_POINT_NOTOUCH		0x80
+
+#define TOUCHKIT_GET_TOUCHED(dat)	((((dat)[0]) & TOUCHKIT_DOWN) ? 1 : 0)
+#define TOUCHKIT_GET_X(dat)		(((dat)[1] << 7) | (dat)[2])
+#define TOUCHKIT_GET_Y(dat)		(((dat)[3] << 7) | (dat)[4])
+
+#define DRIVER_VERSION			"v0.2"
+#define DRIVER_AUTHOR			"Stefan Lucke <stefan@lucke.in-berlin.de>"
+#define DRIVER_DESC			"eGalax TouchKit PS/2 Touchscreen Driver"
+
+static int xyswap = 0;
+module_param(xyswap, bool, 0644);
+MODULE_PARM_DESC(xyswap, "If set X and Y axes are swapped.");
+
+static int  xinvert = 0;
+module_param(xinvert, bool, 0644);
+MODULE_PARM_DESC(xinvert, "Invert direction of x axis.");
+
+static int  yinvert = 0;
+module_param(yinvert, bool, 0644);
+MODULE_PARM_DESC(yinvert, "Invert direction of y axis.");
+
+static int  xfuzz = 0;
+module_param(xfuzz, uint, 0644);
+MODULE_PARM_DESC(xinvert, "Fuzz value for x axis.");
+
+static int  yfuzz = 0;
+module_param(yfuzz, uint, 0644);
+MODULE_PARM_DESC(yfuzz, "Fuzz value for y axis.");
+
+static int  smartpad = 0;
+module_param(smartpad, bool, 0644);
+MODULE_PARM_DESC(smartpad, "Act as a smartpad device.");
+
+static int  mouse = 0;
+module_param(mouse, bool, 0644);
+MODULE_PARM_DESC(mouse, "Report mouse button");
+
+static psmouse_ret_t touchkit_ps2_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+{
+	unsigned char 		*packet = psmouse->packet;
+	struct input_dev 	*dev = &psmouse->dev;
+	int 			x,y;
+
+	if (psmouse->pktcnt != 5)
+		return PSMOUSE_GOOD_DATA;
+
+	input_regs(dev, regs);
+
+	if (xyswap) {
+		y = TOUCHKIT_GET_X(packet);
+		x = TOUCHKIT_GET_Y(packet);
+	} else {
+		x = TOUCHKIT_GET_X(packet);
+		y = TOUCHKIT_GET_Y(packet);
+	}
+
+	y = (yinvert) ? TOUCHKIT_MAX_YC - y : y;
+	x = (xinvert) ? TOUCHKIT_MAX_XC - x : x;
+
+	input_report_key(dev,
+			 (mouse) ? BTN_MOUSE : BTN_TOUCH,
+			 TOUCHKIT_GET_TOUCHED(packet));
+
+	if (smartpad)
+		input_report_key(dev, BTN_TOOL_FINGER, 1);
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, y);
+
+	input_sync(dev);
+
+	return PSMOUSE_FULL_PACKET;
+}
+
+int touchkit_ps2_detect(struct psmouse *psmouse, int set_properties)
+{
+	unsigned char	param[3];
+	int		command;
+
+	param[0] = TOUCHKIT_CMD_LENGTH;
+	param[1] = TOUCHKIT_CMD_ACTIVE;
+	command = TOUCHKIT_SEND_PARMS(2, 3, TOUCHKIT_CMD);
+
+	if (ps2_command(&psmouse->ps2dev, param, command) == 0 &&
+	    param[0] == TOUCHKIT_CMD &&
+	    param[1] == 0x01 &&
+	    param[2] == TOUCHKIT_CMD_ACTIVE){
+		printk(KERN_INFO "touchkit_ps2: device detected\n");
+		if (set_properties) {
+			psmouse->vendor = "eGalax";
+			psmouse->name = "Touchscreen";
+		}
+		return 0;
+	}
+	return -1;
+}
+
+int touchkit_ps2_init(struct psmouse *psmouse)
+{
+	psmouse->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
+
+	set_bit((mouse) ? BTN_MOUSE : BTN_TOUCH,psmouse->dev.keybit);
+	if (smartpad)
+		set_bit(BTN_TOOL_FINGER,psmouse->dev.keybit);
+
+	psmouse->dev.absbit[0] = BIT(ABS_X) | BIT(ABS_Y);
+
+	/* Used to Scale Compensated Data */
+	psmouse->dev.absmin[ABS_X] = TOUCHKIT_MIN_XC;
+	psmouse->dev.absmax[ABS_X] = TOUCHKIT_MAX_XC;
+	psmouse->dev.absfuzz[ABS_X] = xfuzz;
+	psmouse->dev.absflat[ABS_X] = TOUCHKIT_XC_FLAT;
+	psmouse->dev.absmin[ABS_Y] = TOUCHKIT_MIN_YC;
+	psmouse->dev.absmax[ABS_Y] = TOUCHKIT_MAX_YC;
+	psmouse->dev.absfuzz[ABS_Y] = yfuzz;
+	psmouse->dev.absflat[ABS_Y] = TOUCHKIT_YC_FLAT;
+
+	input_set_abs_params(&psmouse->dev, ABS_X, 0, 0x07ff, xfuzz, 0);
+	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 0x07ff, yfuzz, 0);
+
+	psmouse->protocol_handler = touchkit_ps2_process_byte;
+	psmouse->pktsize = 5;
+
+	return 0;
+}
diff -uprN linux-2.6.13.2.vanilla/drivers/input/mouse/touchkit_ps2.h linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/touchkit_ps2.h
--- linux-2.6.13.2.vanilla/drivers/input/mouse/touchkit_ps2.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.13.2.touchkit_ps2/drivers/input/mouse/touchkit_ps2.h	2005-09-24 12:34:23.000000000 +0200
@@ -0,0 +1,18 @@
+/* ----------------------------------------------------------------------------
+ * touchkit_ps2.h  --  Driver for eGalax TouchKit PS/2 Touchscreens
+ *
+ * Copyright (C) 2005 by Stefan Lucke
+ * Copyright (c) 2005 Vojtech Pavlik
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _TOUCHKIT_PS2_H
+#define _TOUCHKIT_PS2_H
+
+int touchkit_ps2_detect(struct psmouse *psmouse, int set_properties);
+int touchkit_ps2_init(struct psmouse *psmouse);
+
+#endif

--Boundary-00=_x0BUDFwyI+2Mk93--

