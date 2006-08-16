Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWHPMOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWHPMOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWHPMOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:14:05 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:45983 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751146AbWHPMOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:14:03 -0400
Date: Wed, 16 Aug 2006 14:14:00 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20060816121400.GA29406@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/appldata/appldata_base.c |    2 
 arch/s390/mm/init.c                |    6 +-
 drivers/s390/block/dasd.c          |    2 
 drivers/s390/block/dasd_devmap.c   |   84 +++++++++++++++++--------------------
 drivers/s390/block/dasd_eckd.c     |    8 +--
 drivers/s390/block/xpram.c         |   25 -----------
 drivers/s390/char/tape_class.c     |    2 
 drivers/s390/cio/device_fsm.c      |    1 
 drivers/s390/cio/device_ops.c      |    3 +
 9 files changed, 55 insertions(+), 78 deletions(-)

Cornelia Huck:
      [S390] retry after deferred condition code.

Gerald Schaefer:
      [S390] add __cpuinit to appldata_cpu_notify

Heiko Carstens:
      [S390] tape class return value handling.
      [S390] dasd slab cache alignment.
      [S390] kernel page table allocation.

Horst Hummel:
      [S390] dasd set offline kernel bug.
      [S390] dasd calls kzalloc while holding a spinlock.

Martin Schwidefsky:
      [S390] xpram system device class.

Peter Oberparleiter:
      [S390] lost interrupt after chpid vary off/on cycle.
      [S390] inaccessible PAV alias devices on LPAR.

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 6a4b5f9..a0a94e0 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -618,7 +618,7 @@ appldata_offline_cpu(int cpu)
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-static int
+static int __cpuinit
 appldata_cpu_notify(struct notifier_block *self,
 		    unsigned long action, void *hcpu)
 {
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index eb6ebfe..6e6b6de 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -129,7 +129,7 @@ void __init paging_init(void)
                 /*
                  * pg_table is physical at this point
                  */
-		pg_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		pg_table = (pte_t *) alloc_bootmem_pages(PAGE_SIZE);
 
                 pg_dir->pgd0 =  (_PAGE_TABLE | __pa(pg_table));
                 pg_dir->pgd1 =  (_PAGE_TABLE | (__pa(pg_table)+1024));
@@ -219,7 +219,7 @@ void __init paging_init(void)
                         continue;
                 }          
         
-	        pm_dir = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE*4);
+		pm_dir = (pmd_t *) alloc_bootmem_pages(PAGE_SIZE * 4);
                 pgd_populate(&init_mm, pg_dir, pm_dir);
 
                 for (j = 0 ; j < PTRS_PER_PMD ; j++,pm_dir++) {
@@ -228,7 +228,7 @@ void __init paging_init(void)
                                 continue; 
                         }          
                         
-                        pt_dir = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+			pt_dir = (pte_t *) alloc_bootmem_pages(PAGE_SIZE);
                         pmd_populate_kernel(&init_mm, pm_dir, pt_dir);
 	
                         for (k = 0 ; k < PTRS_PER_PTE ; k++,pt_dir++) {
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 4bf03fb..d8e9b95 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1730,8 +1730,8 @@ dasd_flush_request_queue(struct dasd_dev
 		req = elv_next_request(device->request_queue);
 		if (req == NULL)
 			break;
-		dasd_end_request(req, 0);
 		blkdev_dequeue_request(req);
+		dasd_end_request(req, 0);
 	}
 	spin_unlock_irq(&device->request_queue_lock);
 }
diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 7f6fdac..9d0c6e1 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -48,18 +48,20 @@ struct dasd_devmap {
 };
 
 /*
- * dasd_servermap is used to store the server_id of all storage servers
- * accessed by DASD device driver.
+ * dasd_server_ssid_map contains a globally unique storage server subsystem ID.
+ * dasd_server_ssid_list contains the list of all subsystem IDs accessed by
+ * the DASD device driver.
  */
-struct dasd_servermap {
+struct dasd_server_ssid_map {
 	struct list_head list;
 	struct server_id {
 		char vendor[4];
 		char serial[15];
 	} sid;
+	__u16 ssid;
 };
 
-static struct list_head dasd_serverlist;
+static struct list_head dasd_server_ssid_list;
 
 /*
  * Parameter parsing functions for dasd= parameter. The syntax is:
@@ -89,7 +91,7 @@ static char *dasd[256];
 module_param_array(dasd, charp, NULL, 0);
 
 /*
- * Single spinlock to protect devmap structures and lists.
+ * Single spinlock to protect devmap and servermap structures and lists.
  */
 static DEFINE_SPINLOCK(dasd_devmap_lock);
 
@@ -264,8 +266,9 @@ dasd_parse_keyword( char *parsestring ) 
 		if (dasd_page_cache)
 			return residual_str;
 		dasd_page_cache =
-			kmem_cache_create("dasd_page_cache", PAGE_SIZE, 0,
-					  SLAB_CACHE_DMA, NULL, NULL );
+			kmem_cache_create("dasd_page_cache", PAGE_SIZE,
+					  PAGE_SIZE, SLAB_CACHE_DMA,
+					  NULL, NULL );
 		if (!dasd_page_cache)
 			MESSAGE(KERN_WARNING, "%s", "Failed to create slab, "
 				"fixed buffer mode disabled.");
@@ -859,39 +862,6 @@ static struct attribute_group dasd_attr_
 };
 
 /*
- * Check if the related storage server is already contained in the
- * dasd_serverlist. If server is not contained, create new entry.
- * Return 0 if server was already in serverlist,
- *	  1 if the server was added successfully
- *	 <0 in case of error.
- */
-static int
-dasd_add_server(struct dasd_uid *uid)
-{
-	struct dasd_servermap *new, *tmp;
-
-	/* check if server is already contained */
-	list_for_each_entry(tmp, &dasd_serverlist, list)
-	  // normale cmp?
-		if (strncmp(tmp->sid.vendor, uid->vendor,
-			    sizeof(tmp->sid.vendor)) == 0
-		    && strncmp(tmp->sid.serial, uid->serial,
-			       sizeof(tmp->sid.serial)) == 0)
-			return 0;
-
-	new = (struct dasd_servermap *)
-		kzalloc(sizeof(struct dasd_servermap), GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-
-	strncpy(new->sid.vendor, uid->vendor, sizeof(new->sid.vendor));
-	strncpy(new->sid.serial, uid->serial, sizeof(new->sid.serial));
-	list_add(&new->list, &dasd_serverlist);
-	return 1;
-}
-
-
-/*
  * Return copy of the device unique identifier.
  */
 int
@@ -910,6 +880,9 @@ dasd_get_uid(struct ccw_device *cdev, st
 
 /*
  * Register the given device unique identifier into devmap struct.
+ * In addition check if the related storage server subsystem ID is already
+ * contained in the dasd_server_ssid_list. If subsystem ID is not contained,
+ * create new entry.
  * Return 0 if server was already in serverlist,
  *	  1 if the server was added successful
  *	 <0 in case of error.
@@ -918,16 +891,39 @@ int
 dasd_set_uid(struct ccw_device *cdev, struct dasd_uid *uid)
 {
 	struct dasd_devmap *devmap;
-	int rc;
+	struct dasd_server_ssid_map *srv, *tmp;
 
 	devmap = dasd_find_busid(cdev->dev.bus_id);
 	if (IS_ERR(devmap))
 		return PTR_ERR(devmap);
+
+	/* generate entry for server_ssid_map */
+	srv = (struct dasd_server_ssid_map *)
+		kzalloc(sizeof(struct dasd_server_ssid_map), GFP_KERNEL);
+	if (!srv)
+		return -ENOMEM;
+	strncpy(srv->sid.vendor, uid->vendor, sizeof(srv->sid.vendor) - 1);
+	strncpy(srv->sid.serial, uid->serial, sizeof(srv->sid.serial) - 1);
+	srv->ssid = uid->ssid;
+
+	/* server is already contained ? */
 	spin_lock(&dasd_devmap_lock);
 	devmap->uid = *uid;
-	rc = dasd_add_server(uid);
+	list_for_each_entry(tmp, &dasd_server_ssid_list, list) {
+		if (!memcmp(&srv->sid, &tmp->sid,
+			    sizeof(struct dasd_server_ssid_map))) {
+			kfree(srv);
+			srv = NULL;
+			break;
+		}
+	}
+
+	/* add servermap to serverlist */
+	if (srv)
+		list_add(&srv->list, &dasd_server_ssid_list);
 	spin_unlock(&dasd_devmap_lock);
-	return rc;
+
+	return (srv ? 1 : 0);
 }
 EXPORT_SYMBOL_GPL(dasd_set_uid);
 
@@ -995,7 +991,7 @@ dasd_devmap_init(void)
 		INIT_LIST_HEAD(&dasd_hashlists[i]);
 
 	/* Initialize servermap structure. */
-	INIT_LIST_HEAD(&dasd_serverlist);
+	INIT_LIST_HEAD(&dasd_server_ssid_list);
 	return 0;
 }
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 39c2281..957ed5d 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -468,11 +468,11 @@ dasd_eckd_generate_uid(struct dasd_devic
 		return -ENODEV;
 
 	memset(uid, 0, sizeof(struct dasd_uid));
-	strncpy(uid->vendor, confdata->ned1.HDA_manufacturer,
-		sizeof(uid->vendor) - 1);
+	memcpy(uid->vendor, confdata->ned1.HDA_manufacturer,
+	       sizeof(uid->vendor) - 1);
 	EBCASC(uid->vendor, sizeof(uid->vendor) - 1);
-	strncpy(uid->serial, confdata->ned1.HDA_location,
-		sizeof(uid->serial) - 1);
+	memcpy(uid->serial, confdata->ned1.HDA_location,
+	       sizeof(uid->serial) - 1);
 	EBCASC(uid->serial, sizeof(uid->serial) - 1);
 	uid->ssid = confdata->neq.subsystemID;
 	if (confdata->ned2.sneq.flags == 0x40) {
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 1140302..ca7d51f 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -48,15 +48,6 @@ #define PRINT_WARN(x...)	printk(KERN_WAR
 #define PRINT_ERR(x...)		printk(KERN_ERR XPRAM_NAME " error:" x)
 
 
-static struct sysdev_class xpram_sysclass = {
-	set_kset_name("xpram"),
-};
-
-static struct sys_device xpram_sys_device = {
-	.id	= 0,
-	.cls	= &xpram_sysclass,
-}; 
-
 typedef struct {
 	unsigned int	size;		/* size of xpram segment in pages */
 	unsigned int	offset;		/* start page of xpram segment */
@@ -451,8 +442,6 @@ static void __exit xpram_exit(void)
 	}
 	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 	blk_cleanup_queue(xpram_queue);
-	sysdev_unregister(&xpram_sys_device);
-	sysdev_class_unregister(&xpram_sysclass);
 }
 
 static int __init xpram_init(void)
@@ -470,19 +459,7 @@ static int __init xpram_init(void)
 	rc = xpram_setup_sizes(xpram_pages);
 	if (rc)
 		return rc;
-	rc = sysdev_class_register(&xpram_sysclass);
-	if (rc)
-		return rc;
-
-	rc = sysdev_register(&xpram_sys_device);
-	if (rc) {
-		sysdev_class_unregister(&xpram_sysclass);
-		return rc;
-	}
-	rc = xpram_setup_blkdev();
-	if (rc)
-		sysdev_unregister(&xpram_sys_device);
-	return rc;
+	return xpram_setup_blkdev();
 }
 
 module_init(xpram_init);
diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index 643b6d0..56b8761 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -76,7 +76,7 @@ struct tape_class_device *register_tape_
 				device,
 				"%s", tcd->device_name
 			);
-	rc = PTR_ERR(tcd->class_device);
+	rc = IS_ERR(tcd->class_device) ? PTR_ERR(tcd->class_device) : 0;
 	if (rc)
 		goto fail_with_cdev;
 	rc = sysfs_create_link(
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 7a39e0b..6d91c2e 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -772,6 +772,7 @@ ccw_device_online_verify(struct ccw_devi
 	stsch(sch->schid, &sch->schib);
 
 	if (sch->schib.scsw.actl != 0 ||
+	    (sch->schib.scsw.stctl & SCSW_STCTL_STATUS_PEND) ||
 	    (cdev->private->irb.scsw.stctl & SCSW_STCTL_STATUS_PEND)) {
 		/*
 		 * No final status yet or final status not yet delivered
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index a601242..9e3de0b 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -263,6 +263,9 @@ ccw_device_wake_up(struct ccw_device *cd
 	/* Abuse intparm for error reporting. */
 	if (IS_ERR(irb))
 		cdev->private->intparm = -EIO;
+	else if (irb->scsw.cc == 1)
+		/* Retry for deferred condition code. */
+		cdev->private->intparm = -EAGAIN;
 	else if ((irb->scsw.dstat !=
 		  (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
 		 (irb->scsw.cstat != 0)) {
