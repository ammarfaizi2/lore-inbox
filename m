Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264986AbUDUGMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264986AbUDUGMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265020AbUDUGLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:11:42 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:42156 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264993AbUDUGFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:50 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] New set of input patches: psmouse sliced commands
Date: Wed, 21 Apr 2004 01:02:57 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210102.59382.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1914, 2004-04-20 22:42:22-05:00, dtor_core@ameritech.net
  Input: add psmouse_sliced_command (passes extended commands encoded
         with 0xE8 to the mouse) and use it in Synaptics and Logitech
         drivers


 logips2pp.c    |   12 +-----------
 psmouse-base.c |   24 ++++++++++++++++++++++++
 psmouse.h      |    1 +
 synaptics.c    |   28 +++-------------------------
 4 files changed, 29 insertions(+), 36 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	Tue Apr 20 23:12:25 2004
+++ b/drivers/input/mouse/logips2pp.c	Tue Apr 20 23:12:25 2004
@@ -63,7 +63,6 @@
 		packet[0] &= 0x0f;
 		packet[1] = 0;
 		packet[2] = 0;
-
 	}
 }
 
@@ -76,17 +75,8 @@
 
 static int ps2pp_cmd(struct psmouse *psmouse, unsigned char *param, unsigned char command)
 {
-	unsigned char d;
-	int i;
-
-	if (psmouse_command(psmouse,  NULL, PSMOUSE_CMD_SETSCALE11))
+	if (psmouse_sliced_command(psmouse, command))
 		return -1;
-
-	for (i = 6; i >= 0; i -= 2) {
-		d = (command >> i) & 3;
-		if(psmouse_command(psmouse, &d, PSMOUSE_CMD_SETRES))
-			return -1;
-	}
 
 	if (psmouse_command(psmouse, param, PSMOUSE_CMD_POLL))
 		return -1;
diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Tue Apr 20 23:12:25 2004
+++ b/drivers/input/mouse/psmouse-base.c	Tue Apr 20 23:12:25 2004
@@ -312,6 +312,30 @@
 
 
 /*
+ * psmouse_sliced_command() sends an extended PS/2 command to the mouse
+ * using sliced syntax, understood by advanced devices, such as Logitech
+ * or Synaptics touchpads. The command is encoded as:
+ * 0xE6 0xE8 rr 0xE8 ss 0xE8 tt 0xE8 uu where (rr*64)+(ss*16)+(tt*4)+uu
+ * is the command.
+ */
+int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command)
+{
+	int i;
+
+	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11))
+		return -1;
+
+	for (i = 6; i >= 0; i -= 2) {
+		unsigned char d = (command >> i) & 3;
+		if (psmouse_command(psmouse, &d, PSMOUSE_CMD_SETRES))
+			return -1;
+	}
+
+	return 0;
+}
+
+
+/*
  * psmouse_reset() resets the mouse into power-on state.
  */
 int psmouse_reset(struct psmouse *psmouse)
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	Tue Apr 20 23:12:25 2004
+++ b/drivers/input/mouse/psmouse.h	Tue Apr 20 23:12:25 2004
@@ -74,6 +74,7 @@
 #define PSMOUSE_SYNAPTICS 	7
 
 int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
+int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
 
 extern int psmouse_smartscroll;
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Apr 20 23:12:25 2004
+++ b/drivers/input/mouse/synaptics.c	Tue Apr 20 23:12:25 2004
@@ -44,33 +44,11 @@
  ****************************************************************************/
 
 /*
- * Use the Synaptics extended ps/2 syntax to write a special command byte.
- * special command: 0xE8 rr 0xE8 ss 0xE8 tt 0xE8 uu where (rr*64)+(ss*16)+(tt*4)+uu
- *                  is the command. A 0xF3 or 0xE9 must follow (see synaptics_send_cmd
- *                  and synaptics_mode_cmd)
- */
-static int synaptics_special_cmd(struct psmouse *psmouse, unsigned char command)
-{
-	int i;
-
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11))
-		return -1;
-
-	for (i = 6; i >= 0; i -= 2) {
-		unsigned char d = (command >> i) & 3;
-		if (psmouse_command(psmouse, &d, PSMOUSE_CMD_SETRES))
-			return -1;
-	}
-
-	return 0;
-}
-
-/*
  * Send a command to the synpatics touchpad by special commands
  */
 static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c, unsigned char *param)
 {
-	if (synaptics_special_cmd(psmouse, c))
+	if (psmouse_sliced_command(psmouse, c))
 		return -1;
 	if (psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO))
 		return -1;
@@ -84,7 +62,7 @@
 {
 	unsigned char param[1];
 
-	if (synaptics_special_cmd(psmouse, mode))
+	if (psmouse_sliced_command(psmouse, mode))
 		return -1;
 	param[0] = SYN_PS_SET_MODE2;
 	if (psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE))
@@ -248,7 +226,7 @@
 	struct psmouse *parent = port->driver;
 	char rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
 
-	if (synaptics_special_cmd(parent, c))
+	if (psmouse_sliced_command(parent, c))
 		return -1;
 	if (psmouse_command(parent, &rate_param, PSMOUSE_CMD_SETRATE))
 		return -1;
