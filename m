Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263149AbSJHNlK>; Tue, 8 Oct 2002 09:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263157AbSJHNlK>; Tue, 8 Oct 2002 09:41:10 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:45204 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263149AbSJHNk4>;
	Tue, 8 Oct 2002 09:40:56 -0400
Date: Tue, 8 Oct 2002 15:46:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Use lists.h in serio core [8/23]
Message-ID: <20021008154631.G18546@ucw.cz>
References: <20021008153813.A18515@ucw.cz> <20021008153926.A18546@ucw.cz> <20021008154029.B18546@ucw.cz> <20021008154132.C18546@ucw.cz> <20021008154246.D18546@ucw.cz> <20021008154415.E18546@ucw.cz> <20021008154549.F18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008154549.F18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:45:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.37, 2002-09-25 12:03:31+02:00, vojtech@suse.cz
  Convert serio.[ch] to use list.h lists.


 drivers/input/serio/serio.c |   88 ++++++++++++++++++++++++--------------------
 include/linux/serio.h       |   39 +++++--------------
 2 files changed, 59 insertions(+), 68 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Tue Oct  8 15:26:50 2002
+++ b/drivers/input/serio/serio.c	Tue Oct  8 15:26:50 2002
@@ -37,6 +37,7 @@
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/suspend.h>
+#include <linux/slab.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Serio abstraction core");
@@ -51,19 +52,27 @@
 EXPORT_SYMBOL(serio_close);
 EXPORT_SYMBOL(serio_rescan);
 
-static struct serio *serio_list;
-static struct serio_dev *serio_dev;
+struct serio_event {
+	int type;
+	struct serio *serio;
+	struct list_head node;
+};
+
+static LIST_HEAD(serio_list);
+static LIST_HEAD(serio_dev_list);
+static LIST_HEAD(serio_event_list);
 static int serio_pid;
 
 static void serio_find_dev(struct serio *serio)
 {
-        struct serio_dev *dev = serio_dev;
+	struct serio_dev *dev;
 
-        while (dev && !serio->dev) {
+	list_for_each_entry(dev, &serio_dev_list, node) {
+		if (serio->dev)
+			break;
 		if (dev->connect)
-                	dev->connect(serio, dev);
-                dev = dev->next;
-        }
+			dev->connect(serio, dev);
+	}
 }
 
 #define SERIO_RESCAN	1
@@ -73,17 +82,23 @@
 
 void serio_handle_events(void)
 {
-	struct serio *serio = serio_list;
+	struct list_head *node, *next;
+	struct serio_event *event;
 
-	while (serio) {
-		if (serio->event & SERIO_RESCAN) {
-			if (serio->dev && serio->dev->disconnect)
-				serio->dev->disconnect(serio);
-			serio_find_dev(serio);
-		}
+	list_for_each_safe(node, next, &serio_event_list) {
+		event = container_of(node, struct serio_event, node);	
 
-		serio->event = 0;
-		serio = serio->next;
+		switch (event->type) {
+			case SERIO_RESCAN :
+				if (event->serio->dev && event->serio->dev->disconnect)
+					event->serio->dev->disconnect(event->serio);
+				serio_find_dev(event->serio);
+				break;
+			default:
+				break;
+		}
+		list_del_init(node);
+		kfree(event);
 	}
 }
 
@@ -95,7 +110,7 @@
 
 	do {
 		serio_handle_events();
-		interruptible_sleep_on(&serio_wait); 
+		wait_event_interruptible(serio_wait, !list_empty(&serio_event_list)); 
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_IOTHREAD);
 	} while (!signal_pending(current));
@@ -108,7 +123,15 @@
 
 void serio_rescan(struct serio *serio)
 {
-	serio->event |= SERIO_RESCAN;
+	struct serio_event *event;
+
+	if (!(event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC)))
+		return;
+
+	event->type = SERIO_RESCAN;
+	event->serio = serio;
+
+	list_add_tail(&event->node, &serio_event_list);
 	wake_up(&serio_wait);
 }
 
@@ -122,49 +145,36 @@
 
 void serio_register_port(struct serio *serio)
 {
-	serio->next = serio_list;	
-	serio_list = serio;
+	list_add_tail(&serio->node, &serio_list);
 	serio_find_dev(serio);
 }
 
 void serio_unregister_port(struct serio *serio)
 {
-        struct serio **serioptr = &serio_list;
-
-        while (*serioptr && (*serioptr != serio)) serioptr = &((*serioptr)->next);
-        *serioptr = (*serioptr)->next;
-
+	list_del_init(&serio->node);
 	if (serio->dev && serio->dev->disconnect)
 		serio->dev->disconnect(serio);
 }
 
 void serio_register_device(struct serio_dev *dev)
 {
-	struct serio *serio = serio_list;
-
-	dev->next = serio_dev;	
-	serio_dev = dev;
-
-	while (serio) {
+	struct serio *serio;
+	list_add_tail(&dev->node, &serio_dev_list);
+	list_for_each_entry(serio, &serio_list, node)
 		if (!serio->dev && dev->connect)
 			dev->connect(serio, dev);
-		serio = serio->next;
-	}
 }
 
 void serio_unregister_device(struct serio_dev *dev)
 {
-        struct serio_dev **devptr = &serio_dev;
-	struct serio *serio = serio_list;
+	struct serio *serio;
 
-        while (*devptr && (*devptr != dev)) devptr = &((*devptr)->next);
-        *devptr = (*devptr)->next;
+	list_del_init(&dev->node);
 
-	while (serio) {
+	list_for_each_entry(serio, &serio_list, node) {
 		if (serio->dev == dev && dev->disconnect)
 			dev->disconnect(serio);
 		serio_find_dev(serio);
-		serio = serio->next;
 	}
 }
 
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Tue Oct  8 15:26:50 2002
+++ b/include/linux/serio.h	Tue Oct  8 15:26:50 2002
@@ -2,36 +2,16 @@
 #define _SERIO_H
 
 /*
- * $Id: serio.h,v 1.21 2001/12/19 05:15:21 skids Exp $
- *
- * Copyright (C) 1999-2001 Vojtech Pavlik
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
- */
-
-/*
- * The serial port set type ioctl.
+ * Copyright (C) 1999-2002 Vojtech Pavlik
+*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
  */
 
 #include <linux/ioctl.h>
+#include <linux/list.h>
+
 #define SPIOCSTYPE	_IOW('q', 0x01, unsigned long)
 
 struct serio;
@@ -57,7 +37,8 @@
 	void (*close)(struct serio *);
 
 	struct serio_dev *dev;
-	struct serio *next;
+
+	struct list_head node;
 };
 
 struct serio_dev {
@@ -71,7 +52,7 @@
 	void (*disconnect)(struct serio *);
 	void (*cleanup)(struct serio *);
 
-	struct serio_dev *next;
+	struct list_head node;
 };
 
 int serio_open(struct serio *serio, struct serio_dev *dev);

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.37
## Wrapped with gzip_uu ##


begin 664 bkpatch18270
M'XL(`!K=HCT``[U7;7/:.!#^;/V*[70F`VD`R^^&2Z9I2%/F>FTF:>_+]881
MMER[&)NQ95)Z]+_?2G8)+WFYMG='@@72[J/=9U>[XBF\+WG1UQ;Y)\&#F#R%
M5WDI^EI9E;P;?,'O5WF.WWMQ/N.]1JHWF?:2;%X)@NN73`0Q+'A1]C7:-=<S
M8CGG?>WJ_.+]Z],K0HZ/X2QFV4=^S04<'Q.1%PN6AN5S)N(TS[JB8%DYXX)U
M@WRV6HNN#%TW\,^FKJG;SHHZNN6N`AI2RBS*0]VP/,<BC6'/&[-W]7W#ICB:
M^LJQ;-TE0Z!=VS6[:*\+NM'3_9YA`S7ZNMDWZ3,=/^BP@PG/#.CHY`7\NY:?
MD0#.\@SY$X"12/+N'T'\)VX"N"VD22FZL1K*+OD5',LU77)Y2R7I?.>+$)WI
MY.01+\(BD1'M!3$K>I_R92F28-JK[0LV/+-TW5[IEN,[*QXP>^+S*/1<RCG;
MI6\-J1*GAMH&K(-D&M[*I+[O/VICD@5I%?)>FF35YP8JWF3=MZR5[KC47;'(
M#%S7X=3FW&-AN&?<`UBW9EF6YSDJDQ_PY?'<_GENR9PM>/K/F<4$I+Z-'U>(
M:SLJ_:F^F_B&=U_B6SYT3/\_37W,]]U<K[/@+72*&_6/N7OY$/,_<!1&I@^4
M/&VB#[\TX4_9I!N?D*%M@4%&M@T^*451!<T)'?,%SP3\1;0$!UGG!D3;%(!#
M-=S.2I_&,6<A9'F(TE\'Y`-",HP\O!Y=OQN_.C\=MFIP*=L>W+<:\L4C$LJX
M;S)#1T<'1^JY9:($@D-\2!E#R1A@$DU9&N7%F+,@'B-2L6RAU!$<;.]_I#QI
M2Q*T)()Z[\X)+K=Q1IL4G$TEM(6@(\=!'G$65SLG09YE/!"UQA%(#23J*QFZ
MCC3#5;)[O!W*[8YPX)_%#MM-.`[5@'NZ'CADY)D29]N=DD6\50-)G+53&Y0I
MAVK`8T!3!4LR7HSSJ-';W[AA8J"1H6?+?/'0#V1;*V\2V0=;2JIS(O.DAM<"
MAJ7]^OQJ]'9\=7Y]=OH&^G):$=E(W_()!P>P-XF/I&R85(0W1M\GLP4K^<97
M[4.49*&,ZET23115Y")6I:*_/?T5WXKAD*?C)$M$JZ8"IZ=1P7F-*=/0]V1L
MU5/3;E@B&L[Q`/&BJ.8BF:2\26"Y?`1/%#"?S<6RM1^F]@#(D%(J4>7@/Y@2
M'XBB]DGK6V"G,Y:F>=`JDR\<0[NOVCZ"BY>7X]-W;W\;G;7;DN*"BZK(%-A&
M1!%L,Y`#LA4'7&TJP8<F%['YC#&GTM9!(U>GU;Z'2!HU5#Y10QZ,7?4FSEOJ
M:T73`!L5S5O%=80V%96L9<KC0BU/'O^[J]C.UBJWMC;>J$IW5I#FK&^8V9P:
MW-^FZ"0.KO+5]G8KU=J,(;81)>/0.]Q:&Z6<<DR5&6KX/HOPA**ZBWJRT=]Y
M+WB\Q?_$U63O*OO@U<2BCN59#EY-;.I]=U]'V8[QO_?U^AJUT]?O]/('.OH0
MCXR+?9WB`8!#-&.^+)*/L8#661ODA:(C?8#?:RKPI\HB3:;D4,J^BY,2YD7^
ML6`SP(^R@D&91^*&%7P`R[R"@&50<"RKHD@FE>"0"&!9V,L+F.5A$BUQ0D)5
M6<@+$#$'+&^S$O)(?;EX\QXN./83EL)E-4EE]TX"GF$WD)>:),_``(9&R+4R
MYB%,EA).ZKZ4UEPWUL#+'+?`]H^Q0F?E-67W$E.S?H*%Y_8.8,@R=,^59.A:
BJOU:&^=O5V;]VRZ(>3`MJ]FQY?FN%4TL\C</_Z:%2`X`````
`
end
