Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264728AbUFGMff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbUFGMff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264727AbUFGMch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:32:37 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:1665 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264414AbUFGLzr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:47 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093533311@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1086609353103@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 12/39] input: Move reconnect after errors to generic code in psmouse
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.19, 2004-04-23 02:42:57-05:00, dtor_core@ameritech.net
  Input: move "reconnect after so many errors" handling from synaptics driver
         to psmouse so it can be used by other PS/2 protcol drivers (but so far
         only synaptics knows how to validate incoming data)


 Documentation/kernel-parameters.txt |    4 +-
 drivers/input/mouse/psmouse-base.c  |   61 +++++++++++++++++++++++++-----------
 drivers/input/mouse/psmouse.h       |    9 ++++-
 drivers/input/mouse/synaptics.c     |   24 ++++----------
 drivers/input/mouse/synaptics.h     |    3 -
 5 files changed, 62 insertions(+), 39 deletions(-)

===================================================================

diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-06-07 13:12:48 +02:00
+++ b/Documentation/kernel-parameters.txt	2004-06-07 13:12:48 +02:00
@@ -879,8 +879,8 @@
 	psmouse.rate=	[HW,MOUSE] Set desired mouse report rate, in reports
 			per second.
 	psmouse.resetafter=
-			[HW,MOUSE] Try to reset Synaptics Touchpad after so many
-			bad packets (0 = never).
+			[HW,MOUSE] Try to reset the device after so many bad packets
+			(0 = never).
 	psmouse.resolution=
 			[HW,MOUSE] Set desired mouse resolution, in dpi.
 	psmouse.smartscroll=
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-06-07 13:12:48 +02:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-07 13:12:48 +02:00
@@ -43,9 +43,9 @@
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
-unsigned int psmouse_resetafter;
+static unsigned int psmouse_resetafter;
 module_param_named(resetafter, psmouse_resetafter, uint, 0);
-MODULE_PARM_DESC(resetafter, "Reset Synaptics Touchpad after so many bad packets (0 = never).");
+MODULE_PARM_DESC(resetafter, "Reset device after so many bad packets (0 = never).");
 
 __obsolete_setup("psmouse_noext");
 __obsolete_setup("psmouse_resolution=");
@@ -56,15 +56,22 @@
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
 
 /*
- * psmouse_process_packet() analyzes the PS/2 mouse packet contents and
- * reports relevant events to the input module.
+ * psmouse_process_byte() analyzes the PS/2 data stream and reports
+ * relevant events to the input module once full packet has arrived.
  */
 
-static void psmouse_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
+static psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
 	unsigned char *packet = psmouse->packet;
 
+	if (psmouse->pktcnt < 3 + (psmouse->type >= PSMOUSE_GENPS))
+		return PSMOUSE_GOOD_DATA;
+
+/*
+ * Full packet accumulated, process it
+ */
+
 	input_regs(dev, regs);
 
 /*
@@ -112,6 +119,8 @@
 	input_report_rel(dev, REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
 
 	input_sync(dev);
+
+	return PSMOUSE_FULL_PACKET;
 }
 
 /*
@@ -123,6 +132,7 @@
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct psmouse *psmouse = serio->private;
+	psmouse_ret_t rc;
 
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
@@ -193,19 +203,33 @@
 		}
 	}
 
-	if (psmouse->type == PSMOUSE_SYNAPTICS) {
-		/*
-		 * The synaptics driver has its own resync logic,
-		 * so it needs to receive all bytes one at a time.
-		 */
-		synaptics_process_byte(psmouse, regs);
-		goto out;
-	}
+	rc = psmouse->type == PSMOUSE_SYNAPTICS ?
+		synaptics_process_byte(psmouse, regs) : psmouse_process_byte(psmouse, regs);
 
-	if (psmouse->pktcnt == 3 + (psmouse->type >= PSMOUSE_GENPS)) {
-		psmouse_process_packet(psmouse, regs);
-		psmouse->pktcnt = 0;
-		goto out;
+	switch (rc) {
+		case PSMOUSE_BAD_DATA:
+			printk(KERN_WARNING "psmouse.c: %s at %s lost sync at byte %d\n",
+				psmouse->name, psmouse->phys, psmouse->pktcnt);
+			psmouse->pktcnt = 0;
+
+			if (++psmouse->out_of_sync == psmouse_resetafter) {
+				psmouse->state = PSMOUSE_IGNORE;
+				printk(KERN_NOTICE "psmouse.c: issuing reconnect request\n");
+				serio_reconnect(psmouse->serio);
+			}
+			break;
+
+		case PSMOUSE_FULL_PACKET:
+			psmouse->pktcnt = 0;
+			if (psmouse->out_of_sync) {
+				psmouse->out_of_sync = 0;
+				printk(KERN_NOTICE "psmouse.c: %s at %s - driver resynched.\n",
+					psmouse->name, psmouse->phys);
+			}
+			break;
+
+		case PSMOUSE_GOOD_DATA:
+			break;
 	}
 out:
 	return IRQ_HANDLED;
@@ -677,7 +701,8 @@
 	old_type = psmouse->type;
 
 	psmouse->state = PSMOUSE_CMD_MODE;
-	psmouse->type = psmouse->acking = psmouse->cmdcnt = psmouse->pktcnt = 0;
+	psmouse->type = psmouse->acking = 0;
+	psmouse->cmdcnt = psmouse->pktcnt = psmouse->out_of_sync = 0;
 	if (psmouse->reconnect) {
 	       if (psmouse->reconnect(psmouse))
 			return -1;
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	2004-06-07 13:12:48 +02:00
+++ b/drivers/input/mouse/psmouse.h	2004-06-07 13:12:48 +02:00
@@ -22,6 +22,13 @@
 #define PSMOUSE_ACTIVATED	1
 #define PSMOUSE_IGNORE		2
 
+/* psmouse protocol handler return codes */
+typedef enum {
+	PSMOUSE_BAD_DATA,
+	PSMOUSE_GOOD_DATA,
+	PSMOUSE_FULL_PACKET
+} psmouse_ret_t;
+
 struct psmouse;
 
 struct psmouse_ptport {
@@ -45,6 +52,7 @@
 	unsigned char type;
 	unsigned char model;
 	unsigned long last;
+	unsigned long out_of_sync;
 	unsigned char state;
 	char acking;
 	volatile char ack;
@@ -69,6 +77,5 @@
 
 extern int psmouse_smartscroll;
 extern unsigned int psmouse_rate;
-extern unsigned int psmouse_resetafter;
 
 #endif /* _PSMOUSE_H */
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-06-07 13:12:48 +02:00
+++ b/drivers/input/mouse/synaptics.c	2004-06-07 13:12:48 +02:00
@@ -599,6 +599,9 @@
 	static unsigned char oldabs_mask[]	= { 0xC0, 0x60, 0x00, 0xC0, 0x60 };
 	static unsigned char oldabs_rslt[]	= { 0xC0, 0x00, 0x00, 0x80, 0x00 };
 
+	if (idx < 0 || idx > 4)
+		return 0;
+
 	switch (pkt_type) {
 		case SYN_NEWABS:
 		case SYN_NEWABS_RELAXED:
@@ -629,7 +632,7 @@
 	return SYN_NEWABS_STRICT;
 }
 
-void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
@@ -637,11 +640,6 @@
 	input_regs(dev, regs);
 
 	if (psmouse->pktcnt >= 6) { /* Full packet received */
-		if (priv->out_of_sync) {
-			priv->out_of_sync = 0;
-			printk(KERN_NOTICE "Synaptics driver resynced.\n");
-		}
-
 		if (unlikely(priv->pkt_type == SYN_NEWABS))
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
@@ -649,16 +647,10 @@
 			synaptics_pass_pt_packet(&psmouse->ptport->serio, psmouse->packet);
 		else
 			synaptics_process_packet(psmouse);
-		psmouse->pktcnt = 0;
 
-	} else if (psmouse->pktcnt &&
-		   !synaptics_validate_byte(psmouse->packet, psmouse->pktcnt - 1, priv->pkt_type)) {
-		printk(KERN_WARNING "Synaptics driver lost sync at byte %d\n", psmouse->pktcnt);
-		psmouse->pktcnt = 0;
-		if (++priv->out_of_sync == psmouse_resetafter) {
-			psmouse->state = PSMOUSE_IGNORE;
-			printk(KERN_NOTICE "synaptics: issuing reconnect request\n");
-			serio_reconnect(psmouse->serio);
-		}
+		return PSMOUSE_FULL_PACKET;
 	}
+
+	return synaptics_validate_byte(psmouse->packet, psmouse->pktcnt - 1, priv->pkt_type) ?
+		PSMOUSE_GOOD_DATA : PSMOUSE_BAD_DATA;
 }
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	2004-06-07 13:12:48 +02:00
+++ b/drivers/input/mouse/synaptics.h	2004-06-07 13:12:48 +02:00
@@ -9,7 +9,7 @@
 #ifndef _SYNAPTICS_H
 #define _SYNAPTICS_H
 
-extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
+extern psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
 extern int synaptics_detect(struct psmouse *psmouse);
 extern int synaptics_init(struct psmouse *psmouse);
 extern void synaptics_reset(struct psmouse *psmouse);
@@ -103,7 +103,6 @@
 	unsigned long int identity;		/* Identification */
 
 	/* Data for normal processing */
-	unsigned int out_of_sync;		/* # of packets out of sync */
 	int old_w;				/* Previous w value */
 	unsigned char pkt_type;			/* packet type - old, new, etc */
 };

