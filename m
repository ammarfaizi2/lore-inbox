Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263229AbVGOHJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbVGOHJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 03:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263230AbVGOHJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 03:09:28 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:55146 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263229AbVGOHJ1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 03:09:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l64DVuiCjrfbABtah/HIZM414gf5tOVWibgCEPyqZLPwI2YgLhZ2KLSE3dR0iH3WehM4oIPgLhOMGet8RmcZA/aMOVxp9xgROquoJPGdOYVlWx3eGDZWuD3VbL3fm/iitdSGtpqumXIk4ufNdajKQ7l3hU1otTRv4QSN9LKA714=
Message-ID: <9a96b8e1050715000940410a05@mail.gmail.com>
Date: Fri, 15 Jul 2005 03:09:24 -0400
From: Robert Broglia <robert.broglia@gmail.com>
Reply-To: Robert Broglia <robert.broglia@gmail.com>
To: vojtech@suse.cz
Subject: [PATCH] Config options for hardware tapping on ALPS touchpad
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two options under the PS/2 mouse driver to control how
hardware tapping is enabled on ALPS touchpads. I have defined a new
static variable in alps.c to determine if we call alps_tap_mode() with
a 1 or a 0. The first new config option lets you select whether you
want hardware tapping or not by defining the default value for this
variable.

The second new option lets you add a module parameter to alps.c that
can change the tapping mode when the psmouse module is loaded. This
module parameter simply sets the same variable defined above and lets
you override your choice in the previous option. It also lets you
change the tapping mode without a recompile & reboot by reloading the
psmouse module.

See the Kconfig descriptions for more details.

Other internal changes to alps.c besides the new variable and module
parameter are:
- Added a new static function, alps_setup_tapping, to set the tapping
state using the new variable and handle printk statements.
- Replaced the two instances of alps_tap_mode and any nearby logic
that handles printk with alps_setup_tapping

This fairly simple patch is made to apply on top of 2.6.13-rc3. I have
tested it on my laptop with different combinations of the the new
config options with no problems. Of course any comments/feedback would
be appreciated :)

Signed-off-by: Robert Broglia <robert.broglia@gmail.com>


diff -uprN -X dontdiff linux-2.6.13-rc3/drivers/input/mouse/Kconfig
linux-2.6.13-rc3-patched/drivers/input/mouse/Kconfig
--- linux-2.6.13-rc3/drivers/input/mouse/Kconfig	2005-07-14
01:34:11.000000000 -0400
+++ linux-2.6.13-rc3-patched/drivers/input/mouse/Kconfig	2005-07-14
01:58:48.712666493 -0400
@@ -37,6 +37,34 @@ config MOUSE_PS2
 	  To compile this driver as a module, choose M here: the
  	  module will be called psmouse.
 
+if MOUSE_PS2
+
+config MOUSE_PS2_ALPS_HARDWARE_TAPPING
+	bool "Hardware tapping for ALPS touchpads"
+	default y
+	help
+	Say Y here to enable hardware tapping on ALPS laptop touchpads,
+	such as the one found on the Dell Latitude D600. You should
+	say N here if you use the Synaptics X11 drivers to avoid
+	possible conflicts with software-based tapping.
+
+	If unsure, say Y. This option has no runtime effect unless using
+	an ALPS touchpad.
+
+config MOUSE_PS2_ALPS_HARDWARE_TAPPING_MODULE_PARAM
+	bool "Set ALPS tapping state via module parameter"
+	default y
+	help
+	Say Y here to set the hardware tapping on ALPS laptop touchpads
+	via the parameter "alpshardtap" when loading the psmouse module.
+	A value of 1 enables hardware tapping, and 0 disables it.
+	This overrides whatever the default tapping state is set to.
+
+	If unsure, say Y. This option has no runtime effect unless using
+	an ALPS touchpad.
+
+endif
+
  config MOUSE_SERIAL
  	tristate "Serial mouse"
  	select SERIO
diff -uprN -X dontdiff linux-2.6.13-rc3/drivers/input/mouse/alps.c
linux-2.6.13-rc3-patched/drivers/input/mouse/alps.c
--- linux-2.6.13-rc3/drivers/input/mouse/alps.c	2005-07-14
01:34:11.000000000 -0400
+++ linux-2.6.13-rc3-patched/drivers/input/mouse/alps.c	2005-07-14
01:58:08.358736438 -0400
@@ -75,6 +75,17 @@ static struct alps_model_info alps_model
  * on a dualpoint, etc.
  */
 
+#ifdef CONFIG_MOUSE_PS2_ALPS_HARDWARE_TAPPING
+static unsigned int alps_hardtap = 1;
+#else
+static unsigned int alps_hardtap = 0;
+#endif
+
+#ifdef CONFIG_MOUSE_PS2_ALPS_HARDWARE_TAPPING_MODULE_PARAM
+module_param_named(alpshardtap, alps_hardtap, bool, 0644);
+MODULE_PARM_DESC(alpshardtap, "ALPS hardware tapping, 1 = enabled, 0
= disabled.");
+#endif
+
  static void alps_process_packet(struct psmouse *psmouse, struct pt_regs *regs)
 {
  	struct alps_data *priv = psmouse->private;
@@ -347,6 +358,19 @@ static int alps_tap_mode(struct psmouse 
 	return 0;
 }
 
+static void alps_setup_tapping(struct psmouse *psmouse)
+{
+	if(alps_hardtap == 1) {
+		printk(KERN_INFO "alps.c: Enabling hardware tapping\n");
+		if (alps_tap_mode(psmouse, 1))
+			printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
+	} else {
+		printk(KERN_INFO "alps.c: Disabling hardware tapping\n");
+		if (alps_tap_mode(psmouse, 0))
+			printk(KERN_WARNING "alps.c: Failed to disable hardware tapping\n");
+	}
+}
+
  static int alps_reconnect(struct psmouse *psmouse)
 {
  	struct alps_data *priv = psmouse->private;
@@ -365,7 +389,7 @@ static int alps_reconnect(struct psmouse
 		return -1;
 
  	if (!(param[0] & 0x04))
-		alps_tap_mode(psmouse, 1);
+		alps_setup_tapping(psmouse);
 
  	if (alps_absolute_mode(psmouse)) {
  		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
@@ -408,11 +432,8 @@ int alps_init(struct psmouse *psmouse)
  		goto init_fail;
 	}
 
-	if (param[0] & 0x04) {
-		printk(KERN_INFO "alps.c: Enabling hardware tapping\n");
-		if (alps_tap_mode(psmouse, 1))
-			printk(KERN_WARNING "alps.c: Failed to enable hardware tapping\n");
-	}
+	if (param[0] & 0x04)
+		alps_setup_tapping(psmouse);
 
  	if (alps_absolute_mode(psmouse)) {
  		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
