Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278652AbRJSU4i>; Fri, 19 Oct 2001 16:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278658AbRJSU42>; Fri, 19 Oct 2001 16:56:28 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:53001 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S278652AbRJSU4K>; Fri, 19 Oct 2001 16:56:10 -0400
Message-ID: <3BD092A6.26A1CFE9@zip.com.au>
Date: Fri, 19 Oct 2001 13:52:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, David Hinds <dhinds@sonic.net>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [patch] ip autoconfig for PCMCIA NICs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that ip autoconf doesn't work for cardbus NICs at present
because of an ordering problem.  The call to init_pcmcia_ds() in
init/main.c comes after the ip-autoconf initcall has run. So of course,
autoconf complains that there are no network devices available.

This patch moves ds initialisation out of do_basic_setup() and into an
initcall.  The pcmcia makefile is shuffled so that the ds.c initcall
comes at the end of pcmcia initialisation.

This all works fine.  However it probably breaks something, but the rather
unilluminating comment

#ifdef CONFIG_PCMCIA
        init_pcmcia_ds();               /* Do this last */
#endif

doesn't tell us what.

Also, yenta_open() currently defers device initialisation to keventd,
so there is a good chance that cardbus init hasn't completed by the
time we hit ip autoconf, so the yenta_open_bh functionality is made
synchronous.

yenta_open() is changed so that it has a single exit point.  An error-path
leak in yenta_open() is fixed - missing an iounmap().   The module
refcount handling in yenta_open() is changed to make it less racy.  The
registration of the polling timer in yenta_open_bh() is moved so that it
happens after the socket initialisation, to avoid running the poll timer
in the middle of initialisation.

Patch works fine for me, and is tested with modular PCMCIA
support as well.  But what does it break?

Now, every time I try to understand the relationship between socket
services, card services, socket drivers and driver services my brain
bursts.  Could some kind soul please what these things do, and how
they fit together?   Thanks.



--- linux-2.4.12-ac3/init/main.c	Mon Oct 15 16:04:25 2001
+++ ac/init/main.c	Fri Oct 19 12:20:17 2001
@@ -839,9 +839,6 @@ static void __init do_basic_setup(void)
 	irda_proto_init();
 	irda_device_init(); /* Must be done after protocol initialization */
 #endif
-#ifdef CONFIG_PCMCIA
-	init_pcmcia_ds();		/* Do this last */
-#endif
 }
 
 extern void rd_load(void);
--- linux-2.4.12-ac3/drivers/pcmcia/Makefile	Mon Oct 15 16:04:24 2001
+++ ac/drivers/pcmcia/Makefile	Fri Oct 19 12:20:17 2001
@@ -22,7 +22,7 @@ ifeq ($(CONFIG_CARDBUS),y)
 endif
 
 ifeq ($(CONFIG_PCMCIA),y)
-  obj-y   := cistpl.o rsrc_mgr.o bulkmem.o ds.o cs.o
+  obj-y   := cistpl.o rsrc_mgr.o bulkmem.o cs.o
   ifeq ($(CONFIG_CARDBUS),y)
     obj-y += cardbus.o cb_enabler.o yenta.o pci_socket.o
   endif
@@ -35,6 +35,7 @@ ifeq ($(CONFIG_PCMCIA),y)
   ifeq ($(CONFIG_HD64465_PCMCIA),y)
     obj-y += hd64465_ss.o
   endif
+  obj-y   += ds.o
 else
   ifeq ($(CONFIG_PCMCIA),m)
     obj-m   := pcmcia_core.o ds.o
--- linux-2.4.12-ac3/drivers/pcmcia/ds.c	Mon Oct 15 16:04:24 2001
+++ ac/drivers/pcmcia/ds.c	Fri Oct 19 12:20:17 2001
@@ -964,14 +964,7 @@ int __init init_pcmcia_ds(void)
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
@@ -986,4 +979,6 @@ void __exit cleanup_module(void)
     kfree(socket_table);
 }
 
-#endif
+module_init(init_pcmcia_ds);
+module_exit(cleanup_pcmcia_ds);
+
--- linux-2.4.12-ac3/drivers/pcmcia/yenta.c	Tue Oct  9 21:31:39 2001
+++ ac/drivers/pcmcia/yenta.c	Fri Oct 19 13:00:51 2001
@@ -571,38 +571,6 @@ static void yenta_get_socket_capabilitie
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
@@ -813,6 +781,8 @@ static struct cardbus_override_struct {
 
 #define NR_OVERRIDES (sizeof(cardbus_override)/sizeof(struct cardbus_override_struct))
 
+extern void cardbus_register(pci_socket_t *socket);
+
 /*
  * Initialize a cardbus controller. Make sure we have a usable
  * interrupt, and that we can map the cardbus area. Fill in the
@@ -822,15 +792,19 @@ static int yenta_open(pci_socket_t *sock
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
@@ -839,7 +813,7 @@ static int yenta_open(pci_socket_t *sock
 	 */
 	socket->base = ioremap(pci_resource_start(dev, 0), 0x1000);
 	if (!socket->base)
-		return -1;
+		goto fail;
 
 	yenta_config_init(socket);
 
@@ -857,24 +831,43 @@ static int yenta_open(pci_socket_t *sock
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
