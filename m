Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263157AbSJHNmi>; Tue, 8 Oct 2002 09:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263158AbSJHNmi>; Tue, 8 Oct 2002 09:42:38 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:46484 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263157AbSJHNl7>;
	Tue, 8 Oct 2002 09:41:59 -0400
Date: Tue, 8 Oct 2002 15:47:33 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - wacom.c cleanups and fixes [9/23]
Message-ID: <20021008154733.H18546@ucw.cz>
References: <20021008153813.A18515@ucw.cz> <20021008153926.A18546@ucw.cz> <20021008154029.B18546@ucw.cz> <20021008154132.C18546@ucw.cz> <20021008154246.D18546@ucw.cz> <20021008154415.E18546@ucw.cz> <20021008154549.F18546@ucw.cz> <20021008154631.G18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008154631.G18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:46:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.38, 2002-09-25 12:04:25+02:00, vojtech@suse.cz
  Cleanups and fixes for the Wacom USB driver.


 hid-core.c |    3 -
 wacom.c    |  146 ++++++++++++++++++++++++++++---------------------------------
 2 files changed, 70 insertions(+), 79 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c	Tue Oct  8 15:26:43 2002
+++ b/drivers/usb/input/hid-core.c	Tue Oct  8 15:26:43 2002
@@ -1291,7 +1291,7 @@
 #define USB_DEVICE_ID_WACOM_INTUOS2	0x0040
 
 #define USB_VENDOR_ID_AIPTEK		0x08ca
-#define USB_VENDOR_ID_AIPTEK_6000	0x0020
+#define USB_DEVICE_ID_AIPTEK_6000	0x0020
 
 #define USB_VENDOR_ID_GRIFFIN		0x077d
 #define USB_DEVICE_ID_POWERMATE		0x0410
@@ -1327,7 +1327,6 @@
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 3, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 4, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_PL + 5, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 1, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 2, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS2 + 3, HID_QUIRK_IGNORE },
diff -Nru a/drivers/usb/input/wacom.c b/drivers/usb/input/wacom.c
--- a/drivers/usb/input/wacom.c	Tue Oct  8 15:26:43 2002
+++ b/drivers/usb/input/wacom.c	Tue Oct  8 15:26:43 2002
@@ -85,12 +85,8 @@
 	int y_max;
 	int pressure_max;
 	int distance_max;
+	int type;
 	void (*irq)(struct urb *urb);
-	unsigned long evbit;
-	unsigned long absbit;
-	unsigned long relbit;
-	unsigned long btnbit;
-	unsigned long digibit;
 };
 
 struct wacom {
@@ -255,7 +251,7 @@
 		}
 
 		input_report_key(dev, wacom->tool[idx], 1);
-		input_report_abs(dev, ABS_SERIAL, wacom->serial[idx]);
+		input_event(dev, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
 		input_sync(dev);
 		return;
 	}
@@ -329,75 +325,51 @@
 	input_sync(dev);
 }
 
-#define WACOM_INTUOS_TOOLS	(BIT(BTN_TOOL_BRUSH) | BIT(BTN_TOOL_PENCIL) | BIT(BTN_TOOL_AIRBRUSH) | BIT(BTN_TOOL_LENS))
-#define WACOM_INTUOS_BUTTONS	(BIT(BTN_SIDE) | BIT(BTN_EXTRA))
-#define WACOM_INTUOS_ABS	(BIT(ABS_TILT_X) | BIT(ABS_TILT_Y) | BIT(ABS_RZ) | BIT(ABS_THROTTLE) | BIT(ABS_SERIAL))
-
 struct wacom_features wacom_features[] = {
-	{ "Wacom Penpartner",    7,   5040,  3780,  255, 32, wacom_penpartner_irq,
-		0, 0, 0, 0 },
-        { "Wacom Graphire",      8,  10206,  7422,  511, 32, wacom_graphire_irq,
-                BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },
-	{ "Wacom Graphire2 4x5", 8,  10206,  7422,  511, 32, wacom_graphire_irq,
- 		BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },
- 	{ "Wacom Graphire2 5x7", 8,  13918, 10206,  511, 32, wacom_graphire_irq,
- 		BIT(EV_REL), 0, BIT(REL_WHEEL), 0 },
-  	{ "Wacom Intuos 4x5",   10,  12700, 10360, 1023, 15, wacom_intuos_irq,
- 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
- 	{ "Wacom Intuos 6x8",   10,  20600, 16450, 1023, 15, wacom_intuos_irq,
- 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
- 	{ "Wacom Intuos 9x12",  10,  30670, 24130, 1023, 15, wacom_intuos_irq,
- 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
- 	{ "Wacom Intuos 12x12", 10,  30670, 31040, 1023, 15, wacom_intuos_irq,
- 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
- 	{ "Wacom Intuos 12x18", 10,  45860, 31040, 1023, 15, wacom_intuos_irq,
- 		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
- 	{ "Wacom PL400",         8,   5408,  4056,  255, 32, wacom_pl_irq,
- 		0,  0, 0, 0 },
- 	{ "Wacom PL500",         8,   6144,  4608,  255, 32, wacom_pl_irq,
- 		0,  0, 0, 0 },
- 	{ "Wacom PL600",         8,   6126,  4604,  255, 32, wacom_pl_irq,
- 		0,  0, 0, 0 },
- 	{ "Wacom PL600SX",       8,   6260,  5016,  255, 32, wacom_pl_irq,
- 		0,  0, 0, 0 },
- 	{ "Wacom PL550",         8,   6144,  4608,  511, 32, wacom_pl_irq,
- 		0,  0, 0, 0 },
- 	{ "Wacom PL800",         8,   7220,  5780,  511, 32, wacom_pl_irq,
- 		0,  0, 0, 0 },
-	{ "Wacom Intuos2 4x5",   10, 12700, 10360, 1023, 15, wacom_intuos_irq,
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
-	{ "Wacom Intuos2 6x8",   10, 20600, 16450, 1023, 15, wacom_intuos_irq,
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
-	{ "Wacom Intuos2 9x12",  10, 30670, 24130, 1023, 15, wacom_intuos_irq,
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
-	{ "Wacom Intuos2 12x12", 10, 30670, 31040, 1023, 15, wacom_intuos_irq,
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
-	{ "Wacom Intuos2 12x18", 10, 45860, 31040, 1023, 15, wacom_intuos_irq,
-		0, WACOM_INTUOS_ABS, 0, WACOM_INTUOS_BUTTONS, WACOM_INTUOS_TOOLS },
+	{ "Wacom Penpartner",    7,   5040,  3780,  255, 32, 0, wacom_penpartner_irq },
+        { "Wacom Graphire",      8,  10206,  7422,  511, 32, 1, wacom_graphire_irq },
+	{ "Wacom Graphire2 4x5", 8,  10206,  7422,  511, 32, 1, wacom_graphire_irq },
+ 	{ "Wacom Graphire2 5x7", 8,  13918, 10206,  511, 32, 1, wacom_graphire_irq },
+  	{ "Wacom Intuos 4x5",   10,  12700, 10360, 1023, 15, 2, wacom_intuos_irq },
+ 	{ "Wacom Intuos 6x8",   10,  20600, 16450, 1023, 15, 2, wacom_intuos_irq },
+ 	{ "Wacom Intuos 9x12",  10,  30670, 24130, 1023, 15, 2, wacom_intuos_irq },
+ 	{ "Wacom Intuos 12x12", 10,  30670, 31040, 1023, 15, 2, wacom_intuos_irq },
+ 	{ "Wacom Intuos 12x18", 10,  45860, 31040, 1023, 15, 2, wacom_intuos_irq },
+ 	{ "Wacom PL400",         8,   5408,  4056,  255, 32, 3, wacom_pl_irq },
+ 	{ "Wacom PL500",         8,   6144,  4608,  255, 32, 3, wacom_pl_irq },
+ 	{ "Wacom PL600",         8,   6126,  4604,  255, 32, 3, wacom_pl_irq },
+ 	{ "Wacom PL600SX",       8,   6260,  5016,  255, 32, 3, wacom_pl_irq },
+ 	{ "Wacom PL550",         8,   6144,  4608,  511, 32, 3, wacom_pl_irq },
+ 	{ "Wacom PL800",         8,   7220,  5780,  511, 32, 3, wacom_pl_irq },
+	{ "Wacom Intuos2 4x5",   10, 12700, 10360, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Intuos2 6x8",   10, 20600, 16450, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Intuos2 9x12",  10, 30670, 24130, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Intuos2 12x12", 10, 30670, 31040, 1023, 15, 2, wacom_intuos_irq },
+	{ "Wacom Intuos2 12x18", 10, 45860, 31040, 1023, 15, 2, wacom_intuos_irq },
  	{ }
 };
 
 struct usb_device_id wacom_ids[] = {
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x00), driver_info: 0 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x10), driver_info: 1 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x11), driver_info: 2 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x12), driver_info: 3 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x20), driver_info: 4 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x21), driver_info: 5 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x22), driver_info: 6 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x23), driver_info: 7 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x24), driver_info: 8 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x30), driver_info: 9 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x31), driver_info: 10 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x32), driver_info: 11 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x33), driver_info: 12 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x34), driver_info: 13 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x35), driver_info: 14 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x41), driver_info: 15 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x42), driver_info: 16 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x43), driver_info: 17 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x44), driver_info: 18 },
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x45), driver_info: 19 },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x00) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x10) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x11) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x12) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x20) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x21) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x22) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x23) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x24) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x30) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x31) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x32) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x33) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x34) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x35) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x41) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x42) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x43) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x44) },
+	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x45) },
 	{ }
 };
 
@@ -450,14 +422,34 @@
 		return -ENOMEM;
 	}
 
-	wacom->features = wacom_features + id->driver_info;
+	wacom->features = wacom_features + (id - wacom_ids);
+
+	wacom->dev.evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS);
+	wacom->dev.absbit[0] |= BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
+	wacom->dev.keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_PEN) | BIT(BTN_TOUCH) | BIT(BTN_STYLUS);
+
+	switch (wacom->features->type) {
+		case 1:
+			wacom->dev.evbit[0] |= BIT(EV_REL);
+			wacom->dev.relbit[0] |= BIT(REL_WHEEL);
+			wacom->dev.absbit[0] |= BIT(ABS_DISTANCE);
+			wacom->dev.keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE);
+ 			wacom->dev.keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_RUBBER) | BIT(BTN_TOOL_MOUSE) | BIT(BTN_STYLUS2);
+			break;
 
-	wacom->dev.evbit[0] |= BIT(EV_KEY) | BIT(EV_ABS) | wacom->features->evbit;
-	wacom->dev.absbit[0] |= BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE) | BIT(ABS_DISTANCE) | BIT(ABS_WHEEL) | wacom->features->absbit;
-	wacom->dev.relbit[0] |= wacom->features->relbit;
-	wacom->dev.keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE) | wacom->features->btnbit;
-	wacom->dev.keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_PEN) | BIT(BTN_TOOL_RUBBER) | BIT(BTN_TOOL_MOUSE) |
-		BIT(BTN_TOUCH) | BIT(BTN_STYLUS) | BIT(BTN_STYLUS2) | wacom->features->digibit;
+		case 2:
+			wacom->dev.evbit[0] |= BIT(EV_MSC);
+			wacom->dev.mscbit[0] |= BIT(MSC_SERIAL);
+			wacom->dev.keybit[LONG(BTN_LEFT)] |= BIT(BTN_LEFT) | BIT(BTN_RIGHT) | BIT(BTN_MIDDLE) | BIT(BTN_SIDE) | BIT(BTN_EXTRA);
+ 			wacom->dev.keybit[LONG(BTN_DIGI)] |= BIT(BTN_TOOL_RUBBER) | BIT(BTN_TOOL_MOUSE)	| BIT(BTN_TOOL_BRUSH)
+							  | BIT(BTN_TOOL_PENCIL) | BIT(BTN_TOOL_AIRBRUSH) | BIT(BTN_TOOL_LENS) | BIT(BTN_STYLUS2);
+			wacom->dev.absbit[0] |= BIT(ABS_DISTANCE) | BIT(ABS_WHEEL) | BIT(ABS_TILT_X) | BIT(ABS_TILT_Y) | BIT(ABS_RZ) | BIT(ABS_THROTTLE);
+			break;
+
+		case 3:
+ 			wacom->dev.keybit[LONG(BTN_DIGI)] |= BIT(BTN_STYLUS2);
+			break;
+	}
 
 	wacom->dev.absmax[ABS_X] = wacom->features->x_max;
 	wacom->dev.absmax[ABS_Y] = wacom->features->y_max;

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.38
## Wrapped with gzip_uu ##


begin 664 bkpatch18241
M'XL(`!/=HCT``[68VW+:2!"&K]%33"4W=IG#'"4@12J`%%L5;"@)<M@D10DQ
M!*TQ>"7AD`UY]QV=L`38(&HM&P8-W1_=/7]+`Z_!P.-NO?"P^-OG]E1Z#:X6
MGE\O>$N/E^U_Q;FQ6(CSRG1QQRNQ565T6W'F]TM?$N_W+-^>@@?N>O4"*I/-
MC/_KGM<+AG8YZ#0-26HT0'MJS7]PD_N@T9#\A?M@S<;>.\N?SA;SLN]:<^^.
M^U;97MRM-Z9K#"$6?PPI!#)YC61(E;6-Q@A9%/$QQ+0J4RD.[%T<]K9_#3,$
M(2%H+5.%*)(*4)DII"SBK0*(*[!6P0P@7(>TCMD%%"\@V&*""PQ*4&J!_S?R
MMF2#]HQ;\^6]!ZSY&$R<%??`9.$"?\K!)TM`P<!L@;'KB"*7I0]`Y(!J4N^Q
MGE(IYR%)T(+2VP.I1)_H59;>J/(SB*-LIY*B$"EKB!&BZU%UPO#$LFH03SA1
MV';I,J10.%E>M#P4XS539,9R!39UQKMA42HFUF,%(64R44;*N&99\C%A"5K)
M7KA\-S("L5P+9?R<UV%EGQC[CL*/B9TB\<!H39@L5T/14[@C=_R4W!$HX1>1
M^WMG!48SR[Z=.9X/?&LTXX&LHPIW0<G]&?X+F?:>+?8)LE<1KE&`)#T>7X_Y
MQ)GSH,&&JO91;VM#71TV]5Y?^S"4(80%N`KR$HZ$0.&P7P"QFO.M?JZ6.F+]
MMUHJ67P9*3(,%Q_G6'RY!DJ*\B++?RT6#]A/7_+"/%*7N^B:<%`7<?HGB$*O
M*F)E"\[<#V]:;R2U6@-,4C&K!E*)AD(A_)@A?^!S_VS,'XI`^SB\-MM%()Z&
MIF;HS4XQ"K[T5MQ3'6OVU1FOOI\+'B$8T&!0`(623A09"$T5?H-7T?6]Q^?W
MENO/N?NJ",2A!,\,4BA&HE2#`3-6!`07`8P_9'B_<1HZ[C_@3U$"\;'A7KK6
M_=1Q>40%H"I&)%9)%J,BKFIB8`A%7)1P?\1.";6P@Q/)K)A@GH0#^WALI20\
M4D-B3+!'\%)`?>XO%UX<71!;`,0*A`&0R.&`B7@6M<0)T`F=]H07T^15]9$F
MH@II,F6GT6HKA%\58QJ!LB)&T:OD-!K"$2Y-(R@4SHFT:D*CK"J?1NMU*(2)
MY&+5`49A,%)Q<4BKF6S4/-M+8KLD&5$:D.00>#1)WD?"<D2B.4GFYPTK(N&@
M5J)E4;[LV('L-O(_1*KN9J=@',8473^>(VT+`6<Z*&<#[<+2#92S?W9AZ?[)
MV3Z[L'3[Y.R>_;"D>W(VCTJJ*+@CZ*)QXCO#XX[D+'CY4;M1NT:P.?G4;'>O
MQ6U`[$O.XT`.VZ(\MBB'+3[>%N>(`>>(`>>)@>2PI<?;DARYD1RYD1RYD1RY
MD3RYL>-M:8[<:([<:([<:([<:)2;2AD)MGKA0*5"O(N;<,M?NF)KVHB[=C-Q
M`<Z<,2@ES3SVQ"[OV\9/[`[+_&'D^%_A=[!N@);>/Q.;Q0_:EW.P3LZ:+5,X
MI5VLD9?U$2;#SXE+</(E?=(S--,<&-H6Y9;_"BB=[LWE6:M_,U3U2_U\@PQF
M^MUN9]C3;A)8-#=H7Z4GS/Z7SL",TO)^.L$O.F=;92F]#;;+Y^"WV!S;EL<!
MJHM7!XI@:)T@X(R9RV=9.V$T_'2E[3'=6R-5-_O-F[:V8[U=BX[VOI^M13B3
M2MO0+Z\R$]>ZJG8",G@>_429C4&KI1G92HOIZ^[`U';+C:,,1BZW;M\$JF1`
M%JJ4Q3=/DA09'U%D\8UDIQ9WGIVU>_S:\H)U2Z>HJYES[7/?:+Y,80M;LRUC
M8%Z=!TD&!]AV$KW0UCL[K*9N1([;;W2T&_/)Q3M:K*E6CK2>FNCKG7ZV]<.9
M3/\;?V7>OS*Z_7Y'RRCH6R(:4L]?YGV2+/QY_,G7GG+[UEO>-9B%%:34:M)_
(`!3DF$T6````
`
end
