Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264659AbTE1PJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 11:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbTE1PJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 11:09:56 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15634 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264659AbTE1PJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 11:09:45 -0400
Date: Wed, 28 May 2003 16:22:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCMCIA updates
Message-ID: <20030528162257.A12329@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the patch for a set of PCMCIA updates which will shortly be heading
Linus-ward.  As normal, if you want a bk tree to pull, just ask in personal
mail.

<proski@org.rmk.(none)> (03/05/28 1.1127.7.2)
	[PATCH] Fix crash when unloading yenta_socket in Linux 2.5.69
	
	socket->base is unmapped in yenta_close(), which is called by
	cardbus_remove().  The value of socket->base is not changed to
	NULL, so it becomes invalid.
	
	Then cardbus_remove() calls class_device_unregister(), which calls
	pcmcia_unregister_socket(), which it turn tries to access memory
	space of the socket.

<hch@de.rmk.(none)> (03/05/18 1.1127.7.1)
	[PATCH] kill register_pccard_driver
	
	I tried to get as much in as possible through the maintainers but
	didn't get much feedback.. (Except two batches included and Kai
	ACKing the ISDN stuff).
	
	So here's a big patch to move the reamining users over to
	pcmcia_register_driver and kill it off.

diff -Nru a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
--- a/drivers/char/pcmcia/synclink_cs.c	Wed May 28 16:18:29 2003
+++ b/drivers/char/pcmcia/synclink_cs.c	Wed May 28 16:18:30 2003
@@ -3131,9 +3131,18 @@
 	}
 }
 
+static struct pcmcia_driver mgslpc_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "synclink_cs",
+	},
+	.attach		= mgslpc_attach,
+	.detach		= mgslpc_detach,
+};
+
 static int __init synclink_cs_init(void)
 {
-    servinfo_t serv;
+    int error;
 
     if (break_on_load) {
 	    mgslpc_get_text_ptr();
@@ -3142,13 +3151,9 @@
 
     printk("%s %s\n", driver_name, driver_version);
 
-    CardServices(GetCardServicesInfo, &serv);
-    if (serv.Revision != CS_RELEASE_CODE) {
-	    printk(KERN_NOTICE "synclink_cs: Card Services release "
-		   "does not match!\n");
-	    return -1;
-    }
-    register_pccard_driver(&dev_info, &mgslpc_attach, &mgslpc_detach);
+    error = pcmcia_register_driver(&mgslpc_driver);
+    if (error)
+	    return error;
 
     /* Initialize the tty_driver structure */
 	
@@ -3217,7 +3222,9 @@
 		printk("%s(%d) failed to unregister tty driver err=%d\n",
 		       __FILE__,__LINE__,rc);
 
-	unregister_pccard_driver(&dev_info);
+	pcmcia_unregister_driver(&mgslpc_driver);
+
+	/* XXX: this really needs to move into generic code.. */
 	while (dev_list != NULL) {
 		if (dev_list->state & DEV_CONFIG)
 			mgslpc_release((u_long)dev_list);
diff -Nru a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
--- a/drivers/ide/legacy/ide-cs.c	Wed May 28 16:18:30 2003
+++ b/drivers/ide/legacy/ide-cs.c	Wed May 28 16:18:30 2003
@@ -470,28 +470,25 @@
     return 0;
 } /* ide_event */
 
-/*====================================================================*/
+static struct pcmcia_driver ide_cs_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "ide_cs",
+	},
+	.attach		= ide_attach,
+	.detach		= ide_detach,
+};
 
 static int __init init_ide_cs(void)
 {
-    servinfo_t serv;
-    DEBUG(0, "%s\n", version);
-    CardServices(GetCardServicesInfo, &serv);
-    if (serv.Revision != CS_RELEASE_CODE) {
-	printk(KERN_NOTICE "ide-cs: Card Services release "
-	       "does not match!\n");
-	return -EINVAL;
-    }
-    register_pccard_driver(&dev_info, &ide_attach, &ide_detach);
-    return 0;
+	return pcmcia_register_driver(&ide_cs_driver);
 }
 
 static void __exit exit_ide_cs(void)
 {
-    DEBUG(0, "ide-cs: unloading\n");
-    unregister_pccard_driver(&dev_info);
-    while (dev_list != NULL)
-	ide_detach(dev_list);
+	pcmcia_unregister_driver(&ide_cs_driver);
+	while (dev_list != NULL)
+		ide_detach(dev_list);
 }
 
 module_init(init_ide_cs);
diff -Nru a/drivers/isdn/hardware/avm/avm_cs.c b/drivers/isdn/hardware/avm/avm_cs.c
--- a/drivers/isdn/hardware/avm/avm_cs.c	Wed May 28 16:18:29 2003
+++ b/drivers/isdn/hardware/avm/avm_cs.c	Wed May 28 16:18:29 2003
@@ -510,29 +510,30 @@
     return 0;
 } /* avmcs_event */
 
-/*====================================================================*/
+static struct pcmcia_driver avmcs_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "avmcs_cs",
+	},
+	.attach		= avmcs_attach,
+	.detach		= avmcs_detach,
+};
 
 static int __init avmcs_init(void)
 {
-    servinfo_t serv;
-    CardServices(GetCardServicesInfo, &serv);
-    if (serv.Revision != CS_RELEASE_CODE) {
-	printk(KERN_NOTICE "avm_cs: Card Services release "
-	       "does not match!\n");
-	return -1;
-    }
-    register_pccard_driver(&dev_info, &avmcs_attach, &avmcs_detach);
-    return 0;
+	return pcmcia_register_driver(&avmcs_driver);
 }
 
 static void __exit avmcs_exit(void)
 {
-    unregister_pccard_driver(&dev_info);
-    while (dev_list != NULL) {
-	if (dev_list->state & DEV_CONFIG)
-	    avmcs_release((u_long)dev_list);
-	avmcs_detach(dev_list);
-    }
+	pcmcia_unregister_driver(&avmcs_driver);
+
+	/* XXX: this really needs to move into generic code.. */
+	while (dev_list != NULL) {
+		if (dev_list->state & DEV_CONFIG)
+			avmcs_release((u_long)dev_list);
+		avmcs_detach(dev_list);
+	}
 }
 
 module_init(avmcs_init);
diff -Nru a/drivers/isdn/hisax/avma1_cs.c b/drivers/isdn/hisax/avma1_cs.c
--- a/drivers/isdn/hisax/avma1_cs.c	Wed May 28 16:18:30 2003
+++ b/drivers/isdn/hisax/avma1_cs.c	Wed May 28 16:18:30 2003
@@ -515,30 +515,30 @@
     return 0;
 } /* avma1cs_event */
 
-/*====================================================================*/
+static struct pcmcia_driver avma1cs_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "avma1_cs",
+	},
+	.attach		= avma1cs_attach,
+	.detach		= avma1cs_detach,
+};
 
 static int __init init_avma1_cs(void)
 {
-    servinfo_t serv;
-    DEBUG(0, "%s\n", version);
-    CardServices(GetCardServicesInfo, &serv);
-    if (serv.Revision != CS_RELEASE_CODE) {
-        printk(KERN_NOTICE "avma1_cs: Card Services release "
-               "does not match!\n");
-        return -1;
-    }
-    register_pccard_driver(&dev_info, &avma1cs_attach, &avma1cs_detach);
-    return 0;
+	return pcmcia_register_driver(&avma1cs_driver);
 }
 
 static void __exit exit_avma1_cs(void)
 {
-    DEBUG(0, "avma1_cs: unloading\n");
-    unregister_pccard_driver(&dev_info);
-    while (dev_list != NULL)
-	if (dev_list->state & DEV_CONFIG)
-	    avma1cs_release((u_long)dev_list);
-        avma1cs_detach(dev_list);
+	pcmcia_unregister_driver(&avma1cs_driver);
+
+	/* XXX: this really needs to move into generic code.. */
+	while (dev_list != NULL) {
+		if (dev_list->state & DEV_CONFIG)
+			avma1cs_release((u_long)dev_list);
+		avma1cs_detach(dev_list);
+	}
 }
 
 module_init(init_avma1_cs);
diff -Nru a/drivers/isdn/hisax/elsa_cs.c b/drivers/isdn/hisax/elsa_cs.c
--- a/drivers/isdn/hisax/elsa_cs.c	Wed May 28 16:18:30 2003
+++ b/drivers/isdn/hisax/elsa_cs.c	Wed May 28 16:18:30 2003
@@ -531,28 +531,27 @@
     return 0;
 } /* elsa_cs_event */
 
-/*====================================================================*/
+static struct pcmcia_driver elsa_cs_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "elsa_cs",
+	},
+	.attach		= elsa_cs_attach,
+	.detach		= elsa_cs_detach,
+};
 
 static int __init init_elsa_cs(void)
 {
-    servinfo_t serv;
-    DEBUG(0, "%s\n", version);
-    CardServices(GetCardServicesInfo, &serv);
-    if (serv.Revision != CS_RELEASE_CODE) {
-        printk(KERN_NOTICE "elsa_cs: Card Services release "
-               "does not match!\n");
-        return -1;
-    }
-    register_pccard_driver(&dev_info, &elsa_cs_attach, &elsa_cs_detach);
-    return 0;
+	return pcmcia_register_driver(&elsa_cs_driver);
 }
 
 static void __exit exit_elsa_cs(void)
 {
-    DEBUG(0, "elsa_cs: unloading\n");
-    unregister_pccard_driver(&dev_info);
-    while (dev_list != NULL)
-        elsa_cs_detach(dev_list);
+	pcmcia_unregister_driver(&elsa_cs_driver);
+
+	/* XXX: this really needs to move into generic code.. */
+	while (dev_list != NULL)
+		elsa_cs_detach(dev_list);
 }
 
 module_init(init_elsa_cs);
diff -Nru a/drivers/isdn/hisax/sedlbauer_cs.c b/drivers/isdn/hisax/sedlbauer_cs.c
--- a/drivers/isdn/hisax/sedlbauer_cs.c	Wed May 28 16:18:29 2003
+++ b/drivers/isdn/hisax/sedlbauer_cs.c	Wed May 28 16:18:29 2003
@@ -633,34 +633,32 @@
     return 0;
 } /* sedlbauer_event */
 
-/*====================================================================*/
+static struct pcmcia_driver sedlbauer_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "sedlbauer_cs",
+	},
+	.attach		= sedlbauer_attach,
+	.detach		= sedlbauer_detach,
+};
 
 static int __init init_sedlbauer_cs(void)
 {
-    servinfo_t serv;
-    DEBUG(0, "%s\n", version);
-    CardServices(GetCardServicesInfo, &serv);
-    if (serv.Revision != CS_RELEASE_CODE) {
-	printk(KERN_NOTICE "sedlbauer_cs: Card Services release "
-	       "does not match!\n");
-	return -1;
-    }
-    register_pccard_driver(&dev_info, &sedlbauer_attach, &sedlbauer_detach);
-    return 0;
+	return pcmcia_register_driver(&sedlbauer_driver);
 }
 
 static void __exit exit_sedlbauer_cs(void)
 {
-    DEBUG(0, "sedlbauer_cs: unloading\n");
-    unregister_pccard_driver(&dev_info);
-    while (dev_list != NULL) {
-	del_timer(&dev_list->release);
-	if (dev_list->state & DEV_CONFIG)
-	    sedlbauer_release((u_long)dev_list);
-	sedlbauer_detach(dev_list);
-    }
+	pcmcia_unregister_driver(&sedlbauer_driver);
+
+	/* XXX: this really needs to move into generic code.. */
+	while (dev_list != NULL) {
+		del_timer(&dev_list->release);
+		if (dev_list->state & DEV_CONFIG)
+			sedlbauer_release((u_long)dev_list);
+		sedlbauer_detach(dev_list);
+	}
 }
 
 module_init(init_sedlbauer_cs);
 module_exit(exit_sedlbauer_cs);
-
diff -Nru a/drivers/mtd/maps/pcmciamtd.c b/drivers/mtd/maps/pcmciamtd.c
--- a/drivers/mtd/maps/pcmciamtd.c	Wed May 28 16:18:29 2003
+++ b/drivers/mtd/maps/pcmciamtd.c	Wed May 28 16:18:29 2003
@@ -836,17 +836,18 @@
 	return link;
 }
 
+static struct pcmcia_driver pcmciamtd_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "pcmciamtd",
+	},
+	.attach		= pcmciamtd_attach,
+	.detach		= pcmciamtd_detach,
+};
 
 static int __init init_pcmciamtd(void)
 {
-	servinfo_t serv;
-
 	info(DRIVER_DESC " " DRIVER_VERSION);
-	CardServices(GetCardServicesInfo, &serv);
-	if (serv.Revision != CS_RELEASE_CODE) {
-		err("Card Services release does not match!");
-		return -1;
-	}
 
 	if(buswidth && buswidth != 1 && buswidth != 2) {
 		info("bad buswidth (%d), using default", buswidth);
@@ -860,8 +861,8 @@
 		info("bad mem_type (%d), using default", mem_type);
 		mem_type = 0;
 	}
-	register_pccard_driver(&dev_info, &pcmciamtd_attach, &pcmciamtd_detach);
-	return 0;
+
+	return pcmcia_register_driver(&pcmciamtd_driver);
 }
 
 
@@ -870,7 +871,10 @@
 	struct list_head *temp1, *temp2;
 
 	DEBUG(1, DRIVER_DESC " unloading");
-	unregister_pccard_driver(&dev_info);
+
+	pcmcia_unregister_driver(&pcmciamtd_driver);
+
+	/* XXX: this really needs to move into generic code.. */
 	list_for_each_safe(temp1, temp2, &dev_list) {
 		dev_link_t *link = &list_entry(temp1, struct pcmciamtd_dev, list)->link;
 		if (link && (link->state & DEV_CONFIG)) {
diff -Nru a/drivers/net/pcmcia/pcnet_cs.c b/drivers/net/pcmcia/pcnet_cs.c
--- a/drivers/net/pcmcia/pcnet_cs.c	Wed May 28 16:18:30 2003
+++ b/drivers/net/pcmcia/pcnet_cs.c	Wed May 28 16:18:30 2003
@@ -1620,16 +1620,7 @@
 
 static int __init init_pcnet_cs(void)
 {
-    servinfo_t serv;
-    DEBUG(0, "%s\n", version);
-    CardServices(GetCardServicesInfo, &serv);
-    if (serv.Revision != CS_RELEASE_CODE) {
-	printk(KERN_NOTICE "pcnet_cs: Card Services release "
-	       "does not match!\n");
-	return -EINVAL;
-    }
-    pcmcia_register_driver(&pcnet_driver);
-    return 0;
+    return pcmcia_register_driver(&pcnet_driver);
 }
 
 static void __exit exit_pcnet_cs(void)
diff -Nru a/drivers/parport/parport_cs.c b/drivers/parport/parport_cs.c
--- a/drivers/parport/parport_cs.c	Wed May 28 16:18:31 2003
+++ b/drivers/parport/parport_cs.c	Wed May 28 16:18:31 2003
@@ -390,28 +390,27 @@
     return 0;
 } /* parport_event */
 
-/*====================================================================*/
+static struct pcmcia_driver parport_cs_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "parport_cs",
+	},
+	.attach		= parport_attach,
+	.detach		= parport_detach,
+};
 
 static int __init init_parport_cs(void)
 {
-    servinfo_t serv;
-    DEBUG(0, "%s\n", version);
-    CardServices(GetCardServicesInfo, &serv);
-    if (serv.Revision != CS_RELEASE_CODE) {
-	printk(KERN_NOTICE "parport_cs: Card Services release "
-	       "does not match!\n");
-	return -EINVAL;
-    }
-    register_pccard_driver(&dev_info, &parport_attach, &parport_detach);
-    return 0;
+	return pcmcia_register_driver(&parport_cs_driver);
 }
 
 static void __exit exit_parport_cs(void)
 {
-    DEBUG(0, "parport_cs: unloading\n");
-    unregister_pccard_driver(&dev_info);
-    while (dev_list != NULL)
-	parport_detach(dev_list);
+	pcmcia_unregister_driver(&parport_cs_driver);
+
+	/* XXX: this really needs to move into generic code.. */
+	while (dev_list != NULL)
+		parport_detach(dev_list);
 }
 
 module_init(init_parport_cs);
diff -Nru a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
--- a/drivers/pcmcia/ds.c	Wed May 28 16:18:30 2003
+++ b/drivers/pcmcia/ds.c	Wed May 28 16:18:30 2003
@@ -182,50 +182,6 @@
 }
 EXPORT_SYMBOL(pcmcia_unregister_driver);
 
-
-int register_pccard_driver(dev_info_t *dev_info,
-			   dev_link_t *(*attach)(void),
-			   void (*detach)(dev_link_t *))
-{
-    struct pcmcia_driver *driver;
-
-    DEBUG(0, "ds: register_pccard_driver('%s')\n", (char *)dev_info);
-    driver = get_pcmcia_driver(dev_info);
-    if (driver)
-	    return -EBUSY;
-
-    driver = kmalloc(sizeof(struct pcmcia_driver), GFP_KERNEL);
-    if (!driver) return -ENOMEM;
-    memset(driver, 0, sizeof(struct pcmcia_driver));
-    driver->drv.name = (char *)dev_info;
-    pcmcia_register_driver(driver);
-
-    driver->attach = attach;
-    driver->detach = detach;
-
-    return 0;
-} /* register_pccard_driver */
-
-/*====================================================================*/
-
-int unregister_pccard_driver(dev_info_t *dev_info)
-{
-    struct pcmcia_driver *driver;
-
-    DEBUG(0, "ds: unregister_pccard_driver('%s')\n",
-	  (char *)dev_info);
-
-    driver = get_pcmcia_driver(dev_info);
-    if (!driver)
-	return -ENODEV;
-    
-    pcmcia_unregister_driver(driver);
-    kfree(driver);
-    return 0;
-} /* unregister_pccard_driver */
-
-/*====================================================================*/
-
 #ifdef CONFIG_PROC_FS
 static int proc_read_drivers_callback(struct device_driver *driver, void *d)
 {
@@ -875,11 +831,6 @@
 	.write		= ds_write,
 	.poll		= ds_poll,
 };
-
-EXPORT_SYMBOL(register_pccard_driver);
-EXPORT_SYMBOL(unregister_pccard_driver);
-
-/*====================================================================*/
 
 static int __devinit pcmcia_bus_add_socket(struct device *dev, unsigned int socket_nr)
 {
diff -Nru a/drivers/pcmcia/pci_socket.c b/drivers/pcmcia/pci_socket.c
--- a/drivers/pcmcia/pci_socket.c	Wed May 28 16:18:31 2003
+++ b/drivers/pcmcia/pci_socket.c	Wed May 28 16:18:31 2003
@@ -196,9 +196,9 @@
 	pci_socket_t *socket = pci_get_drvdata(dev);
 
 	/* note: we are already unregistered from the cs core */
+	class_device_unregister(&socket->cls_d.class_dev);
 	if (socket->op && socket->op->close)
 		socket->op->close(socket);
-	class_device_unregister(&socket->cls_d.class_dev);
 	pci_set_drvdata(dev, NULL);
 }
 
diff -Nru a/include/pcmcia/ds.h b/include/pcmcia/ds.h
--- a/include/pcmcia/ds.h	Wed May 28 16:18:29 2003
+++ b/include/pcmcia/ds.h	Wed May 28 16:18:29 2003
@@ -156,12 +156,6 @@
 int pcmcia_register_driver(struct pcmcia_driver *driver);
 void pcmcia_unregister_driver(struct pcmcia_driver *driver);
 
-/* legacy driver registration interface.  don't use in new code */
-int register_pccard_driver(dev_info_t *dev_info,
-			   dev_link_t *(*attach)(void),
-			   void (*detach)(dev_link_t *));
-int unregister_pccard_driver(dev_info_t *dev_info);
-
 /* error reporting */
 void cs_error(client_handle_t handle, int func, int ret);
 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

