Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267337AbSLKW1O>; Wed, 11 Dec 2002 17:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbSLKW1O>; Wed, 11 Dec 2002 17:27:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:49636 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267337AbSLKW1C>;
	Wed, 11 Dec 2002 17:27:02 -0500
Message-ID: <3DF7BD7F.85C6FEA0@digeo.com>
Date: Wed, 11 Dec 2002 14:34:39 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Schaufler <andreas.schaufler@gmx.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NFS mounted rootfs possible via PCMCIA NIC ?
References: <200212112253.57325.andreas.schaufler@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2002 22:34:40.0142 (UTC) FILETIME=[7E3BEAE0:01C2A165]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schaufler wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello list,
> 
> I am trying to configure a notebook with a PCMCIA NIC to boot over network.
> (kernel 2.4.20)

Nope.  The kernel does the NFS thing before bringing up cardbus.

This patch worked, back in the 2.4.17 days.  It also fixes some
cardbus bugs.  I don't immediately recall what they were.




 drivers/pcmcia/Makefile |    3 +
 drivers/pcmcia/ds.c     |   13 ++-----
 drivers/pcmcia/yenta.c  |   85 ++++++++++++++++++++++--------------------------
 init/main.c             |    3 -
 4 files changed, 45 insertions(+), 59 deletions(-)

--- 24/drivers/pcmcia/ds.c~pcmcia-ip-autoconf	Wed Dec 11 14:30:56 2002
+++ 24-akpm/drivers/pcmcia/ds.c	Wed Dec 11 14:30:56 2002
@@ -968,14 +968,7 @@ int __init init_pcmcia_ds(void)
     return 0;
 }
 
-#ifdef MODULE
-
-int __init init_module(void)
-{
-    return init_pcmcia_ds();
-}
-
-void __exit cleanup_module(void)
+void __exit cleanup_pcmcia_ds(void)
 {
     int i;
 #ifdef CONFIG_PROC_FS
@@ -990,4 +983,6 @@ void __exit cleanup_module(void)
     kfree(socket_table);
 }
 
-#endif
+module_init(init_pcmcia_ds);
+module_exit(cleanup_pcmcia_ds);
+
--- 24/drivers/pcmcia/Makefile~pcmcia-ip-autoconf	Wed Dec 11 14:30:56 2002
+++ 24-akpm/drivers/pcmcia/Makefile	Wed Dec 11 14:30:56 2002
@@ -22,7 +22,7 @@ ifeq ($(CONFIG_CARDBUS),y)
 endif
 
 ifeq ($(CONFIG_PCMCIA),y)
-  obj-y   := cistpl.o rsrc_mgr.o bulkmem.o ds.o cs.o
+  obj-y   := cistpl.o rsrc_mgr.o bulkmem.o cs.o
   ifeq ($(CONFIG_CARDBUS),y)
     obj-y += cardbus.o yenta.o pci_socket.o
   endif
@@ -38,6 +38,7 @@ ifeq ($(CONFIG_PCMCIA),y)
   ifeq ($(CONFIG_HD64465_PCMCIA),y)
     obj-y += hd64465_ss.o
   endif
+  obj-y   += ds.o
 else
   ifeq ($(CONFIG_PCMCIA),m)
     obj-m   := pcmcia_core.o ds.o
--- 24/drivers/pcmcia/yenta.c~pcmcia-ip-autoconf	Wed Dec 11 14:30:56 2002
+++ 24-akpm/drivers/pcmcia/yenta.c	Wed Dec 11 14:30:56 2002
@@ -574,38 +574,6 @@ static void yenta_get_socket_capabilitie
 	printk("Yenta IRQ list %04x, PCI irq%d\n", socket->cap.irq_mask, socket->cb_irq);
 }
 
-extern void cardbus_register(pci_socket_t *socket);
-
-/*
- * 'Bottom half' for the yenta_open routine. Allocate the interrupt line
- *  and register the socket with the upper layers.
- */
-static void yenta_open_bh(void * data)
-{
-	pci_socket_t * socket = (pci_socket_t *) data;
-
-	/* It's OK to overwrite this now */
-	socket->tq_task.routine = yenta_bh;
-
-	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->name, socket)) {
-		/* No IRQ or request_irq failed. Poll */
-		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
-		socket->poll_timer.function = yenta_interrupt_wrapper;
-		socket->poll_timer.data = (unsigned long)socket;
-		socket->poll_timer.expires = jiffies + HZ;
-		add_timer(&socket->poll_timer);
-	}
-
-	/* Figure out what the dang thing can do for the PCMCIA layer... */
-	yenta_get_socket_capabilities(socket, isa_interrupts);
-	printk("Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));
-
-	/* Register it with the pcmcia layer.. */
-	cardbus_register(socket);
-
-	MOD_DEC_USE_COUNT;
-}
-
 static void yenta_clear_maps(pci_socket_t *socket)
 {
 	int i;
@@ -823,6 +791,8 @@ static struct cardbus_override_struct {
 
 #define NR_OVERRIDES (sizeof(cardbus_override)/sizeof(struct cardbus_override_struct))
 
+extern void cardbus_register(pci_socket_t *socket);
+
 /*
  * Initialize a cardbus controller. Make sure we have a usable
  * interrupt, and that we can map the cardbus area. Fill in the
@@ -832,15 +802,19 @@ static int yenta_open(pci_socket_t *sock
 {
 	int i;
 	struct pci_dev *dev = socket->dev;
+	int retval = -1;
+	int polling = 0;
+
+	MOD_INC_USE_COUNT;
 
 	/*
 	 * Do some basic sanity checking..
 	 */
 	if (pci_enable_device(dev))
-		return -1;
+		goto fail;
 	if (!pci_resource_start(dev, 0)) {
 		printk("No cardbus resource!\n");
-		return -1;
+		goto fail;
 	}
 
 	/*
@@ -849,7 +823,7 @@ static int yenta_open(pci_socket_t *sock
 	 */
 	socket->base = ioremap(pci_resource_start(dev, 0), 0x1000);
 	if (!socket->base)
-		return -1;
+		goto fail;
 
 	yenta_config_init(socket);
 
@@ -867,24 +841,43 @@ static int yenta_open(pci_socket_t *sock
 		if (dev->vendor == d->vendor && dev->device == d->device) {
 			socket->op = d->op;
 			if (d->op->open) {
-				int retval = d->op->open(socket);
-				if (retval < 0)
-					return retval;
+				int ret = d->op->open(socket);
+				if (ret < 0) {
+					iounmap(socket->base);
+					retval = ret;
+					goto fail;
+				}
 			}
 		}
 	}
 
-	/* Get the PCMCIA kernel thread to complete the
-	   initialisation later. We can't do this here,
-	   because, er, because Linus says so :)
-	*/
-	socket->tq_task.routine = yenta_open_bh;
+	socket->tq_task.routine = yenta_bh;
 	socket->tq_task.data = socket;
 
-	MOD_INC_USE_COUNT;
-	schedule_task(&socket->tq_task);
+	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt,
+				SA_SHIRQ, socket->dev->name, socket)) {
+		/* No IRQ or request_irq failed. Poll */
+		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
+		socket->poll_timer.function = yenta_interrupt_wrapper;
+		socket->poll_timer.data = (unsigned long)socket;
+		socket->poll_timer.expires = jiffies + HZ;
+		polling = 1;
+	}
 
-	return 0;
+	/* Figure out what the dang thing can do for the PCMCIA layer... */
+	yenta_get_socket_capabilities(socket, isa_interrupts);
+	printk("Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));
+
+	/* Register it with the pcmcia layer.. */
+	cardbus_register(socket);
+
+	if (polling)
+		add_timer(&socket->poll_timer);
+
+	retval = 0;
+fail:
+	MOD_DEC_USE_COUNT;
+	return retval;
 }
 
 /*
--- 24/init/main.c~pcmcia-ip-autoconf	Wed Dec 11 14:30:56 2002
+++ 24-akpm/init/main.c	Wed Dec 11 14:30:56 2002
@@ -533,9 +533,6 @@ static void __init do_basic_setup(void)
 	irda_proto_init();
 	irda_device_init(); /* Must be done after protocol initialization */
 #endif
-#ifdef CONFIG_PCMCIA
-	init_pcmcia_ds();		/* Do this last */
-#endif
 }
 
 extern void prepare_namespace(void);

_
