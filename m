Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWGDQxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWGDQxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWGDQxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:53:36 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:6108 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932284AbWGDQxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:53:17 -0400
Date: Tue, 4 Jul 2006 18:53:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, rwuerthn@de.ibm.com,
       cornelia.huck@de.ibm.com
Subject: [patch 2/6] s390: zcrypt user space interface.
Message-ID: <20060704165318.GC6202@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Ralph Wuerthner <rwuerthn@de.ibm.com>
From: Cornelia Huck <cornelia.huck@de.ibm.com>

[patch 2/6] s390: zcrypt user space interface.

The user space interface of the zcrypt device driver implements the old
user space interface as defined by the old z90crypt driver. Everything
is there, the /dev/z90crypt misc character device, all the lovely ioctls
and the /proc file. Even writing to the z90crypt proc file to configure
the crypto device still works. It stands to reason to remove the proc
write function someday since a much cleaner configuration via the sysfs
is now available.

The ap bus device drivers register crypto cards to the zcrypt user
space interface. The request router of the user space interface
picks one of the registered cards based on the predicted latency
for the request and calls the driver via a callback found in the
zcrypt_ops of the device. The request router only knows which
operations the card can do and the minimum / maximum number of bits
a request can have.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_api.c |  910 +++++++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/zcrypt_api.h |  135 +++++
 include/asm-s390/zcrypt.h        |  207 ++++++++
 3 files changed, 1252 insertions(+)

diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_api.c linux-2.6-patched/drivers/s390/crypto/zcrypt_api.c
--- linux-2.6/drivers/s390/crypto/zcrypt_api.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_api.c	2006-07-04 18:31:35.000000000 +0200
@@ -0,0 +1,910 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_api.c
+ *
+ *  zcrypt 2.0.0
+ *
+ *  Copyright (C)  2001, 2006 IBM Corporation
+ *  Author(s): Robert Burroughs
+ *	       Eric Rossman (edrossma@us.ibm.com)
+ *	       Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
+ *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *				  Ralph Wuerthner <rwuerthn@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/compat.h>
+#include <asm/atomic.h>
+#include <asm/uaccess.h>
+
+#include "zcrypt_api.h"
+
+/**
+ * Module description.
+ */
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("Cryptographic Coprocessor interface, "
+		   "Copyright 2001, 2006 IBM Corporation");
+MODULE_LICENSE("GPL");
+
+static DEFINE_SPINLOCK(zcrypt_device_lock);
+static LIST_HEAD(zcrypt_device_list);
+static int zcrypt_device_count = 0;
+static atomic_t zcrypt_open_count = ATOMIC_INIT(0);
+
+/**
+ * Device attributes common for all crypto devices.
+ */
+static ssize_t zcrypt_type_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct zcrypt_device *zdev = to_ap_dev(dev)->private;
+	return snprintf(buf, PAGE_SIZE, "%s\n", zdev->type_string);
+}
+
+static DEVICE_ATTR(type, 0444, zcrypt_type_show, NULL);
+
+static ssize_t zcrypt_online_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct zcrypt_device *zdev = to_ap_dev(dev)->private;
+	return snprintf(buf, PAGE_SIZE, "%d\n", zdev->online);
+}
+
+static ssize_t zcrypt_online_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct zcrypt_device *zdev = to_ap_dev(dev)->private;
+	int online;
+
+	if (sscanf(buf, "%d\n", &online) != 1 || online < 0 || online > 1)
+		return -EINVAL;
+	zdev->online = online;
+	if (!online)
+		ap_flush_queue(zdev->ap_dev);
+	return count;
+}
+
+static DEVICE_ATTR(online, 0644, zcrypt_online_show, zcrypt_online_store);
+
+static struct attribute * zcrypt_device_attrs[] = {
+	&dev_attr_type.attr,
+	&dev_attr_online.attr,
+	NULL,
+};
+
+static struct attribute_group zcrypt_device_attr_group = {
+	.attrs = zcrypt_device_attrs,
+};
+
+/**
+ * Move the device towards the head of the device list.
+ * Need to be called while holding the zcrypt device list lock.
+ * Note: cards with speed_rating of 0 are kept at the end of the list.
+ */
+static void __zcrypt_increase_preference(struct zcrypt_device *zdev)
+{
+	struct zcrypt_device *tmp;
+	struct list_head *l;
+
+	if (zdev->speed_rating == 0)
+		return;
+	for (l = zdev->list.prev; l != &zcrypt_device_list; l = l->prev) {
+		tmp = list_entry(l, struct zcrypt_device, list);
+		if ((tmp->request_count + 1) * tmp->speed_rating <=
+		    (zdev->request_count + 1) * zdev->speed_rating &&
+		    tmp->speed_rating != 0)
+			break;
+	}
+	if (l == zdev->list.next)
+		return;
+	/* Move zdev behind l */
+	list_del(&zdev->list);
+	list_add(&zdev->list, l);
+}
+
+/**
+ * Move the device towards the tail of the device list.
+ * Need to be called while holding the zcrypt device list lock.
+ * Note: cards with speed_rating of 0 are kept at the end of the list.
+ */
+static void __zcrypt_decrease_preference(struct zcrypt_device *zdev)
+{
+	struct zcrypt_device *tmp;
+	struct list_head *l;
+
+	if (zdev->speed_rating == 0)
+		return;
+	for (l = zdev->list.next; l != &zcrypt_device_list; l = l->next) {
+		tmp = list_entry(l, struct zcrypt_device, list);
+		if ((tmp->request_count + 1) * tmp->speed_rating >
+		    (zdev->request_count + 1) * zdev->speed_rating ||
+		    tmp->speed_rating == 0)
+			break;
+	}
+	if (l == zdev->list.next)
+		return;
+	/* Move zdev before l */
+	list_del(&zdev->list);
+	list_add_tail(&zdev->list, l);
+}
+
+/**
+ * Register a crypto device.
+ */
+int zcrypt_device_register(struct zcrypt_device *zdev)
+{
+	int rc;
+
+	rc = sysfs_create_group(&zdev->ap_dev->device.kobj,
+				&zcrypt_device_attr_group);
+	if (rc)
+		goto out;
+	get_device(&zdev->ap_dev->device);
+	spin_lock_bh(&zcrypt_device_lock);
+	zdev->online = 1;	/* New device are online by default. */
+	list_add_tail(&zdev->list, &zcrypt_device_list);
+	__zcrypt_increase_preference(zdev);
+	zcrypt_device_count++;
+	spin_unlock_bh(&zcrypt_device_lock);
+out:
+	return rc;
+}
+EXPORT_SYMBOL(zcrypt_device_register);
+
+/**
+ * Unregister a crypto device.
+ */
+void zcrypt_device_unregister(struct zcrypt_device *zdev)
+{
+	spin_lock_bh(&zcrypt_device_lock);
+	zcrypt_device_count--;
+	list_del_init(&zdev->list);
+	spin_unlock_bh(&zcrypt_device_lock);
+	sysfs_remove_group(&zdev->ap_dev->device.kobj,
+			   &zcrypt_device_attr_group);
+	put_device(&zdev->ap_dev->device);
+}
+EXPORT_SYMBOL(zcrypt_device_unregister);
+
+/**
+ * zcrypt_read is not be supported beyond zcrypt 1.3.1
+ */
+static ssize_t zcrypt_read(struct file *filp, char __user *buf,
+			   size_t count, loff_t *f_pos)
+{
+	return -EPERM;
+}
+
+/**
+ * Write is is not allowed
+ */
+static ssize_t zcrypt_write(struct file *filp, const char __user *buf,
+			    size_t count, loff_t *f_pos)
+{
+	return -EPERM;
+}
+
+/**
+ * Device open/close functions to count number of users.
+ */
+static int zcrypt_open(struct inode *inode, struct file *filp)
+{
+	atomic_inc(&zcrypt_open_count);
+	return 0;
+}
+
+static int zcrypt_release(struct inode *inode, struct file *filp)
+{
+	atomic_dec(&zcrypt_open_count);
+	return 0;
+}
+
+/**
+ * zcrypt ioctls.
+ */
+static long zcrypt_rsa_modexpo(struct ica_rsa_modexpo *mex)
+{
+	struct zcrypt_device *zdev;
+	int rc;
+
+	if (mex->outputdatalength < mex->inputdatalength)
+		return -EINVAL;
+	/**
+	 * As long as outputdatalength is big enough, we can set the
+	 * outputdatalength equal to the inputdatalength, since that is the
+	 * number of bytes we will copy in any case
+	 */
+	mex->outputdatalength = mex->inputdatalength;
+
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list) {
+		if (!zdev->online ||
+		    !zdev->ops->rsa_modexpo ||
+		    zdev->min_mod_size > mex->inputdatalength ||
+		    zdev->max_mod_size < mex->inputdatalength)
+			continue;
+		get_device(&zdev->ap_dev->device);
+		zdev->request_count++;
+		__zcrypt_decrease_preference(zdev);
+		spin_unlock_bh(&zcrypt_device_lock);
+		rc = zdev->ops->rsa_modexpo(zdev, mex);
+		spin_lock_bh(&zcrypt_device_lock);
+		zdev->request_count--;
+		__zcrypt_increase_preference(zdev);
+		put_device(&zdev->ap_dev->device);
+		spin_unlock_bh(&zcrypt_device_lock);
+		return rc;
+	}
+	spin_unlock_bh(&zcrypt_device_lock);
+	return -EINVAL;
+}
+
+static long zcrypt_rsa_crt(struct ica_rsa_modexpo_crt *crt)
+{
+	struct zcrypt_device *zdev;
+	unsigned long long z1, z2, z3;
+	int rc, copied;
+
+	if (crt->outputdatalength < crt->inputdatalength ||
+	    (crt->inputdatalength & 1))
+		return -EINVAL;
+	/**
+	 * As long as outputdatalength is big enough, we can set the
+	 * outputdatalength equal to the inputdatalength, since that is the
+	 * number of bytes we will copy in any case
+	 */
+	crt->outputdatalength = crt->inputdatalength;
+
+	copied = 0;
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list) {
+		if (!zdev->online ||
+		    !zdev->ops->rsa_modexpo_crt ||
+		    zdev->min_mod_size > crt->inputdatalength ||
+		    zdev->max_mod_size < crt->inputdatalength)
+			continue;
+		if (zdev->short_crt && crt->inputdatalength > 240) {
+			/**
+			 * Check inputdata for leading zeros for cards
+			 * that can't handle np_prime, bp_key, or
+			 * u_mult_inv > 128 bytes.
+			 */
+			if (copied == 0) {
+				/* len is max 256 / 2 - 120 = 8 */
+				int len = crt->inputdatalength / 2 - 120;
+				z1 = z2 = z3 = 0;
+				if (copy_from_user(&z1, crt->np_prime, len) ||
+				    copy_from_user(&z2, crt->bp_key, len) ||
+				    copy_from_user(&z3, crt->u_mult_inv, len))
+					return -EFAULT;
+				copied = 1;
+			}
+			if (z1 != 0ULL || z2 != 0ULL || z3 != 0ULL)
+				/* The device can't handle this request. */
+				continue;
+		}
+		get_device(&zdev->ap_dev->device);
+		zdev->request_count++;
+		__zcrypt_decrease_preference(zdev);
+		spin_unlock_bh(&zcrypt_device_lock);
+		rc = zdev->ops->rsa_modexpo_crt(zdev, crt);
+		spin_lock_bh(&zcrypt_device_lock);
+		zdev->request_count--;
+		__zcrypt_increase_preference(zdev);
+		put_device(&zdev->ap_dev->device);
+		spin_unlock_bh(&zcrypt_device_lock);
+		return rc;
+	}
+	spin_unlock_bh(&zcrypt_device_lock);
+	return -EINVAL;
+}
+
+static void zcrypt_status_mask(char status[AP_DEVICES])
+{
+	struct zcrypt_device *zdev;
+
+	memset(status, 0, sizeof(char) * AP_DEVICES);
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list)
+		status[AP_QID_DEVICE(zdev->ap_dev->qid)] =
+			zdev->online ? zdev->user_space_type : 0x0d;
+	spin_unlock_bh(&zcrypt_device_lock);
+}
+
+static void zcrypt_qdepth_mask(char qdepth[AP_DEVICES])
+{
+	struct zcrypt_device *zdev;
+
+	memset(qdepth, 0, sizeof(char)	* AP_DEVICES);
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list) {
+		spin_lock(&zdev->ap_dev->lock);
+		qdepth[AP_QID_DEVICE(zdev->ap_dev->qid)] =
+			zdev->ap_dev->pendingq_count +
+			zdev->ap_dev->requestq_count;
+		spin_unlock(&zdev->ap_dev->lock);
+	}
+	spin_unlock_bh(&zcrypt_device_lock);
+}
+
+static void zcrypt_perdev_reqcnt(int reqcnt[AP_DEVICES])
+{
+	struct zcrypt_device *zdev;
+
+	memset(reqcnt, 0, sizeof(int) * AP_DEVICES);
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list) {
+		spin_lock(&zdev->ap_dev->lock);
+		reqcnt[AP_QID_DEVICE(zdev->ap_dev->qid)] =
+			zdev->ap_dev->total_request_count;
+		spin_unlock(&zdev->ap_dev->lock);
+	}
+	spin_unlock_bh(&zcrypt_device_lock);
+}
+
+static int zcrypt_pendingq_count(void)
+{
+	struct zcrypt_device *zdev;
+	int pendingq_count = 0;
+
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list) {
+		spin_lock(&zdev->ap_dev->lock);
+		pendingq_count += zdev->ap_dev->pendingq_count;
+		spin_unlock(&zdev->ap_dev->lock);
+	}
+	spin_unlock_bh(&zcrypt_device_lock);
+	return pendingq_count;
+}
+
+static int zcrypt_requestq_count(void)
+{
+	struct zcrypt_device *zdev;
+	int requestq_count = 0;
+
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list) {
+		spin_lock(&zdev->ap_dev->lock);
+		requestq_count += zdev->ap_dev->requestq_count;
+		spin_unlock(&zdev->ap_dev->lock);
+	}
+	spin_unlock_bh(&zcrypt_device_lock);
+	return requestq_count;
+}
+
+static int zcrypt_count_type(int type)
+{
+	struct zcrypt_device *zdev;
+	int device_count = 0;
+
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list)
+		if (zdev->user_space_type == type)
+			device_count++;
+	spin_unlock_bh(&zcrypt_device_lock);
+	return device_count;
+}
+
+/**
+ * Old, deprecated combi status call.
+ */
+static long zcrypt_ica_status(struct file *filp, unsigned long arg)
+{
+	struct ica_z90_status *pstat;
+	int ret;
+
+	pstat = kzalloc(sizeof(*pstat), GFP_KERNEL);
+	if (!pstat)
+		return -ENOMEM;
+	pstat->totalcount = zcrypt_device_count;
+	pstat->leedslitecount = zcrypt_count_type(ZCRYPT_PCICA);
+	pstat->leeds2count = zcrypt_count_type(ZCRYPT_PCICC);
+	pstat->requestqWaitCount = zcrypt_requestq_count();
+	pstat->pendingqWaitCount = zcrypt_pendingq_count();
+	pstat->totalOpenCount = atomic_read(&zcrypt_open_count);
+	pstat->cryptoDomain = ap_domain_index;
+	zcrypt_status_mask(pstat->status);
+	zcrypt_qdepth_mask(pstat->qdepth);
+	ret = 0;
+	if (copy_to_user((void __user *) arg, pstat, sizeof(*pstat)))
+		ret = -EFAULT;
+	kfree(pstat);
+	return ret;
+}
+
+static long zcrypt_unlocked_ioctl(struct file *filp, unsigned int cmd,
+				  unsigned long arg)
+{
+	int rc;
+
+	switch (cmd) {
+	case ICARSAMODEXPO: {
+		struct ica_rsa_modexpo __user *umex = (void __user *) arg;
+		struct ica_rsa_modexpo mex;
+		if (copy_from_user(&mex, umex, sizeof(mex)))
+			return -EFAULT;
+		do {
+			rc = zcrypt_rsa_modexpo(&mex);
+		} while (rc == -EAGAIN);
+		if (rc)
+			return rc;
+		return put_user(mex.outputdatalength, &umex->outputdatalength);
+	}
+	case ICARSACRT: {
+		struct ica_rsa_modexpo_crt __user *ucrt = (void __user *) arg;
+		struct ica_rsa_modexpo_crt crt;
+		if (copy_from_user(&crt, ucrt, sizeof(crt)))
+			return -EFAULT;
+		do {
+			rc = zcrypt_rsa_crt(&crt);
+		} while (rc == -EAGAIN);
+		if (rc)
+			return rc;
+		return put_user(crt.outputdatalength, &ucrt->outputdatalength);
+	}
+	case Z90STAT_STATUS_MASK: {
+		char status[AP_DEVICES];
+		zcrypt_status_mask(status);
+		if (copy_to_user((char __user *) arg, status,
+				 sizeof(char) * AP_DEVICES))
+			return -EFAULT;
+		return 0;
+	}
+	case Z90STAT_QDEPTH_MASK: {
+		char qdepth[AP_DEVICES];
+		zcrypt_qdepth_mask(qdepth);
+		if (copy_to_user((char __user *) arg, qdepth,
+				 sizeof(char) * AP_DEVICES))
+			return -EFAULT;
+		return 0;
+	}
+	case Z90STAT_PERDEV_REQCNT: {
+		int reqcnt[AP_DEVICES];
+		zcrypt_perdev_reqcnt(reqcnt);
+		if (copy_to_user((int __user *) arg, reqcnt,
+				 sizeof(int) * AP_DEVICES))
+			return -EFAULT;
+		return 0;
+	}
+	case Z90STAT_REQUESTQ_COUNT:
+		return put_user(zcrypt_requestq_count(), (int __user *) arg);
+	case Z90STAT_PENDINGQ_COUNT:
+		return put_user(zcrypt_pendingq_count(), (int __user *) arg);
+	case Z90STAT_TOTALOPEN_COUNT:
+		return put_user(atomic_read(&zcrypt_open_count),
+				(int __user *) arg);
+	case Z90STAT_DOMAIN_INDEX:
+		return put_user(ap_domain_index, (int __user *) arg);
+	/**
+	 * Deprecated ioctls. Don't add another device count ioctl,
+	 * you can count them yourself in the user space with the
+	 * output of the Z90STAT_STATUS_MASK ioctl.
+	 */
+	case ICAZ90STATUS:
+		return zcrypt_ica_status(filp, arg);
+	case Z90STAT_TOTALCOUNT:
+		return put_user(zcrypt_device_count, (int __user *) arg);
+	case Z90STAT_PCICACOUNT:
+		return put_user(zcrypt_count_type(ZCRYPT_PCICA),
+				(int __user *) arg);
+	case Z90STAT_PCICCCOUNT:
+		return put_user(zcrypt_count_type(ZCRYPT_PCICC),
+				(int __user *) arg);
+	case Z90STAT_PCIXCCMCL2COUNT:
+		return put_user(zcrypt_count_type(ZCRYPT_PCIXCC_MCL2),
+				(int __user *) arg);
+	case Z90STAT_PCIXCCMCL3COUNT:
+		return put_user(zcrypt_count_type(ZCRYPT_PCIXCC_MCL3),
+				(int __user *) arg);
+	case Z90STAT_PCIXCCCOUNT:
+		return put_user(zcrypt_count_type(ZCRYPT_PCIXCC_MCL2) +
+				zcrypt_count_type(ZCRYPT_PCIXCC_MCL3),
+				(int __user *) arg);
+	case Z90STAT_CEX2CCOUNT:
+		return put_user(zcrypt_count_type(ZCRYPT_CEX2C),
+				(int __user *) arg);
+	case Z90STAT_CEX2ACOUNT:
+		return put_user(zcrypt_count_type(ZCRYPT_CEX2A),
+				(int __user *) arg);
+	default:
+		/* unknown ioctl number */
+		return -ENOIOCTLCMD;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+/**
+ * ioctl32 conversion routines
+ */
+struct compat_ica_rsa_modexpo {
+	compat_uptr_t	inputdata;
+	unsigned int	inputdatalength;
+	compat_uptr_t	outputdata;
+	unsigned int	outputdatalength;
+	compat_uptr_t	b_key;
+	compat_uptr_t	n_modulus;
+};
+
+static long trans_modexpo32(struct file *filp, unsigned int cmd,
+			    unsigned long arg)
+{
+	struct compat_ica_rsa_modexpo __user *umex32 = compat_ptr(arg);
+	struct compat_ica_rsa_modexpo mex32;
+	struct ica_rsa_modexpo mex64;
+	long rc;
+
+	if (copy_from_user(&mex32, umex32, sizeof(mex32)))
+		return -EFAULT;
+	mex64.inputdata = compat_ptr(mex32.inputdata);
+	mex64.inputdatalength = mex32.inputdatalength;
+	mex64.outputdata = compat_ptr(mex32.outputdata);
+	mex64.outputdatalength = mex32.outputdatalength;
+	mex64.b_key = compat_ptr(mex32.b_key);
+	mex64.n_modulus = compat_ptr(mex32.n_modulus);
+	do {
+		rc = zcrypt_rsa_modexpo(&mex64);
+	} while (rc == -EAGAIN);
+	if (!rc)
+		rc = put_user(mex64.outputdatalength,
+			      &umex32->outputdatalength);
+	return rc;
+}
+
+struct compat_ica_rsa_modexpo_crt {
+	compat_uptr_t	inputdata;
+	unsigned int	inputdatalength;
+	compat_uptr_t	outputdata;
+	unsigned int	outputdatalength;
+	compat_uptr_t	bp_key;
+	compat_uptr_t	bq_key;
+	compat_uptr_t	np_prime;
+	compat_uptr_t	nq_prime;
+	compat_uptr_t	u_mult_inv;
+};
+
+static long trans_modexpo_crt32(struct file *filp, unsigned int cmd,
+				unsigned long arg)
+{
+	struct compat_ica_rsa_modexpo_crt __user *ucrt32 = compat_ptr(arg);
+	struct compat_ica_rsa_modexpo_crt crt32;
+	struct ica_rsa_modexpo_crt crt64;
+	long rc;
+
+	if (copy_from_user(&crt32, ucrt32, sizeof(crt32)))
+		return -EFAULT;
+	crt64.inputdata = compat_ptr(crt32.inputdata);
+	crt64.inputdatalength = crt32.inputdatalength;
+	crt64.outputdata=  compat_ptr(crt32.outputdata);
+	crt64.outputdatalength = crt32.outputdatalength;
+	crt64.bp_key = compat_ptr(crt32.bp_key);
+	crt64.bq_key = compat_ptr(crt32.bq_key);
+	crt64.np_prime = compat_ptr(crt32.np_prime);
+	crt64.nq_prime = compat_ptr(crt32.nq_prime);
+	crt64.u_mult_inv = compat_ptr(crt32.u_mult_inv);
+	do {
+		rc = zcrypt_rsa_crt(&crt64);
+	} while (rc == -EAGAIN);
+	if (!rc)
+		rc = put_user(crt64.outputdatalength,
+			      &ucrt32->outputdatalength);
+	return rc;
+}
+
+long zcrypt_compat_ioctl(struct file *filp, unsigned int cmd,
+			 unsigned long arg)
+{
+	if (cmd == ICARSAMODEXPO)
+		return trans_modexpo32(filp, cmd, arg);
+	if (cmd == ICARSACRT)
+		return trans_modexpo_crt32(filp, cmd, arg);
+	return zcrypt_unlocked_ioctl(filp, cmd, arg);
+}
+#endif
+
+/**
+ * Misc device file operations.
+ */
+static struct file_operations zcrypt_fops = {
+	.owner		= THIS_MODULE,
+	.read		= zcrypt_read,
+	.write		= zcrypt_write,
+	.unlocked_ioctl	= zcrypt_unlocked_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= zcrypt_compat_ioctl,
+#endif
+	.open		= zcrypt_open,
+	.release	= zcrypt_release
+};
+
+/**
+ * Misc device.
+ */
+static struct miscdevice zcrypt_misc_device = {
+	.minor	    = MISC_DYNAMIC_MINOR,
+	.name	    = "z90crypt",
+	.fops	    = &zcrypt_fops,
+};
+
+/**
+ * Deprecated /proc entry support.
+ */
+static struct proc_dir_entry *zcrypt_entry;
+
+static inline int sprintcl(unsigned char *outaddr, unsigned char *addr,
+			   unsigned int len)
+{
+	int hl, i;
+
+	hl = 0;
+	for (i = 0; i < len; i++)
+		hl += sprintf(outaddr+hl, "%01x", (unsigned int) addr[i]);
+	hl += sprintf(outaddr+hl, " ");
+	return hl;
+}
+
+static inline int sprintrw(unsigned char *outaddr, unsigned char *addr,
+			   unsigned int len)
+{
+	int hl, inl, c, cx;
+
+	hl = sprintf(outaddr, "	   ");
+	inl = 0;
+	for (c = 0; c < (len / 16); c++) {
+		hl += sprintcl(outaddr+hl, addr+inl, 16);
+		inl += 16;
+	}
+	cx = len%16;
+	if (cx) {
+		hl += sprintcl(outaddr+hl, addr+inl, cx);
+		inl += cx;
+	}
+	hl += sprintf(outaddr+hl, "\n");
+	return hl;
+}
+
+static inline int sprinthx(unsigned char *title, unsigned char *outaddr,
+			   unsigned char *addr, unsigned int len)
+{
+	int hl, inl, r, rx;
+
+	hl = sprintf(outaddr, "\n%s\n", title);
+	inl = 0;
+	for (r = 0; r < (len / 64); r++) {
+		hl += sprintrw(outaddr+hl, addr+inl, 64);
+		inl += 64;
+	}
+	rx = len % 64;
+	if (rx) {
+		hl += sprintrw(outaddr+hl, addr+inl, rx);
+		inl += rx;
+	}
+	hl += sprintf(outaddr+hl, "\n");
+	return hl;
+}
+
+static inline int sprinthx4(unsigned char *title, unsigned char *outaddr,
+			    unsigned int *array, unsigned int len)
+{
+	int hl, r;
+
+	hl = sprintf(outaddr, "\n%s\n", title);
+	for (r = 0; r < len; r++) {
+		if ((r % 8) == 0)
+			hl += sprintf(outaddr+hl, "    ");
+		hl += sprintf(outaddr+hl, "%08X ", array[r]);
+		if ((r % 8) == 7)
+			hl += sprintf(outaddr+hl, "\n");
+	}
+	hl += sprintf(outaddr+hl, "\n");
+	return hl;
+}
+
+static int zcrypt_status_read(char *resp_buff, char **start, off_t offset,
+			      int count, int *eof, void *data)
+{
+	unsigned char *workarea;
+	int len;
+
+	len = 0;
+
+	/* resp_buff is a page. Use the right half for a work area */
+	workarea = resp_buff + 2000;
+	len += sprintf(resp_buff + len, "\nzcrypt version: %d.%d.%d\n",
+		ZCRYPT_VERSION, ZCRYPT_RELEASE, ZCRYPT_VARIANT);
+	len += sprintf(resp_buff + len, "Cryptographic domain: %d\n",
+		       ap_domain_index);
+	len += sprintf(resp_buff + len, "Total device count: %d\n",
+		       zcrypt_device_count);
+	len += sprintf(resp_buff + len, "PCICA count: %d\n",
+		       zcrypt_count_type(ZCRYPT_PCICA));
+	len += sprintf(resp_buff + len, "PCICC count: %d\n",
+		       zcrypt_count_type(ZCRYPT_PCICC));
+	len += sprintf(resp_buff + len, "PCIXCC MCL2 count: %d\n",
+		       zcrypt_count_type(ZCRYPT_PCIXCC_MCL2));
+	len += sprintf(resp_buff + len, "PCIXCC MCL3 count: %d\n",
+		       zcrypt_count_type(ZCRYPT_PCIXCC_MCL3));
+	len += sprintf(resp_buff + len, "CEX2C count: %d\n",
+		       zcrypt_count_type(ZCRYPT_CEX2C));
+	len += sprintf(resp_buff + len, "CEX2A count: %d\n",
+		       zcrypt_count_type(ZCRYPT_CEX2A));
+	len += sprintf(resp_buff + len, "requestq count: %d\n",
+		       zcrypt_requestq_count());
+	len += sprintf(resp_buff + len, "pendingq count: %d\n",
+		       zcrypt_pendingq_count());
+	len += sprintf(resp_buff + len, "Total open handles: %d\n\n",
+		       atomic_read(&zcrypt_open_count));
+	zcrypt_status_mask(workarea);
+	len += sprinthx("Online devices: 1=PCICA 2=PCICC 3=PCIXCC(MCL2) "
+			"4=PCIXCC(MCL3) 5=CEX2C 6=CEX2A",
+			resp_buff+len, workarea, AP_DEVICES);
+	zcrypt_qdepth_mask(workarea);
+	len += sprinthx("Waiting work element counts",
+			resp_buff+len, workarea, AP_DEVICES);
+	zcrypt_perdev_reqcnt((unsigned int *) workarea);
+	len += sprinthx4("Per-device successfully completed request counts",
+			 resp_buff+len,(unsigned int *) workarea, AP_DEVICES);
+	*eof = 1;
+	memset((void *) workarea, 0x00, AP_DEVICES * sizeof(unsigned int));
+	return len;
+}
+
+static void zcrypt_disable_card(int index)
+{
+	struct zcrypt_device *zdev;
+
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list)
+		if (AP_QID_DEVICE(zdev->ap_dev->qid) == index) {
+			zdev->online = 0;
+			ap_flush_queue(zdev->ap_dev);
+			break;
+		}
+	spin_unlock_bh(&zcrypt_device_lock);
+}
+
+static void zcrypt_enable_card(int index)
+{
+	struct zcrypt_device *zdev;
+
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list)
+		if (AP_QID_DEVICE(zdev->ap_dev->qid) == index) {
+			zdev->online = 1;
+			break;
+		}
+	spin_unlock_bh(&zcrypt_device_lock);
+}
+
+static int zcrypt_status_write(struct file *file, const char __user *buffer,
+			       unsigned long count, void *data)
+{
+	unsigned char *lbuf, *ptr;
+	unsigned long local_count;
+	int j;
+
+	if (count <= 0)
+		return 0;
+
+#define LBUFSIZE 1200UL
+	lbuf = kmalloc(LBUFSIZE, GFP_KERNEL);
+	if (!lbuf) {
+		PRINTK("kmalloc failed!\n");
+		return 0;
+	}
+
+	local_count = min(LBUFSIZE - 1, count);
+	if (copy_from_user(lbuf, buffer, local_count) != 0) {
+		kfree(lbuf);
+		return -EFAULT;
+	}
+	lbuf[local_count] = '\0';
+
+	ptr = strstr(lbuf, "Online devices");
+	if (!ptr) {
+		PRINTK("Unable to parse data (missing \"Online devices\")\n");
+		goto out;
+	}
+	ptr = strstr(ptr, "\n");
+	if (!ptr) {
+		PRINTK("Unable to parse data (missing newline "
+		       "after \"Online devices\")\n");
+		goto out;
+	}
+	ptr++;
+
+	if (strstr(ptr, "Waiting work element counts") == NULL) {
+		PRINTK("Unable to parse data (missing "
+		       "\"Waiting work element counts\")\n");
+		goto out;
+	}
+
+	for (j = 0; j < 64 && *ptr; ptr++) {
+		/**
+		 * '0' for no device, '1' for PCICA, '2' for PCICC,
+		 * '3' for PCIXCC_MCL2, '4' for PCIXCC_MCL3,
+		 * '5' for CEX2C and '6' for CEX2A'
+		 */
+		if (*ptr >= '0' && *ptr <= '6')
+			j++;
+		else if (*ptr == 'd' || *ptr == 'D')
+			zcrypt_disable_card(j++);
+		else if (*ptr == 'e' || *ptr == 'E')
+			zcrypt_enable_card(j++);
+		else if (*ptr != ' ' && *ptr != '\t')
+			break;
+	}
+out:
+	kfree(lbuf);
+	return count;
+}
+
+/**
+ * The module initialization code.
+ */
+int __init zcrypt_api_init(void)
+{
+	int rc;
+
+	/* Register the request sprayer. */
+	rc = misc_register(&zcrypt_misc_device);
+	if (rc < 0) {
+		PRINTKW(KERN_ERR "misc_register (minor %d) failed with %d\n",
+			zcrypt_misc_device.minor, rc);
+		goto out;
+	}
+
+	/* Set up the proc file system */
+	zcrypt_entry = create_proc_entry("driver/z90crypt", 0644, 0);
+	if (!zcrypt_entry) {
+		PRINTK("Couldn't create z90crypt proc entry\n");
+		rc = -ENOMEM;
+		goto out_misc;
+	}
+	zcrypt_entry->nlink = 1;
+	zcrypt_entry->data = 0;
+	zcrypt_entry->read_proc = zcrypt_status_read;
+	zcrypt_entry->write_proc = zcrypt_status_write;
+
+	return 0;
+
+out_misc:
+	misc_deregister(&zcrypt_misc_device);
+out:
+	return rc;
+}
+
+/**
+ * The module termination code.
+ */
+void __exit zcrypt_api_exit(void)
+{
+	remove_proc_entry("driver/z90crypt", 0);
+	misc_deregister(&zcrypt_misc_device);
+}
+
+#ifndef CONFIG_ZCRYPT_MONOLITHIC
+module_init(zcrypt_api_init);
+module_exit(zcrypt_api_exit);
+#endif
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_api.h linux-2.6-patched/drivers/s390/crypto/zcrypt_api.h
--- linux-2.6/drivers/s390/crypto/zcrypt_api.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_api.h	2006-07-04 18:31:35.000000000 +0200
@@ -0,0 +1,135 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_api.h
+ *
+ *  zcrypt 2.0.0
+ *
+ *  Copyright (C)  2001, 2006 IBM Corporation
+ *  Author(s): Robert Burroughs
+ *	       Eric Rossman (edrossma@us.ibm.com)
+ *	       Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
+ *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *				  Ralph Wuerthner <rwuerthn@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef _ZCRYPT_API_H_
+#define _ZCRYPT_API_H_
+
+/**
+ * Macro definitions
+ *
+ * PDEBUG debugs in the form "zcrypt: function_name -> message"
+ *
+ * PRINTK is like PDEBUG, except that it is always enabled
+ * PRINTKN is like PRINTK, except that it does not include the function name
+ * PRINTKW is like PRINTK, except that it uses KERN_WARNING
+ * PRINTKC is like PRINTK, except that it uses KERN_CRIT
+ */
+#define DEV_NAME	"zcrypt"
+
+#define PRINTK(fmt, args...) \
+	printk(KERN_DEBUG DEV_NAME ": %s -> " fmt, __FUNCTION__ , ## args)
+#define PRINTKN(fmt, args...) \
+	printk(KERN_DEBUG DEV_NAME ": " fmt, ## args)
+#define PRINTKW(fmt, args...) \
+	printk(KERN_WARNING DEV_NAME ": %s -> " fmt, __FUNCTION__ , ## args)
+#define PRINTKC(fmt, args...) \
+	printk(KERN_CRIT DEV_NAME ": %s -> " fmt, __FUNCTION__ , ## args)
+
+#ifdef ZCRYPT_DEBUG
+#define PDEBUG(fmt, args...) \
+	printk(KERN_DEBUG DEV_NAME ": %s -> " fmt, __FUNCTION__ , ## args)
+#else
+#define PDEBUG(fmt, args...) do {} while (0)
+#endif
+
+#include "ap_bus.h"
+#include <asm/zcrypt.h>
+
+/* deprecated status calls */
+#define ICAZ90STATUS		_IOR(ZCRYPT_IOCTL_MAGIC, 0x10, struct ica_z90_status)
+#define Z90STAT_PCIXCCCOUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x43, int)
+
+/**
+ * This structure is deprecated and the corresponding ioctl() has been
+ * replaced with individual ioctl()s for each piece of data!
+ */
+struct ica_z90_status {
+	int totalcount;
+	int leedslitecount; // PCICA
+	int leeds2count;    // PCICC
+	// int PCIXCCCount; is not in struct for backward compatibility
+	int requestqWaitCount;
+	int pendingqWaitCount;
+	int totalOpenCount;
+	int cryptoDomain;
+	// status: 0=not there, 1=PCICA, 2=PCICC, 3=PCIXCC_MCL2, 4=PCIXCC_MCL3,
+	//	   5=CEX2C
+	unsigned char status[64];
+	// qdepth: # work elements waiting for each device
+	unsigned char qdepth[64];
+};
+
+/**
+ * device type for an actual device is either PCICA, PCICC, PCIXCC_MCL2,
+ * PCIXCC_MCL3, CEX2C, or CEX2A
+ *
+ * NOTE: PCIXCC_MCL3 refers to a PCIXCC with May 2004 version of Licensed
+ *	 Internal Code (LIC) (EC J12220 level 29).
+ *	 PCIXCC_MCL2 refers to any LIC before this level.
+ */
+#define ZCRYPT_PCICA		1
+#define ZCRYPT_PCICC		2
+#define ZCRYPT_PCIXCC_MCL2	3
+#define ZCRYPT_PCIXCC_MCL3	4
+#define ZCRYPT_CEX2C		5
+#define ZCRYPT_CEX2A		6
+
+struct zcrypt_device;
+
+struct zcrypt_ops {
+	long (*rsa_modexpo)(struct zcrypt_device *, struct ica_rsa_modexpo *);
+	long (*rsa_modexpo_crt)(struct zcrypt_device *,
+				struct ica_rsa_modexpo_crt *);
+};
+
+struct zcrypt_device {
+	struct list_head list;		/* Device list. */
+	spinlock_t lock;		/* Per device lock. */
+	struct ap_device *ap_dev;	/* The "real" ap device. */
+	struct zcrypt_ops *ops;		/* Crypto operations. */
+	int online;			/* User online/offline */
+
+	int user_space_type;		/* User space device id. */
+	char *type_string;		/* User space device name. */
+	int min_mod_size;		/* Min number of bits. */
+	int max_mod_size;		/* Max number of bits. */
+	int short_crt;			/* Card has crt length restriction. */
+	int speed_rating;		/* Speed of the crypto device. */
+
+	int request_count;		/* # current requests. */
+
+	struct ap_message reply;	/* Per-device reply structure. */
+};
+
+int zcrypt_device_register(struct zcrypt_device *);
+void zcrypt_device_unregister(struct zcrypt_device *);
+int zcrypt_api_init(void);
+void zcrypt_api_exit(void);
+
+#endif /* _ZCRYPT_API_H_ */
diff -urpN linux-2.6/include/asm-s390/zcrypt.h linux-2.6-patched/include/asm-s390/zcrypt.h
--- linux-2.6/include/asm-s390/zcrypt.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/zcrypt.h	2006-07-04 18:31:35.000000000 +0200
@@ -0,0 +1,207 @@
+/*
+ *  include/asm-s390/zcrypt.h
+ *
+ *  zcrypt 2.0.0 (user-visible header)
+ *
+ *  Copyright (C)  2001, 2006 IBM Corporation
+ *  Author(s): Robert Burroughs
+ *	       Eric Rossman (edrossma@us.ibm.com)
+ *
+ *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_S390_ZCRYPT_H
+#define __ASM_S390_ZCRYPT_H
+
+#define ZCRYPT_VERSION 2
+#define ZCRYPT_RELEASE 1
+#define ZCRYPT_VARIANT 0
+
+#include <linux/ioctl.h>
+#include <linux/compiler.h>
+
+/**
+ * struct ica_rsa_modexpo
+ *
+ * Requirements:
+ * - outputdatalength is at least as large as inputdatalength.
+ * - All key parts are right justified in their fields, padded on
+ *   the left with zeroes.
+ * - length(b_key) = inputdatalength
+ * - length(n_modulus) = inputdatalength
+ */
+struct ica_rsa_modexpo {
+	char __user *	inputdata;
+	unsigned int	inputdatalength;
+	char __user *	outputdata;
+	unsigned int	outputdatalength;
+	char __user *	b_key;
+	char __user *	n_modulus;
+};
+
+/**
+ * struct ica_rsa_modexpo_crt
+ *
+ * Requirements:
+ * - inputdatalength is even.
+ * - outputdatalength is at least as large as inputdatalength.
+ * - All key parts are right justified in their fields, padded on
+ *   the left with zeroes.
+ * - length(bp_key)	= inputdatalength/2 + 8
+ * - length(bq_key)	= inputdatalength/2
+ * - length(np_key)	= inputdatalength/2 + 8
+ * - length(nq_key)	= inputdatalength/2
+ * - length(u_mult_inv) = inputdatalength/2 + 8
+ */
+struct ica_rsa_modexpo_crt {
+	char __user *	inputdata;
+	unsigned int	inputdatalength;
+	char __user *	outputdata;
+	unsigned int	outputdatalength;
+	char __user *	bp_key;
+	char __user *	bq_key;
+	char __user *	np_prime;
+	char __user *	nq_prime;
+	char __user *	u_mult_inv;
+};
+
+#define ZCRYPT_IOCTL_MAGIC 'z'
+
+/**
+ * Interface notes:
+ *
+ * The ioctl()s which are implemented (along with relevant details)
+ * are:
+ *
+ *   ICARSAMODEXPO
+ *     Perform an RSA operation using a Modulus-Exponent pair
+ *     This takes an ica_rsa_modexpo struct as its arg.
+ *
+ *     NOTE: please refer to the comments preceding this structure
+ *	     for the implementation details for the contents of the
+ *	     block
+ *
+ *   ICARSACRT
+ *     Perform an RSA operation using a Chinese-Remainder Theorem key
+ *     This takes an ica_rsa_modexpo_crt struct as its arg.
+ *
+ *     NOTE: please refer to the comments preceding this structure
+ *	     for the implementation details for the contents of the
+ *	     block
+ *
+ *   Z90STAT_TOTALCOUNT
+ *     Return an integer count of all device types together.
+ *
+ *   Z90STAT_PCICACOUNT
+ *     Return an integer count of all PCICAs.
+ *
+ *   Z90STAT_PCICCCOUNT
+ *     Return an integer count of all PCICCs.
+ *
+ *   Z90STAT_PCIXCCMCL2COUNT
+ *     Return an integer count of all MCL2 PCIXCCs.
+ *
+ *   Z90STAT_PCIXCCMCL3COUNT
+ *     Return an integer count of all MCL3 PCIXCCs.
+ *
+ *   Z90STAT_CEX2CCOUNT
+ *     Return an integer count of all CEX2Cs.
+ *
+ *   Z90STAT_CEX2ACOUNT
+ *     Return an integer count of all CEX2As.
+ *
+ *   Z90STAT_REQUESTQ_COUNT
+ *     Return an integer count of the number of entries waiting to be
+ *     sent to a device.
+ *
+ *   Z90STAT_PENDINGQ_COUNT
+ *     Return an integer count of the number of entries sent to a
+ *     device awaiting the reply.
+ *
+ *   Z90STAT_TOTALOPEN_COUNT
+ *     Return an integer count of the number of open file handles.
+ *
+ *   Z90STAT_DOMAIN_INDEX
+ *     Return the integer value of the Cryptographic Domain.
+ *
+ *   Z90STAT_STATUS_MASK
+ *     Return an 64 element array of unsigned chars for the status of
+ *     all devices.
+ *	 0x01: PCICA
+ *	 0x02: PCICC
+ *	 0x03: PCIXCC_MCL2
+ *	 0x04: PCIXCC_MCL3
+ *	 0x05: CEX2C
+ *	 0x06: CEX2A
+ *	 0x0d: device is disabled via the proc filesystem
+ *
+ *   Z90STAT_QDEPTH_MASK
+ *     Return an 64 element array of unsigned chars for the queue
+ *     depth of all devices.
+ *
+ *   Z90STAT_PERDEV_REQCNT
+ *     Return an 64 element array of unsigned integers for the number
+ *     of successfully completed requests per device since the device
+ *     was detected and made available.
+ *
+ *   ICAZ90STATUS (deprecated)
+ *     Return some device driver status in a ica_z90_status struct
+ *     This takes an ica_z90_status struct as its arg.
+ *
+ *     NOTE: this ioctl() is deprecated, and has been replaced with
+ *	     single ioctl()s for each type of status being requested
+ *
+ *   Z90STAT_PCIXCCCOUNT (deprecated)
+ *     Return an integer count of all PCIXCCs (MCL2 + MCL3).
+ *     This is DEPRECATED now that MCL3 PCIXCCs are treated differently from
+ *     MCL2 PCIXCCs.
+ *
+ *   Z90QUIESCE (not recommended)
+ *     Quiesce the driver.  This is intended to stop all new
+ *     requests from being processed.  Its use is NOT recommended,
+ *     except in circumstances where there is no other way to stop
+ *     callers from accessing the driver.  Its original use was to
+ *     allow the driver to be "drained" of work in preparation for
+ *     a system shutdown.
+ *
+ *     NOTE: once issued, this ban on new work cannot be undone
+ *	     except by unloading and reloading the driver.
+ */
+
+/**
+ * Supported ioctl calls
+ */
+#define ICARSAMODEXPO	_IOC(_IOC_READ|_IOC_WRITE, ZCRYPT_IOCTL_MAGIC, 0x05, 0)
+#define ICARSACRT	_IOC(_IOC_READ|_IOC_WRITE, ZCRYPT_IOCTL_MAGIC, 0x06, 0)
+
+/* New status calls */
+#define Z90STAT_TOTALCOUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x40, int)
+#define Z90STAT_PCICACOUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x41, int)
+#define Z90STAT_PCICCCOUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x42, int)
+#define Z90STAT_PCIXCCMCL2COUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x4b, int)
+#define Z90STAT_PCIXCCMCL3COUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x4c, int)
+#define Z90STAT_CEX2CCOUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x4d, int)
+#define Z90STAT_CEX2ACOUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x4e, int)
+#define Z90STAT_REQUESTQ_COUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x44, int)
+#define Z90STAT_PENDINGQ_COUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x45, int)
+#define Z90STAT_TOTALOPEN_COUNT _IOR(ZCRYPT_IOCTL_MAGIC, 0x46, int)
+#define Z90STAT_DOMAIN_INDEX	_IOR(ZCRYPT_IOCTL_MAGIC, 0x47, int)
+#define Z90STAT_STATUS_MASK	_IOR(ZCRYPT_IOCTL_MAGIC, 0x48, char[64])
+#define Z90STAT_QDEPTH_MASK	_IOR(ZCRYPT_IOCTL_MAGIC, 0x49, char[64])
+#define Z90STAT_PERDEV_REQCNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x4a, int[64])
+
+#endif /* __ASM_S390_ZCRYPT_H */
