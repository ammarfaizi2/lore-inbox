Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262678AbVA0RSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbVA0RSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbVA0RQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:16:46 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:64735 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262670AbVA0ROV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:14:21 -0500
Subject: [PATCH 3/6] Always bring the i8042 multiplexer out of multiplexing mode
In-Reply-To: <11068460381254@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 27 Jan 2005 18:13:58 +0100
Message-Id: <11068460382702@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1975.1.1, 2005-01-27 13:47:19+01:00, vojtech@silver.ucw.cz
  input: Always bring the i8042 multiplexer out of multiplexing mode before
         rebooting.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 i8042.c |   36 ++++++++++++++++++++++--------------
 1 files changed, 22 insertions(+), 14 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2005-01-27 17:47:51 +01:00
+++ b/drivers/input/serio/i8042.c	2005-01-27 17:47:51 +01:00
@@ -458,12 +458,11 @@
 }
 
 /*
- * i8042_enable_mux_mode checks whether the controller has an active
- * multiplexor and puts the chip into Multiplexed (as opposed to
- * Legacy) mode.
+ * i8042_set_mux_mode checks whether the controller has an active
+ * multiplexor and puts the chip into Multiplexed (1) or Legacy (0) mode.
  */
 
-static int i8042_enable_mux_mode(struct i8042_values *values, unsigned char *mux_version)
+static int i8042_set_mux_mode(unsigned int mode, unsigned char *mux_version)
 {
 
 	unsigned char param;
@@ -482,11 +481,11 @@
 	param = 0xf0;
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x0f)
 		return -1;
-	param = 0x56;
+	param = mode ? 0x56 : 0xf6;
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa9)
 		return -1;
-	param = 0xa4;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b)
+	param = mode ? 0xa4 : 0xa5;
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == (mode ? 0x5b : 0x5a))
 		return -1;
 
 	if (mux_version)
@@ -540,11 +539,11 @@
 {
 	unsigned char mux_version;
 
-	if (i8042_enable_mux_mode(values, &mux_version))
+	if (i8042_set_mux_mode(1, &mux_version))
 		return -1;
 
-	/* Workaround for broken chips which seem to support MUX, but in reality don't. */
-	/* They all report version 10.12 */
+	/* Workaround for interference with USB Legacy emulation */
+	/* that causes a v10.12 MUX to be found. */
 	if (mux_version == 0xAC)
 		return -1;
 
@@ -774,12 +773,21 @@
  */
 void i8042_controller_reset(void)
 {
-	if (i8042_reset) {
-		unsigned char param;
+	unsigned char param;
+
+/*
+ * Reset the controller if requested.
+ */
 
+	if (i8042_reset)
 		if (i8042_command(&param, I8042_CMD_CTL_TEST))
 			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
-	}
+
+/*
+ * Disable MUX mode if present.
+ */
+
+	i8042_set_mux_mode(0, NULL);
 
 /*
  * Restore the original control register setting.
@@ -888,7 +896,7 @@
 	}
 
 	if (i8042_mux_present)
-		if (i8042_enable_mux_mode(&i8042_aux_values, NULL) ||
+		if (i8042_set_mux_mode(1, NULL) ||
 		    i8042_enable_mux_ports(&i8042_aux_values)) {
 			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't work.\n");
 		}

