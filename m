Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbUCPOrO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUCPOnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:43:47 -0500
Received: from styx.suse.cz ([82.208.2.94]:56449 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261865AbUCPOTg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:36 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467763238@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 7/44] request_region() instead of check_region() in ns558.c
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:36 +0100
In-Reply-To: <1079446776360@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1474.188.7, 2004-01-26 13:25:57+01:00, sebek64@post.cz
  input: Use request_region() instead of check_region() in ns558.c
         it's both safer and correct.


 ns558.c |   35 ++++++++++++++++++++++++-----------
 1 files changed, 24 insertions(+), 11 deletions(-)

===================================================================

diff -Nru a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns558.c
--- a/drivers/input/gameport/ns558.c	Tue Mar 16 13:19:54 2004
+++ b/drivers/input/gameport/ns558.c	Tue Mar 16 13:19:54 2004
@@ -77,7 +77,7 @@
  * No one should be using this address.
  */
 
-	if (check_region(io, 1))
+	if (!request_region(io, 1, "ns558-isa"))
 		return;
 
 /*
@@ -89,7 +89,8 @@
 	outb(~c & ~3, io);
 	if (~(u = v = inb(io)) & 3) {
 		outb(c, io);
-		return;
+		i = 0;
+		goto out;
 	}
 /*
  * After a trigger, there must be at least some bits changing.
@@ -99,7 +100,8 @@
 
 	if (u == v) {
 		outb(c, io);
-		return;
+		i = 0;
+		goto out;
 	}
 	wait_ms(3);
 /*
@@ -110,7 +112,8 @@
 	for (i = 0; i < 1000; i++)
 		if ((u ^ inb(io)) & 0xf) {
 			outb(c, io);
-			return;
+			i = 0;
+			goto out;
 		}
 /* 
  * And now find the number of mirrors of the port.
@@ -118,7 +121,9 @@
 
 	for (i = 1; i < 5; i++) {
 
-		if (check_region(io & (-1 << i), (1 << i)))	/* Don't disturb anyone */
+		release_region(io & (-1 << (i-1)), (1 << (i-1)));
+
+		if (!request_region(io & (-1 << i), (1 << i), "ns558-isa"))	/* Don't disturb anyone */
 			break;
 
 		outb(0xff, io & (-1 << i));
@@ -126,18 +131,25 @@
 			if (inb(io & (-1 << i)) != inb((io & (-1 << i)) + (1 << i) - 1)) b++;
 		wait_ms(3);
 
-		if (b > 300)					/* We allow 30% difference */
+		if (b > 300) {					/* We allow 30% difference */
+			release_region(io & (-1 << i), (1 << i));
 			break;
+		}
 	}
 
 	i--;
 
+	if (i != 4) {
+		if (!request_region(io & (-1 << i), (1 << i), "ns558-isa"))
+			return;
+	}
+
 	if (!(port = kmalloc(sizeof(struct ns558), GFP_KERNEL))) {
 		printk(KERN_ERR "ns558: Memory allocation failed.\n");
-		return;
+		goto out;
 	}
-       	memset(port, 0, sizeof(struct ns558));
-	
+	memset(port, 0, sizeof(struct ns558));
+
 	port->type = NS558_ISA;
 	port->size = (1 << i);
 	port->gameport.io = io;
@@ -148,8 +160,6 @@
 	sprintf(port->phys, "isa%04x/gameport0", io & (-1 << i));
 	sprintf(port->name, "NS558 ISA");
 
-	request_region(io & (-1 << i), (1 << i), "ns558-isa");
-
 	gameport_register_port(&port->gameport);
 
 	printk(KERN_INFO "gameport: NS558 ISA at %#x", port->gameport.io);
@@ -157,6 +167,9 @@
 	printk(" speed %d kHz\n", port->gameport.speed);
 
 	list_add(&port->node, &ns558_list);
+	return;
+out:
+	release_region(io & (-1 << i), (1 << i));
 }
 
 #ifdef CONFIG_PNP

