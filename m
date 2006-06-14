Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWFNOKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWFNOKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWFNOJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:09:59 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:8111 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S964963AbWFNOJ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:09:57 -0400
Date: Wed, 14 Jun 2006 16:04:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, edrossma@us.ibm.com
Subject: [patch 17/24] s390: move z90crypt.h to include/asm.
Message-ID: <20060614140452.GR9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Rossman <edrossma@us.ibm.com>

[S390] move z90crypt.h to include/asm.

Signed-off-by: Eric Rossman <edrossma@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/z90crypt.h    |  252 --------------------------------------
 drivers/s390/crypto/z90hardware.c |    6 
 drivers/s390/crypto/z90main.c     |   48 +------
 include/asm-s390/z90crypt.h       |  227 ++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+), 291 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/z90crypt.h linux-2.6-patched/drivers/s390/crypto/z90crypt.h
--- linux-2.6/drivers/s390/crypto/z90crypt.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90crypt.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,252 +0,0 @@
-/*
- *  linux/drivers/s390/crypto/z90crypt.h
- *
- *  z90crypt 1.3.3
- *
- *  Copyright (C)  2001, 2005 IBM Corporation
- *  Author(s): Robert Burroughs (burrough@us.ibm.com)
- *             Eric Rossman (edrossma@us.ibm.com)
- *
- *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef _Z90CRYPT_H_
-#define _Z90CRYPT_H_
-
-#include <linux/ioctl.h>
-
-#define z90crypt_VERSION 1
-#define z90crypt_RELEASE 3	// 2 = PCIXCC, 3 = rewrite for coding standards
-#define z90crypt_VARIANT 3	// 3 = CEX2A support
-
-/**
- * struct ica_rsa_modexpo
- *
- * Requirements:
- * - outputdatalength is at least as large as inputdatalength.
- * - All key parts are right justified in their fields, padded on
- *   the left with zeroes.
- * - length(b_key) = inputdatalength
- * - length(n_modulus) = inputdatalength
- */
-struct ica_rsa_modexpo {
-	char __user *	inputdata;
-	unsigned int	inputdatalength;
-	char __user *	outputdata;
-	unsigned int	outputdatalength;
-	char __user *	b_key;
-	char __user *	n_modulus;
-};
-
-/**
- * struct ica_rsa_modexpo_crt
- *
- * Requirements:
- * - inputdatalength is even.
- * - outputdatalength is at least as large as inputdatalength.
- * - All key parts are right justified in their fields, padded on
- *   the left with zeroes.
- * - length(bp_key)	= inputdatalength/2 + 8
- * - length(bq_key)	= inputdatalength/2
- * - length(np_key)	= inputdatalength/2 + 8
- * - length(nq_key)	= inputdatalength/2
- * - length(u_mult_inv) = inputdatalength/2 + 8
- */
-struct ica_rsa_modexpo_crt {
-	char __user *	inputdata;
-	unsigned int	inputdatalength;
-	char __user *	outputdata;
-	unsigned int	outputdatalength;
-	char __user *	bp_key;
-	char __user *	bq_key;
-	char __user *	np_prime;
-	char __user *	nq_prime;
-	char __user *	u_mult_inv;
-};
-
-#define Z90_IOCTL_MAGIC 'z'  // NOTE:  Need to allocate from linux folks
-
-/**
- * Interface notes:
- *
- * The ioctl()s which are implemented (along with relevant details)
- * are:
- *
- *   ICARSAMODEXPO
- *     Perform an RSA operation using a Modulus-Exponent pair
- *     This takes an ica_rsa_modexpo struct as its arg.
- *
- *     NOTE: please refer to the comments preceding this structure
- *           for the implementation details for the contents of the
- *           block
- *
- *   ICARSACRT
- *     Perform an RSA operation using a Chinese-Remainder Theorem key
- *     This takes an ica_rsa_modexpo_crt struct as its arg.
- *
- *     NOTE: please refer to the comments preceding this structure
- *           for the implementation details for the contents of the
- *           block
- *
- *   Z90STAT_TOTALCOUNT
- *     Return an integer count of all device types together.
- *
- *   Z90STAT_PCICACOUNT
- *     Return an integer count of all PCICAs.
- *
- *   Z90STAT_PCICCCOUNT
- *     Return an integer count of all PCICCs.
- *
- *   Z90STAT_PCIXCCMCL2COUNT
- *     Return an integer count of all MCL2 PCIXCCs.
- *
- *   Z90STAT_PCIXCCMCL3COUNT
- *     Return an integer count of all MCL3 PCIXCCs.
- *
- *   Z90STAT_CEX2CCOUNT
- *     Return an integer count of all CEX2Cs.
- *
- *   Z90STAT_CEX2ACOUNT
- *     Return an integer count of all CEX2As.
- *
- *   Z90STAT_REQUESTQ_COUNT
- *     Return an integer count of the number of entries waiting to be
- *     sent to a device.
- *
- *   Z90STAT_PENDINGQ_COUNT
- *     Return an integer count of the number of entries sent to a
- *     device awaiting the reply.
- *
- *   Z90STAT_TOTALOPEN_COUNT
- *     Return an integer count of the number of open file handles.
- *
- *   Z90STAT_DOMAIN_INDEX
- *     Return the integer value of the Cryptographic Domain.
- *
- *   Z90STAT_STATUS_MASK
- *     Return an 64 element array of unsigned chars for the status of
- *     all devices.
- *       0x01: PCICA
- *       0x02: PCICC
- *       0x03: PCIXCC_MCL2
- *       0x04: PCIXCC_MCL3
- *       0x05: CEX2C
- *       0x06: CEX2A
- *       0x0d: device is disabled via the proc filesystem
- *
- *   Z90STAT_QDEPTH_MASK
- *     Return an 64 element array of unsigned chars for the queue
- *     depth of all devices.
- *
- *   Z90STAT_PERDEV_REQCNT
- *     Return an 64 element array of unsigned integers for the number
- *     of successfully completed requests per device since the device
- *     was detected and made available.
- *
- *   ICAZ90STATUS (deprecated)
- *     Return some device driver status in a ica_z90_status struct
- *     This takes an ica_z90_status struct as its arg.
- *
- *     NOTE: this ioctl() is deprecated, and has been replaced with
- *           single ioctl()s for each type of status being requested
- *
- *   Z90STAT_PCIXCCCOUNT (deprecated)
- *     Return an integer count of all PCIXCCs (MCL2 + MCL3).
- *     This is DEPRECATED now that MCL3 PCIXCCs are treated differently from
- *     MCL2 PCIXCCs.
- *
- *   Z90QUIESCE (not recommended)
- *     Quiesce the driver.  This is intended to stop all new
- *     requests from being processed.  Its use is NOT recommended,
- *     except in circumstances where there is no other way to stop
- *     callers from accessing the driver.  Its original use was to
- *     allow the driver to be "drained" of work in preparation for
- *     a system shutdown.
- *
- *     NOTE: once issued, this ban on new work cannot be undone
- *           except by unloading and reloading the driver.
- */
-
-/**
- * Supported ioctl calls
- */
-#define ICARSAMODEXPO	_IOC(_IOC_READ|_IOC_WRITE, Z90_IOCTL_MAGIC, 0x05, 0)
-#define ICARSACRT	_IOC(_IOC_READ|_IOC_WRITE, Z90_IOCTL_MAGIC, 0x06, 0)
-
-/* DEPRECATED status calls (bound for removal at some point) */
-#define ICAZ90STATUS	_IOR(Z90_IOCTL_MAGIC, 0x10, struct ica_z90_status)
-#define Z90STAT_PCIXCCCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x43, int)
-
-/* unrelated to ICA callers */
-#define Z90QUIESCE	_IO(Z90_IOCTL_MAGIC, 0x11)
-
-/* New status calls */
-#define Z90STAT_TOTALCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x40, int)
-#define Z90STAT_PCICACOUNT	_IOR(Z90_IOCTL_MAGIC, 0x41, int)
-#define Z90STAT_PCICCCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x42, int)
-#define Z90STAT_PCIXCCMCL2COUNT	_IOR(Z90_IOCTL_MAGIC, 0x4b, int)
-#define Z90STAT_PCIXCCMCL3COUNT	_IOR(Z90_IOCTL_MAGIC, 0x4c, int)
-#define Z90STAT_CEX2CCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x4d, int)
-#define Z90STAT_CEX2ACOUNT	_IOR(Z90_IOCTL_MAGIC, 0x4e, int)
-#define Z90STAT_REQUESTQ_COUNT	_IOR(Z90_IOCTL_MAGIC, 0x44, int)
-#define Z90STAT_PENDINGQ_COUNT	_IOR(Z90_IOCTL_MAGIC, 0x45, int)
-#define Z90STAT_TOTALOPEN_COUNT _IOR(Z90_IOCTL_MAGIC, 0x46, int)
-#define Z90STAT_DOMAIN_INDEX	_IOR(Z90_IOCTL_MAGIC, 0x47, int)
-#define Z90STAT_STATUS_MASK	_IOR(Z90_IOCTL_MAGIC, 0x48, char[64])
-#define Z90STAT_QDEPTH_MASK	_IOR(Z90_IOCTL_MAGIC, 0x49, char[64])
-#define Z90STAT_PERDEV_REQCNT	_IOR(Z90_IOCTL_MAGIC, 0x4a, int[64])
-
-/**
- * local errno definitions
- */
-#define ENOBUFF	  129	// filp->private_data->...>work_elem_p->buffer is NULL
-#define EWORKPEND 130	// user issues ioctl while another pending
-#define ERELEASED 131	// user released while ioctl pending
-#define EQUIESCE  132	// z90crypt quiescing (no more work allowed)
-#define ETIMEOUT  133	// request timed out
-#define EUNKNOWN  134	// some unrecognized error occured (retry may succeed)
-#define EGETBUFF  135	// Error getting buffer or hardware lacks capability
-			// (retry in software)
-
-/**
- * DEPRECATED STRUCTURES
- */
-
-/**
- * This structure is DEPRECATED and the corresponding ioctl() has been
- * replaced with individual ioctl()s for each piece of data!
- * This structure will NOT survive past version 1.3.1, so switch to the
- * new ioctl()s.
- */
-#define MASK_LENGTH 64 // mask length
-struct ica_z90_status {
-	int totalcount;
-	int leedslitecount; // PCICA
-	int leeds2count;    // PCICC
-	// int PCIXCCCount; is not in struct for backward compatibility
-	int requestqWaitCount;
-	int pendingqWaitCount;
-	int totalOpenCount;
-	int cryptoDomain;
-	// status: 0=not there, 1=PCICA, 2=PCICC, 3=PCIXCC_MCL2, 4=PCIXCC_MCL3,
-	//         5=CEX2C
-	unsigned char status[MASK_LENGTH];
-	// qdepth: # work elements waiting for each device
-	unsigned char qdepth[MASK_LENGTH];
-};
-
-#endif /* _Z90CRYPT_H_ */
diff -urpN linux-2.6/drivers/s390/crypto/z90hardware.c linux-2.6-patched/drivers/s390/crypto/z90hardware.c
--- linux-2.6/drivers/s390/crypto/z90hardware.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90hardware.c	2006-06-14 14:29:54.000000000 +0200
@@ -29,7 +29,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include "z90crypt.h"
+#include <asm/z90crypt.h>
 #include "z90common.h"
 
 struct cca_token_hdr {
@@ -1688,7 +1688,7 @@ ICAMEX_msg_to_type6MEX_en_msg(struct ica
 
 	temp_exp = kmalloc(256, GFP_KERNEL);
 	if (!temp_exp)
-		return EGETBUFF;
+		return ENOMEM;
 	mod_len = icaMsg_p->inputdatalength;
 	if (copy_from_user(temp_exp, icaMsg_p->b_key, mod_len)) {
 		kfree(temp_exp);
@@ -1918,7 +1918,7 @@ ICAMEX_msg_to_type6MEX_msgX(struct ica_r
 
 	temp_exp = kmalloc(256, GFP_KERNEL);
 	if (!temp_exp)
-		return EGETBUFF;
+		return ENOMEM;
 	mod_len = icaMsg_p->inputdatalength;
 	if (copy_from_user(temp_exp, icaMsg_p->b_key, mod_len)) {
 		kfree(temp_exp);
diff -urpN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2006-06-14 14:29:54.000000000 +0200
@@ -35,7 +35,7 @@
 #include <linux/moduleparam.h>
 #include <linux/proc_fs.h>
 #include <linux/syscalls.h>
-#include "z90crypt.h"
+#include <asm/z90crypt.h>
 #include "z90common.h"
 
 /**
@@ -381,7 +381,6 @@ static int z90crypt_status_write(struct 
  */
 static int domain = DOMAIN_INDEX;
 static struct z90crypt z90crypt;
-static int quiesce_z90crypt;
 static spinlock_t queuespinlock;
 static struct list_head request_list;
 static int requestq_count;
@@ -600,8 +599,6 @@ z90crypt_init_module(void)
 	INIT_LIST_HEAD(&request_list);
 	requestq_count = 0;
 
-	quiesce_z90crypt = 0;
-
 	atomic_set(&total_open, 0);
 	atomic_set(&z90crypt_step, 0);
 
@@ -704,9 +701,6 @@ z90crypt_open(struct inode *inode, struc
 {
 	struct priv_data *private_data_p;
 
-	if (quiesce_z90crypt)
-		return -EQUIESCE;
-
 	private_data_p = kzalloc(sizeof(struct priv_data), GFP_KERNEL);
 	if (!private_data_p) {
 		PRINTK("Memory allocate failed\n");
@@ -767,8 +761,6 @@ z90crypt_read(struct file *filp, char __
 
 	PDEBUG("filp %p (PID %d)\n", filp, PID());
 
-	if (quiesce_z90crypt)
-		return -EQUIESCE;
 	if (count < 0) {
 		PRINTK("Requested random byte count negative: %ld\n", count);
 		return -EINVAL;
@@ -1227,7 +1219,7 @@ z90crypt_send(struct work_element *we_p,
 	if (CHK_RDWRMASK(we_p->status[0]) != STAT_NOWORK) {
 		PDEBUG("PID %d tried to send more work but has outstanding "
 		       "work.\n", PID());
-		return -EWORKPEND;
+		return -EBUSY;
 	}
 	we_p->devindex = -1; // Reset device number
 	spin_lock_irq(&queuespinlock);
@@ -1294,7 +1286,7 @@ z90crypt_process_results(struct work_ele
 	if (!we_p->buffer) {
 		PRINTK("we_p %p PID %d in STAT_READPEND: buffer NULL.\n",
 			we_p, PID());
-		rv = -ENOBUFF;
+		rv = -ENOMEM;
 	}
 
 	if (!rv)
@@ -1607,12 +1599,12 @@ z90crypt_prepare(struct work_element *we
 		rv = -ENODEV;
 		break;
 	case SEN_NOT_AVAIL:
-	case EGETBUFF:
-		rv = -EGETBUFF;
+	case ENOMEM:
+		rv = -ENODEV;
 		break;
 	default:
 		PRINTK("rv = %d\n", rv);
-		rv = -EGETBUFF;
+		rv = -ENODEV;
 		break;
 	}
 	if (CHK_RDWRMASK(we_p->status[0]) == STAT_WRITTEN)
@@ -1676,22 +1668,21 @@ z90crypt_rsa(struct priv_data *private_d
 		/**
 		 * EINVAL *after* receive is almost always a padding error or
 		 * length error issued by a coprocessor (not an accelerator).
-		 * We convert this return value to -EGETBUFF which should
+		 * We convert this return value to -ENODEV which should
 		 * trigger a fallback to software.
 		 */
 		case -EINVAL:
 			if ((we_p->devtype != PCICA) &&
 			    (we_p->devtype != CEX2A))
-				rv = -EGETBUFF;
+				rv = -ENODEV;
 			break;
-		case -ETIMEOUT:
+		case -EIO:
 			if (z90crypt.mask.st_count > 0)
 				rv = -ERESTARTSYS; // retry with another
 			else
 				rv = -ENODEV; // no cards left
 		/* fall through to clean up request queue */
 		case -ERESTARTSYS:
-		case -ERELEASED:
 			switch (CHK_RDWRMASK(we_p->status[0])) {
 			case STAT_WRITTEN:
 				purge_work_element(we_p);
@@ -1745,10 +1736,6 @@ z90crypt_unlocked_ioctl(struct file *fil
 	switch (cmd) {
 	case ICARSAMODEXPO:
 	case ICARSACRT:
-		if (quiesce_z90crypt) {
-			ret = -EQUIESCE;
-			break;
-		}
 		ret = -ENODEV; // Default if no devices
 		loopLim = z90crypt.hdware_info->hdware_mask.st_count -
 			(z90crypt.hdware_info->hdware_mask.disabled_count +
@@ -1917,17 +1904,6 @@ z90crypt_unlocked_ioctl(struct file *fil
 			ret = -EFAULT;
 		break;
 
-	case Z90QUIESCE:
-		if (current->euid != 0) {
-			PRINTK("QUIESCE fails: euid %d\n",
-			       current->euid);
-			ret = -EACCES;
-		} else {
-			PRINTK("QUIESCE device from PID %d\n", PID());
-			quiesce_z90crypt = 1;
-		}
-		break;
-
 	default:
 		/* user passed an invalid IOCTL number */
 		PDEBUG("cmd 0x%08X contains invalid ioctl code\n", cmd);
@@ -2456,7 +2432,7 @@ helper_handle_work_element(int index, un
 			pq_p->status[0] |= STAT_FAILED;
 			break;
 	}
-	if ((pq_p->status[0] != STAT_FAILED) || (pq_p->retcode != -ERELEASED)) {
+	if (pq_p->status[0] != STAT_FAILED) {
 		pq_p->audit[1] |= FP_AWAKENING;
 		atomic_set(&pq_p->alarmrung, 1);
 		wake_up(&pq_p->waitq);
@@ -2647,7 +2623,7 @@ helper_timeout_requests(void)
 		       ((struct caller *)pq_p->requestptr)->caller_id[5],
 		       ((struct caller *)pq_p->requestptr)->caller_id[6],
 		       ((struct caller *)pq_p->requestptr)->caller_id[7]);
-		pq_p->retcode = -ETIMEOUT;
+		pq_p->retcode = -EIO;
 		pq_p->status[0] |= STAT_FAILED;
 		/* get this off any caller queue it may be on */
 		unbuild_caller(LONG2DEVPTR(pq_p->devindex),
@@ -2679,7 +2655,7 @@ helper_timeout_requests(void)
 		       ((struct caller *)pq_p->requestptr)->caller_id[5],
 		       ((struct caller *)pq_p->requestptr)->caller_id[6],
 		       ((struct caller *)pq_p->requestptr)->caller_id[7]);
-			pq_p->retcode = -ETIMEOUT;
+			pq_p->retcode = -EIO;
 			pq_p->status[0] |= STAT_FAILED;
 			list_del_init(lptr);
 			requestq_count--;
diff -urpN linux-2.6/include/asm-s390/z90crypt.h linux-2.6-patched/include/asm-s390/z90crypt.h
--- linux-2.6/include/asm-s390/z90crypt.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/z90crypt.h	2006-06-14 14:29:54.000000000 +0200
@@ -0,0 +1,227 @@
+/*
+ *  linux/drivers/s390/crypto/z90crypt.h
+ *
+ *  z90crypt 1.3.3
+ *
+ *  Copyright (C)  2001, 2005 IBM Corporation
+ *  Author(s): Robert Burroughs (burrough@us.ibm.com)
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
+#ifndef _ASM_S390_Z90CRYPT_H
+#define _ASM_S390_Z90CRYPT_H
+
+#include <linux/ioctl.h>
+#include <linux/compiler.h>
+
+#define z90crypt_VERSION 1
+#define z90crypt_RELEASE 3	// 2 = PCIXCC, 3 = rewrite for coding standards
+#define z90crypt_VARIANT 3	// 3 = CEX2A support, cleanup, sysfs interface
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
+#define Z90_IOCTL_MAGIC 'z'  // NOTE:  Need to allocate from linux folks
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
+ */
+
+/**
+ * Supported ioctl calls
+ */
+#define ICARSAMODEXPO	_IOC(_IOC_READ|_IOC_WRITE, Z90_IOCTL_MAGIC, 0x05, 0)
+#define ICARSACRT	_IOC(_IOC_READ|_IOC_WRITE, Z90_IOCTL_MAGIC, 0x06, 0)
+
+/* DEPRECATED status calls (bound for removal at some point) */
+#define ICAZ90STATUS	_IOR(Z90_IOCTL_MAGIC, 0x10, struct ica_z90_status)
+#define Z90STAT_PCIXCCCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x43, int)
+
+/* New status calls */
+#define Z90STAT_TOTALCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x40, int)
+#define Z90STAT_PCICACOUNT	_IOR(Z90_IOCTL_MAGIC, 0x41, int)
+#define Z90STAT_PCICCCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x42, int)
+#define Z90STAT_PCIXCCMCL2COUNT	_IOR(Z90_IOCTL_MAGIC, 0x4b, int)
+#define Z90STAT_PCIXCCMCL3COUNT	_IOR(Z90_IOCTL_MAGIC, 0x4c, int)
+#define Z90STAT_CEX2CCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x4d, int)
+#define Z90STAT_CEX2ACOUNT	_IOR(Z90_IOCTL_MAGIC, 0x4e, int)
+#define Z90STAT_REQUESTQ_COUNT	_IOR(Z90_IOCTL_MAGIC, 0x44, int)
+#define Z90STAT_PENDINGQ_COUNT	_IOR(Z90_IOCTL_MAGIC, 0x45, int)
+#define Z90STAT_TOTALOPEN_COUNT _IOR(Z90_IOCTL_MAGIC, 0x46, int)
+#define Z90STAT_DOMAIN_INDEX	_IOR(Z90_IOCTL_MAGIC, 0x47, int)
+#define Z90STAT_STATUS_MASK	_IOR(Z90_IOCTL_MAGIC, 0x48, char[64])
+#define Z90STAT_QDEPTH_MASK	_IOR(Z90_IOCTL_MAGIC, 0x49, char[64])
+#define Z90STAT_PERDEV_REQCNT	_IOR(Z90_IOCTL_MAGIC, 0x4a, int[64])
+
+/**
+ * DEPRECATED STRUCTURES
+ */
+
+/**
+ * This structure is DEPRECATED and the corresponding ioctl() has been
+ * replaced with individual ioctl()s for each piece of data!
+ * This structure will NOT survive past version 1.3.1, so switch to the
+ * new ioctl()s.
+ */
+#define MASK_LENGTH 64 // mask length
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
+	unsigned char status[MASK_LENGTH];
+	// qdepth: # work elements waiting for each device
+	unsigned char qdepth[MASK_LENGTH];
+};
+
+#endif /* _ASM_S390_Z90CRYPT_H */
