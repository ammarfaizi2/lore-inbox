Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVGYG7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVGYG7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 02:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbVGYFyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:54:23 -0400
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:17835 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261680AbVGYFx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:29 -0400
Message-Id: <20050725054533.671032000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 22/24] i8042 - dont use negation in i8042_command()
Content-Disposition: inline; filename=i8042-dont-negate-aux-result.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: i8042 - don't use negation to mark AUX data

Currently i8042_command() negates data coming from the AUX port
of keyboard controller; this is not a very reliable indicator.
Change i8042_command() to fail if response to I8042_CMD_AUX_LOOP
is not coming from AUX channel and get rid of negation.

Based on patch by Vojtech Pavlik.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |   62 +++++++++++++++++++++++---------------------
 1 files changed, 33 insertions(+), 29 deletions(-)

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -100,7 +100,7 @@ struct i8042_port {
 static struct i8042_port i8042_ports[I8042_NUM_PORTS] = {
 	{
 		.disable	= I8042_CTR_KBDDIS,
-		.irqen 		= I8042_CTR_KBDINT,
+		.irqen		= I8042_CTR_KBDINT,
 		.mux		= -1,
 		.name		= "KBD",
 	},
@@ -191,41 +191,45 @@ static int i8042_flush(void)
 static int i8042_command(unsigned char *param, int command)
 {
 	unsigned long flags;
-	int retval = 0, i = 0;
+	int i, retval, auxerr = 0;
 
 	if (i8042_noloop && command == I8042_CMD_AUX_LOOP)
 		return -1;
 
 	spin_lock_irqsave(&i8042_lock, flags);
 
-	retval = i8042_wait_write();
-	if (!retval) {
-		dbg("%02x -> i8042 (command)", command & 0xff);
-		i8042_write_command(command & 0xff);
-	}
+	if ((retval = i8042_wait_write()))
+		goto out;
 
-	if (!retval)
-		for (i = 0; i < ((command >> 12) & 0xf); i++) {
-			if ((retval = i8042_wait_write())) break;
-			dbg("%02x -> i8042 (parameter)", param[i]);
-			i8042_write_data(param[i]);
-		}
+	dbg("%02x -> i8042 (command)", command & 0xff);
+	i8042_write_command(command & 0xff);
 
-	if (!retval)
-		for (i = 0; i < ((command >> 8) & 0xf); i++) {
-			if ((retval = i8042_wait_read())) break;
-			if (i8042_read_status() & I8042_STR_AUXDATA)
-				param[i] = ~i8042_read_data();
-			else
-				param[i] = i8042_read_data();
-			dbg("%02x <- i8042 (return)", param[i]);
+	for (i = 0; i < ((command >> 12) & 0xf); i++) {
+		if ((retval = i8042_wait_write()))
+			goto out;
+		dbg("%02x -> i8042 (parameter)", param[i]);
+		i8042_write_data(param[i]);
+	}
+
+	for (i = 0; i < ((command >> 8) & 0xf); i++) {
+		if ((retval = i8042_wait_read()))
+			goto out;
+
+		if (command == I8042_CMD_AUX_LOOP &&
+		    !(i8042_read_status() & I8042_STR_AUXDATA)) {
+			retval = auxerr = -1;
+			goto out;
 		}
 
-	spin_unlock_irqrestore(&i8042_lock, flags);
+		param[i] = i8042_read_data();
+		dbg("%02x <- i8042 (return)", param[i]);
+	}
 
 	if (retval)
-		dbg("     -- i8042 (timeout)");
+		dbg("     -- i8042 (%s)", auxerr ? "auxerr" : "timeout");
 
+ out:
+	spin_unlock_irqrestore(&i8042_lock, flags);
 	return retval;
 }
 
@@ -507,17 +511,17 @@ static int i8042_set_mux_mode(unsigned i
  */
 
 	param = 0xf0;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x0f)
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xf0)
 		return -1;
 	param = mode ? 0x56 : 0xf6;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != (mode ? 0xa9 : 0x09))
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != (mode ? 0x56 : 0xf6))
 		return -1;
 	param = mode ? 0xa4 : 0xa5;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == (mode ? 0x5b : 0x5a))
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == (mode ? 0xa4 : 0xa5))
 		return -1;
 
 	if (mux_version)
-		*mux_version = ~param;
+		*mux_version = param;
 
 	return 0;
 }
@@ -619,7 +623,7 @@ static int __init i8042_check_aux(void)
  */
 
 	param = 0x5a;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa5) {
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x5a) {
 
 /*
  * External connection test - filters out AT-soldered PS/2 i8042's
@@ -630,7 +634,7 @@ static int __init i8042_check_aux(void)
  */
 
 		if (i8042_command(&param, I8042_CMD_AUX_TEST)
-		    	|| (param && param != 0xfa && param != 0xff))
+			|| (param && param != 0xfa && param != 0xff))
 				return -1;
 	}
 

