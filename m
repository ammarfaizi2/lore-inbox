Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbSJKKjx>; Fri, 11 Oct 2002 06:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSJKKjx>; Fri, 11 Oct 2002 06:39:53 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:7812 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262389AbSJKKjp>;
	Fri, 11 Oct 2002 06:39:45 -0400
Date: Fri, 11 Oct 2002 12:45:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Fixes in Active PS/2 Multiplexing support [3/5]
Message-ID: <20021011124526.B1763@ucw.cz>
References: <20021011124406.A1677@ucw.cz> <20021011124452.A1763@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021011124452.A1763@ucw.cz>; from vojtech@suse.cz on Fri, Oct 11, 2002 at 12:44:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.740, 2002-10-11 11:24:16+02:00, vojtech@suse.cz
  Fixes in i8042.c Active Multiplexing support.


 i8042.c |   48 +++++++++++++++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 17 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Fri Oct 11 12:43:06 2002
+++ b/drivers/input/serio/i8042.c	Fri Oct 11 12:43:06 2002
@@ -26,14 +26,16 @@
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(i8042_noaux, "1i");
+MODULE_PARM(i8042_nomux, "1i");
 MODULE_PARM(i8042_unlock, "1i");
 MODULE_PARM(i8042_reset, "1i");
 MODULE_PARM(i8042_direct, "1i");
 MODULE_PARM(i8042_dumbkbd, "1i");
 
+static int i8042_reset;
 static int i8042_noaux;
+static int i8042_nomux;
 static int i8042_unlock;
-static int i8042_reset;
 static int i8042_direct;
 static int i8042_dumbkbd;
 
@@ -220,7 +222,6 @@
 	return retval;
 }
 
-
 /*
  * i8042_open() is called when a port is open by the higher layer.
  * It allocates the interrupt and enables in in the chip.
@@ -323,8 +324,8 @@
 
 static struct i8042_values i8042_mux_values[4];
 static struct serio i8042_mux_port[4];
-static char i8042_mux_names[4][16];
-static char i8042_mux_short[4][8];
+static char i8042_mux_names[4][32];
+static char i8042_mux_short[4][16];
 static char i8042_mux_phys[4][32];
 
 /*
@@ -364,15 +365,15 @@
 		dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
 		      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
 
-		if (i8042_mux_values[0].exists && (buffer[i].str & I8042_STR_AUXDATA)) {
+		if (i8042_mux_values[0].exists && (str & I8042_STR_AUXDATA)) {
 
-			if (buffer[i].str & I8042_STR_MUXERR) {
-				switch (buffer[i].data) {
+			if (str & I8042_STR_MUXERR) {
+				switch (data) {
 					case 0xfd:
 					case 0xfe: dfl = SERIO_TIMEOUT; break;
 					case 0xff: dfl = SERIO_PARITY; break;
 				}
-				buffer[i].data = 0xfe;
+				data = 0xfe;
 			} else dfl = 0;
 
 			dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
@@ -380,8 +381,7 @@
 				dfl & SERIO_PARITY ? ", bad parity" : "",
 				dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
-			if (i8042_mux_values[(str >> 6)].exists)
-				serio_interrupt(i8042_mux_port + (str >> 6), buffer[i].data, dfl);
+			serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl);
 			continue;
 		}
 
@@ -390,8 +390,8 @@
 			dfl & SERIO_PARITY ? ", bad parity" : "",
 			dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
-		if (i8042_aux_values.exists && (buffer[i].str & I8042_STR_AUXDATA)) {
-			serio_interrupt(&i8042_aux_port, buffer[i].data, dfl);
+		if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA)) {
+			serio_interrupt(&i8042_aux_port, data, dfl);
 			continue;
 		}
 
@@ -602,8 +602,14 @@
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b)
 		return -1;
 
-	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev%d.%d.\n",
-		~param >> 4, ~param & 0xf);
+	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
+		(~param >> 4) & 0xf, ~param & 0xf);
+
+/*
+ * In MUX mode the keyboard translation seems to be always off.
+ */
+ 
+	i8042_direct = 1;
 
 /*
  * Disable all muxed ports by disabling AUX.
@@ -742,6 +748,12 @@
 static int __init i8042_setup_noaux(char *str)
 {
 	i8042_noaux = 1;
+	i8042_nomux = 1;
+	return 1;
+}
+static int __init i8042_setup_nomux(char *str)
+{
+	i8042_nomux = 1;
 	return 1;
 }
 static int __init i8042_setup_unlock(char *str)
@@ -762,6 +774,7 @@
 
 __setup("i8042_reset", i8042_setup_reset);
 __setup("i8042_noaux", i8042_setup_noaux);
+__setup("i8042_nomux", i8042_setup_nomux);
 __setup("i8042_unlock", i8042_setup_unlock);
 __setup("i8042_direct", i8042_setup_direct);
 __setup("i8042_dumbkbd", i8042_setup_dumbkbd);
@@ -796,6 +809,7 @@
 	sprintf(i8042_mux_short[index], "AUX%d", index);
 	port->name = i8042_mux_names[index];
 	port->phys = i8042_mux_phys[index];
+	port->driver = values;
 	values->name = i8042_mux_short[index];
 	values->mux = index;
 }
@@ -809,8 +823,8 @@
 	if (i8042_platform_init())
 		return -EBUSY;
 
-	i8042_aux_values.irq =	I8042_AUX_IRQ;
-	i8042_kbd_values.irq =	I8042_KBD_IRQ;
+	i8042_aux_values.irq = I8042_AUX_IRQ;
+	i8042_kbd_values.irq = I8042_KBD_IRQ;
 
 	if (i8042_controller_init())
 		return -ENODEV;
@@ -821,7 +835,7 @@
 	for (i = 0; i < 4; i++)
 		i8042_init_mux_values(i8042_mux_values + i, i8042_mux_port + i, i);
 
-	if (!i8042_noaux && !i8042_check_mux(&i8042_aux_values))
+	if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values))
 		for (i = 0; i < 4; i++)
 			i8042_port_register(i8042_mux_values + i, i8042_mux_port + i);
 	else 

===================================================================

This BitKeeper patch contains the following changesets:
1.740
## Wrapped with gzip_uu ##


begin 664 bkpatch1691
M'XL(`#JKICT``[56?V_:2!#]V_LIIE0704+,[GJQ#1%1:4FO*$V3HXU4J8V0
M8R_!!6QNO<Z/*W>?_6;7)$%)VMZ=KF!YL6?F[9N9-RN>PVDA5=>YS+]H&4_)
M<WB3%[KK%&4AW?@/?![E.3ZWIOE"MM9>K?-9*\V6I29H/XET/(5+J8JNPUSO
M[HV^6<JN,SKX]?1M?T1(KP>OIE%V(=]+#;T>T;FZC.9)\2+2TWF>N5I%6;&0
M.G+C?+&Z<UUQ2CE^VRSP:-M?,9^*8!6SA+%(,)E0+D)?D#6Q%VO:#^(998SZ
M@GMBY87M=D@&P-Q`4*"\Q6B+,6"LRT67^3N4=RF%!W"PPV"7DI?P_Y)^16)X
MG5[+`M(,TI`*[L;0CW5Z*>&HG.MT.9?7:78!1;E<YDJ[Y!"0O_#(R7TMR>Z_
M_!!"(TKV[W+45^D\O9AJMXRO3.D2E9IF5@UNH3C2O+4F5^454(_QML_\E8>5
MY:N`FI0B%DLJV(0F#ZOW0T3;G@X7C*]\O'M6+-\),O+Y:>P?2>G'[&F'!HRU
MVROA!UQ8<?''VN+?TI:'XF+!3U37)%=/R<K(J:KW,>RJ*WNA/$Z^5_K_H+8A
M#X&1H^/!Z=N#\4E_=%2W6.,L7Y373:BQM-;8(T//0Z]"1SJ-<1QT-0]C)0NI
MC54\9;40>V3@^6@=<&X@!A[W@6,$#W!9A\332*UC,&*<10M9?!)GGSQ^MO<-
MGV**$V=\F']FMP@0?%@MCI-.H'[OBUTK$9">N5C80A>PM07U0BO8@J%U>O]A
M-.Z??AST/_0;#?AJX#J69$!Q<2J\AP%'IQ\/1B/CC@Y.<96:4[6>1#JJ((*V
M9607XV$LT`-Z/9&&<.C9'4)1F6T;QU@[J52YU!OLS=$".U"W!/;WP6\@#:_1
M!`.(]\F\8?`Z%5Y'6,;W!8CN"O!/LW^"S=8]EJ'S8&^?MLW>/O4A),Y28=RL
M?G@P>C<>OGM]#+6U.+LPD#A:6B8057)?;)ZB<9YIE<_G4C5!R4OX)7'Q^IS5
MFLBH_M<R4M'"Y"],_EC%)JS?V2?D\9FTM@ELPS`#[`TL\D2"GDJ8R9OS/%()
MV(&=HYKR#`HI%P6.-)Q+B.97T4T!^63B8GR+`'&J?)-4(5]L&D.-!T*`?VNQ
MTJX,CI*Z5)GY^>?F#(RQ?NGM*."8E,LJJFZ5O(T=:)"O3^`-`]]H8ES%U&L;
M#K7F8S@SG$''S+!C6K.[7QT/B%5U'?L3,F[Z$S(C$>>1+%+U.WI76D`=C(>C
MW_9NW6;GR5-NAR\'E=L@Y(;LL%JL[)YM9H1:6S_'4QG/C*`WQ51!-QKW?U2L
36U$N>N*<<43EY&]6@L^@`PD`````
`
end
