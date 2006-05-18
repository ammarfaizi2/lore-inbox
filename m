Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWERHHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWERHHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWERHHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:07:04 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:40666 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751292AbWERHHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:07:03 -0400
Date: Thu, 18 May 2006 09:07:00 +0200
From: Harald Welte <laforge@gnumonks.org>
To: openezx-devel@lists.gnumonks.org
Cc: linux-kernel@vger.kernel.org
Subject: How should Touchscreen Input Drives behave (OpenEZX pcap_ts)
Message-ID: <20060518070700.GT17897@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X2rN3GNvz+yeh2G1"
Content-Disposition: inline
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X2rN3GNvz+yeh2G1
Content-Type: multipart/mixed; boundary="IFrzt5yFNjsAZ17G"
Content-Disposition: inline


--IFrzt5yFNjsAZ17G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

After a lot of struggle, I've finally managed to get my new PCAP2
touchscreen driver for the OpenEZX (http://www.openezx.org/) project
into a somewhat working state.  This means all the hardware-related bits
such as ADC reading and IRQ handling works, and it reports some values
to the upper layers.

It uses the standard input core api and should thus theoretically behave
like any other touchscreen.

Since I've never even owned a linux-driven touchscreen before, let aside
written a ts driver (though plenty of other drivers) yet, there are some
questions that maybe somebody on this list can reply to.

0) What kind of X/Y/Pressure values should I return?  Are they supposed
   to be scaled to the X/Y resolution of the LCD?  As of now, I return
   X_ABS, Y_ABS and PRESSURE values between 0 and 1000 (each).

   However, the coordinates are actually inverted, so '0,0' corresponds
   to the lower right corner of the screen, whereas '1000,1000' is the
   upper left corner.  Shall I invert them (i.e. return 1000-coord')?

1) where does touchscreen calibration happen?  The EZX phones (like many
   other devices, I believe) only contain resistive touchscreens that
   appear pretty uncalibrated.   I'm sure the factory-set calibration
   data must be stored somewhere in flash, but it's definitely handled
   in the proprietary EZX userland, since their old kernel driver
   doesn't have any calibration related bits.

2) what about the 'button' event.  In addition to the pressure (which is
   about 300 for regular stylus use, > 400 if you press hard and > 600 if
   you use yourfinger), some existing TS drivers return a button press.
   Is it up to me to decide after which pressure level to consider the
   button to be pressed / released?

Looking forward to your replies.

I've attached the current status of pcap_ts.c to this file.  It will use
a number of symbols only present in the -ezx5 kernel.  This is not
intended for any kind of mainlinie inclusion, reports on coding style or
the like.  All will happen at its time.

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
We all know Linux is great...it does infinite loops in 5 seconds. -- Linus

--IFrzt5yFNjsAZ17G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ezx_ts.patch"
Content-Transfer-Encoding: quoted-printable

Index: linux-2.6.16.13-ezx3/drivers/input/touchscreen/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.13-ezx3.orig/drivers/input/touchscreen/Kconfig	2006-05-17 =
23:34:47.000000000 +0200
+++ linux-2.6.16.13-ezx3/drivers/input/touchscreen/Kconfig	2006-05-17 23:39=
:26.000000000 +0200
@@ -108,4 +108,16 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called hp680_ts_input.
=20
+config TOUCHSCREEN_PCAP
+	tristate "Motorola PCAP touchscreen"
+	depends on PXA_EZX_PCAP
+	help
+	  Say Y here if you have a Motorola EZX (E680, A780) telephone
+	  and want to support the built-in touchscreen.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hp680_ts_input.
+
 endif
Index: linux-2.6.16.13-ezx3/drivers/input/touchscreen/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.16.13-ezx3.orig/drivers/input/touchscreen/Makefile	2006-05-17=
 23:34:47.000000000 +0200
+++ linux-2.6.16.13-ezx3/drivers/input/touchscreen/Makefile	2006-05-17 23:3=
9:26.000000000 +0200
@@ -12,3 +12,4 @@
 obj-$(CONFIG_TOUCHSCREEN_MTOUCH) +=3D mtouch.o
 obj-$(CONFIG_TOUCHSCREEN_MK712)	+=3D mk712.o
 obj-$(CONFIG_TOUCHSCREEN_HP600)	+=3D hp680_ts_input.o
+obj-$(CONFIG_TOUCHSCREEN_PCAP)	+=3D pcap_ts.o
Index: linux-2.6.16.13-ezx3/drivers/input/touchscreen/pcap_ts.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.16.13-ezx3/drivers/input/touchscreen/pcap_ts.c	2006-05-18 00:=
04:02.000000000 +0200
@@ -0,0 +1,333 @@
+/*
+ * pcap_ts.c - Touchscreen driver for Motorola PCAP2 based touchscreen as =
found
+ * 	       in the EZX phone platform.
+ *
+ *  Copyright (C) 2006 Harald Welte <laforge@openezx.org>
+ *
+ *  Based on information found in the original Motorola 2.4.x ezx-ts.c dri=
ver.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ * TODO:
+ * 	split this in a hardirq handler and a tasklet/bh
+ * 	suspend/resume support
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/string.h>
+#include <linux/pm.h>
+#include <linux/timer.h>
+#include <linux/config.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+
+#include <asm/arch/hardware.h>
+#include <asm/arch/pxa-regs.h>
+
+#include "../../misc/ezx/ssp_pcap.h"
+
+#if 0
+#define DEBUGP(x, args ...) printk(KERN_DEBUG "%s: " x, __FUNCTION__, ## a=
rgs)
+#else
+#define DEBUGP(x, args ...)
+#endif
+
+#define PRESSURE 1
+#define COORDINATE 2
+
+struct pcap_ts {
+	int irq_xy;
+	int irq_touch;
+	struct input_dev *input;
+
+	int read_state;
+	int x, y, pressure;
+	int x_pre, y_pre;
+};
+
+#define X_AXIS_MIN	0
+#define X_AXIS_MAX	1023
+
+#define Y_AXIS_MAX	X_AXIS_MAX
+#define Y_AXIS_MIN	X_AXIS_MIN
+
+#define PRESSURE_MAX	X_AXIS_MAX
+#define PRESSURE_MIN	X_AXIS_MIN
+
+static int pcap_ts_mode(u_int32_t mode)
+{
+	int ret;
+
+	u_int32_t tmp;
+
+	ret =3D ezx_pcap_read(SSP_PCAP_ADJ_ADC1_REGISTER, &tmp);
+	if (ret < 0)
+		return ret;
+
+	tmp &=3D ~SSP_PCAP_TOUCH_PANEL_POSITION_DETECT_MODE_MASK;
+	tmp |=3D mode;
+	ret =3D ezx_pcap_write(SSP_PCAP_ADJ_ADC1_REGISTER, tmp);
+
+	return ret;
+}
+
+/* issue a XY read command to the ADC of PCAP2.  Well get an ADCDONE2 inte=
rrupt
+ * once the result of the conversion is available */
+static int pcap_ts_start_xy_read(void)
+{
+	int ret;
+	u_int32_t tmp;
+
+	ret =3D ezx_pcap_read(SSP_PCAP_ADJ_ADC1_REGISTER, &tmp);
+	if (ret < 0)
+		return ret;
+
+	tmp &=3D SSP_PCAP_ADC_START_VALUE_SET_MASK;
+	tmp |=3D SSP_PCAP_ADC_START_VALUE;
+
+	ret =3D ezx_pcap_write(SSP_PCAP_ADJ_ADC1_REGISTER, tmp);
+	if (ret < 0)
+		return ret;
+
+	ret =3D ezx_pcap_bit_set(SSP_PCAP_ADJ_BIT_ADC2_ASC, 1);
+
+	return ret;
+}
+
+/* read the XY result from the ADC of PCAP2 */
+static int pcap_ts_get_xy_value(struct pcap_ts *pcap_ts)
+{
+	int ret;
+	u_int32_t tmp;
+
+	ret =3D ezx_pcap_read(SSP_PCAP_ADJ_ADC2_REGISTER, &tmp);
+	if (ret < 0)
+		return ret;
+
+	if (tmp & 0x00400000)
+		return -EIO;
+
+	if (pcap_ts->read_state =3D=3D COORDINATE) {
+		pcap_ts->x =3D (tmp & SSP_PCAP_ADD1_VALUE_MASK);
+		pcap_ts->y =3D (tmp & SSP_PCAP_ADD2_VALUE_MASK)
+						>>SSP_PCAP_ADD2_VALUE_SHIFT;
+	} else
+		pcap_ts->pressure =3D (tmp & SSP_PCAP_ADD2_VALUE_MASK)
+						>>SSP_PCAP_ADD2_VALUE_SHIFT;
+
+	/* we need to switch back to standby mode, because PCAP only generates
+	 * touch screen interrupts when in standby mode */
+	pcap_ts_mode(PCAP_TS_STANDBY_MODE);
+
+	return 0;
+}
+
+static irqreturn_t pcap_ts_irq_timer(int irq, void *dev_id, struct pt_regs=
 *regs)
+{
+	DEBUGP("entered\n");
+	pcap_ts_mode(PCAP_TS_POSITION_XY_MEASUREMENT);
+	pcap_ts_start_xy_read();
+
+	return IRQ_HANDLED;
+}
+
+/* PCAP2 interrupts us when ADC conversion result is available */
+static irqreturn_t pcap_ts_irq_xy(int irq, void *dev_id, struct pt_regs *r=
egs)
+{
+	struct pcap_ts *pcap_ts =3D dev_id;
+
+	if (pcap_ts_get_xy_value(pcap_ts) < 0) {
+		DEBUGP("pcap_ts: error reading XY value\n");
+		return IRQ_HANDLED;
+	}
+
+	DEBUGP("%s X=3D%4d, Y=3D%4d Z=3D%4d\n",
+		pcap_ts->read_state =3D=3D COORDINATE ? "COORD" : "PRESS",
+		pcap_ts->x, pcap_ts->y, pcap_ts->pressure);
+
+	if (pcap_ts->read_state =3D=3D PRESSURE) {
+		if (pcap_ts->pressure >=3D PRESSURE_MAX ||
+		    pcap_ts->pressure <=3D PRESSURE_MIN) {
+			/* pen has been released */
+			input_report_abs(pcap_ts->input, ABS_PRESSURE, pcap_ts->y);
+			input_report_key(pcap_ts->input, BTN_TOUCH, 0);
+
+			pcap_ts->x =3D pcap_ts->y =3D 0;
+
+			/* ask PCAP2 to interrupt us if touch event happens again */
+			ezx_pcap_bit_set(SSP_PCAP_ADJ_BIT_MSR_TSM, 0);
+		} else {
+			/* pen has been touched down */
+
+			/* FIXME: can we report this now, even that we don't
+			 * know oure coordinates yet? */
+			input_report_abs(pcap_ts->input, ABS_PRESSURE, pcap_ts->y);
+			input_report_key(pcap_ts->input, BTN_TOUCH, 1);
+
+			/* switch state machine into coordinate read mode */
+			pcap_ts->read_state =3D COORDINATE;
+			pcap_ts_mode(PCAP_TS_POSITION_XY_MEASUREMENT);
+			pcap_ts_start_xy_read();
+		}
+	} else {
+		/* we are in coordinate mode */
+		if (pcap_ts->x <=3D X_AXIS_MIN || pcap_ts->x >=3D X_AXIS_MAX ||
+		    pcap_ts->y <=3D Y_AXIS_MIN || pcap_ts->y >=3D Y_AXIS_MAX) {
+			DEBUGP("invalid x/y coordinate position: PEN_UP?\n");
+			pcap_ts->x =3D pcap_ts->y =3D 0;
+
+			/* switch back to pressure read mode */
+			pcap_ts->read_state =3D PRESSURE;
+			pcap_ts_mode(PCAP_TS_STANDBY_MODE);
+
+			/* ask PCAP2 to interrupt us if touch event happens again */
+			ezx_pcap_bit_set(SSP_PCAP_ADJ_BIT_MSR_TSM, 0);
+		} else {
+			input_report_abs(pcap_ts->input, ABS_X, pcap_ts->x);
+			input_report_abs(pcap_ts->input, ABS_Y, pcap_ts->y);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+/* PCAP2 interrupts us if the pen touches down */
+static irqreturn_t pcap_ts_irq_touch(int irq, void *dev_id, struct pt_regs=
 *regs)
+{
+	struct pcap_ts *pcap_ts =3D dev_id;
+	DEBUGP("entered\n");
+
+	pcap_ts_mode(PCAP_TS_PRESSURE_MEASUREMENT);
+	pcap_ts->read_state =3D PRESSURE;
+	pcap_ts_start_xy_read();
+	pcap_ts->x_pre =3D 0;
+	pcap_ts->y_pre =3D 0;
+
+	return IRQ_HANDLED;
+}
+
+static int __init ezxts_probe(struct platform_device *pdev)
+{
+	struct pcap_ts *pcap_ts;
+	struct input_dev *input_dev;
+	int err =3D -ENOMEM;
+
+	pcap_ts =3D kzalloc(sizeof(*pcap_ts), GFP_KERNEL);
+	input_dev =3D input_allocate_device();
+	if (!pcap_ts || !input_dev)
+		goto fail;
+
+	pcap_ts->irq_xy =3D platform_get_irq(pdev, 0);
+	if (pcap_ts->irq_xy < 0) {
+		err =3D pcap_ts->irq_xy;
+		goto fail;
+	}
+
+	pcap_ts->irq_touch =3D platform_get_irq(pdev, 1);
+	if (pcap_ts->irq_touch < 0) {
+		err =3D pcap_ts->irq_touch;
+		goto fail;
+	}
+
+	ssp_pcap_open(SSP_PCAP_TS_OPEN);
+
+	err =3D request_irq(pcap_ts->irq_xy, pcap_ts_irq_xy, SA_INTERRUPT,
+			  "PCAP Touchscreen XY", pcap_ts);
+	if (err < 0) {
+		printk(KERN_ERR "pcap_ts: can't grab xy irq %d: %d\n",
+		       pcap_ts->irq_xy, err);
+		goto fail;
+	}
+
+	err =3D request_irq(pcap_ts->irq_touch, pcap_ts_irq_touch, SA_INTERRUPT,
+			  "PCAP Touchscreen Touch", pcap_ts);
+	if (err < 0) {
+		printk(KERN_ERR "pcap_ts: can't grab touch irq %d: %d\n",
+		       pcap_ts->irq_touch, err);
+		goto fail_xy;
+	}
+
+	pcap_ts->input =3D input_dev;
+
+	platform_set_drvdata(pdev, pcap_ts);
+
+	/* enable pressure interrupt */
+	ezx_pcap_bit_set(SSP_PCAP_ADJ_BIT_MSR_TSM, 0);
+
+	input_dev->name =3D "EZX PCAP2 Touchscreen";
+	input_dev->phys =3D "ezxts/input0";
+	input_dev->id.bustype =3D BUS_HOST;
+	input_dev->id.vendor =3D 0x0001;
+	input_dev->id.product =3D 0x0002;
+	input_dev->id.version =3D 0x0100;
+	input_dev->cdev.dev =3D &pdev->dev;
+	input_dev->private =3D pcap_ts;
+
+	input_dev->evbit[0] =3D BIT(EV_KEY) | BIT(EV_ABS);
+	input_dev->keybit[LONG(BTN_TOUCH)] =3D BIT(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X, X_AXIS_MIN, X_AXIS_MAX, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, Y_AXIS_MIN, Y_AXIS_MAX, 0, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, PRESSURE_MIN,
+			     PRESSURE_MAX, 0, 0);
+
+	input_register_device(pcap_ts->input);
+
+	pcap_ts->read_state =3D PRESSURE;
+
+	return 0;
+
+fail_touch:
+	free_irq(pcap_ts->irq_touch, pcap_ts);
+fail_xy:
+	free_irq(pcap_ts->irq_xy, pcap_ts);
+fail:
+	input_free_device(input_dev);
+	kfree(pcap_ts);
+
+	return err;
+}
+
+static int ezxts_remove(struct platform_device *pdev)
+{
+	struct pcap_ts *pcap_ts =3D platform_get_drvdata(pdev);
+
+	free_irq(pcap_ts->irq_touch, pcap_ts);
+	free_irq(pcap_ts->irq_xy, pcap_ts);
+
+	input_unregister_device(pcap_ts->input);
+	kfree(pcap_ts);
+
+	return 0;
+}
+
+static struct platform_driver ezxts_driver =3D {
+	.probe		=3D ezxts_probe,
+	.remove		=3D ezxts_remove,
+	//.suspend	=3D ezxts_suspend,
+	//.resume		=3D ezxts_resume,
+	.driver		=3D {
+		.name	=3D "pcap-ts",
+	},
+};
+
+static int __devinit ezxts_init(void)
+{
+	return platform_driver_register(&ezxts_driver);
+}
+
+static void __exit ezxts_exit(void)
+{
+	platform_driver_unregister(&ezxts_driver);
+}
+
+module_init(ezxts_init);
+module_exit(ezxts_exit);
+
+MODULE_DESCRIPTION("Motorola PCAP2 touchscreen driver");
+MODULE_AUTHOR("Harald Welte <laforge@openezx.org>");
+MODULE_LICENSE("GPL");

--IFrzt5yFNjsAZ17G--

--X2rN3GNvz+yeh2G1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEbB0UXaXGVTD0i/8RApgBAJ0ayfsVCGzKDSmcG4To3aQmC9r5YgCfesZo
ON0k4URXEzbHD/DhaINpmzY=
=85M0
-----END PGP SIGNATURE-----

--X2rN3GNvz+yeh2G1--
