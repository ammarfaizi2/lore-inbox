Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263336AbTC0RZX>; Thu, 27 Mar 2003 12:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263329AbTC0RYV>; Thu, 27 Mar 2003 12:24:21 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:18409 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263336AbTC0RXz>; Thu, 27 Mar 2003 12:23:55 -0500
Date: Thu, 27 Mar 2003 18:32:45 +0100
From: Dominik Brodowski <linux@brodo.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia: fix pcmcia_bind_driver
Message-ID: <20030327173245.GA1344@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow "bind_request" to be called before "register_pccard_driver".

	Dominik

diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-27 18:21:51.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-27 18:25:36.000000000 +0100
@@ -188,35 +188,21 @@
 			   void (*detach)(dev_link_t *))
 {
     struct pcmcia_driver *driver;
-    socket_bind_t *b;
-    struct pcmcia_bus_socket *bus_sock;
 
     DEBUG(0, "ds: register_pccard_driver('%s')\n", (char *)dev_info);
     driver = get_pcmcia_driver(dev_info);
-    if (!driver) {
-	driver = kmalloc(sizeof(struct pcmcia_driver), GFP_KERNEL);
-	if (!driver) return -ENOMEM;
-	memset(driver, 0, sizeof(struct pcmcia_driver));
-	driver->drv.name = (char *)dev_info;
-	pcmcia_register_driver(driver);
-    }
+    if (driver)
+	    return -EBUSY;
+
+    driver = kmalloc(sizeof(struct pcmcia_driver), GFP_KERNEL);
+    if (!driver) return -ENOMEM;
+    memset(driver, 0, sizeof(struct pcmcia_driver));
+    driver->drv.name = (char *)dev_info;
+    pcmcia_register_driver(driver);
 
     driver->attach = attach;
     driver->detach = detach;
-    if (driver->use_count == 0) return 0;
-    
-    /* Instantiate any already-bound devices */
-    down_read(&bus_socket_list_rwsem);
-    list_for_each_entry(bus_sock, &bus_socket_list, socket_list) {
-	for (b = bus_sock->bind; b; b = b->next) {
-	    if (b->driver != driver) continue;
-	    b->instance = driver->attach();
-	    if (b->instance == NULL)
-		printk(KERN_NOTICE "ds: unable to create instance "
-		       "of '%s'!\n", driver->drv.name);
-	}
-    }
-    up_read(&bus_socket_list_rwsem);
+
     return 0;
 } /* register_pccard_driver */
 
@@ -414,13 +400,8 @@
     DEBUG(2, "bind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
     driver = get_pcmcia_driver(&bind_info->dev_info);
-    if (driver == NULL) {
-	driver = kmalloc(sizeof(struct pcmcia_driver), GFP_KERNEL);
-	if (!driver) return -ENOMEM;
-	memset(driver, 0, sizeof(struct pcmcia_driver));
-	driver->drv.name = bind_info->dev_info;
-	pcmcia_register_driver(driver);
-    }
+    if (!driver)
+	    return -EINVAL;
 
     for (b = s->bind; b; b = b->next)
 	if ((driver == b->driver) &&
