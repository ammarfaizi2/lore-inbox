Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVARB3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVARB3B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVARB3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:29:00 -0500
Received: from mail.dif.dk ([193.138.115.101]:52407 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262847AbVARBTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:19:17 -0500
Date: Tue, 18 Jan 2005 02:22:03 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 04/11] Get rid of verify_area() - drivers part 1, approximately
 first half of drivers/.
Message-ID: <Pine.LNX.4.61.0501180148280.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert a bunch of verify_area()'s to access_ok().
Drivers part 1, approximately first half of drivers/.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-rc1-bk4-orig/drivers/tc/zs.c	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/tc/zs.c	2005-01-17 20:30:12.000000000 +0100
@@ -1267,28 +1267,25 @@ static int rs_ioctl(struct tty_struct *t
 	
 	switch (cmd) {
 		case TIOCGSERIAL:
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-						sizeof(struct serial_struct));
-			if (error)
-				return error;
-			return get_serial_info(info,
-					       (struct serial_struct *) arg);
+			if (access_ok(VERIFY_WRITE, (void *) arg,
+				       sizeof(struct serial_struct)))
+				return get_serial_info(info,
+					(struct serial_struct *) arg);
+			else
+				return -EFAULT;
 		case TIOCSSERIAL:
 			return set_serial_info(info,
 					       (struct serial_struct *) arg);
 		case TIOCSERGETLSR: /* Get line status register */
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-				sizeof(unsigned int));
-			if (error)
-				return error;
+			if (access_ok(VERIFY_WRITE, (void *) arg,
+				      sizeof(unsigned int)))
+				return get_lsr_info(info, (unsigned int *) arg);
 			else
-			    return get_lsr_info(info, (unsigned int *) arg);
-
+				return -EFAULT;
 		case TIOCSERGSTRUCT:
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-						sizeof(struct dec_serial));
-			if (error)
-				return error;
+			if (!access_ok(VERIFY_WRITE, (void *) arg,
+						sizeof(struct dec_serial)))
+				return -EFAULT;
 			copy_from_user((struct dec_serial *) arg,
 				       info, sizeof(struct dec_serial));
 			return 0;
--- linux-2.6.11-rc1-bk4-orig/drivers/net/wireless/orinoco.c	2005-01-16 21:27:12.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/net/wireless/orinoco.c	2005-01-17 20:30:59.000000000 +0100
@@ -2553,9 +2553,8 @@ static int orinoco_ioctl_getiwrange(stru
 
 	TRACE_ENTER(dev->name);
 
-	err = verify_area(VERIFY_WRITE, rrq->pointer, sizeof(range));
-	if (err)
-		return err;
+	if (!access_ok(VERIFY_WRITE, rrq->pointer, sizeof(range)))
+		return -EFAULT;
 
 	rrq->length = sizeof(range);
 
--- linux-2.6.11-rc1-bk4-orig/drivers/mtd/mtdchar.c	2005-01-12 23:26:12.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/mtd/mtdchar.c	2005-01-17 20:34:46.000000000 +0100
@@ -285,12 +285,12 @@ static int mtd_ioctl(struct inode *inode
 
 	size = (cmd & IOCSIZE_MASK) >> IOCSIZE_SHIFT;
 	if (cmd & IOC_IN) {
-		ret = verify_area(VERIFY_READ, argp, size);
-		if (ret) return ret;
+		if (!access_ok(VERIFY_READ, argp, size))
+			return -EFAULT;
 	}
 	if (cmd & IOC_OUT) {
-		ret = verify_area(VERIFY_WRITE, argp, size);
-		if (ret) return ret;
+		if (!access_ok(VERIFY_WRITE, argp, size))
+			return -EFAULT;
 	}
 	
 	switch (cmd) {
@@ -389,7 +389,8 @@ static int mtd_ioctl(struct inode *inode
 		if (!mtd->write_oob)
 			ret = -EOPNOTSUPP;
 		else
-			ret = verify_area(VERIFY_READ, buf.ptr, buf.length);
+			ret = access_ok(VERIFY_READ, buf.ptr, 
+					buf.length) ? 0 : EFAULT;
 
 		if (ret)
 			return ret;
@@ -428,7 +429,8 @@ static int mtd_ioctl(struct inode *inode
 		if (!mtd->read_oob)
 			ret = -EOPNOTSUPP;
 		else
-			ret = verify_area(VERIFY_WRITE, buf.ptr, buf.length);
+			ret = access_ok(VERIFY_WRITE, buf.ptr, 
+					buf.length) ? 0 : -EFAULT;
 
 		if (ret)
 			return ret;
--- linux-2.6.11-rc1-bk4-orig/drivers/usb/serial/kl5kusb105.c	2004-12-24 22:34:58.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/usb/serial/kl5kusb105.c	2005-01-17 20:39:56.000000000 +0100
@@ -925,45 +925,34 @@ static int klsi_105_ioctl (struct usb_se
 		/* TODO */
 		dbg("%s - TIOCMIWAIT not handled", __FUNCTION__);
 		return -ENOIOCTLCMD;
-
 	case TIOCGICOUNT:
 		/* return count of modemline transitions */
 		/* TODO */
 		dbg("%s - TIOCGICOUNT not handled", __FUNCTION__);
 		return -ENOIOCTLCMD;
-	case TCGETS: {
-	     /* return current info to caller */
-	     int retval;
-
-	     dbg("%s - TCGETS data faked/incomplete", __FUNCTION__);
-
-	     retval = verify_area(VERIFY_WRITE, user_arg,
-				  sizeof(struct termios));
-	     if (retval)
-			 return retval;
-
-	     if (kernel_termios_to_user_termios((struct termios __user *)arg,
-						&priv->termios))
-		     return -EFAULT;
-	     return(0);
-	     }
-	case TCSETS: {
-		/* set port termios to the one given by the user */
-		int retval;
+	case TCGETS:
+		/* return current info to caller */
+		dbg("%s - TCGETS data faked/incomplete", __FUNCTION__);
+
+		if (!access_ok(VERIFY_WRITE, user_arg, sizeof(struct termios)))
+			return -EFAULT;
 
+		if (kernel_termios_to_user_termios((struct termios __user *)arg,
+						   &priv->termios))
+			return -EFAULT;
+		return 0;
+	case TCSETS:
+		/* set port termios to the one given by the user */
 		dbg("%s - TCSETS not handled", __FUNCTION__);
 
-		retval = verify_area(VERIFY_READ, user_arg,
-				     sizeof(struct termios));
-		if (retval)
-			    return retval;
+		if (!access_ok(VERIFY_READ, user_arg, sizeof(struct termios)))
+			return -EFAULT;
 
 		if (user_termios_to_kernel_termios(&priv->termios,
-						  (struct termios __user *)arg))
+						   (struct termios __user *)arg))
 			return -EFAULT;
 		klsi_105_set_termios(port, &priv->termios);
-		return(0);
-	     }
+		return 0;
 	case TCSETSW: {
 		/* set port termios and try to wait for completion of last
 		 * write operation */
--- linux-2.6.11-rc1-bk4-orig/drivers/usb/serial/kobil_sct.c	2005-01-12 23:26:21.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/usb/serial/kobil_sct.c	2005-01-17 20:42:03.000000000 +0100
@@ -637,10 +637,9 @@ static int  kobil_ioctl(struct usb_seria
 
 	switch (cmd) {
 	case TCGETS:   // 0x5401
-		result = verify_area(VERIFY_WRITE, user_arg, sizeof(struct termios));
-		if (result) {
-			dbg("%s - port %d Error in verify_area", __FUNCTION__, port->number);
-			return(result);
+		if (!access_ok(VERIFY_WRITE, user_arg, sizeof(struct termios))) {
+			dbg("%s - port %d Error in access_ok", __FUNCTION__, port->number);
+			return -EFAULT;
 		}
 		if (kernel_termios_to_user_termios((struct termios __user *)arg,
 						   &priv->internal_termios))
@@ -652,10 +651,9 @@ static int  kobil_ioctl(struct usb_seria
 			dbg("%s - port %d Error: port->tty->termios is NULL", __FUNCTION__, port->number);
 			return -ENOTTY;
 		}
-		result = verify_area(VERIFY_READ, user_arg, sizeof(struct termios));
-		if (result) {
-			dbg("%s - port %d Error in verify_area", __FUNCTION__, port->number);
-			return result;
+		if (!access_ok(VERIFY_READ, user_arg, sizeof(struct termios))) {
+			dbg("%s - port %d Error in access_ok", __FUNCTION__, port->number);
+			return -EFAULT;
 		}
 		if (user_termios_to_kernel_termios(&priv->internal_termios,
 						   (struct termios __user *)arg))
--- linux-2.6.11-rc1-bk4-orig/drivers/char/rio/rio_linux.c	2005-01-12 23:26:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/char/rio/rio_linux.c	2005-01-17 21:02:23.000000000 +0100
@@ -681,8 +681,9 @@ static int rio_ioctl (struct tty_struct 
     }
     break;
   case TIOCGSERIAL:
-    if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
-                          sizeof(struct serial_struct))) == 0)
+    rc = -EFAULT;
+    if (access_ok(VERIFY_WRITE, (void *) arg,
+                          sizeof(struct serial_struct)))
       rc = gs_getserial(&PortP->gs, (struct serial_struct *) arg);
     break;
   case TCSBRK:
@@ -711,8 +712,9 @@ static int rio_ioctl (struct tty_struct 
     }
     break;
   case TIOCSSERIAL:
-    if ((rc = verify_area(VERIFY_READ, (void *) arg,
-                          sizeof(struct serial_struct))) == 0)
+    rc = -EFAULT;
+    if (access_ok(VERIFY_READ, (void *) arg,
+                          sizeof(struct serial_struct)))
       rc = gs_setserial(&PortP->gs, (struct serial_struct *) arg);
     break;
 #if 0
@@ -722,8 +724,10 @@ static int rio_ioctl (struct tty_struct 
    * #if 0 disablement predates this comment.
    */
   case TIOCMGET:
-    if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
-                          sizeof(unsigned int))) == 0) {
+    rc = -EFAULT;
+    if (access_ok(VERIFY_WRITE, (void *) arg,
+                          sizeof(unsigned int))) {
+      rc = 0;
       ival = rio_getsignals(port);
       put_user(ival, (unsigned int *) arg);
     }
--- linux-2.6.11-rc1-bk4-orig/drivers/char/generic_nvram.c	2004-12-24 22:34:01.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/char/generic_nvram.c	2005-01-17 21:02:48.000000000 +0100
@@ -51,7 +51,7 @@ static ssize_t read_nvram(struct file *f
 	unsigned int i;
 	char __user *p = buf;
 
-	if (verify_area(VERIFY_WRITE, buf, count))
+	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
 	if (*ppos >= NVRAM_SIZE)
 		return 0;
@@ -69,7 +69,7 @@ static ssize_t write_nvram(struct file *
 	const char __user *p = buf;
 	char c;
 
-	if (verify_area(VERIFY_READ, buf, count))
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 	if (*ppos >= NVRAM_SIZE)
 		return 0;
--- linux-2.6.11-rc1-bk4-orig/drivers/char/nwflash.c	2004-12-24 22:35:49.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/char/nwflash.c	2005-01-17 21:03:05.000000000 +0100
@@ -182,7 +182,7 @@ static ssize_t flash_write(struct file *
 	if (count > gbFlashSize - p)
 		count = gbFlashSize - p;
 			
-	if (verify_area(VERIFY_READ, buf, count))
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 
 	/*
--- linux-2.6.11-rc1-bk4-orig/drivers/char/serial_tx3912.c	2004-12-24 22:34:57.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/char/serial_tx3912.c	2005-01-17 21:57:15.000000000 +0100
@@ -617,13 +617,15 @@ static int rs_ioctl (struct tty_struct *
 		}
 		break;
 	case TIOCGSERIAL:
-		if ((rc = verify_area(VERIFY_WRITE, (void *) arg,
-		                      sizeof(struct serial_struct))) == 0)
+		rc = -EFAULT;
+		if (access_ok(VERIFY_WRITE, (void *) arg,
+		                      sizeof(struct serial_struct)))
 			rc = gs_getserial(&port->gs, (struct serial_struct *) arg);
 		break;
 	case TIOCSSERIAL:
-		if ((rc = verify_area(VERIFY_READ, (void *) arg,
-		                      sizeof(struct serial_struct))) == 0)
+		rc = -EFAULT;
+		if (access_ok(VERIFY_READ, (void *) arg,
+		                      sizeof(struct serial_struct)))
 			rc = gs_setserial(&port->gs, (struct serial_struct *) arg);
 		break;
 	default:
--- linux-2.6.11-rc1-bk4-orig/drivers/char/selection.c	2005-01-12 23:26:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/char/selection.c	2005-01-17 21:57:37.000000000 +0100
@@ -122,7 +122,7 @@ int set_selection(const struct tiocl_sel
 
 	{ unsigned short xs, ys, xe, ye;
 
-	  if (verify_area(VERIFY_READ, sel, sizeof(*sel)))
+	  if (!access_ok(VERIFY_READ, sel, sizeof(*sel)))
 		return -EFAULT;
 	  __get_user(xs, &sel->xs);
 	  __get_user(ys, &sel->ys);
--- linux-2.6.11-rc1-bk4-orig/drivers/char/vt_ioctl.c	2005-01-12 23:26:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/char/vt_ioctl.c	2005-01-17 22:19:44.000000000 +0100
@@ -336,15 +336,13 @@ static inline int 
 do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud, int perm, unsigned int console)
 {
 	struct unimapdesc tmp;
-	int i = 0; 
 
 	if (copy_from_user(&tmp, user_ud, sizeof tmp))
 		return -EFAULT;
-	if (tmp.entries) {
-		i = verify_area(VERIFY_WRITE, tmp.entries, 
-						tmp.entry_ct*sizeof(struct unipair));
-		if (i) return i;
-	}
+	if (tmp.entries)
+		if (!access_ok(VERIFY_WRITE, tmp.entries, 
+				tmp.entry_ct*sizeof(struct unipair)))
+			return -EFAULT;
 	switch (cmd) {
 	case PIO_UNIMAP:
 		if (!perm)
@@ -864,7 +862,7 @@ int vt_ioctl(struct tty_struct *tty, str
 		ushort ll,cc,vlin,clin,vcol,ccol;
 		if (!perm)
 			return -EPERM;
-		if (verify_area(VERIFY_READ, vtconsize,
+		if (!access_ok(VERIFY_READ, vtconsize,
 				sizeof(struct vt_consize)))
 			return -EFAULT;
 		__get_user(ll, &vtconsize->v_rows);
--- linux-2.6.11-rc1-bk4-orig/drivers/char/n_hdlc.c	2005-01-12 23:26:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/char/n_hdlc.c	2005-01-17 22:22:08.000000000 +0100
@@ -575,7 +575,6 @@ static ssize_t n_hdlc_tty_read(struct tt
 			   __u8 __user *buf, size_t nr)
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
-	int error;
 	int ret;
 	struct n_hdlc_buf *rbuf;
 
@@ -587,11 +586,10 @@ static ssize_t n_hdlc_tty_read(struct tt
 		return -EIO;
 
 	/* verify user access to buffer */
-	error = verify_area (VERIFY_WRITE, buf, nr);
-	if (error != 0) {
-		printk(KERN_WARNING"%s(%d) n_hdlc_tty_read() can't verify user "
-		"buffer\n",__FILE__,__LINE__);
-		return (error);
+	if (!access_ok(VERIFY_WRITE, buf, nr)) {
+		printk(KERN_WARNING "%s(%d) n_hdlc_tty_read() can't verify user "
+		"buffer\n", __FILE__, __LINE__);
+		return -EFAULT;
 	}
 
 	for (;;) {
--- linux-2.6.11-rc1-bk4-orig/drivers/isdn/i4l/isdn_ppp.c	2004-12-24 22:35:01.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/isdn/i4l/isdn_ppp.c	2005-01-17 22:24:40.000000000 +0100
@@ -764,7 +764,6 @@ isdn_ppp_read(int min, struct file *file
 {
 	struct ippp_struct *is;
 	struct ippp_buf_queue *b;
-	int r;
 	u_long flags;
 	u_char *save_buf;
 
@@ -773,8 +772,8 @@ isdn_ppp_read(int min, struct file *file
 	if (!(is->state & IPPP_OPEN))
 		return 0;
 
-	if ((r = verify_area(VERIFY_WRITE, buf, count)))
-		return r;
+	if (!access_ok(VERIFY_WRITE, buf, count))
+		return -EFAULT;
 
 	spin_lock_irqsave(&is->buflock, flags);
 	b = is->first->next;
@@ -1995,12 +1994,9 @@ isdn_ppp_dev_ioctl_stats(int slot, struc
 	struct ppp_stats __user *res = ifr->ifr_data;
 	struct ppp_stats t;
 	isdn_net_local *lp = (isdn_net_local *) dev->priv;
-	int err;
-
-	err = verify_area(VERIFY_WRITE, res, sizeof(struct ppp_stats));
 
-	if (err)
-		return err;
+	if (!access_ok(VERIFY_WRITE, res, sizeof(struct ppp_stats)))
+		return -EFAULT;
 
 	/* build a temporary stat struct and copy it to user space */
 
--- linux-2.6.11-rc1-bk4-orig/drivers/isdn/i4l/isdn_common.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/isdn/i4l/isdn_common.c	2005-01-17 22:31:04.000000000 +0100
@@ -1180,9 +1180,9 @@ isdn_ioctl(struct inode *inode, struct f
 				if (arg) {
 					ulong __user *p = argp;
 					int i;
-					if ((ret = verify_area(VERIFY_WRITE, p,
-							       sizeof(ulong) * ISDN_MAX_CHANNELS * 2)))
-						return ret;
+					if (!access_ok(VERIFY_WRITE, p,
+							sizeof(ulong) * ISDN_MAX_CHANNELS * 2))
+						return -EFAULT;
 					for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
 						put_user(dev->ibytes[i], p++);
 						put_user(dev->obytes[i], p++);
@@ -1420,10 +1420,10 @@ isdn_ioctl(struct inode *inode, struct f
 					char __user *p = argp;
 					int i;
 
-					if ((ret = verify_area(VERIFY_WRITE, argp,
+					if (!access_ok(VERIFY_WRITE, argp,
 					(ISDN_MODEM_NUMREG + ISDN_MSNLEN + ISDN_LMSNLEN)
-						   * ISDN_MAX_CHANNELS)))
-						return ret;
+						   * ISDN_MAX_CHANNELS))
+						return -EFAULT;
 
 					for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
 						if (copy_to_user(p, dev->mdm.info[i].emu.profile,
@@ -1447,10 +1447,10 @@ isdn_ioctl(struct inode *inode, struct f
 					char __user *p = argp;
 					int i;
 
-					if ((ret = verify_area(VERIFY_READ, argp,
+					if (!access_ok(VERIFY_READ, argp,
 					(ISDN_MODEM_NUMREG + ISDN_MSNLEN + ISDN_LMSNLEN)
-						   * ISDN_MAX_CHANNELS)))
-						return ret;
+						   * ISDN_MAX_CHANNELS))
+						return -EFAULT;
 
 					for (i = 0; i < ISDN_MAX_CHANNELS; i++) {
 						if (copy_from_user(dev->mdm.info[i].emu.profile, p,
@@ -1496,8 +1496,8 @@ isdn_ioctl(struct inode *inode, struct f
 							int j = 0;
 
 							while (1) {
-								if ((ret = verify_area(VERIFY_READ, p, 1)))
-									return ret;
+								if (!access_ok(VERIFY_READ, p, 1))
+									return -EFAULT;
 								get_user(bname[j], p++);
 								switch (bname[j]) {
 									case '\0':
@@ -1563,9 +1563,9 @@ isdn_ioctl(struct inode *inode, struct f
 						drvidx = 0;
 					if (drvidx == -1)
 						return -ENODEV;
-					if ((ret = verify_area(VERIFY_WRITE, argp,
-					     sizeof(isdn_ioctl_struct))))
-						return ret;
+					if (!access_ok(VERIFY_WRITE, argp,
+					     sizeof(isdn_ioctl_struct)))
+						return -EFAULT;
 					c.driver = drvidx;
 					c.command = ISDN_CMD_IOCTL;
 					c.arg = cmd;
--- linux-2.6.11-rc1-bk4-orig/drivers/isdn/icn/icn.c	2005-01-12 23:26:12.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/isdn/icn/icn.c	2005-01-17 22:33:09.000000000 +0100
@@ -908,14 +908,13 @@ icn_loadproto(u_char __user * buffer, ic
 	uint left = ICN_CODE_STAGE2;
 	uint cnt;
 	int timer;
-	int ret;
 	unsigned long flags;
 
 #ifdef BOOT_DEBUG
 	printk(KERN_DEBUG "icn_loadproto called\n");
 #endif
-	if ((ret = verify_area(VERIFY_READ, buffer, ICN_CODE_STAGE2)))
-		return ret;
+	if (!access_ok(VERIFY_READ, buffer, ICN_CODE_STAGE2))
+		return -EFAULT;
 	timer = 0;
 	spin_lock_irqsave(&dev.devlock, flags);
 	if (card->secondhalf) {
--- linux-2.6.11-rc1-bk4-orig/drivers/isdn/isdnloop/isdnloop.c	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/isdn/isdnloop/isdnloop.c	2005-01-17 22:36:08.000000000 +0100
@@ -1146,8 +1146,8 @@ isdnloop_command(isdn_ctrl * c, isdnloop
 				case ISDNLOOP_IOCTL_DEBUGVAR:
 					return (ulong) card;
 				case ISDNLOOP_IOCTL_STARTUP:
-					if ((i = verify_area(VERIFY_READ, (void *) a, sizeof(isdnloop_sdef))))
-						return i;
+					if (!access_ok(VERIFY_READ, (void *) a, sizeof(isdnloop_sdef)))
+						return -EFAULT;
 					return (isdnloop_start(card, (isdnloop_sdef *) a));
 					break;
 				case ISDNLOOP_IOCTL_ADDCARD:
--- linux-2.6.11-rc1-bk4-orig/drivers/isdn/act2000/act2000_isa.c	2004-12-24 22:34:32.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/isdn/act2000/act2000_isa.c	2005-01-17 22:37:25.000000000 +0100
@@ -401,7 +401,6 @@ int
 act2000_isa_download(act2000_card * card, act2000_ddef __user * cb)
 {
         unsigned int length;
-        int ret;
         int l;
         int c;
         long timeout;
@@ -413,12 +412,12 @@ act2000_isa_download(act2000_card * card
         if (!act2000_isa_reset(card->port))
                 return -ENXIO;
         msleep_interruptible(500);
-        if(copy_from_user(&cblock, cb, sizeof(cblock)))
+        if (copy_from_user(&cblock, cb, sizeof(cblock)))
         	return -EFAULT;
         length = cblock.length;
         p = cblock.buffer;
-        if ((ret = verify_area(VERIFY_READ, p, length)))
-                return ret;
+        if (!access_ok(VERIFY_READ, p, length))
+                return -EFAULT;
         buf = (u_char *) kmalloc(1024, GFP_KERNEL);
         if (!buf)
                 return -ENOMEM;
--- linux-2.6.11-rc1-bk4-orig/drivers/s390/net/ctctty.c	2004-12-24 22:34:58.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/s390/net/ctctty.c	2005-01-17 22:38:39.000000000 +0100
@@ -778,11 +778,10 @@ ctc_tty_ioctl(struct tty_struct *tty, st
 			printk(KERN_DEBUG "%s%d ioctl TIOCSERGETLSR\n", CTC_TTY_NAME,
 			       info->line);
 #endif
-			error = verify_area(VERIFY_WRITE, (void __user *) arg, sizeof(uint));
-			if (error)
-				return error;
-			else
+			if (access_ok(VERIFY_WRITE, (void __user *) arg, sizeof(uint)))
 				return ctc_tty_get_lsr_info(info, (uint __user *) arg);
+			else
+				return -EFAULT;
 		default:
 #ifdef CTC_DEBUG_MODEM_IOCTL
 			printk(KERN_DEBUG "UNKNOWN ioctl 0x%08x on %s%d\n", cmd,
--- linux-2.6.11-rc1-bk4-orig/drivers/sbus/char/aurora.c	2004-12-24 22:34:01.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/sbus/char/aurora.c	2005-01-17 22:39:30.000000000 +0100
@@ -1887,14 +1887,12 @@ extern int aurora_get_serial_info(struct
 {
 	struct serial_struct tmp;
 	struct Aurora_board *bp = port_Board(port);
-	int error;
 	
 #ifdef AURORA_DEBUG
 	printk("aurora_get_serial_info: start\n");
 #endif
-	error = verify_area(VERIFY_WRITE, (void *) retinfo, sizeof(tmp));
-	if (error)
-		return error;
+	if (!access_ok(VERIFY_WRITE, (void *) retinfo, sizeof(tmp)))
+		return -EFAULT;
 	
 	memset(&tmp, 0, sizeof(tmp));
 	tmp.type = PORT_CIRRUS;
--- linux-2.6.11-rc1-bk4-orig/drivers/sbus/char/openprom.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/sbus/char/openprom.c	2005-01-17 22:41:33.000000000 +0100
@@ -427,16 +427,14 @@ static int openprom_bsd_ioctl(struct ino
 			len = op.op_buflen = 0;
 		}
 
-		error = verify_area(VERIFY_WRITE, argp, sizeof(op));
-		if (error) {
+		if (!access_ok(VERIFY_WRITE, argp, sizeof(op))) {
 			kfree(str);
-			return error;
+			return -EFAULT;
 		}
 
-		error = verify_area(VERIFY_WRITE, op.op_buf, len);
-		if (error) {
+		if (!access_ok(VERIFY_WRITE, op.op_buf, len)) {
 			kfree(str);
-			return error;
+			return -EFAULT;
 		}
 
 		error = __copy_to_user(argp, &op, sizeof(op));



