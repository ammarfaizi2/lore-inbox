Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265075AbUFRIrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbUFRIrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 04:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265048AbUFRIq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 04:46:28 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:39765 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265049AbUFRIoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:44:54 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/11] serio renames 1
Date: Fri, 18 Jun 2004 03:39:15 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       vojtech@ucw.cz
References: <200406180335.52843.dtor_core@ameritech.net> <200406180337.47669.dtor_core@ameritech.net> <200406180338.42624.dtor_core@ameritech.net>
In-Reply-To: <200406180338.42624.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406180339.17699.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1793, 2004-06-17 18:18:43-05:00, dtor_core@ameritech.net
  Input: rename serio->driver to serio->port_data in preparation
         to sysfs integration
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/mouse/synaptics.c |    4 ++--
 drivers/input/serio/98kbd-io.c  |    1 -
 drivers/input/serio/ambakmi.c   |   26 +++++++++++++-------------
 drivers/input/serio/gscps2.c    |    8 ++++----
 drivers/input/serio/i8042.c     |   14 +++++++-------
 drivers/input/serio/maceps2.c   |   36 ++++++++++++++++++------------------
 drivers/input/serio/pcips2.c    |    8 ++++----
 drivers/input/serio/sa1111ps2.c |    8 ++++----
 drivers/input/serio/serport.c   |    6 +++---
 include/linux/serio.h           |    2 +-
 10 files changed, 56 insertions(+), 57 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	2004-06-18 03:15:34 -05:00
+++ b/drivers/input/mouse/synaptics.c	2004-06-18 03:15:34 -05:00
@@ -214,7 +214,7 @@
  ****************************************************************************/
 static int synaptics_pt_write(struct serio *port, unsigned char c)
 {
-	struct psmouse *parent = port->driver;
+	struct psmouse *parent = port->port_data;
 	char rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
 
 	if (psmouse_sliced_command(parent, c))
@@ -273,7 +273,7 @@
 	port->serio.name = "Synaptics pass-through";
 	port->serio.phys = "synaptics-pt/serio0";
 	port->serio.write = synaptics_pt_write;
-	port->serio.driver = psmouse;
+	port->serio.port_data = psmouse;
 
 	port->activate = synaptics_pt_activate;
 }
diff -Nru a/drivers/input/serio/98kbd-io.c b/drivers/input/serio/98kbd-io.c
--- a/drivers/input/serio/98kbd-io.c	2004-06-18 03:15:34 -05:00
+++ b/drivers/input/serio/98kbd-io.c	2004-06-18 03:15:34 -05:00
@@ -132,7 +132,6 @@
 	.write =	kbd98_write,
 	.open =		kbd98_open,
 	.close =	kbd98_close,
-	.driver =	NULL,
 	.name =		"PC-9801 Kbd Port",
 	.phys =		KBD98_PHYS_DESC,
 };
diff -Nru a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
--- a/drivers/input/serio/ambakmi.c	2004-06-18 03:15:34 -05:00
+++ b/drivers/input/serio/ambakmi.c	2004-06-18 03:15:34 -05:00
@@ -52,7 +52,7 @@
 
 static int amba_kmi_write(struct serio *io, unsigned char val)
 {
-	struct amba_kmi_port *kmi = io->driver;
+	struct amba_kmi_port *kmi = io->port_data;
 	unsigned int timeleft = 10000; /* timeout in 100ms */
 
 	while ((readb(KMISTAT) & KMISTAT_TXEMPTY) == 0 && timeleft--)
@@ -66,7 +66,7 @@
 
 static int amba_kmi_open(struct serio *io)
 {
-	struct amba_kmi_port *kmi = io->driver;
+	struct amba_kmi_port *kmi = io->port_data;
 	int ret;
 
 	writeb(kmi->divisor, KMICLKDIV);
@@ -86,7 +86,7 @@
 
 static void amba_kmi_close(struct serio *io)
 {
-	struct amba_kmi_port *kmi = io->driver;
+	struct amba_kmi_port *kmi = io->port_data;
 
 	writeb(0, KMICR);
 
@@ -110,22 +110,22 @@
 
 	memset(kmi, 0, sizeof(struct amba_kmi_port));
 
-	kmi->io.type	= SERIO_8042;
-	kmi->io.write	= amba_kmi_write;
-	kmi->io.open	= amba_kmi_open;
-	kmi->io.close	= amba_kmi_close;
-	kmi->io.name	= dev->dev.bus_id;
-	kmi->io.phys	= dev->dev.bus_id;
-	kmi->io.driver	= kmi;
+	kmi->io.type		= SERIO_8042;
+	kmi->io.write		= amba_kmi_write;
+	kmi->io.open		= amba_kmi_open;
+	kmi->io.close		= amba_kmi_close;
+	kmi->io.name		= dev->dev.bus_id;
+	kmi->io.phys		= dev->dev.bus_id;
+	kmi->io.port_data	= kmi;
 
-	kmi->base	= ioremap(dev->res.start, KMI_SIZE);
+	kmi->base		= ioremap(dev->res.start, KMI_SIZE);
 	if (!kmi->base) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	kmi->irq	= dev->irq[0];
-	kmi->divisor	= 24 / 8 - 1;
+	kmi->irq		= dev->irq[0];
+	kmi->divisor		= 24 / 8 - 1;
 
 	amba_set_drvdata(dev, kmi);
 
diff -Nru a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
--- a/drivers/input/serio/gscps2.c	2004-06-18 03:15:34 -05:00
+++ b/drivers/input/serio/gscps2.c	2004-06-18 03:15:34 -05:00
@@ -288,7 +288,7 @@
 
 static int gscps2_write(struct serio *port, unsigned char data)
 {
-	struct gscps2port *ps2port = port->driver;
+	struct gscps2port *ps2port = port->port_data;
 
 	if (!gscps2_writeb_output(ps2port, data)) {
 		printk(KERN_DEBUG PFX "sending byte %#x failed.\n", data);
@@ -304,7 +304,7 @@
 
 static int gscps2_open(struct serio *port)
 {
-	struct gscps2port *ps2port = port->driver;
+	struct gscps2port *ps2port = port->port_data;
 
 	gscps2_reset(ps2port);
 
@@ -319,7 +319,7 @@
 
 static void gscps2_close(struct serio *port)
 {
-	struct gscps2port *ps2port = port->driver;
+	struct gscps2port *ps2port = port->port_data;
 	gscps2_enable(ps2port, DISABLE);
 }
 
@@ -372,7 +372,7 @@
 		(ps2port->id == GSC_ID_KEYBOARD) ? "keyboard" : "mouse" );
 
 	memcpy(&ps2port->port, &gscps2_serio_port, sizeof(gscps2_serio_port));
-	ps2port->port.driver = ps2port;
+	ps2port->port.port_data = ps2port;
 	ps2port->port.name = ps2port->name;
 	ps2port->port.phys = dev->dev.bus_id;
 
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-06-18 03:15:34 -05:00
+++ b/drivers/input/serio/i8042.c	2004-06-18 03:15:34 -05:00
@@ -222,7 +222,7 @@
 
 static int i8042_aux_write(struct serio *port, unsigned char c)
 {
-	struct i8042_values *values = port->driver;
+	struct i8042_values *values = port->port_data;
 	int retval;
 
 /*
@@ -250,7 +250,7 @@
 
 static int i8042_activate_port(struct serio *port)
 {
-	struct i8042_values *values = port->driver;
+	struct i8042_values *values = port->port_data;
 
 	i8042_flush();
 
@@ -278,7 +278,7 @@
 
 static int i8042_open(struct serio *port)
 {
-	struct i8042_values *values = port->driver;
+	struct i8042_values *values = port->port_data;
 
 	if (values->mux != -1)
 		if (i8042_mux_open++)
@@ -317,7 +317,7 @@
 
 static void i8042_close(struct serio *port)
 {
-	struct i8042_values *values = port->driver;
+	struct i8042_values *values = port->port_data;
 
 	if (values->mux != -1)
 		if (--i8042_mux_open)
@@ -352,7 +352,7 @@
 	.write =	i8042_kbd_write,
 	.open =		i8042_open,
 	.close =	i8042_close,
-	.driver =	&i8042_kbd_values,
+	.port_data =	&i8042_kbd_values,
 	.name =		"i8042 Kbd Port",
 	.phys =		I8042_KBD_PHYS_DESC,
 };
@@ -370,7 +370,7 @@
 	.write =	i8042_aux_write,
 	.open =		i8042_open,
 	.close =	i8042_close,
-	.driver =	&i8042_aux_values,
+	.port_data =	&i8042_aux_values,
 	.name =		"i8042 Aux Port",
 	.phys =		I8042_AUX_PHYS_DESC,
 };
@@ -940,7 +940,7 @@
 	sprintf(i8042_mux_short[index], "AUX%d", index);
 	port->name = i8042_mux_names[index];
 	port->phys = i8042_mux_phys[index];
-	port->driver = values;
+	port->port_data = values;
 	values->name = i8042_mux_short[index];
 	values->mux = index;
 }
diff -Nru a/drivers/input/serio/maceps2.c b/drivers/input/serio/maceps2.c
--- a/drivers/input/serio/maceps2.c	2004-06-18 03:15:34 -05:00
+++ b/drivers/input/serio/maceps2.c	2004-06-18 03:15:34 -05:00
@@ -54,7 +54,7 @@
 
 static int maceps2_write(struct serio *dev, unsigned char val)
 {
-	struct mace_ps2port *port = ((struct maceps2_data *)dev->driver)->port;
+	struct mace_ps2port *port = ((struct maceps2_data *)dev->port_data)->port;
 	unsigned int timeout = MACE_PS2_TIMEOUT;
 
 	do {
@@ -72,7 +72,7 @@
 				     struct pt_regs *regs)
 {
 	struct serio *dev = dev_id;
-	struct mace_ps2port *port = ((struct maceps2_data *)dev->driver)->port;
+	struct mace_ps2port *port = ((struct maceps2_data *)dev->port_data)->port;
 	unsigned int byte;
 
 	if (mace_read(port->status) & PS2_STATUS_RX_FULL) {
@@ -85,7 +85,7 @@
 
 static int maceps2_open(struct serio *dev)
 {
-	struct maceps2_data *data = (struct maceps2_data *)dev->driver;
+	struct maceps2_data *data = (struct maceps2_data *)dev->port_data;
 
 	if (request_irq(data->irq, maceps2_interrupt, 0, "PS/2 port", dev)) {
 		printk(KERN_ERR "Could not allocate PS/2 IRQ\n");
@@ -106,7 +106,7 @@
 
 static void maceps2_close(struct serio *dev)
 {
-	struct maceps2_data *data = (struct maceps2_data *)dev->driver;
+	struct maceps2_data *data = (struct maceps2_data *)dev->port_data;
 
 	mace_write(PS2_CONTROL_TX_CLOCK_DISABLE | PS2_CONTROL_RESET,
 		   data->port->control);
@@ -118,24 +118,24 @@
 
 static struct serio maceps2_port0 =
 {
-	.type	= SERIO_8042,
-	.open	= maceps2_open,
-	.close	= maceps2_close,
-	.write	= maceps2_write,
-	.name	= "MACE PS/2 port0",
-	.phys	= "mace/serio0",
-	.driver = &port0_data,
+	.type		= SERIO_8042,
+	.open		= maceps2_open,
+	.close		= maceps2_close,
+	.write		= maceps2_write,
+	.name		= "MACE PS/2 port0",
+	.phys		= "mace/serio0",
+	.port_data	= &port0_data,
 };
 
 static struct serio maceps2_port1 =
 {
-	.type	= SERIO_8042,
-	.open	= maceps2_open,
-	.close	= maceps2_close,
-	.write	= maceps2_write,
-	.name	= "MACE PS/2 port1",
-	.phys	= "mace/serio1",
-	.driver = &port1_data,
+	.type		= SERIO_8042,
+	.open		= maceps2_open,
+	.close		= maceps2_close,
+	.write		= maceps2_write,
+	.name		= "MACE PS/2 port1",
+	.phys		= "mace/serio1",
+	.port_data	= &port1_data,
 };
 
 static int __init maceps2_init(void)
diff -Nru a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.c
--- a/drivers/input/serio/pcips2.c	2004-06-18 03:15:34 -05:00
+++ b/drivers/input/serio/pcips2.c	2004-06-18 03:15:34 -05:00
@@ -45,7 +45,7 @@
 
 static int pcips2_write(struct serio *io, unsigned char val)
 {
-	struct pcips2_data *ps2if = io->driver;
+	struct pcips2_data *ps2if = io->port_data;
 	unsigned int stat;
 
 	do {
@@ -101,7 +101,7 @@
 
 static int pcips2_open(struct serio *io)
 {
-	struct pcips2_data *ps2if = io->driver;
+	struct pcips2_data *ps2if = io->port_data;
 	int ret, val = 0;
 
 	outb(PS2_CTRL_ENABLE, ps2if->base);
@@ -119,7 +119,7 @@
 
 static void pcips2_close(struct serio *io)
 {
-	struct pcips2_data *ps2if = io->driver;
+	struct pcips2_data *ps2if = io->port_data;
 
 	outb(0, ps2if->base);
 
@@ -155,7 +155,7 @@
 	ps2if->io.close		= pcips2_close;
 	ps2if->io.name		= pci_name(dev);
 	ps2if->io.phys		= dev->dev.bus_id;
-	ps2if->io.driver	= ps2if;
+	ps2if->io.port_data	= ps2if;
 	ps2if->dev		= dev;
 	ps2if->base		= pci_resource_start(dev, 0);
 
diff -Nru a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
--- a/drivers/input/serio/sa1111ps2.c	2004-06-18 03:15:34 -05:00
+++ b/drivers/input/serio/sa1111ps2.c	2004-06-18 03:15:34 -05:00
@@ -95,7 +95,7 @@
  */
 static int ps2_write(struct serio *io, unsigned char val)
 {
-	struct ps2if *ps2if = io->driver;
+	struct ps2if *ps2if = io->port_data;
 	unsigned long flags;
 	unsigned int head;
 
@@ -122,7 +122,7 @@
 
 static int ps2_open(struct serio *io)
 {
-	struct ps2if *ps2if = io->driver;
+	struct ps2if *ps2if = io->port_data;
 	int ret;
 
 	sa1111_enable_device(ps2if->dev);
@@ -154,7 +154,7 @@
 
 static void ps2_close(struct serio *io)
 {
-	struct ps2if *ps2if = io->driver;
+	struct ps2if *ps2if = io->port_data;
 
 	sa1111_writel(0, ps2if->base + SA1111_PS2CR);
 
@@ -247,7 +247,7 @@
 	ps2if->io.close		= ps2_close;
 	ps2if->io.name		= dev->dev.bus_id;
 	ps2if->io.phys		= dev->dev.bus_id;
-	ps2if->io.driver	= ps2if;
+	ps2if->io.port_data	= ps2if;
 	ps2if->dev		= dev;
 	sa1111_set_drvdata(dev, ps2if);
 
diff -Nru a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
--- a/drivers/input/serio/serport.c	2004-06-18 03:15:34 -05:00
+++ b/drivers/input/serio/serport.c	2004-06-18 03:15:34 -05:00
@@ -44,13 +44,13 @@
 
 static int serport_serio_write(struct serio *serio, unsigned char data)
 {
-	struct serport *serport = serio->driver;
+	struct serport *serport = serio->port_data;
 	return -(serport->tty->driver->write(serport->tty, 0, &data, 1) != 1);
 }
 
 static void serport_serio_close(struct serio *serio)
 {
-	struct serport *serport = serio->driver;
+	struct serport *serport = serio->port_data;
 
 	serport->serio.type = 0;
 	wake_up_interruptible(&serport->wait);
@@ -83,7 +83,7 @@
 	serport->serio.type = SERIO_RS232;
 	serport->serio.write = serport_serio_write;
 	serport->serio.close = serport_serio_close;
-	serport->serio.driver = serport;
+	serport->serio.port_data = serport;
 
 	init_waitqueue_head(&serport->wait);
 
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-06-18 03:15:34 -05:00
+++ b/include/linux/serio.h	2004-06-18 03:15:34 -05:00
@@ -21,7 +21,7 @@
 
 struct serio {
 	void *private;
-	void *driver;
+	void *port_data;
 	char *name;
 	char *phys;
 
