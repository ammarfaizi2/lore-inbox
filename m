Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWG0E3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWG0E3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 00:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWG0E3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 00:29:09 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:15972 "EHLO
	asav07.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750722AbWG0E3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 00:29:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAOjcx0SBTw
From: Dmitry Torokhov <dtor@insightbb.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC/RFT] Remove polling timer from i8042
Date: Thu, 27 Jul 2006 00:29:04 -0400
User-Agent: KMail/1.9.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, Dave Jones <davej@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607270029.05066.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

OK, I had it in works for quite some time and Dave's talk in Ottawa
made me finish it ;)

-- 
Dmitry

Input: i8042 - get rid of polling timer

Remove polling timer that was used to detect keybord/mice hotplug and
register both IRQs right away instead of waiting for a driver to
attach to a port. If mouse is really missing and IRQ can be used for
something else user can boot with i8042.noaux. 

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |  635 ++++++++++++++++++++------------------------
 1 files changed, 290 insertions(+), 345 deletions(-)

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
@@ -248,7 +228,7 @@ static int i8042_kbd_write(struct serio 
 
 	spin_lock_irqsave(&i8042_lock, flags);
 
-	if(!(retval = i8042_wait_write())) {
+	if (!(retval = i8042_wait_write())) {
 		dbg("%02x -> i8042 (kbd-data)", c);
 		i8042_write_data(c);
 	}
@@ -287,100 +267,6 @@ static int i8042_aux_write(struct serio 
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
@@ -423,8 +309,6 @@ static irqreturn_t i8042_interrupt(int i
 	unsigned int port_no;
 	int ret;
 
-	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
-
 	spin_lock_irqsave(&i8042_lock, flags);
 	str = i8042_read_status();
 	if (unlikely(~str & I8042_STR_OBF)) {
@@ -480,8 +364,8 @@ static irqreturn_t i8042_interrupt(int i
 
 	port = &i8042_ports[port_no];
 
-	dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
-	    data, port->name, irq,
+	dbg("%02x <- i8042 (interrupt, %d, %d%s%s)",
+	    data, port_no, irq,
 	    dfl & SERIO_PARITY ? ", bad parity" : "",
 	    dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
@@ -494,43 +378,39 @@ static irqreturn_t i8042_interrupt(int i
 }
 
 /*
- * i8042_set_mux_mode checks whether the controller has an active
- * multiplexor and puts the chip into Multiplexed (1) or Legacy (0) mode.
+ * i8042_enable_kbd_port enables keybaord port on chip
  */
 
-static int i8042_set_mux_mode(unsigned int mode, unsigned char *mux_version)
+static int i8042_enable_kbd_port(void)
 {
+	i8042_ctr &= ~I8042_CTR_KBDDIS;
+	i8042_ctr |= I8042_CTR_KBDINT;
 
-	unsigned char param;
-/*
- * Get rid of bytes in the queue.
- */
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		printk(KERN_ERR "i8042.c: Failed to enable KBD port.\n");
+		return -EIO;
+	}
 
-	i8042_flush();
+	return 0;
+}
 
 /*
- * Internal loopback test - send three bytes, they should come back from the
- * mouse interface, the last should be version. Note that we negate mouseport
- * command responses for the i8042_check_aux() routine.
+ * i8042_enable_aux_port enables AUX (mouse) port on chip
  */
 
-	param = 0xf0;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xf0)
-		return -1;
-	param = mode ? 0x56 : 0xf6;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != (mode ? 0x56 : 0xf6))
-		return -1;
-	param = mode ? 0xa4 : 0xa5;
-	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == (mode ? 0xa4 : 0xa5))
-		return -1;
+static int i8042_enable_aux_port(void)
+{
+	i8042_ctr &= ~I8042_CTR_AUXDIS;
+	i8042_ctr |= I8042_CTR_AUXINT;
 
-	if (mux_version)
-		*mux_version = param;
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		printk(KERN_ERR "i8042.c: Failed to enable AUX port.\n");
+		return -EIO;
+	}
 
 	return 0;
 }
 
-
 /*
  * i8042_enable_mux_ports enables 4 individual AUX ports after
  * the controller has been switched into Multiplexed mode
@@ -540,31 +420,51 @@ static int i8042_enable_mux_ports(void)
 {
 	unsigned char param;
 	int i;
+
+	for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
+		i8042_command(&param, I8042_CMD_MUX_PFX + i);
+		i8042_command(&param, I8042_CMD_AUX_ENABLE);
+	}
+
+	return 0;
+}
+
 /*
- * Disable all muxed ports by disabling AUX.
+ * i8042_set_mux_mode checks whether the controller has an active
+ * multiplexor and puts the chip into Multiplexed (1) or Legacy (0) mode.
  */
 
-	i8042_ctr |= I8042_CTR_AUXDIS;
-	i8042_ctr &= ~I8042_CTR_AUXINT;
+static int i8042_set_mux_mode(unsigned int mode, unsigned char *mux_version)
+{
 
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		printk(KERN_ERR "i8042.c: Failed to disable AUX port, can't use MUX.\n");
-		return -1;
-	}
+	unsigned char param;
+/*
+ * Get rid of bytes in the queue.
+ */
+
+	i8042_flush();
 
 /*
- * Enable all muxed ports.
+ * Internal loopback test - send three bytes, they should come back from the
+ * mouse interface, the last should be version.
  */
 
-	for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
-		i8042_command(&param, I8042_CMD_MUX_PFX + i);
-		i8042_command(&param, I8042_CMD_AUX_ENABLE);
-	}
+	param = 0xf0;
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xf0)
+		return -1;
+	param = mode ? 0x56 : 0xf6;
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != (mode ? 0x56 : 0xf6))
+		return -1;
+	param = mode ? 0xa4 : 0xa5;
+	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == (mode ? 0xa4 : 0xa5))
+		return -1;
+
+	if (mux_version)
+		*mux_version = param;
 
 	return 0;
 }
 
-
 /*
  * i8042_check_mux() checks whether the controller supports the PS/2 Active
  * Multiplexing specification by Synaptics, Phoenix, Insyde and
@@ -578,18 +478,29 @@ static int __devinit i8042_check_mux(voi
 	if (i8042_set_mux_mode(1, &mux_version))
 		return -1;
 
-	/* Workaround for interference with USB Legacy emulation */
-	/* that causes a v10.12 MUX to be found. */
+/*
+ * Workaround for interference with USB Legacy emulation
+ * that causes a v10.12 MUX to be found.
+ */
 	if (mux_version == 0xAC)
 		return -1;
 
 	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
 		(mux_version >> 4) & 0xf, mux_version & 0xf);
 
-	if (i8042_enable_mux_ports())
-		return -1;
+/*
+ * Disable all muxed ports by disabling AUX.
+ */
+	i8042_ctr |= I8042_CTR_AUXDIS;
+	i8042_ctr &= ~I8042_CTR_AUXINT;
+
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		printk(KERN_ERR "i8042.c: Failed to disable AUX port, can't use MUX.\n");
+		return -EIO;
+	}
 
 	i8042_mux_present = 1;
+
 	return 0;
 }
 
@@ -602,17 +513,6 @@ static int __devinit i8042_check_mux(voi
 static int __devinit i8042_check_aux(void)
 {
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
@@ -637,9 +537,9 @@ static int __devinit i8042_check_aux(voi
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
@@ -665,48 +565,20 @@ static int __devinit i8042_check_aux(voi
 	i8042_ctr |= I8042_CTR_AUXDIS;
 	i8042_ctr &= ~I8042_CTR_AUXINT;
 
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
-		return -1;
-
-	return 0;
+	return i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR);
 }
 
-
-/*
- * i8042_port_register() marks the device as existing,
- * registers it, and reports to the user.
- */
-
-static int __devinit i8042_port_register(struct i8042_port *port)
+static int i8042_controller_check(void)
 {
-	i8042_ctr &= ~port->disable;
-
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		printk(KERN_WARNING "i8042.c: Can't write CTR while registering.\n");
-		kfree(port->serio);
-		port->serio = NULL;
-		i8042_ctr |= port->disable;
-		return -EIO;
+	if (i8042_flush() == I8042_BUFFER_SIZE) {
+		printk(KERN_ERR "i8042.c: No controller found.\n");
+		return -ENODEV;
 	}
 
-	printk(KERN_INFO "serio: i8042 %s port at %#lx,%#lx irq %d\n",
-	       port->name,
-	       (unsigned long) I8042_DATA_REG,
-	       (unsigned long) I8042_COMMAND_REG,
-	       port->irq);
-
-	serio_register_port(port->serio);
-
 	return 0;
 }
 
-
-static void i8042_timer_func(unsigned long data)
-{
-	i8042_interrupt(0, NULL, NULL);
-}
-
-static int i8042_ctl_test(void)
+static int i8042_controller_selftest(void)
 {
 	unsigned char param;
 
@@ -715,13 +587,13 @@ static int i8042_ctl_test(void)
 
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
@@ -738,25 +610,12 @@ static int i8042_controller_init(void)
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
@@ -782,8 +641,10 @@ static int i8042_controller_init(void)
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
@@ -805,7 +666,7 @@ static int i8042_controller_init(void)
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
 		printk(KERN_ERR "i8042.c: Can't write CTR while initializing i8042.\n");
-		return -1;
+		return -EIO;
 	}
 
 	return 0;
@@ -813,15 +674,12 @@ static int i8042_controller_init(void)
 
 
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
@@ -831,12 +689,16 @@ static void i8042_controller_reset(void)
 		i8042_set_mux_mode(0, NULL);
 
 /*
- * Restore the original control register setting.
+ * Reset the controller if requested.
  */
 
-	i8042_ctr = i8042_initial_ctr;
+	i8042_controller_selftest();
+
+/*
+ * Restore the original control register setting.
+ */
 
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
+	if (i8042_command(&i8042_initial_ctr, I8042_CMD_CTL_WCTR))
 		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
 }
 
@@ -850,14 +712,12 @@ static void i8042_controller_cleanup(voi
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
@@ -913,8 +773,7 @@ static long i8042_panic_blink(long count
 
 static int i8042_suspend(struct platform_device *dev, pm_message_t state)
 {
-	del_timer_sync(&i8042_timer);
-	i8042_controller_reset();
+	i8042_controller_cleanup();
 
 	return 0;
 }
@@ -926,33 +785,39 @@ static int i8042_suspend(struct platform
 
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
@@ -978,24 +843,24 @@ static int __devinit i8042_create_kbd_po
 
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
@@ -1003,111 +868,189 @@ static int __devinit i8042_create_aux_po
 
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
 
-	init_timer(&i8042_timer);
-	i8042_timer.function = i8042_timer_func;
+	for (i = 0; i < I8042_NUM_PORTS; i++) {
+		if (i8042_ports[i].serio) {
+			serio_unregister_port(i8042_ports[i].serio);
+			i8042_ports[i].serio = NULL;
+		}
+	}
+}
 
-	if (i8042_controller_init())
-		return -ENODEV;
+static void i8042_free_irqs(void)
+{
+	if (i8042_aux_irq_registered)
+		free_irq(I8042_AUX_IRQ, i8042_platform_device);
+	if (i8042_kbd_irq_registered)
+		free_irq(I8042_KBD_IRQ, i8042_platform_device);
 
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
+	i8042_aux_irq_registered = i8042_kbd_irq_registered = 0;
+}
+
+static int __devinit i8042_setup_aux(void)
+{
+	int error;
+	int i;
+
+	if (request_irq(I8042_AUX_IRQ, i8042_interrupt, IRQF_SHARED,
+			"i8042", i8042_platform_device))
+		return -EBUSY;
+
+	if (i8042_check_aux()) {
+		error = -ENODEV;
+		goto out_fail;
+	}
+
+	if (i8042_nomux || i8042_check_mux()) {
+		error = i8042_create_aux_port(-1);
+		if (error)
+			goto out_fail;
+		error = i8042_enable_aux_port();
+		if (error)
+			goto out_fail;
+	} else {
+		for (i = 0; i < I8042_NUM_MUX_PORTS; i++) {
+			error = i8042_create_aux_port(i);
+			if (error)
+				goto out_fail;
 		}
-		have_ports = 1;
+		error = i8042_enable_mux_ports();
+		if (error)
+			goto out_fail;
 	}
 
-	if (!i8042_nokbd) {
-		err = i8042_create_kbd_port();
-		if (err)
-			goto err_unregister_ports;
-		have_ports = 1;
+	i8042_aux_irq_registered = 1;
+	return 0;
+
+ out_fail:
+	i8042_free_aux_ports();
+	free_irq(I8042_AUX_IRQ, i8042_platform_device);
+	return error;
+}
+
+static int __devinit i8042_setup_kbd(void)
+{
+	int error;
+
+	if (request_irq(I8042_KBD_IRQ, i8042_interrupt, IRQF_SHARED,
+			"i8042", i8042_platform_device))
+		return -EBUSY;
+
+	error = i8042_create_kbd_port();
+	if (error)
+		goto out_fail;
+
+	error = i8042_enable_kbd_port();
+	if (error)
+		goto out_fail;
+
+	i8042_kbd_irq_registered = 1;
+	return 0;
+
+ out_fail:
+	i8042_free_kbd_port();
+	free_irq(I8042_KBD_IRQ, i8042_platform_device);
+	return error;
+}
+
+static int __devinit i8042_probe(struct platform_device *dev)
+{
+	int error;
+
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
 	}
 
-	if (!have_ports) {
-		err = -ENODEV;
-		goto err_controller_cleanup;
+	if (!i8042_nokbd) {
+		error = i8042_setup_kbd();
+		if (error)
+			goto out_fail;
 	}
 
-	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
+/*
+ * Ok, everything is ready, let's register all serio ports
+ */
+	i8042_register_ports();
+
 	return 0;
 
- err_unregister_ports:
-	for (i = 0; i < I8042_NUM_PORTS; i++)
-		if (i8042_ports[i].serio)
-			serio_unregister_port(i8042_ports[i].serio);
- err_controller_cleanup:
-	i8042_controller_cleanup();
+ out_fail:
+	i8042_free_aux_ports();	/* in case KBD failed but AUX not */
+	i8042_free_irqs();
+	i8042_controller_reset();
 
-	return err;
+	return error;
 }
 
 static int __devexit i8042_remove(struct platform_device *dev)
 {
-	int i;
-
-	i8042_controller_cleanup();
-
-	for (i = 0; i < I8042_NUM_PORTS; i++)
-		if (i8042_ports[i].exists)
-			serio_unregister_port(i8042_ports[i].serio);
-
-	del_timer_sync(&i8042_timer);
+	i8042_unregister_ports();
+	i8042_free_irqs();
+	i8042_controller_reset();
 
 	return 0;
 }
@@ -1134,8 +1077,9 @@ static int __init i8042_init(void)
 	if (err)
 		return err;
 
-	i8042_ports[I8042_AUX_PORT_NO].irq = I8042_AUX_IRQ;
-	i8042_ports[I8042_KBD_PORT_NO].irq = I8042_KBD_IRQ;
+	err = i8042_controller_check();
+	if (err)
+		goto err_platform_exit;
 
 	err = platform_driver_register(&i8042_driver);
 	if (err)
@@ -1151,6 +1095,8 @@ static int __init i8042_init(void)
 	if (err)
 		goto err_free_device;
 
+	panic_blink = i8042_panic_blink;
+
 	return 0;
 
  err_free_device:
@@ -1167,7 +1113,6 @@ static void __exit i8042_exit(void)
 {
 	platform_device_unregister(i8042_platform_device);
 	platform_driver_unregister(&i8042_driver);
-
 	i8042_platform_exit();
 
 	panic_blink = NULL;
