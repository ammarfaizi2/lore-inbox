Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267453AbUG2Sm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267453AbUG2Sm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265418AbUG2OoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:44:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:28054 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264997AbUG2OIN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:13 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 35/47] switch to dynamic (heap) serio port allocation
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <1091110196468@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <1091110196896@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.15.30, 2004-06-29 01:27:46-05:00, dtor_core@ameritech.net
  Input: switch to dynamic (heap) serio port allocation in preparation
         to sysfs integration. By having all data structures dynamically
         allocated serio driver modules can be unloaded without waiting
         for the last reference to the port to be dropped.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/mouse/psmouse-base.c |   12 +-
 drivers/input/mouse/psmouse.h      |    3 
 drivers/input/mouse/synaptics.c    |   33 +++--
 drivers/input/serio/ambakmi.c      |   35 +++---
 drivers/input/serio/ct82c710.c     |   62 ++++++-----
 drivers/input/serio/gscps2.c       |   55 ++++++---
 drivers/input/serio/i8042.c        |  208 ++++++++++++++++++++-----------------
 drivers/input/serio/i8042.h        |    7 +
 drivers/input/serio/maceps2.c      |   69 ++++++------
 drivers/input/serio/parkbd.c       |   47 +++++---
 drivers/input/serio/pcips2.c       |   30 +++--
 drivers/input/serio/q40kbd.c       |  107 ++++++++++++++-----
 drivers/input/serio/rpckbd.c       |   40 +++++--
 drivers/input/serio/sa1111ps2.c    |   32 +++--
 drivers/input/serio/serio.c        |    1 
 drivers/input/serio/serport.c      |   45 ++++----
 drivers/serial/sunsu.c             |   83 ++++++++------
 drivers/serial/sunzilog.c          |   60 ++++++----
 include/linux/serio.h              |    5 
 19 files changed, 562 insertions(+), 372 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/mouse/psmouse-base.c	Thu Jul 29 14:39:26 2004
@@ -659,7 +659,7 @@
 	if (psmouse->ptport) {
 		if (psmouse->ptport->deactivate)
 			psmouse->ptport->deactivate(psmouse);
-		__serio_unregister_port(&psmouse->ptport->serio); /* we have serio_sem */
+		__serio_unregister_port(psmouse->ptport->serio); /* we have serio_sem */
 		kfree(psmouse->ptport);
 		psmouse->ptport = NULL;
 	}
@@ -740,8 +740,8 @@
 	psmouse_initialize(psmouse);
 
 	if (psmouse->ptport) {
-		printk(KERN_INFO "serio: %s port at %s\n", psmouse->ptport->serio.name, psmouse->phys);
-		__serio_register_port(&psmouse->ptport->serio); /* we have serio_sem */
+		printk(KERN_INFO "serio: %s port at %s\n", psmouse->ptport->serio->name, psmouse->phys);
+		__serio_register_port(psmouse->ptport->serio); /* we have serio_sem */
 		if (psmouse->ptport->activate)
 			psmouse->ptport->activate(psmouse);
 	}
@@ -780,9 +780,9 @@
 	psmouse_initialize(psmouse);
 
 	if (psmouse->ptport) {
-       		if (psmouse_reconnect(&psmouse->ptport->serio)) {
-			__serio_unregister_port(&psmouse->ptport->serio);
-			__serio_register_port(&psmouse->ptport->serio);
+       		if (psmouse_reconnect(psmouse->ptport->serio)) {
+			__serio_unregister_port(psmouse->ptport->serio);
+			__serio_register_port(psmouse->ptport->serio);
 			if (psmouse->ptport->activate)
 				psmouse->ptport->activate(psmouse);
 		}
diff -Nru a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
--- a/drivers/input/mouse/psmouse.h	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/mouse/psmouse.h	Thu Jul 29 14:39:26 2004
@@ -37,7 +37,8 @@
 struct psmouse;
 
 struct psmouse_ptport {
-	struct serio serio;
+	struct serio *serio;
+	struct psmouse *parent;
 
 	void (*activate)(struct psmouse *parent);
 	void (*deactivate)(struct psmouse *parent);
diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/mouse/synaptics.c	Thu Jul 29 14:39:26 2004
@@ -214,12 +214,12 @@
  ****************************************************************************/
 static int synaptics_pt_write(struct serio *port, unsigned char c)
 {
-	struct psmouse *parent = port->port_data;
+	struct psmouse_ptport *ptport = port->port_data;
 	char rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
 
-	if (psmouse_sliced_command(parent, c))
+	if (psmouse_sliced_command(ptport->parent, c))
 		return -1;
-	if (psmouse_command(parent, &rate_param, PSMOUSE_CMD_SETRATE))
+	if (psmouse_command(ptport->parent, &rate_param, PSMOUSE_CMD_SETRATE))
 		return -1;
 	return 0;
 }
@@ -248,7 +248,7 @@
 
 static void synaptics_pt_activate(struct psmouse *psmouse)
 {
-	struct psmouse *child = psmouse->ptport->serio.private;
+	struct psmouse *child = psmouse->ptport->serio->private;
 
 	/* adjust the touchpad to child's choice of protocol */
 	if (child && child->type >= PSMOUSE_GENPS) {
@@ -260,22 +260,29 @@
 static void synaptics_pt_create(struct psmouse *psmouse)
 {
 	struct psmouse_ptport *port;
+	struct serio *serio;
 
-	psmouse->ptport = port = kmalloc(sizeof(struct psmouse_ptport), GFP_KERNEL);
-	if (!port) {
+	port = kmalloc(sizeof(struct psmouse_ptport), GFP_KERNEL);
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!port || !serio) {
 		printk(KERN_ERR "synaptics: not enough memory to allocate pass-through port\n");
 		return;
 	}
 
 	memset(port, 0, sizeof(struct psmouse_ptport));
+	memset(serio, 0, sizeof(struct serio));
 
-	port->serio.type = SERIO_PS_PSTHRU;
-	port->serio.name = "Synaptics pass-through";
-	port->serio.phys = "synaptics-pt/serio0";
-	port->serio.write = synaptics_pt_write;
-	port->serio.port_data = psmouse;
+	serio->type = SERIO_PS_PSTHRU;
+	strlcpy(serio->name, "Synaptics pass-through", sizeof(serio->name));
+	strlcpy(serio->phys, "synaptics-pt/serio0", sizeof(serio->name));
+	serio->write = synaptics_pt_write;
+	serio->port_data = port;
 
+	port->serio = serio;
+	port->parent = psmouse;
 	port->activate = synaptics_pt_activate;
+
+	psmouse->ptport = port;
 }
 
 /*****************************************************************************
@@ -470,8 +477,8 @@
 		if (unlikely(priv->pkt_type == SYN_NEWABS))
 			priv->pkt_type = synaptics_detect_pkt_type(psmouse);
 
-		if (psmouse->ptport && psmouse->ptport->serio.drv && synaptics_is_pt_packet(psmouse->packet))
-			synaptics_pass_pt_packet(&psmouse->ptport->serio, psmouse->packet);
+		if (psmouse->ptport && psmouse->ptport->serio->drv && synaptics_is_pt_packet(psmouse->packet))
+			synaptics_pass_pt_packet(psmouse->ptport->serio, psmouse->packet);
 		else
 			synaptics_process_packet(psmouse);
 
diff -Nru a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
--- a/drivers/input/serio/ambakmi.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/ambakmi.c	Thu Jul 29 14:39:26 2004
@@ -29,7 +29,7 @@
 #define KMI_BASE	(kmi->base)
 
 struct amba_kmi_port {
-	struct serio		io;
+	struct serio		*io;
 	struct clk		*clk;
 	unsigned char		*base;
 	unsigned int		irq;
@@ -44,7 +44,7 @@
 	int handled = IRQ_NONE;
 
 	while (status & KMIIR_RXINTR) {
-		serio_interrupt(&kmi->io, readb(KMIDATA), 0, regs);
+		serio_interrupt(kmi->io, readb(KMIDATA), 0, regs);
 		status = readb(KMIIR);
 		handled = IRQ_HANDLED;
 	}
@@ -117,6 +117,7 @@
 static int amba_kmi_probe(struct amba_device *dev, void *id)
 {
 	struct amba_kmi_port *kmi;
+	struct serio *io;
 	int ret;
 
 	ret = amba_request_regions(dev, NULL);
@@ -124,22 +125,25 @@
 		return ret;
 
 	kmi = kmalloc(sizeof(struct amba_kmi_port), GFP_KERNEL);
-	if (!kmi) {
+	io = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!kmi || !io) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
 	memset(kmi, 0, sizeof(struct amba_kmi_port));
+	memset(io, 0, sizeof(struct serio));
 
-	kmi->io.type		= SERIO_8042;
-	kmi->io.write		= amba_kmi_write;
-	kmi->io.open		= amba_kmi_open;
-	kmi->io.close		= amba_kmi_close;
-	kmi->io.name		= dev->dev.bus_id;
-	kmi->io.phys		= dev->dev.bus_id;
-	kmi->io.port_data	= kmi;
+	io->type	= SERIO_8042;
+	io->write	= amba_kmi_write;
+	io->open	= amba_kmi_open;
+	io->close	= amba_kmi_close;
+	strlcpy(io->name, dev->dev.bus_id, sizeof(io->name));
+	strlcpy(io->phys, dev->dev.bus_id, sizeof(io->phys));
+	io->port_data	= kmi;
 
-	kmi->base		= ioremap(dev->res.start, KMI_SIZE);
+	kmi->io 	= io;
+	kmi->base	= ioremap(dev->res.start, KMI_SIZE);
 	if (!kmi->base) {
 		ret = -ENOMEM;
 		goto out;
@@ -154,13 +158,14 @@
 	kmi->irq = dev->irq[0];
 	amba_set_drvdata(dev, kmi);
 
-	serio_register_port(&kmi->io);
+	serio_register_port(kmi->io);
 	return 0;
 
  unmap:
 	iounmap(kmi->base);
  out:
 	kfree(kmi);
+	kfree(io);
 	amba_release_regions(dev);
 	return ret;
 }
@@ -171,7 +176,7 @@
 
 	amba_set_drvdata(dev, NULL);
 
-	serio_unregister_port(&kmi->io);
+	serio_unregister_port(kmi->io);
 	clk_put(kmi->clk);
 	iounmap(kmi->base);
 	kfree(kmi);
@@ -184,7 +189,7 @@
 	struct amba_kmi_port *kmi = amba_get_drvdata(dev);
 
 	/* kick the serio layer to rescan this port */
-	serio_rescan(&kmi->io);
+	serio_reconnect(kmi->io);
 
 	return 0;
 }
@@ -214,7 +219,7 @@
 
 static void __exit amba_kmi_exit(void)
 {
-	return amba_driver_unregister(&ambakmi_driver);
+	amba_driver_unregister(&ambakmi_driver);
 }
 
 module_init(amba_kmi_init);
diff -Nru a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
--- a/drivers/input/serio/ct82c710.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/ct82c710.c	Thu Jul 29 14:39:26 2004
@@ -43,9 +43,6 @@
 MODULE_DESCRIPTION("82C710 C&T mouse port chip driver");
 MODULE_LICENSE("GPL");
 
-static char ct82c710_name[] = "C&T 82c710 mouse port";
-static char ct82c710_phys[16];
-
 /*
  * ct82c710 interface
  */
@@ -61,10 +58,20 @@
 
 #define CT82C710_IRQ          12
 
+static struct serio *ct82c710_port;
 static int ct82c710_data;
 static int ct82c710_status;
 
-static irqreturn_t ct82c710_interrupt(int cpl, void *dev_id, struct pt_regs * regs);
+
+/*
+ * Interrupt handler for the 82C710 mouse port. A character
+ * is waiting in the 82C710.
+ */
+
+static irqreturn_t ct82c710_interrupt(int cpl, void *dev_id, struct pt_regs * regs)
+{
+	return serio_interrupt(ct82c710_port, inb(ct82c710_data), 0, regs);
+}
 
 /*
  * Wait for device to send output char and flush any input char.
@@ -139,26 +146,6 @@
 	return 0;
 }
 
-static struct serio ct82c710_port =
-{
-	.type	= SERIO_8042,
-	.name	= ct82c710_name,
-	.phys	= ct82c710_phys,
-	.write	= ct82c710_write,
-	.open	= ct82c710_open,
-	.close	= ct82c710_close,
-};
-
-/*
- * Interrupt handler for the 82C710 mouse port. A character
- * is waiting in the 82C710.
- */
-
-static irqreturn_t ct82c710_interrupt(int cpl, void *dev_id, struct pt_regs * regs)
-{
-	return serio_interrupt(&ct82c710_port, inb(ct82c710_data), 0, regs);
-}
-
 /*
  * See if we can find a 82C710 device. Read mouse address.
  */
@@ -183,6 +170,24 @@
 	return 0;
 }
 
+static struct serio * __init ct82c710_allocate_port(void)
+{
+	struct serio *serio;
+
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
+		memset(serio, 0, sizeof(struct serio));
+		serio->type = SERIO_8042;
+		serio->open = ct82c710_open;
+		serio->close = ct82c710_close;
+		serio->write = ct82c710_write;
+		strlcpy(serio->name, "C&T 82c710 mouse port", sizeof(serio->name));
+		snprintf(serio->phys, sizeof(serio->phys), "isa%04x/serio0", ct82c710_data);
+	}
+
+	return serio;
+}
+
 int __init ct82c710_init(void)
 {
 	if (ct82c710_probe())
@@ -191,9 +196,12 @@
 	if (request_region(ct82c710_data, 2, "ct82c710"))
 		return -EBUSY;
 
-	sprintf(ct82c710_phys, "isa%04x/serio0", ct82c710_data);
+	if (!(ct82c710_port = ct82c710_allocate_port())) {
+		release_region(ct82c710_data, 2);
+		return -ENOMEM;
+	}
 
-	serio_register_port(&ct82c710_port);
+	serio_register_port(ct82c710_port);
 
 	printk(KERN_INFO "serio: C&T 82c710 mouse port at %#x irq %d\n",
 		ct82c710_data, CT82C710_IRQ);
@@ -203,7 +211,7 @@
 
 void __exit ct82c710_exit(void)
 {
-	serio_unregister_port(&ct82c710_port);
+	serio_unregister_port(ct82c710_port);
 	release_region(ct82c710_data, 2);
 }
 
diff -Nru a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
--- a/drivers/input/serio/gscps2.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/gscps2.c	Thu Jul 29 14:39:26 2004
@@ -91,7 +91,7 @@
 struct gscps2port {
 	struct list_head node;
 	struct parisc_device *padev;
-	struct serio port;
+	struct serio *port;
 	spinlock_t lock;
 	char *addr;
 	u8 act, append; /* position in buffer[] */
@@ -100,7 +100,6 @@
 		u8 str;
 	} buffer[BUFFER_SIZE+1];
 	int id;
-	char name[32];
 };
 
 /*
@@ -272,7 +271,7 @@
 	    rxflags =	((status & GSC_STAT_TERR) ? SERIO_TIMEOUT : 0 ) |
 			((status & GSC_STAT_PERR) ? SERIO_PARITY  : 0 );
 
-	    serio_interrupt(&ps2port->port, data, rxflags, regs);
+	    serio_interrupt(ps2port->port, data, rxflags, regs);
 
 	  } /* while() */
 
@@ -343,7 +342,8 @@
 
 static int __init gscps2_probe(struct parisc_device *dev)
 {
-        struct gscps2port *ps2port;
+	struct gscps2port *ps2port;
+	struct serio *serio;
 	unsigned long hpa = dev->hpa;
 	int ret;
 
@@ -355,34 +355,44 @@
 		hpa += GSC_DINO_OFFSET;
 
 	ps2port = kmalloc(sizeof(struct gscps2port), GFP_KERNEL);
-	if (!ps2port)
-		return -ENOMEM;
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!ps2port || !serio) {
+		ret = -ENOMEM;
+		goto fail_nomem;
+	}
 
 	dev_set_drvdata(&dev->dev, ps2port);
 
 	memset(ps2port, 0, sizeof(struct gscps2port));
+	memset(serio, 0, sizeof(struct serio));
+	ps2port->port = serio;
 	ps2port->padev = dev;
 	ps2port->addr = ioremap(hpa, GSC_STATUS + 4);
 	spin_lock_init(&ps2port->lock);
 
 	gscps2_reset(ps2port);
-	ps2port->id = readb(ps2port->addr+GSC_ID) & 0x0f;
-	snprintf(ps2port->name, sizeof(ps2port->name)-1, "%s %s",
-		gscps2_serio_port.name,
-		(ps2port->id == GSC_ID_KEYBOARD) ? "keyboard" : "mouse" );
-
-	memcpy(&ps2port->port, &gscps2_serio_port, sizeof(gscps2_serio_port));
-	ps2port->port.port_data = ps2port;
-	ps2port->port.name = ps2port->name;
-	ps2port->port.phys = dev->dev.bus_id;
+	ps2port->id = readb(ps2port->addr + GSC_ID) & 0x0f;
+
+	snprintf(serio->name, sizeof(serio->name), "GSC PS/2 %s",
+		 (ps2port->id == GSC_ID_KEYBOARD) ? "keyboard" : "mouse");
+	strlcpy(serio->phys, dev->dev.bus_id, sizeof(serio->phys));
+	serio->idbus		= BUS_GSC;
+	serio->idvendor		= PCI_VENDOR_ID_HP;
+	serio->idproduct	= 0x0001;
+	serio->idversion	= 0x0010;
+	serio->type		= SERIO_8042;
+	serio->write		= gscps2_write;
+	serio->open		= gscps2_open;
+	serio->close		= gscps2_close;
+	serio->port_data	= ps2port;
 
 	list_add_tail(&ps2port->node, &ps2port_list);
 
 	ret = -EBUSY;
-	if (request_irq(dev->irq, gscps2_interrupt, SA_SHIRQ, ps2port->name, ps2port))
+	if (request_irq(dev->irq, gscps2_interrupt, SA_SHIRQ, ps2port->port->name, ps2port))
 		goto fail_miserably;
 
-	if ( (ps2port->id != GSC_ID_KEYBOARD) && (ps2port->id != GSC_ID_MOUSE) ) {
+	if (ps2port->id != GSC_ID_KEYBOARD && ps2port->id != GSC_ID_MOUSE) {
 		printk(KERN_WARNING PFX "Unsupported PS/2 port at 0x%08lx (id=%d) ignored\n",
 				hpa, ps2port->id);
 		ret = -ENODEV;
@@ -395,12 +405,12 @@
 #endif
 
 	printk(KERN_INFO "serio: %s port at 0x%p irq %d @ %s\n",
-		ps2port->name,
+		ps2port->port->name,
 		ps2port->addr,
 		ps2port->padev->irq,
-		ps2port->port.phys);
+		ps2port->port->phys);
 
-	serio_register_port(&ps2port->port);
+	serio_register_port(ps2port->port);
 
 	return 0;
 
@@ -411,7 +421,10 @@
 	list_del(&ps2port->node);
 	iounmap(ps2port->addr);
 	release_mem_region(dev->hpa, GSC_STATUS + 4);
+
+fail_nomem:
 	kfree(ps2port);
+	kfree(serio);
 	return ret;
 }
 
@@ -424,7 +437,7 @@
 {
 	struct gscps2port *ps2port = dev_get_drvdata(&dev->dev);
 
-	serio_unregister_port(&ps2port->port);
+	serio_unregister_port(ps2port->port);
 	free_irq(dev->irq, ps2port);
 	gscps2_flush(ps2port);
 	list_del(&ps2port->node);
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/i8042.c	Thu Jul 29 14:39:26 2004
@@ -75,19 +75,35 @@
 	unsigned char irqen;
 	unsigned char exists;
 	signed char mux;
-	unsigned char *name;
-	unsigned char *phys;
+	char name[8];
 };
 
-static struct serio i8042_kbd_port;
-static struct serio i8042_aux_port;
+static struct i8042_values i8042_kbd_values = {
+	.disable	= I8042_CTR_KBDDIS,
+	.irqen 		= I8042_CTR_KBDINT,
+	.mux		= -1,
+	.name		= "KBD",
+};
+
+static struct i8042_values i8042_aux_values = {
+	.disable	= I8042_CTR_AUXDIS,
+	.irqen		= I8042_CTR_AUXINT,
+	.mux		= -1,
+	.name		= "AUX",
+};
+
+static struct i8042_values i8042_mux_values[I8042_NUM_MUX_PORTS];
+
+static struct serio *i8042_kbd_port;
+static struct serio *i8042_aux_port;
+static struct serio *i8042_mux_port[I8042_NUM_MUX_PORTS];
 static unsigned char i8042_initial_ctr;
 static unsigned char i8042_ctr;
 static unsigned char i8042_mux_open;
 static unsigned char i8042_mux_present;
 static unsigned char i8042_sysdev_initialized;
 static struct pm_dev *i8042_pm_dev;
-struct timer_list i8042_timer;
+static struct timer_list i8042_timer;
 
 /*
  * Shared IRQ's require a device pointer, but this driver doesn't support
@@ -337,52 +353,6 @@
 }
 
 /*
- * Structures for registering the devices in the serio.c module.
- */
-
-static struct i8042_values i8042_kbd_values = {
-	.irqen =	I8042_CTR_KBDINT,
-	.disable =	I8042_CTR_KBDDIS,
-	.name =		"KBD",
-	.mux =		-1,
-};
-
-static struct serio i8042_kbd_port =
-{
-	.type =		SERIO_8042_XL,
-	.write =	i8042_kbd_write,
-	.open =		i8042_open,
-	.close =	i8042_close,
-	.port_data =	&i8042_kbd_values,
-	.name =		"i8042 Kbd Port",
-	.phys =		I8042_KBD_PHYS_DESC,
-};
-
-static struct i8042_values i8042_aux_values = {
-	.irqen =	I8042_CTR_AUXINT,
-	.disable =	I8042_CTR_AUXDIS,
-	.name =		"AUX",
-	.mux =		-1,
-};
-
-static struct serio i8042_aux_port =
-{
-	.type =		SERIO_8042,
-	.write =	i8042_aux_write,
-	.open =		i8042_open,
-	.close =	i8042_close,
-	.port_data =	&i8042_aux_values,
-	.name =		"i8042 Aux Port",
-	.phys =		I8042_AUX_PHYS_DESC,
-};
-
-static struct i8042_values i8042_mux_values[4];
-static struct serio i8042_mux_port[4];
-static char i8042_mux_names[4][32];
-static char i8042_mux_short[4][16];
-static char i8042_mux_phys[4][32];
-
-/*
  * i8042_interrupt() is the most important function in this driver -
  * it handles the interrupts from the i8042, and sends incoming bytes
  * to the upper layers.
@@ -428,7 +398,7 @@
 			dfl & SERIO_PARITY ? ", bad parity" : "",
 			dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
-		serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, regs);
+		serio_interrupt(i8042_mux_port[(str >> 6) & 3], data, dfl, regs);
 
 		goto irq_ret;
 	}
@@ -439,14 +409,14 @@
 		dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
 	if (i8042_aux_values.exists && (str & I8042_STR_AUXDATA)) {
-		serio_interrupt(&i8042_aux_port, data, dfl, regs);
+		serio_interrupt(i8042_aux_port, data, dfl, regs);
 		goto irq_ret;
 	}
 
 	if (!i8042_kbd_values.exists)
 		goto irq_ret;
 
-	serio_interrupt(&i8042_kbd_port, data, dfl, regs);
+	serio_interrupt(i8042_kbd_port, data, dfl, regs);
 
 irq_ret:
 	ret = 1;
@@ -639,8 +609,10 @@
  * registers it, and reports to the user.
  */
 
-static int __init i8042_port_register(struct i8042_values *values, struct serio *port)
+static int __init i8042_port_register(struct serio *port)
 {
+	struct i8042_values *values = port->port_data;
+
 	values->exists = 1;
 
 	i8042_ctr &= ~values->disable;
@@ -748,10 +720,8 @@
  * BIOSes.
  */
 
-	if (i8042_direct) {
+	if (i8042_direct)
 		i8042_ctr &= ~I8042_CTR_XLATE;
-		i8042_kbd_port.type = SERIO_8042;
-	}
 
 /*
  * Write CTR back.
@@ -805,14 +775,14 @@
  */
 
 	if (i8042_kbd_values.exists)
-		serio_cleanup(&i8042_kbd_port);
+		serio_cleanup(i8042_kbd_port);
 
 	if (i8042_aux_values.exists)
-		serio_cleanup(&i8042_aux_port);
+		serio_cleanup(i8042_aux_port);
 
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < I8042_NUM_MUX_PORTS; i++)
 		if (i8042_mux_values[i].exists)
-			serio_cleanup(i8042_mux_port + i);
+			serio_cleanup(i8042_mux_port[i]);
 
 	i8042_controller_reset();
 }
@@ -854,15 +824,15 @@
  * Reconnect anything that was connected to the ports.
  */
 
-	if (i8042_kbd_values.exists && i8042_activate_port(&i8042_kbd_port) == 0)
-		serio_reconnect(&i8042_kbd_port);
+	if (i8042_kbd_values.exists && i8042_activate_port(i8042_kbd_port) == 0)
+		serio_reconnect(i8042_kbd_port);
 
-	if (i8042_aux_values.exists && i8042_activate_port(&i8042_aux_port) == 0)
-		serio_reconnect(&i8042_aux_port);
+	if (i8042_aux_values.exists && i8042_activate_port(i8042_aux_port) == 0)
+		serio_reconnect(i8042_aux_port);
 
-	for (i = 0; i < 4; i++)
-		if (i8042_mux_values[i].exists && i8042_activate_port(i8042_mux_port + i) == 0)
-			serio_reconnect(i8042_mux_port + i);
+	for (i = 0; i < I8042_NUM_MUX_PORTS; i++)
+		if (i8042_mux_values[i].exists && i8042_activate_port(i8042_mux_port[i]) == 0)
+			serio_reconnect(i8042_mux_port[i]);
 /*
  * Restart timer (for polling "stuck" data)
  */
@@ -932,18 +902,66 @@
 	return 0;
 }
 
-static void __init i8042_init_mux_values(struct i8042_values *values, struct serio *port, int index)
+static struct serio * __init i8042_allocate_kbd_port(void)
+{
+	struct serio *serio;
+
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
+		memset(serio, 0, sizeof(struct serio));
+		serio->type		= i8042_direct ? SERIO_8042 : SERIO_8042_XL,
+		serio->write		= i8042_dumbkbd ? NULL : i8042_kbd_write,
+		serio->open		= i8042_open,
+		serio->close		= i8042_close,
+		serio->port_data	= &i8042_kbd_values,
+		strlcpy(serio->name, "i8042 Kbd Port", sizeof(serio->name));
+		strlcpy(serio->phys, I8042_KBD_PHYS_DESC, sizeof(serio->phys));
+	}
+
+	return serio;
+}
+
+static struct serio * __init i8042_allocate_aux_port(void)
 {
-	memcpy(port, &i8042_aux_port, sizeof(struct serio));
-	memcpy(values, &i8042_aux_values, sizeof(struct i8042_values));
-	sprintf(i8042_mux_names[index], "i8042 Aux-%d Port", index);
-	sprintf(i8042_mux_phys[index], I8042_MUX_PHYS_DESC, index + 1);
-	sprintf(i8042_mux_short[index], "AUX%d", index);
-	port->name = i8042_mux_names[index];
-	port->phys = i8042_mux_phys[index];
-	port->port_data = values;
-	values->name = i8042_mux_short[index];
-	values->mux = index;
+	struct serio *serio;
+
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
+		memset(serio, 0, sizeof(struct serio));
+		serio->type		= SERIO_8042;
+		serio->write		= i8042_aux_write;
+		serio->open		= i8042_open;
+		serio->close		= i8042_close;
+		serio->port_data	= &i8042_aux_values,
+		strlcpy(serio->name, "i8042 Aux Port", sizeof(serio->name));
+		strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
+	}
+
+	return serio;
+}
+
+static struct serio * __init i8042_allocate_mux_port(int index)
+{
+	struct serio *serio;
+	struct i8042_values *values = &i8042_mux_values[index];
+
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
+		*values = i8042_aux_values;
+		snprintf(values->name, sizeof(values->name), "AUX%d", index);
+		values->mux = index;
+
+		memset(serio, 0, sizeof(struct serio));
+		serio->type		= SERIO_8042;
+		serio->write		= i8042_aux_write;
+		serio->open		= i8042_open;
+		serio->close		= i8042_close;
+		serio->port_data	= values;
+		snprintf(serio->name, sizeof(serio->name), "i8042 Aux-%d Port", index);
+		snprintf(serio->phys, sizeof(serio->phys), I8042_MUX_PHYS_DESC, index + 1);
+	}
+
+	return serio;
 }
 
 int __init i8042_init(void)
@@ -964,9 +982,6 @@
 	if (i8042_controller_init())
 		return -ENODEV;
 
-	if (i8042_dumbkbd)
-		i8042_kbd_port.write = NULL;
-
 #ifdef __i386__
 	if (i8042_dmi_noloop) {
 		printk(KERN_INFO "i8042.c: AUX LoopBack command disabled by DMI.\n");
@@ -976,15 +991,21 @@
 
 	if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values)) {
 		if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values))
-			for (i = 0; i < 4; i++) {
-				i8042_init_mux_values(i8042_mux_values + i, i8042_mux_port + i, i);
-				i8042_port_register(i8042_mux_values + i, i8042_mux_port + i);
+			for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
+				i8042_mux_port[i] = i8042_allocate_mux_port(i);
+				if (i8042_mux_port[i])
+					i8042_port_register(i8042_mux_port[i]);
 			}
-		else
-			i8042_port_register(&i8042_aux_values, &i8042_aux_port);
+		else {
+			i8042_aux_port = i8042_allocate_aux_port();
+			if (i8042_aux_port)
+				i8042_port_register(i8042_aux_port);
+		}
 	}
 
-	i8042_port_register(&i8042_kbd_values, &i8042_kbd_port);
+	i8042_kbd_port = i8042_allocate_kbd_port();
+	if (i8042_kbd_port)
+		i8042_port_register(i8042_kbd_port);
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
@@ -1019,14 +1040,15 @@
 	i8042_controller_cleanup();
 
 	if (i8042_kbd_values.exists)
-		serio_unregister_port(&i8042_kbd_port);
+		serio_unregister_port(i8042_kbd_port);
 
 	if (i8042_aux_values.exists)
-		serio_unregister_port(&i8042_aux_port);
+		serio_unregister_port(i8042_aux_port);
 
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < I8042_NUM_MUX_PORTS; i++)
 		if (i8042_mux_values[i].exists)
-			serio_unregister_port(i8042_mux_port + i);
+			serio_unregister_port(i8042_mux_port[i]);
+
 	del_timer_sync(&i8042_timer);
 
 	i8042_platform_exit();
diff -Nru a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
--- a/drivers/input/serio/i8042.h	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/i8042.h	Thu Jul 29 14:39:26 2004
@@ -104,6 +104,13 @@
 #define I8042_BUFFER_SIZE	32
 
 /*
+ * Number of AUX ports on controllers supporting active multiplexing
+ * specification
+ */
+
+#define I8042_NUM_MUX_PORTS	4
+
+/*
  * Debug.
  */
 
diff -Nru a/drivers/input/serio/maceps2.c b/drivers/input/serio/maceps2.c
--- a/drivers/input/serio/maceps2.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/maceps2.c	Thu Jul 29 14:39:26 2004
@@ -46,12 +46,14 @@
 #define PS2_CONTROL_RX_CLOCK_ENABLE  BIT(4) /* pause reception if set to 0 */
 #define PS2_CONTROL_RESET            BIT(5) /* reset */
 
-
 struct maceps2_data {
 	struct mace_ps2port *port;
 	int irq;
 };
 
+static struct maceps2_data port_data[2];
+static struct serio *maceps2_port[2];
+
 static int maceps2_write(struct serio *dev, unsigned char val)
 {
 	struct mace_ps2port *port = ((struct maceps2_data *)dev->port_data)->port;
@@ -68,8 +70,7 @@
 	return -1;
 }
 
-static irqreturn_t maceps2_interrupt(int irq, void *dev_id,
-				     struct pt_regs *regs)
+static irqreturn_t maceps2_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct serio *dev = dev_id;
 	struct mace_ps2port *port = ((struct maceps2_data *)dev->port_data)->port;
@@ -114,46 +115,52 @@
 	free_irq(data->irq, dev);
 }
 
-static struct maceps2_data port0_data, port1_data;
 
-static struct serio maceps2_port0 =
+static struct serio * __init maceps2_allocate_port(int idx)
 {
-	.type		= SERIO_8042,
-	.open		= maceps2_open,
-	.close		= maceps2_close,
-	.write		= maceps2_write,
-	.name		= "MACE PS/2 port0",
-	.phys		= "mace/serio0",
-	.port_data	= &port0_data,
-};
+	struct serio *serio;
+
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
+		memset(serio, 0, sizeof(struct serio));
+		serio->type	= SERIO_8042;
+		serio->write	= maceps2_write;
+		serio->open	= maceps2_open;
+		serio->close	= maceps2_close;
+		snprintf(serio->name, sizeof(serio->name), "MACE PS/2 port%d", idx);
+		snprintf(serio->phys, sizeof(serio->phys), "mace/serio%d", idx);
+		serio->port_data = &port_data[idx];
+	}
+
+	return serio;
+}
 
-static struct serio maceps2_port1 =
-{
-	.type		= SERIO_8042,
-	.open		= maceps2_open,
-	.close		= maceps2_close,
-	.write		= maceps2_write,
-	.name		= "MACE PS/2 port1",
-	.phys		= "mace/serio1",
-	.port_data	= &port1_data,
-};
 
 static int __init maceps2_init(void)
 {
-	port0_data.port = &mace->perif.ps2.keyb;
-	port0_data.irq  = MACEISA_KEYB_IRQ;
-	port1_data.port = &mace->perif.ps2.mouse;
-	port1_data.irq  = MACEISA_MOUSE_IRQ;
-	serio_register_port(&maceps2_port0);
-	serio_register_port(&maceps2_port1);
+	port_data[0].port = &mace->perif.ps2.keyb;
+	port_data[0].irq  = MACEISA_KEYB_IRQ;
+	port_data[1].port = &mace->perif.ps2.mouse;
+	port_data[1].irq  = MACEISA_MOUSE_IRQ;
+
+	maceps2_port[0] = maceps2_allocate_port(0);
+	maceps2_port[1] = maceps2_allocate_port(1);
+	if (!maceps2_port[0] || !maceps2_port[1]) {
+		kfree(maceps2_port[0]);
+		kfree(maceps2_port[1]);
+		return -ENOMEM;
+	}
+
+	serio_register_port(maceps2_port[0]);
+	serio_register_port(maceps2_port[1]);
 
 	return 0;
 }
 
 static void __exit maceps2_exit(void)
 {
-	serio_unregister_port(&maceps2_port0);
-	serio_unregister_port(&maceps2_port1);
+	serio_unregister_port(maceps2_port[0]);
+	serio_unregister_port(maceps2_port[1]);
 }
 
 module_init(maceps2_init);
diff -Nru a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
--- a/drivers/input/serio/parkbd.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/parkbd.c	Thu Jul 29 14:39:26 2004
@@ -53,9 +53,7 @@
 static unsigned long parkbd_start;
 
 static struct pardevice *parkbd_dev;
-
-static char parkbd_name[] = "PARKBD AT/XT keyboard adapter";
-static char parkbd_phys[32];
+static struct serio *parkbd_port;
 
 static int parkbd_readlines(void)
 {
@@ -86,13 +84,6 @@
 	return 0;
 }
 
-static struct serio parkbd_port =
-{
-	.write	= parkbd_write,
-	.name	= parkbd_name,
-	.phys	= parkbd_phys,
-};
-
 static void parkbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 
@@ -125,7 +116,7 @@
 		parkbd_buffer |= (parkbd_readlines() >> 1) << parkbd_counter++;
 
 		if (parkbd_counter == parkbd_mode + 10)
-			serio_interrupt(&parkbd_port, (parkbd_buffer >> (2 - parkbd_mode)) & 0xff, 0, regs);
+			serio_interrupt(parkbd_port, (parkbd_buffer >> (2 - parkbd_mode)) & 0xff, 0, regs);
 	}
 
 	parkbd_last = jiffies;
@@ -163,16 +154,38 @@
 	return 0;
 }
 
+static struct serio * __init parkbd_allocate_serio(void)
+{
+	struct serio *serio;
+
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
+		serio->type = parkbd_mode;
+		serio->write = parkbd_write,
+		strlcpy(serio->name, "PARKBD AT/XT keyboard adapter", sizeof(serio->name));
+		snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", parkbd_dev->port->name);
+	}
+
+	return serio;
+}
 
 int __init parkbd_init(void)
 {
-	if (parkbd_getport()) return -1;
-	parkbd_writelines(3);
-	parkbd_port.type = parkbd_mode;
+	int err;
 
-	sprintf(parkbd_phys, "%s/serio0", parkbd_dev->port->name);
+	err = parkbd_getport();
+	if (err)
+		return err;
+
+	parkbd_port = parkbd_allocate_serio();
+	if (!parkbd_port) {
+		parport_release(parkbd_dev);
+		return -ENOMEM;
+	}
+
+	parkbd_writelines(3);
 
-	serio_register_port(&parkbd_port);
+	serio_register_port(parkbd_port);
 
 	printk(KERN_INFO "serio: PARKBD %s adapter on %s\n",
                         parkbd_mode ? "AT" : "XT", parkbd_dev->port->name);
@@ -183,7 +196,7 @@
 void __exit parkbd_exit(void)
 {
 	parport_release(parkbd_dev);
-	serio_unregister_port(&parkbd_port);
+	serio_unregister_port(parkbd_port);
 	parport_unregister_device(parkbd_dev);
 }
 
diff -Nru a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
--- a/drivers/input/serio/pcips2.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/pcips2.c	Thu Jul 29 14:39:26 2004
@@ -38,7 +38,7 @@
 #define PS2_STAT_TXEMPTY	(1<<7)
 
 struct pcips2_data {
-	struct serio	io;
+	struct serio	*io;
 	unsigned int	base;
 	struct pci_dev	*dev;
 };
@@ -80,7 +80,7 @@
 		if (hweight8(scancode) & 1)
 			flag ^= SERIO_PARITY;
 
-		serio_interrupt(&ps2if->io, scancode, flag, regs);
+		serio_interrupt(ps2if->io, scancode, flag, regs);
 	} while (1);
 	return IRQ_RETVAL(handled);
 }
@@ -129,6 +129,7 @@
 static int __devinit pcips2_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct pcips2_data *ps2if;
+	struct serio *serio;
 	int ret;
 
 	ret = pci_enable_device(dev);
@@ -142,29 +143,34 @@
 	}
 
 	ps2if = kmalloc(sizeof(struct pcips2_data), GFP_KERNEL);
-	if (!ps2if) {
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!ps2if || !serio) {
 		ret = -ENOMEM;
 		goto release;
 	}
 
 	memset(ps2if, 0, sizeof(struct pcips2_data));
+	memset(serio, 0, sizeof(struct serio));
 
-	ps2if->io.type		= SERIO_8042;
-	ps2if->io.write		= pcips2_write;
-	ps2if->io.open		= pcips2_open;
-	ps2if->io.close		= pcips2_close;
-	ps2if->io.name		= pci_name(dev);
-	ps2if->io.phys		= dev->dev.bus_id;
-	ps2if->io.port_data	= ps2if;
+	serio->type		= SERIO_8042;
+	serio->write		= pcips2_write;
+	serio->open		= pcips2_open;
+	serio->close		= pcips2_close;
+	strlcpy(serio->name, pci_name(dev), sizeof(serio->name));
+	strlcpy(serio->phys, dev->dev.bus_id, sizeof(serio->phys));
+	serio->port_data	= ps2if;
+	ps2if->io		= serio;
 	ps2if->dev		= dev;
 	ps2if->base		= pci_resource_start(dev, 0);
 
 	pci_set_drvdata(dev, ps2if);
 
-	serio_register_port(&ps2if->io);
+	serio_register_port(ps2if->io);
 	return 0;
 
  release:
+	kfree(ps2if);
+	kfree(serio);
 	release_region(pci_resource_start(dev, 0),
 		       pci_resource_len(dev, 0));
  disable:
@@ -176,7 +182,7 @@
 {
 	struct pcips2_data *ps2if = pci_get_drvdata(dev);
 
-	serio_unregister_port(&ps2if->io);
+	serio_unregister_port(ps2if->io);
 	release_region(pci_resource_start(dev, 0),
 		       pci_resource_len(dev, 0));
 	pci_set_drvdata(dev, NULL);
diff -Nru a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
--- a/drivers/input/serio/q40kbd.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/q40kbd.c	Thu Jul 29 14:39:26 2004
@@ -47,43 +47,98 @@
 MODULE_DESCRIPTION("Q40 PS/2 keyboard controller driver");
 MODULE_LICENSE("GPL");
 
-static struct serio q40kbd_port =
-{
-	.type	= SERIO_8042,
-	.name	= "Q40 kbd port",
-	.phys	= "Q40",
-	.write	= NULL,
-};
+spinlock_t q40kbd_lock = SPIN_LOCK_UNLOCKED;
+static struct serio *q40kbd_port;
 
-static irqreturn_t q40kbd_interrupt(int irq, void *dev_id,
-				    struct pt_regs *regs)
+static irqreturn_t q40kbd_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&q40kbd_lock, flags);
+
 	if (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG))
-		serio_interrupt(&q40kbd_port, master_inb(KEYCODE_REG), 0, regs);
+		serio_interrupt(q40kbd_port, master_inb(KEYCODE_REG), 0, regs);
 
 	master_outb(-1, KEYBOARD_UNLOCK_REG);
+
+	spin_unlock_irqrestore(&q40kbd_lock, flags);
+
 	return IRQ_HANDLED;
 }
 
-static int __init q40kbd_init(void)
+/*
+ * q40kbd_flush() flushes all data that may be in the keyboard buffers
+ */
+
+static void q40kbd_flush(void)
 {
-	int maxread = 100;
+ 	int maxread = 100;
+	unsigned long flags;
+
+	spin_lock_irqsave(&q40kbd_lock, flags);
+
+ 	while (maxread-- && (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG)))
+ 		master_inb(KEYCODE_REG);
+
+	spin_unlock_irqrestore(&q40kbd_lock, flags);
+}
+
+/*
+ * q40kbd_open() is called when a port is open by the higher layer.
+ * It allocates the interrupt and enables in in the chip.
+ */
+
+static int q40kbd_open(struct serio *port)
+{
+	q40kbd_flush();
+
+	if (request_irq(Q40_IRQ_KEYBOARD, q40kbd_interrupt, 0, "q40kbd", NULL)) {
+		printk(KERN_ERR "q40kbd.c: Can't get irq %d.\n", Q40_IRQ_KEYBOARD);
+		return -1;
+	}
+
+ 	/* off we go */
+ 	master_outb(-1, KEYBOARD_UNLOCK_REG);
+ 	master_outb(1, KEY_IRQ_ENABLE_REG);
+
+ 	return 0;
+}
 
+static void q40kbd_close(struct serio *port)
+{
+	master_outb(0, KEY_IRQ_ENABLE_REG);
+	master_outb(-1, KEYBOARD_UNLOCK_REG);
+	free_irq(Q40_IRQ_KEYBOARD, NULL);
+
+	q40kbd_flush();
+}
+
+static struct serio * __init q40kbd_allocate_port(void)
+{
+	struct serio *serio;
+
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
+		memset(serio, 0, sizeof(struct serio));
+		serio->type	= SERIO_8042;
+		serio->open	= q40kbd_open;
+		serio->close	= q40kbd_close;
+		strlcpy(serio->name, "Q40 Kbd Port", sizeof(serio->name));
+		strlcpy(serio->phys, "Q40", sizeof(serio->phys));
+	}
+
+	return serio;
+}
+
+static int __init q40kbd_init(void)
+{
 	if (!MACH_IS_Q40)
 		return -EIO;
 
-	/* allocate the IRQ */
-	request_irq(Q40_IRQ_KEYBOARD, q40kbd_interrupt, 0, "q40kbd", NULL);
-
-	/* flush any pending input */
-	while (maxread-- && (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG)))
-		master_inb(KEYCODE_REG);
-
-	/* off we go */
-	master_outb(-1,KEYBOARD_UNLOCK_REG);
-	master_outb(1,KEY_IRQ_ENABLE_REG);
+	if (!(q40kbd_port = q40kbd_allocate_port()))
+		return -ENOMEM;
 
-	serio_register_port(&q40kbd_port);
+	serio_register_port(q40kbd_port);
 	printk(KERN_INFO "serio: Q40 kbd registered\n");
 
 	return 0;
@@ -91,11 +146,7 @@
 
 static void __exit q40kbd_exit(void)
 {
-	master_outb(0,KEY_IRQ_ENABLE_REG);
-	master_outb(-1,KEYBOARD_UNLOCK_REG);
-
-	serio_unregister_port(&q40kbd_port);
-	free_irq(Q40_IRQ_KEYBOARD, NULL);
+	serio_unregister_port(q40kbd_port);
 }
 
 module_init(q40kbd_init);
diff -Nru a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
--- a/drivers/input/serio/rpckbd.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/rpckbd.c	Thu Jul 29 14:39:26 2004
@@ -44,6 +44,8 @@
 MODULE_DESCRIPTION("Acorn RiscPC PS/2 keyboard controller driver");
 MODULE_LICENSE("GPL");
 
+static struct serio *rpckbd_port;
+
 static int rpckbd_write(struct serio *port, unsigned char val)
 {
 	while (!(iomd_readb(IOMD_KCTRL) & (1 << 7)))
@@ -101,25 +103,41 @@
 	free_irq(IRQ_KEYBOARDTX, port);
 }
 
-static struct serio rpckbd_port =
-{
-	.type	= SERIO_8042,
-	.open	= rpckbd_open,
-	.close	= rpckbd_close,
-	.write	= rpckbd_write,
-	.name	= "RiscPC PS/2 kbd port",
-	.phys	= "rpckbd/serio0",
-};
+/*
+ * Allocate and initialize serio structure for subsequent registration
+ * with serio core.
+ */
+
+static struct serio * __init rpckbd_allocate_port(void)
+{
+	struct serio *serio;
+
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
+		memset(serio, 0, sizeof(struct serio));
+		serio->type	= SERIO_8042;
+		serio->write	= rpckbd_write;
+		serio->open	= rpckbd_open;
+		serio->close	= rpckbd_close;
+		strlcpy(serio->name, "RiscPC PS/2 kbd port", sizeof(serio->name));
+		strlcpy(serio->phys, "rpckbd/serio0", sizeof(serio->phys));
+	}
+
+	return serio;
+}
 
 static int __init rpckbd_init(void)
 {
-	serio_register_port(&rpckbd_port);
+	if (!(rpckbd_port = rpckbd_allocate_port()))
+		return -ENOMEM;
+
+	serio_register_port(rpckbd_port);
 	return 0;
 }
 
 static void __exit rpckbd_exit(void)
 {
-	serio_unregister_port(&rpckbd_port);
+	serio_unregister_port(rpckbd_port);
 }
 
 module_init(rpckbd_init);
diff -Nru a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
--- a/drivers/input/serio/sa1111ps2.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/sa1111ps2.c	Thu Jul 29 14:39:26 2004
@@ -26,7 +26,7 @@
 #include <asm/hardware/sa1111.h>
 
 struct ps2if {
-	struct serio		io;
+	struct serio		*io;
 	struct sa1111_dev	*dev;
 	unsigned long		base;
 	unsigned int		open;
@@ -59,7 +59,7 @@
 		if (hweight8(scancode) & 1)
 			flag ^= SERIO_PARITY;
 
-		serio_interrupt(&ps2if->io, scancode, flag, regs);
+		serio_interrupt(ps2if->io, scancode, flag, regs);
 
 		status = sa1111_readl(ps2if->base + SA1111_PS2STAT);
         }
@@ -232,22 +232,27 @@
 static int ps2_probe(struct sa1111_dev *dev)
 {
 	struct ps2if *ps2if;
+	struct serio *serio;
 	int ret;
 
 	ps2if = kmalloc(sizeof(struct ps2if), GFP_KERNEL);
-	if (!ps2if) {
-		return -ENOMEM;
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (!ps2if || !serio) {
+		ret = -ENOMEM;
+		goto free;
 	}
 
 	memset(ps2if, 0, sizeof(struct ps2if));
+	memset(serio, 0, sizeof(struct serio));
 
-	ps2if->io.type		= SERIO_8042;
-	ps2if->io.write		= ps2_write;
-	ps2if->io.open		= ps2_open;
-	ps2if->io.close		= ps2_close;
-	ps2if->io.name		= dev->dev.bus_id;
-	ps2if->io.phys		= dev->dev.bus_id;
-	ps2if->io.port_data	= ps2if;
+	serio->type		= SERIO_8042;
+	serio->write		= ps2_write;
+	serio->open		= ps2_open;
+	serio->close		= ps2_close;
+	strlcpy(serio->name, dev->dev.bus_id, sizeof(serio->name));
+	strlcpy(serio->phys, dev->dev.bus_id, sizeof(serio->phys));
+	serio->port_data	= ps2if;
+	ps2if->io		= serio;
 	ps2if->dev		= dev;
 	sa1111_set_drvdata(dev, ps2if);
 
@@ -292,7 +297,7 @@
 	ps2_clear_input(ps2if);
 
 	sa1111_disable_device(ps2if->dev);
-	serio_register_port(&ps2if->io);
+	serio_register_port(ps2if->io);
 	return 0;
 
  out:
@@ -302,6 +307,7 @@
  free:
 	sa1111_set_drvdata(dev, NULL);
 	kfree(ps2if);
+	kfree(serio);
 	return ret;
 }
 
@@ -312,7 +318,7 @@
 {
 	struct ps2if *ps2if = sa1111_get_drvdata(dev);
 
-	serio_unregister_port(&ps2if->io);
+	serio_unregister_port(ps2if->io);
 	release_mem_region(dev->res.start,
 			   dev->res.end - dev->res.start + 1);
 	sa1111_set_drvdata(dev, NULL);
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/serio.c	Thu Jul 29 14:39:26 2004
@@ -283,6 +283,7 @@
 	list_del_init(&serio->node);
 	if (serio->drv)
 		serio->drv->disconnect(serio);
+	kfree(serio);
 }
 
 /*
diff -Nru a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
--- a/drivers/input/serio/serport.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/input/serio/serport.c	Thu Jul 29 14:39:26 2004
@@ -31,13 +31,10 @@
 struct serport {
 	struct tty_struct *tty;
 	wait_queue_head_t wait;
-	struct serio serio;
+	struct serio *serio;
 	unsigned long flags;
-	char phys[32];
 };
 
-char serport_name[] = "Serial port";
-
 /*
  * Callback functions from the serio code.
  */
@@ -52,7 +49,7 @@
 {
 	struct serport *serport = serio->port_data;
 
-	serport->serio.type = 0;
+	serport->serio->type = 0;
 	wake_up_interruptible(&serport->wait);
 }
 
@@ -64,26 +61,30 @@
 static int serport_ldisc_open(struct tty_struct *tty)
 {
 	struct serport *serport;
+	struct serio *serio;
 	char name[64];
 
 	serport = kmalloc(sizeof(struct serport), GFP_KERNEL);
-	if (unlikely(!serport))
+	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (unlikely(!serport || !serio)) {
+		kfree(serport);
+		kfree(serio);
 		return -ENOMEM;
-	memset(serport, 0, sizeof(struct serport));
+	}
 
+	memset(serport, 0, sizeof(struct serport));
+	serport->serio = serio;
 	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	serport->tty = tty;
 	tty->disc_data = serport;
 
-	snprintf(serport->phys, sizeof(serport->phys), "%s/serio0", tty_name(tty, name));
-
-	serport->serio.name = serport_name;
-	serport->serio.phys = serport->phys;
-
-	serport->serio.type = SERIO_RS232;
-	serport->serio.write = serport_serio_write;
-	serport->serio.close = serport_serio_close;
-	serport->serio.port_data = serport;
+	memset(serio, 0, sizeof(struct serio));
+	strlcpy(serio->name, "Serial port", sizeof(serio->name));
+	snprintf(serio->phys, sizeof(serio->phys), "%s/serio0", tty_name(tty, name));
+	serio->type = SERIO_RS232;
+	serio->write = serport_serio_write;
+	serio->close = serport_serio_close;
+	serio->port_data = serport;
 
 	init_waitqueue_head(&serport->wait);
 
@@ -114,7 +115,7 @@
 	struct serport *serport = (struct serport*) tty->disc_data;
 	int i;
 	for (i = 0; i < count; i++)
-		serio_interrupt(&serport->serio, cp[i], 0, NULL);
+		serio_interrupt(serport->serio, cp[i], 0, NULL);
 }
 
 /*
@@ -142,10 +143,10 @@
 	if (test_and_set_bit(SERPORT_BUSY, &serport->flags))
 		return -EBUSY;
 
-	serio_register_port(&serport->serio);
+	serio_register_port(serport->serio);
 	printk(KERN_INFO "serio: Serial port %s\n", tty_name(tty, name));
-	wait_event_interruptible(serport->wait, !serport->serio.type);
-	serio_unregister_port(&serport->serio);
+	wait_event_interruptible(serport->wait, !serport->serio->type);
+	serio_unregister_port(serport->serio);
 
 	clear_bit(SERPORT_BUSY, &serport->flags);
 
@@ -161,7 +162,7 @@
 	struct serport *serport = (struct serport*) tty->disc_data;
 
 	if (cmd == SPIOCSTYPE)
-		return get_user(serport->serio.type, (unsigned long __user *) arg);
+		return get_user(serport->serio->type, (unsigned long __user *) arg);
 
 	return -EINVAL;
 }
@@ -170,7 +171,7 @@
 {
 	struct serport *sp = (struct serport *) tty->disc_data;
 
-	serio_drv_write_wakeup(&sp->serio);
+	serio_drv_write_wakeup(sp->serio);
 }
 
 /*
diff -Nru a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
--- a/drivers/serial/sunsu.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/serial/sunsu.c	Thu Jul 29 14:39:26 2004
@@ -98,7 +98,7 @@
 	unsigned int		irq;
 
 #ifdef CONFIG_SERIO
-	struct serio		serio;
+	struct serio		*serio;
 	int			serio_open;
 #endif
 };
@@ -520,7 +520,7 @@
 		/* Stop-A is handled by drivers/char/keyboard.c now. */
 		if (up->su_type == SU_PORT_KBD) {
 #ifdef CONFIG_SERIO
-			serio_interrupt(&up->serio, ch, 0, regs);
+			serio_interrupt(up->serio, ch, 0, regs);
 #endif
 		} else if (up->su_type == SU_PORT_MS) {
 			int ret = suncore_mouse_baud_detection(ch, is_break);
@@ -534,7 +534,7 @@
 
 			case 0:
 #ifdef CONFIG_SERIO
-				serio_interrupt(&up->serio, ch, 0, regs);
+				serio_interrupt(up->serio, ch, 0, regs);
 #endif
 				break;
 			};
@@ -1284,54 +1284,58 @@
 	.major			= TTY_MAJOR,
 };
 
-static int __init sunsu_kbd_ms_init(void)
+static int __init sunsu_kbd_ms_init(struct uart_sunsu_port *up, int channel)
 {
-	struct uart_sunsu_port *up;
-	int i;
+	struct serio *serio;
 
-	for (i = 0, up = sunsu_ports; i < 2; i++, up++) {
-		up->port.line = i;
-		up->port.type = PORT_UNKNOWN;
-		up->port.uartclk = (SU_BASE_BAUD * 16);
+	up->port.line = channel;
+	up->port.type = PORT_UNKNOWN;
+	up->port.uartclk = (SU_BASE_BAUD * 16);
 
-		if (up->su_type == SU_PORT_KBD)
-			up->cflag = B1200 | CS8 | CLOCAL | CREAD;
-		else
-			up->cflag = B4800 | CS8 | CLOCAL | CREAD;
+	if (up->su_type == SU_PORT_KBD)
+		up->cflag = B1200 | CS8 | CLOCAL | CREAD;
+	else
+		up->cflag = B4800 | CS8 | CLOCAL | CREAD;
 
-		sunsu_autoconfig(up);
-		if (up->port.type == PORT_UNKNOWN)
-			continue;
+	sunsu_autoconfig(up);
+	if (up->port.type == PORT_UNKNOWN)
+		return -1;
 
-		printk(KERN_INFO "su%d at 0x%p (irq = %s) is a %s\n",
-		       i,
-		       up->port.membase, __irq_itoa(up->irq),
-		       sunsu_type(&up->port));
+	printk(KERN_INFO "su%d at 0x%p (irq = %s) is a %s\n",
+	       channel,
+	       up->port.membase, __irq_itoa(up->irq),
+	       sunsu_type(&up->port));
 
 #ifdef CONFIG_SERIO
-		memset(&up->serio, 0, sizeof(up->serio));
+	up->serio = serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
+		memset(serio, 0, sizeof(serio));
 
-		up->serio.port_data = up;
+		serio->port_data = up;
 
-		up->serio.type = SERIO_RS232;
+		serio->type = SERIO_RS232;
 		if (up->su_type == SU_PORT_KBD) {
-			up->serio.type |= SERIO_SUNKBD;
-			up->serio.name = "sukbd";
+			serio->type |= SERIO_SUNKBD;
+			strlcpy(serio->name, "sukbd", sizeof(serio->name));
 		} else {
-			up->serio.type |= (SERIO_SUN | (1 << 16));
-			up->serio.name = "sums";
+			serio->type |= (SERIO_SUN | (1 << 16));
+			strlcpy(serio->name, "sums", sizeof(serio->name));
 		}
-		up->serio.phys = (i == 0 ? "su/serio0" : "su/serio1");
+		strlcpy(serio->phys, (channel == 0 ? "su/serio0" : "su/serio1"),
+			sizeof(serio->phys));
 
-		up->serio.write = sunsu_serio_write;
-		up->serio.open = sunsu_serio_open;
-		up->serio.close = sunsu_serio_close;
+		serio->write = sunsu_serio_write;
+		serio->open = sunsu_serio_open;
+		serio->close = sunsu_serio_close;
 
-		serio_register_port(&up->serio);
+		serio_register_port(serio);
+	} else {
+		printk(KERN_WARNING "su%d: not enough memory for serio port\n",
+			channel);
+	}
 #endif
 
-		sunsu_startup(&up->port);
-	}
+	sunsu_startup(&up->port);
 	return 0;
 }
 
@@ -1680,10 +1684,12 @@
 	if (scan.msx != -1 && scan.kbx != -1) {
 		sunsu_ports[0].su_type = SU_PORT_MS;
 		sunsu_ports[0].port_node = scan.msnode;
+		sunsu_kbd_ms_init(&sunsu_ports[0], 0);
+
 		sunsu_ports[1].su_type = SU_PORT_KBD;
 		sunsu_ports[1].port_node = scan.kbnode;
+		sunsu_kbd_ms_init(&sunsu_ports[1], 1);
 
-		sunsu_kbd_ms_init();
 		return 0;
 	}
 
@@ -1715,7 +1721,10 @@
 		if (up->su_type == SU_PORT_MS ||
 		    up->su_type == SU_PORT_KBD) {
 #ifdef CONFIG_SERIO
-			serio_unregister_port(&up->serio);
+			if (up->serio) {
+				serio_unregister_port(up->serio);
+				up->serio = NULL;
+			}
 #endif
 		} else if (up->port.type != PORT_UNKNOWN) {
 			uart_remove_one_port(&sunsu_reg, &up->port);
diff -Nru a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
--- a/drivers/serial/sunzilog.c	Thu Jul 29 14:39:26 2004
+++ b/drivers/serial/sunzilog.c	Thu Jul 29 14:39:26 2004
@@ -107,7 +107,7 @@
 	unsigned char			prev_status;
 
 #ifdef CONFIG_SERIO
-	struct serio			serio;
+	struct serio			*serio;
 	int				serio_open;
 #endif
 };
@@ -291,7 +291,7 @@
 		/* Stop-A is handled by drivers/char/keyboard.c now. */
 #ifdef CONFIG_SERIO
 		if (up->serio_open)
-			serio_interrupt(&up->serio, ch, 0, regs);
+			serio_interrupt(up->serio, ch, 0, regs);
 #endif
 	} else if (ZS_IS_MOUSE(up)) {
 		int ret = suncore_mouse_baud_detection(ch, is_break);
@@ -306,7 +306,7 @@
 		case 0:
 #ifdef CONFIG_SERIO
 			if (up->serio_open)
-				serio_interrupt(&up->serio, ch, 0, regs);
+				serio_interrupt(up->serio, ch, 0, regs);
 #endif
 			break;
 		};
@@ -1529,6 +1529,7 @@
 static void __init sunzilog_init_kbdms(struct uart_sunzilog_port *up, int channel)
 {
 	int baud, brg;
+	struct serio *serio;
 
 	if (channel == KEYBOARD_LINE) {
 		up->flags |= SUNZILOG_FLAG_CONS_KEYB;
@@ -1547,26 +1548,34 @@
 	sunzilog_convert_to_zs(up, up->cflag, 0, brg);
 
 #ifdef CONFIG_SERIO
-	memset(&up->serio, 0, sizeof(up->serio));
+	up->serio = serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
+	if (serio) {
 
-	up->serio.port_data = up;
+		memset(serio, 0, sizeof(serio));
 
-	up->serio.type = SERIO_RS232;
-	if (channel == KEYBOARD_LINE) {
-		up->serio.type |= SERIO_SUNKBD;
-		up->serio.name = "zskbd";
-	} else {
-		up->serio.type |= (SERIO_SUN | (1 << 16));
-		up->serio.name = "zsms";
-	}
-	up->serio.phys = (channel == KEYBOARD_LINE ?
-			  "zs/serio0" : "zs/serio1");
+		serio->port_data = up;
 
-	up->serio.write = sunzilog_serio_write;
-	up->serio.open = sunzilog_serio_open;
-	up->serio.close = sunzilog_serio_close;
+		serio->type = SERIO_RS232;
+		if (channel == KEYBOARD_LINE) {
+			serio->type |= SERIO_SUNKBD;
+			strlcpy(serio->name, "zskbd", sizeof(serio->name));
+		} else {
+			serio->type |= (SERIO_SUN | (1 << 16));
+			strlcpy(serio->name, "zsms", sizeof(serio->name));
+		}
+		strlcpy(serio->phys,
+			(channel == KEYBOARD_LINE ? "zs/serio0" : "zs/serio1"),
+			sizeof(serio->phys));
+
+		serio->write = sunzilog_serio_write;
+		serio->open = sunzilog_serio_open;
+		serio->close = sunzilog_serio_close;
 
-	serio_register_port(&up->serio);
+		serio_register_port(serio);
+	} else {
+		printk(KERN_WARNING "zs%d: not enough memory for serio port\n",
+			channel);
+	}
 #endif
 
 	sunzilog_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
@@ -1732,10 +1741,15 @@
 	for (i = 0; i < NUM_CHANNELS; i++) {
 		struct uart_sunzilog_port *up = &sunzilog_port_table[i];
 
-		if (ZS_IS_KEYB(up) || ZS_IS_MOUSE(up))
-			continue;
-
-		uart_remove_one_port(&sunzilog_reg, &up->port);
+		if (ZS_IS_KEYB(up) || ZS_IS_MOUSE(up)) {
+#ifdef CONFIG_SERIO
+			if (up->serio) {
+				serio_unregister_port(up->serio);
+				up->serio = NULL;
+			}
+#endif
+		} else
+			uart_remove_one_port(&sunzilog_reg, &up->port);
 	}
 
 	uart_unregister_driver(&sunzilog_reg);
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Thu Jul 29 14:39:26 2004
+++ b/include/linux/serio.h	Thu Jul 29 14:39:26 2004
@@ -22,8 +22,9 @@
 struct serio {
 	void *private;
 	void *port_data;
-	char *name;
-	char *phys;
+
+	char name[32];
+	char phys[32];
 
 	unsigned short idbus;
 	unsigned short idvendor;

