Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290123AbSAKVew>; Fri, 11 Jan 2002 16:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290125AbSAKVeo>; Fri, 11 Jan 2002 16:34:44 -0500
Received: from mx.fluke.com ([129.196.128.53]:2824 "EHLO evtvir03.tc.fluke.com")
	by vger.kernel.org with ESMTP id <S290123AbSAKVej>;
	Fri, 11 Jan 2002 16:34:39 -0500
Date: Fri, 11 Jan 2002 13:34:50 -0800 (PST)
From: David Dyck <dcd@tc.fluke.com>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: <emoenke@gwdg.de>, <linux-kernel@vger.kernel.org>,
        <torvalds@transmeta.com>
Subject: Re: Patch: linux-2.5.2-pre7/drivers/cdrom additional kdev_t fixes
In-Reply-To: <20020104190435.A25696@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.33.0201111331070.1127-200000@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=3V7upXqbjpZ4EhLz
Content-ID: <Pine.LNX.4.33.0201111331071.1127@dd.tc.fluke.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--3V7upXqbjpZ4EhLz
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0201111331072.1127@dd.tc.fluke.com>
Content-Disposition: INLINE



I had been testing 2.5.2-pre11 and earlier, but hadn't looked at
reading from my cdrom for a while.  Yesterday I created examined several
large cdrom sets that had been readable earlier and they read partially
but get read errors.  These same cdroms can be read reliable on
2.4.18-pre3 using the same hardware, and are readable on other
PC's runing older kernels.

Has anyone else seen cdrom read errors with 2.5.2-pre* kernels?

 David

On Fri, 4 Jan 2002 at 19:04 -0800, Adam J. Richter <adam@yggdrasil.com> wrote:

> From: Adam J. Richter <adam@yggdrasil.com>
> To: emoenke@gwdg.de, linux-kernel@vger.kernel.org
> Cc: torvalds@transmeta.com
> Date: Fri, 4 Jan 2002 19:04:35 -0800
> Subject: Patch: linux-2.5.2-pre7/drivers/cdrom additional kdev_t fixes
>
> 	Here are the remaining kdev_t fixes for
> linux-2.5.2-pre7/drivers/cdrom.  Note that sbpcd.c still will not compile,
> due to it apparently needing some bio changes that I haven't looked
> into yet.  However, my changes are quite mechanical, so the spbcd.c
> changes are a step toward making it compile.  The changes make the
> other drivers compile (sonycd535.c and sjcd.c).
>
> 	I only know that these change eliminate compilation error.
> There are otherwise completely untested.
>
> --
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
>

--3V7upXqbjpZ4EhLz
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-ID: <Pine.LNX.4.33.0201111331073.1127@dd.tc.fluke.com>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="cdrom.diffs"

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
