Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263773AbTDGXTY (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTDGXPc (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:15:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62592
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263829AbTDGXHn (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:07:43 -0400
Date: Tue, 8 Apr 2003 01:26:34 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080026.h380QYNr009131@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: update slip to new tty module locks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/drivers/net/slip.c linux-2.5.67-ac1/drivers/net/slip.c
--- linux-2.5.67/drivers/net/slip.c	2003-02-10 18:39:17.000000000 +0000
+++ linux-2.5.67-ac1/drivers/net/slip.c	2003-04-07 18:56:42.000000000 +0100
@@ -836,8 +836,6 @@
 	if(!capable(CAP_NET_ADMIN))
 		return -EPERM;
 		
-	MOD_INC_USE_COUNT;
-
 	/* RTnetlink lock is misused here to serialize concurrent
 	   opens of slip channels. There are better ways, but it is
 	   the simplest one.
@@ -905,7 +903,6 @@
 	rtnl_unlock();
 
 	/* Count references from TTY module */
-	MOD_DEC_USE_COUNT;
 	return err;
 }
 
@@ -953,7 +950,6 @@
 #endif
 
 	/* Count references from TTY module */
-	MOD_DEC_USE_COUNT;
 }
 
  /************************************************************************
@@ -1122,8 +1118,7 @@
 #endif /* CONFIG_SLIP_MODE_SLIP6 */
 
 /* Perform I/O control on an active SLIP channel. */
-static int
-slip_ioctl(struct tty_struct *tty, void *file, int cmd, void *arg)
+static int slip_ioctl(struct tty_struct *tty, struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct slip *sl = (struct slip *) tty->disc_data;
 	unsigned int tmp;
@@ -1135,11 +1130,8 @@
 
 	switch(cmd) {
 	 case SIOCGIFNAME:
-		/* Please, do not put this line under copy_to_user,
-		   it breaks my old poor gcc on alpha --ANK
-		 */
 		tmp = strlen(sl->dev->name) + 1;
-		if (copy_to_user(arg, sl->dev->name, tmp))
+		if (copy_to_user((void *)arg, sl->dev->name, tmp))
 			return -EFAULT;
 		return 0;
 
@@ -1230,7 +1222,7 @@
 	/* Allow stty to read, but not set, the serial port */
 	case TCGETS:
 	case TCGETA:
-		return n_tty_ioctl(tty, (struct file *) file, cmd, (unsigned long) arg);
+		return n_tty_ioctl(tty, file, cmd, arg);
 
 	default:
 		return -ENOIOCTLCMD;
@@ -1349,34 +1341,28 @@
 	memset(slip_ctrls, 0, sizeof(void*)*slip_maxdev); /* Pointers */
 
 	/* Fill in our line protocol discipline, and register it */
-	memset(&sl_ldisc, 0, sizeof(sl_ldisc));
-	sl_ldisc.magic  = TTY_LDISC_MAGIC;
-	sl_ldisc.name   = "slip";
-	sl_ldisc.flags  = 0;
-	sl_ldisc.open   = slip_open;
-	sl_ldisc.close  = slip_close;
-	sl_ldisc.read   = NULL;
-	sl_ldisc.write  = NULL;
-	sl_ldisc.ioctl  = (int (*)(struct tty_struct *, struct file *,
-				   unsigned int, unsigned long)) slip_ioctl;
-	sl_ldisc.poll   = NULL;
-	sl_ldisc.receive_buf = slip_receive_buf;
-	sl_ldisc.receive_room = slip_receive_room;
-	sl_ldisc.write_wakeup = slip_write_wakeup;
 	if ((status = tty_register_ldisc(N_SLIP, &sl_ldisc)) != 0)  {
 		printk(KERN_ERR "SLIP: can't register line discipline (err = %d)\n", status);
 	}
-
-
 	return status;
 }
 
-
+static struct tty_ldisc	sl_ldisc =
+{
+	.owner 		=	THIS_MODULE,
+	.magic 		= 	TTY_LDISC_MAGIC,
+	.name 		= 	"slip",
+	.open 		= 	slip_open,
+	.close	 	= 	slip_close,
+	.ioctl		=	slip_ioctl,
+	.receive_buf	=	slip_receive_buf,
+	.receive_room	=	slip_receive_room,
+	.write_wakeup	=	slip_write_wakeup,
+};
 
 #ifdef MODULE
 
-int
-init_module(void)
+int init_module(void)
 {
 	return slip_init_ctrl_dev();
 }
