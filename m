Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263162AbSJHNr0>; Tue, 8 Oct 2002 09:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263186AbSJHNpv>; Tue, 8 Oct 2002 09:45:51 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:49556 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263162AbSJHNn3>;
	Tue, 8 Oct 2002 09:43:29 -0400
Date: Tue, 8 Oct 2002 15:49:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [patch] Input - Use list_for_each_entry() in input.c [11/23]
Message-ID: <20021008154904.J18546@ucw.cz>
References: <20021008153813.A18515@ucw.cz> <20021008153926.A18546@ucw.cz> <20021008154029.B18546@ucw.cz> <20021008154132.C18546@ucw.cz> <20021008154246.D18546@ucw.cz> <20021008154415.E18546@ucw.cz> <20021008154549.F18546@ucw.cz> <20021008154631.G18546@ucw.cz> <20021008154733.H18546@ucw.cz> <20021008154824.I18546@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021008154824.I18546@ucw.cz>; from vojtech@suse.cz on Tue, Oct 08, 2002 at 03:48:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.
'bk pull bk://linux-input.bkbits.net/linux-input' should work as well.

===================================================================

ChangeSet@1.573.1.40, 2002-09-25 12:23:16+02:00, vojtech@suse.cz
  Use list_for_each_entry() in input.c.


 input.c |   46 ++++++++++++++++++----------------------------
 1 files changed, 18 insertions(+), 28 deletions(-)

===================================================================

diff -Nru a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c	Tue Oct  8 15:26:28 2002
+++ b/drivers/input/input.c	Tue Oct  8 15:26:28 2002
@@ -58,7 +58,7 @@
 
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
-	struct list_head * node;
+	struct input_handle *handle;
 
 	if (dev->pm_dev)
 		pm_access(dev->pm_dev);
@@ -177,11 +177,9 @@
 	if (type != EV_SYN) 
 		dev->sync = 0;
 
-	list_for_each(node,&dev->h_list) {
-		struct input_handle *handle = to_handle(node);
+	list_for_each_entry(handle, &dev->h_list, d_node)
 		if (handle->open)
 			handle->handler->event(handle, type, code, value);
-	}
 }
 
 static void input_repeat_key(unsigned long data)
@@ -234,8 +232,8 @@
 
 static void input_link_handle(struct input_handle *handle)
 {
-	list_add_tail(&handle->d_node,&handle->dev->h_list);
-	list_add_tail(&handle->h_node,&handle->handler->h_list);
+	list_add_tail(&handle->d_node, &handle->dev->h_list);
+	list_add_tail(&handle->h_node, &handle->handler->h_list);
 }
 
 #define MATCH_BIT(bit, max) \
@@ -400,8 +398,8 @@
 
 void input_register_device(struct input_dev *dev)
 {
-	struct list_head * node;
 	struct input_handle *handle;
+	struct input_handler *handler;
 	struct input_device_id *id;
 
 	set_bit(EV_SYN, dev->evbit);
@@ -415,12 +413,10 @@
 	INIT_LIST_HEAD(&dev->h_list);
 	list_add_tail(&dev->node,&input_dev_list);
 
-	list_for_each(node,&input_handler_list) {
-		struct input_handler *handler = to_handler(node);
+	list_for_each_entry(handler, &input_handler_list, node)
 		if ((id = input_match_device(handler->id_table, dev)))
 			if ((handle = handler->connect(handler, dev, id)))
 				input_link_handle(handle);
-	}
 
 #ifdef CONFIG_HOTPLUG
 	input_call_hotplug("add", dev);
@@ -443,7 +439,7 @@
 
 	del_timer_sync(&dev->timer);
 
-	list_for_each_safe(node,next,&dev->h_list) {
+	list_for_each_safe(node, next, &dev->h_list) {
 		struct input_handle * handle = to_handle(node);
 		list_del_init(&handle->d_node);
 		list_del_init(&handle->h_node);
@@ -464,7 +460,7 @@
 
 void input_register_handler(struct input_handler *handler)
 {
-	struct list_head * node;
+	struct input_dev *dev;
 	struct input_handle *handle;
 	struct input_device_id *id;
 
@@ -477,12 +473,10 @@
 
 	list_add_tail(&handler->node,&input_handler_list);
 	
-	list_for_each(node,&input_dev_list) {
-		struct input_dev *dev = to_dev(node);
+	list_for_each_entry(dev, &input_dev_list, node)
 		if ((id = input_match_device(handler->id_table, dev)))
 			if ((handle = handler->connect(handler, dev, id)))
 				input_link_handle(handle);
-	}
 
 #ifdef CONFIG_PROC_FS
 	input_devices_state++;
@@ -494,7 +488,7 @@
 {
 	struct list_head * node, * next;
 
-	list_for_each_safe(node,next,&handler->h_list) {
+	list_for_each_safe(node, next, &handler->h_list) {
 		struct input_handle * handle = to_handle_h(node);
 		list_del_init(&handle->h_node);
 		list_del_init(&handle->d_node);
@@ -591,14 +585,13 @@
 
 static int input_devices_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
 {
-	struct list_head * node;
+	struct input_dev *dev;
+	struct input_handle *handle;
 
 	off_t at = 0;
 	int i, len, cnt = 0;
 
-	list_for_each(node,&input_dev_list) {
-		struct input_dev * dev = to_dev(node);
-		struct list_head * hnode;
+	list_for_each_entry(dev, &input_dev_list, node) {
 
 		len = sprintf(buf, "I: Bus=%04x Vendor=%04x Product=%04x Version=%04x\n",
 			dev->id.bustype, dev->id.vendor, dev->id.product, dev->id.version);
@@ -607,10 +600,8 @@
 		len += sprintf(buf + len, "P: Phys=%s\n", dev->phys ? dev->phys : "");
 		len += sprintf(buf + len, "H: Handlers=");
 
-		list_for_each(hnode,&dev->h_list) {
-			struct input_handle * handle = to_handle(hnode);
+		list_for_each_entry(handle, &dev->h_list, d_node)
 			len += sprintf(buf + len, "%s ", handle->name);
-		}
 
 		len += sprintf(buf + len, "\n");
 
@@ -638,7 +629,7 @@
 		}
 	}
 
-	if (node == &input_dev_list)
+	if (&dev->node == &input_dev_list)
 		*eof = 1;
 
 	return (count > cnt) ? cnt : count;
@@ -646,14 +637,13 @@
 
 static int input_handlers_read(char *buf, char **start, off_t pos, int count, int *eof, void *data)
 {
-	struct list_head * node;
+	struct input_handler *handler;
 
 	off_t at = 0;
 	int len = 0, cnt = 0;
 	int i = 0;
 
-	list_for_each(node,&input_handler_list) {
-		struct input_handler *handler = to_handler(node);
+	list_for_each_entry(handler, &input_handler_list, node) {
 
 		if (handler->fops)
 			len = sprintf(buf, "N: Number=%d Name=%s Minor=%d\n",
@@ -674,7 +664,7 @@
 				break;
 		}
 	}
-	if (node == &input_handler_list)
+	if (&handler->node == &input_handler_list)
 		*eof = 1;
 
 	return (count > cnt) ? cnt : count;

===================================================================

This BitKeeper patch contains the following changesets:
1.573.1.40
## Wrapped with gzip_uu ##


begin 664 bkpatch18183
M'XL(``3=HCT``[U676_:,!1]QK_"4J4*VA)LQ\X'%56W,FUHDU9UZC,RL6FR
MT@0YAJY;?OQLA]&20>FZ:8!R27SO\3GW'D@.X'4I5;^U++YJF:3@`'XH2MUO
ME8M2>LEW<WY5%.:\EQ9WLK?*ZDUN>UD^7VA@UB^Y3E*XE*KLM[#GKZ_HA[GL
MMZ[>O;_^].8*@,$`7J0\OY%?I(:#`="%6O*9*,^Y3F=%[FG%\_).:NXEQ5VU
M3JT(0L2\&0Y]Q((*!XB&58(%QIQB*1"A44#!BMCYBG:S/B8,(\0(JP(:$@R&
M$'LL]#WL4001Z:&X1QC$I$_\/@Z.$>DC!!N8\!C#+@)OX;]E?@$2.P(XRTH]
MGA9J+'F2CF6NU4.[`[,<ND9[B0<^PH#B$('+QT:"[A^^`$`<@;,]&H3*[#SK
M&?=6!)[HH2:83@8QJXB(?"+$-!01PG**FUU[#LM-A?B85(A$F#B/;$W?[Y>_
M8`PF*5<&=Y+=S(M<>+G4'E\\RQL3%%+*:(5#'`7.383\YB.RTT<1[)+HOSNI
MU)(+6$PW$\S2?2J5A'P^GV4)G\RDP3&KL$P+I:6"22&D=9^;T6?85??N8\QT
MN7U<KW#E,,`0@Y$[MDJM%HFNC3\V31`S"8_J>`J&.$*0@!&.7.XVL77J"3P4
M<MD]2\<VYP2*<6Z$="P`-95#XH<6A_B1"34.%V*L>39K']80W;.ZR$"M+SQ"
M=DYWEJ7-LCJJ)Z5#BGPKF2*Z0[/Z)5K9;&QICBB.GU>MS*8;("OU*^V4V$V'
ME`9N;Q<::"6?RG9-/Y??]&8;._"'J0Y"5^W")G.3"H_,P3*NYT1WS\GDK=F:
M[PVF$7-,XWHO%_8R;;;9LF6Q;?#(!K*3[1[/L3B&OK$G>HT62R+`KAD!=@"O
M<6V`W>3,+<#]4%QH95/8KO-MEOF;;%*PA32N*^*7^"Q@S!%E6YSQ8I\YQ:$;
F7!UJHNOI-,@^1>@\/E(DJ4QNR\7=@,632329<O`3$@/Z@:T(````
`
end
