Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUE3PJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUE3PJb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 11:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263121AbUE3PJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 11:09:31 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:24228 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261943AbUE3PJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 11:09:26 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: SERIO_USERDEV patch for 2.6
Date: Sun, 30 May 2004 10:09:18 -0500
User-Agent: KMail/1.6.2
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Sau Dan Lee <danlee@informatik.uni-freiburg.de>, tuukkat@ee.oulu.fi
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de> <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de> <20040530134246.GA1828@ucw.cz>
In-Reply-To: <20040530134246.GA1828@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
X-PRIORITY: 2 (High)
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405301009.21202.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 May 2004 08:42 am, Vojtech Pavlik wrote:
> 
> Anyway, looking at the patch, it's not bad, and it's quite close to what
> I was considering to write. I'd like to keep it separate from the
> serio.c file, although it's obvious it'll require to be linked to it
> statically, because it needs hooks there - it cannot be a regular serio
> driver.
> 

Do we really have to have this stuff directly in serio? How about being able
to mark some serio ports as working in raw mode (i8042.raw=0,1,1,0) and have
separate (serio_raw?) module bind to such ports

Warning - the patch below is not really tested and may not apply to Linus'
tree. 

-- 
Dmitry


===================================================================


ChangeSet@1.1743.7.10, 2004-05-29 22:19:16-05:00, dtor_core@ameritech.net
  Input: i8042 - add kernel parameter to allow mark some of AUX ports
         as raw (SERIO_8042_RAW). This will cause psmouse module ignore
         these ports and will allow bytestream driver serve data to the
         userspace.


 Documentation/kernel-parameters.txt |    2 ++
 drivers/input/serio/i8042.c         |   15 +++++++++++++--
 include/linux/serio.h               |    1 +
 3 files changed, 16 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-05-30 10:08:34 -05:00
+++ b/Documentation/kernel-parameters.txt	2004-05-30 10:08:34 -05:00
@@ -464,6 +464,8 @@
 	i8042.noaux	[HW] Don't check for auxiliary (== mouse) port
 	i8042.nomux	[HW] Don't check presence of an active multiplexing
 			     controller
+	i8042.raw	[HW] Specifies which AUX ports should be marked as raw
+			Format: <aux1>,<aux2>,<aux3>,<aux4>
 	i8042.reset	[HW] Reset the controller during init and cleanup
 	i8042.unlock	[HW] Unlock (ignore) the keylock
 
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-05-30 10:08:34 -05:00
+++ b/drivers/input/serio/i8042.c	2004-05-30 10:08:34 -05:00
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
@@ -651,8 +656,9 @@
 		return -1;
 	}
 
-	printk(KERN_INFO "serio: i8042 %s port at %#lx,%#lx irq %d\n",
+	printk(KERN_INFO "serio: i8042 %s port %s at %#lx,%#lx irq %d\n",
 	       values->name,
+	       port->type == SERIO_8042_RAW ? "(raw)" : "",
 	       (unsigned long) I8042_DATA_REG,
 	       (unsigned long) I8042_COMMAND_REG,
 	       values->irq);
@@ -936,6 +942,8 @@
 	sprintf(i8042_mux_names[index], "i8042 Aux-%d Port", index);
 	sprintf(i8042_mux_phys[index], I8042_MUX_PHYS_DESC, index + 1);
 	sprintf(i8042_mux_short[index], "AUX%d", index);
+	if (i8042_aux_raw[index])
+		port->type = SERIO_8042_RAW;
 	port->name = i8042_mux_names[index];
 	port->phys = i8042_mux_phys[index];
 	port->driver = values;
@@ -970,8 +978,11 @@
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
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-05-30 10:08:34 -05:00
+++ b/include/linux/serio.h	2004-05-30 10:08:34 -05:00
@@ -108,6 +108,7 @@
 #define SERIO_PC9800	0x04000000UL
 #define SERIO_PS_PSTHRU	0x05000000UL
 #define SERIO_8042_XL	0x06000000UL
+#define SERIO_8042_RAW	0x07000000UL
 
 #define SERIO_PROTO	0xFFUL
 #define SERIO_MSC	0x01
