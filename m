Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWCVPPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWCVPPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWCVPPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:15:16 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:15022 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751080AbWCVPPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:15:12 -0500
Date: Wed, 22 Mar 2006 16:15:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cornelia.huck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 3/24] s390: channel path measurements.
Message-ID: <20060322151539.GC5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[patch 3/24] s390: channel path measurements.

Gather extended measurements for channel paths from the channel subsystem
and expose them to userspace via a sysfs attribute.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/chsc.c |  428 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/s390/cio/chsc.h |   22 ++
 drivers/s390/cio/css.c  |   41 ++++
 drivers/s390/cio/css.h  |    6 
 4 files changed, 494 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.c linux-2.6-patched/drivers/s390/cio/chsc.c
--- linux-2.6/drivers/s390/cio/chsc.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.c	2006-03-22 14:36:11.000000000 +0100
@@ -875,6 +875,266 @@ s390_vary_chpid( __u8 chpid, int on)
 }
 
 /*
+ * Channel measurement related functions
+ */
+static ssize_t
+chp_measurement_chars_read(struct kobject *kobj, char *buf, loff_t off,
+			   size_t count)
+{
+	struct channel_path *chp;
+	unsigned int size;
+
+	chp = to_channelpath(container_of(kobj, struct device, kobj));
+	if (!chp->cmg_chars)
+		return 0;
+
+	size = sizeof(struct cmg_chars);
+
+	if (off > size)
+		return 0;
+	if (off + count > size)
+		count = size - off;
+	memcpy(buf, chp->cmg_chars + off, count);
+	return count;
+}
+
+static struct bin_attribute chp_measurement_chars_attr = {
+	.attr = {
+		.name = "measurement_chars",
+		.mode = S_IRUSR,
+		.owner = THIS_MODULE,
+	},
+	.size = sizeof(struct cmg_chars),
+	.read = chp_measurement_chars_read,
+};
+
+static void
+chp_measurement_copy_block(struct cmg_entry *buf,
+			   struct channel_subsystem *css, int chpid)
+{
+	void *area;
+	struct cmg_entry *entry, reference_buf;
+	int idx;
+
+	if (chpid < 128) {
+		area = css->cub_addr1;
+		idx = chpid;
+	} else {
+		area = css->cub_addr2;
+		idx = chpid - 128;
+	}
+	entry = area + (idx * sizeof(struct cmg_entry));
+	do {
+		memcpy(buf, entry, sizeof(*entry));
+		memcpy(&reference_buf, entry, sizeof(*entry));
+	} while (reference_buf.values[0] != buf->values[0]);
+}
+
+static ssize_t
+chp_measurement_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
+{
+	struct channel_path *chp;
+	struct channel_subsystem *css;
+	unsigned int size;
+
+	chp = to_channelpath(container_of(kobj, struct device, kobj));
+	css = to_css(chp->dev.parent);
+
+	size = sizeof(struct cmg_chars);
+
+	/* Only allow single reads. */
+	if (off || count < size)
+		return 0;
+	chp_measurement_copy_block((struct cmg_entry *)buf, css, chp->id);
+	return count;
+}
+
+static struct bin_attribute chp_measurement_attr = {
+	.attr = {
+		.name = "measurement",
+		.mode = S_IRUSR,
+		.owner = THIS_MODULE,
+	},
+	.size = sizeof(struct cmg_entry),
+	.read = chp_measurement_read,
+};
+
+static void
+chsc_remove_chp_cmg_attr(struct channel_path *chp)
+{
+	sysfs_remove_bin_file(&chp->dev.kobj, &chp_measurement_chars_attr);
+	sysfs_remove_bin_file(&chp->dev.kobj, &chp_measurement_attr);
+}
+
+static int
+chsc_add_chp_cmg_attr(struct channel_path *chp)
+{
+	int ret;
+
+	ret = sysfs_create_bin_file(&chp->dev.kobj,
+				    &chp_measurement_chars_attr);
+	if (ret)
+		return ret;
+	ret = sysfs_create_bin_file(&chp->dev.kobj, &chp_measurement_attr);
+	if (ret)
+		sysfs_remove_bin_file(&chp->dev.kobj,
+				      &chp_measurement_chars_attr);
+	return ret;
+}
+
+static void
+chsc_remove_cmg_attr(struct channel_subsystem *css)
+{
+	int i;
+
+	for (i = 0; i <= __MAX_CHPID; i++) {
+		if (!css->chps[i])
+			continue;
+		chsc_remove_chp_cmg_attr(css->chps[i]);
+	}
+}
+
+static int
+chsc_add_cmg_attr(struct channel_subsystem *css)
+{
+	int i, ret;
+
+	ret = 0;
+	for (i = 0; i <= __MAX_CHPID; i++) {
+		if (!css->chps[i])
+			continue;
+		ret = chsc_add_chp_cmg_attr(css->chps[i]);
+		if (ret)
+			goto cleanup;
+	}
+	return ret;
+cleanup:
+	for (--i; i >= 0; i--) {
+		if (!css->chps[i])
+			continue;
+		chsc_remove_chp_cmg_attr(css->chps[i]);
+	}
+	return ret;
+}
+
+
+static inline int
+__chsc_do_secm(struct channel_subsystem *css, int enable, void *page)
+{
+	struct {
+		struct chsc_header request;
+		u32 operation_code : 2;
+		u32 : 30;
+		u32 key : 4;
+		u32 : 28;
+		u32 zeroes1;
+		u32 cub_addr1;
+		u32 zeroes2;
+		u32 cub_addr2;
+		u32 reserved[13];
+		struct chsc_header response;
+		u32 status : 8;
+		u32 : 4;
+		u32 fmt : 4;
+		u32 : 16;
+	} *secm_area;
+	int ret, ccode;
+
+	secm_area = page;
+	secm_area->request = (struct chsc_header) {
+		.length = 0x0050,
+		.code   = 0x0016,
+	};
+
+	secm_area->key = PAGE_DEFAULT_KEY;
+	secm_area->cub_addr1 = (u64)(unsigned long)css->cub_addr1;
+	secm_area->cub_addr2 = (u64)(unsigned long)css->cub_addr2;
+
+	secm_area->operation_code = enable ? 0 : 1;
+
+	ccode = chsc(secm_area);
+	if (ccode > 0)
+		return (ccode == 3) ? -ENODEV : -EBUSY;
+
+	switch (secm_area->response.code) {
+	case 0x0001: /* Success. */
+		ret = 0;
+		break;
+	case 0x0003: /* Invalid block. */
+	case 0x0007: /* Invalid format. */
+	case 0x0008: /* Other invalid block. */
+		CIO_CRW_EVENT(2, "Error in chsc request block!\n");
+		ret = -EINVAL;
+		break;
+	case 0x0004: /* Command not provided in model. */
+		CIO_CRW_EVENT(2, "Model does not provide secm\n");
+		ret = -EOPNOTSUPP;
+		break;
+	case 0x0102: /* cub adresses incorrect */
+		CIO_CRW_EVENT(2, "Invalid addresses in chsc request block\n");
+		ret = -EINVAL;
+		break;
+	case 0x0103: /* key error */
+		CIO_CRW_EVENT(2, "Access key error in secm\n");
+		ret = -EINVAL;
+		break;
+	case 0x0105: /* error while starting */
+		CIO_CRW_EVENT(2, "Error while starting channel measurement\n");
+		ret = -EIO;
+		break;
+	default:
+		CIO_CRW_EVENT(2, "Unknown CHSC response %d\n",
+			      secm_area->response.code);
+		ret = -EIO;
+	}
+	return ret;
+}
+
+int
+chsc_secm(struct channel_subsystem *css, int enable)
+{
+	void  *secm_area;
+	int ret;
+
+	secm_area = (void *)get_zeroed_page(GFP_KERNEL |  GFP_DMA);
+	if (!secm_area)
+		return -ENOMEM;
+
+	mutex_lock(&css->mutex);
+	if (enable && !css->cm_enabled) {
+		css->cub_addr1 = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		css->cub_addr2 = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+		if (!css->cub_addr1 || !css->cub_addr2) {
+			free_page((unsigned long)css->cub_addr1);
+			free_page((unsigned long)css->cub_addr2);
+			free_page((unsigned long)secm_area);
+			mutex_unlock(&css->mutex);
+			return -ENOMEM;
+		}
+	}
+	ret = __chsc_do_secm(css, enable, secm_area);
+	if (!ret) {
+		css->cm_enabled = enable;
+		if (css->cm_enabled) {
+			ret = chsc_add_cmg_attr(css);
+			if (ret) {
+				memset(secm_area, 0, PAGE_SIZE);
+				__chsc_do_secm(css, 0, secm_area);
+				css->cm_enabled = 0;
+			}
+		} else
+			chsc_remove_cmg_attr(css);
+	}
+	if (enable && !css->cm_enabled) {
+		free_page((unsigned long)css->cub_addr1);
+		free_page((unsigned long)css->cub_addr2);
+	}
+	mutex_unlock(&css->mutex);
+	free_page((unsigned long)secm_area);
+	return ret;
+}
+
+/*
  * Files for the channel path entries.
  */
 static ssize_t
@@ -925,9 +1185,39 @@ chp_type_show(struct device *dev, struct
 
 static DEVICE_ATTR(type, 0444, chp_type_show, NULL);
 
+static ssize_t
+chp_cmg_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct channel_path *chp = to_channelpath(dev);
+
+	if (!chp)
+		return 0;
+	if (chp->cmg == -1) /* channel measurements not available */
+		return sprintf(buf, "unknown\n");
+	return sprintf(buf, "%x\n", chp->cmg);
+}
+
+static DEVICE_ATTR(cmg, 0444, chp_cmg_show, NULL);
+
+static ssize_t
+chp_shared_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct channel_path *chp = to_channelpath(dev);
+
+	if (!chp)
+		return 0;
+	if (chp->shared == -1) /* channel measurements not available */
+		return sprintf(buf, "unknown\n");
+	return sprintf(buf, "%x\n", chp->shared);
+}
+
+static DEVICE_ATTR(shared, 0444, chp_shared_show, NULL);
+
 static struct attribute * chp_attrs[] = {
 	&dev_attr_status.attr,
 	&dev_attr_type.attr,
+	&dev_attr_cmg.attr,
+	&dev_attr_shared.attr,
 	NULL,
 };
 
@@ -1006,6 +1296,113 @@ out:
 	return ret;
 }
 
+static void
+chsc_initialize_cmg_chars(struct channel_path *chp, u8 cmcv,
+			  struct cmg_chars *chars)
+{
+	switch (chp->cmg) {
+	case 2:
+	case 3:
+		chp->cmg_chars = kmalloc(sizeof(struct cmg_chars),
+					 GFP_KERNEL);
+		if (chp->cmg_chars) {
+			int i, mask;
+			struct cmg_chars *cmg_chars;
+
+			cmg_chars = chp->cmg_chars;
+			for (i = 0; i < NR_MEASUREMENT_CHARS; i++) {
+				mask = 0x80 >> (i + 3);
+				if (cmcv & mask)
+					cmg_chars->values[i] = chars->values[i];
+				else
+					cmg_chars->values[i] = 0;
+			}
+		}
+		break;
+	default:
+		/* No cmg-dependent data. */
+		break;
+	}
+}
+
+static int
+chsc_get_channel_measurement_chars(struct channel_path *chp)
+{
+	int ccode, ret;
+
+	struct {
+		struct chsc_header request;
+		u32 : 24;
+		u32 first_chpid : 8;
+		u32 : 24;
+		u32 last_chpid : 8;
+		u32 zeroes1;
+		struct chsc_header response;
+		u32 zeroes2;
+		u32 not_valid : 1;
+		u32 shared : 1;
+		u32 : 22;
+		u32 chpid : 8;
+		u32 cmcv : 5;
+		u32 : 11;
+		u32 cmgq : 8;
+		u32 cmg : 8;
+		u32 zeroes3;
+		u32 data[NR_MEASUREMENT_CHARS];
+	} *scmc_area;
+
+	scmc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!scmc_area)
+		return -ENOMEM;
+
+	scmc_area->request = (struct chsc_header) {
+		.length = 0x0010,
+		.code   = 0x0022,
+	};
+
+	scmc_area->first_chpid = chp->id;
+	scmc_area->last_chpid = chp->id;
+
+	ccode = chsc(scmc_area);
+	if (ccode > 0) {
+		ret = (ccode == 3) ? -ENODEV : -EBUSY;
+		goto out;
+	}
+
+	switch (scmc_area->response.code) {
+	case 0x0001: /* Success. */
+		if (!scmc_area->not_valid) {
+			chp->cmg = scmc_area->cmg;
+			chp->shared = scmc_area->shared;
+			chsc_initialize_cmg_chars(chp, scmc_area->cmcv,
+						  (struct cmg_chars *)
+						  &scmc_area->data);
+		} else {
+			chp->cmg = -1;
+			chp->shared = -1;
+		}
+		ret = 0;
+		break;
+	case 0x0003: /* Invalid block. */
+	case 0x0007: /* Invalid format. */
+	case 0x0008: /* Invalid bit combination. */
+		CIO_CRW_EVENT(2, "Error in chsc request block!\n");
+		ret = -EINVAL;
+		break;
+	case 0x0004: /* Command not provided. */
+		CIO_CRW_EVENT(2, "Model does not provide scmc\n");
+		ret = -EOPNOTSUPP;
+		break;
+	default:
+		CIO_CRW_EVENT(2, "Unknown CHSC response %d\n",
+			      scmc_area->response.code);
+		ret = -EIO;
+	}
+out:
+	free_page((unsigned long)scmc_area);
+	return ret;
+}
+
 /*
  * Entries for chpids on the system bus.
  * This replaces /proc/chpids.
@@ -1034,6 +1431,22 @@ new_channel_path(int chpid)
 	ret = chsc_determine_channel_path_description(chpid, &chp->desc);
 	if (ret)
 		goto out_free;
+	/* Get channel-measurement characteristics. */
+	if (css_characteristics_avail && css_chsc_characteristics.scmc
+	    && css_chsc_characteristics.secm) {
+		ret = chsc_get_channel_measurement_chars(chp);
+		if (ret)
+			goto out_free;
+	} else {
+		static int msg_done;
+
+		if (!msg_done) {
+			printk(KERN_WARNING "cio: Channel measurements not "
+			       "available, continuing.\n");
+			msg_done = 1;
+		}
+		chp->cmg = -1;
+	}
 
 	/* make it known to the system */
 	ret = device_register(&chp->dev);
@@ -1046,8 +1459,19 @@ new_channel_path(int chpid)
 	if (ret) {
 		device_unregister(&chp->dev);
 		goto out_free;
-	} else
-		css[0]->chps[chpid] = chp;
+	}
+	mutex_lock(&css[0]->mutex);
+	if (css[0]->cm_enabled) {
+		ret = chsc_add_chp_cmg_attr(chp);
+		if (ret) {
+			sysfs_remove_group(&chp->dev.kobj, &chp_attr_group);
+			device_unregister(&chp->dev);
+			mutex_unlock(&css[0]->mutex);
+			goto out_free;
+		}
+	}
+	css[0]->chps[chpid] = chp;
+	mutex_unlock(&css[0]->mutex);
 	return ret;
 out_free:
 	kfree(chp);
diff -urpN linux-2.6/drivers/s390/cio/chsc.h linux-2.6-patched/drivers/s390/cio/chsc.h
--- linux-2.6/drivers/s390/cio/chsc.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.h	2006-03-22 14:36:11.000000000 +0100
@@ -12,6 +12,16 @@ struct chsc_header {
 	u16 code;
 };
 
+#define NR_MEASUREMENT_CHARS 5
+struct cmg_chars {
+	u32 values[NR_MEASUREMENT_CHARS];
+};
+
+#define NR_MEASUREMENT_ENTRIES 8
+struct cmg_entry {
+	u32 values[NR_MEASUREMENT_ENTRIES];
+};
+
 struct channel_path_desc {
 	u8 flags;
 	u8 lsn;
@@ -27,6 +37,10 @@ struct channel_path {
 	int id;
 	int state;
 	struct channel_path_desc desc;
+	/* Channel-measurement related stuff: */
+	int cmg;
+	int shared;
+	void *cmg_chars;
 	struct device dev;
 };
 
@@ -52,7 +66,11 @@ struct css_general_char {
 
 struct css_chsc_char {
 	u64 res;
-	u64 : 43;
+	u64 : 20;
+	u32 secm : 1; /* bit 84 */
+	u32 : 1;
+	u32 scmc : 1; /* bit 86 */
+	u32 : 20;
 	u32 scssc : 1;  /* bit 107 */
 	u32 scsscf : 1; /* bit 108 */
 	u32 : 19;
@@ -67,6 +85,8 @@ extern int css_characteristics_avail;
 extern void *chsc_get_chp_desc(struct subchannel*, int);
 
 extern int chsc_enable_facility(int);
+struct channel_subsystem;
+extern int chsc_secm(struct channel_subsystem *, int);
 
 #define to_channelpath(device) container_of(device, struct channel_path, dev)
 
diff -urpN linux-2.6/drivers/s390/cio/css.c linux-2.6-patched/drivers/s390/cio/css.c
--- linux-2.6/drivers/s390/cio/css.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.c	2006-03-22 14:36:11.000000000 +0100
@@ -452,15 +452,50 @@ channel_subsystem_release(struct device 
 	struct channel_subsystem *css;
 
 	css = to_css(dev);
+	mutex_destroy(&css->mutex);
 	kfree(css);
 }
 
+static ssize_t
+css_cm_enable_show(struct device *dev, struct device_attribute *attr,
+		   char *buf)
+{
+	struct channel_subsystem *css = to_css(dev);
+
+	if (!css)
+		return 0;
+	return sprintf(buf, "%x\n", css->cm_enabled);
+}
+
+static ssize_t
+css_cm_enable_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	struct channel_subsystem *css = to_css(dev);
+	int ret;
+
+	switch (buf[0]) {
+	case '0':
+		ret = css->cm_enabled ? chsc_secm(css, 0) : 0;
+		break;
+	case '1':
+		ret = css->cm_enabled ? 0 : chsc_secm(css, 1);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret < 0 ? ret : count;
+}
+
+static DEVICE_ATTR(cm_enable, 0644, css_cm_enable_show, css_cm_enable_store);
+
 static inline void __init
 setup_css(int nr)
 {
 	u32 tod_high;
 
 	memset(css[nr], 0, sizeof(struct channel_subsystem));
+	mutex_init(&css[nr]->mutex);
 	css[nr]->valid = 1;
 	css[nr]->cssid = nr;
 	sprintf(css[nr]->device.bus_id, "css%x", nr);
@@ -507,6 +542,9 @@ init_channel_subsystem (void)
 		ret = device_register(&css[i]->device);
 		if (ret)
 			goto out_free;
+		if (css_characteristics_avail && css_chsc_characteristics.secm)
+			device_create_file(&css[i]->device,
+					   &dev_attr_cm_enable);
 	}
 	css_init_done = 1;
 
@@ -519,6 +557,9 @@ out_free:
 out_unregister:
 	while (i > 0) {
 		i--;
+		if (css_characteristics_avail && css_chsc_characteristics.secm)
+			device_remove_file(&css[i]->device,
+					   &dev_attr_cm_enable);
 		device_unregister(&css[i]->device);
 	}
 out_bus:
diff -urpN linux-2.6/drivers/s390/cio/css.h linux-2.6-patched/drivers/s390/cio/css.h
--- linux-2.6/drivers/s390/cio/css.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/css.h	2006-03-22 14:36:11.000000000 +0100
@@ -1,6 +1,7 @@
 #ifndef _CSS_H
 #define _CSS_H
 
+#include <linux/mutex.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
@@ -150,6 +151,11 @@ struct channel_subsystem {
 	struct channel_path *chps[__MAX_CHPID + 1];
 	struct device device;
 	struct pgid global_pgid;
+	struct mutex mutex;
+	/* channel measurement related */
+	int cm_enabled;
+	void *cub_addr1;
+	void *cub_addr2;
 };
 #define to_css(dev) container_of(dev, struct channel_subsystem, device)
 
