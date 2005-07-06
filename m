Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVGFCgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVGFCgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 22:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVGFCeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 22:34:04 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:56984 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262044AbVGFCTS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:18 -0400
Subject: [PATCH] [4/48] Suspend2 2.1.9.8 for 2.6.12: 302-init-hooks.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:39 +1000
Message-Id: <11206164392@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 350-workthreads.patch-old/drivers/acpi/osl.c 350-workthreads.patch-new/drivers/acpi/osl.c
--- 350-workthreads.patch-old/drivers/acpi/osl.c	2005-06-20 11:46:50.000000000 +1000
+++ 350-workthreads.patch-new/drivers/acpi/osl.c	2005-07-04 23:14:18.000000000 +1000
@@ -95,7 +95,7 @@ acpi_os_initialize1(void)
 		return AE_NULL_ENTRY;
 	}
 #endif
-	kacpid_wq = create_singlethread_workqueue("kacpid");
+	kacpid_wq = create_singlethread_workqueue("kacpid", PF_NOFREEZE);
 	BUG_ON(!kacpid_wq);
 
 	return AE_OK;
diff -ruNp 350-workthreads.patch-old/drivers/block/ll_rw_blk.c 350-workthreads.patch-new/drivers/block/ll_rw_blk.c
--- 350-workthreads.patch-old/drivers/block/ll_rw_blk.c	2005-06-20 11:46:50.000000000 +1000
+++ 350-workthreads.patch-new/drivers/block/ll_rw_blk.c	2005-07-04 23:14:18.000000000 +1000
@@ -3266,7 +3266,7 @@ EXPORT_SYMBOL(kblockd_flush);
 
 int __init blk_dev_init(void)
 {
-	kblockd_workqueue = create_workqueue("kblockd");
+	kblockd_workqueue = create_workqueue("kblockd", PF_NOFREEZE);
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
diff -ruNp 350-workthreads.patch-old/drivers/block/pktcdvd.c 350-workthreads.patch-new/drivers/block/pktcdvd.c
--- 350-workthreads.patch-old/drivers/block/pktcdvd.c	2005-07-06 11:14:09.000000000 +1000
+++ 350-workthreads.patch-new/drivers/block/pktcdvd.c	2005-07-04 23:14:18.000000000 +1000
@@ -2373,7 +2373,7 @@ static int pkt_new_dev(struct pktcdvd_de
 	pkt_init_queue(pd);
 
 	atomic_set(&pd->cdrw.pending_bios, 0);
-	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
+	pd->cdrw.thread = kthread_run(kcdrwd, pd, 0, "%s", pd->name);
 	if (IS_ERR(pd->cdrw.thread)) {
 		printk("pktcdvd: can't start kernel thread\n");
 		ret = -ENOMEM;
diff -ruNp 350-workthreads.patch-old/drivers/char/hvc_console.c 350-workthreads.patch-new/drivers/char/hvc_console.c
--- 350-workthreads.patch-old/drivers/char/hvc_console.c	2005-02-03 22:33:25.000000000 +1100
+++ 350-workthreads.patch-new/drivers/char/hvc_console.c	2005-07-04 23:14:18.000000000 +1000
@@ -709,7 +709,7 @@ int __init hvc_init(void)
 
 	/* Always start the kthread because there can be hotplug vty adapters
 	 * added later. */
-	hvc_task = kthread_run(khvcd, NULL, "khvcd");
+	hvc_task = kthread_run(khvcd, NULL, PF_NOFREEZE, "khvcd");
 	if (IS_ERR(hvc_task)) {
 		panic("Couldn't create kthread for console.\n");
 		put_tty_driver(hvc_driver);
diff -ruNp 350-workthreads.patch-old/drivers/char/hvcs.c 350-workthreads.patch-new/drivers/char/hvcs.c
--- 350-workthreads.patch-old/drivers/char/hvcs.c	2005-02-14 09:05:25.000000000 +1100
+++ 350-workthreads.patch-new/drivers/char/hvcs.c	2005-07-04 23:14:18.000000000 +1000
@@ -1403,7 +1403,7 @@ static int __init hvcs_module_init(void)
 		return -ENOMEM;
 	}
 
-	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
+	hvcs_task = kthread_run(khvcsd, NULL, PF_NOFREEZE, "khvcsd");
 	if (IS_ERR(hvcs_task)) {
 		printk(KERN_ERR "HVCS: khvcsd creation failed.  Driver not loaded.\n");
 		kfree(hvcs_pi_buff);
diff -ruNp 350-workthreads.patch-old/drivers/infiniband/core/fmr_pool.c 350-workthreads.patch-new/drivers/infiniband/core/fmr_pool.c
--- 350-workthreads.patch-old/drivers/infiniband/core/fmr_pool.c	2005-06-20 11:46:54.000000000 +1000
+++ 350-workthreads.patch-new/drivers/infiniband/core/fmr_pool.c	2005-07-04 23:14:18.000000000 +1000
@@ -266,6 +266,7 @@ struct ib_fmr_pool *ib_create_fmr_pool(s
 
 	pool->thread = kthread_create(ib_fmr_cleanup_thread,
 				      pool,
+				      0,
 				      "ib_fmr(%s)",
 				      device->name);
 	if (IS_ERR(pool->thread)) {
diff -ruNp 350-workthreads.patch-old/drivers/infiniband/core/mad.c 350-workthreads.patch-new/drivers/infiniband/core/mad.c
--- 350-workthreads.patch-old/drivers/infiniband/core/mad.c	2005-06-20 11:46:54.000000000 +1000
+++ 350-workthreads.patch-new/drivers/infiniband/core/mad.c	2005-07-04 23:14:18.000000000 +1000
@@ -2502,7 +2502,7 @@ static int ib_mad_port_open(struct ib_de
 		goto error7;
 
 	snprintf(name, sizeof name, "ib_mad%d", port_num);
-	port_priv->wq = create_singlethread_workqueue(name);
+	port_priv->wq = create_singlethread_workqueue(name, 0);
 	if (!port_priv->wq) {
 		ret = -ENOMEM;
 		goto error8;
diff -ruNp 350-workthreads.patch-old/drivers/infiniband/ulp/ipoib/ipoib_main.c 350-workthreads.patch-new/drivers/infiniband/ulp/ipoib/ipoib_main.c
--- 350-workthreads.patch-old/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-06-20 11:46:54.000000000 +1000
+++ 350-workthreads.patch-new/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-07-04 23:14:18.000000000 +1000
@@ -1070,7 +1070,7 @@ static int __init ipoib_init_module(void
 	 * so flush_scheduled_work() can deadlock during device
 	 * removal.
 	 */
-	ipoib_workqueue = create_singlethread_workqueue("ipoib");
+	ipoib_workqueue = create_singlethread_workqueue("ipoib", 0);
 	if (!ipoib_workqueue) {
 		ret = -ENOMEM;
 		goto err_fs;
diff -ruNp 350-workthreads.patch-old/drivers/macintosh/therm_adt746x.c 350-workthreads.patch-new/drivers/macintosh/therm_adt746x.c
--- 350-workthreads.patch-old/drivers/macintosh/therm_adt746x.c	2005-07-06 11:14:09.000000000 +1000
+++ 350-workthreads.patch-new/drivers/macintosh/therm_adt746x.c	2005-07-04 23:14:18.000000000 +1000
@@ -437,7 +437,7 @@ static int attach_one_thermostat(struct 
 		write_both_fan_speed(th, -1);
 	}
 	
-	thread_therm = kthread_run(monitor_task, th, "kfand");
+	thread_therm = kthread_run(monitor_task, th, 0, "kfand");
 
 	if (thread_therm == ERR_PTR(-ENOMEM)) {
 		printk(KERN_INFO "adt746x: Kthread creation failed\n");
diff -ruNp 350-workthreads.patch-old/drivers/md/dm-crypt.c 350-workthreads.patch-new/drivers/md/dm-crypt.c
--- 350-workthreads.patch-old/drivers/md/dm-crypt.c	2005-06-20 11:46:55.000000000 +1000
+++ 350-workthreads.patch-new/drivers/md/dm-crypt.c	2005-07-04 23:14:18.000000000 +1000
@@ -927,7 +927,7 @@ static int __init dm_crypt_init(void)
 	if (!_crypt_io_pool)
 		return -ENOMEM;
 
-	_kcryptd_workqueue = create_workqueue("kcryptd");
+	_kcryptd_workqueue = create_workqueue("kcryptd", PF_NOFREEZE);
 	if (!_kcryptd_workqueue) {
 		r = -ENOMEM;
 		DMERR(PFX "couldn't create kcryptd");
diff -ruNp 350-workthreads.patch-old/drivers/md/dm-mpath.c 350-workthreads.patch-new/drivers/md/dm-mpath.c
--- 350-workthreads.patch-old/drivers/md/dm-mpath.c	2005-06-20 11:46:55.000000000 +1000
+++ 350-workthreads.patch-new/drivers/md/dm-mpath.c	2005-07-04 23:14:18.000000000 +1000
@@ -1278,7 +1278,7 @@ static int __init dm_multipath_init(void
 		return -EINVAL;
 	}
 
-	kmultipathd = create_workqueue("kmpathd");
+	kmultipathd = create_workqueue("kmpathd", 0);
 	if (!kmultipathd) {
 		DMERR("%s: failed to create workqueue kmpathd",
 				multipath_target.name);
diff -ruNp 350-workthreads.patch-old/drivers/md/dm-raid1.c 350-workthreads.patch-new/drivers/md/dm-raid1.c
--- 350-workthreads.patch-old/drivers/md/dm-raid1.c	2005-06-20 11:46:55.000000000 +1000
+++ 350-workthreads.patch-new/drivers/md/dm-raid1.c	2005-07-04 23:14:18.000000000 +1000
@@ -1229,7 +1229,7 @@ static int __init dm_mirror_init(void)
 	if (r)
 		return r;
 
-	_kmirrord_wq = create_workqueue("kmirrord");
+	_kmirrord_wq = create_workqueue("kmirrord", PF_SYNCTHREAD);
 	if (!_kmirrord_wq) {
 		DMERR("couldn't start kmirrord");
 		dm_dirty_log_exit();
diff -ruNp 350-workthreads.patch-old/drivers/md/kcopyd.c 350-workthreads.patch-new/drivers/md/kcopyd.c
--- 350-workthreads.patch-old/drivers/md/kcopyd.c	2005-02-03 22:33:28.000000000 +1100
+++ 350-workthreads.patch-new/drivers/md/kcopyd.c	2005-07-04 23:14:18.000000000 +1000
@@ -609,7 +609,7 @@ static int kcopyd_init(void)
 		return r;
 	}
 
-	_kcopyd_wq = create_singlethread_workqueue("kcopyd");
+	_kcopyd_wq = create_singlethread_workqueue("kcopyd", PF_SYNCTHREAD);
 	if (!_kcopyd_wq) {
 		jobs_exit();
 		up(&kcopyd_init_lock);
diff -ruNp 350-workthreads.patch-old/drivers/media/video/cx88/cx88-video.c 350-workthreads.patch-new/drivers/media/video/cx88/cx88-video.c
--- 350-workthreads.patch-old/drivers/media/video/cx88/cx88-video.c	2005-06-20 11:46:58.000000000 +1000
+++ 350-workthreads.patch-new/drivers/media/video/cx88/cx88-video.c	2005-07-04 23:14:18.000000000 +1000
@@ -2121,7 +2121,7 @@ static int __devinit cx8800_initdev(stru
 
 	/* start tvaudio thread */
 	if (core->tuner_type != TUNER_ABSENT)
-		core->kthread = kthread_run(cx88_audio_thread, core, "cx88 tvaudio");
+		core->kthread = kthread_run(cx88_audio_thread, core, 0, "cx88 tvaudio");
 	return 0;
 
 fail_unreg:
diff -ruNp 350-workthreads.patch-old/drivers/media/video/msp3400.c 350-workthreads.patch-new/drivers/media/video/msp3400.c
--- 350-workthreads.patch-old/drivers/media/video/msp3400.c	2005-07-06 11:14:10.000000000 +1000
+++ 350-workthreads.patch-new/drivers/media/video/msp3400.c	2005-07-04 23:14:18.000000000 +1000
@@ -1563,7 +1563,7 @@ static int msp_attach(struct i2c_adapter
 
 	/* startup control thread if needed */
 	if (thread_func) {
-		msp->kthread = kthread_run(thread_func, c, "msp34xx");
+		msp->kthread = kthread_run(thread_func, c, 0, "msp34xx");
 		if (NULL == msp->kthread)
 			printk(KERN_WARNING "msp34xx: kernel_thread() failed\n");
 		msp_wake_thread(c);
diff -ruNp 350-workthreads.patch-old/drivers/media/video/video-buf-dvb.c 350-workthreads.patch-new/drivers/media/video/video-buf-dvb.c
--- 350-workthreads.patch-old/drivers/media/video/video-buf-dvb.c	2005-07-06 11:14:09.000000000 +1000
+++ 350-workthreads.patch-new/drivers/media/video/video-buf-dvb.c	2005-07-04 23:14:18.000000000 +1000
@@ -103,7 +103,7 @@ static int videobuf_dvb_start_feed(struc
 	if (NULL != dvb->thread)
 		goto out;
 	dvb->thread = kthread_run(videobuf_dvb_thread,
-				  dvb, "%s dvb", dvb->name);
+				  dvb, 0, "%s dvb", dvb->name);
 	if (IS_ERR(dvb->thread)) {
 		rc = PTR_ERR(dvb->thread);
 		dvb->thread = NULL;
diff -ruNp 350-workthreads.patch-old/drivers/message/i2o/driver.c 350-workthreads.patch-new/drivers/message/i2o/driver.c
--- 350-workthreads.patch-old/drivers/message/i2o/driver.c	2005-02-03 22:33:29.000000000 +1100
+++ 350-workthreads.patch-new/drivers/message/i2o/driver.c	2005-07-04 23:14:18.000000000 +1000
@@ -79,7 +79,7 @@ int i2o_driver_register(struct i2o_drive
 	pr_debug("i2o: Register driver %s\n", drv->name);
 
 	if (drv->event) {
-		drv->event_queue = create_workqueue(drv->name);
+		drv->event_queue = create_workqueue(drv->name, 0);
 		if (!drv->event_queue) {
 			printk(KERN_ERR "i2o: Could not initialize event queue "
 			       "for driver %s\n", drv->name);
diff -ruNp 350-workthreads.patch-old/drivers/net/wan/sdlamain.c 350-workthreads.patch-new/drivers/net/wan/sdlamain.c
--- 350-workthreads.patch-old/drivers/net/wan/sdlamain.c	2004-11-03 21:54:35.000000000 +1100
+++ 350-workthreads.patch-new/drivers/net/wan/sdlamain.c	2005-07-04 23:14:18.000000000 +1000
@@ -240,7 +240,7 @@ static int __init wanpipe_init(void)
 	printk(KERN_INFO "%s v%u.%u %s\n",
 		fullname, DRV_VERSION, DRV_RELEASE, copyright);
 
-	wanpipe_wq = create_workqueue("wanpipe_wq");
+	wanpipe_wq = create_workqueue("wanpipe_wq", 0);
 	if (!wanpipe_wq)
 		return -ENOMEM;
 
diff -ruNp 350-workthreads.patch-old/drivers/s390/cio/device.c 350-workthreads.patch-new/drivers/s390/cio/device.c
--- 350-workthreads.patch-old/drivers/s390/cio/device.c	2005-06-20 11:47:03.000000000 +1000
+++ 350-workthreads.patch-new/drivers/s390/cio/device.c	2005-07-04 23:14:18.000000000 +1000
@@ -148,15 +148,16 @@ init_ccw_bus_type (void)
 	init_waitqueue_head(&ccw_device_init_wq);
 	atomic_set(&ccw_device_init_count, 0);
 
-	ccw_device_work = create_singlethread_workqueue("cio");
+	ccw_device_work = create_singlethread_workqueue("cio", 0);
 	if (!ccw_device_work)
 		return -ENOMEM; /* FIXME: better errno ? */
-	ccw_device_notify_work = create_singlethread_workqueue("cio_notify");
+	ccw_device_notify_work = create_singlethread_workqueue("cio_notify",
+			0);
 	if (!ccw_device_notify_work) {
 		ret = -ENOMEM; /* FIXME: better errno ? */
 		goto out_err;
 	}
-	slow_path_wq = create_singlethread_workqueue("kslowcrw");
+	slow_path_wq = create_singlethread_workqueue("kslowcrw", 0);
 	if (!slow_path_wq) {
 		ret = -ENOMEM; /* FIXME: better errno ? */
 		goto out_err;
diff -ruNp 350-workthreads.patch-old/drivers/scsi/hosts.c 350-workthreads.patch-new/drivers/scsi/hosts.c
--- 350-workthreads.patch-old/drivers/scsi/hosts.c	2005-06-20 11:47:04.000000000 +1000
+++ 350-workthreads.patch-new/drivers/scsi/hosts.c	2005-07-04 23:14:18.000000000 +1000
@@ -133,7 +133,7 @@ int scsi_add_host(struct Scsi_Host *shos
 		snprintf(shost->work_q_name, KOBJ_NAME_LEN, "scsi_wq_%d",
 			shost->host_no);
 		shost->work_q = create_singlethread_workqueue(
-					shost->work_q_name);
+					shost->work_q_name, PF_NOFREEZE);
 		if (!shost->work_q)
 			goto out_free_shost_data;
 	}
diff -ruNp 350-workthreads.patch-old/drivers/scsi/libata-core.c 350-workthreads.patch-new/drivers/scsi/libata-core.c
--- 350-workthreads.patch-old/drivers/scsi/libata-core.c	2005-06-20 11:47:05.000000000 +1000
+++ 350-workthreads.patch-new/drivers/scsi/libata-core.c	2005-07-04 23:14:18.000000000 +1000
@@ -4342,7 +4342,7 @@ int pci_test_config_bits(struct pci_dev 
 
 static int __init ata_init(void)
 {
-	ata_wq = create_workqueue("ata");
+	ata_wq = create_workqueue("ata", 0);
 	if (!ata_wq)
 		return -ENOMEM;
 
diff -ruNp 350-workthreads.patch-old/drivers/usb/net/pegasus.c 350-workthreads.patch-new/drivers/usb/net/pegasus.c
--- 350-workthreads.patch-old/drivers/usb/net/pegasus.c	2005-06-20 11:47:09.000000000 +1000
+++ 350-workthreads.patch-new/drivers/usb/net/pegasus.c	2005-07-04 23:14:18.000000000 +1000
@@ -1412,7 +1412,7 @@ static struct usb_driver pegasus_driver 
 static int __init pegasus_init(void)
 {
 	pr_info("%s: %s, " DRIVER_DESC "\n", driver_name, DRIVER_VERSION);
-	pegasus_workqueue = create_singlethread_workqueue("pegasus");
+	pegasus_workqueue = create_singlethread_workqueue("pegasus", PF_NOFREEZE);
 	if (!pegasus_workqueue)
 		return -ENOMEM;
 	return usb_register(&pegasus_driver);
diff -ruNp 350-workthreads.patch-old/fs/aio.c 350-workthreads.patch-new/fs/aio.c
--- 350-workthreads.patch-old/fs/aio.c	2005-06-20 11:47:11.000000000 +1000
+++ 350-workthreads.patch-new/fs/aio.c	2005-07-04 23:14:18.000000000 +1000
@@ -70,7 +70,7 @@ static int __init aio_setup(void)
 	kioctx_cachep = kmem_cache_create("kioctx", sizeof(struct kioctx),
 				0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
-	aio_wq = create_workqueue("aio");
+	aio_wq = create_workqueue("aio", 0);
 
 	pr_debug("aio_setup: sizeof(struct page) = %d\n", (int)sizeof(struct page));
 
diff -ruNp 350-workthreads.patch-old/fs/nfsd/nfs4state.c 350-workthreads.patch-new/fs/nfsd/nfs4state.c
--- 350-workthreads.patch-old/fs/nfsd/nfs4state.c	2005-06-20 11:47:13.000000000 +1000
+++ 350-workthreads.patch-new/fs/nfsd/nfs4state.c	2005-07-04 23:14:18.000000000 +1000
@@ -1356,7 +1356,7 @@ void nfsd_break_deleg_cb(struct file_loc
 	/* XXX need to merge NFSD_LEASE_TIME with fs/locks.c:lease_break_time */
 	fl->fl_break_time = jiffies + NFSD_LEASE_TIME * HZ;
 
-	t = kthread_run(do_recall, dp, "%s", "nfs4_cb_recall");
+	t = kthread_run(do_recall, dp, 0, "%s", "nfs4_cb_recall");
 	if (IS_ERR(t)) {
 		struct nfs4_client *clp = dp->dl_client;
 
diff -ruNp 350-workthreads.patch-old/fs/reiserfs/journal.c 350-workthreads.patch-new/fs/reiserfs/journal.c
--- 350-workthreads.patch-old/fs/reiserfs/journal.c	2005-06-20 11:47:13.000000000 +1000
+++ 350-workthreads.patch-new/fs/reiserfs/journal.c	2005-07-04 23:14:18.000000000 +1000
@@ -2510,7 +2510,7 @@ int journal_init(struct super_block *p_s
 
   reiserfs_mounted_fs_count++ ;
   if (reiserfs_mounted_fs_count <= 1)
-    commit_wq = create_workqueue("reiserfs");
+    commit_wq = create_workqueue("reiserfs", PF_SYNCTHREAD);
 
   INIT_WORK(&journal->j_work, flush_async_commits, p_s_sb);
   return 0 ;
diff -ruNp 350-workthreads.patch-old/fs/xfs/linux-2.6/xfs_buf.c 350-workthreads.patch-new/fs/xfs/linux-2.6/xfs_buf.c
--- 350-workthreads.patch-old/fs/xfs/linux-2.6/xfs_buf.c	2005-07-06 11:14:10.000000000 +1000
+++ 350-workthreads.patch-new/fs/xfs/linux-2.6/xfs_buf.c	2005-07-06 11:14:38.000000000 +1000
@@ -1902,11 +1902,11 @@ pagebuf_daemon_start(void)
 {
 	int		rval;
 
-	pagebuf_logio_workqueue = create_workqueue("xfslogd");
+	pagebuf_logio_workqueue = create_workqueue("xfslogd", PF_SYNCTHREAD);
 	if (!pagebuf_logio_workqueue)
 		return -ENOMEM;
 
-	pagebuf_dataio_workqueue = create_workqueue("xfsdatad");
+	pagebuf_dataio_workqueue = create_workqueue("xfsdatad", PF_SYNCTHREAD);
 	if (!pagebuf_dataio_workqueue) {
 		destroy_workqueue(pagebuf_logio_workqueue);
 		return -ENOMEM;
diff -ruNp 350-workthreads.patch-old/include/linux/kthread.h 350-workthreads.patch-new/include/linux/kthread.h
--- 350-workthreads.patch-old/include/linux/kthread.h	2004-11-03 21:51:12.000000000 +1100
+++ 350-workthreads.patch-new/include/linux/kthread.h	2005-07-04 23:14:18.000000000 +1000
@@ -25,20 +25,26 @@
  */
 struct task_struct *kthread_create(int (*threadfn)(void *data),
 				   void *data,
+				   unsigned long freezer_flags,
 				   const char namefmt[], ...);
 
 /**
  * kthread_run: create and wake a thread.
  * @threadfn: the function to run until signal_pending(current).
  * @data: data ptr for @threadfn.
+ * @freezer_flags: process flags that should be used for freezing.
+ * 	PF_SYNCTHREAD if needed for syncing data to disk.
+ * 	PF_NOFREEZE if also needed for writing the image.
+ * 	0 otherwise.
  * @namefmt: printf-style name for the thread.
  *
  * Description: Convenient wrapper for kthread_create() followed by
  * wake_up_process().  Returns the kthread, or ERR_PTR(-ENOMEM). */
-#define kthread_run(threadfn, data, namefmt, ...)			   \
+#define kthread_run(threadfn, data, freezer_flags, namefmt, ...)	   \
 ({									   \
 	struct task_struct *__k						   \
-		= kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
+		= kthread_create(threadfn, data, freezer_flags, 	   \
+			namefmt, ## __VA_ARGS__);			   \
 	if (!IS_ERR(__k))						   \
 		wake_up_process(__k);					   \
 	__k;								   \
diff -ruNp 350-workthreads.patch-old/include/linux/workqueue.h 350-workthreads.patch-new/include/linux/workqueue.h
--- 350-workthreads.patch-old/include/linux/workqueue.h	2005-06-20 11:47:30.000000000 +1000
+++ 350-workthreads.patch-new/include/linux/workqueue.h	2005-07-04 23:14:18.000000000 +1000
@@ -51,9 +51,10 @@ struct work_struct {
 	} while (0)
 
 extern struct workqueue_struct *__create_workqueue(const char *name,
-						    int singlethread);
-#define create_workqueue(name) __create_workqueue((name), 0)
-#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
+						    int singlethread,
+						    unsigned long freezer_flag);
+#define create_workqueue(name, flags) __create_workqueue((name), 0, flags)
+#define create_singlethread_workqueue(name, flags) __create_workqueue((name), 1, flags)
 
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
diff -ruNp 350-workthreads.patch-old/kernel/kmod.c 350-workthreads.patch-new/kernel/kmod.c
--- 350-workthreads.patch-old/kernel/kmod.c	2004-12-10 14:27:00.000000000 +1100
+++ 350-workthreads.patch-new/kernel/kmod.c	2005-07-04 23:14:18.000000000 +1000
@@ -36,6 +36,7 @@
 #include <linux/mount.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/suspend.h>
 #include <asm/uaccess.h>
 
 extern int max_threads;
@@ -240,6 +241,9 @@ int call_usermodehelper(char *path, char
 	if (!khelper_wq)
 		return -EBUSY;
 
+	if (test_suspend_state(SUSPEND_FREEZER_ON))
+		return -EBUSY;
+
 	if (path[0] == '\0')
 		return 0;
 
@@ -251,6 +255,6 @@ EXPORT_SYMBOL(call_usermodehelper);
 
 void __init usermodehelper_init(void)
 {
-	khelper_wq = create_singlethread_workqueue("khelper");
+	khelper_wq = create_singlethread_workqueue("khelper", 0);
 	BUG_ON(!khelper_wq);
 }
diff -ruNp 350-workthreads.patch-old/kernel/kthread.c 350-workthreads.patch-new/kernel/kthread.c
--- 350-workthreads.patch-old/kernel/kthread.c	2005-07-06 11:14:10.000000000 +1000
+++ 350-workthreads.patch-new/kernel/kthread.c	2005-07-06 11:14:38.000000000 +1000
@@ -25,6 +25,7 @@ struct kthread_create_info
 	/* Information passed to kthread() from keventd. */
 	int (*threadfn)(void *data);
 	void *data;
+	unsigned long freezer_flags;
 	struct completion started;
 
 	/* Result passed back to kthread_create() from keventd. */
@@ -93,6 +94,10 @@ static int kthread(void *_create)
 	current->flags |= flags_used;
 	atomic_set(&(current->freeze_status), 0);
 
+	/* Set our freezer flags */
+	current->flags &= ~(PF_SYNCTHREAD | PF_NOFREEZE);
+	current->flags |= create->freezer_flags;
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	complete(&create->started);
@@ -128,6 +133,7 @@ static void keventd_create_kthread(void 
 
 struct task_struct *kthread_create(int (*threadfn)(void *data),
 				   void *data,
+				   unsigned long freezer_flags,
 				   const char namefmt[],
 				   ...)
 {
@@ -136,6 +142,7 @@ struct task_struct *kthread_create(int (
 
 	create.threadfn = threadfn;
 	create.data = data;
+	create.freezer_flags = freezer_flags;
 	init_completion(&create.started);
 	init_completion(&create.done);
 
@@ -200,7 +207,7 @@ EXPORT_SYMBOL(kthread_stop);
 
 static __init int helper_init(void)
 {
-	helper_wq = create_singlethread_workqueue("kthread");
+	helper_wq = create_singlethread_workqueue("kthread", 0);
 	BUG_ON(!helper_wq);
 
 	return 0;
diff -ruNp 350-workthreads.patch-old/kernel/sched.c 350-workthreads.patch-new/kernel/sched.c
--- 350-workthreads.patch-old/kernel/sched.c	2005-07-06 11:14:10.000000000 +1000
+++ 350-workthreads.patch-new/kernel/sched.c	2005-07-04 23:14:19.000000000 +1000
@@ -4420,10 +4420,10 @@ static int migration_call(struct notifie
 
 	switch (action) {
 	case CPU_UP_PREPARE:
-		p = kthread_create(migration_thread, hcpu, "migration/%d",cpu);
+		p = kthread_create(migration_thread, hcpu, 0,
+				"migration/%d",cpu);
 		if (IS_ERR(p))
 			return NOTIFY_BAD;
-		p->flags |= PF_NOFREEZE;
 		kthread_bind(p, cpu);
 		/* Must be high prio: stop_machine expects to yield to it. */
 		rq = task_rq_lock(p, &flags);
diff -ruNp 350-workthreads.patch-old/kernel/softirq.c 350-workthreads.patch-new/kernel/softirq.c
--- 350-workthreads.patch-old/kernel/softirq.c	2005-06-20 11:47:32.000000000 +1000
+++ 350-workthreads.patch-new/kernel/softirq.c	2005-07-04 23:14:18.000000000 +1000
@@ -350,7 +350,6 @@ void __init softirq_init(void)
 static int ksoftirqd(void * __bind_cpu)
 {
 	set_user_nice(current, 19);
-	current->flags |= PF_NOFREEZE;
 
 	set_current_state(TASK_INTERRUPTIBLE);
 
@@ -456,7 +455,7 @@ static int __devinit cpu_callback(struct
 	case CPU_UP_PREPARE:
 		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
 		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
-		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
+		p = kthread_create(ksoftirqd, hcpu, PF_NOFREEZE, "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
diff -ruNp 350-workthreads.patch-old/kernel/stop_machine.c 350-workthreads.patch-new/kernel/stop_machine.c
--- 350-workthreads.patch-old/kernel/stop_machine.c	2005-06-20 11:47:32.000000000 +1000
+++ 350-workthreads.patch-new/kernel/stop_machine.c	2005-07-04 23:14:18.000000000 +1000
@@ -184,7 +184,7 @@ struct task_struct *__stop_machine_run(i
 	if (cpu == NR_CPUS)
 		cpu = _smp_processor_id();
 
-	p = kthread_create(do_stop, &smdata, "kstopmachine");
+	p = kthread_create(do_stop, &smdata, 0, "kstopmachine");
 	if (!IS_ERR(p)) {
 		kthread_bind(p, cpu);
 		wake_up_process(p);
diff -ruNp 350-workthreads.patch-old/kernel/workqueue.c 350-workthreads.patch-new/kernel/workqueue.c
--- 350-workthreads.patch-old/kernel/workqueue.c	2005-06-20 11:47:32.000000000 +1000
+++ 350-workthreads.patch-new/kernel/workqueue.c	2005-07-04 23:14:18.000000000 +1000
@@ -186,8 +186,6 @@ static int worker_thread(void *__cwq)
 	struct k_sigaction sa;
 	sigset_t blocked;
 
-	current->flags |= PF_NOFREEZE;
-
 	set_user_nice(current, -5);
 
 	/* Block and flush all signals */
@@ -208,6 +206,7 @@ static int worker_thread(void *__cwq)
 			schedule();
 		else
 			__set_current_state(TASK_RUNNING);
+		try_to_freeze();
 		remove_wait_queue(&cwq->more_work, &wait);
 
 		if (!list_empty(&cwq->worklist))
@@ -277,7 +276,8 @@ void fastcall flush_workqueue(struct wor
 }
 
 static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
-						   int cpu)
+						   int cpu,
+						   unsigned long freezer_flags)
 {
 	struct cpu_workqueue_struct *cwq = wq->cpu_wq + cpu;
 	struct task_struct *p;
@@ -292,9 +292,11 @@ static struct task_struct *create_workqu
 	init_waitqueue_head(&cwq->work_done);
 
 	if (is_single_threaded(wq))
-		p = kthread_create(worker_thread, cwq, "%s", wq->name);
+		p = kthread_create(worker_thread, cwq, freezer_flags, 
+				"%s", wq->name);
 	else
-		p = kthread_create(worker_thread, cwq, "%s/%d", wq->name, cpu);
+		p = kthread_create(worker_thread, cwq, freezer_flags,
+				"%s/%d", wq->name, cpu);
 	if (IS_ERR(p))
 		return NULL;
 	cwq->thread = p;
@@ -302,7 +304,8 @@ static struct task_struct *create_workqu
 }
 
 struct workqueue_struct *__create_workqueue(const char *name,
-					    int singlethread)
+					    int singlethread,
+					    unsigned long freezer_flags)
 {
 	int cpu, destroy = 0;
 	struct workqueue_struct *wq;
@@ -320,7 +323,7 @@ struct workqueue_struct *__create_workqu
 	lock_cpu_hotplug();
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, 0);
+		p = create_workqueue_thread(wq, 0, freezer_flags);
 		if (!p)
 			destroy = 1;
 		else
@@ -330,7 +333,7 @@ struct workqueue_struct *__create_workqu
 		list_add(&wq->list, &workqueues);
 		spin_unlock(&workqueue_lock);
 		for_each_online_cpu(cpu) {
-			p = create_workqueue_thread(wq, cpu);
+			p = create_workqueue_thread(wq, cpu, freezer_flags);
 			if (p) {
 				kthread_bind(p, cpu);
 				wake_up_process(p);
@@ -540,7 +543,7 @@ static int __devinit workqueue_cpu_callb
 void init_workqueues(void)
 {
 	hotcpu_notifier(workqueue_cpu_callback, 0);
-	keventd_wq = create_workqueue("events");
+	keventd_wq = create_workqueue("events", PF_NOFREEZE);
 	BUG_ON(!keventd_wq);
 }
 
diff -ruNp 350-workthreads.patch-old/mm/pdflush.c 350-workthreads.patch-new/mm/pdflush.c
--- 350-workthreads.patch-old/mm/pdflush.c	2005-07-06 11:14:10.000000000 +1000
+++ 350-workthreads.patch-new/mm/pdflush.c	2005-07-06 11:14:38.000000000 +1000
@@ -213,7 +213,7 @@ int pdflush_operation(void (*fn)(unsigne
 
 static void start_one_pdflush_thread(void)
 {
-	kthread_run(pdflush, NULL, "pdflush");
+	kthread_run(pdflush, NULL, PF_SYNCTHREAD, "pdflush");
 }
 
 static int __init pdflush_init(void)
diff -ruNp 350-workthreads.patch-old/net/sunrpc/sched.c 350-workthreads.patch-new/net/sunrpc/sched.c
--- 350-workthreads.patch-old/net/sunrpc/sched.c	2005-07-06 11:14:10.000000000 +1000
+++ 350-workthreads.patch-new/net/sunrpc/sched.c	2005-07-04 23:14:18.000000000 +1000
@@ -1007,7 +1007,7 @@ rpciod_up(void)
 	 * Create the rpciod thread and wait for it to start.
 	 */
 	error = -ENOMEM;
-	wq = create_workqueue("rpciod");
+	wq = create_workqueue("rpciod", PF_SYNCTHREAD);
 	if (wq == NULL) {
 		printk(KERN_WARNING "rpciod_up: create workqueue failed, error=%d\n", error);
 		rpciod_users--;
diff -ruNp 350-workthreads.patch-old/sound/i2c/other/ak4114.c 350-workthreads.patch-new/sound/i2c/other/ak4114.c
--- 350-workthreads.patch-old/sound/i2c/other/ak4114.c	2005-06-20 11:47:36.000000000 +1000
+++ 350-workthreads.patch-new/sound/i2c/other/ak4114.c	2005-07-04 23:14:18.000000000 +1000
@@ -106,7 +106,7 @@ int snd_ak4114_create(snd_card_t *card,
 	for (reg = 0; reg < 5; reg++)
 		chip->txcsb[reg] = txcsb[reg];
 
-	chip->workqueue = create_workqueue("snd-ak4114");
+	chip->workqueue = create_workqueue("snd-ak4114", 0);
 	if (chip->workqueue == NULL) {
 		kfree(chip);
 		return -ENOMEM;
diff -ruNp 350-workthreads.patch-old/sound/pci/hda/hda_codec.c 350-workthreads.patch-new/sound/pci/hda/hda_codec.c
--- 350-workthreads.patch-old/sound/pci/hda/hda_codec.c	2005-06-20 11:47:40.000000000 +1000
+++ 350-workthreads.patch-new/sound/pci/hda/hda_codec.c	2005-07-04 23:14:18.000000000 +1000
@@ -291,7 +291,7 @@ static int init_unsol_queue(struct hda_b
 		snd_printk(KERN_ERR "hda_codec: can't allocate unsolicited queue\n");
 		return -ENOMEM;
 	}
-	unsol->workq = create_workqueue("hda_codec");
+	unsol->workq = create_workqueue("hda_codec", 0);
 	if (! unsol->workq) {
 		snd_printk(KERN_ERR "hda_codec: can't create workqueue\n");
 		kfree(unsol);

