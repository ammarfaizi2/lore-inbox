Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUCWG6L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 01:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUCWG6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 01:58:11 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:28314 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262208AbUCWG5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 01:57:55 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/RFT] PS/2 strict protocol checking and reconnect for KVM users
Date: Tue, 23 Mar 2004 01:57:47 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403230157.47800.dtor_core@ameritech.net>
X-Amavis-Alert: BAD HEADER Improper use of control character (char 0D hex) in message header 'User-Agent'
  User-Agent: KMail/1.6.1\r\n                         ^
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have heard many complaints from KVM users who lose mouse when switching
to 2.6 when KVM for some reason suppresses the 0xAA 0x00 announce sequence
from the mouse and mouse is reset to protocol other then kernel expects to
get.

I am trying to extend psmouse.resetafter option that is right now work only
for Synaptics touchpads to work with other types of hardware connected to
PS/2 port. Unfortunately standard PS/2 protocol has pretty much no pattern
that can be used to reliably validate the data stream. The only requirement
is that 1st byte has 4th bit set to 1. Unfortunately there are devices that
violate even this rule, so it can't be turned on by default requiring one
more option - psmouse.strict.

So, if you are a KVM user and your mouse stops working after switching from
2.6 and back please try the patch below and pass psmouse.strict and
psmouse.resetafter=3 parameters to your kernel and tell me if it works for you
(unfotrunately I do not have a KVM to play with).

-- 
Dmitry


===================================================================


ChangeSet@1.1850, 2004-03-23 01:51:34-05:00, dtor_core@ameritech.net
  Input: - Implement strict PS/2 protocol checking - disabled by default,
           activated via psmouse.strict option.
         - Make psmouse.resetafter work for all types of PS/2 devices.
           Together with psmouse.strict should help users of KVM switces
           re-initialize mouse after switching to 2.6 box.


 Documentation/kernel-parameters.txt |    6 ++-
 drivers/input/mouse/psmouse-base.c  |   67 ++++++++++++++++++++++++++----------
 drivers/input/mouse/psmouse.h       |    8 +++-
 drivers/input/mouse/synaptics.c     |   24 ++++--------
 drivers/input/mouse/synaptics.h     |    3 -
 5 files changed, 70 insertions(+), 38 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Tue Mar 23 01:53:31 2004
+++ b/Documentation/kernel-parameters.txt	Tue Mar 23 01:53:31 2004
@@ -881,13 +881,15 @@
 	psmouse.rate=	[HW,MOUSE] Set desired mouse report rate, in reports
 			per second.
 	psmouse.resetafter=
-			[HW,MOUSE] Try to reset Synaptics Touchpad after so many
-			bad packets (0 = never).
+			[HW,MOUSE] Try to reset the device after so many bad packets
+                        (0 = never).
 	psmouse.resolution=
 			[HW,MOUSE] Set desired mouse resolution, in dpi.
 	psmouse.smartscroll=
 			[HW,MOUSE] Controls Logitech smartscroll autorepeat,
 			0 = disabled, 1 = enabled (default).
+	psmouse.strict= [HW,MOUSE] Enforce strict PS/2 protocol,
+                        0 = disabled (default), 1 = enabled.
 
 	pss=		[HW,OSS] Personal Sound System (ECHO ESC614)
 			Format: <io>,<mss_io>,<mss_irq>,<mss_dma>,<mpu_io>,<mpu_irq>
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Mar 23 01:53:31 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Mar 23 01:53:31 2004
@@ -43,9 +43,13 @@
 module_param_named(smartscroll, psmouse_smartscroll, bool, 0);
 MODULE_PARM_DESC(smartscroll, "Logitech Smartscroll autorepeat, 1 = enabled (default), 0 = disabled.");
 
+static int psmouse_strict;
+module_param_named(strict, psmouse_strict, bool, 0);
+MODULE_PARM_DESC(smartscroll, "Enforce strict PS/2 protocol. Useful for KVM switches.");
+
 unsigned int psmouse_resetafter;
 module_param_named(resetafter, psmouse_resetafter, uint, 0);
-MODULE_PARM_DESC(resetafter, "Reset Synaptics Touchpad after so many bad packets (0 = never).");
+MODULE_PARM_DESC(resetafter, "Try resetting the device after so many bad packets (0 = never).");
 
 __obsolete_setup("psmouse_noext");
 __obsolete_setup("psmouse_resolution=");
@@ -56,15 +60,26 @@
 static char *psmouse_protocols[] = { "None", "PS/2", "PS2++", "PS2T++", "GenPS/2", "ImPS/2", "ImExPS/2", "SynPS/2"};
 
 /*
- * psmouse_process_packet() analyzes the PS/2 mouse packet contents and
- * reports relevant events to the input module.
+ * psmouse_process_byte() analyzes the PS/2 data stream and reports reports
+ * relevant events to the input module once full packet has arrived.
  */
 
-static void psmouse_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
+static int psmouse_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
 	unsigned char *packet = psmouse->packet;
 
+	if (psmouse->pktcnt == 1 && psmouse_strict)
+		if (!(packet[0] & 0x08))
+			return PSMOUSE_BAD_DATA;
+
+	if (psmouse->pktcnt < 3 + (psmouse->type >= PSMOUSE_GENPS))
+		return PSMOUSE_GOOD_DATA;
+
+/*
+ * Full packet accumulated, process it
+ */
+
 	input_regs(dev, regs);
 
 /*
@@ -112,6 +127,8 @@
 	input_report_rel(dev, REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
 
 	input_sync(dev);
+
+	return PSMOUSE_FULL_PACKET;
 }
 
 /*
@@ -123,6 +140,7 @@
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct psmouse *psmouse = serio->private;
+	int rc;
 
 	if (psmouse->state == PSMOUSE_IGNORE)
 		goto out;
@@ -180,7 +198,7 @@
 		if (psmouse->pktcnt == 2) {
 			if (psmouse->packet[1] == PSMOUSE_RET_ID) {
 				psmouse->state = PSMOUSE_IGNORE;
-				serio_rescan(serio);
+				serio_reconnect(serio);
 				goto out;
 			}
 			if (psmouse->type == PSMOUSE_SYNAPTICS) {
@@ -193,19 +211,34 @@
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
+		default:
+			break;
 	}
 out:
 	return IRQ_HANDLED;
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	Tue Mar 23 01:53:31 2004
+++ b/drivers/input/mouse/psmouse.h	Tue Mar 23 01:53:31 2004
@@ -22,6 +22,11 @@
 #define PSMOUSE_ACTIVATED	1
 #define PSMOUSE_IGNORE		2
 
+/* psmouse protocol handler return codes */
+#define PSMOUSE_GOOD_DATA	0
+#define PSMOUSE_BAD_DATA	1
+#define PSMOUSE_FULL_PACKET	2
+
 struct psmouse;
 
 struct psmouse_ptport {
@@ -45,10 +50,11 @@
 	unsigned char type;
 	unsigned char model;
 	unsigned long last;
+	unsigned long out_of_sync;
 	unsigned char state;
 	char acking;
 	volatile char ack;
-	char error;
+	char spare;
 	char devname[64];
 	char phys[32];
 
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Mar 23 01:53:31 2004
+++ b/drivers/input/mouse/synaptics.c	Tue Mar 23 01:53:31 2004
@@ -607,6 +607,9 @@
 	static unsigned char oldabs_mask[]	= { 0xC0, 0x60, 0x00, 0xC0, 0x60 };
 	static unsigned char oldabs_rslt[]	= { 0xC0, 0x00, 0x00, 0x80, 0x00 };
 
+	if (idx < 0 || idx > 4)
+		return 0;
+
 	switch (pkt_type) {
 		case SYN_NEWABS:
 		case SYN_NEWABS_RELAXED:
@@ -637,7 +640,7 @@
 	return SYN_NEWABS_STRICT;
 }
 
-void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
+int synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
@@ -645,11 +648,6 @@
 	input_regs(dev, regs);
 
 	if (psmouse->pktcnt >= 6) { /* Full packet received */
-		if (priv->out_of_sync) {
-			priv->out_of_sync = 0;
-			printk(KERN_NOTICE "Synaptics driver resynced.\n");
-		}
-
 		if (unlikely(priv->pkt_type == SYN_NEWABS))
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
@@ -657,16 +655,10 @@
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
--- a/drivers/input/mouse/synaptics.h	Tue Mar 23 01:53:31 2004
+++ b/drivers/input/mouse/synaptics.h	Tue Mar 23 01:53:31 2004
@@ -9,7 +9,7 @@
 #ifndef _SYNAPTICS_H
 #define _SYNAPTICS_H
 
-extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
+extern int synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
 extern int synaptics_detect(struct psmouse *psmouse);
 extern int synaptics_init(struct psmouse *psmouse);
 extern void synaptics_reset(struct psmouse *psmouse);
@@ -108,7 +108,6 @@
 	unsigned long int identity;		/* Identification */
 
 	/* Data for normal processing */
-	unsigned int out_of_sync;		/* # of packets out of sync */
 	int old_w;				/* Previous w value */
 	unsigned char pkt_type;			/* packet type - old, new, etc */
 };
