Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbUKLGlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbUKLGlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 01:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbUKLGib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 01:38:31 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:16286 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262466AbUKLGfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 01:35:09 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 3/7] i8042 - use start() and stop() methods
Date: Fri, 12 Nov 2004 01:30:52 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411120127.01473.dtor_core@ameritech.net> <200411120129.04300.dtor_core@ameritech.net> <200411120129.58520.dtor_core@ameritech.net>
In-Reply-To: <200411120129.58520.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411120130.54103.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1987, 2004-11-12 00:25:22-05:00, dtor_core@ameritech.net
  Input: i8042 - make use of new serio start() and stop() callbacks
         to ensure that i8042 interrupt handler that is shared among
         several ports does not reference deleted ports. Also rename
         i8042_valies structure to i8042_port, consolidate handling
         of KBD, AUX and MUX ports, rearrange interrupt handler code.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8042.c |  319 ++++++++++++++++++++++++++++++++--------------------------------
 i8042.h |    6 -
 2 files changed, 165 insertions(+), 160 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-11-12 01:00:34 -05:00
+++ b/drivers/input/serio/i8042.c	2004-11-12 01:00:34 -05:00
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/serio.h>
 #include <linux/err.h>
+#include <linux/rcupdate.h>
 
 #include <asm/io.h>
 
@@ -82,7 +83,8 @@
 
 spinlock_t i8042_lock = SPIN_LOCK_UNLOCKED;
 
-struct i8042_values {
+struct i8042_port {
+	struct serio *serio;
 	int irq;
 	unsigned char disable;
 	unsigned char irqen;
@@ -91,25 +93,25 @@
 	char name[8];
 };
 
-static struct i8042_values i8042_kbd_values = {
-	.disable	= I8042_CTR_KBDDIS,
-	.irqen 		= I8042_CTR_KBDINT,
-	.mux		= -1,
-	.name		= "KBD",
-};
-
-static struct i8042_values i8042_aux_values = {
-	.disable	= I8042_CTR_AUXDIS,
-	.irqen		= I8042_CTR_AUXINT,
-	.mux		= -1,
-	.name		= "AUX",
+#define I8042_KBD_PORT_NO	0
+#define I8042_AUX_PORT_NO	1
+#define I8042_MUX_PORT_NO	2
+#define I8042_NUM_PORTS		(I8042_NUM_MUX_PORTS + 2)
+static struct i8042_port i8042_ports[I8042_NUM_PORTS] = {
+	{
+		.disable	= I8042_CTR_KBDDIS,
+		.irqen 		= I8042_CTR_KBDINT,
+		.mux		= -1,
+		.name		= "KBD",
+	},
+	{
+		.disable	= I8042_CTR_AUXDIS,
+		.irqen		= I8042_CTR_AUXINT,
+		.mux		= -1,
+		.name		= "AUX",
+	}
 };
 
-static struct i8042_values i8042_mux_values[I8042_NUM_MUX_PORTS];
-
-static struct serio *i8042_kbd_port;
-static struct serio *i8042_aux_port;
-static struct serio *i8042_mux_port[I8042_NUM_MUX_PORTS];
 static unsigned char i8042_initial_ctr;
 static unsigned char i8042_ctr;
 static unsigned char i8042_mux_open;
@@ -117,6 +119,7 @@
 static struct timer_list i8042_timer;
 static struct platform_device *i8042_platform_device;
 
+
 /*
  * Shared IRQ's require a device pointer, but this driver doesn't support
  * multiple devices
@@ -250,19 +253,19 @@
  * i8042_aux_write() sends a byte out through the aux interface.
  */
 
-static int i8042_aux_write(struct serio *port, unsigned char c)
+static int i8042_aux_write(struct serio *serio, unsigned char c)
 {
-	struct i8042_values *values = port->port_data;
+	struct i8042_port *port = serio->port_data;
 	int retval;
 
 /*
  * Send the byte out.
  */
 
-	if (values->mux == -1)
+	if (port->mux == -1)
 		retval = i8042_command(&c, I8042_CMD_AUX_SEND);
 	else
-		retval = i8042_command(&c, I8042_CMD_MUX_SEND + values->mux);
+		retval = i8042_command(&c, I8042_CMD_MUX_SEND + port->mux);
 
 /*
  * Make sure the interrupt happens and the character is received even
@@ -278,9 +281,10 @@
  * i8042_activate_port() enables port on a chip.
  */
 
-static int i8042_activate_port(struct serio *port)
+static int i8042_activate_port(struct i8042_port *port)
 {
-	struct i8042_values *values = port->port_data;
+	if (!port->serio)
+		return -1;
 
 	i8042_flush();
 
@@ -288,12 +292,12 @@
 	 * Enable port again here because it is disabled if we are
 	 * resuming (normally it is enabled already).
 	 */
-	i8042_ctr &= ~values->disable;
+	i8042_ctr &= ~port->disable;
 
-	i8042_ctr |= values->irqen;
+	i8042_ctr |= port->irqen;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		i8042_ctr &= ~values->irqen;
+		i8042_ctr &= ~port->irqen;
 		return -1;
 	}
 
@@ -306,22 +310,22 @@
  * It allocates the interrupt and calls i8042_enable_port.
  */
 
-static int i8042_open(struct serio *port)
+static int i8042_open(struct serio *serio)
 {
-	struct i8042_values *values = port->port_data;
+	struct i8042_port *port = serio->port_data;
 
-	if (values->mux != -1)
+	if (port->mux != -1)
 		if (i8042_mux_open++)
 			return 0;
 
-	if (request_irq(values->irq, i8042_interrupt,
+	if (request_irq(port->irq, i8042_interrupt,
 			SA_SHIRQ, "i8042", i8042_request_irq_cookie)) {
-		printk(KERN_ERR "i8042.c: Can't get irq %d for %s, unregistering the port.\n", values->irq, values->name);
+		printk(KERN_ERR "i8042.c: Can't get irq %d for %s, unregistering the port.\n", port->irq, port->name);
 		goto irq_fail;
 	}
 
 	if (i8042_activate_port(port)) {
-		printk(KERN_ERR "i8042.c: Can't activate %s, unregistering the port\n", values->name);
+		printk(KERN_ERR "i8042.c: Can't activate %s, unregistering the port\n", port->name);
 		goto activate_fail;
 	}
 
@@ -330,11 +334,10 @@
 	return 0;
 
 activate_fail:
-	free_irq(values->irq, i8042_request_irq_cookie);
+	free_irq(port->irq, i8042_request_irq_cookie);
 
 irq_fail:
-	values->exists = 0;
-	serio_unregister_port_delayed(port);
+	serio_unregister_port_delayed(serio);
 
 	return -1;
 }
@@ -345,27 +348,58 @@
  * the BIOS could have used the AUX interrupt for PCI.
  */
 
-static void i8042_close(struct serio *port)
+static void i8042_close(struct serio *serio)
 {
-	struct i8042_values *values = port->port_data;
+	struct i8042_port *port = serio->port_data;
 
-	if (values->mux != -1)
+	if (port->mux != -1)
 		if (--i8042_mux_open)
 			return;
 
-	i8042_ctr &= ~values->irqen;
+	i8042_ctr &= ~port->irqen;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		printk(KERN_ERR "i8042.c: Can't write CTR while closing %s.\n", values->name);
-		return;
+		printk(KERN_WARNING "i8042.c: Can't write CTR while closing %s.\n", port->name);
+/*
+ * We still want to continue and free IRQ so if more data keeps coming in
+ * kernel will just ignore the irq.
+ */
 	}
 
-	free_irq(values->irq, i8042_request_irq_cookie);
+	free_irq(port->irq, i8042_request_irq_cookie);
 
 	i8042_flush();
 }
 
 /*
+ * i8042_start() is called by serio core when port is about to finish
+ * registering. It will mark port as existing so i8042_interrupt can
+ * start sending data through it.
+ */
+static int i8042_start(struct serio *serio)
+{
+	struct i8042_port *port = serio->port_data;
+
+	port->exists = 1;
+	mb();
+	return 0;
+}
+
+/*
+ * i8042_stop() marks serio port as non-existing so i8042_interrupt
+ * will not try to send data to the port that is about to go away.
+ * The function is called by serio core as part of unregister procedure.
+ */
+static void i8042_stop(struct serio *serio)
+{
+	struct i8042_port *port = serio->port_data;
+
+	port->exists = 0;
+	synchronize_kernel();
+	port->serio = NULL;
+}
+
+/*
  * i8042_interrupt() is the most important function in this driver -
  * it handles the interrupts from the i8042, and sends incoming bytes
  * to the upper layers.
@@ -373,25 +407,25 @@
 
 static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	struct i8042_port *port;
 	unsigned long flags;
-	unsigned char str, data = 0;
+	unsigned char str, data;
 	unsigned int dfl;
-	unsigned int aux_idx;
+	unsigned int port_no;
 	int ret;
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
 	spin_lock_irqsave(&i8042_lock, flags);
 	str = i8042_read_status();
-	if (str & I8042_STR_OBF)
-		data = i8042_read_data();
-	spin_unlock_irqrestore(&i8042_lock, flags);
-
-	if (~str & I8042_STR_OBF) {
+	if (unlikely(~str & I8042_STR_OBF)) {
+		spin_unlock_irqrestore(&i8042_lock, flags);
 		if (irq) dbg("Interrupt %d, without any data", irq);
 		ret = 0;
 		goto out;
 	}
+	data = i8042_read_data();
+	spin_unlock_irqrestore(&i8042_lock, flags);
 
 	if (i8042_mux_present && (str & I8042_STR_AUXDATA)) {
 		static unsigned long last_transmit;
@@ -423,39 +457,28 @@
 			}
 		}
 
-		aux_idx = (str >> 6) & 3;
-
-		dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
-			data, aux_idx, irq,
-			dfl & SERIO_PARITY ? ", bad parity" : "",
-			dfl & SERIO_TIMEOUT ? ", timeout" : "");
-
-		if (likely(i8042_mux_values[aux_idx].exists))
-			serio_interrupt(i8042_mux_port[aux_idx], data, dfl, regs);
-
+		port_no = I8042_MUX_PORT_NO + ((str >> 6) & 3);
 		last_str = str;
 		last_transmit = jiffies;
-		goto irq_ret;
+	} else {
+
+		dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
+		      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
+
+		port_no = (str & I8042_STR_AUXDATA) ?
+				I8042_AUX_PORT_NO : I8042_KBD_PORT_NO;
 	}
 
-	dfl = ((str & I8042_STR_PARITY) ? SERIO_PARITY : 0) |
-	      ((str & I8042_STR_TIMEOUT) ? SERIO_TIMEOUT : 0);
+	port = &i8042_ports[port_no];
 
 	dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
-		data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq,
-		dfl & SERIO_PARITY ? ", bad parity" : "",
-		dfl & SERIO_TIMEOUT ? ", timeout" : "");
+	    data, port->name, irq,
+	    dfl & SERIO_PARITY ? ", bad parity" : "",
+	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
+	if (likely(port->exists))
+		serio_interrupt(port->serio, data, dfl, regs);
 
-	if (str & I8042_STR_AUXDATA) {
-		if (likely(i8042_aux_values.exists))
-			serio_interrupt(i8042_aux_port, data, dfl, regs);
-	} else {
-		if (likely(i8042_kbd_values.exists))
-			serio_interrupt(i8042_kbd_port, data, dfl, regs);
-	}
-
-irq_ret:
 	ret = 1;
 out:
 	return IRQ_RETVAL(ret);
@@ -467,7 +490,7 @@
  * Legacy) mode.
  */
 
-static int i8042_enable_mux_mode(struct i8042_values *values, unsigned char *mux_version)
+static int i8042_enable_mux_mode(unsigned char *mux_version)
 {
 
 	unsigned char param;
@@ -505,7 +528,7 @@
  * the controller has been switched into Multiplexed mode
  */
 
-static int i8042_enable_mux_ports(struct i8042_values *values)
+static int i8042_enable_mux_ports(void)
 {
 	unsigned char param;
 	int i;
@@ -540,11 +563,11 @@
  * LCS/Telegraphics.
  */
 
-static int __init i8042_check_mux(struct i8042_values *values)
+static int __init i8042_check_mux(void)
 {
 	unsigned char mux_version;
 
-	if (i8042_enable_mux_mode(values, &mux_version))
+	if (i8042_enable_mux_mode(&mux_version))
 		return -1;
 
 	/* Workaround for broken chips which seem to support MUX, but in reality don't. */
@@ -555,7 +578,7 @@
 	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
 		(mux_version >> 4) & 0xf, mux_version & 0xf);
 
-	if (i8042_enable_mux_ports(values))
+	if (i8042_enable_mux_ports())
 		return -1;
 
 	i8042_mux_present = 1;
@@ -568,7 +591,7 @@
  * the presence of an AUX interface.
  */
 
-static int __init i8042_check_aux(struct i8042_values *values)
+static int __init i8042_check_aux(void)
 {
 	unsigned char param;
 	static int i8042_check_aux_cookie;
@@ -578,10 +601,10 @@
  * in trying to detect AUX presence.
  */
 
-	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
-				"i8042", &i8042_check_aux_cookie))
+	if (request_irq(i8042_ports[I8042_AUX_PORT_NO].irq, i8042_interrupt,
+			SA_SHIRQ, "i8042", &i8042_check_aux_cookie))
                 return -1;
-	free_irq(values->irq, &i8042_check_aux_cookie);
+	free_irq(i8042_ports[I8042_AUX_PORT_NO].irq, &i8042_check_aux_cookie);
 
 /*
  * Get rid of bytes in the queue.
@@ -646,27 +669,25 @@
  * registers it, and reports to the user.
  */
 
-static int __init i8042_port_register(struct serio *port)
+static int __init i8042_port_register(struct i8042_port *port)
 {
-	struct i8042_values *values = port->port_data;
-
-	values->exists = 1;
-
-	i8042_ctr &= ~values->disable;
+	i8042_ctr &= ~port->disable;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
 		printk(KERN_WARNING "i8042.c: Can't write CTR while registering.\n");
-		values->exists = 0;
+		kfree(port->serio);
+		port->serio = NULL;
+		i8042_ctr |= port->disable;
 		return -1;
 	}
 
 	printk(KERN_INFO "serio: i8042 %s port at %#lx,%#lx irq %d\n",
-	       values->name,
+	       port->name,
 	       (unsigned long) I8042_DATA_REG,
 	       (unsigned long) I8042_COMMAND_REG,
-	       values->irq);
+	       port->irq);
 
-	serio_register_port(port);
+	serio_register_port(port->serio);
 
 	return 0;
 }
@@ -811,15 +832,9 @@
  * Reset anything that is connected to the ports.
  */
 
-	if (i8042_kbd_values.exists)
-		serio_cleanup(i8042_kbd_port);
-
-	if (i8042_aux_values.exists)
-		serio_cleanup(i8042_aux_port);
-
-	for (i = 0; i < I8042_NUM_MUX_PORTS; i++)
-		if (i8042_mux_values[i].exists)
-			serio_cleanup(i8042_mux_port[i]);
+	for (i = 0; i < I8042_NUM_PORTS; i++)
+		if (i8042_ports[i].exists)
+			serio_cleanup(i8042_ports[i].serio);
 
 	i8042_controller_reset();
 }
@@ -897,8 +912,7 @@
 	}
 
 	if (i8042_mux_present)
-		if (i8042_enable_mux_mode(&i8042_aux_values, NULL) ||
-		    i8042_enable_mux_ports(&i8042_aux_values)) {
+		if (i8042_enable_mux_mode(NULL) || i8042_enable_mux_ports()) {
 			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't work.\n");
 		}
 
@@ -906,15 +920,9 @@
  * Reconnect anything that was connected to the ports.
  */
 
-	if (i8042_kbd_values.exists && i8042_activate_port(i8042_kbd_port) == 0)
-		serio_reconnect(i8042_kbd_port);
-
-	if (i8042_aux_values.exists && i8042_activate_port(i8042_aux_port) == 0)
-		serio_reconnect(i8042_aux_port);
-
-	for (i = 0; i < I8042_NUM_MUX_PORTS; i++)
-		if (i8042_mux_values[i].exists && i8042_activate_port(i8042_mux_port[i]) == 0)
-			serio_reconnect(i8042_mux_port[i]);
+	for (i = 0; i < I8042_NUM_PORTS; i++)
+		if (i8042_activate_port(&i8042_ports[i]) == 0)
+			serio_reconnect(i8042_ports[i].serio);
 /*
  * Restart timer (for polling "stuck" data)
  */
@@ -944,9 +952,10 @@
 	.shutdown	= i8042_shutdown,
 };
 
-static struct serio * __init i8042_allocate_kbd_port(void)
+static void __init i8042_create_kbd_port(void)
 {
 	struct serio *serio;
+	struct i8042_port *port = &i8042_ports[I8042_KBD_PORT_NO];
 
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
@@ -955,18 +964,22 @@
 		serio->write		= i8042_dumbkbd ? NULL : i8042_kbd_write,
 		serio->open		= i8042_open,
 		serio->close		= i8042_close,
-		serio->port_data	= &i8042_kbd_values,
+		serio->start		= i8042_start,
+		serio->stop		= i8042_stop,
+		serio->port_data	= port,
 		serio->dev.parent	= &i8042_platform_device->dev;
 		strlcpy(serio->name, "i8042 Kbd Port", sizeof(serio->name));
 		strlcpy(serio->phys, I8042_KBD_PHYS_DESC, sizeof(serio->phys));
-	}
 
-	return serio;
+		port->serio = serio;
+		i8042_port_register(port);
+	}
 }
 
-static struct serio * __init i8042_allocate_aux_port(void)
+static void __init i8042_create_aux_port(void)
 {
 	struct serio *serio;
+	struct i8042_port *port = &i8042_ports[I8042_AUX_PORT_NO];
 
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
@@ -975,38 +988,44 @@
 		serio->write		= i8042_aux_write;
 		serio->open		= i8042_open;
 		serio->close		= i8042_close;
-		serio->port_data	= &i8042_aux_values,
+		serio->start		= i8042_start,
+		serio->stop		= i8042_stop,
+		serio->port_data	= port,
 		serio->dev.parent	= &i8042_platform_device->dev;
 		strlcpy(serio->name, "i8042 Aux Port", sizeof(serio->name));
 		strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
-	}
 
-	return serio;
+		port->serio = serio;
+		i8042_port_register(port);
+	}
 }
 
-static struct serio * __init i8042_allocate_mux_port(int index)
+static void __init i8042_create_mux_port(int index)
 {
 	struct serio *serio;
-	struct i8042_values *values = &i8042_mux_values[index];
+	struct i8042_port *port = &i8042_ports[I8042_MUX_PORT_NO + index];
 
 	serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
-		*values = i8042_aux_values;
-		snprintf(values->name, sizeof(values->name), "AUX%d", index);
-		values->mux = index;
-
 		memset(serio, 0, sizeof(struct serio));
 		serio->type		= SERIO_8042;
 		serio->write		= i8042_aux_write;
 		serio->open		= i8042_open;
 		serio->close		= i8042_close;
-		serio->port_data	= values;
+		serio->start		= i8042_start,
+		serio->stop		= i8042_stop,
+		serio->port_data	= port;
 		serio->dev.parent	= &i8042_platform_device->dev;
 		snprintf(serio->name, sizeof(serio->name), "i8042 Aux-%d Port", index);
 		snprintf(serio->phys, sizeof(serio->phys), I8042_MUX_PHYS_DESC, index + 1);
-	}
 
-	return serio;
+		*port = i8042_ports[I8042_AUX_PORT_NO];
+		port->exists = 0;
+		snprintf(port->name, sizeof(port->name), "AUX%d", index);
+		port->mux = index;
+		port->serio = serio;
+		i8042_port_register(port);
+	}
 }
 
 int __init i8042_init(void)
@@ -1022,8 +1041,8 @@
 	if (i8042_platform_init())
 		return -EBUSY;
 
-	i8042_aux_values.irq = I8042_AUX_IRQ;
-	i8042_kbd_values.irq = I8042_KBD_IRQ;
+	i8042_ports[I8042_AUX_PORT_NO].irq = I8042_AUX_IRQ;
+	i8042_ports[I8042_KBD_PORT_NO].irq = I8042_KBD_IRQ;
 
 	if (i8042_controller_init())
 		return -ENODEV;
@@ -1038,23 +1057,15 @@
 		return PTR_ERR(i8042_platform_device);
 	}
 
-	if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values)) {
-		if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values))
-			for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
-				i8042_mux_port[i] = i8042_allocate_mux_port(i);
-				if (i8042_mux_port[i])
-					i8042_port_register(i8042_mux_port[i]);
-			}
-		else {
-			i8042_aux_port = i8042_allocate_aux_port();
-			if (i8042_aux_port)
-				i8042_port_register(i8042_aux_port);
-		}
+	if (!i8042_noaux && !i8042_check_aux()) {
+		if (!i8042_nomux && !i8042_check_mux())
+			for (i = 0; i < I8042_NUM_MUX_PORTS; i++)
+				i8042_create_mux_port(i);
+		else
+			i8042_create_aux_port();
 	}
 
-	i8042_kbd_port = i8042_allocate_kbd_port();
-	if (i8042_kbd_port)
-		i8042_port_register(i8042_kbd_port);
+	i8042_create_kbd_port();
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
@@ -1067,15 +1078,9 @@
 
 	i8042_controller_cleanup();
 
-	if (i8042_kbd_values.exists)
-		serio_unregister_port(i8042_kbd_port);
-
-	if (i8042_aux_values.exists)
-		serio_unregister_port(i8042_aux_port);
-
-	for (i = 0; i < I8042_NUM_MUX_PORTS; i++)
-		if (i8042_mux_values[i].exists)
-			serio_unregister_port(i8042_mux_port[i]);
+	for (i = 0; i < I8042_NUM_PORTS; i++)
+		if (i8042_ports[i].exists)
+			serio_unregister_port(i8042_ports[i].serio);
 
 	del_timer_sync(&i8042_timer);
 
diff -Nru a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
--- a/drivers/input/serio/i8042.h	2004-11-12 01:00:34 -05:00
+++ b/drivers/input/serio/i8042.h	2004-11-12 01:00:34 -05:00
@@ -117,13 +117,13 @@
  */
 
 #ifdef DEBUG
-static unsigned long i8042_start;
-#define dbg_init() do { i8042_start = jiffies; } while (0)
+static unsigned long i8042_start_time;
+#define dbg_init() do { i8042_start_time = jiffies; } while (0)
 #define dbg(format, arg...) 							\
 	do { 									\
 		if (i8042_debug)						\
 			printk(KERN_DEBUG __FILE__ ": " format " [%d]\n" ,	\
-	 			## arg, (int) (jiffies - i8042_start));		\
+	 			## arg, (int) (jiffies - i8042_start_time));	\
 	} while (0)
 #else
 #define dbg_init() do { } while (0)
