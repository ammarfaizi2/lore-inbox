Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVCVCMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVCVCMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262343AbVCVCKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:10:41 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:6283 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262322AbVCVBfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:12 -0500
Message-Id: <20050322013457.576389000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:23:57 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-av7110-ir-fix-oops.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 24/48] av7110: fix Oops when av7110_ir_init() failed
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o don't call av7110_ir_init() if driver initialization failed already
  due to previous errors (resulted in Oops in out-of-memory conditions) (me)
o don't do av7110_ir_exit if init was not done (Kenneth Aafloy)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 av7110.c    |   15 +++------------
 av7110_ir.c |    8 ++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110.c	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110.c	2005-03-22 00:17:56.000000000 +0100
@@ -2453,6 +2453,9 @@ err_no_mem:
 	av7110->dvb_adapter->priv = av7110;
 	frontend_init(av7110);
 
+#if defined(CONFIG_INPUT_EVDEV) || defined(CONFIG_INPUT_EVDEV_MODULE)
+	av7110_ir_init();
+#endif
 	printk(KERN_INFO "dvb-ttpci: found av7110-%d.\n", av7110_num);
 	av7110->device_initialized = 1;
 	av7110_num++;
@@ -2640,18 +2643,6 @@ static int __init av7110_init(void)
 {
 	int retval;
 	retval = saa7146_register_extension(&av7110_extension);
-#if defined(CONFIG_INPUT_EVDEV) || defined(CONFIG_INPUT_EVDEV_MODULE)
-	if (retval)
-		goto failed_saa7146_register;
-
-	retval = av7110_ir_init();
-	if (retval)
-		goto failed_av7110_ir_init;
-	return 0;
-failed_av7110_ir_init:
-	saa7146_unregister_extension(&av7110_extension);
-failed_saa7146_register:
-#endif
 	return retval;
 }
 
Index: linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_ir.c
===================================================================
--- linux-2.6.12-rc1-mm1.orig/drivers/media/dvb/ttpci/av7110_ir.c	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/drivers/media/dvb/ttpci/av7110_ir.c	2005-03-22 00:17:56.000000000 +0100
@@ -12,6 +12,7 @@
 
 /* enable ir debugging by or'ing av7110_debug with 16 */
 
+static int ir_initialized;
 static struct input_dev input_dev;
 
 static u32 ir_config;
@@ -160,6 +161,9 @@ static int av7110_ir_write_proc(struct f
 
 int __init av7110_ir_init(void)
 {
+	if (ir_initialized)
+		return 0;
+
 	static struct proc_dir_entry *e;
 
 	init_timer(&keyup_timer);
@@ -187,16 +191,20 @@ int __init av7110_ir_init(void)
 		e->size = 4 + 256 * sizeof(u16);
 	}
 
+	ir_initialized = 1;
 	return 0;
 }
 
 
 void __exit av7110_ir_exit(void)
 {
+	if (ir_initialized == 0)
+		return;
 	del_timer_sync(&keyup_timer);
 	remove_proc_entry("av7110_ir", NULL);
 	av7110_unregister_irc_handler(av7110_emit_key);
 	input_unregister_device(&input_dev);
+	ir_initialized = 0;
 }
 
 //MODULE_AUTHOR("Holger Waechtler <holger@convergence.de>");

--

