Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUFBHTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUFBHTJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265107AbUFBHTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:19:08 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:15449 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265093AbUFBHSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:18:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] Raw access to serio ports (2/2)
Date: Wed, 2 Jun 2004 02:17:16 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Giuseppe Bilotta <bilotta78@hotpop.com>,
       Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       Vojtech Pavlik <vojtech@suse.cz>, Tuukka Toivonen <tuukkat@ee.oulu.fi>
References: <200406020216.36568.dtor_core@ameritech.net>
In-Reply-To: <200406020216.36568.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406020217.19056.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1841, 2004-06-02 02:00:12-05:00, dtor_core@ameritech.net
  Input: add i8042.raw option to mark AUX ports as raw so they can be
         bound to rawdev device.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 Documentation/kernel-parameters.txt |    2 ++
 drivers/input/serio/i8042.c         |   15 +++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-06-02 02:15:49 -05:00
+++ b/Documentation/kernel-parameters.txt	2004-06-02 02:15:49 -05:00
@@ -464,6 +464,8 @@
 	i8042.noaux	[HW] Don't check for auxiliary (== mouse) port
 	i8042.nomux	[HW] Don't check presence of an active multiplexing
 			     controller
+	i8042.raw	[HW] Specifies which AUX ports should be marked as raw
+			Format: <aux1>,<aux2>,<aux3>,<aux4>
 	i8042.reset	[HW] Reset the controller during init and cleanup
 	i8042.unlock	[HW] Unlock (ignore) the keylock
 
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-06-02 02:15:49 -05:00
+++ b/drivers/input/serio/i8042.c	2004-06-02 02:15:49 -05:00
@@ -52,6 +52,11 @@
 module_param_named(dumbkbd, i8042_dumbkbd, bool, 0);
 MODULE_PARM_DESC(dumbkbd, "Pretend that controller can only read data from keyboard");
 
+static unsigned int i8042_aux_raw[4];
+static unsigned int i8042_aux_raw_nargs;
+module_param_array_named(raw, i8042_aux_raw, bool, i8042_aux_raw_nargs, 0);
+MODULE_PARM_DESC(raw, "Specifies which AUX ports should be marked as RAW");
+
 __obsolete_setup("i8042_noaux");
 __obsolete_setup("i8042_nomux");
 __obsolete_setup("i8042_unlock");
@@ -652,8 +657,9 @@
 		return -1;
 	}
 
-	printk(KERN_INFO "serio: i8042 %s port at %#lx,%#lx irq %d\n",
+	printk(KERN_INFO "serio: i8042 %s port%s at %#lx,%#lx irq %d\n",
 	       values->name,
+	       port->type == SERIO_8042_RAW ? " (raw)" : "",
 	       (unsigned long) I8042_DATA_REG,
 	       (unsigned long) I8042_COMMAND_REG,
 	       values->irq);
@@ -940,6 +946,8 @@
 	sprintf(i8042_mux_names[index], "i8042 Aux-%d Port", index);
 	sprintf(i8042_mux_phys[index], I8042_MUX_PHYS_DESC, index + 1);
 	sprintf(i8042_mux_short[index], "AUX%d", index);
+	if (i8042_aux_raw[index])
+		port->type = SERIO_8042_RAW;
 	port->name = i8042_mux_names[index];
 	port->phys = i8042_mux_phys[index];
 	port->driver = values;
@@ -974,8 +982,11 @@
 				i8042_init_mux_values(i8042_mux_values + i, i8042_mux_port + i, i);
 				i8042_port_register(i8042_mux_values + i, i8042_mux_port + i);
 			}
-		else
+		else {
+			if (i8042_aux_raw[0])
+				i8042_aux_port.type = SERIO_8042_RAW;
 			i8042_port_register(&i8042_aux_values, &i8042_aux_port);
+		}
 	}
 
 	i8042_port_register(&i8042_kbd_values, &i8042_kbd_port);
