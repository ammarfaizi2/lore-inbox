Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319563AbSIMJAi>; Fri, 13 Sep 2002 05:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319564AbSIMJAi>; Fri, 13 Sep 2002 05:00:38 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:60048 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S319563AbSIMJAg>;
	Fri, 13 Sep 2002 05:00:36 -0400
Date: Fri, 13 Sep 2002 11:04:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: vojtech@suse.cz
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Minor input fixes [1/7]
Message-ID: <20020913110453.A28145@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.568.2.2, 2002-08-31 16:15:03+02:00, vojtech@suse.cz
  This fixes problems in serport.c found by Russell King:
      	1) Problem with current->state in serport_ldisc_read.
      	   Solved by using wait_event_interruptible()
      	2) Problem when serport_ldisc_read() is entered twice.
      	   Solved using set_bit et al.
      	3) Complex naming of the serio ports.
      	   Using tty_name() instead.
      	4) Possible stack overflows in name generations.
      	   Using tty_name() instead. 


 char/tty_io.c         |    2 +
 input/serio/serport.c |   77 ++++++++++++++------------------------------------
 2 files changed, 25 insertions(+), 54 deletions(-)

===================================================================

diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Thu Sep 12 23:37:14 2002
+++ b/drivers/char/tty_io.c	Thu Sep 12 23:37:14 2002
@@ -204,6 +204,8 @@
 	return _tty_make_name(tty, (tty)?tty->driver.name:NULL, buf);
 }
 
+EXPORT_SYMBOL(tty_name);
+
 inline int tty_paranoia_check(struct tty_struct *tty, kdev_t device,
 			      const char *routine)
 {
diff -Nru a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
--- a/drivers/input/serio/serport.c	Thu Sep 12 23:37:14 2002
+++ b/drivers/input/serio/serport.c	Thu Sep 12 23:37:14 2002
@@ -1,32 +1,16 @@
 /*
- * $Id: serport_old.c,v 1.10 2002/01/24 19:52:57 vojtech Exp $
+ * Input device TTY line discipline
+ *
+ * Copyright (c) 1999-2002 Vojtech Pavlik
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
- */
-
-/*
  * This is a module that converts a tty line into a much simpler
  * 'serial io port' abstraction that the input device drivers use.
  */
 
 /*
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
- * 
- *  Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #include <asm/uaccess.h>
@@ -41,10 +25,13 @@
 MODULE_DESCRIPTION("Input device TTY line discipline");
 MODULE_LICENSE("GPL");
 
+#define SERPORT_BUSY	1
+
 struct serport {
 	struct tty_struct *tty;
 	wait_queue_head_t wait;
 	struct serio serio;
+	unsigned long flags;
 	char phys[32];
 };
 
@@ -68,20 +55,20 @@
 static void serport_serio_close(struct serio *serio)
 {
 	struct serport *serport = serio->driver;
+
+	serport->serio.type = 0;
 	wake_up_interruptible(&serport->wait);
 }
 
 /*
  * serport_ldisc_open() is the routine that is called upon setting our line
- * discipline on a tty. It looks for the Mag, and if found, registers
- * it as a joystick device.
+ * discipline on a tty. It prepares the serio struct.
  */
 
 static int serport_ldisc_open(struct tty_struct *tty)
 {
 	struct serport *serport;
-	char ttyname[64];
-	int i;
+	char name[64];
 
 	MOD_INC_USE_COUNT;
 
@@ -96,11 +83,7 @@
 	serport->tty = tty;
 	tty->disc_data = serport;
 
-	strcpy(ttyname, tty->driver.name);
-	for (i = 0; ttyname[i] != 0 && ttyname[i] != '/'; i++);
-	ttyname[i] = 0;
-
-	sprintf(serport->phys, "%s%d/serio0", ttyname, minor(tty->device) - tty->driver.minor_start);
+	snprintf(serport->phys, sizeof(serport->phys), "%s/serio0", tty_name(tty, name));
 
 	serport->serio.name = serport_name;
 	serport->serio.phys = serport->phys;
@@ -161,29 +144,18 @@
 static ssize_t serport_ldisc_read(struct tty_struct * tty, struct file * file, unsigned char * buf, size_t nr)
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
-	DECLARE_WAITQUEUE(wait, current);
-	char name[32];
+	char name[64];
 
-#ifdef CONFIG_DEVFS_FS
-	sprintf(name, tty->driver.name, minor(tty->device) - tty->driver.minor_start);
-#else
-	sprintf(name, "%s%d", tty->driver.name, minor(tty->device) - tty->driver.minor_start);
-#endif
+	if (test_and_set_bit(SERPORT_BUSY, &serport->flags))
+		return -EBUSY;
 
 	serio_register_port(&serport->serio);
-
-	printk(KERN_INFO "serio: Serial port %s\n", name);
-
-	add_wait_queue(&serport->wait, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-
-	while(serport->serio.type && !signal_pending(current)) schedule();
-
-	set_current_state(TASK_RUNNING);
-	remove_wait_queue(&serport->wait, &wait);
-
+	printk(KERN_INFO "serio: Serial port %s\n", tty_name(tty, name));
+	wait_event_interruptible(serport->wait, !serport->serio.type);
 	serio_unregister_port(&serport->serio);
 
+	clear_bit(SERPORT_BUSY, &serport->flags);
+
 	return 0;
 }
 
@@ -195,10 +167,8 @@
 {
 	struct serport *serport = (struct serport*) tty->disc_data;
 	
-	switch (cmd) {
-		case SPIOCSTYPE:
-			return get_user(serport->serio.type, (unsigned long *) arg);
-	}
+	if (cmd == SPIOCSTYPE)
+		return get_user(serport->serio.type, (unsigned long *) arg);
 
 	return -EINVAL;
 }
@@ -208,7 +178,6 @@
 	struct serport *sp = (struct serport *) tty->disc_data;
 
 	serio_dev_write_wakeup(&sp->serio);
-
 }
 
 /*

===================================================================

This BitKeeper patch contains the following changesets:
1.568.2.2
## Wrapped with gzip_uu ##


begin 664 bkpatch25155
M'XL(``H)@3T``\U7;8_:1A#^[/T5TT2I(`'C]2MPNBK-05*4-(?@KNJIJ9`Q
M:^Q@O&AW#2'BQW?6<!QWO7>E4GG187MGYIF99Y[=>PGGDHFVL>1?%8L2\A)^
MXU*U#5E(9D;?\7K`.5XW$CYGC=VJQGC62/-%H0@^[X<J2F#)A&P;U'3V=]1Z
MP=K&H/OA_-.O`T*.C^$D"?,I&S(%Q\=$<;$,LXE\&ZHDX[FI1)C+.5.A&?'Y
M9K]T8UN6C6^/!H[E^1OJ6VZPB>B$TM"E;&+9;M-WR52PZ=N9X&%RFWG3H9;G
M.%:P\5SJ6*0#U/3\IFF;-EAVPVHV'`K4;U.O;3EO++MM6;!+]>VN$/#&AKI%
MWL&/Q7U"(CA+4@EQ^HU)6`@^SMA<0IH#MF7!A3(CB'F13V"\AD$A)<LR^)CF
MTS9:ZI=!J]#?FL$J50E$A1`L5_5?I`H5._`TRB:IC$:"A1/STAB_0YXM6>F^
MD.@75F&J1FR)+D9IKI@0Q4*EZ+Y2O32R#R(F[#;_E2I@3DR;HVNU2B-V2\AM
M/,G4:)PJ0%J$V7Z54X43/E]D[!ODX5ROXS&HA.E@*0<=3QZZ/"]]*;4>X7*F
MX^=2'6;J(F@NI<X$L#+1##AR-L[XJJRVMH(IRYD(5<KSQ_D&\A$\QW5;I']%
M;E)_XHL0*[3(+P\P:R)2/6.-*`E%0V-)N1D=L,RU+'?C-9N^OV&,(M_'42N.
MXK`UCF]R^3Y?."K4I9YE;6S;HZVGP?K*UU*ET:RQY^YU@-X&Q]"U-S1R)KX?
M1DUO'$\<YM\)L!291MGRFSZO@/H.#8)28.XU>UAT?D@NY#(79'V63A-E%M'J
MD3D%MFL[;D#IQO9;0:O4J=:_%,JZ4Z$<J'ON_TRCGJU/3]:FY^O2PYKT:#UZ
M2(N>HT,/:M!V`DZA+E;E!S6E?_\P/$.D.C90TK/!(?`:>MHI3-@2*PAG9Q>0
MI3D#7>=TH7_B&KWLA"_60@\!5*(JT%:K5=><@S^VU,63PC)+9Z3C@DLZU`$:
M8(36-D1).23;5(1SW;58,*P8C]4J%.P(UKR`*,P!&YE*)=)QH<F$_<HG#2Y@
MSB=IO,8;VA52DXFR6]AX9.ZN=1\^G\.'LM09](MQED;P"?/))2N/,UA^L"%$
M$/J93$HB:G?:]KU&,]RA@?>:_67#3-)S';#)RPF+=4F&W4'_='`V>G<^O#`H
M^8*/`ZRC4>0RG>;H$N=S"G$63N41Z046FGXAQJY/.".Z;:8^2L$Q6$>D$_BX
MHA=H'XCDJN"`8$/-#Q-Z"LO&%HA+'C`4:U1$RB2=IH;7:[H:A5:ZDG)_^>[?
MZ+W5`H_TJ.7HAS)?")RRN+)'LTC6L@8R_<[XC;O5&KQX);<LLU[4KHB*/VIE
MA&H5_5/?U<&I[]T6G?I!&3Z@N,A(8Z@H)M4(.SK:#63EL)PU^'F/H2Q@M4H,
M0S!5B!SJ7;U$.PTP4R0N;>K01IG2K/*Q._@\ZGU^?PHO2LQM&.(?Y(%V!Z_D
ME_S.)(P[16B/1J^HP4^W=!'M$8GNH1%E+!2/2.H("=&AK2:.2,^V]J6)YA/<
MT6#8[YV>#,\N^MV#Y*=8+=P41.46!#6H7.?>ZRJ$8JJ[8U/<8ZYMI-<."$_<
M0)]V1KEY@K_'%6Y6-G4\U\=+UPW*7=()GK!-_E<'^>ZWDCV7M,%)X3B`H=)B
M5&0XC5JO$`6JDHFJO3U@W:':U_)^AEHC533+NG^6S!I>_/[N]%/E$EG)J?T_
9:E'"HIDLYL<N'F'<8.R1?P"OK?>'%0X`````
`
end

-- 
Vojtech Pavlik
SuSE Labs
