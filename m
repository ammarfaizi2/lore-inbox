Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263146AbSJHNk3>; Tue, 8 Oct 2002 09:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263149AbSJHNk3>; Tue, 8 Oct 2002 09:40:29 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:42644 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263146AbSJHNkO>;
	Tue, 8 Oct 2002 09:40:14 -0400
Date: Tue, 8 Oct 2002 15:45:49 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Use lists.h in gameport core [7/23]
Message-ID: <20021008154549.F18546@ucw.cz>
References: <20021008153813.A18515@ucw.cz> <20021008153926.A18546@ucw.cz> <20021008154029.B18546@ucw.cz> <20021008154132.C18546@ucw.cz> <20021008154246.D18546@ucw.cz> <20021008154415.E18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008154415.E18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:44:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.36, 2002-09-25 12:02:30+02:00, vojtech@suse.cz
  Convert gameport.[ch] to use lists.h for its linked lists.


 drivers/input/gameport/gameport.c |   74 ++++++++++----------------------------
 include/linux/gameport.h          |   32 ++++------------
 2 files changed, 29 insertions(+), 77 deletions(-)

===================================================================

diff -Nru a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	Tue Oct  8 15:26:57 2002
+++ b/drivers/input/gameport/gameport.c	Tue Oct  8 15:26:57 2002
@@ -1,31 +1,13 @@
 /*
- * $Id: gameport.c,v 1.18 2002/01/22 20:41:14 vojtech Exp $
- *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
- */
-
-/*
  * Generic gameport layer
+ *
+ * Copyright (c) 1999-2002 Vojtech Pavlik
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
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #include <asm/io.h>
@@ -51,9 +33,8 @@
 EXPORT_SYMBOL(gameport_rescan);
 EXPORT_SYMBOL(gameport_cooked_read);
 
-static struct gameport *gameport_list;
-static struct gameport_dev *gameport_dev;
-
+static LIST_HEAD(gameport_list);
+static LIST_HEAD(gameport_dev_list);
 
 #ifdef __i386__
 
@@ -122,12 +103,13 @@
 
 static void gameport_find_dev(struct gameport *gameport)
 {
-        struct gameport_dev *dev = gameport_dev;
+        struct gameport_dev *dev;
 
-        while (dev && !gameport->dev) {
+        list_for_each_entry(dev, &gameport_dev_list, node) {
+		if (gameport->dev)
+			break;
 		if (dev->connect)
                 	dev->connect(gameport, dev);
-                dev = dev->next;
         }
 }
 
@@ -139,52 +121,37 @@
 
 void gameport_register_port(struct gameport *gameport)
 {
-	gameport->next = gameport_list;	
-	gameport_list = gameport;
-
+	list_add_tail(&gameport->node, &gameport_list);
 	gameport->speed = gameport_measure_speed(gameport);
-
 	gameport_find_dev(gameport);
 }
 
 void gameport_unregister_port(struct gameport *gameport)
 {
-        struct gameport **gameportptr = &gameport_list;
-
-        while (*gameportptr && (*gameportptr != gameport)) gameportptr = &((*gameportptr)->next);
-        *gameportptr = (*gameportptr)->next;
-
+	list_del_init(&gameport->node);
 	if (gameport->dev && gameport->dev->disconnect)
 		gameport->dev->disconnect(gameport);
 }
 
 void gameport_register_device(struct gameport_dev *dev)
 {
-	struct gameport *gameport = gameport_list;
+	struct gameport *gameport;
 
-	dev->next = gameport_dev;	
-	gameport_dev = dev;
-
-	while (gameport) {
+	list_add_tail(&dev->node, &gameport_dev_list);
+	list_for_each_entry(gameport, &gameport_list, node)
 		if (!gameport->dev && dev->connect)
 			dev->connect(gameport, dev);
-		gameport = gameport->next;
-	}
 }
 
 void gameport_unregister_device(struct gameport_dev *dev)
 {
-        struct gameport_dev **devptr = &gameport_dev;
-	struct gameport *gameport = gameport_list;
-
-        while (*devptr && (*devptr != dev)) devptr = &((*devptr)->next);
-        *devptr = (*devptr)->next;
+	struct gameport *gameport;
 
-	while (gameport) {
+	list_del_init(&dev->node);
+	list_for_each_entry(gameport, &gameport_list, node) {
 		if (gameport->dev == dev && dev->disconnect)
 			dev->disconnect(gameport);
 		gameport_find_dev(gameport);
-		gameport = gameport->next;
 	}
 }
 
@@ -209,5 +176,6 @@
 void gameport_close(struct gameport *gameport)
 {
 	gameport->dev = NULL;
-	if (gameport->close) gameport->close(gameport);
+	if (gameport->close)
+		gameport->close(gameport);
 }
diff -Nru a/include/linux/gameport.h b/include/linux/gameport.h
--- a/include/linux/gameport.h	Tue Oct  8 15:26:57 2002
+++ b/include/linux/gameport.h	Tue Oct  8 15:26:57 2002
@@ -2,33 +2,16 @@
 #define _GAMEPORT_H
 
 /*
- * $Id: gameport.h,v 1.20 2002/01/03 08:55:05 vojtech Exp $
+ *  Copyright (c) 1999-2002 Vojtech Pavlik
  *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
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
- *
- * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
- * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #include <asm/io.h>
 #include <linux/input.h>
+#include <linux/list.h>
 
 struct gameport;
 
@@ -53,7 +36,8 @@
 	void (*close)(struct gameport *);
 
 	struct gameport_dev *dev;
-	struct gameport *next;
+
+	struct list_head node;
 };
 
 struct gameport_dev {
@@ -64,7 +48,7 @@
 	void (*connect)(struct gameport *, struct gameport_dev *dev);
 	void (*disconnect)(struct gameport *);
 
-	struct gameport_dev *next;
+	struct list_head node;
 };
 
 int gameport_open(struct gameport *gameport, struct gameport_dev *dev, int mode);

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.36
## Wrapped with gzip_uu ##


begin 664 bkpatch18299
M'XL(`"'=HCT``]56;6_;-A#^;/Z*`P(425I+)/7N+D&[N$V-%5N0-/NR#09-
MT9%J630D*IDW__@=94=)G:5NLV[`9%LTZ>/=/0_O'GD/+FM5#7K7^J-1,B-[
M\$[79M"KFUHY\@^<GVN-<S?3<^5NK-S)S,W+16,(_GXFC,S@6E7UH,<<KULQ
MRX4:],[?G%Z^?WU.R-$1G&2BO%(7RL#1$3&ZNA9%6K\2)BMTZ9A*E/5<&>%(
M/5]UIBM.*<=7P"*/!N&*A=2/5I*EC`F?J91R/PY]LDGLU2;M[?T)]QE^>+"B
M-(@],@3F!)'G8+XA4.[2Q.4!,#Z@?.#1YWBG%+9\PG,.?4J^AV^;^0F1<*)+
MY,_`E9BKA:Z,\XO,?L,X@)&AR&M3.QE,=06YJ7%>SE2Z628_0.@'-")G=^R2
M_E=>A%!!R?$.8'DIBR95+L9O?G>[5+/[.!/?7U'$B6@GDRD/DB16,?,5G6ZS
MN<-=P@.&([>TL23:F5Q:Y;8"79F)ROVHE[7)Y>S.J[R7I(\EL&(TC(-5($(E
MI&1"1AZ+DP<YWGIM:[WS]L#M7;)AP/%(;:WOW+J[![X)IJXSS$U>Y%>9<1IY
M\Q78(NP:SX\872'(F+>=DVRW#`\?;1D&_<#[5YOFTS:Q#=$>PD_0KV[:-Q;X
MV>[S>$+7##F$9!0#)W"(;\QHL:PLQ[`O#X`E2=*W<.#G-2NHB]=%/B-#QH%%
M9,1C\.RV#UE>PZ+25Y68`WZ=5DI!K:?F1E3J)2QU`U*44*D4(5;YI#$*A0!$
MF;HH"7.=YM,E+EA739FJ"DRFP*AJ7H.>MI/3'R_A5)6J$@6<-9,BE_`^EZI$
MVBPIN2Z!@\`D[&]UANHR65IW=N];F\W%)AMXJS&$,+C#(</`1P"C($0":H.+
MZ'5T\6'\[LWKX?XML6-[+@<O/V.0JNM;(V0&2XJ,U@-L+@3=R#MQM!O@$&^M
M?;2VCRR5F\LZ&Z-:CK$/LK$J3;7<1_,7\.Q!S!=0ZE0=P)^DU\NGT"75/T:+
M`USL32HE9C:21S'2D/G<8F:^C[->&TFDZ=B(O-A_=K?;>KT?K\/GAZV7@$.`
M7H*P\Y*J8IR7N=GVTNX*O19E._2VZ(##VV^M90"^M;1%N9T>0GJ8V3WV>W]'
MW*WA-IH-<Q@R8A@+AZB%%+.=.<9K-#CP!^"[')^8#YXD!K!%,>2VS;#+<,`X
MGYZN+'2M[/EN+74F&-ZJ^&,/J=WB_<^>EH^J]N?=1JC1OA=2OF)>1,-6K!G]
M<K6.H<_]_U:LUX_W+;%^#.53-+H5E%9.#N&+%3H";DLG^G\+],BSS;BW81.^
M6]-IN7>R8V0F;*FQ\OUKU[)MSV5*I&T_8;N&K<*V]\=LNK_\,E-R5C?S(TY3
..@G3@/P%39=J55\,````
`
end
