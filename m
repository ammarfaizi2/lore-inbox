Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVFAMe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVFAMe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVFAMe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:34:59 -0400
Received: from [203.171.93.254] ([203.171.93.254]:58859 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261365AbVFAMck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:32:40 -0400
Subject: Freezer Patches.
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="=-WJ7CSqcBbxDg0aXuvUXo"
Organization: Cycades
Message-Id: <1117629212.10328.26.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 01 Jun 2005 22:33:32 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WJ7CSqcBbxDg0aXuvUXo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Pavel.

Here are the freezer patches. They were prepared against rc3, but I
think they still apply fine against rc5. (Ben, these are the same ones I
sent you the other day).

Regards,

Nigel


--=-WJ7CSqcBbxDg0aXuvUXo
Content-Disposition: attachment; filename=300-workthreads.patch
Content-Type: text/x-patch; name=300-workthreads.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -ruNp 210-workthreads.patch-old/drivers/acpi/osl.c 210-workthreads.patch-new/drivers/acpi/osl.c
--- 210-workthreads.patch-old/drivers/acpi/osl.c	2005-04-22 23:32:09.000000000 +1000
+++ 210-workthreads.patch-new/drivers/acpi/osl.c	2005-05-02 13:53:32.000000000 +1000
@@ -95,7 +95,7 @@ acpi_os_initialize1(void)
 		return AE_NULL_ENTRY;
 	}
 #endif
-	kacpid_wq = create_singlethread_workqueue("kacpid");
+	kacpid_wq = create_singlethread_workqueue("kacpid", PF_NOFREEZE);
 	BUG_ON(!kacpid_wq);
 
 	return AE_OK;
diff -ruNp 210-workthreads.patch-old/drivers/block/ll_rw_blk.c 210-workthreads.patch-new/drivers/block/ll_rw_blk.c
--- 210-workthreads.patch-old/drivers/block/ll_rw_blk.c	2005-04-22 23:32:09.000000000 +1000
+++ 210-workthreads.patch-new/drivers/block/ll_rw_blk.c	2005-05-02 13:53:32.000000000 +1000
@@ -3266,7 +3266,7 @@ EXPORT_SYMBOL(kblockd_flush);
 
 int __init blk_dev_init(void)
 {
-	kblockd_workqueue = create_workqueue("kblockd");
+	kblockd_workqueue = create_workqueue("kblockd", PF_NOFREEZE);
 	if (!kblockd_workqueue)
 		panic("Failed to create kblockd\n");
 
diff -ruNp 210-workthreads.patch-old/drivers/block/pktcdvd.c 210-workthreads.patch-new/drivers/block/pktcdvd.c
--- 210-workthreads.patch-old/drivers/block/pktcdvd.c	2005-04-22 23:32:09.000000000 +1000
+++ 210-workthreads.patch-new/drivers/block/pktcdvd.c	2005-05-02 13:53:32.000000000 +1000
@@ -2366,7 +2366,7 @@ static int pkt_new_dev(struct pktcdvd_de
 	pkt_init_queue(pd);
 
 	atomic_set(&pd->cdrw.pending_bios, 0);
-	pd->cdrw.thread = kthread_run(kcdrwd, pd, "%s", pd->name);
+	pd->cdrw.thread = kthread_run(kcdrwd, pd, 0, "%s", pd->name);
 	if (IS_ERR(pd->cdrw.thread)) {
 		printk("pktcdvd: can't start kernel thread\n");
 		ret = -ENOMEM;
diff -ruNp 210-workthreads.patch-old/drivers/char/hvc_console.c 210-workthreads.patch-new/drivers/char/hvc_console.c
--- 210-workthreads.patch-old/drivers/char/hvc_console.c	2005-02-03 22:33:25.000000000 +1100
+++ 210-workthreads.patch-new/drivers/char/hvc_console.c	2005-05-02 13:53:32.000000000 +1000
@@ -709,7 +709,7 @@ int __init hvc_init(void)
 
 	/* Always start the kthread because there can be hotplug vty adapters
 	 * added later. */
-	hvc_task = kthread_run(khvcd, NULL, "khvcd");
+	hvc_task = kthread_run(khvcd, NULL, PF_NOFREEZE, "khvcd");
 	if (IS_ERR(hvc_task)) {
 		panic("Couldn't create kthread for console.\n");
 		put_tty_driver(hvc_driver);
diff -ruNp 210-workthreads.patch-old/drivers/char/hvcs.c 210-workthreads.patch-new/drivers/char/hvcs.c
--- 210-workthreads.patch-old/drivers/char/hvcs.c	2005-02-14 09:05:25.000000000 +1100
+++ 210-workthreads.patch-new/drivers/char/hvcs.c	2005-05-02 13:53:32.000000000 +1000
@@ -1403,7 +1403,7 @@ static int __init hvcs_module_init(void)
 		return -ENOMEM;
 	}
 
-	hvcs_task = kthread_run(khvcsd, NULL, "khvcsd");
+	hvcs_task = kthread_run(khvcsd, NULL, PF_NOFREEZE, "khvcsd");
 	if (IS_ERR(hvcs_task)) {
 		printk(KERN_ERR "HVCS: khvcsd creation failed.  Driver not loaded.\n");
 		kfree(hvcs_pi_buff);
diff -ruNp 210-workthreads.patch-old/drivers/infiniband/core/fmr_pool.c 210-workthreads.patch-new/drivers/infiniband/core/fmr_pool.c
--- 210-workthreads.patch-old/drivers/infiniband/core/fmr_pool.c	2005-04-22 23:32:11.000000000 +1000
+++ 210-workthreads.patch-new/drivers/infiniband/core/fmr_pool.c	2005-05-02 13:53:32.000000000 +1000
@@ -266,6 +266,7 @@ struct ib_fmr_pool *ib_create_fmr_pool(s
 
 	pool->thread = kthread_create(ib_fmr_cleanup_thread,
 				      pool,
+				      0,
 				      "ib_fmr(%s)",
 				      device->name);
 	if (IS_ERR(pool->thread)) {
diff -ruNp 210-workthreads.patch-old/drivers/infiniband/core/mad.c 210-workthreads.patch-new/drivers/infiniband/core/mad.c
--- 210-workthreads.patch-old/drivers/infiniband/core/mad.c	2005-04-22 23:32:11.000000000 +1000
+++ 210-workthreads.patch-new/drivers/infiniband/core/mad.c	2005-05-02 13:53:32.000000000 +1000
@@ -2502,7 +2502,7 @@ static int ib_mad_port_open(struct ib_de
 		goto error7;
 
 	snprintf(name, sizeof name, "ib_mad%d", port_num);
-	port_priv->wq = create_singlethread_workqueue(name);
+	port_priv->wq = create_singlethread_workqueue(name, 0);
 	if (!port_priv->wq) {
 		ret = -ENOMEM;
 		goto error8;
diff -ruNp 210-workthreads.patch-old/drivers/infiniband/ulp/ipoib/ipoib_main.c 210-workthreads.patch-new/drivers/infiniband/ulp/ipoib/ipoib_main.c
--- 210-workthreads.patch-old/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-04-22 23:32:11.000000000 +1000
+++ 210-workthreads.patch-new/drivers/infiniband/ulp/ipoib/ipoib_main.c	2005-05-02 13:53:32.000000000 +1000
@@ -1070,7 +1070,7 @@ static int __init ipoib_init_module(void
 	 * so flush_scheduled_work() can deadlock during device
 	 * removal.
 	 */
-	ipoib_workqueue = create_singlethread_workqueue("ipoib");
+	ipoib_workqueue = create_singlethread_workqueue("ipoib", 0);
 	if (!ipoib_workqueue) {
 		ret = -ENOMEM;
 		goto err_fs;
diff -ruNp 210-workthreads.patch-old/drivers/macintosh/therm_adt746x.c 210-workthreads.patch-new/drivers/macintosh/therm_adt746x.c
--- 210-workthreads.patch-old/drivers/macintosh/therm_adt746x.c	2005-04-22 23:32:12.000000000 +1000
+++ 210-workthreads.patch-new/drivers/macintosh/therm_adt746x.c	2005-05-02 13:53:32.000000000 +1000
@@ -438,7 +438,7 @@ static int attach_one_thermostat(struct 
 		write_both_fan_speed(th, -1);
 	}
 	
-	thread_therm = kthread_run(monitor_task, th, "kfand");
+	thread_therm = kthread_run(monitor_task, th, 0, "kfand");
 
 	if (thread_therm == ERR_PTR(-ENOMEM)) {
 		printk(KERN_INFO "adt746x: Kthread creation failed\n");
diff -ruNp 210-workthreads.patch-old/drivers/md/dm-crypt.c 210-workthreads.patch-new/drivers/md/dm-crypt.c
--- 210-workthreads.patch-old/drivers/md/dm-crypt.c	2005-04-22 23:32:12.000000000 +1000
+++ 210-workthreads.patch-new/drivers/md/dm-crypt.c	2005-05-02 13:53:32.000000000 +1000
@@ -936,7 +936,7 @@ static int __init dm_crypt_init(void)
 	if (!_crypt_io_pool)
 		return -ENOMEM;
 
-	_kcryptd_workqueue = create_workqueue("kcryptd");
+	_kcryptd_workqueue = create_workqueue("kcryptd", PF_NOFREEZE);
 	if (!_kcryptd_workqueue) {
 		r = -ENOMEM;
 		DMERR(PFX "couldn't create kcryptd");
diff -ruNp 210-workthreads.patch-old/drivers/md/dm-raid1.c 210-workthreads.patch-new/drivers/md/dm-raid1.c
--- 210-workthreads.patch-old/drivers/md/dm-raid1.c	2005-04-22 23:32:12.000000000 +1000
+++ 210-workthreads.patch-new/drivers/md/dm-raid1.c	2005-05-02 13:53:32.000000000 +1000
@@ -1229,7 +1229,7 @@ static int __init dm_mirror_init(void)
 	if (r)
 		return r;
 
-	_kmirrord_wq = create_workqueue("kmirrord");
+	_kmirrord_wq = create_workqueue("kmirrord", PF_SYNCTHREAD);
 	if (!_kmirrord_wq) {
 		DMERR("couldn't start kmirrord");
 		dm_dirty_log_exit();
diff -ruNp 210-workthreads.patch-old/drivers/md/kcopyd.c 210-workthreads.patch-new/drivers/md/kcopyd.c
--- 210-workthreads.patch-old/drivers/md/kcopyd.c	2005-02-03 22:33:28.000000000 +1100
+++ 210-workthreads.patch-new/drivers/md/kcopyd.c	2005-05-02 13:53:32.000000000 +1000
@@ -609,7 +609,7 @@ static int kcopyd_init(void)
 		return r;
 	}
 
-	_kcopyd_wq = create_singlethread_workqueue("kcopyd");
+	_kcopyd_wq = create_singlethread_workqueue("kcopyd", PF_SYNCTHREAD);
 	if (!_kcopyd_wq) {
 		jobs_exit();
 		up(&kcopyd_init_lock);
diff -ruNp 210-workthreads.patch-old/drivers/media/video/cx88/cx88-video.c 210-workthreads.patch-new/drivers/media/video/cx88/cx88-video.c
--- 210-workthreads.patch-old/drivers/media/video/cx88/cx88-video.c	2005-04-22 23:32:12.000000000 +1000
+++ 210-workthreads.patch-new/drivers/media/video/cx88/cx88-video.c	2005-05-02 13:53:32.000000000 +1000
@@ -2121,7 +2121,7 @@ static int __devinit cx8800_initdev(stru
 
 	/* start tvaudio thread */
 	if (core->tuner_type != TUNER_ABSENT)
-		core->kthread = kthread_run(cx88_audio_thread, core, "cx88 tvaudio");
+		core->kthread = kthread_run(cx88_audio_thread, core, 0, "cx88 tvaudio");
 	return 0;
 
 fail_unreg:
diff -ruNp 210-workthreads.patch-old/drivers/media/video/msp3400.c 210-workthreads.patch-new/drivers/media/video/msp3400.c
--- 210-workthreads.patch-old/drivers/media/video/msp3400.c	2005-04-22 23:32:12.000000000 +1000
+++ 210-workthreads.patch-new/drivers/media/video/msp3400.c	2005-05-02 13:53:32.000000000 +1000
@@ -1555,7 +1555,7 @@ static int msp_attach(struct i2c_adapter
 
 	/* startup control thread if needed */
 	if (thread_func) {
-		msp->kthread = kthread_run(thread_func, c, "msp34xx");
+		msp->kthread = kthread_run(thread_func, c, 0, "msp34xx");
 		if (NULL == msp->kthread)
 			printk(KERN_WARNING "msp34xx: kernel_thread() failed\n");
 		msp_wake_thread(c);
diff -ruNp 210-workthreads.patch-old/drivers/media/video/video-buf-dvb.c 210-workthreads.patch-new/drivers/media/video/video-buf-dvb.c
--- 210-workthreads.patch-old/drivers/media/video/video-buf-dvb.c	2005-02-03 22:33:29.000000000 +1100
+++ 210-workthreads.patch-new/drivers/media/video/video-buf-dvb.c	2005-05-02 13:53:32.000000000 +1000
@@ -104,7 +104,7 @@ static int videobuf_dvb_start_feed(struc
 	if (NULL != dvb->thread)
 		goto out;
 	dvb->thread = kthread_run(videobuf_dvb_thread,
-				  dvb, "%s dvb", dvb->name);
+				  dvb, 0, "%s dvb", dvb->name);
 	if (IS_ERR(dvb->thread)) {
 		rc = PTR_ERR(dvb->thread);
 		dvb->thread = NULL;
diff -ruNp 210-workthreads.patch-old/drivers/message/i2o/driver.c 210-workthreads.patch-new/drivers/message/i2o/driver.c
--- 210-workthreads.patch-old/drivers/message/i2o/driver.c	2005-02-03 22:33:29.000000000 +1100
+++ 210-workthreads.patch-new/drivers/message/i2o/driver.c	2005-05-02 13:53:32.000000000 +1000
@@ -79,7 +79,7 @@ int i2o_driver_register(struct i2o_drive
 	pr_debug("i2o: Register driver %s\n", drv->name);
 
 	if (drv->event) {
-		drv->event_queue = create_workqueue(drv->name);
+		drv->event_queue = create_workqueue(drv->name, 0);
 		if (!drv->event_queue) {
 			printk(KERN_ERR "i2o: Could not initialize event queue "
 			       "for driver %s\n", drv->name);
diff -ruNp 210-workthreads.patch-old/drivers/net/wan/sdlamain.c 210-workthreads.patch-new/drivers/net/wan/sdlamain.c
--- 210-workthreads.patch-old/drivers/net/wan/sdlamain.c	2004-11-03 21:54:35.000000000 +1100
+++ 210-workthreads.patch-new/drivers/net/wan/sdlamain.c	2005-05-02 13:53:32.000000000 +1000
@@ -240,7 +240,7 @@ static int __init wanpipe_init(void)
 	printk(KERN_INFO "%s v%u.%u %s\n",
 		fullname, DRV_VERSION, DRV_RELEASE, copyright);
 
-	wanpipe_wq = create_workqueue("wanpipe_wq");
+	wanpipe_wq = create_workqueue("wanpipe_wq", 0);
 	if (!wanpipe_wq)
 		return -ENOMEM;
 
diff -ruNp 210-workthreads.patch-old/drivers/s390/cio/device.c 210-workthreads.patch-new/drivers/s390/cio/device.c
--- 210-workthreads.patch-old/drivers/s390/cio/device.c	2005-04-22 23:32:15.000000000 +1000
+++ 210-workthreads.patch-new/drivers/s390/cio/device.c	2005-05-02 13:53:32.000000000 +1000
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
diff -ruNp 210-workthreads.patch-old/drivers/scsi/hosts.c 210-workthreads.patch-new/drivers/scsi/hosts.c
--- 210-workthreads.patch-old/drivers/scsi/hosts.c	2005-04-22 23:32:16.000000000 +1000
+++ 210-workthreads.patch-new/drivers/scsi/hosts.c	2005-05-02 13:53:32.000000000 +1000
@@ -133,7 +133,7 @@ int scsi_add_host(struct Scsi_Host *shos
 		snprintf(shost->work_q_name, KOBJ_NAME_LEN, "scsi_wq_%d",
 			shost->host_no);
 		shost->work_q = create_singlethread_workqueue(
-					shost->work_q_name);
+					shost->work_q_name, PF_NOFREEZE);
 		if (!shost->work_q)
 			goto out_free_shost_data;
 	}
diff -ruNp 210-workthreads.patch-old/drivers/scsi/libata-core.c 210-workthreads.patch-new/drivers/scsi/libata-core.c
--- 210-workthreads.patch-old/drivers/scsi/libata-core.c	2005-04-22 23:32:16.000000000 +1000
+++ 210-workthreads.patch-new/drivers/scsi/libata-core.c	2005-05-02 13:53:32.000000000 +1000
@@ -3951,7 +3951,7 @@ int pci_test_config_bits(struct pci_dev 
 
 static int __init ata_init(void)
 {
-	ata_wq = create_workqueue("ata");
+	ata_wq = create_workqueue("ata", 0);
 	if (!ata_wq)
 		return -ENOMEM;
 
diff -ruNp 210-workthreads.patch-old/drivers/usb/net/pegasus.c 210-workthreads.patch-new/drivers/usb/net/pegasus.c
--- 210-workthreads.patch-old/drivers/usb/net/pegasus.c	2005-04-22 23:32:18.000000000 +1000
+++ 210-workthreads.patch-new/drivers/usb/net/pegasus.c	2005-05-02 13:53:32.000000000 +1000
@@ -1412,7 +1412,7 @@ static struct usb_driver pegasus_driver 
 static int __init pegasus_init(void)
 {
 	pr_info("%s: %s, " DRIVER_DESC "\n", driver_name, DRIVER_VERSION);
-	pegasus_workqueue = create_singlethread_workqueue("pegasus");
+	pegasus_workqueue = create_singlethread_workqueue("pegasus", PF_NOFREEZE);
 	if (!pegasus_workqueue)
 		return -ENOMEM;
 	return usb_register(&pegasus_driver);
diff -ruNp 210-workthreads.patch-old/fs/aio.c 210-workthreads.patch-new/fs/aio.c
--- 210-workthreads.patch-old/fs/aio.c	2005-04-22 23:32:19.000000000 +1000
+++ 210-workthreads.patch-new/fs/aio.c	2005-05-02 13:53:32.000000000 +1000
@@ -73,7 +73,7 @@ static int __init aio_setup(void)
 	kioctx_cachep = kmem_cache_create("kioctx", sizeof(struct kioctx),
 				0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
 
-	aio_wq = create_workqueue("aio");
+	aio_wq = create_workqueue("aio", 0);
 
 	pr_debug("aio_setup: sizeof(struct page) = %d\n", (int)sizeof(struct page));
 
diff -ruNp 210-workthreads.patch-old/fs/nfsd/nfs4state.c 210-workthreads.patch-new/fs/nfsd/nfs4state.c
--- 210-workthreads.patch-old/fs/nfsd/nfs4state.c	2005-04-22 23:32:19.000000000 +1000
+++ 210-workthreads.patch-new/fs/nfsd/nfs4state.c	2005-05-02 13:53:32.000000000 +1000
@@ -1356,7 +1356,7 @@ void nfsd_break_deleg_cb(struct file_loc
 	/* XXX need to merge NFSD_LEASE_TIME with fs/locks.c:lease_break_time */
 	fl->fl_break_time = jiffies + NFSD_LEASE_TIME * HZ;
 
-	t = kthread_run(do_recall, dp, "%s", "nfs4_cb_recall");
+	t = kthread_run(do_recall, dp, 0, "%s", "nfs4_cb_recall");
 	if (IS_ERR(t)) {
 		struct nfs4_client *clp = dp->dl_client;
 
diff -ruNp 210-workthreads.patch-old/fs/reiserfs/journal.c 210-workthreads.patch-new/fs/reiserfs/journal.c
--- 210-workthreads.patch-old/fs/reiserfs/journal.c	2005-04-22 23:32:19.000000000 +1000
+++ 210-workthreads.patch-new/fs/reiserfs/journal.c	2005-05-02 13:53:32.000000000 +1000
@@ -2512,7 +2512,7 @@ int journal_init(struct super_block *p_s
 
   reiserfs_mounted_fs_count++ ;
   if (reiserfs_mounted_fs_count <= 1)
-    commit_wq = create_workqueue("reiserfs");
+    commit_wq = create_workqueue("reiserfs", PF_SYNCTHREAD);
 
   INIT_WORK(&journal->j_work, flush_async_commits, p_s_sb);
   return 0 ;
diff -ruNp 210-workthreads.patch-old/fs/xfs/linux-2.6/xfs_buf.c 210-workthreads.patch-new/fs/xfs/linux-2.6/xfs_buf.c
--- 210-workthreads.patch-old/fs/xfs/linux-2.6/xfs_buf.c	2005-04-22 23:32:19.000000000 +1000
+++ 210-workthreads.patch-new/fs/xfs/linux-2.6/xfs_buf.c	2005-05-02 13:53:53.000000000 +1000
@@ -1895,11 +1895,11 @@ pagebuf_daemon_start(void)
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
diff -ruNp 210-workthreads.patch-old/include/linux/kthread.h 210-workthreads.patch-new/include/linux/kthread.h
--- 210-workthreads.patch-old/include/linux/kthread.h	2004-11-03 21:51:12.000000000 +1100
+++ 210-workthreads.patch-new/include/linux/kthread.h	2005-05-02 13:53:32.000000000 +1000
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
diff -ruNp 210-workthreads.patch-old/include/linux/workqueue.h 210-workthreads.patch-new/include/linux/workqueue.h
--- 210-workthreads.patch-old/include/linux/workqueue.h	2005-04-22 23:32:24.000000000 +1000
+++ 210-workthreads.patch-new/include/linux/workqueue.h	2005-05-02 13:53:32.000000000 +1000
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
 
diff -ruNp 210-workthreads.patch-old/kernel/kmod.c 210-workthreads.patch-new/kernel/kmod.c
--- 210-workthreads.patch-old/kernel/kmod.c	2004-12-10 14:27:00.000000000 +1100
+++ 210-workthreads.patch-new/kernel/kmod.c	2005-05-02 13:53:32.000000000 +1000
@@ -251,6 +251,6 @@ EXPORT_SYMBOL(call_usermodehelper);
 
 void __init usermodehelper_init(void)
 {
-	khelper_wq = create_singlethread_workqueue("khelper");
+	khelper_wq = create_singlethread_workqueue("khelper", 0);
 	BUG_ON(!khelper_wq);
 }
diff -ruNp 210-workthreads.patch-old/kernel/kthread.c 210-workthreads.patch-new/kernel/kthread.c
--- 210-workthreads.patch-old/kernel/kthread.c	2005-02-03 22:33:50.000000000 +1100
+++ 210-workthreads.patch-new/kernel/kthread.c	2005-05-02 13:53:32.000000000 +1000
@@ -25,6 +25,7 @@ struct kthread_create_info
 	/* Information passed to kthread() from keventd. */
 	int (*threadfn)(void *data);
 	void *data;
+	unsigned long freezer_flags;
 	struct completion started;
 
 	/* Result passed back to kthread_create() from keventd. */
@@ -86,6 +87,10 @@ static int kthread(void *_create)
 	/* By default we can run anywhere, unlike keventd. */
 	set_cpus_allowed(current, CPU_MASK_ALL);
 
+	/* Set our freezer flags */
+	current->flags &= ~(PF_SYNCTHREAD | PF_NOFREEZE);
+	current->flags |= create->freezer_flags;
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_INTERRUPTIBLE);
 	complete(&create->started);
@@ -121,6 +126,7 @@ static void keventd_create_kthread(void 
 
 struct task_struct *kthread_create(int (*threadfn)(void *data),
 				   void *data,
+				   unsigned long freezer_flags,
 				   const char namefmt[],
 				   ...)
 {
@@ -129,6 +135,7 @@ struct task_struct *kthread_create(int (
 
 	create.threadfn = threadfn;
 	create.data = data;
+	create.freezer_flags = freezer_flags;
 	init_completion(&create.started);
 	init_completion(&create.done);
 
@@ -193,7 +200,7 @@ EXPORT_SYMBOL(kthread_stop);
 
 static __init int helper_init(void)
 {
-	helper_wq = create_singlethread_workqueue("kthread");
+	helper_wq = create_singlethread_workqueue("kthread", 0);
 	BUG_ON(!helper_wq);
 
 	return 0;
diff -ruNp 210-workthreads.patch-old/kernel/sched.c 210-workthreads.patch-new/kernel/sched.c
--- 210-workthreads.patch-old/kernel/sched.c	2005-04-22 23:32:24.000000000 +1000
+++ 210-workthreads.patch-new/kernel/sched.c	2005-05-02 13:53:32.000000000 +1000
@@ -4379,10 +4379,10 @@ static int migration_call(struct notifie
 
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
diff -ruNp 210-workthreads.patch-old/kernel/softirq.c 210-workthreads.patch-new/kernel/softirq.c
--- 210-workthreads.patch-old/kernel/softirq.c	2005-04-22 23:32:24.000000000 +1000
+++ 210-workthreads.patch-new/kernel/softirq.c	2005-05-02 13:53:32.000000000 +1000
@@ -350,7 +350,6 @@ void __init softirq_init(void)
 static int ksoftirqd(void * __bind_cpu)
 {
 	set_user_nice(current, 19);
-	current->flags |= PF_NOFREEZE;
 
 	set_current_state(TASK_INTERRUPTIBLE);
 
@@ -364,6 +363,8 @@ static int ksoftirqd(void * __bind_cpu)
 
 		__set_current_state(TASK_RUNNING);
 
+		try_to_freeze(PF_FREEZE);
+
 		while (local_softirq_pending()) {
 			/* Preempt disable stops cpu going offline.
 			   If already offline, we'll be on wrong CPU:
@@ -456,7 +457,7 @@ static int __devinit cpu_callback(struct
 	case CPU_UP_PREPARE:
 		BUG_ON(per_cpu(tasklet_vec, hotcpu).list);
 		BUG_ON(per_cpu(tasklet_hi_vec, hotcpu).list);
-		p = kthread_create(ksoftirqd, hcpu, "ksoftirqd/%d", hotcpu);
+		p = kthread_create(ksoftirqd, hcpu, PF_NOFREEZE, "ksoftirqd/%d", hotcpu);
 		if (IS_ERR(p)) {
 			printk("ksoftirqd for %i failed\n", hotcpu);
 			return NOTIFY_BAD;
diff -ruNp 210-workthreads.patch-old/kernel/stop_machine.c 210-workthreads.patch-new/kernel/stop_machine.c
--- 210-workthreads.patch-old/kernel/stop_machine.c	2005-04-22 23:32:24.000000000 +1000
+++ 210-workthreads.patch-new/kernel/stop_machine.c	2005-05-02 13:53:32.000000000 +1000
@@ -184,7 +184,7 @@ struct task_struct *__stop_machine_run(i
 	if (cpu == NR_CPUS)
 		cpu = _smp_processor_id();
 
-	p = kthread_create(do_stop, &smdata, "kstopmachine");
+	p = kthread_create(do_stop, &smdata, 0, "kstopmachine");
 	if (!IS_ERR(p)) {
 		kthread_bind(p, cpu);
 		wake_up_process(p);
diff -ruNp 210-workthreads.patch-old/kernel/workqueue.c 210-workthreads.patch-new/kernel/workqueue.c
--- 210-workthreads.patch-old/kernel/workqueue.c	2005-04-22 23:32:24.000000000 +1000
+++ 210-workthreads.patch-new/kernel/workqueue.c	2005-05-02 13:53:32.000000000 +1000
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
+		try_to_freeze(PF_FREEZE);
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
 
diff -ruNp 210-workthreads.patch-old/mm/pdflush.c 210-workthreads.patch-new/mm/pdflush.c
--- 210-workthreads.patch-old/mm/pdflush.c	2005-02-03 22:33:50.000000000 +1100
+++ 210-workthreads.patch-new/mm/pdflush.c	2005-05-02 13:53:53.000000000 +1000
@@ -213,7 +213,7 @@ int pdflush_operation(void (*fn)(unsigne
 
 static void start_one_pdflush_thread(void)
 {
-	kthread_run(pdflush, NULL, "pdflush");
+	kthread_run(pdflush, NULL, PF_SYNCTHREAD, "pdflush");
 }
 
 static int __init pdflush_init(void)
diff -ruNp 210-workthreads.patch-old/net/sunrpc/sched.c 210-workthreads.patch-new/net/sunrpc/sched.c
--- 210-workthreads.patch-old/net/sunrpc/sched.c	2005-04-22 23:32:26.000000000 +1000
+++ 210-workthreads.patch-new/net/sunrpc/sched.c	2005-05-02 13:53:32.000000000 +1000
@@ -1003,7 +1003,7 @@ rpciod_up(void)
 	 * Create the rpciod thread and wait for it to start.
 	 */
 	error = -ENOMEM;
-	wq = create_workqueue("rpciod");
+	wq = create_workqueue("rpciod", 0);
 	if (wq == NULL) {
 		printk(KERN_WARNING "rpciod_up: create workqueue failed, error=%d\n", error);
 		rpciod_users--;

--=-WJ7CSqcBbxDg0aXuvUXo
Content-Disposition: attachment; filename=301-refrigerator.patch
Content-Type: text/x-patch; name=301-refrigerator.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -ruNp 211-refrigerator.patch-old/include/linux/sched.h 211-refrigerator.patch-new/include/linux/sched.h
--- 211-refrigerator.patch-old/include/linux/sched.h	2005-04-22 23:32:23.000000000 +1000
+++ 211-refrigerator.patch-new/include/linux/sched.h	2005-05-02 16:53:47.000000000 +1000
@@ -1248,6 +1248,7 @@ extern void normalize_rt_tasks(void);
 extern void refrigerator(unsigned long);
 extern int freeze_processes(void);
 extern void thaw_processes(void);
+extern unsigned int refrigerator_on;
 
 static inline int try_to_freeze(unsigned long refrigerator_flags)
 {
@@ -1261,6 +1262,7 @@ static inline int try_to_freeze(unsigned
 static inline void refrigerator(unsigned long flag) {}
 static inline int freeze_processes(void) { BUG(); return 0; }
 static inline void thaw_processes(void) {}
+#define refrigerator_on (0)
 
 static inline int try_to_freeze(unsigned long refrigerator_flags)
 {
diff -ruNp 211-refrigerator.patch-old/kernel/exit.c 211-refrigerator.patch-new/kernel/exit.c
--- 211-refrigerator.patch-old/kernel/exit.c	2005-05-02 16:53:40.000000000 +1000
+++ 211-refrigerator.patch-new/kernel/exit.c	2005-05-02 16:13:38.000000000 +1000
@@ -789,6 +789,8 @@ fastcall NORET_TYPE void do_exit(long co
 		panic("Attempted to kill init!");
 	if (tsk->io_context)
 		exit_io_context();
+	if (unlikely(refrigerator_on))
+		refrigerator(0);
 
 	if (unlikely(current->ptrace & PT_TRACE_EXIT)) {
 		current->ptrace_message = code;
diff -ruNp 211-refrigerator.patch-old/kernel/fork.c 211-refrigerator.patch-new/kernel/fork.c
--- 211-refrigerator.patch-old/kernel/fork.c	2005-04-22 23:32:24.000000000 +1000
+++ 211-refrigerator.patch-new/kernel/fork.c	2005-05-02 16:13:38.000000000 +1000
@@ -1200,6 +1200,9 @@ long do_fork(unsigned long clone_flags,
 	int trace = 0;
 	long pid = alloc_pidmap();
 
+	if (unlikely(refrigerator_on))
+		refrigerator(0);
+
 	if (pid < 0)
 		return -EAGAIN;
 	if (unlikely(current->ptrace)) {
diff -ruNp 211-refrigerator.patch-old/kernel/kmod.c 211-refrigerator.patch-new/kernel/kmod.c
--- 211-refrigerator.patch-old/kernel/kmod.c	2005-05-02 16:53:40.000000000 +1000
+++ 211-refrigerator.patch-new/kernel/kmod.c	2005-05-02 16:13:38.000000000 +1000
@@ -237,7 +237,7 @@ int call_usermodehelper(char *path, char
 	};
 	DECLARE_WORK(work, __call_usermodehelper, &sub_info);
 
-	if (!khelper_wq)
+	if ((!khelper_wq) || (refrigerator_on))
 		return -EBUSY;
 
 	if (path[0] == '\0')
diff -ruNp 211-refrigerator.patch-old/kernel/power/process.c 211-refrigerator.patch-new/kernel/power/process.c
--- 211-refrigerator.patch-old/kernel/power/process.c	2004-12-10 14:26:31.000000000 +1100
+++ 211-refrigerator.patch-new/kernel/power/process.c	2005-05-02 16:49:35.000000000 +1000
@@ -1,121 +1,317 @@
 /*
- * drivers/power/process.c - Functions for starting/stopping processes on 
- *                           suspend transitions.
+ * kernel/power/process.c
  *
- * Originally from swsusp.
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Freeze_and_free contains the routines software suspend uses to freeze other
+ * processes during the suspend cycle. 
+ *
+ * Under high I/O load, we need to be careful about the order in which we
+ * freeze processes. If we freeze processes in the wrong order, we could
+ * deadlock others. The freeze_order array this specifies the order in which
+ * critical processes are frozen. All others are suspended after these have
+ * entered the refrigerator.
+ *
+ * Other processes on an SMP system have been taken care of already when we
+ * use these routines. We assume there are no races or locking issues.
  */
 
+#include <linux/module.h>
+//#include <linux/suspend.h>
+#include <asm/tlbflush.h>
+#include <linux/sched.h>
+
+unsigned int refrigerator_on = 0;
 
-#undef DEBUG
+static unsigned int sync_freeze = 0;
 
-#include <linux/smp_lock.h>
-#include <linux/interrupt.h>
-#include <linux/suspend.h>
-#include <linux/module.h>
+atomic_t __nosavedata suspend_cpu_counter = { 0 }; 
 
-/* 
- * Timeout for stopping processes
- */
-#define TIMEOUT	(6 * HZ)
+/* Timeouts when freezing */
+#define FREEZER_TOTAL_TIMEOUT (5 * HZ)
+#define FREEZER_CHECK_TIMEOUT (HZ / 10)
 
+/**
+ * refrigerator - idle routine for frozen processes
+ * @flag: unsigned long, non zero if signals to be flushed.
+ *
+ * A routine for threads which should not do work during suspend
+ * to enter and spin in until the process is finished.
+ */
 
-static inline int freezeable(struct task_struct * p)
+void refrigerator(unsigned long flag)
 {
-	if ((p == current) || 
+	unsigned long flags;
+	long save;
+	
+	if (unlikely(current->flags & PF_NOFREEZE)) {
+		current->flags &= ~PF_FREEZE;
+		spin_lock_irqsave(&current->sighand->siglock, flags);
+		recalc_sigpending();
+		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		return;
+	}
+
+	/* You need correct to work with real-time processes.
+	   OTOH, this way one process may see (via /proc/) some other
+	   process in stopped state (and thereby discovered we were
+	   suspended. We probably do not care). 
+	 */
+	if ((flag) && (current->flags & PF_FREEZE)) {
+
+		spin_lock_irqsave(&current->sighand->siglock, flags);
+		recalc_sigpending();
+		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	}
+
+	if (refrigerator_on) {
+		save = current->state;
+		current->flags |= PF_FROZEN;
+		while (current->flags & PF_FROZEN) {
+			current->state = TASK_STOPPED;
+			schedule();
+			if (flag) {
+				spin_lock_irqsave(
+					&current->sighand->siglock, flags);
+				recalc_sigpending();
+				spin_unlock_irqrestore(
+					&current->sighand->siglock, flags);
+			}
+		}
+		current->state = save;
+	}
+	current->flags &= ~PF_FREEZE;
+	spin_lock_irqsave(&current->sighand->siglock, flags);
+	recalc_sigpending();
+	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+}
+
+/*
+ * to_be_frozen
+ *
+ * Description:	Determine whether a process should be frozen yet.
+ * Parameters:	struct task_struct *	The process to consider.
+ * 		int			Which group of processes to consider.
+ * Returns:	int			0 if don't freeze yet, otherwise do.
+ */
+static int to_be_frozen(struct task_struct * p, int type_being_frozen) {
+
+	if ((p == current) ||
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
 	    (p->exit_state == EXIT_DEAD) ||
 	    (p->state == TASK_STOPPED) ||
 	    (p->state == TASK_TRACED))
 		return 0;
+	if ((!(p->mm)) && (type_being_frozen < 3))
+		return 0;
+	if ((p->flags & PF_SYNCTHREAD) && (type_being_frozen == 1))
+		return 0;
+	if ((p->state == TASK_UNINTERRUPTIBLE) && (type_being_frozen == 3))
+		return 0;
 	return 1;
 }
 
-/* Refrigerator is place where frozen processes are stored :-). */
-void refrigerator(unsigned long flag)
-{
-	/* Hmm, should we be allowed to suspend when there are realtime
-	   processes around? */
-	long save;
-	save = current->state;
-	current->state = TASK_UNINTERRUPTIBLE;
-	pr_debug("%s entered refrigerator\n", current->comm);
-	printk("=");
-	current->flags &= ~PF_FREEZE;
+/*
+ * num_to_be_frozen
+ *
+ * Description:	Determine how many processes of our type are still to be
+ * 		frozen. As a side effect, update the progress bar too.
+ * Parameters:	int	Which type we are trying to freeze.
+ */
+static int num_to_be_frozen(int type_being_frozen) {
+	
+	struct task_struct *p, *g;
+	int todo_this_type = 0, total_todo = 0;
+	int total_threads = 0;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (to_be_frozen(p, type_being_frozen)) {
+			todo_this_type++;
+			total_todo++;
+		} else if (to_be_frozen(p, 3))
+			total_todo++;
+		total_threads++;
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
 
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending(); /* We sent fake signal, clean it up */
-	spin_unlock_irq(&current->sighand->siglock);
-
-	current->flags |= PF_FROZEN;
-	while (current->flags & PF_FROZEN)
-		schedule();
-	pr_debug("%s left refrigerator\n", current->comm);
-	current->state = save;
+	return todo_this_type;
 }
 
-/* 0 = success, else # of processes that we failed to stop */
-int freeze_processes(void)
+/*
+ * freeze_threads
+ *
+ * Freeze a set of threads.
+ *
+ * Types:
+ * 1: User threads not syncing.
+ * 2: Remaining user threads.
+ * 3: Kernel threads.
+ */
+
+static int freeze_threads(int type)
 {
-       int todo;
-       unsigned long start_time;
-	struct task_struct *g, *p;
-	
-	printk( "Stopping tasks: " );
-	start_time = jiffies;
+	struct task_struct *p, *g;
+	unsigned long start_time = jiffies;
+	int result = 0, still_to_do;
+
 	do {
-		todo = 0;
+		int numsignalled = 0;
+
+		preempt_disable();
+
+		local_irq_disable();
+
 		read_lock(&tasklist_lock);
+
+		/*
+		 * Signal the processes.
+		 *
+		 * We signal them every time through. Otherwise pdflush -
+		 * and maybe other processes - might never enter the
+		 * fridge.
+		 *
+		 * NB: We're inside an SMP pause. Our printks are unsafe.
+		 * They're only here for debugging.
+		 *
+		 */
+		
 		do_each_thread(g, p) {
 			unsigned long flags;
-			if (!freezeable(p))
-				continue;
-			if ((p->flags & PF_FROZEN) ||
-			    (p->state == TASK_TRACED) ||
-			    (p->state == TASK_STOPPED))
+			if (!to_be_frozen(p, type))
 				continue;
-
-			/* FIXME: smp problem here: we may not access other process' flags
-			   without locking */
+			
+			numsignalled++;
 			p->flags |= PF_FREEZE;
 			spin_lock_irqsave(&p->sighand->siglock, flags);
 			signal_wake_up(p, 0);
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			todo++;
 		} while_each_thread(g, p);
+
 		read_unlock(&tasklist_lock);
-		yield();			/* Yield is okay here */
-		if (time_after(jiffies, start_time + TIMEOUT)) {
-			printk( "\n" );
-			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
-			return todo;
-		}
-	} while(todo);
+
+		preempt_enable();
+
+		local_irq_enable();
+		
+		/*
+		 * Sleep.
+		 */
+		set_task_state(current, TASK_INTERRUPTIBLE);
+		schedule_timeout(FREEZER_CHECK_TIMEOUT);
+
+		still_to_do = num_to_be_frozen(type);
+	} while(still_to_do && !time_after(jiffies, start_time + FREEZER_TOTAL_TIMEOUT));
+
+	/*
+	 * Did we time out? See if we failed to freeze processes as well.
+	 *
+	 */
+	if ((time_after(jiffies, start_time + FREEZER_TOTAL_TIMEOUT)) && (still_to_do)) {
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p) {
+			if (!to_be_frozen(p, type)) 
+				continue;
+			
+			if (!result) {
+				printk(KERN_ERR	"Stopping tasks failed.\n");
+				printk(KERN_ERR "Tasks that refused to be "
+				 "refrigerated and haven't since exited:\n");
+				result = 1;
+			}
+			
+			if (p->flags & PF_FREEZE) {
+				printk(" - %s (#%d) signalled but "
+					"didn't enter refrigerator.\n",
+					p->comm, p->pid);
+			} else
+				printk(" - %s (#%d) wasn't "
+					"signalled.\n",
+					p->comm, p->pid);
+		} while_each_thread(g, p);
+		read_unlock(&tasklist_lock);
+
+		show_state();
+	}
+	
+	return result;
+}
+
+/*
+ * freeze_processes - Freeze processes prior to saving an image of memory.
+ * 
+ * Return value: 0 = success, else # of processes that we failed to stop.
+ */
+extern asmlinkage long sys_sync(void);
+
+/* Freeze_processes.
+ * Debugging output is still printed.
+ */
+int freeze_processes(void)
+{
+	int showidlelist, result = 0;
+
+	showidlelist = 1;
+
+	refrigerator_on = 1;
+
+	/* First, freeze all userspace,	non syncing threads. */
+	if (freeze_threads(1))
+		goto aborting;
 	
-	printk( "|\n" );
-	BUG_ON(in_atomic());
-	return 0;
+	/* Now freeze processes that were syncing and are still running */
+	if (freeze_threads(2))
+		goto aborting;
+
+	/* Now do our own sync, just in case one wasn't running already */
+	sys_sync();
+
+	sync_freeze = 1;
+
+	/* Freeze kernel threads */
+	if (freeze_threads(3))
+		goto aborting;
+
+out:
+	return result;
+
+aborting:
+	result = -1;
+	thaw_processes();
+	goto out;
 }
 
 void thaw_processes(void)
 {
-	struct task_struct *g, *p;
+	struct task_struct *p, *g;
+	
+	sync_freeze = 0;
+	refrigerator_on = 0;
+	
+	preempt_disable();
+	
+	local_irq_disable();
 
-	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
+
 	do_each_thread(g, p) {
-		if (!freezeable(p))
-			continue;
 		if (p->flags & PF_FROZEN) {
 			p->flags &= ~PF_FROZEN;
 			wake_up_process(p);
-		} else
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+		}
 	} while_each_thread(g, p);
 
 	read_unlock(&tasklist_lock);
-	schedule();
-	printk( " done\n" );
+
+	preempt_enable();
+
+	local_irq_enable();
 }
 
 EXPORT_SYMBOL(refrigerator);

--=-WJ7CSqcBbxDg0aXuvUXo
Content-Disposition: attachment; filename=304-syncthreads
Content-Type: text/x-patch; name=304-syncthreads; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -ruNp 214-syncthreads-old/fs/buffer.c 214-syncthreads-new/fs/buffer.c
--- 214-syncthreads-old/fs/buffer.c	2005-04-22 23:32:19.000000000 +1000
+++ 214-syncthreads-new/fs/buffer.c	2005-05-02 14:50:03.000000000 +1000
@@ -171,6 +171,10 @@ EXPORT_SYMBOL(sync_blockdev);
  */
 int fsync_super(struct super_block *sb)
 {
+	int ret;
+
+	current->flags |= PF_SYNCTHREAD;
+
 	sync_inodes_sb(sb, 0);
 	DQUOT_SYNC(sb);
 	lock_super(sb);
@@ -182,7 +186,10 @@ int fsync_super(struct super_block *sb)
 	sync_blockdev(sb->s_bdev);
 	sync_inodes_sb(sb, 1);
 
-	return sync_blockdev(sb->s_bdev);
+	ret = sync_blockdev(sb->s_bdev);
+
+	current->flags &= ~PF_SYNCTHREAD;
+	return ret;
 }
 
 /*
@@ -193,12 +200,19 @@ int fsync_super(struct super_block *sb)
 int fsync_bdev(struct block_device *bdev)
 {
 	struct super_block *sb = get_super(bdev);
+	int ret;
+
+	current->flags |= PF_SYNCTHREAD;
+
 	if (sb) {
 		int res = fsync_super(sb);
 		drop_super(sb);
+		current->flags &= ~PF_SYNCTHREAD;
 		return res;
 	}
-	return sync_blockdev(bdev);
+	ret = sync_blockdev(bdev);
+	current->flags &= ~PF_SYNCTHREAD;
+	return ret;
 }
 
 /**
@@ -278,6 +292,8 @@ EXPORT_SYMBOL(thaw_bdev);
  */
 static void do_sync(unsigned long wait)
 {
+	current->flags |= PF_SYNCTHREAD;
+
 	wakeup_bdflush(0);
 	sync_inodes(0);		/* All mappings, inodes and their blockdevs */
 	DQUOT_SYNC(NULL);
@@ -289,6 +305,8 @@ static void do_sync(unsigned long wait)
 		printk("Emergency Sync complete\n");
 	if (unlikely(laptop_mode))
 		laptop_sync_completion();
+
+	current->flags &= ~PF_SYNCTHREAD;
 }
 
 asmlinkage long sys_sync(void)
@@ -314,6 +332,8 @@ int file_fsync(struct file *filp, struct
 	struct super_block * sb;
 	int ret, err;
 
+	current->flags |= PF_SYNCTHREAD;
+
 	/* sync the inode to buffers */
 	ret = write_inode_now(inode, 0);
 
@@ -328,6 +348,8 @@ int file_fsync(struct file *filp, struct
 	err = sync_blockdev(sb->s_bdev);
 	if (!ret)
 		ret = err;
+
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
@@ -337,6 +359,8 @@ asmlinkage long sys_fsync(unsigned int f
 	struct address_space *mapping;
 	int ret, err;
 
+	current->flags |= PF_SYNCTHREAD;
+
 	ret = -EBADF;
 	file = fget(fd);
 	if (!file)
@@ -370,6 +394,7 @@ asmlinkage long sys_fsync(unsigned int f
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
@@ -379,6 +404,8 @@ asmlinkage long sys_fdatasync(unsigned i
 	struct address_space *mapping;
 	int ret, err;
 
+	current->flags |= PF_SYNCTHREAD;
+
 	ret = -EBADF;
 	file = fget(fd);
 	if (!file)
@@ -405,6 +432,7 @@ asmlinkage long sys_fdatasync(unsigned i
 out_putf:
 	fput(file);
 out:
+	current->flags &= ~PF_SYNCTHREAD;
 	return ret;
 }
 
diff -ruNp 214-syncthreads-old/fs/jbd/journal.c 214-syncthreads-new/fs/jbd/journal.c
--- 214-syncthreads-old/fs/jbd/journal.c	2005-04-22 23:32:19.000000000 +1000
+++ 214-syncthreads-new/fs/jbd/journal.c	2005-05-02 14:50:03.000000000 +1000
@@ -130,6 +130,7 @@ int kjournald(void *arg)
 	current_journal = journal;
 
 	daemonize("kjournald");
+	current->flags |= PF_SYNCTHREAD;
 
 	/* Set up an interval timer which can be used to trigger a
            commit wakeup after the commit interval expires */
diff -ruNp 214-syncthreads-old/fs/jffs/intrep.c 214-syncthreads-new/fs/jffs/intrep.c
--- 214-syncthreads-old/fs/jffs/intrep.c	2005-04-22 23:32:19.000000000 +1000
+++ 214-syncthreads-new/fs/jffs/intrep.c	2005-05-02 14:50:03.000000000 +1000
@@ -3364,6 +3364,7 @@ jffs_garbage_collect_thread(void *ptr)
 	D1(int i = 1);
 
 	daemonize("jffs_gcd");
+	current->flags |= PF_SYNCTHREAD;
 
 	c->gc_task = current;
 
@@ -3399,6 +3400,9 @@ jffs_garbage_collect_thread(void *ptr)
 			siginfo_t info;
 			unsigned long signr = 0;
 
+			if (try_to_freeze(PF_FREEZE))
+				continue;
+
 			spin_lock_irq(&current->sighand->siglock);
 			signr = dequeue_signal(current, &current->blocked, &info);
 			spin_unlock_irq(&current->sighand->siglock);
diff -ruNp 214-syncthreads-old/fs/jfs/jfs_logmgr.c 214-syncthreads-new/fs/jfs/jfs_logmgr.c
--- 214-syncthreads-old/fs/jfs/jfs_logmgr.c	2005-04-22 23:32:19.000000000 +1000
+++ 214-syncthreads-new/fs/jfs/jfs_logmgr.c	2005-05-02 14:50:03.000000000 +1000
@@ -2321,6 +2321,7 @@ int jfsIOWait(void *arg)
 	struct lbuf *bp;
 
 	daemonize("jfsIO");
+	current->flags |= PF_SYNCTHREAD;
 
 	complete(&jfsIOwait);
 
diff -ruNp 214-syncthreads-old/fs/jfs/jfs_txnmgr.c 214-syncthreads-new/fs/jfs/jfs_txnmgr.c
--- 214-syncthreads-old/fs/jfs/jfs_txnmgr.c	2005-04-22 23:32:19.000000000 +1000
+++ 214-syncthreads-new/fs/jfs/jfs_txnmgr.c	2005-05-02 14:50:03.000000000 +1000
@@ -47,7 +47,6 @@
 #include <linux/vmalloc.h>
 #include <linux/smp_lock.h>
 #include <linux/completion.h>
-#include <linux/suspend.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include "jfs_incore.h"
@@ -2750,6 +2749,7 @@ int jfs_lazycommit(void *arg)
 	struct jfs_sb_info *sbi;
 
 	daemonize("jfsCommit");
+	current->flags |= PF_SYNCTHREAD;
 
 	complete(&jfsIOwait);
 
diff -ruNp 214-syncthreads-old/fs/lockd/clntlock.c 214-syncthreads-new/fs/lockd/clntlock.c
--- 214-syncthreads-old/fs/lockd/clntlock.c	2004-11-03 21:55:00.000000000 +1100
+++ 214-syncthreads-new/fs/lockd/clntlock.c	2005-05-02 14:50:03.000000000 +1000
@@ -200,6 +200,7 @@ reclaimer(void *ptr)
 	struct inode *inode;
 
 	daemonize("%s-reclaim", host->h_name);
+	current->flags |= PF_SYNCTHREAD;
 	allow_signal(SIGKILL);
 
 	/* This one ensures that our parent doesn't terminate while the
@@ -222,6 +223,7 @@ restart:
 
 		fl->fl_u.nfs_fl.flags &= ~NFS_LCK_RECLAIM;
 		nlmclnt_reclaim(host, fl);
+		try_to_freeze(PF_FREEZE);
 		if (signalled())
 			break;
 		goto restart;
diff -ruNp 214-syncthreads-old/fs/lockd/svc.c 214-syncthreads-new/fs/lockd/svc.c
--- 214-syncthreads-old/fs/lockd/svc.c	2005-04-22 23:32:19.000000000 +1000
+++ 214-syncthreads-new/fs/lockd/svc.c	2005-05-02 14:50:03.000000000 +1000
@@ -115,6 +115,7 @@ lockd(struct svc_rqst *rqstp)
 	up(&lockd_start);
 
 	daemonize("lockd");
+	current->flags |= PF_SYNCTHREAD;
 
 	/* Process request with signals blocked, but allow SIGKILL.  */
 	allow_signal(SIGKILL);
@@ -138,6 +139,8 @@ lockd(struct svc_rqst *rqstp)
 	while ((nlmsvc_users || !signalled()) && nlmsvc_pid == current->pid) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
 
+		try_to_freeze(PF_SYNCTHREAD);
+
 		if (signalled()) {
 			flush_signals(current);
 			if (nlmsvc_ops) {
diff -ruNp 214-syncthreads-old/fs/nfsd/nfssvc.c 214-syncthreads-new/fs/nfsd/nfssvc.c
--- 214-syncthreads-old/fs/nfsd/nfssvc.c	2005-04-22 23:32:19.000000000 +1000
+++ 214-syncthreads-new/fs/nfsd/nfssvc.c	2005-05-02 14:50:03.000000000 +1000
@@ -182,6 +182,7 @@ nfsd(struct svc_rqst *rqstp)
 	/* Lock module and set up kernel thread */
 	lock_kernel();
 	daemonize("nfsd");
+	current->flags |= PF_SYNCTHREAD;
 
 	/* After daemonize() this kernel thread shares current->fs
 	 * with the init process. We need to create files with a
diff -ruNp 214-syncthreads-old/fs/xfs/linux-2.6/xfs_buf.c 214-syncthreads-new/fs/xfs/linux-2.6/xfs_buf.c
--- 214-syncthreads-old/fs/xfs/linux-2.6/xfs_buf.c	2005-05-02 15:39:36.000000000 +1000
+++ 214-syncthreads-new/fs/xfs/linux-2.6/xfs_buf.c	2005-05-02 14:50:03.000000000 +1000
@@ -1770,7 +1770,7 @@ pagebuf_daemon(
 
 	/*  Set up the thread  */
 	daemonize("xfsbufd");
-	current->flags |= PF_MEMALLOC;
+	current->flags |= PF_MEMALLOC | PF_SYNCTHREAD;
 
 	pagebuf_daemon_task = current;
 	pagebuf_daemon_active = 1;
diff -ruNp 214-syncthreads-old/fs/xfs/linux-2.6/xfs_super.c 214-syncthreads-new/fs/xfs/linux-2.6/xfs_super.c
--- 214-syncthreads-old/fs/xfs/linux-2.6/xfs_super.c	2005-04-22 23:32:19.000000000 +1000
+++ 214-syncthreads-new/fs/xfs/linux-2.6/xfs_super.c	2005-05-02 14:50:03.000000000 +1000
@@ -471,6 +471,7 @@ xfssyncd(
 	struct vfs_sync_work	*work, *n;
 
 	daemonize("xfssyncd");
+	current->flags |= PF_SYNCTHREAD;
 
 	vfsp->vfs_sync_work.w_vfs = vfsp;
 	vfsp->vfs_sync_work.w_syncer = vfs_sync_worker;
diff -ruNp 214-syncthreads-old/include/linux/sched.h 214-syncthreads-new/include/linux/sched.h
--- 214-syncthreads-old/include/linux/sched.h	2005-05-02 15:39:37.000000000 +1000
+++ 214-syncthreads-new/include/linux/sched.h	2005-05-02 15:19:04.000000000 +1000
@@ -788,6 +788,8 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 #define PF_RANDOMIZE	0x00800000	/* randomize virtual address space */
+#define PF_SYNCTHREAD	0x01000000	/* this thread can start activity during the 
++ 					   early part of freezing processes */
 
 /*
  * Only the _current_ task can read/write to tsk->flags, but other
diff -ruNp 214-syncthreads-old/mm/pdflush.c 214-syncthreads-new/mm/pdflush.c
--- 214-syncthreads-old/mm/pdflush.c	2005-05-02 15:39:37.000000000 +1000
+++ 214-syncthreads-new/mm/pdflush.c	2005-05-02 14:50:03.000000000 +1000
@@ -89,7 +89,7 @@ struct pdflush_work {
 
 static int __pdflush(struct pdflush_work *my_work)
 {
-	current->flags |= PF_FLUSHER;
+	current->flags |= (PF_FLUSHER | PF_SYNCTHREAD);
 	my_work->fn = NULL;
 	my_work->who = current;
 	INIT_LIST_HEAD(&my_work->list);

--=-WJ7CSqcBbxDg0aXuvUXo--

