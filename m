Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTDUS3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTDUS3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:29:05 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:50228 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261835AbTDUS3A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:29:00 -0400
Subject: [PATCH] synclink.c 2.5.68
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050950459.1841.29.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Apr 2003 13:41:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Remove MODULE_USE_COUNT macros
* Add owner member
* Add tiocmget/tiocmset tty callbacks

Please Apply

Paul Fulghum
paulkf@microgate.com

--- linux-2.5.68/drivers/char/synclink.c	2003-04-07 12:31:04.000000000 -0500
+++ linux-2.5.68-mg/drivers/char/synclink.c	2003-04-21 12:54:06.657578712 -0500
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.4 2002/10/10 14:53:36 paulkf Exp $
+ * $Id: synclink.c,v 4.6 2003/04/21 17:46:54 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -854,9 +854,9 @@
 /*
  * ioctl call handlers
  */
-static int set_modem_info(struct mgsl_struct * info, unsigned int cmd,
-			  unsigned int *value);
-static int get_modem_info(struct mgsl_struct * info, unsigned int *value);
+static int tiocmget(struct tty_struct *tty, struct file *file);
+static int tiocmset(struct tty_struct *tty, struct file *file,
+		    unsigned int set, unsigned int clear);
 static int mgsl_get_stats(struct mgsl_struct * info, struct mgsl_icount
 	*user_icount);
 static int mgsl_get_params(struct mgsl_struct * info, MGSL_PARAMS *user_params);
@@ -917,7 +917,7 @@
 MODULE_PARM(txholdbufs,"1-" __MODULE_STRING(MAX_TOTAL_DEVICES) "i");
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.4 $";
+static char *driver_version = "$Revision: 4.6 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -2921,110 +2921,58 @@
 	return rc;
 }
 
-/* get_modem_info()
- * 
- * 	Read the state of the serial control and
- * 	status signals and return to caller.
- * 	
- * Arguments:	 	info	pointer to device instance data
- * 			value	pointer to int to hold returned info
- * 	
- * Return Value:	0 if success, otherwise error code
+/* return the state of the serial control and status signals
  */
-static int get_modem_info(struct mgsl_struct * info, unsigned int *value)
+static int tiocmget(struct tty_struct *tty, struct file *file)
 {
-	unsigned int result = 0;
+	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
+	unsigned int result;
  	unsigned long flags;
-	int err;
- 
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
  	usc_get_serial_signals(info);
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
 
-	if (info->serial_signals & SerialSignal_RTS)
-		result |= TIOCM_RTS;
-	if (info->serial_signals & SerialSignal_DTR)
-		result |= TIOCM_DTR;
-	if (info->serial_signals & SerialSignal_DCD)
-		result |= TIOCM_CAR;
-	if (info->serial_signals & SerialSignal_RI)
-		result |= TIOCM_RNG;
-	if (info->serial_signals & SerialSignal_DSR)
-		result |= TIOCM_DSR;
-	if (info->serial_signals & SerialSignal_CTS)
-		result |= TIOCM_CTS;
+	result = ((info->serial_signals & SerialSignal_RTS) ? TIOCM_RTS:0) +
+		((info->serial_signals & SerialSignal_DTR) ? TIOCM_DTR:0) +
+		((info->serial_signals & SerialSignal_DCD) ? TIOCM_CAR:0) +
+		((info->serial_signals & SerialSignal_RI)  ? TIOCM_RNG:0) +
+		((info->serial_signals & SerialSignal_DSR) ? TIOCM_DSR:0) +
+		((info->serial_signals & SerialSignal_CTS) ? TIOCM_CTS:0);
 
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("%s(%d):mgsl_get_modem_info %s value=%08X\n",
+		printk("%s(%d):%s tiocmget() value=%08X\n",
 			 __FILE__,__LINE__, info->device_name, result );
-			
-	PUT_USER(err,result,value);
-	return err;
-}	/* end of get_modem_info() */
+	return result;
+}
 
-/* set_modem_info()
- * 
- * 	Set the state of the modem control signals (DTR/RTS)
- * 	
- * Arguments:
- * 
- * 	info	pointer to device instance data
- * 	cmd	signal command: TIOCMBIS = set bit TIOCMBIC = clear bit
- *		TIOCMSET = set/clear signal values
- * 	value	bit mask for command
- * 	
- * Return Value:	0 if success, otherwise error code
+/* set modem control signals (DTR/RTS)
  */
-static int set_modem_info(struct mgsl_struct * info, unsigned int cmd,
-			  unsigned int *value)
+static int tiocmset(struct tty_struct *tty, struct file *file,
+		    unsigned int set, unsigned int clear)
 {
- 	int error;
- 	unsigned int arg;
+	struct mgsl_struct *info = (struct mgsl_struct *)tty->driver_data;
  	unsigned long flags;
- 
+
 	if (debug_level >= DEBUG_LEVEL_INFO)
-		printk("%s(%d):mgsl_set_modem_info %s\n", __FILE__,__LINE__,
-			info->device_name );
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
-		
- 		if (arg & TIOCM_DTR)
- 			info->serial_signals |= SerialSignal_DTR;
-		else
- 			info->serial_signals &= ~SerialSignal_DTR;
- 		break;
- 	default:
- 		return -EINVAL;
- 	}
-	
+		printk("%s(%d):%s tiocmset(%x,%x)\n",
+			__FILE__,__LINE__,info->device_name, set, clear);
+
+	if (set & TIOCM_RTS)
+		info->serial_signals |= SerialSignal_RTS;
+	if (set & TIOCM_DTR)
+		info->serial_signals |= SerialSignal_DTR;
+	if (clear & TIOCM_RTS)
+		info->serial_signals &= ~SerialSignal_RTS;
+	if (clear & TIOCM_DTR)
+		info->serial_signals &= ~SerialSignal_DTR;
+
 	spin_lock_irqsave(&info->irq_spinlock,flags);
  	usc_set_serial_signals(info);
 	spin_unlock_irqrestore(&info->irq_spinlock,flags);
-	
+
 	return 0;
-	
-}	/* end of set_modem_info() */
+}
 
 /* mgsl_break()		Set or clear transmit break condition
  *
@@ -3093,12 +3041,6 @@
 	unsigned long flags;
 	
 	switch (cmd) {
-		case TIOCMGET:
-			return get_modem_info(info, (unsigned int *) arg);
-		case TIOCMBIS:
-		case TIOCMBIC:
-		case TIOCMSET:
-			return set_modem_info(info, cmd, (unsigned int *) arg);
 		case MGSL_IOCGPARAMS:
 			return mgsl_get_params(info,(MGSL_PARAMS *)arg);
 		case MGSL_IOCSPARAMS:
@@ -3323,7 +3265,6 @@
 	if (debug_level >= DEBUG_LEVEL_INFO)
 		printk("%s(%d):mgsl_close(%s) exit, count=%d\n", __FILE__,__LINE__,
 			tty->driver.name, info->count);
-	MOD_DEC_USE_COUNT;
 			
 }	/* end of mgsl_close() */
 
@@ -3615,8 +3556,6 @@
 		printk("%s(%d):mgsl_open(%s), old ref count = %d\n",
 			 __FILE__,__LINE__,tty->driver.name, info->count);
 
-	MOD_INC_USE_COUNT;
-	
 	/* If port is closing, signal caller to try again */
 	if (tty_hung_up_p(filp) || info->flags & ASYNC_CLOSING){
 		if (info->flags & ASYNC_CLOSING)
@@ -3683,7 +3622,6 @@
 	
 cleanup:			
 	if (retval) {
-		MOD_DEC_USE_COUNT;
 		if(info->count)
 			info->count--;
 	}
@@ -4571,6 +4509,7 @@
 	
 	memset(&serial_driver, 0, sizeof(struct tty_driver));
 	serial_driver.magic = TTY_DRIVER_MAGIC;
+	serial_driver.owner = THIS_MODULE;
 	serial_driver.driver_name = "synclink";
 	serial_driver.name = "ttySL";
 	serial_driver.major = ttymajor;
@@ -4606,6 +4545,8 @@
 	serial_driver.stop = mgsl_stop;
 	serial_driver.start = mgsl_start;
 	serial_driver.hangup = mgsl_hangup;
+	serial_driver.tiocmget = tiocmget;
+	serial_driver.tiocmset = tiocmset;
 	
 	/*
 	 * The callout device is just like normal device except for
@@ -8003,7 +7944,6 @@
 		return -EBUSY;
 	}
 	info->netcount=1;
-	MOD_INC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 
 	/* claim resources and init adapter */
@@ -8026,7 +7966,6 @@
 open_fail:
 	spin_lock_irqsave(&info->netlock, flags);
 	info->netcount=0;
-	MOD_DEC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 	return err;
 }
@@ -8092,7 +8031,6 @@
 
 	spin_lock_irqsave(&info->netlock, flags);
 	info->netcount=0;
-	MOD_DEC_USE_COUNT;
 	spin_unlock_irqrestore(&info->netlock, flags);
 	return 0;
 }



