Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUF1FkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUF1FkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264771AbUF1FhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:37:07 -0400
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:30604 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264704AbUF1FXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:23:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 15/19] synaptics passthrough handling
Date: Mon, 28 Jun 2004 00:23:10 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280021.21090.dtor_core@ameritech.net> <200406280022.16273.dtor_core@ameritech.net>
In-Reply-To: <200406280022.16273.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280023.21998.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1789, 2004-06-27 16:03:33-05:00, dtor_core@ameritech.net
  Input: synaptics - do not try to process packets from slave device
         as if they were coming form the touchpad itself if pass-through
         port is disconnected
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 synaptics.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-06-27 17:51:38 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-06-27 17:51:38 -05:00
@@ -472,9 +472,10 @@
 		if (unlikely(priv->pkt_type == SYN_NEWABS))
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
-		if (psmouse->serio->child && psmouse->serio->child->drv && synaptics_is_pt_packet(psmouse->packet))
-			synaptics_pass_pt_packet(psmouse->serio->child, psmouse->packet);
-		else
+		if (SYN_CAP_PASS_THROUGH(priv->capabilities) && synaptics_is_pt_packet(psmouse->packet)) {
+			if (psmouse->serio->child && psmouse->serio->child->drv)
+				synaptics_pass_pt_packet(psmouse->serio->child, psmouse->packet);
+		} else
 			synaptics_process_packet(psmouse);
 
 		return PSMOUSE_FULL_PACKET;
