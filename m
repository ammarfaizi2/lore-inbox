Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbUCKHk1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUCKHkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:40:14 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:50578 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262986AbUCKHjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:39:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 3/3] Input patches: synaptics restore taps
Date: Thu, 11 Mar 2004 02:31:40 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200403110226.23897.dtor_core@ameritech.net> <200403110230.07892.dtor_core@ameritech.net> <200403110231.01676.dtor_core@ameritech.net>
In-Reply-To: <200403110231.01676.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403110231.42023.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1664, 2004-03-11 01:57:12-05:00, dtor_core@ameritech.net
  Input: if Synaptics' absolute mode is disabled make sure that
         touchpad is reset back to relative mode and gestures
         (taps) are enabled


 psmouse-base.c |    4 ++++
 synaptics.c    |    8 +++++++-
 synaptics.h    |    1 +
 3 files changed, 12 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Thu Mar 11 02:08:01 2004
+++ b/drivers/input/mouse/psmouse-base.c	Thu Mar 11 02:08:01 2004
@@ -389,6 +389,10 @@
  */
 			psmouse_max_proto = PSMOUSE_IMEX;
 		}
+/*
+ * Make sure that touchpad is in relative mode, gestures (taps) are enabled
+ */
+		synaptics_reset(psmouse);
 	}
 
 	if (psmouse_max_proto > PSMOUSE_IMEX && genius_detect(psmouse)) {
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Mar 11 02:08:01 2004
+++ b/drivers/input/mouse/synaptics.c	Thu Mar 11 02:08:01 2004
@@ -357,9 +357,15 @@
 	clear_bit(REL_Y, dev->relbit);
 }
 
-static void synaptics_disconnect(struct psmouse *psmouse)
+void synaptics_reset(struct psmouse *psmouse)
 {
+	/* reset touchpad back to relative mode, gestures enabled */
 	synaptics_mode_cmd(psmouse, 0);
+}
+
+static void synaptics_disconnect(struct psmouse *psmouse)
+{
+	synaptics_reset(psmouse);
 	kfree(psmouse->private);
 }
 
diff -Nru a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
--- a/drivers/input/mouse/synaptics.h	Thu Mar 11 02:08:01 2004
+++ b/drivers/input/mouse/synaptics.h	Thu Mar 11 02:08:01 2004
@@ -12,6 +12,7 @@
 extern void synaptics_process_byte(struct psmouse *psmouse, struct pt_regs *regs);
 extern int synaptics_detect(struct psmouse *psmouse);
 extern int synaptics_init(struct psmouse *psmouse);
+extern void synaptics_reset(struct psmouse *psmouse);
 
 /* synaptics queries */
 #define SYN_QUE_IDENTIFY		0x00
