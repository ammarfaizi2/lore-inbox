Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293679AbSCKKty>; Mon, 11 Mar 2002 05:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293681AbSCKKtq>; Mon, 11 Mar 2002 05:49:46 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:9357 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S293679AbSCKKtg>; Mon, 11 Mar 2002 05:49:36 -0500
Date: Mon, 11 Mar 2002 11:49:20 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] sonypi driver update
Message-ID: <20020311104920.GE18651@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a workaround in the sonypi driver 
improving the programmable keys events recognision on 
jodial impaired Vaio models.

Previously on those models, PK events were recognized as
jogdial events. Now, if you pass the nojogdial=1 option to
the sonypi modules (kernel command line option available too,
see Documentation/sonypi.txt), the PK will send PK events, as they
should.

All this crap will be gone in the 2.5 version of the driver, when
I'll probably switch to some kind of keymap logic, leaving the
user the possibility to set its own preferred Vaio model configuration...

Marcelo, please apply.

Stelian.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.161   -> 1.162  
#	Documentation/sonypi.txt	1.6     -> 1.7    
#	drivers/char/sonypi.h	1.7     -> 1.8    
#	drivers/char/sonypi.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/03/11	stelian@popies.net	1.162
# Enable more accurate events on Vaio laptops without a jogdial (FX series)
# --------------------------------------------
#
diff -Nru a/Documentation/sonypi.txt b/Documentation/sonypi.txt
--- a/Documentation/sonypi.txt	Mon Mar 11 11:38:53 2002
+++ b/Documentation/sonypi.txt	Mon Mar 11 11:38:54 2002
@@ -43,7 +43,7 @@
 to /etc/modules.conf file, when the driver is compiled as a module or by
 adding the following to the kernel command line (in your bootloader):
 
-	sonypi=minor[[[[,camera],fnkeyinit],verbose],compat]
+	sonypi=minor[[[[[,camera],fnkeyinit],verbose],compat],nojogdial]
 
 where:
 
@@ -70,6 +70,9 @@
 			events. If the driver worked for you in the past
 			(prior to version 1.5) and does not work anymore,
 			add this option and report to the author.
+
+	nojogdial:	gives more accurate PKEY events on those Vaio models
+			which don't have a jogdial (like the FX series).
 
 Module use:
 -----------
diff -Nru a/drivers/char/sonypi.c b/drivers/char/sonypi.c
--- a/drivers/char/sonypi.c	Mon Mar 11 11:38:54 2002
+++ b/drivers/char/sonypi.c	Mon Mar 11 11:38:54 2002
@@ -50,6 +50,7 @@
 static int fnkeyinit; /* = 0 */
 static int camera; /* = 0 */
 static int compat; /* = 0 */
+static int nojogdial; /* = 0 */
 
 /* Inits the queue */
 static inline void sonypi_initq(void) {
@@ -310,24 +311,28 @@
 	int i;
 	u8 sonypi_jogger_ev, sonypi_fnkey_ev;
 	u8 sonypi_capture_ev, sonypi_bluetooth_ev;
+	u8 sonypi_pkey_ev;
 
 	if (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE2) {
 		sonypi_jogger_ev = SONYPI_TYPE2_JOGGER_EV;
 		sonypi_fnkey_ev = SONYPI_TYPE2_FNKEY_EV;
 		sonypi_capture_ev = SONYPI_TYPE2_CAPTURE_EV;
 		sonypi_bluetooth_ev = SONYPI_TYPE2_BLUETOOTH_EV;
+		sonypi_pkey_ev = nojogdial ? SONYPI_TYPE2_PKEY_EV 
+					   : SONYPI_TYPE1_PKEY_EV;
 	}
 	else {
 		sonypi_jogger_ev = SONYPI_TYPE1_JOGGER_EV;
 		sonypi_fnkey_ev = SONYPI_TYPE1_FNKEY_EV;
 		sonypi_capture_ev = SONYPI_TYPE1_CAPTURE_EV;
 		sonypi_bluetooth_ev = SONYPI_TYPE1_BLUETOOTH_EV;
+		sonypi_pkey_ev = SONYPI_TYPE1_PKEY_EV;
 	}
 
 	v1 = inb_p(sonypi_device.ioport1);
 	v2 = inb_p(sonypi_device.ioport2);
 
-	if ((v2 & SONYPI_TYPE1_PKEY_EV) == SONYPI_TYPE1_PKEY_EV) {
+	if ((v2 & sonypi_pkey_ev) == sonypi_pkey_ev) {
 		for (i = 0; sonypi_pkeyev[i].event; i++)
 			if (sonypi_pkeyev[i].data == v1) {
 				event = sonypi_pkeyev[i].event;
@@ -713,11 +718,12 @@
 	       SONYPI_DRIVER_MAJORVERSION,
 	       SONYPI_DRIVER_MINORVERSION);
 	printk(KERN_INFO "sonypi: detected %s model, "
-	       "camera = %s, compat = %s\n",
+	       "camera = %s, compat = %s, nojogdial = %s\n",
 	       (sonypi_device.model == SONYPI_DEVICE_MODEL_TYPE1) ?
 			"type1" : "type2",
 	       camera ? "on" : "off",
-	       compat ? "on" : "off");
+	       compat ? "on" : "off",
+	       nojogdial ? "on" : "off");
 	printk(KERN_INFO "sonypi: enabled at irq=%d, port1=0x%x, port2=0x%x\n",
 	       sonypi_device.irq, 
 	       sonypi_device.ioport1, sonypi_device.ioport2);
@@ -791,6 +797,9 @@
 	if (ints[0] == 4)
 		goto out;
 	compat = ints[5];
+	if (ints[0] == 5)
+		goto out;
+	nojogdial = ints[6];
 out:
 	return 1;
 }
@@ -817,5 +826,7 @@
 MODULE_PARM_DESC(camera, "set this if you have a MotionEye camera (PictureBook series)");
 MODULE_PARM(compat,"i");
 MODULE_PARM_DESC(compat, "set this if you want to enable backward compatibility mode");
+MODULE_PARM(nojogdial, "i");
+MODULE_PARM_DESC(nojogdial, "set this if you have a Vaio without a jogdial (like the fx series)");
 
 EXPORT_SYMBOL(sonypi_camera_command);
diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	Mon Mar 11 11:38:54 2002
+++ b/drivers/char/sonypi.h	Mon Mar 11 11:38:54 2002
@@ -35,7 +35,7 @@
 #ifdef __KERNEL__
 
 #define SONYPI_DRIVER_MAJORVERSION	 1
-#define SONYPI_DRIVER_MINORVERSION	10
+#define SONYPI_DRIVER_MINORVERSION	11
 
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -141,6 +141,7 @@
 #define SONYPI_TYPE1_BLUETOOTH_EV	0x30
 #define SONYPI_TYPE2_BLUETOOTH_EV	0x08
 #define SONYPI_TYPE1_PKEY_EV		0x40
+#define SONYPI_TYPE2_PKEY_EV		0x08
 #define SONYPI_BACK_EV			0x08
 #define SONYPI_LID_EV			0x38
 

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
