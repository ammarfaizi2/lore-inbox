Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbTI3Gam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbTI3G3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:29:08 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:37498 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263141AbTI3G2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:28:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 4/6] Synaptics: code cleanup
Date: Tue, 30 Sep 2003 01:20:51 -0500
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, petero2@telia.com, linux-kernel@vger.kernel.org
References: <200309300052.49908.dtor_core@ameritech.net> <200309300112.50076.dtor_core@ameritech.net> <200309300114.57761.dtor_core@ameritech.net>
In-Reply-To: <200309300114.57761.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309300120.51661.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: Synaptics code cleanup and credit update.


 synaptics.c |   79 ++++++++++++++++++++----------------------------------------
 1 files changed, 27 insertions(+), 52 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Sep 30 01:17:52 2003
+++ b/drivers/input/mouse/synaptics.c	Tue Sep 30 01:17:52 2003
@@ -2,7 +2,8 @@
  * Synaptics TouchPad PS/2 mouse driver
  *
  *   2003 Dmitry Torokhov <dtor@mail.ru>
- *     Added support for pass-through port
+ *     Added support for pass-through port. Special thanks to Peter Berg Larsen
+ *     for explaining various Synaptics quirks.
  *
  *   2003 Peter Osterlund <petero2@telia.com>
  *     Ported to 2.5 input device infrastructure.
@@ -419,16 +420,7 @@
 
 static void synaptics_parse_hw_state(unsigned char buf[], struct synaptics_data *priv, struct synaptics_hw_state *hw)
 {
-	hw->up    = 0;
-	hw->down  = 0;
-	hw->b0    = 0;
-	hw->b1    = 0;
-	hw->b2    = 0;
-	hw->b3    = 0;
-	hw->b4    = 0;
-	hw->b5    = 0;
-	hw->b6    = 0;
-	hw->b7    = 0;
+	memset(hw, 0, sizeof(struct synaptics_hw_state));
 
 	if (SYN_MODEL_NEWABS(priv->model_id)) {
 		hw->x = (((buf[3] & 0x10) << 8) |
@@ -570,44 +562,29 @@
 	input_sync(dev);
 }
 
+static int synaptics_validate_byte(struct psmouse *psmouse)
+{
+	static unsigned char newabs_mask[] = { 0xC8, 0x00, 0x00, 0xC8, 0x00 };
+	static unsigned char newabs_rslt[] = { 0x80, 0x00, 0x00, 0xC0, 0x00 };
+	static unsigned char oldabs_mask[] = { 0xC0, 0x60, 0x00, 0xC0, 0x60 };
+	static unsigned char oldabs_rslt[] = { 0xC0, 0x00, 0x00, 0x80, 0x00 };
+	struct synaptics_data *priv = psmouse->private;
+	int idx = psmouse->pktcnt - 1;
+
+	if (SYN_MODEL_NEWABS(priv->model_id))
+		return (psmouse->packet[idx] & newabs_mask[idx]) == newabs_rslt[idx];
+	else
+		return (psmouse->packet[idx] & oldabs_mask[idx]) == oldabs_rslt[idx];
+}
+
 void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs)
 {
 	struct input_dev *dev = &psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
-	unsigned char data = psmouse->packet[psmouse->pktcnt - 1];
-	int newabs = SYN_MODEL_NEWABS(priv->model_id);
 
 	input_regs(dev, regs);
 
-	switch (psmouse->pktcnt) {
-	case 1:
-		if (newabs ? ((data & 0xC8) != 0x80) : ((data & 0xC0) != 0xC0)) {
-			printk(KERN_WARNING "Synaptics driver lost sync at 1st byte\n");
-			goto bad_sync;
-		}
-		break;
-	case 2:
-		if (!newabs && ((data & 0x60) != 0x00)) {
-			printk(KERN_WARNING "Synaptics driver lost sync at 2nd byte\n");
-			goto bad_sync;
-		}
-		break;
-	case 4:
-		if (newabs ? ((data & 0xC8) != 0xC0) : ((data & 0xC0) != 0x80)) {
-			printk(KERN_WARNING "Synaptics driver lost sync at 4th byte\n");
-			goto bad_sync;
-		}
-		break;
-	case 5:
-		if (!newabs && ((data & 0x60) != 0x00)) {
-			printk(KERN_WARNING "Synaptics driver lost sync at 5th byte\n");
-			goto bad_sync;
-		}
-		break;
-	default:
-		if (psmouse->pktcnt < 6)
-			break;		    /* Wait for full packet */
-
+	if (psmouse->pktcnt >= 6) { /* Full packet received */
 		if (priv->out_of_sync) {
 			priv->out_of_sync = 0;
 			printk(KERN_NOTICE "Synaptics driver resynced.\n");
@@ -617,17 +594,15 @@
 			synaptics_pass_pt_packet(priv->ptport, psmouse->packet);
 		else
 			synaptics_process_packet(psmouse);
-
 		psmouse->pktcnt = 0;
-		break;
-	}
-	return;
 
- bad_sync:
-	priv->out_of_sync++;
-	psmouse->pktcnt = 0;
-	if (psmouse_resetafter > 0 && priv->out_of_sync	== psmouse_resetafter) {
-		psmouse->state = PSMOUSE_IGNORE;
-		serio_rescan(psmouse->serio);
+	} else if (psmouse->pktcnt && !synaptics_validate_byte(psmouse)) {
+		printk(KERN_WARNING "Synaptics driver lost sync at byte %d\n", psmouse->pktcnt);
+		psmouse->pktcnt = 0;
+		if (++priv->out_of_sync == psmouse_resetafter) {
+			psmouse->state = PSMOUSE_IGNORE;
+			printk(KERN_NOTICE "synaptics: issuing rescan request\n");
+			serio_rescan(psmouse->serio);
+		}
 	}
 }

