Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWGRL7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWGRL7K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 07:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWGRL7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 07:59:10 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:14840 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751324AbWGRL7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 07:59:09 -0400
Date: Tue, 18 Jul 2006 13:59:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20060718115913.GA22988@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 arch/s390/kernel/head31.S      |    4 +--
 arch/s390/kernel/head64.S      |    4 +--
 arch/s390/kernel/setup.c       |   46 ++++++++++++++++++++++++++++--------
 drivers/s390/block/xpram.c     |   17 +++++++++++--
 drivers/s390/char/raw3270.c    |   52 +++++++++++++++++++++++++++--------------
 drivers/s390/char/tape_class.c |   10 +++++++
 drivers/s390/char/tape_core.c  |   18 ++++++++------
 drivers/s390/cio/cmf.c         |    1 
 drivers/s390/net/ctcmain.c     |   21 +++++++++++++---
 drivers/s390/net/qeth_main.c   |    7 +++--
 include/asm-s390/system.h      |    9 +++++--
 include/asm-s390/timex.h       |    4 +--
 12 files changed, 140 insertions(+), 53 deletions(-)

Andreas Krebbel:
      [S390] get_clock inline assembly.

Cornelia Huck:
      [S390] channel measurement interval display.

Heiko Carstens:
      [S390] Fix gcc warning about unused return values.
      [S390] xpram module parameter parsing - take 2.
      [S390] .align 4096 statements in head.S
      [S390] sysfs_create_xxx return values.

diff --git a/arch/s390/kernel/head31.S b/arch/s390/kernel/head31.S
index d00de17..a4dc61f 100644
--- a/arch/s390/kernel/head31.S
+++ b/arch/s390/kernel/head31.S
@@ -273,7 +273,7 @@ #
 .Lbss_end:  .long _end
 .Lparmaddr: .long PARMAREA
 .Lsccbaddr: .long .Lsccb
-	.align	4096
+	.org	0x12000
 .Lsccb:
 	.hword	0x1000			# length, one page
 	.byte	0x00,0x00,0x00
@@ -290,7 +290,7 @@ #
 .Lscpincr2:
 	.quad	0x00
 	.fill	3984,1,0
-	.align	4096
+	.org	0x13000
 
 #ifdef CONFIG_SHARED_KERNEL
 	.org	0x100000
diff --git a/arch/s390/kernel/head64.S b/arch/s390/kernel/head64.S
index 47744fc..9d80c5b 100644
--- a/arch/s390/kernel/head64.S
+++ b/arch/s390/kernel/head64.S
@@ -268,7 +268,7 @@ #
 .Lparmaddr:
 	.quad	PARMAREA
 
-	.align 4096
+	.org	0x12000
 .Lsccb:
 	.hword 0x1000			# length, one page
 	.byte 0x00,0x00,0x00
@@ -285,7 +285,7 @@ #
 .Lscpincr2:
 	.quad 0x00
 	.fill 3984,1,0
-	.align 4096
+	.org	0x13000
 
 #ifdef CONFIG_SHARED_KERNEL
 	.org   0x100000
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 1ca34f5..c902f05 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -877,31 +877,57 @@ static struct bin_attribute ipl_scp_data
 
 static decl_subsys(ipl, NULL, NULL);
 
+static int ipl_register_fcp_files(void)
+{
+	int rc;
+
+	rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+				&ipl_fcp_attr_group);
+	if (rc)
+		goto out;
+	rc = sysfs_create_bin_file(&ipl_subsys.kset.kobj,
+				   &ipl_parameter_attr);
+	if (rc)
+		goto out_ipl_parm;
+	rc = sysfs_create_bin_file(&ipl_subsys.kset.kobj,
+				   &ipl_scp_data_attr);
+	if (!rc)
+		goto out;
+
+	sysfs_remove_bin_file(&ipl_subsys.kset.kobj, &ipl_parameter_attr);
+
+out_ipl_parm:
+	sysfs_remove_group(&ipl_subsys.kset.kobj, &ipl_fcp_attr_group);
+out:
+	return rc;
+}
+
 static int __init
 ipl_device_sysfs_register(void) {
 	int rc;
 
 	rc = firmware_register(&ipl_subsys);
 	if (rc)
-		return rc;
+		goto out;
 
 	switch (get_ipl_type()) {
 	case ipl_type_ccw:
-		sysfs_create_group(&ipl_subsys.kset.kobj, &ipl_ccw_attr_group);
+		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+					&ipl_ccw_attr_group);
 		break;
 	case ipl_type_fcp:
-		sysfs_create_group(&ipl_subsys.kset.kobj, &ipl_fcp_attr_group);
-		sysfs_create_bin_file(&ipl_subsys.kset.kobj,
-				      &ipl_parameter_attr);
-		sysfs_create_bin_file(&ipl_subsys.kset.kobj,
-				      &ipl_scp_data_attr);
+		rc = ipl_register_fcp_files();
 		break;
 	default:
-		sysfs_create_group(&ipl_subsys.kset.kobj,
-				   &ipl_unknown_attr_group);
+		rc = sysfs_create_group(&ipl_subsys.kset.kobj,
+					&ipl_unknown_attr_group);
 		break;
 	}
-	return 0;
+
+	if (rc)
+		firmware_unregister(&ipl_subsys);
+out:
+	return rc;
 }
 
 __initcall(ipl_device_sysfs_register);
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
index 4cd879c..1140302 100644
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -304,6 +304,7 @@ static int __init xpram_setup_sizes(unsi
 {
 	unsigned long mem_needed;
 	unsigned long mem_auto;
+	unsigned long long size;
 	int mem_auto_no;
 	int i;
 
@@ -321,9 +322,19 @@ static int __init xpram_setup_sizes(unsi
 	mem_needed = 0;
 	mem_auto_no = 0;
 	for (i = 0; i < xpram_devs; i++) {
-		if (sizes[i])
-			xpram_sizes[i] =
-				(memparse(sizes[i], &sizes[i]) + 3) & -4UL;
+		if (sizes[i]) {
+			size = simple_strtoull(sizes[i], &sizes[i], 0);
+			switch (sizes[i][0]) {
+			case 'g':
+			case 'G':
+				size <<= 20;
+				break;
+			case 'm':
+			case 'M':
+				size <<= 10;
+			}
+			xpram_sizes[i] = (size + 3) & -4UL;
+		}
 		if (xpram_sizes[i])
 			mem_needed += xpram_sizes[i];
 		else
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 95e285b..7a84014 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1106,10 +1106,10 @@ raw3270_delete_device(struct raw3270 *rp
 
 	/* Remove from device chain. */
 	mutex_lock(&raw3270_mutex);
-	if (rp->clttydev)
+	if (rp->clttydev && !IS_ERR(rp->clttydev))
 		class_device_destroy(class3270,
 				     MKDEV(IBM_TTY3270_MAJOR, rp->minor));
-	if (rp->cltubdev)
+	if (rp->cltubdev && !IS_ERR(rp->cltubdev))
 		class_device_destroy(class3270,
 				     MKDEV(IBM_FS3270_MAJOR, rp->minor));
 	list_del_init(&rp->list);
@@ -1173,21 +1173,37 @@ static struct attribute_group raw3270_at
 	.attrs = raw3270_attrs,
 };
 
-static void
-raw3270_create_attributes(struct raw3270 *rp)
+static int raw3270_create_attributes(struct raw3270 *rp)
 {
-	//FIXME: check return code
-	sysfs_create_group(&rp->cdev->dev.kobj, &raw3270_attr_group);
-	rp->clttydev =
-		class_device_create(class3270, NULL,
-				    MKDEV(IBM_TTY3270_MAJOR, rp->minor),
-				    &rp->cdev->dev, "tty%s",
-				    rp->cdev->dev.bus_id);
-	rp->cltubdev =
-		class_device_create(class3270, NULL,
-				    MKDEV(IBM_FS3270_MAJOR, rp->minor),
-				    &rp->cdev->dev, "tub%s",
-				    rp->cdev->dev.bus_id);
+	int rc;
+
+	rc = sysfs_create_group(&rp->cdev->dev.kobj, &raw3270_attr_group);
+	if (rc)
+		goto out;
+
+	rp->clttydev = class_device_create(class3270, NULL,
+					   MKDEV(IBM_TTY3270_MAJOR, rp->minor),
+					   &rp->cdev->dev, "tty%s",
+					   rp->cdev->dev.bus_id);
+	if (IS_ERR(rp->clttydev)) {
+		rc = PTR_ERR(rp->clttydev);
+		goto out_ttydev;
+	}
+
+	rp->cltubdev = class_device_create(class3270, NULL,
+					   MKDEV(IBM_FS3270_MAJOR, rp->minor),
+					   &rp->cdev->dev, "tub%s",
+					   rp->cdev->dev.bus_id);
+	if (!IS_ERR(rp->cltubdev))
+		goto out;
+
+	rc = PTR_ERR(rp->cltubdev);
+	class_device_destroy(class3270, MKDEV(IBM_TTY3270_MAJOR, rp->minor));
+
+out_ttydev:
+	sysfs_remove_group(&rp->cdev->dev.kobj, &raw3270_attr_group);
+out:
+	return rc;
 }
 
 /*
@@ -1255,7 +1271,9 @@ raw3270_set_online (struct ccw_device *c
 	rc = raw3270_reset_device(rp);
 	if (rc)
 		goto failure;
-	raw3270_create_attributes(rp);
+	rc = raw3270_create_attributes(rp);
+	if (rc)
+		goto failure;
 	set_bit(RAW3270_FLAGS_READY, &rp->flags);
 	mutex_lock(&raw3270_mutex);
 	list_for_each_entry(np, &raw3270_notifier, list)
diff --git a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
index a5c68e6..643b6d0 100644
--- a/drivers/s390/char/tape_class.c
+++ b/drivers/s390/char/tape_class.c
@@ -76,14 +76,22 @@ struct tape_class_device *register_tape_
 				device,
 				"%s", tcd->device_name
 			);
-	sysfs_create_link(
+	rc = PTR_ERR(tcd->class_device);
+	if (rc)
+		goto fail_with_cdev;
+	rc = sysfs_create_link(
 		&device->kobj,
 		&tcd->class_device->kobj,
 		tcd->mode_name
 	);
+	if (rc)
+		goto fail_with_class_device;
 
 	return tcd;
 
+fail_with_class_device:
+	class_device_destroy(tape_class, tcd->char_device->dev);
+
 fail_with_cdev:
 	cdev_del(tcd->char_device);
 
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index 122b4d8..2826aed 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -543,20 +543,24 @@ int
 tape_generic_probe(struct ccw_device *cdev)
 {
 	struct tape_device *device;
+	int ret;
 
 	device = tape_alloc_device();
 	if (IS_ERR(device))
 		return -ENODEV;
-	PRINT_INFO("tape device %s found\n", cdev->dev.bus_id);
+	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
+	ret = sysfs_create_group(&cdev->dev.kobj, &tape_attr_group);
+	if (ret) {
+		tape_put_device(device);
+		PRINT_ERR("probe failed for tape device %s\n", cdev->dev.bus_id);
+		return ret;
+	}
 	cdev->dev.driver_data = device;
+	cdev->handler = __tape_do_irq;
 	device->cdev = cdev;
 	device->cdev_id = busid_to_int(cdev->dev.bus_id);
-	cdev->handler = __tape_do_irq;
-
-	ccw_device_set_options(cdev, CCWDEV_DO_PATHGROUP);
-	sysfs_create_group(&cdev->dev.kobj, &tape_attr_group);
-
-	return 0;
+	PRINT_INFO("tape device %s found\n", cdev->dev.bus_id);
+	return ret;
 }
 
 static inline void
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 0df3af1..828b2d3 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -1068,6 +1068,7 @@ cmb_show_avg_sample_interval(struct devi
 	if (count) {
 		interval = cmb_data->last_update -
 			cdev->private->cmb_start_time;
+		interval = (interval * 1000) >> 12;
 		interval /= count;
 	} else
 		interval = -1;
diff --git a/drivers/s390/net/ctcmain.c b/drivers/s390/net/ctcmain.c
index 20c8eb1..8a4b581 100644
--- a/drivers/s390/net/ctcmain.c
+++ b/drivers/s390/net/ctcmain.c
@@ -2686,9 +2686,17 @@ static struct attribute_group ctc_attr_g
 static int
 ctc_add_attributes(struct device *dev)
 {
-	device_create_file(dev, &dev_attr_loglevel);
-	device_create_file(dev, &dev_attr_stats);
-	return 0;
+	int rc;
+
+	rc = device_create_file(dev, &dev_attr_loglevel);
+	if (rc)
+		goto out;
+	rc = device_create_file(dev, &dev_attr_stats);
+	if (!rc)
+		goto out;
+	device_remove_file(dev, &dev_attr_loglevel);
+out:
+	return rc;
 }
 
 static void
@@ -2901,7 +2909,12 @@ ctc_new_device(struct ccwgroup_device *c
 		goto out;
 	}
 
-	ctc_add_attributes(&cgdev->dev);
+	if (ctc_add_attributes(&cgdev->dev)) {
+		ctc_netdev_unregister(dev);
+		dev->priv = NULL;
+		ctc_free_netdevice(dev, 1);
+		goto out;
+	}
 
 	strlcpy(privptr->fsm->name, dev->name, sizeof (privptr->fsm->name));
 
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 103c414..5fff1f9 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -8451,10 +8451,11 @@ __qeth_reboot_event_card(struct device *
 static int
 qeth_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
 {
+	int ret;
 
-	driver_for_each_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
-			       __qeth_reboot_event_card);
-	return NOTIFY_DONE;
+	ret = driver_for_each_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
+				     __qeth_reboot_event_card);
+	return ret ? NOTIFY_BAD : NOTIFY_DONE;
 }
 
 
diff --git a/include/asm-s390/system.h b/include/asm-s390/system.h
index 36a3a85..1604004 100644
--- a/include/asm-s390/system.h
+++ b/include/asm-s390/system.h
@@ -128,8 +128,13 @@ #define finish_arch_switch(prev) do {			
 
 #define nop() __asm__ __volatile__ ("nop")
 
-#define xchg(ptr,x) \
-  ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(void *)(ptr),sizeof(*(ptr))))
+#define xchg(ptr,x)							  \
+({									  \
+	__typeof__(*(ptr)) __ret;					  \
+	__ret = (__typeof__(*(ptr)))					  \
+		__xchg((unsigned long)(x), (void *)(ptr),sizeof(*(ptr))); \
+	__ret;								  \
+})
 
 static inline unsigned long __xchg(unsigned long x, void * ptr, int size)
 {
diff --git a/include/asm-s390/timex.h b/include/asm-s390/timex.h
index 4848057..5d0332a 100644
--- a/include/asm-s390/timex.h
+++ b/include/asm-s390/timex.h
@@ -19,7 +19,7 @@ static inline cycles_t get_cycles(void)
 {
 	cycles_t cycles;
 
-	__asm__("stck 0(%1)" : "=m" (cycles) : "a" (&cycles) : "cc");
+	__asm__ __volatile__ ("stck 0(%1)" : "=m" (cycles) : "a" (&cycles) : "cc");
 	return cycles >> 2;
 }
 
@@ -27,7 +27,7 @@ static inline unsigned long long get_clo
 {
 	unsigned long long clk;
 
-	__asm__("stck 0(%1)" : "=m" (clk) : "a" (&clk) : "cc");
+	__asm__ __volatile__ ("stck 0(%1)" : "=m" (clk) : "a" (&clk) : "cc");
 	return clk;
 }
 
