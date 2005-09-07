Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVIGRet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVIGRet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 13:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbVIGRes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 13:34:48 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:61899
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751196AbVIGRes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 13:34:48 -0400
Subject: [patch] synclinkmp.c fix double mapping of signals
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1126114482.4056.3.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 07 Sep 2005 12:34:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] synclinkmp.c fix double mapping of signals

From: Paul Fulghum <paulkf@microgate.com>

Serial signals were incorrectly mapped twice
to events.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.13/drivers/char/synclinkmp.c	2005-08-28 18:41:01.000000000 -0500
+++ linux-2.6.13-mg/drivers/char/synclinkmp.c	2005-09-07 12:21:33.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.34 2005/03/04 15:07:10 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.38 2005/07/15 13:29:44 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -487,7 +487,7 @@ module_param_array(maxframe, int, NULL, 
 module_param_array(dosyncppp, int, NULL, 0);
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.34 $";
+static char *driver_version = "$Revision: 4.38 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -556,7 +556,6 @@ static int  set_txidle(SLMP_INFO *info, 
 static int  tx_enable(SLMP_INFO *info, int enable);
 static int  tx_abort(SLMP_INFO *info);
 static int  rx_enable(SLMP_INFO *info, int enable);
-static int  map_status(int signals);
 static int  modem_input_wait(SLMP_INFO *info,int arg);
 static int  wait_mgsl_event(SLMP_INFO *info, int __user *mask_ptr);
 static int  tiocmget(struct tty_struct *tty, struct file *file);
@@ -3109,16 +3108,6 @@ static int rx_enable(SLMP_INFO * info, i
 	return 0;
 }
 
-static int map_status(int signals)
-{
-	/* Map status bits to API event bits */
-
-	return ((signals & SerialSignal_DSR) ? MgslEvent_DsrActive : MgslEvent_DsrInactive) +
-	       ((signals & SerialSignal_CTS) ? MgslEvent_CtsActive : MgslEvent_CtsInactive) +
-	       ((signals & SerialSignal_DCD) ? MgslEvent_DcdActive : MgslEvent_DcdInactive) +
-	       ((signals & SerialSignal_RI)  ? MgslEvent_RiActive : MgslEvent_RiInactive);
-}
-
 /* wait for specified event to occur
  */
 static int wait_mgsl_event(SLMP_INFO * info, int __user *mask_ptr)
@@ -3145,7 +3134,7 @@ static int wait_mgsl_event(SLMP_INFO * i
 
 	/* return immediately if state matches requested events */
 	get_signals(info);
-	s = map_status(info->serial_signals);
+	s = info->serial_signals;
 
 	events = mask &
 		( ((s & SerialSignal_DSR) ? MgslEvent_DsrActive:MgslEvent_DsrInactive) +


