Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287919AbSAMGVl>; Sun, 13 Jan 2002 01:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287924AbSAMGVc>; Sun, 13 Jan 2002 01:21:32 -0500
Received: from ohiper1-140.apex.net ([209.250.47.155]:31503 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S287919AbSAMGVY>; Sun, 13 Jan 2002 01:21:24 -0500
Date: Sun, 13 Jan 2002 00:21:15 -0600
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] (2/3) unchecked request_region's in drivers/net
Message-ID: <20020113002115.B26730@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 12:14am  up 4 days,  6:43,  1 user,  load average: 1.02, 1.03, 1.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches were approved by their respective maintainers, and can
hopefully be assumed to be bugfree (or at least introduce no new bugs).

The next message will have patches for drivers whose maintainers didn't
respond, and should be eyed carefully.

Andrew, hopefully I've fixed all the errors you adeptly found.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns

--- linux/drivers/net/arcnet/com90io.c~	Sat Jan 12 23:33:14 2002
+++ linux/drivers/net/arcnet/com90io.c	Sat Jan 12 23:34:03 2002
@@ -241,7 +241,10 @@
 		return -ENODEV;
 	}
 	/* Reserve the I/O region - guaranteed to work by check_region */
-	request_region(dev->base_addr, ARCNET_TOTAL_SIZE, "arcnet (COM90xx-IO)");
+	if (!request_region(dev->base_addr, ARCNET_TOTAL_SIZE, "arcnet (COM90xx-IO)")) {
+		free_irq(dev->irq, dev);
+		return -EBUSY;
+	}
 
 	/* Initialize the rest of the device structure. */
 	dev->priv = kmalloc(sizeof(struct arcnet_local), GFP_KERNEL);
--- linux/drivers/net/sb1000.c~	Sat Jan 12 23:36:00 2002
+++ linux/drivers/net/sb1000.c	Sat Jan 12 23:42:58 2002
@@ -204,7 +204,12 @@
 		/*
 		 *	Ok set it up.
 		 */
-		 
+		if (!request_region(ioaddr[0], 16, dev->name))
+			continue;
+		if (!request_region(ioaddr[1], 16, dev->name)) {
+			release_region(ioaddr[0], 16);
+			continue;
+		}
 		 
 		dev->base_addr = ioaddr[0];
 		/* rmem_end holds the second I/O address - fv */
@@ -262,9 +267,6 @@
 
 		/* Lock resources */
 
-		request_region(ioaddr[0], 16, dev->name);
-		request_region(ioaddr[1], 16, dev->name);
-
 		return 0;
 	}
 }
@@ -962,8 +964,6 @@
 	/* rmem_end holds the second I/O address - fv */
 	ioaddr[1] = dev->rmem_end;
 	name = dev->name;
-	request_region(ioaddr[0], SB1000_IO_EXTENT, "sb1000");
-	request_region(ioaddr[1], SB1000_IO_EXTENT, "sb1000");
 
 	/* initialize sb1000 */
 	if ((status = sb1000_reset(ioaddr, name)))
diff -Nru clean-2.4.17//drivers/net/wan/sealevel.c linux/drivers/net/wan/sealevel.c
--- clean-2.4.17//drivers/net/wan/sealevel.c	Mon Nov  5 19:23:14 2001
+++ linux/drivers/net/wan/sealevel.c	Thu Dec 27 14:18:21 2001
@@ -219,12 +219,11 @@
 	 *	Get the needed I/O space
 	 */
 	 
-	if(check_region(iobase, 8))
+	if(!request_region(iobase, 8, "Sealevel 4021"))
 	{	
 		printk(KERN_WARNING "sealevel: I/O 0x%X already in use.\n", iobase);
 		return NULL;
 	}
-	request_region(iobase, 8, "Sealevel 4021");
 	
 	b=(struct slvl_board *)kmalloc(sizeof(struct slvl_board), GFP_KERNEL);
 	if(!b)
