Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbTLaWDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 17:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265231AbTLaWDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 17:03:42 -0500
Received: from mail.contactel.cz ([212.65.193.9]:36748 "EHLO mail.contactel.cz")
	by vger.kernel.org with ESMTP id S265263AbTLaWDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 17:03:35 -0500
Date: Wed, 31 Dec 2003 22:58:57 +0100
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-joystick@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2.6] ns558.c check_region -> request_region
Message-ID: <20031231215857.GB745@penguin.localdomain>
Mail-Followup-To: vojtech@suse.cz, linux-kernel@vger.kernel.org,
	linux-joystick@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch modifies ns558.c to use request_region instead of
check_region:


diff -urN linux-2.6/drivers/input/gameport/ns558.c linux-2.6-new/drivers/input/gameport/ns558.c
--- linux-2.6/drivers/input/gameport/ns558.c	2003-08-23 13:57:35.000000000 +0200
+++ linux-2.6-new/drivers/input/gameport/ns558.c	2003-12-31 22:27:40.000000000 +0100
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
@@ -118,7 +121,7 @@
 
 	for (i = 1; i < 5; i++) {
 
-		if (check_region(io & (-1 << i), (1 << i)))	/* Don't disturb anyone */
+		if (!request_region(io & (-1 << i), (1 << i), "ns558-isa"))	/* Don't disturb anyone */
 			break;
 
 		outb(0xff, io & (-1 << i));
@@ -126,15 +129,19 @@
 			if (inb(io & (-1 << i)) != inb((io & (-1 << i)) + (1 << i) - 1)) b++;
 		wait_ms(3);
 
-		if (b > 300)					/* We allow 30% difference */
+		if (b > 300) {					/* We allow 30% difference */
+			release_region(io & (-1 << i), (1 << i));
 			break;
+		}
+
+		release_region(io & (-1 << (i-1)), (1 << (i-1)));
 	}
 
 	i--;
 
 	if (!(port = kmalloc(sizeof(struct ns558), GFP_KERNEL))) {
 		printk(KERN_ERR "ns558: Memory allocation failed.\n");
-		return;
+		goto out;
 	}
        	memset(port, 0, sizeof(struct ns558));
 	
@@ -148,8 +155,6 @@
 	sprintf(port->phys, "isa%04x/gameport0", io & (-1 << i));
 	sprintf(port->name, "NS558 ISA");
 
-	request_region(io & (-1 << i), (1 << i), "ns558-isa");
-
 	gameport_register_port(&port->gameport);
 
 	printk(KERN_INFO "gameport: NS558 ISA at %#x", port->gameport.io);
@@ -157,6 +162,9 @@
 	printk(" speed %d kHz\n", port->gameport.speed);
 
 	list_add(&port->node, &ns558_list);
+	return;
+out:
+	release_region(io & (-1 << i), (1 << i));
 }
 
 #ifdef CONFIG_PNP


-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

