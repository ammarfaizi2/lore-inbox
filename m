Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311898AbSGYMW4>; Thu, 25 Jul 2002 08:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSGYMW4>; Thu, 25 Jul 2002 08:22:56 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:31683 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S312560AbSGYMWv>;
	Thu, 25 Jul 2002 08:22:51 -0400
Date: Thu, 25 Jul 2002 14:25:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: [cset] Move ps2serkbd.c functionality into atkbd.c, kill ps2serkbd.c
Message-ID: <20020725142559.C14561@ucw.cz>
References: <20020725083716.A20717@ucw.cz> <20020725140040.A14561@ucw.cz> <20020725140342.B14561@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020725140342.B14561@ucw.cz>; from vojtech@suse.cz on Thu, Jul 25, 2002 at 02:03:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 02:03:42PM +0200, Vojtech Pavlik wrote:

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull http://linux-input.bkbits.net:8080/linux-input' should also
work.

===================================================================

ChangeSet@1.446, 2002-07-25 14:23:58+02:00, vojtech@twilight.ucw.cz
  Add support for AT keyboards connected over a PS/2 to Serial
  converter to atkbd.c - trivial. Remove ps2serkbd, because it's
  not needed anymore.


 b/drivers/input/keyboard/Config.help |   12 -
 b/drivers/input/keyboard/Config.in   |    1 
 b/drivers/input/keyboard/Makefile    |    1 
 b/drivers/input/keyboard/atkbd.c     |   19 +-
 drivers/input/keyboard/ps2serkbd.c   |  299 -----------------------------------
 5 files changed, 14 insertions(+), 318 deletions(-)


diff -Nru a/drivers/input/keyboard/Config.help b/drivers/input/keyboard/Config.help
--- a/drivers/input/keyboard/Config.help	Thu Jul 25 14:24:31 2002
+++ b/drivers/input/keyboard/Config.help	Thu Jul 25 14:24:31 2002
@@ -7,7 +7,8 @@
 CONFIG_KEYBOARD_ATKBD
   Say Y here if you want to use the standard AT keyboard. Usually
   you'll need this, unless you have a different type keyboard (USB,
-  ADB or other).
+  ADB or other). This also works for AT keyboards connected over
+  a PS/2 to serial converter.
 
   If unsure, say Y.
 
@@ -24,15 +25,6 @@
   This driver is also available as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want).
   The module will be called sunkbd.o. If you want to compile it as a
-  module, say M here and read <file:Documentation/modules.txt>.
-
-CONFIG_KEYBOARD_PS2SERKBD
-  Say Y here if you want to use a PS/2 to Serial converter with a
-  keyboard attached to it.
-
-  This driver is also available as a module ( = code which can be
-  inserted in and removed from the running kernel whenever you want).
-  The module will be called ps2serkbd.o. If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
 CONFIG_KEYBOARD_XTKBD
diff -Nru a/drivers/input/keyboard/Config.in b/drivers/input/keyboard/Config.in
--- a/drivers/input/keyboard/Config.in	Thu Jul 25 14:24:31 2002
+++ b/drivers/input/keyboard/Config.in	Thu Jul 25 14:24:31 2002
@@ -6,7 +6,6 @@
 
 dep_tristate '  AT keyboard support' CONFIG_KEYBOARD_ATKBD $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD $CONFIG_SERIO
 dep_tristate '  Sun Type 4 and Type 5 keyboard support' CONFIG_KEYBOARD_SUNKBD $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD $CONFIG_SERIO
-dep_tristate '  PS/2 to Serial converter support' CONFIG_KEYBOARD_PS2SERKBD $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD $CONFIG_SERIO
 dep_tristate '  XT Keyboard support' CONFIG_KEYBOARD_XTKBD $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD $CONFIG_SERIO
 dep_tristate '  Newton keyboard' CONFIG_KEYBOARD_NEWTON $CONFIG_INPUT $CONFIG_INPUT_KEYBOARD $CONFIG_SERIO
 
diff -Nru a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
--- a/drivers/input/keyboard/Makefile	Thu Jul 25 14:24:31 2002
+++ b/drivers/input/keyboard/Makefile	Thu Jul 25 14:24:31 2002
@@ -6,7 +6,6 @@
 
 obj-$(CONFIG_KEYBOARD_ATKBD)		+= atkbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
-obj-$(CONFIG_KEYBOARD_PS2SERKBD)	+= ps2serkbd.o
 obj-$(CONFIG_KEYBOARD_SUNKBD)		+= sunkbd.o
 obj-$(CONFIG_KEYBOARD_XTKBD)		+= xtkbd.o
 obj-$(CONFIG_KEYBOARD_AMIGA)		+= amikbd.o
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Jul 25 14:24:31 2002
+++ b/drivers/input/keyboard/atkbd.c	Thu Jul 25 14:24:31 2002
@@ -129,6 +129,7 @@
 	signed char ack;
 	unsigned char emul;
 	unsigned short id;
+	unsigned char write;
 };
 
 /*
@@ -146,7 +147,7 @@
 #endif
 
 	/* Interface error.  Request that the keyboard resend. */
-	if (flags & (SERIO_FRAME | SERIO_PARITY)) {
+	if ((flags & (SERIO_FRAME | SERIO_PARITY)) && atkbd->write) {
 		printk("atkbd.c: frame/parity error: %02x\n", flags);
 		serio_write(serio, ATKBD_CMD_RESEND);
 		return;
@@ -265,7 +266,7 @@
 	struct atkbd *atkbd = dev->private;
 	char param[2];
 
-	if (!atkbd->serio->write)
+	if (!atkbd->write)
 		return -1;
 
 	switch (type) {
@@ -449,15 +450,19 @@
 	struct atkbd *atkbd;
 	int i;
 
-	if ((serio->type & SERIO_TYPE) != SERIO_8042)
-		return;
+	if ((serio->type & SERIO_TYPE) != SERIO_8042 &&
+		(((serio->type & SERIO_TYPE) != SERIO_RS232) || (serio->type & SERIO_PROTO) != SERIO_PS2SER))
+		        return;
 
 	if (!(atkbd = kmalloc(sizeof(struct atkbd), GFP_KERNEL)))
 		return;
 
 	memset(atkbd, 0, sizeof(struct atkbd));
 
-	if (serio->write) {
+	if ((serio->type & SERIO_TYPE) == SERIO_8042 && serio->write)
+		atkbd->write = 1;
+
+	if (atkbd->write) {
 		atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
 		atkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
 	} else  atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
@@ -475,7 +480,7 @@
 		return;
 	}
 
-	if (serio->write) {
+	if (atkbd->write) {
 
 		if (atkbd_probe(atkbd)) {
 			serio_close(serio);
@@ -518,7 +523,7 @@
 
 	printk(KERN_INFO "input: %s on %s\n", atkbd->name, serio->phys);
 
-	if (serio->write)
+	if (atkbd->write)
 		atkbd_initialize(atkbd);
 }
 
diff -Nru a/drivers/input/keyboard/ps2serkbd.c b/drivers/input/keyboard/ps2serkbd.c
--- a/drivers/input/keyboard/ps2serkbd.c	Thu Jul 25 14:24:31 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,299 +0,0 @@
-/*
- * based on: sunkbd.c and ps2serkbd.c
- *
- * $Id: ps2serkbd.c,v 1.5 2001/09/25 10:12:07 vojtech Exp $
- */
-
-/*
- * PS/2 keyboard via adapter at serial port driver for Linux
- */
-
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or 
- * (at your option) any later version.
- * 
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- * 
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/input.h>
-#include <linux/serio.h>
-#include <linux/tqueue.h>
-
-#define ATKBD_CMD_SETLEDS	0x10ed
-#define ATKBD_CMD_GSCANSET	0x11f0
-#define ATKBD_CMD_SSCANSET	0x10f0
-#define ATKBD_CMD_GETID		0x02f2
-#define ATKBD_CMD_ENABLE	0x00f4
-#define ATKBD_CMD_RESET_DIS	0x00f5
-#define ATKBD_CMD_SETALL_MB	0x00f8
-#define ATKBD_CMD_EX_ENABLE	0x10ea
-#define ATKBD_CMD_EX_SETLEDS	0x20eb
-
-#define ATKBD_RET_ACK		0xfa
-#define ATKBD_RET_NAK		0xfe
-
-#define ATKBD_KEY_UNKNOWN	  0
-#define ATKBD_KEY_BAT		251
-#define ATKBD_KEY_EMUL0		252
-#define ATKBD_KEY_EMUL1		253
-#define ATKBD_KEY_RELEASE	254
-#define ATKBD_KEY_NULL		255
-
-static unsigned char ps2serkbd_set2_keycode[512] = {
-    0, 67, 65, 63, 61, 59, 60, 88, 0, 68, 66, 64, 62, 15, 41, 85,
-    0, 56, 42, 0, 29, 16, 2, 89, 0, 0, 44, 31, 30, 17, 3, 90,
-    0, 46, 45, 32, 18, 5, 4, 91, 0, 57, 47, 33, 20, 19, 6, 0,
-    0, 49, 48, 35, 34, 21, 7, 0, 0, 0, 50, 36, 22, 8, 9, 0,
-    0, 51, 37, 23, 24, 11, 10, 0, 0, 52, 53, 38, 39, 25, 12, 0,
-    122, 89, 40,120, 26, 13, 0, 0, 58, 54, 28, 27, 0, 43, 0, 0,
-    85, 86, 90, 91, 92, 93, 14, 94, 95, 79, 0, 75, 71,121, 0,123,
-    82, 83, 80, 76, 77, 72, 1, 69, 87, 78, 81, 74, 55, 73, 70, 99,
-    252, 0, 0, 65, 99, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0,251, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    252,253, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-    254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,255,
-    0, 0, 92, 90, 85, 0,137, 0, 0, 0, 0, 91, 89,144,115, 0,
-    136,100,255, 0, 97,149,164, 0,156, 0, 0,140,115, 0, 0,125,
-    0,150, 0,154,152,163,151,126,112,166, 0,140, 0,147, 0,127,
-    159,167,139,160,163, 0, 0,116,158, 0,150,165, 0, 0, 0,142,
-    157, 0,114,166,168, 0, 0, 0,155, 0, 98,113, 0,148, 0,138,
-    0, 0, 0, 0, 0, 0,153,140, 0, 0, 96, 0, 0, 0,143, 0,
-    133, 0,116, 0,143, 0,174,133, 0,107, 0,105,102, 0, 0,112,
-    110,111,108,112,106,103, 0,119, 0,118,109, 0, 99,104,119
-};
-
-/*
- * Per-keyboard data.
- */
-
-struct ps2serkbd {
-    unsigned char keycode[512];
-    struct input_dev dev;
-    struct serio *serio;
-    char name[64];
-    char phys[32];
-    struct tq_struct tq;
-    unsigned char cmdbuf[4];
-    unsigned char cmdcnt;
-    unsigned char set;
-    char release;
-    char ack;
-    char emul;
-    char error;
-    unsigned short id;
-};
-
-/*
- * ps2serkbd_interrupt() is called by the low level driver when a character
- * is received.
- */
-
-static void ps2serkbd_interrupt(struct serio *serio, unsigned char data, unsigned int flags)
-{
-    static int event_count=0;
-    struct ps2serkbd* ps2serkbd = serio->private;
-    int code=data;
-
-#if 0
-    printk(KERN_WARNING "ps2serkbd.c(%8d): (scancode %#x)\n", event_count, data);
-#endif
-    event_count++;
-
-    switch (code) {
-    case ATKBD_RET_ACK:
-        ps2serkbd->ack = 1;
-        return;
-    case ATKBD_RET_NAK:
-        ps2serkbd->ack = -1;
-        return;
-    }
-
-    if (ps2serkbd->cmdcnt) {
-        ps2serkbd->cmdbuf[--ps2serkbd->cmdcnt] = code;
-        return;
-    }
-
-    switch (ps2serkbd->keycode[code]) {
-    case ATKBD_KEY_BAT:
-        queue_task(&ps2serkbd->tq, &tq_immediate);
-        mark_bh(IMMEDIATE_BH);
-        return;
-    case ATKBD_KEY_EMUL0:
-        ps2serkbd->emul = 1;
-        return;
-    case ATKBD_KEY_EMUL1:
-        ps2serkbd->emul = 2;
-        return;
-    case ATKBD_KEY_RELEASE:
-        ps2serkbd->release = 1;
-        return;
-    }
-
-    if (ps2serkbd->emul) {
-        if (--ps2serkbd->emul) return;
-        code |= 0x100;
-    }
-
-    switch (ps2serkbd->keycode[code]) {
-    case ATKBD_KEY_NULL:
-        break;
-    case ATKBD_KEY_UNKNOWN:
-        printk(KERN_WARNING "ps2serkbd.c: Unknown key (set %d, scancode %#x) %s.\n",
-        ps2serkbd->set, code, ps2serkbd->release ? "released" : "pressed");
-        break;
-    default:
-        input_report_key(&ps2serkbd->dev, ps2serkbd->keycode[code], !ps2serkbd->release);
-	input_sync(&ps2serkbd->dev);
-    }
-
-    ps2serkbd->release = 0;
-}
-
-/*
- * ps2serkbd_event() handles events from the input module.
- */
-
-static int ps2serkbd_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
-{
-    switch (type) {
-
-    case EV_LED:
-
-        return 0;
-    }
-
-    return -1;
-}
-
-static int ps2serkbd_initialize(struct ps2serkbd *ps2serkbd) 
-{
-    return 0;
-}
-
-static void ps2serkbd_reinit(void *data) 
-{
-}
-
-
-static void ps2serkbd_connect(struct serio *serio, struct serio_dev *dev)
-{
-    struct ps2serkbd *ps2serkbd;
-    int i;
-
-    if ((serio->type & SERIO_TYPE) != SERIO_RS232)
-        return;
-
-    if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) != SERIO_PS2SER)
-        return;
-
-
-    if (!(ps2serkbd = kmalloc(sizeof(struct ps2serkbd), GFP_KERNEL)))
-        return;
-
-    memset(ps2serkbd, 0, sizeof(struct ps2serkbd));
-
-    ps2serkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
-    ps2serkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
-
-    ps2serkbd->serio = serio;
-
-    ps2serkbd->dev.keycode = ps2serkbd->keycode;
-    ps2serkbd->dev.event = ps2serkbd_event;
-    ps2serkbd->dev.private = ps2serkbd;
-
-    ps2serkbd->tq.routine = ps2serkbd_reinit;
-    ps2serkbd->tq.data = ps2serkbd;
-
-    serio->private = ps2serkbd;
-
-    if (serio_open(serio, dev)) {
-        kfree(ps2serkbd);
-        return;
-    }
-
-    if (ps2serkbd_initialize(ps2serkbd) < 0) {
-        serio_close(serio);
-        kfree(ps2serkbd);
-        return;
-    }
-
-    ps2serkbd->set = 4;
-
-    if (ps2serkbd->set == 4) {
-        ps2serkbd->dev.ledbit[0] |= 0;
-        sprintf(ps2serkbd->name, "AT Set 2 Extended keyboard\n");
-    }
-    memcpy(ps2serkbd->keycode, ps2serkbd_set2_keycode, sizeof(ps2serkbd->keycode));
-
-    sprintf(ps2serkbd->phys, "%s/input0", serio->phys);
-
-    ps2serkbd->dev.name = ps2serkbd->name;
-    ps2serkbd->dev.phys = ps2serkbd->phys;
-    ps2serkbd->dev.id.bustype = BUS_RS232; 
-    ps2serkbd->dev.id.vendor = SERIO_PS2SER;
-    ps2serkbd->dev.id.product = ps2serkbd->set;
-    ps2serkbd->dev.id.version = ps2serkbd->id;
-
-    for (i = 0; i < 512; i++)
-        if (ps2serkbd->keycode[i] && ps2serkbd->keycode[i] <= 250)
-            set_bit(ps2serkbd->keycode[i], ps2serkbd->dev.keybit);
-
-    input_register_device(&ps2serkbd->dev);
-}
-
-/*
- * ps2serkbd_disconnect() unregisters and closes behind us.
- */
-
-static void ps2serkbd_disconnect(struct serio *serio)
-{
-    struct ps2serkbd *ps2serkbd = serio->private;
-    input_unregister_device(&ps2serkbd->dev);
-    serio_close(serio);
-    kfree(ps2serkbd);
-}
-
-static struct serio_dev ps2serkbd_dev = {
-interrupt:
-    ps2serkbd_interrupt,
-connect:
-    ps2serkbd_connect,
-disconnect:
-    ps2serkbd_disconnect
-};
-
-/*
- * The functions for insering/removing us as a module.
- */
-
-int __init ps2serkbd_init(void)
-{
-    serio_register_device(&ps2serkbd_dev);
-    return 0;
-}
-
-void __exit ps2serkbd_exit(void)
-{
-    serio_unregister_device(&ps2serkbd_dev);
-}
-
-module_init(ps2serkbd_init);
-module_exit(ps2serkbd_exit);

===================================================================


This BitKeeper patch contains the following changesets:
+
## Wrapped with gzip_uu ##


begin 664 bkpatch20801
M'XL(`/_M/ST``\U8;6_B1A#^C'_%G$Y*@ZZ8?;?-B>BXD+;H>@J"W(>3*E6+
MO007L)%M$J6U^ML[M@GA2-+PTIQ*HJRQAV=F9YY]9LA;^)*:I%6[B?_(C#^Q
MWL(O<9JU:MEM.`NO)YF]]&]M_T^\/XACO-^<Q'/37%DW1]-F&"V6F87/^SKS
M)W!CDK15HS9?W\GN%J95&US\_.77SL"RVFTXG^CHV@Q-!NVVE<7)C9X%Z0>=
M369Q9&>)CM*YR;3MQ_-\;9HS0AC^2.IP(E5.%1%.[M.`4BVH"0@3KA+6*K`/
M6^%OXSA,T@*-Y;@*S^H"M8500%B3.$TF@8H6XRWIOB.L10@\`POO)#2(]1'^
MVTV<6SYT@@#2Y6(1)QF,XP0Z5S`U=Z-8)T$*?AQ%QL],`#'F&S3TATV&0<#0
M)*&>X<?1`I]D^!#OZFPZ"FP?&I`EX0T:V#`P<_PH+%*&U<>G/\+(^'J9&@BS
M'U($B.(,(F,"]*&CNWF<&-OZ!))QAUG]API:C3U?ED4TL<Z>RV@>8(1(H8I6
MS?LM-U=;6%6/<,J)*TA./9?2?#0*/,.("2A7GL./PRZ8P;B4B"V5MW^DYW$T
M#J_M,-J.52K'D[FG#>$&$SNF2HT]YUCX=;B*>](Y.-R)F2VV`Q8.7N74=3!2
MYHT-,2(0\G@'ZY"%\@C?/^3/>FK&X<QLQTN(0T7N&5?[RC7:%=)%0AR)O@Z6
M%V=V_V#7)VR;O#0G@A*5&S8RRA6^UAYC@@?/.O@89I^,69BD&9B9P</?M/&B
ML>'@[VVLC3U0=)H+IB0M)?CE8A7:_-I<.MX!Y:CC`G6<N)P[I8[S1RHN7U)Q
M!@WZ.C*^K;.HH17K+Z&1W):_J(G]'>IQ@-)V*0%J]?`OLP`ZW8^`C23.)B:I
MVW`U"5/0LS2&VSB9IB\U&01X:#-IV68>FHQM=9D#W@[,"J/#>;6KI!X+O\$I
MX?)#.4604]^+4I7V[T6I,#J$4![\JWS<:^<!-=Y/U(]$7U>82_1237__XPH7
MDU?5?G8K\?UN7Z'"]Z/D_@7>9X([#AO;'96*B9QPI51974KW+R_%KN!\_]F^
MG.B_G><?A#8MJ%`-IKM18969`YC0PT."7*@MHS2\CK`+^!.=P&T29N8]=A;A
ME:VE7&KA&$Y/QS-]G<()G`XO!KW+WW\:=#Y?0`[5NWYGT+OZ6J_#R4GU=:1Q
M5D+5X2_L'<HMP*JE!'OSC8W5%9)A#^L)R8&OW!4]*&Z<%=\NT6GEY>IK_Z(.
M;]JKMRX1#!U:M=KI3O:#(>.L#GD.3UKW!Y=7EQOF_2'#BWH=\6'U2DRV3"+,
MCU!EZRT6\6+`[:V`866ZVGVMMID-:`-];_U6@3Y*I7#*5%;+TR:2%77M5<MC
MD_+T'S!K'B`)>\_&QSM8:X-"^9=/*#^E+4YV4/[7&1>[9;9;SYWFC?T4@V0Y
DS6_IP`&5.T`<UO_<\2?&GZ;+>5N;0+ET+*U_``B&%^]1$@``
`
end

-- 
Vojtech Pavlik
SuSE Labs
