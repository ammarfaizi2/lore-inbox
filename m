Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbTBOQoW>; Sat, 15 Feb 2003 11:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTBOQoW>; Sat, 15 Feb 2003 11:44:22 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:12507 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264628AbTBOQoL>; Sat, 15 Feb 2003 11:44:11 -0500
Date: Sat, 15 Feb 2003 17:52:55 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, dahinds@users.sourceforge.net, davej@suse.de,
       alan@lxorguk.ukuu.org.uk, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org, pcmcia-cs-devel@lists.sourceforge.net
Subject: [PATCH 2.5.61] pcmcia: use device_class->add_device/remove_device
Message-ID: <20030215165255.GB7204@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[depends on the device_class patch sent a moment ago]

This patch removes the {un}register_ss_entry/pcmcia_{un}register_socket
calls, and replaces them with generic driver-model-compatible functions.
Also, update the CodingStyle of these cs.c functions to what's recommended
in the Linux kernel.

	Dominik

 drivers/pcmcia/cs.c         |  196 ++++++++++++++++++++++----------------------
 drivers/pcmcia/hd64465_ss.c |   29 ++----
 drivers/pcmcia/i82092.c     |   16 ++-
 drivers/pcmcia/i82365.c     |   10 +-
 drivers/pcmcia/pci_socket.c |   18 +++-
 drivers/pcmcia/pci_socket.h |    1
 drivers/pcmcia/tcic.c       |   15 +--
 drivers/pcmcia/yenta.c      |   62 ++++---------
 include/pcmcia/ss.h         |   12 ++
 9 files changed, 180 insertions(+), 179 deletions(-)

diff -ruN linux-original/drivers/pcmcia/cs.c linux-pcmcia/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-02-15 17:31:20.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/cs.c	2003-02-15 17:11:31.000000000 +0100
@@ -309,119 +309,123 @@
 static void unreset_socket(socket_info_t *);
 static void parse_events(void *info, u_int events);
 
-socket_info_t *pcmcia_register_socket (int slot,
-	struct pccard_operations * ss_entry,
-	int use_bus_pm)
-{
-    socket_info_t *s;
-    int i;
+#define to_class_data(dev) dev->class_data
 
-    DEBUG(0, "cs: pcmcia_register_socket(0x%p)\n", ss_entry);
-
-    s = kmalloc(sizeof(struct socket_info_t), GFP_KERNEL);
-    if (!s)
-    	return NULL;
-    memset(s, 0, sizeof(socket_info_t));
-
-    s->ss_entry = ss_entry;
-    s->sock = slot;
-
-    /* base address = 0, map = 0 */
-    s->cis_mem.flags = 0;
-    s->cis_mem.speed = cis_speed;
-    s->use_bus_pm = use_bus_pm;
-    s->erase_busy.next = s->erase_busy.prev = &s->erase_busy;
-    spin_lock_init(&s->lock);
-    
-    for (i = 0; i < sockets; i++)
-	if (socket_table[i] == NULL) break;
-    socket_table[i] = s;
-    if (i == sockets) sockets++;
+/**
+ * pcmcia_register_socket - add a new pcmcia socket device
+ */
+int pcmcia_register_socket(struct device *dev)
+{
+	struct pcmcia_socket_class_data *cls_d = to_class_data(dev);
+	socket_info_t *s_info;
+	unsigned int i, j;
+
+	if (!cls_d)
+		return -EINVAL;
+
+	DEBUG(0, "cs: pcmcia_register_socket(0x%p)\n", cls_d->ops);
+
+	s_info = kmalloc(cls_d->nsock * sizeof(struct socket_info_t), GFP_KERNEL);
+	if (!s_info)
+		return -ENOMEM;
+	memset(s_info, 0, cls_d->nsock * sizeof(socket_info_t));
+
+	/* socket initialization */
+	for (i = 0; i < cls_d->nsock; i++) {
+		socket_info_t *s = &s_info[i];
+
+		cls_d->s_info[i] = s;
+		s->ss_entry = cls_d->ops;
+		s->sock = i;
+
+		/* base address = 0, map = 0 */
+		s->cis_mem.flags = 0;
+		s->cis_mem.speed = cis_speed;
+		s->use_bus_pm = cls_d->use_bus_pm;
+		s->erase_busy.next = s->erase_busy.prev = &s->erase_busy;
+		spin_lock_init(&s->lock);
+    
+		/* TBD: remove usage of socket_table, use class_for_each_dev instead */
+		for (j = 0; j < sockets; j++)
+			if (socket_table[j] == NULL) break;
+		socket_table[j] = s;
+		if (j == sockets) sockets++;
 
-    init_socket(s);
-    ss_entry->inquire_socket(slot, &s->cap);
+		init_socket(s);
+		s->ss_entry->inquire_socket(i, &s->cap);
 #ifdef CONFIG_PROC_FS
-    if (proc_pccard) {
-	char name[3];
-	sprintf(name, "%02d", i);
-	s->proc = proc_mkdir(name, proc_pccard);
-	if (s->proc)
-	    ss_entry->proc_setup(slot, s->proc);
+		if (proc_pccard) {
+			char name[3];
+			sprintf(name, "%02d", i);
+			s->proc = proc_mkdir(name, proc_pccard);
+			if (s->proc)
+				s->ss_entry->proc_setup(i, s->proc);
 #ifdef PCMCIA_DEBUG
-	if (s->proc)
-	    create_proc_read_entry("clients", 0, s->proc,
-				   proc_read_clients, s);
+			if (s->proc)
+				create_proc_read_entry("clients", 0, s->proc,
+				       proc_read_clients, s);
 #endif
-    }
+		}
 #endif
-    return s;
+	}
+	return 0;
 } /* pcmcia_register_socket */
 
-int register_ss_entry(int nsock, struct pccard_operations * ss_entry)
-{
-    int ns;
-
-    DEBUG(0, "cs: register_ss_entry(%d, 0x%p)\n", nsock, ss_entry);
-
-    for (ns = 0; ns < nsock; ns++) {
-	pcmcia_register_socket (ns, ss_entry, 0);
-    }
-    
-    return 0;
-} /* register_ss_entry */
-
-/*====================================================================*/
 
-void pcmcia_unregister_socket(socket_info_t *s)
+/**
+ * pcmcia_unregister_socket - remove a pcmcia socket device
+ */
+void pcmcia_unregister_socket(struct device *dev)
 {
-    int j, socket = -1;
-    client_t *client;
+	struct pcmcia_socket_class_data *cls_d = to_class_data(dev);
+	unsigned int i;
+	int j, socket = -1;
+	client_t *client;
+	socket_info_t *s;
 
-    for (j = 0; j < MAX_SOCK; j++)
-	if (socket_table [j] == s) {
-	    socket = j;
-	    break;
-	}
-    if (socket < 0)
-	return;
+	if (!cls_d)
+		return;
+
+	s = (socket_info_t *) cls_d->s_info;
 
+	for (i = 0; i < cls_d->nsock; i++) {
+		for (j = 0; j < MAX_SOCK; j++)
+			if (socket_table [j] == s) {
+				socket = j;
+				break;
+			}
+		if (socket < 0)
+			continue;
+		
 #ifdef CONFIG_PROC_FS
-    if (proc_pccard) {
-	char name[3];
-	sprintf(name, "%02d", socket);
+		if (proc_pccard) {
+			char name[3];
+			sprintf(name, "%02d", socket);
 #ifdef PCMCIA_DEBUG
-	remove_proc_entry("clients", s->proc);
+			remove_proc_entry("clients", s->proc);
 #endif
-	remove_proc_entry(name, proc_pccard);
-    }
+			remove_proc_entry(name, proc_pccard);
+		}
 #endif
+		
+		shutdown_socket(s);
+		release_cis_mem(s);
+		while (s->clients) {
+			client = s->clients;
+			s->clients = s->clients->next;
+			kfree(client);
+		}
+		s->ss_entry = NULL;
+		socket_table[socket] = NULL;
+		for (j = socket; j < sockets-1; j++)
+			socket_table[j] = socket_table[j+1];
+		sockets--;
 
-    shutdown_socket(s);
-    release_cis_mem(s);
-    while (s->clients) {
-	client = s->clients;
-	s->clients = s->clients->next;
-	kfree(client);
-    }
-    s->ss_entry = NULL;
-    kfree(s);
-
-    socket_table[socket] = NULL;
-    for (j = socket; j < sockets-1; j++)
-	socket_table[j] = socket_table[j+1];
-    sockets--;
+		s++;
+	}
+	kfree(cls_d->s_info);
 } /* pcmcia_unregister_socket */
 
-void unregister_ss_entry(struct pccard_operations * ss_entry)
-{
-    int i;
-
-    for (i = sockets-1; i >= 0; i-- ) {
-	socket_info_t *socket = socket_table[i];
-	if (socket->ss_entry == ss_entry)
-		pcmcia_unregister_socket (socket);
-    }
-} /* unregister_ss_entry */
 
 /*======================================================================
 
@@ -2403,8 +2407,6 @@
 EXPORT_SYMBOL(pcmcia_write_memory);
 
 EXPORT_SYMBOL(dead_socket);
-EXPORT_SYMBOL(register_ss_entry);
-EXPORT_SYMBOL(unregister_ss_entry);
 EXPORT_SYMBOL(CardServices);
 EXPORT_SYMBOL(MTDHelperEntry);
 #ifdef CONFIG_PROC_FS
@@ -2418,6 +2420,8 @@
 
 struct device_class pcmcia_socket_class = {
 	.name = "pcmcia_socket",
+	.add_device = &pcmcia_register_socket,
+	.remove_device = &pcmcia_unregister_socket,
 };
 EXPORT_SYMBOL(pcmcia_socket_class);
 
diff -ruN linux-original/drivers/pcmcia/hd64465_ss.c linux-pcmcia/drivers/pcmcia/hd64465_ss.c
--- linux-original/drivers/pcmcia/hd64465_ss.c	2003-02-15 17:31:20.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/hd64465_ss.c	2003-02-15 17:12:48.000000000 +0100
@@ -961,6 +961,10 @@
 	
 	hs_reset_socket(sp, 1);
 
+	printk(KERN_INFO "HD64465 PCMCIA bridge socket %d at 0x%08lx irq %d io window %ldK@0x%08lx\n",
+	    	i, sp->mem_base, sp->irq,
+		sp->io_vma->size>>10, (unsigned long)sp->io_vma->addr);
+
     	return 0;
 }
 
@@ -991,6 +995,10 @@
 	    vfree(sp->io_vma->addr);
 }
 
+static struct pcmcia_socket_class_data hd64465_data = {
+	.nsock = HS_MAX_SOCKETS,
+	.ops = &hs_operations,
+};
 
 static struct device_driver hd64465_driver = {
 	.name = "hd64465-pcmcia",
@@ -1067,25 +1075,9 @@
 
 /*	hd64465_io_debug = 0; */
 	platform_device_register(&hd64465_device);
+	hd64465_device.dev.class_data = &hd64465_data;
 
-	if (register_ss_entry(HS_MAX_SOCKETS, &hs_operations) != 0) {
-	    for (i=0 ; i<HS_MAX_SOCKETS ; i++)
-		hs_exit_socket(&hs_sockets[i]);
-	    platform_device_unregister(&hd64465_device);
-	    unregister_driver(&hd64465_driver);
-    	    return -ENODEV;
-	}
-
-	printk(KERN_INFO "HD64465 PCMCIA bridge:\n");
-	for (i=0 ; i<HS_MAX_SOCKETS ; i++) {
-	    hs_socket_t *sp = &hs_sockets[i];
-	    
-	    printk(KERN_INFO "  socket %d at 0x%08lx irq %d io window %ldK@0x%08lx\n",
-	    	i, sp->mem_base, sp->irq,
-		sp->io_vma->size>>10, (unsigned long)sp->io_vma->addr);
-	}
-
-    	return 0;
+	return 0;
 }
 
 static void __exit exit_hs(void)
@@ -1101,7 +1093,6 @@
 	for (i=0 ; i<HS_MAX_SOCKETS ; i++)
 	    hs_exit_socket(&hs_sockets[i]);
 	platform_device_unregister(&hd64465_device);
-	unregister_ss_entry(&hs_operations);
 	
 	restore_flags(flags);
 	unregister_driver(&hd64465_driver);
diff -ruN linux-original/drivers/pcmcia/i82092.c linux-pcmcia/drivers/pcmcia/i82092.c
--- linux-original/drivers/pcmcia/i82092.c	2003-02-15 17:31:20.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/i82092.c	2003-02-15 17:12:30.000000000 +0100
@@ -97,6 +97,7 @@
 {
 	unsigned char configbyte;
 	int i, ret;
+	struct pcmcia_socket_class_data *cls_d;
 	
 	enter("i82092aa_pci_probe");
 	
@@ -154,11 +155,17 @@
 		printk(KERN_ERR "i82092aa: Failed to register IRQ %d, aborting\n", dev->irq);
 		goto err_out_free_res;
 	}
-		 
-	if ((ret = register_ss_entry(socket_count, &i82092aa_operations) != 0)) {
-		printk(KERN_ERR "i82092aa: register_ss_entry() failed\n");
+
+	
+	cls_d = kmalloc(sizeof(*cls_d), GFP_KERNEL);
+	if (!cls_d) {
+		printk(KERN_ERR "i82092aa: kmalloc failed\n");
 		goto err_out_free_irq;
 	}
+	memset(cls_d, 0, sizeof(*cls_d));
+	cls_d->nsock = socket_count;
+	cls_d->ops = &i82092aa_operations;
+	dev->dev.class_data = cls_d;
 
 	leave("i82092aa_pci_probe");
 	return 0;
@@ -177,6 +184,8 @@
 	enter("i82092aa_pci_remove");
 	
 	free_irq(dev->irq, i82092aa_interrupt);
+	if (dev->dev.class_data)
+		kfree(dev->dev.class_data);
 
 	leave("i82092aa_pci_remove");
 }
@@ -907,7 +916,6 @@
 {
 	enter("i82092aa_module_exit");
 	pci_unregister_driver(&i82092aa_pci_drv);
-	unregister_ss_entry(&i82092aa_operations);
 	if (sockets[0].io_base>0)
 			 release_region(sockets[0].io_base, 2);
 	leave("i82092aa_module_exit");
diff -ruN linux-original/drivers/pcmcia/i82365.c linux-pcmcia/drivers/pcmcia/i82365.c
--- linux-original/drivers/pcmcia/i82365.c	2003-02-15 17:31:20.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/i82365.c	2003-02-15 17:12:38.000000000 +0100
@@ -1584,6 +1584,10 @@
 
 /*====================================================================*/
 
+static struct pcmcia_socket_class_data i82365_data = {
+	.ops = &pcic_operations,
+};
+
 static struct device_driver i82365_driver = {
 	.name = "i82365",
 	.bus = &platform_bus_type,
@@ -1629,9 +1633,10 @@
 #endif
     
     platform_device_register(&i82365_device);
-    if (register_ss_entry(sockets, &pcic_operations) != 0)
-	printk(KERN_NOTICE "i82365: register_ss_entry() failed\n");
 
+    i82365_data.nsock = sockets;
+    i82365_device.dev.class_data = &i82365_data;
+    
     /* Finally, schedule a polling interrupt */
     if (poll_interval != 0) {
 	poll_timer.function = pcic_interrupt_wrapper;
@@ -1651,7 +1656,6 @@
 #ifdef CONFIG_PROC_FS
     for (i = 0; i < sockets; i++) pcic_proc_remove(i);
 #endif
-    unregister_ss_entry(&pcic_operations);
     platform_device_unregister(&i82365_device);
     if (poll_interval != 0)
 	del_timer_sync(&poll_timer);
diff -ruN linux-original/drivers/pcmcia/pci_socket.c linux-pcmcia/drivers/pcmcia/pci_socket.c
--- linux-original/drivers/pcmcia/pci_socket.c	2003-02-15 17:31:20.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/pci_socket.c	2003-02-15 17:12:07.000000000 +0100
@@ -190,11 +190,21 @@
 	return err;
 }
 
-void cardbus_register(pci_socket_t *socket)
+int cardbus_register(struct pci_dev *p_dev)
 {
-	int nr = socket - pci_socket_array;
+	pci_socket_t *socket = pci_get_drvdata(p_dev);
+	struct pcmcia_socket_class_data *cls_d;
 
-	socket->pcmcia_socket = pcmcia_register_socket(nr, &pci_socket_operations, 1);
+	if (!socket)
+		return -EINVAL;
+
+	cls_d = &socket->cls_d;
+	cls_d->nsock = 1; /* yenta is 1, no other low-level driver uses
+			     this yet */
+	cls_d->ops = &pci_socket_operations;
+	cls_d->use_bus_pm = 1;
+	p_dev->dev.class_data = cls_d;
+	return 0;
 }
 
 static int __devinit
@@ -214,7 +224,7 @@
 {
 	pci_socket_t *socket = pci_get_drvdata(dev);
 
-	pcmcia_unregister_socket (socket->pcmcia_socket);
+	/* note: we are already unregistered from the cs core */
 	if (socket->op && socket->op->close)
 		socket->op->close(socket);
 	pci_set_drvdata(dev, NULL);
diff -ruN linux-original/drivers/pcmcia/pci_socket.h linux-pcmcia/drivers/pcmcia/pci_socket.h
--- linux-original/drivers/pcmcia/pci_socket.h	2002-10-08 09:24:28.000000000 +0200
+++ linux-pcmcia/drivers/pcmcia/pci_socket.h	2003-02-15 17:12:10.000000000 +0100
@@ -24,6 +24,7 @@
 	struct work_struct tq_task;
 	struct timer_list poll_timer;
 
+	struct pcmcia_socket_class_data cls_d;
 	/* A few words of private data for the low-level driver.. */
 	unsigned int private[8];
 } pci_socket_t;
diff -ruN linux-original/drivers/pcmcia/tcic.c linux-pcmcia/drivers/pcmcia/tcic.c
--- linux-original/drivers/pcmcia/tcic.c	2003-02-15 17:31:20.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/tcic.c	2003-02-15 17:12:42.000000000 +0100
@@ -376,6 +376,9 @@
 
 /*====================================================================*/
 
+static struct pcmcia_socket_class_data tcic_data = {
+	.ops = &tcic_operations,
+};
 
 static struct device_driver tcic_driver = {
 	.name = "tcic-pcmcia",
@@ -521,15 +524,8 @@
     /* jump start interrupt handler, if needed */
     tcic_interrupt(0, NULL, NULL);
 
-    if (register_ss_entry(sockets, &tcic_operations) != 0) {
-	printk(KERN_NOTICE "tcic: register_ss_entry() failed\n");
-	release_region(tcic_base, 16);
-	if (cs_irq != 0)
-	    free_irq(cs_irq, tcic_interrupt);
-	platform_device_unregister(&tcic_device);
-	driver_unregister(&tcic_driver);
-	return -ENODEV;
-    }
+    tcic_data.nsock = sockets;
+    tcic_device.dev.class_data = &tcic_data;
 
     return 0;
     
@@ -539,7 +535,6 @@
 
 static void __exit exit_tcic(void)
 {
-    unregister_ss_entry(&tcic_operations);
     del_timer_sync(&poll_timer);
     if (cs_irq != 0) {
 	tcic_aux_setw(TCIC_AUX_SYSCFG, TCIC_SYSCFG_AUTOBUSY|0x0a00);
diff -ruN linux-original/drivers/pcmcia/yenta.c linux-pcmcia/drivers/pcmcia/yenta.c
--- linux-original/drivers/pcmcia/yenta.c	2003-01-10 21:49:31.000000000 +0100
+++ linux-pcmcia/drivers/pcmcia/yenta.c	2003-02-15 17:12:15.000000000 +0100
@@ -577,39 +577,6 @@
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
-	INIT_WORK(&socket->tq_task, yenta_bh, socket);
-
-	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->dev.name, socket)) {
-		/* No IRQ or request_irq failed. Poll */
-		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
-		init_timer(&socket->poll_timer);
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
@@ -881,6 +848,9 @@
 
 #define NR_OVERRIDES (sizeof(cardbus_override)/sizeof(struct cardbus_override_struct))
 
+
+extern int cardbus_register(struct pci_dev *p_dev);
+
 /*
  * Initialize a cardbus controller. Make sure we have a usable
  * interrupt, and that we can map the cardbus area. Fill in the
@@ -932,16 +902,26 @@
 		}
 	}
 
-	/* Get the PCMCIA kernel thread to complete the
-	   initialisation later. We can't do this here,
-	   because, er, because Linus says so :)
-	*/
-	INIT_WORK(&socket->tq_task, yenta_open_bh, socket);
+	/* We must finish initialization here */
 
-	MOD_INC_USE_COUNT;
-	schedule_work(&socket->tq_task);
+	INIT_WORK(&socket->tq_task, yenta_bh, socket);
 
-	return 0;
+	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, SA_SHIRQ, socket->dev->dev.name, socket)) {
+		/* No IRQ or request_irq failed. Poll */
+		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
+		init_timer(&socket->poll_timer);
+		socket->poll_timer.function = yenta_interrupt_wrapper;
+		socket->poll_timer.data = (unsigned long)socket;
+		socket->poll_timer.expires = jiffies + HZ;
+		add_timer(&socket->poll_timer);
+	}
+
+	/* Figure out what the dang thing can do for the PCMCIA layer... */
+	yenta_get_socket_capabilities(socket, isa_interrupts);
+	printk("Socket status: %08x\n", cb_readl(socket, CB_SOCKET_STATE));
+
+	/* Register it with the pcmcia layer.. */
+	return cardbus_register(dev);
 }
 
 /*
diff -ruN linux-original/include/pcmcia/ss.h linux-pcmcia/include/pcmcia/ss.h
--- linux-original/include/pcmcia/ss.h	2003-02-15 17:31:20.000000000 +0100
+++ linux-pcmcia/include/pcmcia/ss.h	2003-02-15 17:11:53.000000000 +0100
@@ -31,6 +31,7 @@
 #define _LINUX_SS_H
 
 #include <pcmcia/cs_types.h>
+#include <linux/device.h>
 
 /* Definitions for card status flags for GetStatus */
 #define SS_WRPROT	0x0001
@@ -142,8 +143,15 @@
 /*
  *  Calls to set up low-level "Socket Services" drivers
  */
-extern int register_ss_entry(int nsock, struct pccard_operations *ops);
-extern void unregister_ss_entry(struct pccard_operations *ops);
+
+#define MAX_SOCKETS_PER_DEV 8
+
+struct pcmcia_socket_class_data {
+	unsigned int nsock;			/* number of sockets */
+	struct pccard_operations *ops;		/* see above */
+	void *s_info[MAX_SOCKETS_PER_DEV];	/* socket_info_t */
+	unsigned int use_bus_pm;
+};
 
 extern struct device_class pcmcia_socket_class;
 
