Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287472AbSAEDE4>; Fri, 4 Jan 2002 22:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287474AbSAEDEs>; Fri, 4 Jan 2002 22:04:48 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:7555 "EHLO ns1.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S287472AbSAEDEg>;
	Fri, 4 Jan 2002 22:04:36 -0500
Date: Fri, 4 Jan 2002 19:04:35 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: emoenke@gwdg.de, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Patch: linux-2.5.2-pre7/drivers/cdrom additional kdev_t fixes
Message-ID: <20020104190435.A25696@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Here are the remaining kdev_t fixes for
linux-2.5.2-pre7/drivers/cdrom.  Note that sbpcd.c still will not compile,
due to it apparently needing some bio changes that I haven't looked
into yet.  However, my changes are quite mechanical, so the spbcd.c
changes are a step toward making it compile.  The changes make the
other drivers compile (sonycd535.c and sjcd.c).

	I only know that these change eliminate compilation error.
There are otherwise completely untested.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cdrom.diffs"

--- linux-2.5.2-pre7/drivers/cdrom/sjcd.c	Thu Oct 25 13:58:35 2001
+++ linux/drivers/cdrom/sjcd.c	Fri Jan  4 18:05:38 2002
@@ -105,6 +105,7 @@
 static volatile unsigned char sjcd_completion_error = 0;
 static unsigned short sjcd_command_is_in_progress = 0;
 static unsigned short sjcd_error_reported = 0;
+static spinlock_t sjcd_lock = SPIN_LOCK_UNLOCKED;
 
 static int sjcd_open_count;
 
@@ -458,7 +459,7 @@
 #if 0
 	printk("SJCD: sjcd_disk_change( 0x%x )\n", full_dev);
 #endif
-	if (MINOR(full_dev) > 0) {
+	if (minor(full_dev) > 0) {
 		printk("SJCD: request error: invalid device minor.\n");
 		return 0;
 	}
@@ -1074,7 +1075,7 @@
  */
 
 #define CURRENT_IS_VALID                                      \
-    ( !QUEUE_EMPTY && MAJOR( CURRENT->rq_dev ) == MAJOR_NR && \
+    ( !QUEUE_EMPTY && major( CURRENT->rq_dev ) == MAJOR_NR && \
       CURRENT->cmd == READ && CURRENT->sector != -1 )
 
 static void sjcd_transfer(void)
@@ -1497,12 +1498,6 @@
 #endif
 	sjcd_transfer_is_active = 1;
 	while (CURRENT_IS_VALID) {
-		/*
-		 * Who of us are paranoiac?
-		 */
-		if (CURRENT->bh && !buffer_locked(CURRENT->bh))
-			panic(DEVICE_NAME ": block not locked");
-
 		sjcd_transfer();
 		if (CURRENT->nr_sectors == 0)
 			end_request(1);
@@ -1664,7 +1659,6 @@
 };
 
 static int blksize = 2048;
-static int secsize = 2048;
 
 /*
  * Following stuff is intended for initialization of the cdrom. It
@@ -1692,7 +1686,6 @@
 	printk("SJCD: sjcd=0x%x: ", sjcd_base);
 #endif
 
-	hardsect_size[MAJOR_NR] = &secsize;
 	blksize_size[MAJOR_NR] = &blksize;
 
 	if (devfs_register_blkdev(MAJOR_NR, "sjcd", &sjcd_fops) != 0) {
@@ -1701,9 +1694,9 @@
 		return (-EIO);
 	}
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST);
+	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), DEVICE_REQUEST,&sjcd_lock);
 	read_ahead[MAJOR_NR] = 4;
-	register_disk(NULL, MKDEV(MAJOR_NR, 0), 1, &sjcd_fops, 0);
+	register_disk(NULL, mk_kdev(MAJOR_NR, 0), 1, &sjcd_fops, 0);
 
 	if (check_region(sjcd_base, 4)) {
 		printk
--- linux-2.5.2-pre7/drivers/cdrom/sonycd535.c	Thu Jan  3 19:52:01 2002
+++ linux/drivers/cdrom/sonycd535.c	Fri Jan  4 18:05:38 2002
@@ -281,7 +281,7 @@
 {
 	int retval;
 
-	if (MINOR(full_dev) != 0) {
+	if (minor(full_dev) != 0) {
 		printk(CDU535_MESSAGE_NAME " request error: invalid device.\n");
 		return 0;
 	}
@@ -810,7 +810,7 @@
 			return;
 		}
 		INIT_REQUEST;
-		dev = MINOR(CURRENT->rq_dev);
+		dev = minor(CURRENT->rq_dev);
 		block = CURRENT->sector;
 		nsect = CURRENT->nr_sectors;
 		if (dev != 0) {
@@ -1089,7 +1089,7 @@
 	if (!inode) {
 		return -EINVAL;
 	}
-	dev = MINOR(inode->i_rdev) >> 6;
+	dev = minor(inode->i_rdev) >> 6;
 	if (dev != 0) {
 		return -EINVAL;
 	}
@@ -1644,7 +1644,7 @@
 		return -EIO;
 	}
 	request_region(sony535_cd_base_io, 4, CDU535_HANDLE);
-	register_disk(NULL, MKDEV(MAJOR_NR,0), 1, &cdu_fops, 0);
+	register_disk(NULL, mk_kdev(MAJOR_NR,0), 1, &cdu_fops, 0);
 	return 0;
 }
 
--- linux-2.5.2-pre7/drivers/cdrom/sbpcd.c	Sat Dec  8 20:02:47 2001
+++ linux/drivers/cdrom/sbpcd.c	Fri Jan  4 18:05:38 2002
@@ -2057,7 +2057,7 @@
 
 static int sbpcd_select_speed(struct cdrom_device_info *cdi, int speed)
 {
-  int i = MINOR(cdi->dev);
+  int i = minor(cdi->dev);
 
   if (i != d)
     switch_drive(i);
@@ -2095,7 +2095,7 @@
 
 static int sbpcd_reset(struct cdrom_device_info *cdi)
 {
-  int i = MINOR(cdi->dev);
+  int i = minor(cdi->dev);
 
   if (i != d)
     switch_drive(i);
@@ -2376,7 +2376,7 @@
 {
 	int i;
 	int retval=0;
-	i = MINOR(cdi->dev);
+	i = minor(cdi->dev);
 	switch_drive(i);
 	/* DUH! --AJK */
 	if(D_S[d].CD_changed != 0xFF) {
@@ -4061,13 +4061,13 @@
 	msg(DBG_000,"Drive Status: busy =%d.\n", st_busy);
 
 #if 0
-  if (!(D_S[MINOR(cdi->dev)].status_bits & p_door_closed)) return CDS_TRAY_OPEN;
-  if (D_S[MINOR(cdi->dev)].status_bits & p_disk_ok) return CDS_DISC_OK;
-  if (D_S[MINOR(cdi->dev)].status_bits & p_disk_in) return CDS_DRIVE_NOT_READY;
+  if (!(D_S[minor(cdi->dev)].status_bits & p_door_closed)) return CDS_TRAY_OPEN;
+  if (D_S[minor(cdi->dev)].status_bits & p_disk_ok) return CDS_DISC_OK;
+  if (D_S[minor(cdi->dev)].status_bits & p_disk_in) return CDS_DRIVE_NOT_READY;
 
   return CDS_NO_DISC;
 #else
-  if (D_S[MINOR(cdi->dev)].status_bits & p_spinning) return CDS_DISC_OK;
+  if (D_S[minor(cdi->dev)].status_bits & p_spinning) return CDS_DISC_OK;
 /*  return CDS_TRAY_OPEN; */
   return CDS_NO_DISC;
   
@@ -4203,8 +4203,8 @@
 static int sbpcd_get_last_session(struct cdrom_device_info *cdi, struct cdrom_multisession *ms_infp)
 {
 	ms_infp->addr_format = CDROM_LBA;
-	ms_infp->addr.lba    = D_S[MINOR(cdi->dev)].lba_multi;
-	if (D_S[MINOR(cdi->dev)].f_multisession)
+	ms_infp->addr.lba    = D_S[minor(cdi->dev)].lba_multi;
+	if (D_S[minor(cdi->dev)].f_multisession)
 		ms_infp->xa_flag=1; /* valid redirection address */
 	else
 		ms_infp->xa_flag=0; /* invalid redirection address */
@@ -4223,8 +4223,8 @@
 	int i;
 	
 	msg(DBG_IO2,"ioctl(%d, 0x%08lX, 0x%08lX)\n",
-	    MINOR(cdi->dev), cmd, arg);
-	i=MINOR(cdi->dev);
+	    minor(cdi->dev), cmd, arg);
+	i=minor(cdi->dev);
 	if ((i<0) || (i>=NR_SBPCD) || (D_S[i].drv_id==-1))
 	{
 		msg(DBG_INF, "ioctl: bad device: %04X\n", cdi->dev);
@@ -4533,9 +4533,9 @@
 		
 	case BLKRASET:
 		if(!capable(CAP_SYS_ADMIN)) RETURN_UP(-EACCES);
-		if(!(cdi->dev)) RETURN_UP(-EINVAL);
+		if(kdev_none(cdi->dev)) RETURN_UP(-EINVAL);
 		if(arg > 0xff) RETURN_UP(-EINVAL);
-		read_ahead[MAJOR(cdi->dev)] = arg;
+		read_ahead[major(cdi->dev)] = arg;
 		RETURN_UP(0);
 	default:
 		msg(DBG_IOC,"ioctl: unknown function request %04X\n", cmd);
@@ -4549,8 +4549,8 @@
 	int i, st, j;
 	
 	msg(DBG_IO2,"ioctl(%d, 0x%08lX, 0x%08p)\n",
-	    MINOR(cdi->dev), cmd, arg);
-	i=MINOR(cdi->dev);
+	    minor(cdi->dev), cmd, arg);
+	i=minor(cdi->dev);
 	if ((i<0) || (i>=NR_SBPCD) || (D_S[i].drv_id==-1))
 	{
 		msg(DBG_INF, "ioctl: bad device: %04X\n", cdi->dev);
@@ -4930,7 +4930,7 @@
 		sbpcd_end_request(req, 0);
 	if (req -> sector == -1)
 		sbpcd_end_request(req, 0);
-	spin_unlock_irq(&q->queue_lock);
+	spin_unlock_irq(q->queue_lock);
 
 	down(&ioctl_read_sem);
 	if (req->cmd != READ)
@@ -4938,7 +4938,7 @@
 		msg(DBG_INF, "bad cmd %d\n", req->cmd);
 		goto err_done;
 	}
-	i = MINOR(req->rq_dev);
+	i = minor(req->rq_dev);
 	if ( (i<0) || (i>=NR_SBPCD) || (D_S[i].drv_id==-1))
 	{
 		msg(DBG_INF, "do_request: bad device: %s\n",
@@ -4970,7 +4970,7 @@
 			xnr, req, req->sector, req->nr_sectors, jiffies);
 #endif
 		up(&ioctl_read_sem);
-		spin_lock_irq(&q->queue_lock);
+		spin_lock_irq(q->queue_lock);
 		sbpcd_end_request(req, 1);
 		goto request_loop;
 	}
@@ -5011,7 +5011,7 @@
 				xnr, req, req->sector, req->nr_sectors, jiffies);
 #endif
 			up(&ioctl_read_sem);
-			spin_lock_irq(&q->queue_lock);
+			spin_lock_irq(q->queue_lock);
 			sbpcd_end_request(req, 1);
 			goto request_loop;
 		}
@@ -5027,7 +5027,7 @@
 #endif
 	up(&ioctl_read_sem);
 	sbp_sleep(0);    /* wait a bit, try again */
-	spin_lock_irq(&q->queue_lock);
+	spin_lock_irq(q->queue_lock);
 	sbpcd_end_request(req, 0);
 	goto request_loop;
 }
@@ -5435,7 +5435,7 @@
 {
 	int i;
 
-	i = MINOR(cdi->dev);
+	i = minor(cdi->dev);
 
 	down(&ioctl_read_sem);
 	switch_drive(i);
@@ -5474,7 +5474,7 @@
 {
 	int i;
 	
-	i = MINOR(cdi->dev);
+	i = minor(cdi->dev);
 	if ((i<0) || (i>=NR_SBPCD) || (D_S[i].drv_id==-1))
 	{
 		msg(DBG_INF, "release: bad device: %04X\n", cdi->dev);
@@ -6003,8 +6003,8 @@
 {
 	int i;
 	
-	msg(DBG_CHK,"media_check (%d) called\n", MINOR(full_dev));
-	i=MINOR(full_dev);
+	i=minor(full_dev);
+	msg(DBG_CHK,"media_check (%d) called\n", i);
 	
 	if (D_S[i].CD_changed==0xFF)
         {

--3V7upXqbjpZ4EhLz--
