Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264518AbTLGUzs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTLGUyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:54:44 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.20]:41793 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S264527AbTLGUxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:53:53 -0500
Date: Sun, 7 Dec 2003 21:49:39 +0100
Message-Id: <200312072049.hB7KndJ1000690@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 127] Mac ADB IOP fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac ADB IOP: Fix improperly initialized request struct in the reset code,
causing a bogus pointer (from Matthias Urlichs in 2.6.0)

--- linux-2.4.23/drivers/macintosh/adb-iop.c	Wed Feb 16 07:39:01 2000
+++ linux-m68k-2.4.23/drivers/macintosh/adb-iop.c	Mon Oct 20 21:45:29 2003
@@ -106,6 +106,9 @@
 	struct adb_iopmsg *amsg = (struct adb_iopmsg *) msg->message;
 	struct adb_request *req;
 	uint flags;
+#ifdef DEBUG_ADB_IOP
+	int i;
+#endif
 
 	save_flags(flags);
 	cli();
@@ -113,12 +116,10 @@
 	req = current_req;
 
 #ifdef DEBUG_ADB_IOP
-	printk("adb_iop_listen: rcvd packet, %d bytes: %02X %02X",
+	printk("adb_iop_listen %p: rcvd packet, %d bytes: %02X %02X", req,
 		(uint) amsg->count + 2, (uint) amsg->flags, (uint) amsg->cmd);
-	i = 0;
-	while (i < amsg->count) {
-		printk(" %02X", (uint) amsg->data[i++]);
-	}
+	for (i = 0; i < amsg->count; i++)
+		printk(" %02X", (uint) amsg->data[i]);
 	printk("\n");
 #endif
 
@@ -136,7 +137,7 @@
 			adb_iop_end_req(req, idle);
 		}
 	} else {
-		/* TODO: is it possible for more tha one chunk of data  */
+		/* TODO: is it possible for more than one chunk of data  */
 		/*       to arrive before the timeout? If so we need to */
 		/*       use reply_ptr here like the other drivers do.  */
 		if ((adb_iop_state == awaiting_reply) &&
@@ -165,6 +166,9 @@
 	unsigned long flags;
 	struct adb_request *req;
 	struct adb_iopmsg amsg;
+#ifdef DEBUG_ADB_IOP
+	int i;
+#endif
 
 	/* get the packet to send */
 	req = current_req;
@@ -174,7 +178,7 @@
 	cli();
 
 #ifdef DEBUG_ADB_IOP
-	printk("adb_iop_start: sending packet, %d bytes:", req->nbytes);
+	printk("adb_iop_start %p: sending packet, %d bytes:", req, req->nbytes);
 	for (i = 0 ; i < req->nbytes ; i++)
 		printk(" %02X", (uint) req->data[i]);
 	printk("\n");
@@ -271,13 +275,17 @@
 
 int adb_iop_reset_bus(void)
 {
-	struct adb_request req;
+	struct adb_request req = {
+		.reply_expected = 0,
+		.nbytes = 2,
+		.data = { ADB_PACKET, 0 },
+	};
 
-	req.reply_expected = 0;
-	req.nbytes = 2;
-	req.data[0] = ADB_PACKET;
-	req.data[1] = 0; /* RESET */
 	adb_iop_write(&req);
-	while (!req.complete) adb_iop_poll();
+	while (!req.complete) {
+		adb_iop_poll();
+		schedule();
+	}
+
 	return 0;
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
