Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTDUSbd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbTDUSbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:31:33 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:56628 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261885AbTDUSbZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:31:25 -0400
Subject: [PATCH] synclinkmp.c 2.5.68
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050950605.1841.33.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Apr 2003 13:43:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove MODULE_USE_COUNT macros
* Add owner member
* Add tiocmget/tiocmset tty callbacks

Please Apply

Paul Fulghum
paulkf@microgate.com


--- linux-2.5.68/drivers/char/synclinkmp.c	2003-04-07 12:30:46.000000000 -0500
+++ linux-2.5.68-mg/drivers/char/synclinkmp.c	2003-04-21 12:54:06.666577344 -0500
@@ -1,5 +1,5 @@
 /*
- * $Id: synclinkmp.c,v 4.6 2002/10/10 14:50:47 paulkf Exp $
+ * $Id: synclinkmp.c,v 4.8 2003/04/21 17:46:55 paulkf Exp $
  *
  * Device driver for Microgate SyncLink Multiport
  * high speed multiprotocol serial adapter.
@@ -503,7 +503,7 @@
 MODULE_PARM(dosyncppp,"1-" __MODULE_STRING(MAX_DEVICES) "i");
 
 static char *driver_name = "SyncLink MultiPort driver";
-static char *driver_version = "$Revision: 4.6 $";
+static char *driver_version = "$Revision: 4.8 $";
 
 static int synclinkmp_init_one(struct pci_dev *dev,const struct pci_device_id *ent);
 static void synclinkmp_remove_one(struct pci_dev *dev);
@@ -592,8 +592,9 @@
 static int  map_status(int signals);
 static int  modem_input_wait(SLMP_INFO *info,int arg);
 static int  wait_mgsl_event(SLMP_INFO *info, int *mask_ptr);
-static int  get_modem_info(SLMP_INFO *info, unsigned int *value);
-static int  set_modem_info(SLMP_INFO *info, unsigned int cmd,unsigned int *value);
+static int  tiocmget(struct tty_struct *tty, struct file *file);
+static int  tiocmset(struct tty_struct *tty, struct file *file,
+		     unsigned int set, unsigned int clear);
 static void set_break(struct tty_struct *tty, int break_state);
 
 static void add_device(SLMP_INFO *info);
@@ -770,8 +771,6 @@
 		printk("%s(%d):%s open(), old ref count = %d\n",
 			 __FILE__,__LINE__,tty->driver.name, info->count);
 
-	MOD_INC_USE_COUNT;
-
 	/* If port is closing, signal caller to try again */
 	if (tty_hung_up_p(filp) || info->flags & ASYNC_CLOSING){
 		if (info->flags & ASYNC_CLOSING)
@@ -826,7 +825,6 @@
 
 cleanup:
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		if(info->count)
 			info->count--;
 	}
@@ -925,7 +923,6 @@
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):%s close() exit, count=%d\n", __FILE__,__LINE__,
 			tty->driver.name, info->count);
-	MOD_DEC_USE_COUNT;
 }
 
 /* Called by tty_hangup() when a hangup is signaled.
@@ -1387,12 +1384,6 @@
 	}
 
 	switch (cmd) {
-	case TIOCMGET:
-		return get_modem_info(info, (unsigned int *) arg);
-	case TIOCMBIS:
-	case TIOCMBIC:
-	case TIOCMSET:
-		return set_modem_info(info, cmd, (unsigned int *) arg);
 	case MGSL_IOCGPARAMS:
 		return get_params(info,(MGSL_PARAMS *)arg);
 	case MGSL_IOCSPARAMS:
@@ -1717,7 +1708,7 @@
 {
 	SLMP_INFO *info = d->priv;
 	int err;
-	long flags;
+	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("sppp_cb_open(%s)\n",info->netname);
@@ -1729,7 +1720,6 @@
 		return -EBUSY;
 	}
 	info->netcount=1;
-	MOD_INC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 
 	/* claim resources and init adapter */
@@ -1752,7 +1742,6 @@
 open_fail:
 	spin_lock_irqsave(&info->netlock, flags);
 	info->netcount=0;
-	MOD_DEC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 	return err;
 }
@@ -1760,7 +1749,7 @@
 static void sppp_cb_tx_timeout(struct net_device *dev)
 {
 	SLMP_INFO *info = dev->priv;
-	long flags;
+	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("sppp_tx_timeout(%s)\n",info->netname);
@@ -1818,7 +1807,6 @@
 
 	spin_lock_irqsave(&info->netlock, flags);
 	info->netcount=0;
-	MOD_DEC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 	return 0;
 }
@@ -3146,11 +3134,11 @@
 
 /* return the state of the serial control and status signals
  */
-static int get_modem_info(SLMP_INFO * info, unsigned int *value)
+static int tiocmget(struct tty_struct *tty, struct file *file)
 {
+	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
 	unsigned int result;
  	unsigned long flags;
-	int err;
 
 	spin_lock_irqsave(&info->lock,flags);
  	get_signals(info);
@@ -3164,61 +3152,31 @@
 		((info->serial_signals & SerialSignal_CTS) ? TIOCM_CTS:0);
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("%s(%d):%s synclinkmp_get_modem_info() value=%08X\n",
+		printk("%s(%d):%s tiocmget() value=%08X\n",
 			 __FILE__,__LINE__, info->device_name, result );
-
-	PUT_USER(err,result,value);
-	return err;
+	return result;
 }
 
 /* set modem control signals (DTR/RTS)
- *
- * 	cmd	signal command: TIOCMBIS = set bit TIOCMBIC = clear bit
- *		TIOCMSET = set/clear signal values
- * 	value	bit mask for command
  */
-static int set_modem_info(SLMP_INFO * info, unsigned int cmd,
-			  unsigned int *value)
+static int tiocmset(struct tty_struct *tty, struct file *file,
+		    unsigned int set, unsigned int clear)
 {
- 	int error;
- 	unsigned int arg;
+	SLMP_INFO *info = (SLMP_INFO *)tty->driver_data;
  	unsigned long flags;
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("%s(%d):%s synclinkmp_set_modem_info()\n",
-			__FILE__,__LINE__,info->device_name );
-
- 	GET_USER(error,arg,value);
- 	if (error)
- 		return error;
-
- 	switch (cmd) {
- 	case TIOCMBIS:
- 		if (arg & TIOCM_RTS)
- 			info->serial_signals |= SerialSignal_RTS;
- 		if (arg & TIOCM_DTR)
- 			info->serial_signals |= SerialSignal_DTR;
- 		break;
- 	case TIOCMBIC:
- 		if (arg & TIOCM_RTS)
- 			info->serial_signals &= ~SerialSignal_RTS;
- 		if (arg & TIOCM_DTR)
- 			info->serial_signals &= ~SerialSignal_DTR;
- 		break;
- 	case TIOCMSET:
- 		if (arg & TIOCM_RTS)
- 			info->serial_signals |= SerialSignal_RTS;
-		else
- 			info->serial_signals &= ~SerialSignal_RTS;
+		printk("%s(%d):%s tiocmset(%x,%x)\n",
+			__FILE__,__LINE__,info->device_name, set, clear);
 
- 		if (arg & TIOCM_DTR)
- 			info->serial_signals |= SerialSignal_DTR;
-		else
- 			info->serial_signals &= ~SerialSignal_DTR;
- 		break;
- 	default:
- 		return -EINVAL;
- 	}
+	if (set & TIOCM_RTS)
+		info->serial_signals |= SerialSignal_RTS;
+	if (set & TIOCM_DTR)
+		info->serial_signals |= SerialSignal_DTR;
+	if (clear & TIOCM_RTS)
+		info->serial_signals &= ~SerialSignal_RTS;
+	if (clear & TIOCM_DTR)
+		info->serial_signals &= ~SerialSignal_DTR;
 
 	spin_lock_irqsave(&info->lock,flags);
  	set_signals(info);
@@ -3875,6 +3833,7 @@
 
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.driver_name = "synclinkmp";
 	serial_driver.name = "ttySLM";
 	serial_driver.major = ttymajor;
@@ -3910,6 +3869,8 @@
 	serial_driver.stop = tx_hold;
 	serial_driver.start = tx_release;
 	serial_driver.hangup = hangup;
+	serial_driver.tiocmget = tiocmget;
+	serial_driver.tiocmset = tiocmset;
 
 	/*
 	 * The callout device is just like normal device except for



