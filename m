Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264535AbUFGMbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUFGMbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbUFGMaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:30:39 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:3713 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264535AbUFGLzz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:55 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093533406@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <1086609353980@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 14/39] input: Add psmouse_sliced_command
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.21, 2004-04-23 02:44:24-05:00, dtor_core@ameritech.net
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
--- a/drivers/input/mouse/logips2pp.c	2004-06-07 13:12:36 +02:00
+++ b/drivers/input/mouse/logips2pp.c	2004-06-07 13:12:36 +02:00
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
--- a/drivers/input/mouse/psmouse-base.c	2004-06-07 13:12:36 +02:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-07 13:12:36 +02:00
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
--- a/drivers/input/mouse/psmouse.h	2004-06-07 13:12:36 +02:00
+++ b/drivers/input/mouse/psmouse.h	2004-06-07 13:12:36 +02:00
@@ -74,6 +74,7 @@
 #define PSMOUSE_SYNAPTICS 	7
 
 int psmouse_command(struct psmouse *psmouse, unsigned char *param, int command);
+int psmouse_sliced_command(struct psmouse *psmouse, unsigned char command);
 int psmouse_reset(struct psmouse *psmouse);
 
 extern int psmouse_smartscroll;
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-06-07 13:12:36 +02:00
+++ b/drivers/input/mouse/synaptics.c	2004-06-07 13:12:36 +02:00
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

