Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUBKBiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbUBKBh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:37:29 -0500
Received: from wacom-nt2.wacom.com ([204.119.25.126]:48911 "EHLO
	wacom_nt2.WACOM.COM") by vger.kernel.org with ESMTP id S263805AbUBKBgL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:36:11 -0500
Message-ID: <28E6D16EC4CCD71196610060CF213AEB065BBF@wacom-nt2.wacom.com>
From: Ping Cheng <pingc@wacom.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: "''vojtech@suse.cz' '" <vojtech@suse.cz>, "'Greg KH '" <greg@kroah.com>
Subject: Wacom USB driver patch
Date: Tue, 10 Feb 2004 17:23:11 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C3F03A.2D56C8DC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C3F03A.2D56C8DC
Content-Type: text/plain

 <<linuxwacom.patch>> 
Attached is a wacom driver patch for kernel 2.6. I have sent my patch to
Vojtech last year. But, he didn't commit it. I bet he's busy. So, hope
someone in this list can help me check the code in.

Please reply to me directly since I am not in linux-kernel mailing list. 

Thanks!

Ping

-----Original Message-----
From: Greg KH
To: Ping Cheng
Sent: 2/10/04 4:54 PM
Subject: Re: Wacom USB driver patch

On Tue, Feb 10, 2004 at 04:48:32PM -0800, Ping Cheng wrote:
> Can someone in the To list commit my patch? The patch is based on
wacom.c
> 1.32 and hid-core.c 1.72 at http://linux.bkbits.net:8080/linux-2.5. 

So this is for the 2.6 kernel?

Your patch is line-wrapped, and can't be applied by using 'patch -p1'
from the main kernel directory.

Vojtech would be the one to ACK this patch or not, but you also might
want to CC: the linux-usb-devel mailing list.

thanks,

greg k-h

------_=_NextPart_000_01C3F03A.2D56C8DC
Content-Type: application/octet-stream;
	name="linuxwacom.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="linuxwacom.patch"

diff -purN wacom.c@1.32 wacom.c=0A=
--- wacom.c@1.32	2004-02-10 14:32:01.000000000 -0800=0A=
+++ wacom.c	2004-02-10 15:34:00.000000000 -0800=0A=
@@ -8,7 +8,7 @@=0A=
  *  Copyright (c) 2000 James E. Blair		<corvus@gnu.org>=0A=
  *  Copyright (c) 2000 Daniel Egger		<egger@suse.de>=0A=
  *  Copyright (c) 2001 Frederic Lepied		<flepied@mandrakesoft.com>=0A=
- *  Copyright (c) 2002 Ping Cheng		<pingc@wacom.com>=0A=
+ *  Copyright (c) 2002-2004 Ping Cheng		<pingc@wacom.com>=0A=
  *=0A=
  *  ChangeLog:=0A=
  *      v0.1 (vp)  - Initial release=0A=
@@ -137,14 +137,12 @@ static void wacom_pl_irq(struct urb *urb=0A=
 	}=0A=
 =0A=
 	if (data[0] !=3D 2)=0A=
-		dbg("received unknown report #%d", data[0]);=0A=
+		dbg("wacom_pl_irq: received unknown report #%d", data[0]);=0A=
 =0A=
 	prox =3D data[1] & 0x40;=0A=
 =0A=
 	input_regs(dev, regs);=0A=
 	=0A=
-	input_report_key(dev, BTN_TOOL_PEN, prox);=0A=
-	=0A=
 	if (prox) {=0A=
 =0A=
 		pressure =3D (signed char)((data[7] << 1) | ((data[4] >> 2) & =
1));=0A=
@@ -152,15 +150,103 @@ static void wacom_pl_irq(struct urb *urb=0A=
 			pressure =3D (pressure << 1) | ((data[4] >> 6) & 1);=0A=
 		pressure +=3D (wacom->features->pressure_max + 1) / 2;=0A=
 =0A=
+		/*=0A=
+		 * if going from out of proximity into proximity select between the =
eraser=0A=
+		 * and the pen based on the state of the stylus2 button, choose =
eraser if=0A=
+		 * pressed else choose pen. if not a proximity change from out to =
in, send=0A=
+		 * an out of proximity for previous tool then a in for new tool.=0A=
+		 */=0A=
+		if (!wacom->tool[0]) {=0A=
+			/* Going into proximity select tool */=0A=
+			wacom->tool[1] =3D (data[4] & 0x20)? BTN_TOOL_RUBBER : =
BTN_TOOL_PEN;=0A=
+		}=0A=
+		else {=0A=
+			/* was entered with stylus2 pressed */=0A=
+			if (wacom->tool[1] =3D=3D BTN_TOOL_RUBBER && !(data[4] & 0x20) ) =
{=0A=
+				/* report out proximity for previous tool */=0A=
+				input_report_key(dev, wacom->tool[1], 0);=0A=
+				input_sync(dev);=0A=
+				wacom->tool[1] =3D BTN_TOOL_PEN;=0A=
+				return;=0A=
+			}=0A=
+		}=0A=
+		if (wacom->tool[1] !=3D BTN_TOOL_RUBBER) {=0A=
+			/* Unknown tool selected default to pen tool */=0A=
+			wacom->tool[1] =3D BTN_TOOL_PEN;=0A=
+		}=0A=
+		input_report_key(dev, wacom->tool[1], prox); /* report in proximity =
for tool */=0A=
 		input_report_abs(dev, ABS_X, data[3] | ((__u32)data[2] << 7) | =
((__u32)(data[1] & 0x03) << 14));=0A=
 		input_report_abs(dev, ABS_Y, data[6] | ((__u32)data[5] << 7) | =
((__u32)(data[4] & 0x03) << 14));=0A=
 		input_report_abs(dev, ABS_PRESSURE, pressure);=0A=
 =0A=
 		input_report_key(dev, BTN_TOUCH, data[4] & 0x08);=0A=
 		input_report_key(dev, BTN_STYLUS, data[4] & 0x10);=0A=
-		input_report_key(dev, BTN_STYLUS2, data[4] & 0x20);=0A=
+		/* Only allow the stylus2 button to be reported for the pen tool. =
*/=0A=
+		input_report_key(dev, BTN_STYLUS2, (wacom->tool[1] =3D=3D =
BTN_TOOL_PEN) && (data[4] & 0x20));=0A=
 	}=0A=
-	=0A=
+	else {=0A=
+		/* report proximity-out of a (valid) tool */=0A=
+		if (wacom->tool[1] !=3D BTN_TOOL_RUBBER) {=0A=
+			/* Unknown tool selected default to pen tool */=0A=
+			wacom->tool[1] =3D BTN_TOOL_PEN;=0A=
+		}=0A=
+		input_report_key(dev, wacom->tool[1], prox);=0A=
+	}=0A=
+=0A=
+	wacom->tool[0] =3D prox; /* Save proximity state */=0A=
+	input_sync(dev);=0A=
+=0A=
+exit:=0A=
+	retval =3D usb_submit_urb (urb, GFP_ATOMIC);=0A=
+	if (retval)=0A=
+		err ("%s - usb_submit_urb failed with result %d",=0A=
+		     __FUNCTION__, retval);=0A=
+}=0A=
+=0A=
+static void wacom_ptu_irq(struct urb *urb, struct pt_regs *regs)=0A=
+{=0A=
+	struct wacom *wacom =3D urb->context;=0A=
+	unsigned char *data =3D wacom->data;=0A=
+	struct input_dev *dev =3D &wacom->dev;=0A=
+	int retval;=0A=
+=0A=
+	switch (urb->status) {=0A=
+	case 0:=0A=
+		/* success */=0A=
+		break;=0A=
+	case -ECONNRESET:=0A=
+	case -ENOENT:=0A=
+	case -ESHUTDOWN:=0A=
+		/* this urb is terminated, clean up */=0A=
+		dbg("%s - urb shutting down with status: %d", __FUNCTION__, =
urb->status);=0A=
+		return;=0A=
+	default:=0A=
+		dbg("%s - nonzero urb status received: %d", __FUNCTION__, =
urb->status);=0A=
+		goto exit;=0A=
+	}=0A=
+=0A=
+	if (data[0] !=3D 2)=0A=
+	{=0A=
+		printk(KERN_INFO "wacom_ptu_irq: received unknown report #%d\n", =
data[0]);=0A=
+	}=0A=
+=0A=
+	input_regs(dev, regs);=0A=
+	if (data[1] & 0x04)=0A=
+	{=0A=
+		input_report_key(dev, BTN_TOOL_RUBBER, data[1] & 0x20);=0A=
+		input_report_key(dev, BTN_TOUCH, data[1] & 0x08);=0A=
+	}=0A=
+	else=0A=
+	{=0A=
+		input_report_key(dev, BTN_TOOL_PEN, data[1] & 0x20);=0A=
+		input_report_key(dev, BTN_TOUCH, data[1] & 0x01);=0A=
+	}=0A=
+	input_report_abs(dev, ABS_X, data[3] << 8 | data[2]);=0A=
+	input_report_abs(dev, ABS_Y, data[5] << 8 | data[4]);=0A=
+	input_report_abs(dev, ABS_PRESSURE, (data[6]|data[7] << 8));=0A=
+	input_report_key(dev, BTN_STYLUS, data[1] & 0x02);=0A=
+	input_report_key(dev, BTN_STYLUS2, data[1] & 0x10);=0A=
+=0A=
 	input_sync(dev);=0A=
 =0A=
 exit:=0A=
@@ -231,8 +317,12 @@ static void wacom_graphire_irq(struct ur=0A=
 		goto exit;=0A=
 	}=0A=
 =0A=
+	/* check if we can handle the data */=0A=
+	if (data[0] =3D=3D 99)=0A=
+		return;=0A=
+=0A=
 	if (data[0] !=3D 2)=0A=
-		dbg("received unknown report #%d", data[0]);=0A=
+		dbg("wacom_graphire_irq: received unknown report #%d", data[0]);=0A=
 =0A=
 	x =3D data[2] | ((__u32)data[3] << 8);=0A=
 	y =3D data[4] | ((__u32)data[5] << 8);=0A=
@@ -249,13 +339,16 @@ static void wacom_graphire_irq(struct ur=0A=
 			input_report_key(dev, BTN_TOOL_RUBBER, data[1] & 0x80);=0A=
 			break;=0A=
 =0A=
-		case 2: /* Mouse */=0A=
+		case 2: /* Mouse with wheel */=0A=
+			input_report_key(dev, BTN_MIDDLE, data[1] & 0x04);=0A=
+			input_report_rel(dev, REL_WHEEL, (signed char) data[6]);=0A=
+			/* fall through */=0A=
+=0A=
+                case 3: /* Mouse without wheel */=0A=
 			input_report_key(dev, BTN_TOOL_MOUSE, data[7] > 24);=0A=
 			input_report_key(dev, BTN_LEFT, data[1] & 0x01);=0A=
 			input_report_key(dev, BTN_RIGHT, data[1] & 0x02);=0A=
-			input_report_key(dev, BTN_MIDDLE, data[1] & 0x04);=0A=
 			input_report_abs(dev, ABS_DISTANCE, data[7]);=0A=
-			input_report_rel(dev, REL_WHEEL, (signed char) data[6]);=0A=
 =0A=
 			input_report_abs(dev, ABS_X, x);=0A=
 			input_report_abs(dev, ABS_Y, y);=0A=
@@ -308,7 +401,7 @@ static void wacom_intuos_irq(struct urb =0A=
 	}=0A=
 =0A=
 	if (data[0] !=3D 2)=0A=
-		dbg("received unknown report #%d", data[0]);=0A=
+		dbg("wacom_intuos_irq: received unknown report #%d", data[0]);=0A=
 =0A=
 	input_regs(dev, regs);=0A=
 =0A=
@@ -317,18 +410,18 @@ static void wacom_intuos_irq(struct urb =0A=
 =0A=
 	if ((data[1] & 0xfc) =3D=3D 0xc0) {						/* Enter report */=0A=
 =0A=
-		wacom->serial[idx] =3D ((__u32)(data[3] & 0x0f) << 4) +		/* serial =
number of the tool */=0A=
-			((__u32)data[4] << 16) + ((__u32)data[5] << 12) +=0A=
+		wacom->serial[idx] =3D ((__u32)(data[3] & 0x0f) << 28) +		/* serial =
number of the tool */=0A=
+			((__u32)data[4] << 20) + ((__u32)data[5] << 12) +=0A=
 			((__u32)data[6] << 4) + (data[7] >> 4);=0A=
 =0A=
 		switch (((__u32)data[2] << 4) | (data[3] >> 4)) {=0A=
-			case 0x832:=0A=
+			case 0x812:=0A=
 			case 0x012: wacom->tool[idx] =3D BTN_TOOL_PENCIL;		break;	/* Inking =
pen */=0A=
 			case 0x822:=0A=
 			case 0x842:=0A=
 			case 0x852:=0A=
 			case 0x022: wacom->tool[idx] =3D BTN_TOOL_PEN;		break;	/* Pen */=0A=
-			case 0x812:=0A=
+			case 0x832:=0A=
 			case 0x032: wacom->tool[idx] =3D BTN_TOOL_BRUSH;		break;	/* Stroke =
pen */=0A=
 			case 0x007:=0A=
 		        case 0x09c:=0A=
@@ -337,7 +430,10 @@ static void wacom_intuos_irq(struct urb =0A=
 			case 0x82a:=0A=
 			case 0x85a:=0A=
 		        case 0x91a:=0A=
+			case 0xd1a:=0A=
 			case 0x0fa: wacom->tool[idx] =3D BTN_TOOL_RUBBER;		break;	/* Eraser =
*/=0A=
+			case 0xd12:=0A=
+			case 0x912:=0A=
 			case 0x112: wacom->tool[idx] =3D BTN_TOOL_AIRBRUSH;	break;	/* =
Airbrush */=0A=
 			default:    wacom->tool[idx] =3D BTN_TOOL_PEN;		break;	/* Unknown =
tool */=0A=
 		}=0A=
@@ -350,13 +446,14 @@ static void wacom_intuos_irq(struct urb =0A=
 =0A=
 	if ((data[1] & 0xfe) =3D=3D 0x80) {						/* Exit report */=0A=
 		input_report_key(dev, wacom->tool[idx], 0);=0A=
+		input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);=0A=
 		input_sync(dev);=0A=
 		goto exit;=0A=
 	}=0A=
 =0A=
 	input_report_abs(dev, ABS_X, ((__u32)data[2] << 8) | data[3]);=0A=
 	input_report_abs(dev, ABS_Y, ((__u32)data[4] << 8) | data[5]);=0A=
-	input_report_abs(dev, ABS_DISTANCE, data[9] >> 4);=0A=
+	input_report_abs(dev, ABS_DISTANCE, data[9]);=0A=
 =0A=
 	if ((data[1] & 0xb8) =3D=3D 0xa0) {						/* general pen packet */=0A=
 		input_report_abs(dev, ABS_PRESSURE, t =3D ((__u32)data[6] << 2) | =
((data[7] >> 6) & 3));=0A=
@@ -378,8 +475,8 @@ static void wacom_intuos_irq(struct urb =0A=
 		if (data[1] & 0x02) {						/* Rotation packet */=0A=
 =0A=
 			input_report_abs(dev, ABS_RZ, (data[7] & 0x20) ?=0A=
-					 ((__u32)data[6] << 2) | ((data[7] >> 6) & 3):=0A=
-					 (-(((__u32)data[6] << 2) | ((data[7] >> 6) & 3))) - 1);=0A=
+					 ((__u32)data[6] << 3) | ((data[7] >> 5) & 7):=0A=
+					 (-(((__u32)data[6] << 3) | ((data[7] >> 5) & 7))) - 1);=0A=
 =0A=
 		} else {=0A=
 =0A=
@@ -391,17 +488,17 @@ static void wacom_intuos_irq(struct urb =0A=
 =0A=
 				input_report_key(dev, BTN_SIDE,   data[8] & 0x20);=0A=
 				input_report_key(dev, BTN_EXTRA,  data[8] & 0x10);=0A=
-				input_report_abs(dev, ABS_THROTTLE,  (data[8] & 0x08) ?=0A=
+				input_report_abs(dev, ABS_THROTTLE,  -((data[8] & 0x08) ?=0A=
 						 ((__u32)data[6] << 2) | ((data[7] >> 6) & 3) :=0A=
-						 -((__u32)data[6] << 2) | ((data[7] >> 6) & 3));=0A=
+						 -((__u32)data[6] << 2) | ((data[7] >> 6) & 3)));=0A=
 =0A=
 			} else {=0A=
 				if (wacom->tool[idx] =3D=3D BTN_TOOL_MOUSE) {	/* 2D mouse packets =
*/	=0A=
 					input_report_key(dev, BTN_LEFT,   data[8] & 0x04);=0A=
 					input_report_key(dev, BTN_MIDDLE, data[8] & 0x08);=0A=
 					input_report_key(dev, BTN_RIGHT,  data[8] & 0x10);=0A=
-					input_report_abs(dev, REL_WHEEL, =0A=
-					    ((__u32)(data[8] & 0x01) - (__u32)((data[8] & 0x02) >> =
1)));=0A=
+					input_report_rel(dev, REL_WHEEL, =0A=
+					    (-(__u32)(data[8] & 0x01) + (__u32)((data[8] & 0x02) >> =
1)));=0A=
 				}=0A=
 				else {     /* Lens cursor packets */=0A=
 					input_report_key(dev, BTN_LEFT,   data[8] & 0x01);=0A=
@@ -414,6 +511,8 @@ static void wacom_intuos_irq(struct urb =0A=
 		}=0A=
 	}=0A=
 	=0A=
+	input_report_key(dev, wacom->tool[idx], 1);=0A=
+	input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);=0A=
 	input_sync(dev);=0A=
 =0A=
 exit:=0A=
@@ -429,22 +528,26 @@ struct wacom_features wacom_features[] =3D=0A=
 	{ "Wacom Graphire2 4x5", 8,  10206,  7422,  511, 32, 1, =
wacom_graphire_irq },=0A=
  	{ "Wacom Graphire2 5x7", 8,  13918, 10206,  511, 32, 1, =
wacom_graphire_irq },=0A=
 	{ "Wacom Graphire3",     8,  10208,  7424,  511, 32, 1, =
wacom_graphire_irq },=0A=
-  	{ "Wacom Intuos 4x5",   10,  12700, 10360, 1023, 15, 2, =
wacom_intuos_irq },=0A=
- 	{ "Wacom Intuos 6x8",   10,  20600, 16450, 1023, 15, 2, =
wacom_intuos_irq },=0A=
- 	{ "Wacom Intuos 9x12",  10,  30670, 24130, 1023, 15, 2, =
wacom_intuos_irq },=0A=
- 	{ "Wacom Intuos 12x12", 10,  30670, 31040, 1023, 15, 2, =
wacom_intuos_irq },=0A=
- 	{ "Wacom Intuos 12x18", 10,  45860, 31040, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+	{ "Wacom Graphire3 6x8", 8,  16704, 12064,  511, 32, 1, =
wacom_graphire_irq },=0A=
+  	{ "Wacom Intuos 4x5",   10,  12700, 10600, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+ 	{ "Wacom Intuos 6x8",   10,  20320, 16240, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+ 	{ "Wacom Intuos 9x12",  10,  30480, 24060, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+ 	{ "Wacom Intuos 12x12", 10,  30480, 31680, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+ 	{ "Wacom Intuos 12x18", 10,  45720, 31680, 1023, 15, 2, =
wacom_intuos_irq },=0A=
  	{ "Wacom PL400",         8,   5408,  4056,  255, 32, 3, wacom_pl_irq =
},=0A=
  	{ "Wacom PL500",         8,   6144,  4608,  255, 32, 3, wacom_pl_irq =
},=0A=
  	{ "Wacom PL600",         8,   6126,  4604,  255, 32, 3, wacom_pl_irq =
},=0A=
  	{ "Wacom PL600SX",       8,   6260,  5016,  255, 32, 3, wacom_pl_irq =
},=0A=
  	{ "Wacom PL550",         8,   6144,  4608,  511, 32, 3, wacom_pl_irq =
},=0A=
  	{ "Wacom PL800",         8,   7220,  5780,  511, 32, 3, wacom_pl_irq =
},=0A=
-	{ "Wacom Intuos2 4x5",   10, 12700, 10360, 1023, 15, 2, =
wacom_intuos_irq },=0A=
-	{ "Wacom Intuos2 6x8",   10, 20600, 16450, 1023, 15, 2, =
wacom_intuos_irq },=0A=
-	{ "Wacom Intuos2 9x12",  10, 30670, 24130, 1023, 15, 2, =
wacom_intuos_irq },=0A=
-	{ "Wacom Intuos2 12x12", 10, 30670, 31040, 1023, 15, 2, =
wacom_intuos_irq },=0A=
-	{ "Wacom Intuos2 12x18", 10, 45860, 31040, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+	{ "Wacom Intuos2 4x5",   10, 12700, 10600, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+	{ "Wacom Intuos2 6x8",   10, 20320, 16240, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+	{ "Wacom Intuos2 9x12",  10, 30480, 24060, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+	{ "Wacom Intuos2 12x12", 10, 30480, 31680, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+	{ "Wacom Intuos2 12x18", 10, 45720, 31680, 1023, 15, 2, =
wacom_intuos_irq },=0A=
+	{ "Wacom Volito",        8,   5104,  3712,  511, 32, 1, =
wacom_graphire_irq },=0A=
+	{ "Wacom Cintiq Partner",8,  20480, 15360,  511, 32, 3, wacom_ptu_irq =
},=0A=
+	{ "Wacom Intuos2 6x8",   10, 20320, 16240, 1023, 15, 2, =
wacom_intuos_irq },=0A=
  	{ }=0A=
 };=0A=
 =0A=
@@ -454,6 +557,7 @@ struct usb_device_id wacom_ids[] =3D {=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x11) },=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x12) },=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x13) },=0A=
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x14) },=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x20) },=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x21) },=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x22) },=0A=
@@ -470,6 +574,9 @@ struct usb_device_id wacom_ids[] =3D {=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x43) },=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x44) },=0A=
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x45) },=0A=
+        { USB_DEVICE(USB_VENDOR_ID_WACOM, 0x60) },=0A=
+        { USB_DEVICE(USB_VENDOR_ID_WACOM, 0x03) },=0A=
+        { USB_DEVICE(USB_VENDOR_ID_WACOM, 0x47) },=0A=
 	{ }=0A=
 };=0A=
 =0A=
@@ -538,8 +645,9 @@ static int wacom_probe(struct usb_interf=0A=
 			break;=0A=
 =0A=
 		case 2:=0A=
-			wacom->dev.evbit[0] |=3D BIT(EV_MSC);=0A=
+			wacom->dev.evbit[0] |=3D BIT(EV_MSC) | BIT(EV_REL);=0A=
 			wacom->dev.mscbit[0] |=3D BIT(MSC_SERIAL);=0A=
+			wacom->dev.relbit[0] |=3D BIT(REL_WHEEL);=0A=
 			wacom->dev.keybit[LONG(BTN_LEFT)] |=3D BIT(BTN_LEFT) | =
BIT(BTN_RIGHT) | BIT(BTN_MIDDLE) | BIT(BTN_SIDE) | BIT(BTN_EXTRA);=0A=
  			wacom->dev.keybit[LONG(BTN_DIGI)] |=3D BIT(BTN_TOOL_RUBBER) | =
BIT(BTN_TOOL_MOUSE)	| BIT(BTN_TOOL_BRUSH)=0A=
 							  | BIT(BTN_TOOL_PENCIL) | BIT(BTN_TOOL_AIRBRUSH) | =
BIT(BTN_TOOL_LENS) | BIT(BTN_STYLUS2);=0A=
=0A=
diff -purN hid-core.c@1.72 hid-core.c=0A=
--- hid-core.c@1.72	2004-02-10 11:59:31.000000000 -0800=0A=
+++ hid-core.c	2004-02-10 12:30:33.000000000 -0800=0A=
@@ -1313,6 +1313,8 @@ void hid_init_reports(struct hid_device =0A=
 #define USB_DEVICE_ID_WACOM_INTUOS	0x0020=0A=
 #define USB_DEVICE_ID_WACOM_PL		0x0030=0A=
 #define USB_DEVICE_ID_WACOM_INTUOS2	0x0040=0A=
+#define USB_DEVICE_ID_WACOM_VOLITO      0x0060=0A=
+#define USB_DEVICE_ID_WACOM_PTU         0x0003=0A=
 =0A=
 #define USB_VENDOR_ID_KBGEAR            0x084e=0A=
 #define USB_DEVICE_ID_KBGEAR_JAMSTUDIO  0x1001=0A=
@@ -1372,6 +1374,7 @@ struct hid_blacklist {=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 1, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 2, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 3, =
HID_QUIRK_IGNORE },=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE + 4, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS, HID_QUIRK_IGNORE =
},=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS + 1, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS + 2, =
HID_QUIRK_IGNORE },=0A=
@@ -1383,11 +1386,14 @@ struct hid_blacklist {=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 3, HID_QUIRK_IGNORE =
},=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 4, HID_QUIRK_IGNORE =
},=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 5, HID_QUIRK_IGNORE =
},=0A=
-	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2, HID_QUIRK_IGNORE =
},=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 1, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 2, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 3, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 4, =
HID_QUIRK_IGNORE },=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 5, =
HID_QUIRK_IGNORE },=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 7, =
HID_QUIRK_IGNORE },=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_VOLITO, HID_QUIRK_IGNORE =
},=0A=
+	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PTU, HID_QUIRK_IGNORE =
},=0A=
 	{ USB_VENDOR_ID_KBGEAR, USB_DEVICE_ID_KBGEAR_JAMSTUDIO, =
HID_QUIRK_IGNORE },=0A=
 	{ USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_6000, HID_QUIRK_IGNORE =
},=0A=
 	{ USB_VENDOR_ID_GRIFFIN, USB_DEVICE_ID_POWERMATE, HID_QUIRK_IGNORE =
},=0A=


------_=_NextPart_000_01C3F03A.2D56C8DC--
