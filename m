Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265828AbUGHHCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUGHHCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265871AbUGHHBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:01:45 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:52866 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265837AbUGHG7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:59:19 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 7/8] New set of input patches
Date: Thu, 8 Jul 2004 01:58:30 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407080155.07827.dtor_core@ameritech.net> <200407080157.38459.dtor_core@ameritech.net> <200407080158.05735.dtor_core@ameritech.net>
In-Reply-To: <200407080158.05735.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407080158.32258.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1826, 2004-07-08 01:28:44-05:00, dtor_core@ameritech.net
  Input: synaptics - do not try to process packets from slave device
         as if they were coming form the touchpad itself if pass-through
         port is disconnected, just pass them to serio core and it will
         attempt to bind proper driver to the port
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 synaptics.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-07-08 01:35:41 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-07-08 01:35:41 -05:00
@@ -233,17 +233,14 @@
 {
 	struct psmouse *child = ptport->private;
 
-	if (child) {
-		if (child->state == PSMOUSE_ACTIVATED) {
-			serio_interrupt(ptport, packet[1], 0, NULL);
-			serio_interrupt(ptport, packet[4], 0, NULL);
-			serio_interrupt(ptport, packet[5], 0, NULL);
-			if (child->type >= PSMOUSE_GENPS)
-				serio_interrupt(ptport, packet[2], 0, NULL);
-		} else if (child->state != PSMOUSE_IGNORE) {
-			serio_interrupt(ptport, packet[1], 0, NULL);
-		}
-	}
+	if (child && child->state == PSMOUSE_ACTIVATED) {
+		serio_interrupt(ptport, packet[1], 0, NULL);
+		serio_interrupt(ptport, packet[4], 0, NULL);
+		serio_interrupt(ptport, packet[5], 0, NULL);
+		if (child->type >= PSMOUSE_GENPS)
+			serio_interrupt(ptport, packet[2], 0, NULL);
+	} else
+		serio_interrupt(ptport, packet[1], 0, NULL);
 }
 
 static void synaptics_pt_activate(struct psmouse *psmouse)
@@ -472,9 +469,10 @@
 		if (unlikely(priv->pkt_type == SYN_NEWABS))
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
-		if (psmouse->serio->child && psmouse->serio->child->drv && synaptics_is_pt_packet(psmouse->packet))
-			synaptics_pass_pt_packet(psmouse->serio->child, psmouse->packet);
-		else
+		if (SYN_CAP_PASS_THROUGH(priv->capabilities) && synaptics_is_pt_packet(psmouse->packet)) {
+			if (psmouse->serio->child)
+				synaptics_pass_pt_packet(psmouse->serio->child, psmouse->packet);
+		} else
 			synaptics_process_packet(psmouse);
 
 		return PSMOUSE_FULL_PACKET;
