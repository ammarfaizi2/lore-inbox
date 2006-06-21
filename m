Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWFUUJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWFUUJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 16:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWFUUJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 16:09:20 -0400
Received: from [205.205.44.11] ([205.205.44.11]:3332 "EHLO
	ssbarcelone.teknor.com") by vger.kernel.org with ESMTP
	id S1030208AbWFUUJT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 16:09:19 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: [PATCH] pckeyb legacy free option vs kbd_controller_present()  ( Yet Another Patch)
Date: Wed, 21 Jun 2006 16:09:22 -0400
Message-ID: <C2866F9FC4CB034EB51A633DF1685986369B76@ssbarcelone.teknor.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] pckeyb legacy free option vs kbd_controller_present()  ( Yet Another Patch)
Thread-Index: AcaVbpKg4sOPSxlYT+mH6KNrMC7JSw==
From: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
To: <cananian@alumni.princeton.edu>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is already some patches for this feature (see http://lkml.org/lkml/2002/12/4/162)
This one has the benefit of not being "CONFIG" time, but rather "BOOT" time using  pc_keyb=off.



--- /usr/src/linux-2.4.32/drivers/char/pc_keyb.c	Thu Nov 28 18:53:12 2002
+++ /usr/src/linux-2.4.32-82571ACPI/drivers/char/pc_keyb.c	Wed Jun 21 16:01:42 2006
@@ -13,6 +13,8 @@
  * Code fixes to handle mouse ACKs properly.
  * C. Scott Ananian <cananian@alumni.princeton.edu> 1999-01-29.
  *
+ * Added pc_keyb setup option to avoid boot delays on legacy free PCs
+ * Francois Isabelle <isabellf@sympatico.ca> 2006-06-21
  */
 
 #include <linux/config.h>
@@ -48,6 +50,11 @@
 
 #include <linux/pc_keyb.h>
 
+unsigned int pc_keyb_probe=1; 
+
+static int __devinit pc_keyb_setup(char *str);
+
+
 /* Simple translation table for the SysRq keys */
 
 #ifdef CONFIG_MAGIC_SYSRQ
@@ -801,6 +810,18 @@
 }
 #endif /* CONFIG_PSMOUSE */
 
+
+static int __devinit pc_keyb_setup(char *str)
+{
+	if (!strcmp(str, "off")) {
+		pc_keyb_probe = 0;
+		return 0;
+	}
+	return 1;
+}
+
+__setup("pc_keyb=", pc_keyb_setup);
+
 static char * __init initialize_kbd(void)
 {
 	int status;
@@ -898,6 +919,11 @@
 
 void __init pckbd_init_hw(void)
 {
+	if(!pc_keyb_probe ){
+		kbd_exists = 0;
+		return;
+	}
+
 	if (!kbd_controller_present()) {
 		kbd_exists = 0;
 		return;

Francois Isabelle

