Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVCDDgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVCDDgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 22:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbVCDD2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 22:28:21 -0500
Received: from mail.dif.dk ([193.138.115.101]:35038 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262850AbVCDCqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:46:35 -0500
Date: Fri, 4 Mar 2005 03:47:26 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][1/10] verify_area cleanup : drivers part 1
Message-ID: <Pine.LNX.4.62.0503040321010.2801@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch converts the first half of drivers from verify_area to 
access_ok.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -urp linux-2.6.11-orig/drivers/block/nbd.c linux-2.6.11/drivers/block/nbd.c
--- linux-2.6.11-orig/drivers/block/nbd.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11/drivers/block/nbd.c	2005-03-03 22:51:28.000000000 +0100
@@ -38,7 +38,7 @@
  * 03-06-24 Cleanup PARANOIA usage & code. <ldl@aros.net>
  * 04-02-19 Remove PARANOIA, plus various cleanups (Paul Clements)
  * possible FIXME: make set_sock / set_blksize / set_size / do_it one syscall
- * why not: would need verify_area and friends, would share yet another 
+ * why not: would need access_ok and friends, would share yet another 
  *          structure with userland
  */
 
diff -urp linux-2.6.11-orig/drivers/block/viodasd.c linux-2.6.11/drivers/block/viodasd.c
--- linux-2.6.11-orig/drivers/block/viodasd.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11/drivers/block/viodasd.c	2005-03-03 22:51:28.000000000 +0100
@@ -250,7 +250,6 @@ static int viodasd_release(struct inode 
 static int viodasd_ioctl(struct inode *ino, struct file *fil,
 			 unsigned int cmd, unsigned long arg)
 {
-	int err;
 	unsigned char sectors;
 	unsigned char heads;
 	unsigned short cylinders;
@@ -263,9 +262,8 @@ static int viodasd_ioctl(struct inode *i
 		geo = (struct hd_geometry *)arg;
 		if (geo == NULL)
 			return -EINVAL;
-		err = verify_area(VERIFY_WRITE, geo, sizeof(*geo));
-		if (err)
-			return err;
+		if (!access_ok(VERIFY_WRITE, geo, sizeof(*geo)))
+			return -EFAULT;
 		gendisk = ino->i_bdev->bd_disk;
 		d = gendisk->private_data;
 		sectors = d->sectors;
diff -urp linux-2.6.11-orig/drivers/bluetooth/hci_vhci.c linux-2.6.11/drivers/bluetooth/hci_vhci.c
--- linux-2.6.11-orig/drivers/bluetooth/hci_vhci.c	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.11/drivers/bluetooth/hci_vhci.c	2005-03-03 22:51:28.000000000 +0100
@@ -157,7 +157,7 @@ static ssize_t hci_vhci_chr_write(struct
 {
 	struct hci_vhci_struct *hci_vhci = (struct hci_vhci_struct *) file->private_data;
 
-	if (verify_area(VERIFY_READ, buf, count))
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 
 	return hci_vhci_get_user(hci_vhci, buf, count);
@@ -222,7 +222,7 @@ static ssize_t hci_vhci_chr_read(struct 
 			continue;
 		}
 
-		if (!verify_area(VERIFY_WRITE, buf, count))
+		if (access_ok(VERIFY_WRITE, buf, count))
 			ret = hci_vhci_put_user(hci_vhci, skb, buf, count);
 		else
 			ret = -EFAULT;
diff -urp linux-2.6.11-orig/drivers/cdrom/cdu31a.c linux-2.6.11/drivers/cdrom/cdu31a.c
--- linux-2.6.11-orig/drivers/cdrom/cdu31a.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11/drivers/cdrom/cdu31a.c	2005-03-03 22:51:28.000000000 +0100
@@ -2769,7 +2769,6 @@ static int scd_dev_ioctl(struct cdrom_de
 			 unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
-	int i;
 
 	switch (cmd) {
 	case CDROMREADAUDIO:	/* Read 2352 byte audio tracks and 2340 byte
@@ -2790,10 +2789,9 @@ static int scd_dev_ioctl(struct cdrom_de
 				return 0;
 			}
 
-			i = verify_area(VERIFY_WRITE, ra.buf,
-					CD_FRAMESIZE_RAW * ra.nframes);
-			if (i < 0)
-				return i;
+			if (!access_ok(VERIFY_WRITE, ra.buf,
+					CD_FRAMESIZE_RAW * ra.nframes))
+				return -EFAULT;
 
 			if (ra.addr_format == CDROM_LBA) {
 				if ((ra.addr.lba >=
diff -urp linux-2.6.11-orig/drivers/cdrom/sbpcd.c linux-2.6.11/drivers/cdrom/sbpcd.c
--- linux-2.6.11-orig/drivers/cdrom/sbpcd.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.11/drivers/cdrom/sbpcd.c	2005-03-03 22:51:28.000000000 +0100
@@ -4266,9 +4266,9 @@ static int sbpcd_dev_ioctl(struct cdrom_
 				   sizeof(struct cdrom_read_audio)))
 			RETURN_UP(-EFAULT);
 		if (read_audio.nframes < 0 || read_audio.nframes>current_drive->sbp_audsiz) RETURN_UP(-EINVAL);
-		i=verify_area(VERIFY_WRITE, read_audio.buf,
-			      read_audio.nframes*CD_FRAMESIZE_RAW);
-		if (i) RETURN_UP(i);
+		if (!access_ok(VERIFY_WRITE, read_audio.buf,
+			      read_audio.nframes*CD_FRAMESIZE_RAW))
+                	RETURN_UP(-EFAULT);
 		
 		if (read_audio.addr_format==CDROM_MSF) /* MSF-bin specification of where to start */
 			block=msf2lba(&read_audio.addr.msf.minute);
diff -urp linux-2.6.11-orig/drivers/cdrom/sjcd.c linux-2.6.11/drivers/cdrom/sjcd.c
--- linux-2.6.11-orig/drivers/cdrom/sjcd.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11/drivers/cdrom/sjcd.c	2005-03-03 22:51:28.000000000 +0100
@@ -831,8 +831,8 @@ static int sjcd_ioctl(struct inode *ip, 
 			printk("SJCD: ioctl: playmsf\n");
 #endif
 			if ((s =
-			     verify_area(VERIFY_READ, argp,
-					 sizeof(sjcd_msf))) == 0) {
+			     access_ok(VERIFY_READ, argp, sizeof(sjcd_msf)) 
+			     		? 0 : -EFAULT) == 0) {
 				if (sjcd_audio_status == CDROM_AUDIO_PLAY) {
 					sjcd_send_cmd(SCMD_PAUSE);
 					(void) sjcd_receive_status();
@@ -888,8 +888,8 @@ static int sjcd_ioctl(struct inode *ip, 
 			printk("SJCD: ioctl: readtocentry\n");
 #endif
 			if ((s =
-			     verify_area(VERIFY_WRITE, argp,
-					 sizeof(toc_entry))) == 0) {
+			     access_ok(VERIFY_WRITE, argp, sizeof(toc_entry))
+			     		? 0 : -EFAULT) == 0) {
 				struct sjcd_hw_disk_info *tp;
 
 				if (copy_from_user(&toc_entry, argp,
@@ -943,8 +943,8 @@ static int sjcd_ioctl(struct inode *ip, 
 			printk("SJCD: ioctl: subchnl\n");
 #endif
 			if ((s =
-			     verify_area(VERIFY_WRITE, argp,
-					 sizeof(subchnl))) == 0) {
+			     access_ok(VERIFY_WRITE, argp, sizeof(subchnl))
+			     		? 0 : -EFAULT) == 0) {
 				struct sjcd_hw_qinfo q_info;
 
 				if (copy_from_user(&subchnl, argp,
@@ -1002,8 +1002,8 @@ static int sjcd_ioctl(struct inode *ip, 
 			printk("SJCD: ioctl: volctrl\n");
 #endif
 			if ((s =
-			     verify_area(VERIFY_READ, argp,
-					 sizeof(vol_ctrl))) == 0) {
+			     access_ok(VERIFY_READ, argp, sizeof(vol_ctrl))
+			     		? 0 : -EFAULT) == 0) {
 				unsigned char dummy[4];
 
 				if (copy_from_user(&vol_ctrl, argp,
diff -urp linux-2.6.11-orig/drivers/char/generic_nvram.c linux-2.6.11/drivers/char/generic_nvram.c
--- linux-2.6.11-orig/drivers/char/generic_nvram.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.11/drivers/char/generic_nvram.c	2005-03-03 22:51:20.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/char/n_hdlc.c linux-2.6.11/drivers/char/n_hdlc.c
--- linux-2.6.11-orig/drivers/char/n_hdlc.c	2005-03-02 08:37:52.000000000 +0100
+++ linux-2.6.11/drivers/char/n_hdlc.c	2005-03-03 22:51:22.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/char/nwflash.c linux-2.6.11/drivers/char/nwflash.c
--- linux-2.6.11-orig/drivers/char/nwflash.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11/drivers/char/nwflash.c	2005-03-03 22:51:20.000000000 +0100
@@ -182,7 +182,7 @@ static ssize_t flash_write(struct file *
 	if (count > gbFlashSize - p)
 		count = gbFlashSize - p;
 			
-	if (verify_area(VERIFY_READ, buf, count))
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 
 	/*
diff -urp linux-2.6.11-orig/drivers/char/rio/rio_linux.c linux-2.6.11/drivers/char/rio/rio_linux.c
--- linux-2.6.11-orig/drivers/char/rio/rio_linux.c	2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6.11/drivers/char/rio/rio_linux.c	2005-03-03 22:51:20.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/char/selection.c linux-2.6.11/drivers/char/selection.c
--- linux-2.6.11-orig/drivers/char/selection.c	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.11/drivers/char/selection.c	2005-03-03 22:51:22.000000000 +0100
@@ -122,7 +122,7 @@ int set_selection(const struct tiocl_sel
 
 	{ unsigned short xs, ys, xe, ye;
 
-	  if (verify_area(VERIFY_READ, sel, sizeof(*sel)))
+	  if (!access_ok(VERIFY_READ, sel, sizeof(*sel)))
 		return -EFAULT;
 	  __get_user(xs, &sel->xs);
 	  __get_user(ys, &sel->ys);
diff -urp linux-2.6.11-orig/drivers/char/vt_ioctl.c linux-2.6.11/drivers/char/vt_ioctl.c
--- linux-2.6.11-orig/drivers/char/vt_ioctl.c	2005-03-02 08:38:38.000000000 +0100
+++ linux-2.6.11/drivers/char/vt_ioctl.c	2005-03-03 22:51:22.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/ieee1394/raw1394.c linux-2.6.11/drivers/ieee1394/raw1394.c
--- linux-2.6.11-orig/drivers/ieee1394/raw1394.c	2005-03-02 08:37:31.000000000 +0100
+++ linux-2.6.11/drivers/ieee1394/raw1394.c	2005-03-03 22:51:28.000000000 +0100
@@ -2338,7 +2338,7 @@ static int raw1394_iso_recv_packets(stru
 		return -EINVAL;
 
 	/* ensure user-supplied buffer is accessible and big enough */
-	if (verify_area(VERIFY_WRITE, upackets.infos,
+	if (!access_ok(VERIFY_WRITE, upackets.infos,
 		       upackets.n_packets * sizeof(struct raw1394_iso_packet_info)))
 		return -EFAULT;
 
@@ -2368,7 +2368,7 @@ static int raw1394_iso_send_packets(stru
 		return -EINVAL;
 
 	/* ensure user-supplied buffer is accessible and big enough */
-	if (verify_area(VERIFY_READ, upackets.infos,
+	if (!access_ok(VERIFY_READ, upackets.infos,
 		       upackets.n_packets * sizeof(struct raw1394_iso_packet_info)))
 		return -EFAULT;
 
diff -urp linux-2.6.11-orig/drivers/isdn/act2000/act2000_isa.c linux-2.6.11/drivers/isdn/act2000/act2000_isa.c
--- linux-2.6.11-orig/drivers/isdn/act2000/act2000_isa.c	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6.11/drivers/isdn/act2000/act2000_isa.c	2005-03-03 22:51:22.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/isdn/i4l/isdn_common.c linux-2.6.11/drivers/isdn/i4l/isdn_common.c
--- linux-2.6.11-orig/drivers/isdn/i4l/isdn_common.c	2005-03-02 08:37:58.000000000 +0100
+++ linux-2.6.11/drivers/isdn/i4l/isdn_common.c	2005-03-03 22:51:22.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/isdn/i4l/isdn_ppp.c linux-2.6.11/drivers/isdn/i4l/isdn_ppp.c
--- linux-2.6.11-orig/drivers/isdn/i4l/isdn_ppp.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11/drivers/isdn/i4l/isdn_ppp.c	2005-03-03 22:51:22.000000000 +0100
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
 
diff -urp linux-2.6.11-orig/drivers/isdn/icn/icn.c linux-2.6.11/drivers/isdn/icn/icn.c
--- linux-2.6.11-orig/drivers/isdn/icn/icn.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11/drivers/isdn/icn/icn.c	2005-03-03 22:51:22.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/isdn/isdnloop/isdnloop.c linux-2.6.11/drivers/isdn/isdnloop/isdnloop.c
--- linux-2.6.11-orig/drivers/isdn/isdnloop/isdnloop.c	2005-03-02 08:37:30.000000000 +0100
+++ linux-2.6.11/drivers/isdn/isdnloop/isdnloop.c	2005-03-03 22:51:22.000000000 +0100
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
diff -urp linux-2.6.11-orig/drivers/macintosh/adb.c linux-2.6.11/drivers/macintosh/adb.c
--- linux-2.6.11-orig/drivers/macintosh/adb.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11/drivers/macintosh/adb.c	2005-03-03 22:51:28.000000000 +0100
@@ -755,7 +755,7 @@ static int adb_release(struct inode *ino
 static ssize_t adb_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
-	int ret;
+	int ret = 0;
 	struct adbdev_state *state = file->private_data;
 	struct adb_request *req;
 	wait_queue_t wait = __WAITQUEUE_INITIALIZER(wait,current);
@@ -765,9 +765,8 @@ static ssize_t adb_read(struct file *fil
 		return -EINVAL;
 	if (count > sizeof(req->reply))
 		count = sizeof(req->reply);
-	ret = verify_area(VERIFY_WRITE, buf, count);
-	if (ret)
-		return ret;
+	if (!access_ok(VERIFY_WRITE, buf, count))
+		return -EFAULT;
 
 	req = NULL;
 	spin_lock_irqsave(&state->lock, flags);
@@ -824,9 +823,8 @@ static ssize_t adb_write(struct file *fi
 		return -EINVAL;
 	if (adb_controller == NULL)
 		return -ENXIO;
-	ret = verify_area(VERIFY_READ, buf, count);
-	if (ret)
-		return ret;
+	if (!access_ok(VERIFY_READ, buf, count))
+		return -EFAULT;
 
 	req = (struct adb_request *) kmalloc(sizeof(struct adb_request),
 					     GFP_KERNEL);
diff -urp linux-2.6.11-orig/drivers/macintosh/ans-lcd.c linux-2.6.11/drivers/macintosh/ans-lcd.c
--- linux-2.6.11-orig/drivers/macintosh/ans-lcd.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11/drivers/macintosh/ans-lcd.c	2005-03-03 22:51:28.000000000 +0100
@@ -61,7 +61,7 @@ anslcd_write( struct file * file, const 
 	printk(KERN_DEBUG "LCD: write\n");
 #endif
 
-	if ( verify_area(VERIFY_READ, buf, count) )
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 	for ( i = *ppos; count > 0; ++i, ++p, --count ) 
 	{
diff -urp linux-2.6.11-orig/drivers/macintosh/nvram.c linux-2.6.11/drivers/macintosh/nvram.c
--- linux-2.6.11-orig/drivers/macintosh/nvram.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6.11/drivers/macintosh/nvram.c	2005-03-03 22:51:28.000000000 +0100
@@ -45,7 +45,7 @@ static ssize_t read_nvram(struct file *f
 	unsigned int i;
 	char __user *p = buf;
 
-	if (verify_area(VERIFY_WRITE, buf, count))
+	if (!access_ok(VERIFY_WRITE, buf, count))
 		return -EFAULT;
 	if (*ppos >= NVRAM_SIZE)
 		return 0;
@@ -63,7 +63,7 @@ static ssize_t write_nvram(struct file *
 	const char __user *p = buf;
 	char c;
 
-	if (verify_area(VERIFY_READ, buf, count))
+	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
 	if (*ppos >= NVRAM_SIZE)
 		return 0;
diff -urp linux-2.6.11-orig/drivers/macintosh/via-pmu.c linux-2.6.11/drivers/macintosh/via-pmu.c
--- linux-2.6.11-orig/drivers/macintosh/via-pmu.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11/drivers/macintosh/via-pmu.c	2005-03-03 22:51:28.000000000 +0100
@@ -2770,13 +2770,12 @@ pmu_read(struct file *file, char __user 
 	struct pmu_private *pp = file->private_data;
 	DECLARE_WAITQUEUE(wait, current);
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	if (count < 1 || pp == 0)
 		return -EINVAL;
-	ret = verify_area(VERIFY_WRITE, buf, count);
-	if (ret)
-		return ret;
+	if (!access_ok(VERIFY_WRITE, buf, count);
+		return -EFAULT;
 
 	spin_lock_irqsave(&pp->lock, flags);
 	add_wait_queue(&pp->wait, &wait);
Only in linux-2.6.11/drivers/macintosh: via-pmu.c~
diff -urp linux-2.6.11-orig/drivers/media/video/c-qcam.c linux-2.6.11/drivers/media/video/c-qcam.c
--- linux-2.6.11-orig/drivers/media/video/c-qcam.c	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.11/drivers/media/video/c-qcam.c	2005-03-03 22:51:28.000000000 +0100
@@ -363,7 +363,7 @@ static long qc_capture(struct qcam_devic
 	size_t wantlen, outptr = 0;
 	char tmpbuf[BUFSZ];
 
-	if (verify_area(VERIFY_WRITE, buf, len))
+	if (!access_ok(VERIFY_WRITE, buf, len))
 		return -EFAULT;
 
 	/* Wait for camera to become ready */


