Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbTI2Rq2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbTI2Ro3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:44:29 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:57272 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S263972AbTI2RnB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:43:01 -0400
Subject: [PATCH 1/4] Cleanup of the ADI gameport packet reading routine.
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 29 Sep 2003 19:42:51 +0200
Message-Id: <10648573712586@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1340.1.1, 2003-09-28 09:21:37+02:00, vojtech@suse.cz
  input: Cleanup the ADI gameport packet reading routine a bit.
         Thanks to a nice guy who wishes not to be named.


 adi.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

===================================================================

diff -Nru a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
--- a/drivers/input/joystick/adi.c	Mon Sep 29 19:37:19 2003
+++ b/drivers/input/joystick/adi.c	Mon Sep 29 19:37:19 2003
@@ -136,13 +136,18 @@
 
 /*
  * adi_read_packet() reads a Logitech ADI packet.
+ *
+ * A packet is sent in response to a gameport trigger command, and can arrive
+ * over one or both pairs of gameport button signals. If the top bit of the
+ * pair changes, it's a 1. If the bottom bit changes, it's a 0. The end of a
+ * packet is signalled by a timeout.
  */
 
 static void adi_read_packet(struct adi_port *port)
 {
 	struct adi *adi = port->adi;
 	struct gameport *gameport = port->gameport;
-	unsigned char u, v, w, x, z;
+	unsigned char u, v, w;
 	int t[2], s[2], i;
 	unsigned long flags;
 
@@ -155,19 +160,19 @@
 	local_irq_save(flags);
 
 	gameport_trigger(gameport);
-	v = z = gameport_read(gameport);
+	v = gameport_read(gameport);
 
 	do {
-		u = v;
-		w = u ^ (v = x = gameport_read(gameport));
-		for (i = 0; i < 2; i++, w >>= 2, x >>= 2) {
+		w = v ^ (u = gameport_read(gameport));
+		v = u;
+		for (i = 0; i < 2; i++, w >>= 2, u >>= 2) {
 			t[i]--;
 			if ((w & 0x30) && s[i]) {
 				if ((w & 0x30) < 0x30 && adi[i].ret < ADI_MAX_LENGTH && t[i] > 0) {
 					adi[i].data[++adi[i].ret] = w;
 					t[i] = gameport_time(gameport, ADI_MAX_STROBE);
 				} else t[i] = 0;
-			} else if (!(x & 0x30)) s[i] = 1;
+			} else if (!(u & 0x30)) s[i] = 1;
 		}
 	} while (t[0] > 0 || t[1] > 0);
 

