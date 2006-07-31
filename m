Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWGaCdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWGaCdH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 22:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWGaCdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 22:33:06 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:20037 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S932413AbWGaCdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 22:33:04 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAAEJzUSBUg
From: Dmitry Torokhov <dtor@insightbb.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC/RFT] Remove polling timer from i8042 - V2
Date: Sun, 30 Jul 2006 22:33:00 -0400
User-Agent: KMail/1.9.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>
References: <200607270029.05066.dtor@insightbb.com> <d120d5000607280720u3db9b7dmb7f05cb7e9424934@mail.gmail.com> <20060728202737.GC5313@suse.cz>
In-Reply-To: <20060728202737.GC5313@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607302233.01141.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another version of the patch removing polling timer from i8042, this
one implements Vojtech's suggestion and tests AUX IRQ delivery before
creating AUX serio port. This shoudl help with older boards that used
to reserve AUX IRQ for other purposes if mouse was not detected by
their BIOS at boot time.

Andrew, could you please add it to -mm so it can get wider testing?
 
-- 
Dmitry

Input: i8042 - get rid of polling timer

Remove polling timer that was used to detect keybord/mice hotplug and
register both IRQs right away instead of waiting for a driver to
attach to a port.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |  743 ++++++++++++++++++++++----------------------
 1 files changed, 387 insertions(+), 356 deletions(-)

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -90,46 +90,24 @@ static DEFINE_SPINLOCK(i8042_lock);
 struct i8042_port {
 	struct serio *serio;
 	int irq;
-	unsigned char disable;
-	unsigned char irqen;
 	unsigned char exists;
 	signed char mux;
-	char name[8];
 };
 
 #define I8042_KBD_PORT_NO	0
 #define I8042_AUX_PORT_NO	1
 #define I8042_MUX_PORT_NO	2
 #define I8042_NUM_PORTS		(I8042_NUM_MUX_PORTS + 2)
-static struct i8042_port i8042_ports[I8042_NUM_PORTS] = {
-	{
-		.disable	= I8042_CTR_KBDDIS,
-		.irqen		= I8042_CTR_KBDINT,
-		.mux		= -1,
-		.name		= "KBD",
-	},
-	{
-		.disable	= I8042_CTR_AUXDIS,
-		.irqen		= I8042_CTR_AUXINT,
-		.mux		= -1,
-		.name		= "AUX",
-	}
-};
+
+static struct i8042_port i8042_ports[I8042_NUM_PORTS];
 
 static unsigned char i8042_initial_ctr;
 static unsigned char i8042_ctr;
-static unsigned char i8042_mux_open;
 static unsigned char i8042_mux_present;
-static struct timer_list i8042_timer;
+static unsigned char i8042_kbd_irq_registered;
+static unsigned char i8042_aux_irq_registered;
 static struct platform_device *i8042_platform_device;
 
-
-/*
- * Shared IRQ's require a device pointer, but this driver doesn't support
- * multiple devices
- */
-#define i8042_request_irq_cookie (&i8042_timer)
-
 static irqreturn_t i8042_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 /*
@@ -141,6 +119,7 @@ static irqreturn_t i8042_interrupt(int i
 static int i8042_wait_read(void)
 {
 	int i = 0;
+
 	while ((~i8042_read_status() & I8042_STR_OBF) && (i < I8042_CTL_TIMEOUT)) {
 		udelay(50);
 		i++;
@@ -151,6 +130,7 @@ static int i8042_wait_read(void)
 static int i8042_wait_write(void)
 {
 	int i = 0;
+
 	while ((i8042_read_status() & I8042_STR_IBF) && (i < I8042_CTL_TIMEOUT)) {
 		udelay(50);
 		i++;
@@ -192,48 +172,57 @@ static int i8042_flush(void)
  * encoded in bits 8-11 of the command number.
  */
 
-static int i8042_command(unsigned char *param, int command)
+static int __i8042_command(unsigned char *param, int command)
 {
-	unsigned long flags;
-	int i, retval, auxerr = 0;
+	int i, error;
 
 	if (i8042_noloop && command == I8042_CMD_AUX_LOOP)
 		return -1;
 
-	spin_lock_irqsave(&i8042_lock, flags);
-
-	if ((retval = i8042_wait_write()))
-		goto out;
+	error = i8042_wait_write();
+	if (error)
+		return error;
 
 	dbg("%02x -> i8042 (command)", command & 0xff);
 	i8042_write_command(command & 0xff);
 
 	for (i = 0; i < ((command >> 12) & 0xf); i++) {
-		if ((retval = i8042_wait_write()))
-			goto out;
+		error = i8042_wait_write();
+		if (error)
+			return error;
 		dbg("%02x -> i8042 (parameter)", param[i]);
 		i8042_write_data(param[i]);
 	}
 
 	for (i = 0; i < ((command >> 8) & 0xf); i++) {
-		if ((retval = i8042_wait_read()))
-			goto out;
+		error = i8042_wait_read();
+		if (error) {
+			dbg("     -- i8042 (timeout)");
+			return error;
+		}
 
 		if (command == I8042_CMD_AUX_LOOP &&
 		    !(i8042_read_status() & I8042_STR_AUXDATA)) {
-			retval = auxerr = -1;
-			goto out;
+			dbg("     -- i8042 (auxerr)");
+			return -1;
 		}
 
 		param[i] = i8042_read_data();
 		dbg("%02x <- i8042 (return)", param[i]);
 	}
 
-	if (retval)
-		dbg("     -- i8042 (%s)", auxerr ? "auxerr" : "timeout");
+	return 0;
+}
 
- out:
+static int i8042_command(unsigned char *param, int command)
+{
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&i8042_lock, flags);
+	retval = __i8042_command(param, command);
 	spin_unlock_irqrestore(&i8042_lock, flags);
+
 	return retval;
 }
 
@@ -248,7 +237,7 @@ static int i8042_kbd_write(struct serio 
 
 	spin_lock_irqsave(&i8042_lock, flags);
 
-	if(!(retval = i8042_wait_write())) {
+	if (!(retval = i8042_wait_write())) {
 		dbg("%02x -> i8042 (kbd-data)", c);
 		i8042_write_data(c);
 	}
@@ -287,100 +276,6 @@ static int i8042_aux_write(struct serio 
 }
 
 /*
- * i8042_activate_port() enables port on a chip.
- */
-
-static int i8042_activate_port(struct i8042_port *port)
-{
-	if (!port->serio)
-		return -1;
-
-	i8042_flush();
-
-	/*
-	 * Enable port again here because it is disabled if we are
-	 * resuming (normally it is enabled already).
-	 */
-	i8042_ctr &= ~port->disable;
-
-	i8042_ctr |= port->irqen;
-
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		i8042_ctr &= ~port->irqen;
-		return -1;
-	}
-
-	return 0;
-}
-
-
-/*
- * i8042_open() is called when a port is open by the higher layer.
- * It allocates the interrupt and calls i8042_enable_port.
- */
-
-static int i8042_open(struct serio *serio)
-{
-	struct i8042_port *port = serio->port_data;
-
-	if (port->mux != -1)
-		if (i8042_mux_open++)
-			return 0;
-
-	if (request_irq(port->irq, i8042_interrupt,
-			IRQF_SHARED, "i8042", i8042_request_irq_cookie)) {
-		printk(KERN_ERR "i8042.c: Can't get irq %d for %s, unregistering the port.\n", port->irq, port->name);
-		goto irq_fail;
-	}
-
-	if (i8042_activate_port(port)) {
-		printk(KERN_ERR "i8042.c: Can't activate %s, unregistering the port\n", port->name);
-		goto activate_fail;
-	}
-
-	i8042_interrupt(0, NULL, NULL);
-
-	return 0;
-
- activate_fail:
-	free_irq(port->irq, i8042_request_irq_cookie);
-
- irq_fail:
-	serio_unregister_port_delayed(serio);
-
-	return -1;
-}
-
-/*
- * i8042_close() frees the interrupt, so that it can possibly be used
- * by another driver. We never know - if the user doesn't have a mouse,
- * the BIOS could have used the AUX interrupt for PCI.
- */
-
-static void i8042_close(struct serio *serio)
-{
-	struct i8042_port *port = serio->port_data;
-
-	if (port->mux != -1)
-		if (--i8042_mux_open)
-			return;
-
-	i8042_ctr &= ~port->irqen;
-
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		printk(KERN_WARNING "i8042.c: Can't write CTR while closing %s.\n", port->name);
-/*
- * We still want to continue and free IRQ so if more data keeps coming in
- * kernel will just ignore the irq.
- */
-	}
-
-	free_irq(port->irq, i8042_request_irq_cookie);
-
-	i8042_flush();
-}
-
-/*
  * i8042_start() is called by serio core when port is about to finish
  * registering. It will mark port as existing so i8042_interrupt can
  * start sending data through it.
@@ -423,8 +318,6 @@ static irqreturn_t i8042_interrupt(int i
 	unsigned int port_no;
 	int ret;
 
-	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
-
 	spin_lock_irqsave(&i8042_lock, flags);
 	str = i8042_read_status();
 	if (unlikely(~str & I8042_STR_OBF)) {
@@ -480,8 +373,8 @@ static irqreturn_t i8042_interrupt(int i
 
 	port = &i8042_ports[port_no];
 
-	dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
-	    data, port->name, irq,
+	dbg("%02x <- i8042 (interrupt, %d, %d%s%s)",
+	    data, port_no, irq,
 	    dfl & SERIO_PARITY ? ", bad parity" : "",
 	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
@@ -494,6 +387,58 @@ static irqreturn_t i8042_interrupt(int i
 }
 
 /*
+ * i8042_enable_kbd_port enables keybaord port on chip
+ */
+
+static int i8042_enable_kbd_port(void)
+{
+	i8042_ctr &= ~I8042_CTR_KBDDIS;
+	i8042_ctr |= I8042_CTR_KBDINT;
+
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		printk(KERN_ERR "i8042.c: Failed to enable KBD port.\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * i8042_enable_aux_port enables AUX (mouse) port on chip
+ */
+
+static int i8042_enable_aux_port(void)
+{
+	i8042_ctr &= ~I8042_CTR_AUXDIS;
+	i8042_ctr |= I8042_CTR_AUXINT;
+
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		printk(KERN_ERR "i8042.c: Failed to enable AUX port.\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * i8042_enable_mux_ports enables 4 individual AUX ports after
+ * the controller has been switched into Multiplexed mode
+ */
+
+static int i8042_enable_mux_ports(void)
+{
+	unsigned char param;
+	int i;
+
+	for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
+		i8042_command(&param, I8042_CMD_MUX_PFX + i);
+		i8042_command(&param, I8042_CMD_AUX_ENABLE);
+	}
+
+	return 0;
+}
+
+/*
  * i8042_set_mux_mode checks whether the controller has an active
  * multiplexor and puts the chip into Multiplexed (1) or Legacy (0) mode.
  */
@@ -510,8 +455,7 @@ static int i8042_set_mux_mode(unsigned i
 
 /*
  * Internal loopback test - send three bytes, they should come back from the
- * mouse interface, the last should be version. Note that we negate mouseport
- * command responses for the i8042_check_aux() routine.
+ * mouse interface, the last should be version.
  */
 
 	param = 0xf0;
@@ -530,67 +474,67 @@ static int i8042_set_mux_mode(unsigned i
 	return 0;
 }
 
-
 /*
- * i8042_enable_mux_ports enables 4 individual AUX ports after
- * the controller has been switched into Multiplexed mode
+ * i8042_check_mux() checks whether the controller supports the PS/2 Active
+ * Multiplexing specification by Synaptics, Phoenix, Insyde and
+ * LCS/Telegraphics.
  */
 
-static int i8042_enable_mux_ports(void)
+static int __devinit i8042_check_mux(void)
 {
-	unsigned char param;
-	int i;
+	unsigned char mux_version;
+
+	if (i8042_set_mux_mode(1, &mux_version))
+		return -1;
+
 /*
- * Disable all muxed ports by disabling AUX.
+ * Workaround for interference with USB Legacy emulation
+ * that causes a v10.12 MUX to be found.
  */
+	if (mux_version == 0xAC)
+		return -1;
+
+	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
+		(mux_version >> 4) & 0xf, mux_version & 0xf);
 
+/*
+ * Disable all muxed ports by disabling AUX.
+ */
 	i8042_ctr |= I8042_CTR_AUXDIS;
 	i8042_ctr &= ~I8042_CTR_AUXINT;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
 		printk(KERN_ERR "i8042.c: Failed to disable AUX port, can't use MUX.\n");
-		return -1;
+		return -EIO;
 	}
 
-/*
- * Enable all muxed ports.
- */
-
-	for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
-		i8042_command(&param, I8042_CMD_MUX_PFX + i);
-		i8042_command(&param, I8042_CMD_AUX_ENABLE);
-	}
+	i8042_mux_present = 1;
 
 	return 0;
 }
 
-
 /*
- * i8042_check_mux() checks whether the controller supports the PS/2 Active
- * Multiplexing specification by Synaptics, Phoenix, Insyde and
- * LCS/Telegraphics.
+ * The following is used to test AUX IRQ delivery.
  */
+static struct completion i8042_aux_irq_delivered __devinitdata;
+static int i8042_irq_being_tested __devinitdata;
 
-static int __devinit i8042_check_mux(void)
+static irqreturn_t __devinit i8042_aux_test_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
-	unsigned char mux_version;
-
-	if (i8042_set_mux_mode(1, &mux_version))
-		return -1;
-
-	/* Workaround for interference with USB Legacy emulation */
-	/* that causes a v10.12 MUX to be found. */
-	if (mux_version == 0xAC)
-		return -1;
-
-	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
-		(mux_version >> 4) & 0xf, mux_version & 0xf);
+	unsigned long flags;
+	unsigned char str, data;
 
-	if (i8042_enable_mux_ports())
-		return -1;
+	spin_lock_irqsave(&i8042_lock, flags);
+	str = i8042_read_status();
+	if (str & I8042_STR_OBF) {
+		data = i8042_read_data();
+		if (i8042_irq_being_tested &&
+		    data == 0xa5 && (str & I8042_STR_AUXDATA))
+			complete(&i8042_aux_irq_delivered);
+	}
+	spin_unlock_irqrestore(&i8042_lock, flags);
 
-	i8042_mux_present = 1;
-	return 0;
+	return IRQ_HANDLED;
 }
 
 
@@ -601,18 +545,10 @@ static int __devinit i8042_check_mux(voi
 
 static int __devinit i8042_check_aux(void)
 {
+	int retval = -1;
+	int irq_registered = 0;
+	unsigned long flags;
 	unsigned char param;
-	static int i8042_check_aux_cookie;
-
-/*
- * Check if AUX irq is available. If it isn't, then there is no point
- * in trying to detect AUX presence.
- */
-
-	if (request_irq(i8042_ports[I8042_AUX_PORT_NO].irq, i8042_interrupt,
-			IRQF_SHARED, "i8042", &i8042_check_aux_cookie))
-                return -1;
-	free_irq(i8042_ports[I8042_AUX_PORT_NO].irq, &i8042_check_aux_cookie);
 
 /*
  * Get rid of bytes in the queue.
@@ -637,9 +573,9 @@ static int __devinit i8042_check_aux(voi
  * AUX ports, we test for this only when the LOOP command failed.
  */
 
-		if (i8042_command(&param, I8042_CMD_AUX_TEST)
-			|| (param && param != 0xfa && param != 0xff))
-				return -1;
+		if (i8042_command(&param, I8042_CMD_AUX_TEST) ||
+		    (param && param != 0xfa && param != 0xff))
+			return -1;
 	}
 
 /*
@@ -659,54 +595,74 @@ static int __devinit i8042_check_aux(voi
 		return -1;
 
 /*
- * Disable the interface.
+ * Test AUX IRQ delivery to make sure BIOS did not grab the IRQ and
+ * used it for a PCI card or somethig else.
  */
 
-	i8042_ctr |= I8042_CTR_AUXDIS;
-	i8042_ctr &= ~I8042_CTR_AUXINT;
+	if (i8042_noloop) {
+/*
+ * Without LOOP command we can't test AUX IRQ delivery. Assume the port
+ * is working and hope we are right.
+ */
+		retval = 0;
+		goto out;
+	}
 
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
-		return -1;
+	if (request_irq(I8042_AUX_IRQ, i8042_aux_test_irq, IRQF_SHARED,
+			"i8042", i8042_platform_device))
+		goto out;
 
-	return 0;
-}
+	irq_registered = 1;
+
+	if (i8042_enable_aux_port())
+		goto out;
 
+	spin_lock_irqsave(&i8042_lock, flags);
+
+	init_completion(&i8042_aux_irq_delivered);
+	i8042_irq_being_tested = 1;
+
+	param = 0xa5;
+	retval = __i8042_command(&param, I8042_CMD_AUX_LOOP & 0xf0ff);
+
+	spin_unlock_irqrestore(&i8042_lock, flags);
+
+	if (retval)
+		goto out;
+
+	if (wait_for_completion_timeout(&i8042_aux_irq_delivered,
+					msecs_to_jiffies(250)) == 0)
+		retval = -1;
+
+ out:
 
 /*
- * i8042_port_register() marks the device as existing,
- * registers it, and reports to the user.
+ * Disable the interface.
  */
 
-static int __devinit i8042_port_register(struct i8042_port *port)
-{
-	i8042_ctr &= ~port->disable;
-
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		printk(KERN_WARNING "i8042.c: Can't write CTR while registering.\n");
-		kfree(port->serio);
-		port->serio = NULL;
-		i8042_ctr |= port->disable;
-		return -EIO;
-	}
+	i8042_ctr |= I8042_CTR_AUXDIS;
+	i8042_ctr &= ~I8042_CTR_AUXINT;
 
-	printk(KERN_INFO "serio: i8042 %s port at %#lx,%#lx irq %d\n",
-	       port->name,
-	       (unsigned long) I8042_DATA_REG,
-	       (unsigned long) I8042_COMMAND_REG,
-	       port->irq);
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
+		retval = -1;
 
-	serio_register_port(port->serio);
+	if (irq_registered)
+		free_irq(I8042_AUX_IRQ, i8042_platform_device);
 
-	return 0;
+	return retval;
 }
 
-
-static void i8042_timer_func(unsigned long data)
+static int i8042_controller_check(void)
 {
-	i8042_interrupt(0, NULL, NULL);
+	if (i8042_flush() == I8042_BUFFER_SIZE) {
+		printk(KERN_ERR "i8042.c: No controller found.\n");
+		return -ENODEV;
+	}
+
+	return 0;
 }
 
-static int i8042_ctl_test(void)
+static int i8042_controller_selftest(void)
 {
 	unsigned char param;
 
@@ -715,13 +671,13 @@ static int i8042_ctl_test(void)
 
 	if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
 		printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
-		return -1;
+		return -ENODEV;
 	}
 
 	if (param != I8042_RET_CTL_TEST) {
 		printk(KERN_ERR "i8042.c: i8042 controller selftest failed. (%#x != %#x)\n",
 			 param, I8042_RET_CTL_TEST);
-		return -1;
+		return -EIO;
 	}
 
 	return 0;
@@ -738,25 +694,12 @@ static int i8042_controller_init(void)
 	unsigned long flags;
 
 /*
- * Test the i8042. We need to know if it thinks it's working correctly
- * before doing anything else.
- */
-
-	if (i8042_flush() == I8042_BUFFER_SIZE) {
-		printk(KERN_ERR "i8042.c: No controller found.\n");
-		return -1;
-	}
-
-	if (i8042_ctl_test())
-		return -1;
-
-/*
  * Save the CTR for restoral on unload / reboot.
  */
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_RCTR)) {
 		printk(KERN_ERR "i8042.c: Can't read CTR while initializing i8042.\n");
-		return -1;
+		return -EIO;
 	}
 
 	i8042_initial_ctr = i8042_ctr;
@@ -782,8 +725,10 @@ static int i8042_controller_init(void)
 	spin_unlock_irqrestore(&i8042_lock, flags);
 
 /*
- * If the chip is configured into nontranslated mode by the BIOS, don't
- * bother enabling translating and be happy.
+ ** If the chip is configured into nontranslated mode by the BIOS, don't
+ ** bother enabling translating and be happy.
+ * If we were in xlate mode before (that means we are resuming)
+ * restore it.
  */
 
 	if (~i8042_ctr & I8042_CTR_XLATE)
@@ -805,7 +750,7 @@ static int i8042_controller_init(void)
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
 		printk(KERN_ERR "i8042.c: Can't write CTR while initializing i8042.\n");
-		return -1;
+		return -EIO;
 	}
 
 	return 0;
@@ -813,15 +758,12 @@ static int i8042_controller_init(void)
 
 
 /*
- * Reset the controller.
+ * Reset the controller and reset CRT to the original value set by BIOS.
  */
+
 static void i8042_controller_reset(void)
 {
-/*
- * Reset the controller if requested.
- */
-
-	i8042_ctl_test();
+	i8042_flush();
 
 /*
  * Disable MUX mode if present.
@@ -831,12 +773,16 @@ static void i8042_controller_reset(void)
 		i8042_set_mux_mode(0, NULL);
 
 /*
- * Restore the original control register setting.
+ * Reset the controller if requested.
  */
 
-	i8042_ctr = i8042_initial_ctr;
+	i8042_controller_selftest();
 
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
+/*
+ * Restore the original control register setting.
+ */
+
+	if (i8042_command(&i8042_initial_ctr, I8042_CMD_CTL_WCTR))
 		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
 }
 
@@ -850,14 +796,12 @@ static void i8042_controller_cleanup(voi
 {
 	int i;
 
-	i8042_flush();
-
 /*
  * Reset anything that is connected to the ports.
  */
 
 	for (i = 0; i < I8042_NUM_PORTS; i++)
-		if (i8042_ports[i].exists)
+		if (i8042_ports[i].serio)
 			serio_cleanup(i8042_ports[i].serio);
 
 	i8042_controller_reset();
@@ -913,8 +857,7 @@ static long i8042_panic_blink(long count
 
 static int i8042_suspend(struct platform_device *dev, pm_message_t state)
 {
-	del_timer_sync(&i8042_timer);
-	i8042_controller_reset();
+	i8042_controller_cleanup();
 
 	return 0;
 }
@@ -926,33 +869,39 @@ static int i8042_suspend(struct platform
 
 static int i8042_resume(struct platform_device *dev)
 {
-	int i;
+	int error;
 
-	if (i8042_ctl_test())
-		return -1;
+	error = i8042_controller_check();
+	if (error)
+		return error;
 
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		printk(KERN_ERR "i8042: Can't write CTR\n");
-		return -1;
-	}
-
-	if (i8042_mux_present)
-		if (i8042_set_mux_mode(1, NULL) || i8042_enable_mux_ports())
-			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't work.\n");
+	error = i8042_controller_selftest();
+	if (error)
+		return error;
 
 /*
- * Activate all ports.
+ * Restore pre-resume CTR value and disable all ports
  */
 
-	for (i = 0; i < I8042_NUM_PORTS; i++)
-		i8042_activate_port(&i8042_ports[i]);
+	i8042_ctr |= I8042_CTR_AUXDIS | I8042_CTR_KBDDIS;
+	i8042_ctr &= ~(I8042_CTR_AUXINT | I8042_CTR_KBDINT);
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		printk(KERN_ERR "i8042: Can't write CTR to resume\n");
+		return -EIO;
+	}
 
-/*
- * Restart timer (for polling "stuck" data)
- */
-	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
+	if (i8042_mux_present) {
+		if (i8042_set_mux_mode(1, NULL) || i8042_enable_mux_ports())
+			printk(KERN_WARNING
+				"i8042: failed to resume active multiplexor, "
+				"mouse won't work.\n");
+	} else if (i8042_ports[I8042_AUX_PORT_NO].serio)
+		i8042_enable_aux_port();
 
-	panic_blink = i8042_panic_blink;
+	if (i8042_ports[I8042_KBD_PORT_NO].serio)
+		i8042_enable_kbd_port();
+
+	i8042_interrupt(0, NULL, NULL);
 
 	return 0;
 }
@@ -978,24 +927,24 @@ static int __devinit i8042_create_kbd_po
 
 	serio->id.type		= i8042_direct ? SERIO_8042 : SERIO_8042_XL;
 	serio->write		= i8042_dumbkbd ? NULL : i8042_kbd_write;
-	serio->open		= i8042_open;
-	serio->close		= i8042_close;
 	serio->start		= i8042_start;
 	serio->stop		= i8042_stop;
 	serio->port_data	= port;
 	serio->dev.parent	= &i8042_platform_device->dev;
-	strlcpy(serio->name, "i8042 Kbd Port", sizeof(serio->name));
+	strlcpy(serio->name, "i8042 KBD port", sizeof(serio->name));
 	strlcpy(serio->phys, I8042_KBD_PHYS_DESC, sizeof(serio->phys));
 
 	port->serio = serio;
+	port->irq = I8042_KBD_IRQ;
 
-	return i8042_port_register(port);
+	return 0;
 }
 
-static int __devinit i8042_create_aux_port(void)
+static int __devinit i8042_create_aux_port(int idx)
 {
 	struct serio *serio;
-	struct i8042_port *port = &i8042_ports[I8042_AUX_PORT_NO];
+	int port_no = idx < 0 ? I8042_AUX_PORT_NO : I8042_MUX_PORT_NO + idx;
+	struct i8042_port *port = &i8042_ports[port_no];
 
 	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!serio)
@@ -1003,111 +952,191 @@ static int __devinit i8042_create_aux_po
 
 	serio->id.type		= SERIO_8042;
 	serio->write		= i8042_aux_write;
-	serio->open		= i8042_open;
-	serio->close		= i8042_close;
 	serio->start		= i8042_start;
 	serio->stop		= i8042_stop;
 	serio->port_data	= port;
 	serio->dev.parent	= &i8042_platform_device->dev;
-	strlcpy(serio->name, "i8042 Aux Port", sizeof(serio->name));
-	strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
+	if (idx < 0) {
+		strlcpy(serio->name, "i8042 AUX port", sizeof(serio->name));
+		strlcpy(serio->phys, I8042_AUX_PHYS_DESC, sizeof(serio->phys));
+	} else {
+		snprintf(serio->name, sizeof(serio->name), "i8042 AUX%d port", idx);
+		snprintf(serio->phys, sizeof(serio->phys), I8042_MUX_PHYS_DESC, idx + 1);
+	}
 
 	port->serio = serio;
+	port->mux = idx;
+	port->irq = I8042_AUX_IRQ;
 
-	return i8042_port_register(port);
+	return 0;
 }
 
-static int __devinit i8042_create_mux_port(int index)
+static void __devinit i8042_free_kbd_port(void)
 {
-	struct serio *serio;
-	struct i8042_port *port = &i8042_ports[I8042_MUX_PORT_NO + index];
+	kfree(i8042_ports[I8042_KBD_PORT_NO].serio);
+	i8042_ports[I8042_KBD_PORT_NO].serio = NULL;
+}
 
-	serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
-	if (!serio)
-		return -ENOMEM;
+static void __devinit i8042_free_aux_ports(void)
+{
+	int i;
 
-	serio->id.type		= SERIO_8042;
-	serio->write		= i8042_aux_write;
-	serio->open		= i8042_open;
-	serio->close		= i8042_close;
-	serio->start		= i8042_start;
-	serio->stop		= i8042_stop;
-	serio->port_data	= port;
-	serio->dev.parent	= &i8042_platform_device->dev;
-	snprintf(serio->name, sizeof(serio->name), "i8042 Aux-%d Port", index);
-	snprintf(serio->phys, sizeof(serio->phys), I8042_MUX_PHYS_DESC, index + 1);
+	for (i = I8042_AUX_PORT_NO; i < I8042_NUM_PORTS; i++) {
+		kfree(i8042_ports[i].serio);
+		i8042_ports[i].serio = NULL;
+	}
+}
 
-	*port = i8042_ports[I8042_AUX_PORT_NO];
-	port->exists = 0;
-	snprintf(port->name, sizeof(port->name), "AUX%d", index);
-	port->mux = index;
-	port->serio = serio;
+static void __devinit i8042_register_ports(void)
+{
+	int i;
 
-	return i8042_port_register(port);
+	for (i = 0; i < I8042_NUM_PORTS; i++) {
+		if (i8042_ports[i].serio) {
+			printk(KERN_INFO "serio: %s at %#lx,%#lx irq %d\n",
+				i8042_ports[i].serio->name,
+				(unsigned long) I8042_DATA_REG,
+				(unsigned long) I8042_COMMAND_REG,
+				i8042_ports[i].irq);
+			serio_register_port(i8042_ports[i].serio);
+		}
+	}
 }
 
-static int __devinit i8042_probe(struct platform_device *dev)
+static void __devinit i8042_unregister_ports(void)
 {
-	int i, have_ports = 0;
-	int err;
+	int i;
+
+	for (i = 0; i < I8042_NUM_PORTS; i++) {
+		if (i8042_ports[i].serio) {
+			serio_unregister_port(i8042_ports[i].serio);
+			i8042_ports[i].serio = NULL;
+		}
+	}
+}
+
+static void i8042_free_irqs(void)
+{
+	if (i8042_aux_irq_registered)
+		free_irq(I8042_AUX_IRQ, i8042_platform_device);
+	if (i8042_kbd_irq_registered)
+		free_irq(I8042_KBD_IRQ, i8042_platform_device);
+
+	i8042_aux_irq_registered = i8042_kbd_irq_registered = 0;
+}
 
-	init_timer(&i8042_timer);
-	i8042_timer.function = i8042_timer_func;
+static int __devinit i8042_setup_aux(void)
+{
+	int (*aux_enable)(void);
+	int error;
+	int i;
 
-	if (i8042_controller_init())
+	if (i8042_check_aux())
 		return -ENODEV;
 
-	if (!i8042_noaux && !i8042_check_aux()) {
-		if (!i8042_nomux && !i8042_check_mux()) {
-			for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
-				err = i8042_create_mux_port(i);
-				if (err)
-					goto err_unregister_ports;
-			}
-		} else {
-			err = i8042_create_aux_port();
-			if (err)
-				goto err_unregister_ports;
+	if (i8042_nomux || i8042_check_mux()) {
+		error = i8042_create_aux_port(-1);
+		if (error)
+			goto err_free_ports;
+		aux_enable = i8042_enable_aux_port;
+	} else {
+		for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
+			error = i8042_create_aux_port(i);
+			if (error)
+				goto err_free_ports;
 		}
-		have_ports = 1;
+		aux_enable = i8042_enable_mux_ports;
 	}
 
-	if (!i8042_nokbd) {
-		err = i8042_create_kbd_port();
-		if (err)
-			goto err_unregister_ports;
-		have_ports = 1;
-	}
+	error = request_irq(I8042_AUX_IRQ, i8042_interrupt, IRQF_SHARED,
+			    "i8042", i8042_platform_device);
+	if (error)
+		goto err_free_ports;
 
-	if (!have_ports) {
-		err = -ENODEV;
-		goto err_controller_cleanup;
-	}
+	if (aux_enable())
+		goto err_free_irq;
 
-	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
+	i8042_aux_irq_registered = 1;
 	return 0;
 
- err_unregister_ports:
-	for (i = 0; i < I8042_NUM_PORTS; i++)
-		if (i8042_ports[i].serio)
-			serio_unregister_port(i8042_ports[i].serio);
- err_controller_cleanup:
-	i8042_controller_cleanup();
+ err_free_irq:
+	free_irq(I8042_AUX_IRQ, i8042_platform_device);
+ err_free_ports:
+	i8042_free_aux_ports();
+	return error;
+}
 
-	return err;
+static int __devinit i8042_setup_kbd(void)
+{
+	int error;
+
+	error = i8042_create_kbd_port();
+	if (error)
+		return error;
+
+	error = request_irq(I8042_KBD_IRQ, i8042_interrupt, IRQF_SHARED,
+			    "i8042", i8042_platform_device);
+	if (error)
+		goto err_free_port;
+
+	error = i8042_enable_kbd_port();
+	if (error)
+		goto err_free_irq;
+
+	i8042_kbd_irq_registered = 1;
+	return 0;
+
+ err_free_irq:
+	free_irq(I8042_KBD_IRQ, i8042_platform_device);
+ err_free_port:
+	i8042_free_kbd_port();
+	return error;
 }
 
-static int __devexit i8042_remove(struct platform_device *dev)
+static int __devinit i8042_probe(struct platform_device *dev)
 {
-	int i;
+	int error;
 
-	i8042_controller_cleanup();
+	error = i8042_controller_selftest();
+	if (error)
+		return error;
+
+	error = i8042_controller_init();
+	if (error)
+		return error;
+
+	if (!i8042_noaux) {
+		error = i8042_setup_aux();
+		if (error && error != -ENODEV && error != -EBUSY)
+			goto out_fail;
+	}
 
-	for (i = 0; i < I8042_NUM_PORTS; i++)
-		if (i8042_ports[i].exists)
-			serio_unregister_port(i8042_ports[i].serio);
+	if (!i8042_nokbd) {
+		error = i8042_setup_kbd();
+		if (error)
+			goto out_fail;
+	}
 
-	del_timer_sync(&i8042_timer);
+/*
+ * Ok, everything is ready, let's register all serio ports
+ */
+	i8042_register_ports();
+
+	return 0;
+
+ out_fail:
+	i8042_free_aux_ports();	/* in case KBD failed but AUX not */
+	i8042_free_irqs();
+	i8042_controller_reset();
+
+	return error;
+}
+
+static int __devexit i8042_remove(struct platform_device *dev)
+{
+	i8042_unregister_ports();
+	i8042_free_irqs();
+	i8042_controller_reset();
 
 	return 0;
 }
@@ -1134,8 +1163,9 @@ static int __init i8042_init(void)
 	if (err)
 		return err;
 
-	i8042_ports[I8042_AUX_PORT_NO].irq = I8042_AUX_IRQ;
-	i8042_ports[I8042_KBD_PORT_NO].irq = I8042_KBD_IRQ;
+	err = i8042_controller_check();
+	if (err)
+		goto err_platform_exit;
 
 	err = platform_driver_register(&i8042_driver);
 	if (err)
@@ -1151,6 +1181,8 @@ static int __init i8042_init(void)
 	if (err)
 		goto err_free_device;
 
+	panic_blink = i8042_panic_blink;
+
 	return 0;
 
  err_free_device:
@@ -1167,7 +1199,6 @@ static void __exit i8042_exit(void)
 {
 	platform_device_unregister(i8042_platform_device);
 	platform_driver_unregister(&i8042_driver);
-
 	i8042_platform_exit();
 
 	panic_blink = NULL;
