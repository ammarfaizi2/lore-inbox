Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSHaOT7>; Sat, 31 Aug 2002 10:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSHaOT7>; Sat, 31 Aug 2002 10:19:59 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:63920 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315440AbSHaOTy>;
	Sat, 31 Aug 2002 10:19:54 -0400
Date: Sat, 31 Aug 2002 16:16:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>, torvalds@transmeta.com
Cc: James Simmons <jsimmons@transvirtual.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [patch] Fixes in serport.c
Message-ID: <20020831161648.A64429@ucw.cz>
References: <E17ktTz-000359-00@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17ktTz-000359-00@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Aug 30, 2002 at 10:39:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 10:39:11PM +0100, Russell King wrote:

> This patch appears not to be in 2.5.32, but applies cleanly.
> 
> serport/serio presently has several problems.  This is by no means a
> definitive list (for example, the locking problems that hch reported
> back in 2.4.0-test time):

This patch should fix all four of them:

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.570, 2002-08-31 16:15:03+02:00, vojtech@suse.cz
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
--- a/drivers/char/tty_io.c	Sat Aug 31 16:15:18 2002
+++ b/drivers/char/tty_io.c	Sat Aug 31 16:15:18 2002
@@ -204,6 +204,8 @@
 	return _tty_make_name(tty, (tty)?tty->driver.name:NULL, buf);
 }
 
+EXPORT_SYMBOL(tty_name);
+
 inline int tty_paranoia_check(struct tty_struct *tty, kdev_t device,
 			      const char *routine)
 {
diff -Nru a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
--- a/drivers/input/serio/serport.c	Sat Aug 31 16:15:18 2002
+++ b/drivers/input/serio/serport.c	Sat Aug 31 16:15:18 2002
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
+
## Wrapped with gzip_uu ##


begin 664 bkpatch64481
M'XL(`';/<#T``\U7^X_:1A#^V?M73!.E@H2'UT_,Z:HT!TE1TAR"NZJGID+&
MK+&#\:+=-82(/[ZSAN.XZ[V52N6AP_;LS#<SWWR[]Q+.)1-M8\F_*A8EY"7\
MQJ5J&[*0K!%]Q^L!YWC=3/B<-7=6S?&LF>:+0A%\W@]5E,"2"=DV:,/>WU'K
M!6L;@^Z'\T^_#@@Y/H:3),RG;,@4'!\3Q<4RS";R;:B2C.<-)<)<SID*&Q&?
M;_:F&\LT+7R[U+=-U]M0SW3\340GE(8.91/3<EJ>0Z:"3=_.!`^3VY:W;&JZ
MMFWZ&]>AMDDZ0!NN;X)I-<U6TZ9`O39UVZ;]QK3:I@F[--_NB@!O+*B;Y!W\
M6,PG)(*S))40I]^8A(7@XXS-):0Y8$L67*A&!#$O\@F,US`HI&19!A_3?-K&
ME?IET"KTM\M@E:H$HD((EJOZ+U*%BAUX&F635$8CP<))XW(Q?H<\6[+2?2'1
M+ZS"5(W8$EV,TEPQ(8J%2M%]I7JYR#J(F+#;_%>J@#DQO1Q=JU4:L5M";N-)
MID;C5`%2(LSV5G853OA\D;%OD(=S;<=C4`G3P5(..IX\='E>^E)J/4)SIN/G
M4AUFZB!H+J7.!+`RT0PX\C7.^*JLMEX%4Y8S$:J4YX_S#>0CN+;C!*1_16Q2
M?^*+$#,TR2\/,&LB4CU?S2@)15-C27DC.F"98YK.QFVU/&_#&$6NCZ,@CN(P
M&,<WN7R?+QP3ZE#7-#>6Y=+@:;"^\K54:31K[KE[':"[P1%TK`V-[(GGA5'+
M'<<3FWEW`BP%IEFV_*;/*Z">37V_%)=[ESTL.#\D%W*9"[(^2Z>):A31ZI$Y
M^99CV8Y/Z<;R`C\H-2KXET*9=RJ4#777^9]IU+/UZ<G:]'Q=>EB3'JU'#VG1
M<W3H00W:3L`IU,6J_*"F].\?AF>(5,<"2GH6V`1>0T\[A0E;8@7A[.P"LC1G
MH.N<+O1/M-%F)WRQ%GH(H!)5@09!4-><@S^VU,53PC)+9Z3C@$,ZU`;J8X1@
M&Z*D'))M*L*Y[EHL&%:,QVH5"G8$:UY`%.:`C4RE$NFXT&3"?N63)A<PYY,T
M7N,-[0JIR439+6P\,G?7N@^?S^%#6>H,^L4X2R/XA/GDDI5'&2P_6!`B"/U,
M)B41M3N]]KU&,]RA@?>:_67#&J3GV&"1EQ,6ZY(,NX/^Z>!L].Y\>&%0\@4?
M^UA'H\AE.LW1)<[G%.(LG,HCTL/SB(4VQJY/.".Z;0U]C()C,(](Q_?0HN=K
M'XCDJN"`8$/-CP;T%):-+1"7/&`HUJB(5(-T6AI>K^5H%%KI2LK]Y3E_H_<@
M`)?TJ&GKAS)?")RRN+)'LTC6L@8R_<[XC;O5&KQX);<L,U_4KHB*/VIEA&H5
M_5//T<&IY]X6G7I^&=ZG:&2D,504DVJ$'1WM!K)R6,X:_+S'4!:P6B6&(9@J
M1`[UKC;13GW,%(E+6SJT4:8TJWSL#CZ/>I_?G\*+$G,;AO@'>:#=P2OY);\S
M">-.$=JCT18U^.F6+N)Z1*)[:$09"\4CDCI"0G1HT,(1Z5GFOC31?(([&@S[
MO=.3X=E%OWN0_!2KA9N"J-R"H`:5Z]Q[78503'5W+(I[S+6-]-H!X8D;Z-/.
M*#=/[_>XPLW*HK;K>'CI.'ZY2]K^$[;)_^H@W_U6LN>2-C@I'`<P5%J,B@RG
M4>L5HD!5:J!J;P]8=ZCVM;R?H=9(%<VR[I\ELX87O[\[_52Y1%9R:O]/6I2P
5:":+^;$3L-CQ&"/_`/9DR!D1#@``
`
end

-- 
Vojtech Pavlik
SuSE Labs
