Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265342AbUAAJNg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 04:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265343AbUAAJNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 04:13:36 -0500
Received: from mail.contactel.cz ([212.65.193.9]:59550 "EHLO mail.contactel.cz")
	by vger.kernel.org with ESMTP id S265342AbUAAJN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 04:13:28 -0500
Date: Thu, 1 Jan 2004 10:12:26 +0100
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-joystick@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6] ns558.c check_region -> request_region
Message-ID: <20040101091226.GA1108@penguin.localdomain>
Mail-Followup-To: vojtech@suse.cz, linux-kernel@vger.kernel.org,
	linux-joystick@atrey.karlin.mff.cuni.cz
References: <20031231215857.GB745@penguin.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231215857.GB745@penguin.localdomain>
User-Agent: Mutt/1.5.4i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 10:58:57PM +0100, Marcel Sebek wrote:
> 
> This patch modifies ns558.c to use request_region instead of
> check_region:
> 
> 

The old version doesn't release region before requesting for new.
Here's an updated patch:



diff -urN linux-2.6/drivers/input/gameport/ns558.c linux-2.6-new/drivers/input/gameport/ns558.c
--- linux-2.6/drivers/input/gameport/ns558.c	2003-08-23 13:57:35.000000000 +0200
+++ linux-2.6-new/drivers/input/gameport/ns558.c	2004-01-01 10:06:23.000000000 +0100
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

-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

