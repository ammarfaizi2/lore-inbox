Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTLEE1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 23:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTLEE1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 23:27:21 -0500
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:54424 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262128AbTLEE1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 23:27:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: [RFC/PATCH 1/3] Input: resume support for i8042 (atkbd & psmouse)
Date: Thu, 4 Dec 2003 23:27:06 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <XQFu.15s.3@gated-at.bofh.it> <20031204224643.GA23592@hell.org.pl>
In-Reply-To: <20031204224643.GA23592@hell.org.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312042327.06645.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 December 2003 05:46 pm, Karol Kozimor wrote:
> Thus wrote Dmitry Torokhov:
> > Here is an attempt to implement resume for i8042 using
> > serio_reconnect facility that can be found in -mm kernels. It also
> > depends on bunch of other changes in input subsystem all of which can
> > be found here: http://www.geocities.com/dt_or/input
> >
> > They should apply cleanly to -test11.
>
> Your patches seem to work fine for my keyboard -- it reconnects and
> works smoothly (the interrupts are fine). My Synaptics touchpad is
> however not present after resume -- no response and no mention of i8042
> in /proc/interrupts after S3 resume. I attach a dmesg excerpt in hope
> that helps you in any way. Thanks for the good work!

Karol,

I realized that I was not switching from the Legacy to Multiplexed mode 
and that could (or even should I might say) cause dead mouse. I have 
passive  multiplexor so the old code worked for me.

Could you please try this patch (on top of everything else). It complies 
but I have not booted with it.

Thank you,
Dmitry

===== drivers/input/serio/i8042.c 1.35 vs edited =====
--- 1.35/drivers/input/serio/i8042.c	Wed Dec  3 02:52:13 2003
+++ edited/drivers/input/serio/i8042.c	Thu Dec  4 23:17:26 2003
@@ -60,6 +60,7 @@
 static unsigned char i8042_initial_ctr;
 static unsigned char i8042_ctr;
 static unsigned char i8042_mux_open;
+static unsigned char i8042_mux_present;
 struct timer_list i8042_timer;
 
 static int i8042_sysdev_initialized;
@@ -565,58 +566,16 @@
 
 }
 
-/*
- * Here we try to reset everything back to a state in which suspended
- */
-
-static int i8042_controller_resume(struct sys_device *dev)
-{
-	int i;
-
-	if (i8042_controller_init()) {
-		printk(KERN_ERR "i8042: resume failed\n");
-		return -1;
-	}
 
 /*
- * Reconnect anything that was connected to the ports.
+ * i8042_enable_mux_mode checks whether the controller has an active
+ * multiplexor and puts the chip into Multiplexed (as opposed to 
+ * Legacy) mode.
  */
-
-	if (i8042_kbd_values.exists && i8042_activate_port(&i8042_kbd_port) == 0)
-		serio_reconnect(&i8042_kbd_port);
-
-	if (i8042_aux_values.exists && i8042_activate_port(&i8042_aux_port) == 0)
-		serio_reconnect(&i8042_aux_port);
-
-	for (i = 0; i < 4; i++)
-		if (i8042_mux_values[i].exists && i8042_activate_port(i8042_mux_port + i) == 0)
-			serio_reconnect(i8042_mux_port + i);
-
-	return 0;
-}
-
-
-/*
- * i8042_check_mux() checks whether the controller supports the PS/2 Active
- * Multiplexing specification by Synaptics, Phoenix, Insyde and
- * LCS/Telegraphics.
- */
-
-static int __init i8042_check_mux(struct i8042_values *values)
+static int i8042_enable_mux_mode(struct i8042_values *values)
 {
-	unsigned char param;
-	static int i8042_check_mux_cookie;
-	int i;
-
-/*
- * Check if AUX irq is available.
- */
-
-	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
-				"i8042", &i8042_check_mux_cookie))
-                return -1;
-	free_irq(values->irq, &i8042_check_mux_cookie);
 
+	unsigned char param;
 /*
  * Get rid of bytes in the queue.
  */
@@ -639,9 +598,14 @@
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b)
 		return -1;
 
-	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
-		(~param >> 4) & 0xf, ~param & 0xf);
+	return ~param; 
+}
+
 
+static int i8042_activate_mux(struct i8042_values *values)
+{
+	unsigned char param;
+	int i;
 /*
  * Disable all muxed ports by disabling AUX.
  */
@@ -649,8 +613,10 @@
 	i8042_ctr |= I8042_CTR_AUXDIS;
 	i8042_ctr &= ~I8042_CTR_AUXINT;
 
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		printk(KERN_ERR "i8042.c: Failed to disable AUX port, can't use MUX.\n");
 		return -1;
+	}
 
 /*
  * Enable all muxed ports.
@@ -664,6 +630,40 @@
 	return 0;
 }
 
+
+/*
+ * i8042_check_mux() checks whether the controller supports the PS/2 Active
+ * Multiplexing specification by Synaptics, Phoenix, Insyde and
+ * LCS/Telegraphics.
+ */
+
+static int __init i8042_check_mux(struct i8042_values *values)
+{
+	static int i8042_check_mux_cookie;
+	int mux_version;
+
+/*
+ * Check if AUX irq is available.
+ */
+	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
+				"i8042", &i8042_check_mux_cookie))
+                return -1;
+	free_irq(values->irq, &i8042_check_mux_cookie);
+
+	if ((mux_version = i8042_enable_mux_mode(values))  < 0)
+		return 0;
+
+	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
+		(mux_version >> 4) & 0xf, mux_version & 0xf);
+
+	if (i8042_activate_mux(values))
+		return -1;
+
+	i8042_mux_present = 1;
+	return 0;
+}
+
+
 /*
  * i8042_check_aux() applies as much paranoia as it can at detecting
  * the presence of an AUX interface.
@@ -846,6 +846,41 @@
 	values->name = i8042_mux_short[index];
 	values->mux = index;
 }
+
+/*
+ * Here we try to reset everything back to a state in which suspended
+ */
+static int i8042_controller_resume(struct sys_device *dev)
+{
+	int i;
+
+	if (i8042_controller_init()) {
+		printk(KERN_ERR "i8042: resume failed\n");
+		return -1;
+	}
+
+	if (i8042_mux_present &&
+	    (i8042_enable_mux_mode(&i8042_aux_values) < 0 || i8042_activate_mux(&i8042_aux_values))) {
+		printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't wotk.\n");
+	}
+
+/*
+ * Reconnect anything that was connected to the ports.
+ */
+
+	if (i8042_kbd_values.exists && i8042_activate_port(&i8042_kbd_port) == 0)
+		serio_reconnect(&i8042_kbd_port);
+
+	if (i8042_aux_values.exists && i8042_activate_port(&i8042_aux_port) == 0)
+		serio_reconnect(&i8042_aux_port);
+
+	for (i = 0; i < 4; i++)
+		if (i8042_mux_values[i].exists && i8042_activate_port(i8042_mux_port + i) == 0)
+			serio_reconnect(i8042_mux_port + i);
+
+	return 0;
+}
+
 
 static struct sysdev_class kbc_sysclass = {
        set_kset_name("i8042"),

