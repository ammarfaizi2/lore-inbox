Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUB2HUa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUB2HUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:20:30 -0500
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:43428 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261998AbUB2HUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:20:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 3/9] synaptics strict/relaxed protocol checks
Date: Sun, 29 Feb 2004 01:56:51 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402290153.08798.dtor_core@ameritech.net> <200402290155.04825.dtor_core@ameritech.net> <200402290155.46360.dtor_core@ameritech.net>
In-Reply-To: <200402290155.46360.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290156.53325.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1687, 2004-02-27 23:44:17-05:00, dtor_core@ameritech.net
  Input: Switch between strict/relaxed synaptics protocol checks based on
         data in the first full data packet. Having strict checks helps
         getting rid of bad data after loosing sync, but not all harware
         implements strict protocol.


 synaptics.c |   53 +++++++++++++++++++++++++++++++++++++++++------------
 synaptics.h |    7 +++++++
 2 files changed, 48 insertions(+), 12 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Sun Feb 29 01:16:28 2004
+++ b/drivers/input/mouse/synaptics.c	Sun Feb 29 01:16:28 2004
@@ -435,6 +435,8 @@
 		goto init_fail;
 	}
 
+	priv->pkt_type = SYN_MODEL_NEWABS(priv->model_id) ? SYN_NEWABS : SYN_OLDABS;
+
 	if (SYN_CAP_EXTENDED(priv->capabilities) && SYN_CAP_PASS_THROUGH(priv->capabilities))
        		synaptics_pt_create(psmouse);
 
@@ -602,19 +604,42 @@
 	input_sync(dev);
 }
 
-static int synaptics_validate_byte(struct psmouse *psmouse)
+static int synaptics_validate_byte(unsigned char packet[], int idx, unsigned char pkt_type)
 {
-	static unsigned char newabs_mask[] = { 0xC0, 0x00, 0x00, 0xC0, 0x00 };
-	static unsigned char newabs_rslt[] = { 0x80, 0x00, 0x00, 0xC0, 0x00 };
-	static unsigned char oldabs_mask[] = { 0xC0, 0x60, 0x00, 0xC0, 0x60 };
-	static unsigned char oldabs_rslt[] = { 0xC0, 0x00, 0x00, 0x80, 0x00 };
-	struct synaptics_data *priv = psmouse->private;
-	int idx = psmouse->pktcnt - 1;
+	static unsigned char newabs_mask[]	= { 0xC8, 0x00, 0x00, 0xC8, 0x00 };
+	static unsigned char newabs_rel_mask[]	= { 0xC0, 0x00, 0x00, 0xC0, 0x00 };
+	static unsigned char newabs_rslt[]	= { 0x80, 0x00, 0x00, 0xC0, 0x00 };
+	static unsigned char oldabs_mask[]	= { 0xC0, 0x60, 0x00, 0xC0, 0x60 };
+	static unsigned char oldabs_rslt[]	= { 0xC0, 0x00, 0x00, 0x80, 0x00 };
+
+	switch (pkt_type) {
+		case SYN_NEWABS:
+		case SYN_NEWABS_RELAXED:
+			return (packet[idx] & newabs_rel_mask[idx]) == newabs_rslt[idx];
+
+		case SYN_NEWABS_STRICT:
+			return (packet[idx] & newabs_mask[idx]) == newabs_rslt[idx];
+
+		case SYN_OLDABS:
+			return (packet[idx] & oldabs_mask[idx]) == oldabs_rslt[idx];
 
-	if (SYN_MODEL_NEWABS(priv->model_id))
-		return (psmouse->packet[idx] & newabs_mask[idx]) == newabs_rslt[idx];
-	else
-		return (psmouse->packet[idx] & oldabs_mask[idx]) == oldabs_rslt[idx];
+		default:
+			printk(KERN_ERR "synaptics: unknown packet type %d\n", pkt_type);
+			return 0;
+	}
+}
+
+static unsigned char synaptics_detect_pkt_type(struct psmouse *psmouse)
+{
+	int i;
+
+	for (i = 0; i < 5; i++)
+		if (!synaptics_validate_byte(psmouse->packet, i, SYN_NEWABS_STRICT)) {
+			printk(KERN_INFO "synaptics: using relaxed packet validation\n");
+			return SYN_NEWABS_RELAXED;
+		}
+
+	return SYN_NEWABS_STRICT;
 }
 
 void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
@@ -630,13 +655,17 @@
 			printk(KERN_NOTICE "Synaptics driver resynced.\n");
 		}
 
+		if (unlikely(priv->pkt_type == SYN_NEWABS))
+			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
+
 		if (psmouse->ptport && psmouse->ptport->serio.dev && synaptics_is_pt_packet(psmouse->packet))
 			synaptics_pass_pt_packet(&psmouse->ptport->serio, psmouse->packet);
 		else
 			synaptics_process_packet(psmouse);
 		psmouse->pktcnt = 0;
 
-	} else if (psmouse->pktcnt && !synaptics_validate_byte(psmouse)) {
+	} else if (psmouse->pktcnt &&
+		   !synaptics_validate_byte(psmouse->packet, psmouse->pktcnt - 1, priv->pkt_type)) {
 		printk(KERN_WARNING "Synaptics driver lost sync at byte %d\n", psmouse->pktcnt);
 		psmouse->pktcnt = 0;
 		if (++priv->out_of_sync == psmouse_resetafter) {
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	Sun Feb 29 01:16:28 2004
+++ b/drivers/input/mouse/synaptics.h	Sun Feb 29 01:16:28 2004
@@ -70,6 +70,12 @@
 #define SYN_PS_SET_MODE2		0x14
 #define SYN_PS_CLIENT_CMD		0x28
 
+/* synaptics packet types */
+#define SYN_NEWABS			0
+#define SYN_NEWABS_STRICT		1
+#define SYN_NEWABS_RELAXED		2
+#define SYN_OLDABS			3
+
 /*
  * A structure to describe the state of the touchpad hardware (buttons and pad)
  */
@@ -103,6 +109,7 @@
 	/* Data for normal processing */
 	unsigned int out_of_sync;		/* # of packets out of sync */
 	int old_w;				/* Previous w value */
+	unsigned char pkt_type;			/* packet type - old, new, etc */
 };
 
 #endif /* _SYNAPTICS_H */
