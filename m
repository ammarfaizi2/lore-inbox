Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282126AbRK1XMi>; Wed, 28 Nov 2001 18:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282167AbRK1XMY>; Wed, 28 Nov 2001 18:12:24 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:52434 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S282126AbRK1XL5>; Wed, 28 Nov 2001 18:11:57 -0500
Date: Wed, 28 Nov 2001 15:05:36 -0800
From: "David C. Hansen" <haveblue@us.ibm.com>
Message-Id: <200111282305.fASN5ap02626@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] remove BKL from drivers' release functions
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This version fixes a non-release of a spinlock before a return on error in rd.c.

The following is a patch which removes the BKL from quite a few 
drivers' release functions.  The release functions are already 
serialized in the VFS code by an atomic_t which guarantees that each 
function will be called only once, after all file descriptors have been 
closed.  In addition, in these drivers, the BKL was _only_ held in the 
release function and nowhere else in the driver where it might be needed.

Many of these patches simply remove the BKL from the file.  This causes 
no harm because the BKL was not really protecting anything, anyway.  
Other patches try to actually fix the locking.  Some do this by making 
use of atomic operations with the atomic_* functions, or the 
(test|set)_bit functions.  Most of these patches replace uses of normal 
integers which were used to keep open counts in the drivers.  In other 
some cases, a spinlock was added when the atomic operations could not 
guarantee proper serialization by themselves.  And, in very few cases, 
the existing locking was extended to protect more things.  These cases 
are very uncommon because locking is very uncommon in most of these drivers.

Special care has been taken not to introduce more locking issues into 
the drivers (do no harm).

The patch applies cleanly against 2.5.1-pre2. 

diff -ur linux-2.5.1-pre2-clean/arch/i386/kernel/apm.c linux/arch/i386/kernel/apm.c
--- linux-2.5.1-pre2-clean/arch/i386/kernel/apm.c	Fri Nov  9 13:58:02 2001
+++ linux/arch/i386/kernel/apm.c	Wed Nov 28 11:08:06 2001
@@ -387,6 +387,7 @@
 static DECLARE_WAIT_QUEUE_HEAD(apm_waitqueue);
 static DECLARE_WAIT_QUEUE_HEAD(apm_suspend_waitqueue);
 static struct apm_user *	user_list;
+static spinlock_t		user_list_lock;
 
 static char			driver_version[] = "1.15";	/* no spaces */
 
@@ -1053,6 +1054,7 @@
 {
 	struct apm_user *	as;
 
+	spin_lock( &user_list_lock );
 	if (user_list == NULL)
 		return;
 	for (as = user_list; as != NULL; as = as->next) {
@@ -1083,6 +1085,7 @@
 			break;
 		}
 	}
+	spin_unlock( &user_list_lock );
 	wake_up_interruptible(&apm_waitqueue);
 }
 
@@ -1179,10 +1182,12 @@
 	send_event(APM_NORMAL_RESUME);
 	sti();
 	queue_event(APM_NORMAL_RESUME, NULL);
+	spin_lock( &user_list_lock );
 	for (as = user_list; as != NULL; as = as->next) {
 		as->suspend_wait = 0;
 		as->suspend_result = ((err == APM_SUCCESS) ? 0 : -EIO);
 	}
+	spin_unlock( &user_list_lock );
 	ignore_normal_resume = 1;
 	wake_up_interruptible(&apm_suspend_waitqueue);
 	return err;
@@ -1519,7 +1524,6 @@
 	if (check_apm_user(as, "release"))
 		return 0;
 	filp->private_data = NULL;
-	lock_kernel();
 	if (as->standbys_pending > 0) {
 		standbys_pending -= as->standbys_pending;
 		if (standbys_pending <= 0)
@@ -1530,6 +1534,7 @@
 		if (suspends_pending <= 0)
 			(void) suspend();
 	}
+  	spin_lock( &user_list_lock );
 	if (user_list == as)
 		user_list = as->next;
 	else {
@@ -1544,7 +1549,7 @@
 		else
 			as1->next = as->next;
 	}
-	unlock_kernel();
+	spin_unlock( &user_list_lock );
 	kfree(as);
 	return 0;
 }
@@ -1573,8 +1578,10 @@
 	as->suser = capable(CAP_SYS_ADMIN);
 	as->writer = (filp->f_mode & FMODE_WRITE) == FMODE_WRITE;
 	as->reader = (filp->f_mode & FMODE_READ) == FMODE_READ;
+	spin_lock( &user_list_lock );
 	as->next = user_list;
 	user_list = as;
+	spin_unlock( &user_list_lock );
 	filp->private_data = as;
 	return 0;
 }
diff -ur linux-2.5.1-pre2-clean/arch/i386/kernel/mtrr.c linux/arch/i386/kernel/mtrr.c
--- linux-2.5.1-pre2-clean/arch/i386/kernel/mtrr.c	Fri Nov  9 13:58:02 2001
+++ linux/arch/i386/kernel/mtrr.c	Wed Nov 28 11:08:06 2001
@@ -1788,7 +1788,6 @@
     unsigned int *fcount = file->private_data;
 
     if (fcount == NULL) return 0;
-    lock_kernel();
     max = get_num_var_ranges ();
     for (i = 0; i < max; ++i)
     {
@@ -1798,7 +1797,6 @@
 	    --fcount[i];
 	}
     }
-    unlock_kernel();
     kfree (fcount);
     file->private_data = NULL;
     return 0;
diff -ur linux-2.5.1-pre2-clean/arch/m68k/atari/joystick.c linux/arch/m68k/atari/joystick.c
--- linux-2.5.1-pre2-clean/arch/m68k/atari/joystick.c	Wed Jul 12 21:58:42 2000
+++ linux/arch/m68k/atari/joystick.c	Wed Nov 28 11:08:06 2001
@@ -61,13 +61,11 @@
 {
     int minor = DEVICE_NR(inode->i_rdev);
 
-    lock_kernel();
     joystick[minor].active = 0;
     joystick[minor].ready = 0;
 
     if ((joystick[0].active == 0) && (joystick[1].active == 0))
 	ikbd_joystick_disable();
-    unlock_kernel();
     return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/arch/m68k/mvme16x/rtc.c linux/arch/m68k/mvme16x/rtc.c
--- linux-2.5.1-pre2-clean/arch/m68k/mvme16x/rtc.c	Mon Jun 11 19:15:27 2001
+++ linux/arch/m68k/mvme16x/rtc.c	Wed Nov 28 11:08:06 2001
@@ -36,7 +36,7 @@
 static unsigned char days_in_mo[] =
 {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
 
-static char rtc_status = 0;
+static atomic_t rtc_ready = ATOMIC_INIT(1);
 
 static int rtc_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
 		     unsigned long arg)
@@ -130,18 +130,18 @@
 
 static int rtc_open(struct inode *inode, struct file *file)
 {
-	if(rtc_status)
+	if( !atomic_dec_and_test(&rtc_ready) )
+	{
+		atomic_inc( &rtc_ready );
 		return -EBUSY;
+	}
 
-	rtc_status = 1;
 	return 0;
 }
 
 static int rtc_release(struct inode *inode, struct file *file)
 {
-	lock_kernel();
-	rtc_status = 0;
-	unlock_kernel();
+	atomic_inc( &rtc_ready );
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/arch/mips64/sgi-ip27/ip27-rtc.c linux/arch/mips64/sgi-ip27/ip27-rtc.c
--- linux-2.5.1-pre2-clean/arch/mips64/sgi-ip27/ip27-rtc.c	Tue Nov 28 21:42:04 2000
+++ linux/arch/mips64/sgi-ip27/ip27-rtc.c	Wed Nov 28 11:08:06 2001
@@ -53,14 +53,7 @@
 
 static void get_rtc_time(struct rtc_time *rtc_tm);
 
-/*
- *	Bits in rtc_status. (6 bits of room for future expansion)
- */
-
-#define RTC_IS_OPEN		0x01	/* means /dev/rtc is in use	*/
-#define RTC_TIMER_ON		0x02	/* missed irq timer active	*/
-
-static unsigned char rtc_status;	/* bitmapped status byte.	*/
+static atomic_t rtc_ready = ATOMIC_INIT(1);
 static unsigned long rtc_freq;	/* Current periodic IRQ rate	*/
 static struct m48t35_rtc *rtc;
 
@@ -166,23 +159,17 @@
 
 static int rtc_open(struct inode *inode, struct file *file)
 {
-	if(rtc_status & RTC_IS_OPEN)
+	if( atomic_dec_and_test( &rtc_ready ) ) 
+	{
+		atomic_inc( &rtc_ready );
 		return -EBUSY;
-
-	rtc_status |= RTC_IS_OPEN;
+	}
 	return 0;
 }
 
 static int rtc_release(struct inode *inode, struct file *file)
 {
-	/*
-	 * Turn off all interrupts once the device is no longer
-	 * in use, and clear the data.
-	 */
-
-	lock_kernel();
-	rtc_status &= ~RTC_IS_OPEN;
-	unlock_kernel();
+	atomic_inc( &rtc_ready );
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/arch/sparc64/solaris/socksys.c linux/arch/sparc64/solaris/socksys.c
--- linux-2.5.1-pre2-clean/arch/sparc64/solaris/socksys.c	Sun Feb 18 19:49:54 2001
+++ linux/arch/sparc64/solaris/socksys.c	Wed Nov 28 11:08:06 2001
@@ -118,7 +118,6 @@
         struct T_primsg *it;
 
 	/* XXX: check this */
-	lock_kernel();
 	sock = (struct sol_socket_struct *)filp->private_data;
 	SOLDD(("sock release %016lx(%016lx)\n", sock, filp));
 	it = sock->pfirst;
@@ -132,7 +131,6 @@
 	filp->private_data = NULL;
 	SOLDD(("socksys_release %016lx\n", sock));
 	mykfree((char*)sock);
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/block/acsi_slm.c linux/drivers/block/acsi_slm.c
--- linux-2.5.1-pre2-clean/drivers/block/acsi_slm.c	Tue May 22 10:23:16 2001
+++ linux/drivers/block/acsi_slm.c	Wed Nov 28 11:08:07 2001
@@ -121,8 +121,8 @@
 static struct slm {
 	unsigned	target;			/* target number */
 	unsigned	lun;			/* LUN in target controller */
-	unsigned	wbusy : 1;		/* output part busy */
-	unsigned	rbusy : 1;		/* status part busy */
+	atomic_t	wr_ok; 			/* set to 0 if output part busy */
+	atomic_t	rd_ok;			/* set to 0 if status part busy */
 } slm_info[MAX_SLM];
 
 int N_SLM_Printers = 0;
@@ -778,15 +778,17 @@
 
 	if (file->f_mode & 2) {
 		/* open for writing is exclusive */
-		if (sip->wbusy)
+		if ( !atomic_dec_and_test(&sip->wr_ok) ) {
+			atomic_inc(&sip->wr_ok);	
 			return( -EBUSY );
-		sip->wbusy = 1;
+		}
 	}
 	if (file->f_mode & 1) {
-		/* open for writing is exclusive */
-		if (sip->rbusy)
-			return( -EBUSY );
-		sip->rbusy = 1;
+		/* open for reading is exclusive */
+                if ( !atomic_dec_and_test(&sip->rd_ok) ) {
+                        atomic_inc(&sip->rd_ok);
+                        return( -EBUSY );
+                }
 	}
 
 	return( 0 );
@@ -801,12 +803,10 @@
 	device = MINOR(inode->i_rdev);
 	sip = &slm_info[device];
 
-	lock_kernel();
 	if (file->f_mode & 2)
-		sip->wbusy = 0;
+		atomic_inc( &sip->wr_ok );
 	if (file->f_mode & 1)
-		sip->rbusy = 0;
-	unlock_kernel();
+		atomic_inc( &sip->rd_ok );
 	
 	return( 0 );
 }
@@ -983,8 +983,8 @@
 
 	slm_info[N_SLM_Printers].target = target;
 	slm_info[N_SLM_Printers].lun    = lun;
-	slm_info[N_SLM_Printers].wbusy  = 0;
-	slm_info[N_SLM_Printers].rbusy  = 0;
+	atomic_set(&slm_info[N_SLM_Printers].wr_ok, 1 ); 
+	atomic_set(&slm_info[N_SLM_Printers].rd_ok, 1 );
 	
 	printk( KERN_INFO "  Printer: %s\n", SLMBuffer );
 	printk( KERN_INFO "Detected slm%d at id %d lun %d\n",
diff -ur linux-2.5.1-pre2-clean/drivers/block/paride/pg.c linux/drivers/block/paride/pg.c
--- linux-2.5.1-pre2-clean/drivers/block/paride/pg.c	Thu Oct 11 09:04:57 2001
+++ linux/drivers/block/paride/pg.c	Wed Nov 28 11:08:07 2001
@@ -276,7 +276,7 @@
 	pg_drive_count = 0;
 	for (unit=0;unit<PG_UNITS;unit++) {
 		PG.pi = & PG.pia;
-		PG.access = 0;
+		set_bit( 0, &PG.access );
 		PG.busy = 0;
 		PG.present = 0;
 		PG.bufptr = NULL;
@@ -573,10 +573,7 @@
 
 	if ((unit >= PG_UNITS) || (!PG.present)) return -ENODEV;
 
-	PG.access++;
-
-	if (PG.access > 1) {
-		PG.access--;
+	if ( test_and_set_bit(0, &PG.access) ) {
 		return -EBUSY;
 	}
 
@@ -590,7 +587,7 @@
 
 	PG.bufptr = kmalloc(PG_MAX_DATA,GFP_KERNEL);
 	if (PG.bufptr == NULL) {
-		PG.access--;
+		clear_bit( 0, &PG.access ) ;
 		printk("%s: buffer allocation failed\n",PG.name);
 		return -ENOMEM;
 	}
@@ -602,15 +599,13 @@
 {
 	int	unit = DEVICE_NR(inode->i_rdev);
 
-	if ((unit >= PG_UNITS) || (PG.access <= 0)) 
+	if ( unit >= PG_UNITS || !test_bit(0,&PG.access) )
 		return -EINVAL;
 
-	lock_kernel();
-	PG.access--;
+	clear_bit( 0, &PG.access);
 
 	kfree(PG.bufptr);
 	PG.bufptr = NULL;
-	unlock_kernel();
 
 	return 0;
 
diff -ur linux-2.5.1-pre2-clean/drivers/block/paride/pt.c linux/drivers/block/paride/pt.c
--- linux-2.5.1-pre2-clean/drivers/block/paride/pt.c	Thu Oct 11 09:04:57 2001
+++ linux/drivers/block/paride/pt.c	Wed Nov 28 11:08:07 2001
@@ -244,7 +244,7 @@
 	int flags;        	  /* various state flags */
 	int last_sense;		  /* result of last request sense */
 	int drive;		  /* drive */
-	int access;               /* count of active opens ... */
+	atomic_t available;       /* 1 if access is available 0 otherwise */
 	int bs;			  /* block size */
 	int capacity;             /* Size of tape in KB */
 	int present;		  /* device present ? */
@@ -279,7 +279,7 @@
         pt_drive_count = 0;
         for (unit=0;unit<PT_UNITS;unit++) {
                 PT.pi = & PT.pia;
-                PT.access = 0;
+                atomic_set( &PT.available, 1 );
                 PT.flags = 0;
 		PT.last_sense = 0;
                 PT.present = 0;
@@ -696,22 +696,20 @@
 
         if ((unit >= PT_UNITS) || (!PT.present)) return -ENODEV;
 
-        PT.access++;
-
-	if (PT.access > 1) {
-		PT.access--;
+	if ( !atomic_dec_and_test(&PT.available) ) {
+		atomic_inc( &PT.available );
 		return -EBUSY;
 	}
 
 	pt_identify(unit);
 
 	if (!PT.flags & PT_MEDIA) {
-		PT.access--;
+		atomic_inc( &PT.available );
 		return -ENODEV;
 		}
 
 	if ((!PT.flags & PT_WRITE_OK) && (file ->f_mode & 2)) {
-		PT.access--;
+		atomic_inc( &PT.available );
 		return -EROFS;
 		}
 
@@ -720,7 +718,7 @@
 
 	PT.bufptr = kmalloc(PT_BUFSIZE,GFP_KERNEL);
 	if (PT.bufptr == NULL) {
-		PT.access--;
+		atomic_inc( &PT.available );
 		printk("%s: buffer allocation failed\n",PT.name);
 		return -ENOMEM;
 	}
@@ -775,20 +773,18 @@
 {
         int	unit = DEVICE_NR(inode->i_rdev);
 
-        if ((unit >= PT_UNITS) || (PT.access <= 0)) 
+        if ((unit >= PT_UNITS) || (atomic_read(&PT.available) > 1)) 
                 return -EINVAL;
 
-	lock_kernel();
 	if (PT.flags & PT_WRITING) pt_write_fm(unit);
 
 	if (PT.flags & PT_REWIND) pt_rewind(unit);	
 
-	PT.access--;
-
 	kfree(PT.bufptr);
 	PT.bufptr = NULL;
-	unlock_kernel();
 
+	atomic_inc( &PT.available );
+	
 	return 0;
 
 }
diff -ur linux-2.5.1-pre2-clean/drivers/block/rd.c linux/drivers/block/rd.c
--- linux-2.5.1-pre2-clean/drivers/block/rd.c	Wed Nov 28 11:07:19 2001
+++ linux/drivers/block/rd.c	Wed Nov 28 11:08:07 2001
@@ -89,6 +89,7 @@
 
 #ifdef CONFIG_BLK_DEV_INITRD
 static int initrd_users;
+static spinlock_t initrd_users_lock = SPIN_LOCK_UNLOCKED;
 #endif
 #endif
 
@@ -408,12 +409,15 @@
 {
 	extern void free_initrd_mem(unsigned long, unsigned long);
 
-	lock_kernel();
+	spin_lock( &initrd_users_lock );
 	if (!--initrd_users) {
+		spin_unlock( &initrd_users_lock );
 		free_initrd_mem(initrd_start, initrd_end);
 		initrd_start = 0;
+	} else {
+		spin_unlock( &initrd_users_lock );
 	}
-	unlock_kernel();
+		
 	blkdev_put(inode->i_bdev, BDEV_FILE);
 	return 0;
 }
@@ -433,8 +437,10 @@
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (unit == INITRD_MINOR) {
-		if (!initrd_start) return -ENODEV;
+		spin_lock( &initrd_users_lock );
 		initrd_users++;
+		if (!initrd_start) return -ENODEV;
+		spin_unlock( &initrd_users_lock );
 		filp->f_op = &initrd_fops;
 		return 0;
 	}
diff -ur linux-2.5.1-pre2-clean/drivers/char/acquirewdt.c linux/drivers/char/acquirewdt.c
--- linux-2.5.1-pre2-clean/drivers/char/acquirewdt.c	Thu Sep 13 15:21:32 2001
+++ linux/drivers/char/acquirewdt.c	Wed Nov 28 11:08:07 2001
@@ -141,7 +141,6 @@
 
 static int acq_close(struct inode *inode, struct file *file)
 {
-	lock_kernel();
 	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
 	{
 		spin_lock(&acq_lock);
@@ -151,7 +150,6 @@
 		acq_is_open=0;
 		spin_unlock(&acq_lock);
 	}
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/advantechwdt.c linux/drivers/char/advantechwdt.c
--- linux-2.5.1-pre2-clean/drivers/char/advantechwdt.c	Thu Sep 13 15:21:32 2001
+++ linux/drivers/char/advantechwdt.c	Wed Nov 28 11:08:07 2001
@@ -151,7 +151,6 @@
 static int
 advwdt_close(struct inode *inode, struct file *file)
 {
-	lock_kernel();
 	if (MINOR(inode->i_rdev) == WATCHDOG_MINOR) {
 		spin_lock(&advwdt_lock);
 #ifndef CONFIG_WATCHDOG_NOWAYOUT	
@@ -160,7 +159,6 @@
 		advwdt_is_open = 0;
 		spin_unlock(&advwdt_lock);
 	}
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/agp/agpgart_fe.c linux/drivers/char/agp/agpgart_fe.c
--- linux-2.5.1-pre2-clean/drivers/char/agp/agpgart_fe.c	Sun Aug 12 10:38:48 2001
+++ linux/drivers/char/agp/agpgart_fe.c	Wed Nov 28 11:08:07 2001
@@ -606,17 +606,14 @@
 	agp_file_private *priv = (agp_file_private *) file->private_data;
 	agp_kern_info kerninfo;
 
-	lock_kernel();
 	AGP_LOCK();
 
 	if (agp_fe.backend_acquired != TRUE) {
 		AGP_UNLOCK();
-		unlock_kernel();
 		return -EPERM;
 	}
 	if (!(test_bit(AGP_FF_IS_VALID, &priv->access_flags))) {
 		AGP_UNLOCK();
-		unlock_kernel();
 		return -EPERM;
 	}
 	agp_copy_info(&kerninfo);
@@ -628,51 +625,42 @@
 	if (test_bit(AGP_FF_IS_CLIENT, &priv->access_flags)) {
 		if ((size + offset) > current_size) {
 			AGP_UNLOCK();
-			unlock_kernel();
 			return -EINVAL;
 		}
 		client = agp_find_client_by_pid(current->pid);
 
 		if (client == NULL) {
 			AGP_UNLOCK();
-			unlock_kernel();
 			return -EPERM;
 		}
 		if (!agp_find_seg_in_client(client, offset,
 					    size, vma->vm_page_prot)) {
 			AGP_UNLOCK();
-			unlock_kernel();
 			return -EINVAL;
 		}
 		if (remap_page_range(vma->vm_start,
 				     (kerninfo.aper_base + offset),
 				     size, vma->vm_page_prot)) {
 			AGP_UNLOCK();
-			unlock_kernel();
 			return -EAGAIN;
 		}
 		AGP_UNLOCK();
-		unlock_kernel();
 		return 0;
 	}
 	if (test_bit(AGP_FF_IS_CONTROLLER, &priv->access_flags)) {
 		if (size != current_size) {
 			AGP_UNLOCK();
-			unlock_kernel();
 			return -EINVAL;
 		}
 		if (remap_page_range(vma->vm_start, kerninfo.aper_base,
 				     size, vma->vm_page_prot)) {
 			AGP_UNLOCK();
-			unlock_kernel();
 			return -EAGAIN;
 		}
 		AGP_UNLOCK();
-		unlock_kernel();
 		return 0;
 	}
 	AGP_UNLOCK();
-	unlock_kernel();
 	return -EPERM;
 }
 
@@ -680,7 +668,6 @@
 {
 	agp_file_private *priv = (agp_file_private *) file->private_data;
 
-	lock_kernel();
 	AGP_LOCK();
 
 	if (test_bit(AGP_FF_IS_CONTROLLER, &priv->access_flags)) {
@@ -702,7 +689,6 @@
 	agp_remove_file_private(priv);
 	kfree(priv);
 	AGP_UNLOCK();
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/busmouse.c linux/drivers/char/busmouse.c
--- linux-2.5.1-pre2-clean/drivers/char/busmouse.c	Fri Sep  7 09:28:38 2001
+++ linux/drivers/char/busmouse.c	Wed Nov 28 11:08:07 2001
@@ -171,6 +171,7 @@
 	lock_kernel();
 	busmouse_fasync(-1, file, 0);
 
+	down(&mouse_sem); /* to protect mse->active */
 	if (--mse->active == 0) {
 		if (mse->ops->release)
 			ret = mse->ops->release(inode, file);
@@ -179,7 +180,8 @@
 		mse->ready = 0;
 	}
 	unlock_kernel();
-
+	up( &mouse_sem);
+	
 	return ret;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/dtlk.c linux/drivers/char/dtlk.c
--- linux-2.5.1-pre2-clean/drivers/char/dtlk.c	Thu Sep 13 15:21:32 2001
+++ linux/drivers/char/dtlk.c	Wed Nov 28 11:08:07 2001
@@ -328,10 +328,8 @@
 		break;
 	}
 	TRACE_RET;
-
-	lock_kernel();
+	
 	del_timer(&dtlk_timer);
-	unlock_kernel();
 
 	return 0;
 }
diff -ur linux-2.5.1-pre2-clean/drivers/char/ftape/zftape/zftape-init.c linux/drivers/char/ftape/zftape/zftape-init.c
--- linux-2.5.1-pre2-clean/drivers/char/ftape/zftape/zftape-init.c	Thu Sep 13 15:21:32 2001
+++ linux/drivers/char/ftape/zftape/zftape-init.c	Wed Nov 28 11:08:07 2001
@@ -68,7 +68,8 @@
 
 /*      Local vars.
  */
-static int busy_flag = 0;
+static int busy_flag;
+
 static sigset_t orig_sigmask;
 
 /*  the interface to the kernel vfs layer
@@ -113,14 +114,13 @@
 	TRACE_FUN(ft_t_flow);
 
 	TRACE(ft_t_flow, "called for minor %d", MINOR(ino->i_rdev));
-	if (busy_flag) {
+	if ( test_and_set_bit(0,&busy_flag) )) {
 		TRACE_ABORT(-EBUSY, ft_t_warn, "failed: already busy");
 	}
-	busy_flag = 1;
 	if ((MINOR(ino->i_rdev) & ~(ZFT_MINOR_OP_MASK | FTAPE_NO_REWIND))
 	     > 
 	    FTAPE_SEL_D) {
-		busy_flag = 0;
+		clear_bit(0,&busy_flag);
 		TRACE_ABORT(-ENXIO, ft_t_err, "failed: illegal unit nr");
 	}
 	orig_sigmask = current->blocked;
@@ -128,7 +128,7 @@
 	result = _zft_open(MINOR(ino->i_rdev), filep->f_flags & O_ACCMODE);
 	if (result < 0) {
 		current->blocked = orig_sigmask; /* restore mask */
-		busy_flag = 0;
+		clear_bit(0,&busy_flag);
 		TRACE_ABORT(result, ft_t_err, "_ftape_open failed");
 	} else {
 		/* Mask signals that will disturb proper operation of the
@@ -147,10 +147,8 @@
 	int result;
 	TRACE_FUN(ft_t_flow);
 
-	lock_kernel();
-	if (!busy_flag || MINOR(ino->i_rdev) != zft_unit) {
+	if ( !test_bit(0,&busy_flag) || MINOR(ino->i_rdev) != zft_unit) {
 		TRACE(ft_t_err, "failed: not busy or wrong unit");
-		unlock_kernel();
 		TRACE_EXIT 0;
 	}
 	sigfillset(&current->blocked);
@@ -159,8 +157,7 @@
 		TRACE(ft_t_err, "_zft_close failed");
 	}
 	current->blocked = orig_sigmask; /* restore before open state */
-	busy_flag = 0;
-	unlock_kernel();
+	clear_bit(0,&busy_flag);
 	TRACE_EXIT 0;
 }
 
@@ -173,7 +170,7 @@
 	sigset_t old_sigmask;
 	TRACE_FUN(ft_t_flow);
 
-	if (!busy_flag || MINOR(ino->i_rdev) != zft_unit || ft_failure) {
+	if ( !test_bit(0,&busy_flag) || MINOR(ino->i_rdev) != zft_unit || ft_failure) {
 		TRACE_ABORT(-EIO, ft_t_err,
 			    "failed: not busy, failure or wrong unit");
 	}
@@ -193,7 +190,7 @@
 	sigset_t old_sigmask;
 	TRACE_FUN(ft_t_flow);
 
-	if (!busy_flag || 
+	if ( !test_bit(0,&busy_flag) || 
 	    MINOR(filep->f_dentry->d_inode->i_rdev) != zft_unit || 
 	    ft_failure)
 	{
@@ -202,14 +199,12 @@
 	}
 	old_sigmask = current->blocked; /* save mask */
 	sigfillset(&current->blocked);
-	lock_kernel();
 	if ((result = ftape_mmap(vma)) >= 0) {
 #ifndef MSYNC_BUG_WAS_FIXED
 		static struct vm_operations_struct dummy = { NULL, };
 		vma->vm_ops = &dummy;
 #endif
 	}
-	unlock_kernel();
 	current->blocked = old_sigmask; /* restore mask */
 	TRACE_EXIT result;
 }
@@ -225,7 +220,7 @@
 	TRACE_FUN(ft_t_flow);
 
 	TRACE(ft_t_data_flow, "called with count: %ld", (unsigned long)req_len);
-	if (!busy_flag || MINOR(ino->i_rdev) != zft_unit || ft_failure) {
+	if (!test_bit(0,&busy_flag)  || MINOR(ino->i_rdev) != zft_unit || ft_failure) {
 		TRACE_ABORT(-EIO, ft_t_err,
 			    "failed: not busy, failure or wrong unit");
 	}
@@ -248,7 +243,7 @@
 	TRACE_FUN(ft_t_flow);
 
 	TRACE(ft_t_flow, "called with count: %ld", (unsigned long)req_len);
-	if (!busy_flag || MINOR(ino->i_rdev) != zft_unit || ft_failure) {
+	if (!test_bit(0,&busy_flag) || MINOR(ino->i_rdev) != zft_unit || ft_failure) {
 		TRACE_ABORT(-EIO, ft_t_err,
 			    "failed: not busy, failure or wrong unit");
 	}
@@ -403,7 +398,7 @@
  */
 static int can_unload(void)
 {
-	return (GET_USE_COUNT(THIS_MODULE)||zft_dirty()||busy_flag)?-EBUSY:0;
+	return (GET_USE_COUNT(THIS_MODULE)||zft_dirty()||test_bit(0,&busy_flag))?-EBUSY:0;
 }
 /* Called by modules package when installing the driver
  */
diff -ur linux-2.5.1-pre2-clean/drivers/char/lp.c linux/drivers/char/lp.c
--- linux-2.5.1-pre2-clean/drivers/char/lp.c	Thu Oct 25 00:07:39 2001
+++ linux/drivers/char/lp.c	Wed Nov 28 11:08:07 2001
@@ -494,11 +494,9 @@
 	parport_negotiate (lp_table[minor].dev->port, IEEE1284_MODE_COMPAT);
 	lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
 	lp_release_parport (&lp_table[minor]);
-	lock_kernel();
 	kfree(lp_table[minor].lp_buffer);
 	lp_table[minor].lp_buffer = NULL;
 	LP_F(minor) &= ~LP_BUSY;
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/mixcomwd.c linux/drivers/char/mixcomwd.c
--- linux-2.5.1-pre2-clean/drivers/char/mixcomwd.c	Thu Sep 13 15:21:32 2001
+++ linux/drivers/char/mixcomwd.c	Wed Nov 28 11:08:07 2001
@@ -101,11 +101,9 @@
 static int mixcomwd_release(struct inode *inode, struct file *file)
 {
 
-	lock_kernel();
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
 	if(mixcomwd_timer_alive) {
 		printk(KERN_ERR "mixcomwd: release called while internal timer alive");
-		unlock_kernel();
 		return -EBUSY;
 	}
 	init_timer(&mixcomwd_timer);
@@ -117,7 +115,6 @@
 #endif
 
 	clear_bit(0,&mixcomwd_opened);
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/nvram.c linux/drivers/char/nvram.c
--- linux-2.5.1-pre2-clean/drivers/char/nvram.c	Fri Sep 14 14:40:00 2001
+++ linux/drivers/char/nvram.c	Wed Nov 28 11:08:07 2001
@@ -108,7 +108,10 @@
 #include <asm/system.h>
 
 static int nvram_open_cnt;	/* #times opened */
-static int nvram_open_mode;		/* special open modes */
+static int nvram_open_mode;	/* special open modes */
+static spinlock_t nvram_open_lock = SPIN_LOCK_UNLOCKED;
+                               /* guards nvram_open_cnt and
+                                         nvram_open_mode */
 #define	NVRAM_WRITE		1		/* opened for writing (exclusive) */
 #define	NVRAM_EXCL		2		/* opened with O_EXCL */
 
@@ -326,29 +329,33 @@
 
 static int nvram_open( struct inode *inode, struct file *file )
 {
+	spin_lock( &nvram_open_lock );
 	if ((nvram_open_cnt && (file->f_flags & O_EXCL)) ||
 		(nvram_open_mode & NVRAM_EXCL) ||
 		((file->f_mode & 2) && (nvram_open_mode & NVRAM_WRITE)))
+	{	
+		spin_unlock( &nvram_open_lock );
 		return( -EBUSY );
+	}
 
 	if (file->f_flags & O_EXCL)
 		nvram_open_mode |= NVRAM_EXCL;
 	if (file->f_mode & 2)
 		nvram_open_mode |= NVRAM_WRITE;
 	nvram_open_cnt++;
+	spin_unlock( &nvram_open_lock );
 	return( 0 );
 }
 
 static int nvram_release( struct inode *inode, struct file *file )
 {
-	lock_kernel();
+	spin_lock( &nvram_open_lock );
 	nvram_open_cnt--;
 	if (file->f_flags & O_EXCL)
 		nvram_open_mode &= ~NVRAM_EXCL;
 	if (file->f_mode & 2)
 		nvram_open_mode &= ~NVRAM_WRITE;
-	unlock_kernel();
-
+	spin_unlock( &nvram_open_lock );
 	return( 0 );
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/pc110pad.c linux/drivers/char/pc110pad.c
--- linux-2.5.1-pre2-clean/drivers/char/pc110pad.c	Fri Sep  7 09:28:38 2001
+++ linux/drivers/char/pc110pad.c	Wed Nov 28 11:08:07 2001
@@ -68,7 +68,9 @@
 /* driver/filesystem interface management */
 static wait_queue_head_t queue;
 static struct fasync_struct *asyncptr;
-static int active;	/* number of concurrent open()s */
+static active_count = 0; 	/* number of concurrent open()s */
+static spinlock_t active_lock = SPIN_LOCK_UNLOCKED;
+/* this lock should be held when referencing active_count */
 static struct semaphore reader_lock;
 
 /**
@@ -584,11 +586,11 @@
  
 static int close_pad(struct inode * inode, struct file * file)
 {
-	lock_kernel();
 	fasync_pad(-1, file, 0);
-	if (!--active)
+	spin_lock( &active_lock );
+	if (!--active_count)
 		outb(0x30, current_params.io+2);  /* switch off digitiser */
-	unlock_kernel();
+	spin_unlock( &active_lock );	
 	return 0;
 }
 
@@ -608,8 +610,13 @@
 {
 	unsigned long flags;
 	
-	if (active++)
+	spin_lock( &active_lock );
+	if (active_count++)
+        {
+		spin_unlock( &active_lock );
 		return 0;
+	}
+	spin_unlock( &active_lock );
 
 	save_flags(flags);
 	cli();
diff -ur linux-2.5.1-pre2-clean/drivers/char/pc_keyb.c linux/drivers/char/pc_keyb.c
--- linux-2.5.1-pre2-clean/drivers/char/pc_keyb.c	Fri Nov  9 14:01:21 2001
+++ linux/drivers/char/pc_keyb.c	Wed Nov 28 11:08:07 2001
@@ -90,6 +90,7 @@
  
 static struct aux_queue *queue;	/* Mouse data buffer. */
 static int aux_count;
+static spinlock_t aux_count_lock = SPIN_LOCK_UNLOCKED;
 /* used when we send commands to the mouse that expect an ACK. */
 static unsigned char mouse_reply_expected;
 
@@ -405,8 +406,9 @@
 
        if (rqst == PM_RESUME) {
                if (queue) {                    /* Aux port detected */
-                       if (aux_count == 0) {   /* Mouse not in use */ 
-                               spin_lock_irqsave(&kbd_controller_lock, flags);
+		       spin_lock_irqsave( &aux_count_lock, flags);
+              	       if ( aux_count == 0) {   /* Mouse not in use */ 
+                               spin_lock(&kbd_controller_lock);
 			       /*
 				* Dell Lat. C600 A06 enables mouse after resume.
 				* When user touches the pad, it posts IRQ 12
@@ -418,8 +420,9 @@
 			       kbd_write_command(KBD_CCMD_WRITE_MODE);
 			       kb_wait();
 			       kbd_write_output(AUX_INTS_OFF);
-			       spin_unlock_irqrestore(&kbd_controller_lock, flags);
+			       spin_unlock(&kbd_controller_lock, flags);
 		       }
+		       spin_unlock_irqrestore( &aux_count_lock,flags );
 	       }
        }
 #endif
@@ -430,6 +433,7 @@
 static inline void handle_mouse_event(unsigned char scancode)
 {
 #ifdef CONFIG_PSMOUSE
+	int flags;
 	static unsigned char prev_code;
 	if (mouse_reply_expected) {
 		if (scancode == AUX_ACK) {
@@ -448,7 +452,8 @@
 
 	prev_code = scancode;
 	add_mouse_randomness(scancode);
-	if (aux_count) {
+	spin_lock_irqsave( &aux_count_lock, flags);
+	if ( aux_count ) {
 		int head = queue->head;
 
 		queue->buf[head] = scancode;
@@ -459,6 +464,7 @@
 			wake_up_interruptible(&queue->proc_list);
 		}
 	}
+	spin_unlock_irqrestore( &aux_count_lock, flags);
 #endif
 }
 
@@ -1046,16 +1052,17 @@
 
 static int release_aux(struct inode * inode, struct file * file)
 {
-	lock_kernel();
+	int flags;
 	fasync_aux(-1, file, 0);
-	if (--aux_count) {
-		unlock_kernel();
+	spin_lock_irqsave( &aux_count, flags );
+	if ( --aux_count ) {
+		spin_unlock_irqrestore( &aux_count_lock );
 		return 0;
 	}
+	spin_unlock_irqrestore( &aux_count_lock, flags );
 	kbd_write_cmd(AUX_INTS_OFF);			    /* Disable controller ints */
 	kbd_write_command_w(KBD_CCMD_MOUSE_DISABLE);
 	aux_free_irq(AUX_DEV);
-	unlock_kernel();
 	return 0;
 }
 
@@ -1066,12 +1073,16 @@
 
 static int open_aux(struct inode * inode, struct file * file)
 {
-	if (aux_count++) {
+	int flags;
+	spin_lock_irqsave( &aux_count_lock, flags );
+	if ( aux_count++ ) {
+		spin_unlock_irqrestore( &aux_count_lock );
 		return 0;
 	}
 	queue->head = queue->tail = 0;		/* Flush input queue */
 	if (aux_request_irq(keyboard_interrupt, AUX_DEV)) {
 		aux_count--;
+		spin_unlock_irqrestore( &aux_count_lock, flags );
 		return -EBUSY;
 	}
 	kbd_write_command_w(KBD_CCMD_MOUSE_ENABLE);	/* Enable the
@@ -1083,7 +1094,7 @@
 	mdelay(2);			/* Ensure we follow the kbc access delay rules.. */
 
 	send_data(KBD_CMD_ENABLE);	/* try to workaround toshiba4030cdt problem */
-
+	spin_unlock_irqrestore( &aux_count_lock, flags );
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/pcwd.c linux/drivers/char/pcwd.c
--- linux-2.5.1-pre2-clean/drivers/char/pcwd.c	Thu Sep 13 15:21:32 2001
+++ linux/drivers/char/pcwd.c	Wed Nov 28 11:08:07 2001
@@ -100,7 +100,8 @@
 #define WD_SRLY2                0x80	/* Software external relay triggered */
 
 static int current_readport, revision, temp_panic;
-static int is_open, initial_status, supports_temp, mode_debug;
+static atomic_t open_allowed = ATOMIC_INIT(1);
+static int initial_status, supports_temp, mode_debug;
 static spinlock_t io_lock;
 
 /*
@@ -402,9 +403,12 @@
         switch (MINOR(ino->i_rdev))
         {
                 case WATCHDOG_MINOR:
-                    if (is_open)
+                    if ( !atomic_dec_and_test(&open_allowed) )
+		    {
+			atomic_inc( &open_allowed );
                         return -EBUSY;
-                    MOD_INC_USE_COUNT;
+                    }
+		    MOD_INC_USE_COUNT;
                     /*  Enable the port  */
                     if (revision == PCWD_REVISION_C)
                     {
@@ -412,7 +416,6 @@
                     	outb_p(0x00, current_readport + 3);
                     	spin_unlock(&io_lock);
                     }
-                    is_open = 1;
                     return(0);
                 case TEMP_MINOR:
                     return(0);
@@ -452,8 +455,6 @@
 {
 	if (MINOR(ino->i_rdev)==WATCHDOG_MINOR)
 	{
-		lock_kernel();
-	        is_open = 0;
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
 		/*  Disable the board  */
 		if (revision == PCWD_REVISION_C) {
@@ -462,8 +463,8 @@
 			outb_p(0xA5, current_readport + 3);
 			spin_unlock(&io_lock);
 		}
+	        atomic_inc( &open_allowed );
 #endif
-		unlock_kernel();
 	}
 	return 0;
 }
@@ -574,7 +575,7 @@
 	printk("pcwd: v%s Ken Hollis (kenji@bitgate.com)\n", WD_VER);
 
 	/* Initial variables */
-	is_open = 0;
+	set_bit( 0, &open_allowed );
 	supports_temp = 0;
 	mode_debug = 0;
 	temp_panic = 0;
diff -ur linux-2.5.1-pre2-clean/drivers/char/ppdev.c linux/drivers/char/ppdev.c
--- linux-2.5.1-pre2-clean/drivers/char/ppdev.c	Thu Sep 13 15:21:32 2001
+++ linux/drivers/char/ppdev.c	Wed Nov 28 11:08:07 2001
@@ -646,7 +646,6 @@
 	struct pp_struct *pp = file->private_data;
 	int compat_negot;
 
-	lock_kernel();
 	compat_negot = 0;
 	if (!(pp->flags & PP_CLAIMED) && pp->pdev &&
 	    (pp->state.mode != IEEE1284_MODE_COMPAT)) {
@@ -695,7 +694,6 @@
 		printk (KERN_DEBUG CHRDEV "%x: unregistered pardevice\n",
 			minor);
 	}
-	unlock_kernel();
 
 	kfree (pp);
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/qpmouse.c linux/drivers/char/qpmouse.c
--- linux-2.5.1-pre2-clean/drivers/char/qpmouse.c	Fri Sep  7 09:28:38 2001
+++ linux/drivers/char/qpmouse.c	Wed Nov 28 11:08:07 2001
@@ -111,6 +111,7 @@
 
 static int qp_present;
 static int qp_count;
+static spinlock_t qp_count_lock = SPIN_LOCK_UNLOCKED;
 static int qp_data = QP_DATA;
 static int qp_status = QP_STATUS;
 
@@ -141,8 +142,8 @@
 {
 	unsigned char status;
 
-	lock_kernel();
 	fasync_qp(-1, file, 0);
+ 	spin_lock( &qp_count_lock );	
 	if (!--qp_count) {
 		if (!poll_qp_status())
 			printk(KERN_WARNING "Warning: Mouse device busy in release_qp()\n");
@@ -152,7 +153,7 @@
 			printk(KERN_WARNING "Warning: Mouse device busy in release_qp()\n");
 		free_irq(QP_IRQ, NULL);
 	}
-	unlock_kernel();
+	spin_unlock( &qp_count_lock );
 	return 0;
 }
 
@@ -168,8 +169,13 @@
 	if (!qp_present)
 		return -EINVAL;
 
+	spin_lock( &qp_count_lock );
 	if (qp_count++)
+	{
+		spin_unlock( &qp_count_lock );
 		return 0;
+	}
+	spin_unlock( &qp_count_lock );
 
 	if (request_irq(QP_IRQ, qp_interrupt, 0, "PS/2 Mouse", NULL)) {
 		qp_count--;
diff -ur linux-2.5.1-pre2-clean/drivers/char/qtronix.c linux/drivers/char/qtronix.c
--- linux-2.5.1-pre2-clean/drivers/char/qtronix.c	Sun Sep  9 10:43:02 2001
+++ linux/drivers/char/qtronix.c	Wed Nov 28 11:08:07 2001
@@ -492,10 +492,8 @@
 
 static int release_aux(struct inode * inode, struct file * file)
 {
-	lock_kernel();
 	fasync_aux(-1, file, 0);
 	aux_count--;
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/sbc60xxwdt.c linux/drivers/char/sbc60xxwdt.c
--- linux-2.5.1-pre2-clean/drivers/char/sbc60xxwdt.c	Thu Sep 13 15:21:32 2001
+++ linux/drivers/char/sbc60xxwdt.c	Wed Nov 28 11:08:07 2001
@@ -214,7 +214,6 @@
 
 static int fop_close(struct inode * inode, struct file * file)
 {
-	lock_kernel();
 	if(MINOR(inode->i_rdev) == WATCHDOG_MINOR) 
 	{
 		if(wdt_expect_close)
@@ -225,7 +224,6 @@
 		}
 	}
 	wdt_is_open = 0;
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/softdog.c linux/drivers/char/softdog.c
--- linux-2.5.1-pre2-clean/drivers/char/softdog.c	Sun Sep 30 12:26:05 2001
+++ linux/drivers/char/softdog.c	Wed Nov 28 11:08:08 2001
@@ -100,12 +100,10 @@
 	 *	Shut off the timer.
 	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
 	 */
-	 lock_kernel();
 #ifndef CONFIG_WATCHDOG_NOWAYOUT	 
 	del_timer(&watchdog_ticktock);
 #endif	
 	timer_alive=0;
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/tpqic02.c linux/drivers/char/tpqic02.c
--- linux-2.5.1-pre2-clean/drivers/char/tpqic02.c	Fri Sep 14 14:40:00 2001
+++ linux/drivers/char/tpqic02.c	Wed Nov 28 11:08:08 2001
@@ -2395,7 +2395,6 @@
 {
 	kdev_t dev = inode->i_rdev;
 
-	lock_kernel();
 	if (TP_DIAGS(dev)) {
 		printk("qic02_tape_release: dev=%s\n", kdevname(dev));
 	}
@@ -2419,7 +2418,6 @@
 			(void) do_qic_cmd(QCMD_REWIND, TIM_R);
 		}
 	}
-	unlock_kernel();
 	return 0;
 }				/* qic02_tape_release */
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/w83877f_wdt.c linux/drivers/char/w83877f_wdt.c
--- linux-2.5.1-pre2-clean/drivers/char/w83877f_wdt.c	Thu Sep 13 15:21:32 2001
+++ linux/drivers/char/w83877f_wdt.c	Wed Nov 28 11:08:08 2001
@@ -214,7 +214,6 @@
 
 static int fop_close(struct inode * inode, struct file * file)
 {
-	lock_kernel();
 	if(MINOR(inode->i_rdev) == WATCHDOG_MINOR) 
 	{
 		if(wdt_expect_close)
@@ -225,7 +224,6 @@
 		}
 	}
 	wdt_is_open = 0;
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/wdt.c linux/drivers/char/wdt.c
--- linux-2.5.1-pre2-clean/drivers/char/wdt.c	Fri Sep  7 09:28:38 2001
+++ linux/drivers/char/wdt.c	Wed Nov 28 11:08:08 2001
@@ -374,7 +374,6 @@
  
 static int wdt_release(struct inode *inode, struct file *file)
 {
-	lock_kernel();
 	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
 	{
 #ifndef CONFIG_WATCHDOG_NOWAYOUT	
@@ -383,7 +382,6 @@
 #endif		
 		wdt_is_open=0;
 	}
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/char/wdt285.c linux/drivers/char/wdt285.c
--- linux-2.5.1-pre2-clean/drivers/char/wdt285.c	Fri Sep  7 09:28:38 2001
+++ linux/drivers/char/wdt285.c	Wed Nov 28 11:08:08 2001
@@ -94,10 +94,8 @@
 static int watchdog_release(struct inode *inode, struct file *file)
 {
 #ifdef ONLY_TESTING
-	lock_kernel();
 	free_irq(IRQ_TIMER4, NULL);
 	timer_alive = 0;
-	unlock_kernel();
 #else
 	/*
 	 *	It's irreversible!
diff -ur linux-2.5.1-pre2-clean/drivers/char/wdt977.c linux/drivers/char/wdt977.c
--- linux-2.5.1-pre2-clean/drivers/char/wdt977.c	Fri Sep  7 09:28:38 2001
+++ linux/drivers/char/wdt977.c	Wed Nov 28 11:08:08 2001
@@ -92,7 +92,6 @@
 	 * 	Lock it in if it's a module and we defined ...NOWAYOUT
 	 */
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
-	lock_kernel();
 
 	// unlock the SuperIO chip
 	outb(0x87,0x370); 
@@ -124,7 +123,6 @@
 	outb(0xAA,0x370);
 
 	timer_alive=0;
-	unlock_kernel();
 
 	printk(KERN_INFO "Watchdog: shutdown.\n");
 #endif
diff -ur linux-2.5.1-pre2-clean/drivers/char/wdt_pci.c linux/drivers/char/wdt_pci.c
--- linux-2.5.1-pre2-clean/drivers/char/wdt_pci.c	Fri Sep  7 09:28:38 2001
+++ linux/drivers/char/wdt_pci.c	Wed Nov 28 11:08:08 2001
@@ -353,16 +353,16 @@
 	switch(MINOR(inode->i_rdev))
 	{
 		case WATCHDOG_MINOR:
-			if(wdt_is_open)
+			if( test_and_set_bit(0,&wdt_is_open) ) 
+			{
 				return -EBUSY;
+			}
 #ifdef CONFIG_WATCHDOG_NOWAYOUT	
 			MOD_INC_USE_COUNT;
 #endif
 			/*
 			 *	Activate 
 			 */
-	 
-			wdt_is_open=1;
 
 			inb_p(WDT_DC);		/* Disable */
 
@@ -412,13 +412,11 @@
 {
 	if(MINOR(inode->i_rdev)==WATCHDOG_MINOR)
 	{
-		lock_kernel();
 #ifndef CONFIG_WATCHDOG_NOWAYOUT	
 		inb_p(WDT_DC);		/* Disable counters */
 		wdtpci_ctr_load(2,0);	/* 0 length reset pulses now */
 #endif		
-		wdt_is_open=0;
-		unlock_kernel();
+		clear_bit(0, &wdt_is_open );
 	}
 	return 0;
 }
diff -ur linux-2.5.1-pre2-clean/drivers/i2c/i2c-dev.c linux/drivers/i2c/i2c-dev.c
--- linux-2.5.1-pre2-clean/drivers/i2c/i2c-dev.c	Thu Oct 11 08:05:47 2001
+++ linux/drivers/i2c/i2c-dev.c	Wed Nov 28 11:08:08 2001
@@ -423,14 +423,9 @@
 #endif
 #if LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0)
 	MOD_DEC_USE_COUNT;
-#else /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
-	lock_kernel();
 #endif /* LINUX_KERNEL_VERSION < KERNEL_VERSION(2,4,0) */
 	if (i2cdev_adaps[minor]->dec_use)
 		i2cdev_adaps[minor]->dec_use(i2cdev_adaps[minor]);
-#if LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0)
-	unlock_kernel();
-#endif /* LINUX_KERNEL_VERSION >= KERNEL_VERSION(2,4,0) */
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/ide/ide-tape.c linux/drivers/ide/ide-tape.c
--- linux-2.5.1-pre2-clean/drivers/ide/ide-tape.c	Wed Nov 28 11:07:20 2001
+++ linux/drivers/ide/ide-tape.c	Wed Nov 28 11:08:08 2001
@@ -5486,7 +5486,6 @@
 	idetape_pc_t pc;
 	unsigned int minor=MINOR (inode->i_rdev);
 
-	lock_kernel();
 	tape = drive->driver_data;
 #if IDETAPE_DEBUG_LOG
 	if (tape->debug_level >= 3)
@@ -5517,7 +5516,6 @@
 		MOD_DEC_USE_COUNT;
 	}
 	clear_bit (IDETAPE_BUSY, &tape->flags);
-	unlock_kernel();
 	return 0;
 }
 
Only in linux/drivers/ide: ide-tape.c.orig
diff -ur linux-2.5.1-pre2-clean/drivers/ieee1394/raw1394.c linux/drivers/ieee1394/raw1394.c
--- linux-2.5.1-pre2-clean/drivers/ieee1394/raw1394.c	Mon Oct  1 21:24:24 2001
+++ linux/drivers/ieee1394/raw1394.c	Wed Nov 28 11:08:08 2001
@@ -949,7 +949,6 @@
         struct pending_request *req;
         int done = 0, i;
 
-        lock_kernel();
         for (i = 0; i < 64; i++) {
                 if (fi->listen_channels & (1ULL << i)) {
                         hpsb_unlisten_channel(hl_handle, fi->host, i);
@@ -990,7 +989,6 @@
         kfree(fi);
 
         V22_COMPAT_MOD_DEC_USE_COUNT;
-        unlock_kernel();
         return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/input/evdev.c linux/drivers/input/evdev.c
--- linux-2.5.1-pre2-clean/drivers/input/evdev.c	Sun Sep 30 12:26:05 2001
+++ linux/drivers/input/evdev.c	Wed Nov 28 11:08:08 2001
@@ -94,7 +94,6 @@
 	struct evdev_list *list = file->private_data;
 	struct evdev_list **listptr;
 
-	lock_kernel();
 	listptr = &list->evdev->list;
 	evdev_fasync(-1, file, 0);
 
@@ -113,7 +112,6 @@
 	}
 
 	kfree(list);
-	unlock_kernel();
 
 	return 0;
 }
diff -ur linux-2.5.1-pre2-clean/drivers/input/input.c linux/drivers/input/input.c
--- linux-2.5.1-pre2-clean/drivers/input/input.c	Sun Sep 30 12:26:05 2001
+++ linux/drivers/input/input.c	Wed Nov 28 11:08:08 2001
@@ -387,9 +387,7 @@
 	old_fops = file->f_op;
 	file->f_op = new_fops;
 
-	lock_kernel();
 	err = new_fops->open(inode, file);
-	unlock_kernel();
 
 	if (err) {
 		fops_put(file->f_op);
diff -ur linux-2.5.1-pre2-clean/drivers/input/joydev.c linux/drivers/input/joydev.c
--- linux-2.5.1-pre2-clean/drivers/input/joydev.c	Sun Sep 30 12:26:05 2001
+++ linux/drivers/input/joydev.c	Wed Nov 28 11:08:08 2001
@@ -164,8 +164,7 @@
 {
 	struct joydev_list *list = file->private_data;
 	struct joydev_list **listptr;
-
-	lock_kernel();
+	
 	listptr = &list->joydev->list;
 	joydev_fasync(-1, file, 0);
 
@@ -184,7 +183,6 @@
 	}
 
 	kfree(list);
-	unlock_kernel();
 
 	return 0;
 }
diff -ur linux-2.5.1-pre2-clean/drivers/input/mousedev.c linux/drivers/input/mousedev.c
--- linux-2.5.1-pre2-clean/drivers/input/mousedev.c	Sun Sep 30 12:26:05 2001
+++ linux/drivers/input/mousedev.c	Wed Nov 28 11:08:08 2001
@@ -169,8 +169,7 @@
 {
 	struct mousedev_list *list = file->private_data;
 	struct mousedev_list **listptr;
-
-	lock_kernel();
+	
 	listptr = &list->mousedev->list;
 	mousedev_fasync(-1, file, 0);
 
@@ -208,7 +207,6 @@
 	}
 	
 	kfree(list);
-	unlock_kernel();
 
 	return 0;
 }
diff -ur linux-2.5.1-pre2-clean/drivers/isdn/avmb1/capi.c linux/drivers/isdn/avmb1/capi.c
--- linux-2.5.1-pre2-clean/drivers/isdn/avmb1/capi.c	Sun Sep 30 12:26:05 2001
+++ linux/drivers/isdn/avmb1/capi.c	Wed Nov 28 11:08:08 2001
@@ -1055,7 +1055,6 @@
 {
 	struct capidev *cdev = (struct capidev *)file->private_data;
 
-	lock_kernel();
 	capincci_free(cdev, 0xffffffff);
 	capidev_free(cdev);
 	file->private_data = NULL;
@@ -1064,7 +1063,6 @@
 #ifdef _DEBUG_REFCOUNT
 	printk(KERN_DEBUG "capi_release %d\n", GET_USE_COUNT(THIS_MODULE));
 #endif
-	unlock_kernel();
 	return 0;
 }
 
@@ -1243,13 +1241,11 @@
 	struct capiminor *mp = (struct capiminor *)file->private_data;
 
 	if (mp) {
-		lock_kernel();
 		mp->file = 0;
 		if (mp->nccip == 0) {
 			capiminor_free(mp);
 			file->private_data = NULL;
 		}
-		unlock_kernel();
 	}
 
 #ifdef _DEBUG_REFCOUNT
diff -ur linux-2.5.1-pre2-clean/drivers/isdn/divert/divert_procfs.c linux/drivers/isdn/divert/divert_procfs.c
--- linux-2.5.1-pre2-clean/drivers/isdn/divert/divert_procfs.c	Sun Sep 30 12:26:05 2001
+++ linux/drivers/isdn/divert/divert_procfs.c	Wed Nov 28 11:08:08 2001
@@ -29,6 +29,7 @@
 ulong if_used = 0;		/* number of interface users */
 static struct divert_info *divert_info_head = NULL;	/* head of queue */
 static struct divert_info *divert_info_tail = NULL;	/* pointer to last entry */
+static spinlock_t divert_info_lock = SPIN_LOCK_UNLOCKED;/* lock for queue */
 static wait_queue_head_t rd_queue;
 
 /*********************************/
@@ -50,8 +51,7 @@
 		 return;	/* no memory */
 	strcpy(ib->info_start, cp);	/* set output string */
 	ib->next = NULL;
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave( &divert_info_lock, flags );
 	ib->usage_cnt = if_used;
 	if (!divert_info_head)
 		divert_info_head = ib;	/* new head */
@@ -70,6 +70,7 @@
 		} else
 			break;
 	}			/* divert_info_head->next */
+	spin_lock_irqrestore( &divert_info_lock, flags );
 	wake_up_interruptible(&(rd_queue));
 }				/* put_info_buffer */
 
@@ -135,17 +136,14 @@
 {
 	unsigned long flags;
 
-	lock_kernel();
-	save_flags(flags);
-	cli();
-	if_used++;
+	spin_lock_irqsave( &divert_info_lock, flags );
+ 	if_used++;
 	if (divert_info_head)
 		(struct divert_info **) filep->private_data = &(divert_info_tail->next);
 	else
 		(struct divert_info **) filep->private_data = &divert_info_head;
-	restore_flags(flags);
+	spin_unlock_irqrestore( &divert_info_lock, flags );
 	/*  start_divert(); */
-	unlock_kernel();
 	return (0);
 }				/* isdn_divert_open */
 
@@ -158,9 +156,7 @@
 	struct divert_info *inf;
 	unsigned long flags;
 
-	lock_kernel();
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave( &divert_info_lock, flags );
 	if_used--;
 	inf = *((struct divert_info **) filep->private_data);
 	while (inf) {
@@ -174,7 +170,7 @@
 			divert_info_head = divert_info_head->next;
 			kfree(inf);
 		}
-	unlock_kernel();
+	spin_unlock_irq( &divert_info_lock, flags );
 	return (0);
 }				/* isdn_divert_close */
 
diff -ur linux-2.5.1-pre2-clean/drivers/macintosh/adb.c linux/drivers/macintosh/adb.c
--- linux-2.5.1-pre2-clean/drivers/macintosh/adb.c	Tue Sep 18 14:23:14 2001
+++ linux/drivers/macintosh/adb.c	Wed Nov 28 11:08:08 2001
@@ -672,7 +672,6 @@
 	struct adbdev_state *state = file->private_data;
 	unsigned long flags;
 
-	lock_kernel();
 	if (state) {
 		file->private_data = NULL;
 		spin_lock_irqsave(&state->lock, flags);
@@ -685,7 +684,6 @@
 			spin_unlock_irqrestore(&state->lock, flags);
 		}
 	}
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/macintosh/via-pmu.c linux/drivers/macintosh/via-pmu.c
--- linux-2.5.1-pre2-clean/drivers/macintosh/via-pmu.c	Sat Sep  8 12:38:42 2001
+++ linux/drivers/macintosh/via-pmu.c	Wed Nov 28 11:08:08 2001
@@ -1983,7 +1983,6 @@
 	struct pmu_private *pp = file->private_data;
 	unsigned long flags;
 
-	lock_kernel();
 	if (pp != 0) {
 		file->private_data = 0;
 		spin_lock_irqsave(&all_pvt_lock, flags);
@@ -1991,7 +1990,6 @@
 		spin_unlock_irqrestore(&all_pvt_lock, flags);
 		kfree(pp);
 	}
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/message/i2o/i2o_config.c linux/drivers/message/i2o/i2o_config.c
--- linux-2.5.1-pre2-clean/drivers/message/i2o/i2o_config.c	Mon Oct 22 08:39:56 2001
+++ linux/drivers/message/i2o/i2o_config.c	Wed Nov 28 11:08:08 2001
@@ -847,7 +847,6 @@
 	struct i2o_cfg_info *p1, *p2;
 	unsigned long flags;
 
-	lock_kernel();
 	p1 = p2 = NULL;
 
 	spin_lock_irqsave(&i2o_config_lock, flags);
@@ -870,7 +869,6 @@
 		p1 = p1->next;
 	}
 	spin_unlock_irqrestore(&i2o_config_lock, flags);
-	unlock_kernel();
 
 	return 0;
 }
diff -ur linux-2.5.1-pre2-clean/drivers/net/ppp_generic.c linux/drivers/net/ppp_generic.c
--- linux-2.5.1-pre2-clean/drivers/net/ppp_generic.c	Thu Oct 11 09:18:31 2001
+++ linux/drivers/net/ppp_generic.c	Wed Nov 28 11:08:09 2001
@@ -325,7 +325,6 @@
 {
 	struct ppp_file *pf = (struct ppp_file *) file->private_data;
 
-	lock_kernel();
 	if (pf != 0) {
 		file->private_data = 0;
 		if (atomic_dec_and_test(&pf->refcnt)) {
@@ -339,7 +338,6 @@
 			}
 		}
 	}
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/net/wan/cosa.c linux/drivers/net/wan/cosa.c
--- linux-2.5.1-pre2-clean/drivers/net/wan/cosa.c	Thu Sep 13 16:04:43 2001
+++ linux/drivers/net/wan/cosa.c	Wed Nov 28 11:08:09 2001
@@ -974,13 +974,11 @@
 	struct cosa_data *cosa;
 	unsigned long flags;
 
-	lock_kernel();
 	cosa = channel->cosa;
 	spin_lock_irqsave(&cosa->lock, flags);
 	cosa->usage--;
 	channel->usage--;
 	spin_unlock_irqrestore(&cosa->lock, flags);
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-2.5.1-pre2-clean/drivers/pcmcia/ds.c	Mon Nov 12 09:39:01 2001
+++ linux/drivers/pcmcia/ds.c	Wed Nov 28 11:08:09 2001
@@ -597,7 +597,6 @@
     DEBUG(0, "ds_release(socket %d)\n", i);
     if ((i >= sockets) || (sockets == 0))
 	return 0;
-    lock_kernel();
     s = &socket_table[i];
     user = file->private_data;
     if (CHECK_USER(user))
@@ -615,7 +614,6 @@
     user->user_magic = 0;
     kfree(user);
 out:
-    unlock_kernel();
     return 0;
 } /* ds_release */
 
diff -ur linux-2.5.1-pre2-clean/drivers/pnp/isapnp_proc.c linux/drivers/pnp/isapnp_proc.c
--- linux-2.5.1-pre2-clean/drivers/pnp/isapnp_proc.c	Wed Jan 17 13:29:14 2001
+++ linux/drivers/pnp/isapnp_proc.c	Wed Nov 28 11:08:09 2001
@@ -170,12 +170,10 @@
 		kfree(buffer);
 		return -ENOMEM;
 	}
-	lock_kernel();
 	buffer->curr = buffer->buffer;
 	file->private_data = buffer;
 	if (mode == O_RDONLY)
 		isapnp_info_read(buffer);
-	unlock_kernel();
 	return 0;
 }
 
@@ -187,12 +185,10 @@
 	if ((buffer = (isapnp_info_buffer_t *) file->private_data) == NULL)
 		return -EINVAL;
 	mode = file->f_flags & O_ACCMODE;
-	lock_kernel();
 	if (mode == O_WRONLY)
 		isapnp_info_write(buffer);
 	vfree(buffer->buffer);
 	kfree(buffer);
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/scsi/sg.c linux/drivers/scsi/sg.c
--- linux-2.5.1-pre2-clean/drivers/scsi/sg.c	Sun Nov  4 09:31:57 2001
+++ linux/drivers/scsi/sg.c	Wed Nov 28 11:08:09 2001
@@ -336,9 +336,7 @@
     Sg_device * sdp;
     Sg_fd * sfp;
 
-    lock_kernel();
     if ((! (sfp = (Sg_fd *)filp->private_data)) || (! (sdp = sfp->parentdp))) {
-	unlock_kernel();
         return -ENXIO;
     }
     SCSI_LOG_TIMEOUT(3, printk("sg_release: dev=%d\n", MINOR(sdp->i_rdev)));
@@ -352,7 +350,6 @@
 	sdp->exclude = 0;
 	wake_up_interruptible(&sdp->o_excl_wait);
     }
-    unlock_kernel();
     return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/sgi/char/graphics.c linux/drivers/sgi/char/graphics.c
--- linux-2.5.1-pre2-clean/drivers/sgi/char/graphics.c	Thu Oct 11 09:43:30 2001
+++ linux/drivers/sgi/char/graphics.c	Wed Nov 28 11:08:09 2001
@@ -196,7 +196,6 @@
 	int board = GRAPHICS_CARD (inode->i_rdev);
 
 	/* Tell the rendering manager that one client is going away */
-	lock_kernel();
 	rrm_close (inode, file);
 
 	/* Was this file handle from the board owner?, clear it */
@@ -206,7 +205,6 @@
 			(*cards [board].g_reset_console)();
 		enable_gconsole ();
 	}
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/sgi/char/shmiq.c linux/drivers/sgi/char/shmiq.c
--- linux-2.5.1-pre2-clean/drivers/sgi/char/shmiq.c	Mon Aug 27 08:56:31 2001
+++ linux/drivers/sgi/char/shmiq.c	Wed Nov 28 11:08:09 2001
@@ -79,11 +79,13 @@
 
 /* /dev/qcntlN attached memory regions, location and size of the event queue */
 static struct {
-	int    opened;		/* if this device has been opened */
-	void   *shmiq_vaddr;	/* mapping in kernel-land */
-	int    tail;		/* our copy of the shmiq->tail */
-	int    events;
-	int    mapped;
+	int		opened;
+	void 	 	*shmiq_vaddr;		/* mapping in kernel-land */
+	spinlock_t	shmiq_lock:SPIN_LOCK_UNLOCKED;
+					 	/* protects vaddr and opened */
+	int   		tail;			/* our copy of the shmiq->tail */
+	int    		events;
+	int    		mapped;
 	
 	wait_queue_head_t    proc_list;
 	struct fasync_struct *fasync;
@@ -328,10 +330,10 @@
 
 	size  = vma->vm_end - vma->vm_start;
 	start = vma->vm_start; 
-	lock_kernel();
+	spin_lock( &shmiqs [minor].shmiq_lock );
 	mem = (unsigned long) shmiqs [minor].shmiq_vaddr =  vmalloc_uncached (size);
 	if (!mem) {
-		unlock_kernel();
+		spin_unlock( &shmiqs [minor].shmiq_lock );
 		return -EINVAL;
 	}
 
@@ -347,8 +349,7 @@
 	shmiqs [minor].tail = 0;
 	/* Init the shared memory input queue */
 	memset (shmiqs [minor].shmiq_vaddr, 0, size);
-	unlock_kernel();
-	
+	spin_unlock( &shmiqs [minor].shmiq_lock );
 	return error;
 }
 
@@ -393,13 +394,16 @@
 	minor--;
 	if (minor > MAX_SHMI_QUEUES)
 		return -EINVAL;
+	spin_lock( &shmiqs [minor].shmiq_lock );
 	if (shmiqs [minor].opened)
+	{
+		spin_unlock( &shmiqs [minor].shmiq_lock );
 		return -EBUSY;
+	}
 
-	lock_kernel ();
 	shmiqs [minor].opened      = 1;
 	shmiqs [minor].shmiq_vaddr = 0;
-	unlock_kernel ();
+	spin_unlock( &shmiqs [minor].shmiq_lock );
 
 	return 0;
 }
@@ -429,18 +433,19 @@
 
 	if (minor > MAX_SHMI_QUEUES)
 		return -EINVAL;
+
+	spin_lock( &shmiqs [minor].shmiq_lock );
 	if (shmiqs [minor].opened == 0)
 		return -EINVAL;
 
-	lock_kernel ();
 	shmiq_qcntl_fasync (-1, filp, 0);
-	shmiqs [minor].opened      = 0;
+	shmiqs [minor].opened 	   = 0;
 	shmiqs [minor].mapped      = 0;
 	shmiqs [minor].events      = 0;
 	shmiqs [minor].fasync      = 0;
 	vfree (shmiqs [minor].shmiq_vaddr);
 	shmiqs [minor].shmiq_vaddr = 0;
-	unlock_kernel ();
+	spin_unlock( &shmiqs [minor].shmiq_lock );
 
 	return 0;
 }
diff -ur linux-2.5.1-pre2-clean/drivers/sgi/char/streamable.c linux/drivers/sgi/char/streamable.c
--- linux-2.5.1-pre2-clean/drivers/sgi/char/streamable.c	Wed Jul 12 21:58:43 2000
+++ linux/drivers/sgi/char/streamable.c	Wed Nov 28 11:08:09 2001
@@ -221,9 +221,7 @@
 static int
 sgi_mouse_close (struct inode *inode, struct file *filp)
 {
-	lock_kernel();
 	mouse_opened = 0;
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/usb/dabusb.c linux/drivers/usb/dabusb.c
--- linux-2.5.1-pre2-clean/drivers/usb/dabusb.c	Fri Sep 14 14:04:07 2001
+++ linux/drivers/usb/dabusb.c	Wed Nov 28 11:08:09 2001
@@ -622,7 +622,6 @@
 
 	dbg("dabusb_release");
 
-	lock_kernel();
 	down (&s->mutex);
 	dabusb_stop (s);
 	dabusb_free_buffers (s);
@@ -636,7 +635,6 @@
 		wake_up (&s->remove_ok);
 
 	s->opened = 0;
-	unlock_kernel();
 	return 0;
 }
 
diff -ur linux-2.5.1-pre2-clean/drivers/usb/hiddev.c linux/drivers/usb/hiddev.c
--- linux-2.5.1-pre2-clean/drivers/usb/hiddev.c	Sat Oct 20 19:13:11 2001
+++ linux/drivers/usb/hiddev.c	Wed Nov 28 11:08:09 2001
@@ -193,7 +193,6 @@
 	struct hiddev_list *list = file->private_data;
 	struct hiddev_list **listptr;
 
-	lock_kernel();
 	listptr = &list->hiddev->list;
 	hiddev_fasync(-1, file, 0);
 
@@ -209,7 +208,6 @@
 	}
 
 	kfree(list);
-	unlock_kernel();
 
 	return 0;
 }
diff -ur linux-2.5.1-pre2-clean/fs/autofs4/root.c linux/fs/autofs4/root.c
--- linux-2.5.1-pre2-clean/fs/autofs4/root.c	Mon Oct 23 21:57:38 2000
+++ linux/fs/autofs4/root.c	Wed Nov 28 11:08:09 2001
@@ -202,8 +202,6 @@
 {
 	struct autofs_info *inf;
 
-	lock_kernel();
-
 	DPRINTK(("autofs4_dentry_release: releasing %p\n", de));
 
 	inf = autofs4_dentry_ino(de);
@@ -215,8 +213,6 @@
 
 		autofs4_free_ino(inf);
 	}
-
-	unlock_kernel();
 }
 
 /* For dentries of directories in the root dir */
