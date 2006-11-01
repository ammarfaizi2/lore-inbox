Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946878AbWKAOEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946878AbWKAOEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 09:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946885AbWKAOEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 09:04:09 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:40210 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1946878AbWKAOEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 09:04:06 -0500
Date: Wed, 1 Nov 2006 08:56:19 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, akpm@osdl.org
Cc: kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in several drivers
Message-ID: <20061101135619.GA3459@hmsreliant.homelinux.net>
References: <20061023171910.GA23714@hmsreliant.homelinux.net> <1161660875.10524.535.camel@localhost.localdomain> <20061024125306.GA1608@hmsreliant.homelinux.net> <1161729762.10524.660.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161729762.10524.660.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey all-
	Since Andrew hasn't incorporated this patch yet, and I had the time, I
redid the patch taking Benjamin's INIT_LIST_HEAD and Joes mmtimer cleanup into
account.  New patch attached, replacing the old one, everything except the
aforementioned cleanups is identical.  

Thanks & Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 drivers/char/misc.c             |    2 ++
 drivers/char/mmtimer.c          |   23 ++++++++++++++++++-----
 drivers/char/tpm/tpm.c          |    1 +
 drivers/input/misc/hp_sdc_rtc.c |    4 +++-
 drivers/macintosh/apm_emu.c     |    3 ++-
 5 files changed, 26 insertions(+), 7 deletions(-)



diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 62ebe09..77c20f8 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -204,6 +204,8 @@ int misc_register(struct miscdevice * mi
 	dev_t dev;
 	int err = 0;
 
+	INIT_LIST_HEAD(&misc->list);
+
 	down(&misc_sem);
 	list_for_each_entry(c, &misc_list, list) {
 		if (c->minor == misc->minor) {
diff --git a/drivers/char/mmtimer.c b/drivers/char/mmtimer.c
index 22b9905..dbc5503 100644
--- a/drivers/char/mmtimer.c
+++ b/drivers/char/mmtimer.c
@@ -680,7 +680,7 @@ static int __init mmtimer_init(void)
 	if (sn_rtc_cycles_per_second < 100000) {
 		printk(KERN_ERR "%s: unable to determine clock frequency\n",
 		       MMTIMER_NAME);
-		return -1;
+		goto out1;
 	}
 
 	mmtimer_femtoperiod = ((unsigned long)1E15 + sn_rtc_cycles_per_second /
@@ -689,13 +689,13 @@ static int __init mmtimer_init(void)
 	if (request_irq(SGI_MMTIMER_VECTOR, mmtimer_interrupt, IRQF_PERCPU, MMTIMER_NAME, NULL)) {
 		printk(KERN_WARNING "%s: unable to allocate interrupt.",
 			MMTIMER_NAME);
-		return -1;
+		goto out1;
 	}
 
 	if (misc_register(&mmtimer_miscdev)) {
 		printk(KERN_ERR "%s: failed to register device\n",
 		       MMTIMER_NAME);
-		return -1;
+		goto out2;
 	}
 
 	/* Get max numbered node, calculate slots needed */
@@ -709,16 +709,18 @@ static int __init mmtimer_init(void)
 	if (timers == NULL) {
 		printk(KERN_ERR "%s: failed to allocate memory for device\n",
 				MMTIMER_NAME);
-		return -1;
+		goto out3;
 	}
 
+	memset(timers,0,(sizeof(mmtimer_t *)*maxn));
+
 	/* Allocate mmtimer_t's for each online node */
 	for_each_online_node(node) {
 		timers[node] = kmalloc_node(sizeof(mmtimer_t)*NUM_COMPARATORS, GFP_KERNEL, node);
 		if (timers[node] == NULL) {
 			printk(KERN_ERR "%s: failed to allocate memory for device\n",
 				MMTIMER_NAME);
-			return -1;
+			goto out4;
 		}
 		for (i=0; i< NUM_COMPARATORS; i++) {
 			mmtimer_t * base = timers[node] + i;
@@ -739,6 +741,17 @@ static int __init mmtimer_init(void)
 	       sn_rtc_cycles_per_second/(unsigned long)1E6);
 
 	return 0;
+
+out4:
+	for_each_online_node(node) {
+		kfree(timers[node]);
+	}
+out3:
+	misc_deregister(&mmtimer_miscdev);
+out2:
+	free_irq(SGI_MMTIMER_VECTOR, NULL);
+out1:
+	return -1;	
 }
 
 module_init(mmtimer_init);
diff --git a/drivers/char/tpm/tpm.c b/drivers/char/tpm/tpm.c
index 6ad2d3b..f14bf8b 100644
--- a/drivers/char/tpm/tpm.c
+++ b/drivers/char/tpm/tpm.c
@@ -1155,6 +1155,7 @@ #define DEVNAME_SIZE 7
 
 	if (sysfs_create_group(&dev->kobj, chip->vendor.attr_group)) {
 		list_del(&chip->list);
+		misc_deregister(&chip->vendor.miscdev);
 		put_device(dev);
 		clear_bit(chip->dev_num, dev_mask);
 		kfree(chip);
diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
index ab4da79..31d5a13 100644
--- a/drivers/input/misc/hp_sdc_rtc.c
+++ b/drivers/input/misc/hp_sdc_rtc.c
@@ -695,7 +695,9 @@ static int __init hp_sdc_rtc_init(void)
 
 	if ((ret = hp_sdc_request_timer_irq(&hp_sdc_rtc_isr)))
 		return ret;
-	misc_register(&hp_sdc_rtc_dev);
+	if (misc_register(&hp_sdc_rtc_dev) != 0)
+		printk(KERN_INFO "Could not register misc. dev for i8042 rtc\n");
+
         create_proc_read_entry ("driver/rtc", 0, NULL,
 				hp_sdc_rtc_read_proc, NULL);
 
diff --git a/drivers/macintosh/apm_emu.c b/drivers/macintosh/apm_emu.c
index 1293876..8862a83 100644
--- a/drivers/macintosh/apm_emu.c
+++ b/drivers/macintosh/apm_emu.c
@@ -529,7 +529,8 @@ static int __init apm_emu_init(void)
 	if (apm_proc)
 		apm_proc->owner = THIS_MODULE;
 
-	misc_register(&apm_device);
+	if (misc_register(&apm_device) != 0)
+		printk(KERN_INFO "Could not create misc. device for apm\n");
 
 	pmu_register_sleep_notifier(&apm_sleep_notifier);
 
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
