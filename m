Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTCCDZJ>; Sun, 2 Mar 2003 22:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268311AbTCCDZJ>; Sun, 2 Mar 2003 22:25:09 -0500
Received: from csl.Stanford.EDU ([171.64.73.43]:21454 "EHLO csl.stanford.edu")
	by vger.kernel.org with ESMTP id <S262201AbTCCDZF>;
	Sun, 2 Mar 2003 22:25:05 -0500
From: Dawson Engler <engler@csl.stanford.edu>
Message-Id: <200303030335.h233ZTt07857@csl.stanford.edu>
Subject: [CHECKER] potential deadlocks
To: linux-kernel@vger.kernel.org
Date: Sun, 2 Mar 2003 19:35:29 -0800 (PST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

here are a small number of potential deadlocks caught from a static
deadlock detector. It flags any places with locking cycles.  E.g. it
will flag:

	lock(a)
	lock(b);
	...
	unlock(a);
	unlock(b);
	...
	lock(b);
	lock(a)
since a thread could grab "a" while another could grab "b" and then
both could spin waiting for the other's lock.

It understands that only the first read_lock and lock_kernel actually
does anything, so that it won't warn about

	lock_kernel();
	lock(a);
	lock_kernel(); /* no lock acquired */

violating a partial order.

Any feedback on the results would be great.  My understanding of linux's
sprawling locking rules is less than impressive.  Also, if there are
known deadlocks, let me know and I can make sure we're finding them.

Note that the message format is a bit confusing.  It prints out the number
of times each locking order occurred at and then gives some example paths.
For example, for the first error below:

   <&driver_lock>-><&adap_lock> occurred 1 times
   <&adap_lock>-><&driver_lock> occurred 1 times

means that driver_lock was aqcquired followed by adap_lock 1 time,
and the opposite also occured one time.  A path to the first order
is given by:
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/i2c/i2c-core.c:i2c_del_driver:292
           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/i2c/i2c-core.c:i2c_del_driver:312

Thanks to Andrew for feedback on other race detector checker.

Dawson

--------------------------------------------------
BUG ERROR: 1 thread deadlock.
   <&driver_lock>-><&adap_lock> occurred 1 times
   <&adap_lock>-><&driver_lock> occurred 1 times
  &driver_lock->&adap_lock =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/i2c/i2c-core.c:i2c_del_driver:292
           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/i2c/i2c-core.c:i2c_del_driver:312

  &adap_lock->&driver_lock =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/i2c/i2c-core.c:i2c_del_adapter:175
           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/i2c/i2c-core.c:i2c_del_adapter:192

--------------------------------------------------
BUG ERROR: 1 thread deadlock.
   <&rtc_lock>-><&rtc_task_lock> occurred 1 times
   <&rtc_task_lock>-><&rtc_lock> occurred 1 times
  &rtc_lock->&rtc_task_lock =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/rtc.c:rtc_register:723
           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/rtc.c:rtc_register:728

  &rtc_task_lock->&rtc_lock =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/rtc.c:rtc_unregister:749
           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/char/rtc.c:rtc_unregister:755



--------------------------------------------------
BUG ERROR: 1 thread deadlock.
   <struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0)>-><struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0)> occurred 1 times
   <struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0)>-><struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0)> occurred 1 times
  struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0)->struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0) =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1620
           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1711

  struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0)->struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0) =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1610
           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1620

--------------------------------------------------
BUG ERROR: 1 thread deadlock.
   <&dev_table_mutex>-><struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0)> occurred 1 times
   <struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0)>-><&dev_table_mutex> occurred 1 times
  &dev_table_mutex->struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0) =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_open:1404
           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_open:1412

  struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0)->&dev_table_mutex =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerswald_disconnect:2091
           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerswald_disconnect:2096 



--------------------------------------------------
BUG ERROR: 1 thread deadlock.
   <lock_kernel>-><struct namespace.sem (<local>:0)> occurred 36 times
   <struct namespace.sem (<local>:0)>-><lock_kernel> occurred 30 times
  lock_kernel->struct namespace.sem (<local>:0) =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_pivot_root:974
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_pivot_root:997
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_umount:306
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_umount:335
    depth = 3:
        /u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_mount:870
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_mount:870
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_mount:871
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_mount:753
           ->end=/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_loopback:511
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_loopback:511
    depth = 3:
        /u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_mount:870
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_mount:870
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_mount:871
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_mount:755
           ->end=/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_move_mount:579
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_move_mount:579
    depth = 3:
        /u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_mount:870
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_mount:870
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:sys_mount:871
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_mount:757
           ->end=/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_add_mount:644
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_add_mount:644

  struct namespace.sem (<local>:0)->lock_kernel =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_umount:335
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/namespace.c:do_umount:341


--------------------------------------------------
BUG: ERROR: 1 thread deadlock.
   <struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0)>-><struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0)> occurred 1 times
   <struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0)>-><struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0)> occurred 1 times
  struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0)->struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0) =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1620

        /* only one reader per device allowed */
        if (down_interruptible (&ccp->readmutex)) {
                up (&ccp->mutex);

           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1711

        if (down_interruptible (&ccp->mutex)) {
                up (&ccp->readmutex);


  struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.mutex (<local>:0)->struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c582.readmutex (<local>:0) =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1610

        /* get the mutex */
        if (down_interruptible (&ccp->mutex))
                return -ERESTARTSYS;

           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_read:1620

        /* only one reader per device allowed */
        if (down_interruptible (&ccp->readmutex)) {
                up (&ccp->mutex);



--------------------------------------------------
BUG: ERROR: 1 thread deadlock.
   <&dev_table_mutex>-><struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0)> occurred 1 times
   <struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0)>-><&dev_table_mutex> occurred 1 times
  &dev_table_mutex->struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0) =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerchar_open:1404
  struct /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c162.mutex (<local>:0)->&dev_table_mutex =

        /* usb device available? */
        if (down_interruptible (&dev_table_mutex)) {
                return -ERESTARTSYS;
        }
        cp = dev_table[dtindex];
        if (cp == NULL) {
                up (&dev_table_mutex);
                return -ENODEV;
        }
        if (down_interruptible (&cp->mutex)) {

    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerswald_disconnect:2091

           ->/u2/engler/mc/oses/linux/linux-2.5.62/drivers/usb/misc/auerswald.c:auerswald_disconnect:2096

        down (&cp->mutex);
        info ("device /dev/usb/%s now disconnecting", cp->name);

        /* remove from device table */
        /* Nobody can open() this device any more */
        down (&dev_table_mutex);
        dev_table[cp->dtindex] = NULL;
        up (&dev_table_mutex);



--------------------------------------------------
BUG: ERROR: 1 thread deadlock.
   <lock_kernel>-><struct block_device.bd_sem (<local>:0)> occurred 37 times
   <struct block_device.bd_sem (<local>:0)>-><lock_kernel> occurred 36 times
  lock_kernel->struct block_device.bd_sem (<local>:0) =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/fs/block_dev.c:do_open:569
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/block_dev.c:do_open:578

        lock_kernel();
        disk = get_gendisk(bdev->bd_dev, &part);
        if (!disk) {
                unlock_kernel();
                bdput(bdev);
                return ret;
        }
        owner = disk->fops->owner;

        down(&bdev->bd_sem);

    depth = 6:
        /u2/engler/mc/oses/linux/linux-2.5.62/init/main.c:init:508
           ->/u2/engler/mc/oses/linux/linux-2.5.62/init/main.c:init:508
           ->/u2/engler/mc/oses/linux/linux-2.5.62/init/main.c:init:527
           ->/u2/engler/mc/oses/linux/linux-2.5.62/init/do_mounts.c:prepare_namespace:883
           ->/u2/engler/mc/oses/linux/linux-2.5.62/kernel/suspend.c:software_resume:1231
           ->/u2/engler/mc/oses/linux/linux-2.5.62/kernel/suspend.c:read_suspend_image:1170
           ->end=/u2/engler/mc/oses/linux/linux-2.5.62/fs/block_dev.c:blkdev_put:705
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/block_dev.c:blkdev_put:705

  struct block_device.bd_sem (<local>:0)->lock_kernel =
    depth = 1:
        /u2/engler/mc/oses/linux/linux-2.5.62/fs/block_dev.c:blkdev_put:705
           ->/u2/engler/mc/oses/linux/linux-2.5.62/fs/block_dev.c:blkdev_put:712

        down(&bdev->bd_sem);
        switch (kind) {
        case BDEV_FILE:
        case BDEV_FS:
                sync_blockdev(bd_inode->i_bdev);
                break;
        }
        lock_kernel();

