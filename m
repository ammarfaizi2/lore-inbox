Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWGDQxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWGDQxl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWGDQxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:53:41 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:10460 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932291AbWGDQxe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:53:34 -0400
Date: Tue, 4 Jul 2006 18:53:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, rwuerthn@de.ibm.com,
       cornelia.huck@de.ibm.com
Subject: [patch 3/6] s390: zcrypt CEX2A, CEX2C, PCICA accelerator card ap bus drivers.
Message-ID: <20060704165334.GD6202@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Ralph Wuerthner <rwuerthn@de.ibm.com>

[patch 3/6] s390: zcrypt CEX2A, CEX2C, PCICA accelerator card ap bus drivers.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_cex2a.c |  456 +++++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/zcrypt_cex2a.h |  126 ++++++++++
 drivers/s390/crypto/zcrypt_error.h |  133 ++++++++++
 drivers/s390/crypto/zcrypt_pcica.c |  439 +++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/zcrypt_pcica.h |  117 +++++++++
 5 files changed, 1271 insertions(+)

diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_cex2a.c linux-2.6-patched/drivers/s390/crypto/zcrypt_cex2a.c
--- linux-2.6/drivers/s390/crypto/zcrypt_cex2a.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_cex2a.c	2006-07-04 18:31:37.000000000 +0200
@@ -0,0 +1,456 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_cex2a.c
+ *
+ *  zcrypt 2.0.0
+ *
+ *  Copyright (C)  2001, 2006 IBM Corporation
+ *  Author(s): Robert Burroughs
+ *	       Eric Rossman (edrossma@us.ibm.com)
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
+#include <linux/err.h>
+#include <asm/atomic.h>
+#include <asm/uaccess.h>
+
+#include "ap_bus.h"
+#include "zcrypt_api.h"
+#include "zcrypt_error.h"
+#include "zcrypt_cex2a.h"
+
+#define CEX2A_MIN_MOD_SIZE	  1	/*    8 bits	*/
+#define CEX2A_MAX_MOD_SIZE	256	/* 2048 bits	*/
+
+#define CEX2A_SPEED_RATING	970
+
+#define CEX2A_MAX_MESSAGE_SIZE	0x390	/* sizeof(struct type50_crb2_msg)    */
+#define CEX2A_MAX_RESPONSE_SIZE 0x110	/* max outputdatalength + type80_hdr */
+
+#define CEX2A_CLEANUP_TIME	(15*HZ)
+
+static struct ap_device_id zcrypt_cex2a_ids[] = {
+	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2A) },
+	{ /* end of list */ },
+};
+
+#ifndef CONFIG_ZCRYPT_MONOLITHIC
+MODULE_DEVICE_TABLE(ap, zcrypt_cex2a_ids);
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("CEX2A Cryptographic Coprocessor device driver, "
+		   "Copyright 2001, 2006 IBM Corporation");
+MODULE_LICENSE("GPL");
+#endif
+
+static int zcrypt_cex2a_probe(struct ap_device *ap_dev);
+static void zcrypt_cex2a_remove(struct ap_device *ap_dev);
+static void zcrypt_cex2a_release(struct ap_device *ap_dev);
+static void zcrypt_cex2a_receive(struct ap_device *, struct ap_message *,
+				 struct ap_message *);
+
+static struct ap_driver zcrypt_cex2a_driver = {
+	.probe = zcrypt_cex2a_probe,
+	.remove = zcrypt_cex2a_remove,
+	.release = zcrypt_cex2a_release,
+	.receive = zcrypt_cex2a_receive,
+	.ids = zcrypt_cex2a_ids,
+};
+
+/**
+ * Convert a ICAMEX message to a type50 MEX message.
+ *
+ * @zdev: crypto device pointer
+ * @zreq: crypto request pointer
+ * @mex: pointer to user input data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+static int ICAMEX_msg_to_type50MEX_msg(struct zcrypt_device *zdev,
+				       struct ap_message *ap_msg,
+				       struct ica_rsa_modexpo *mex)
+{
+	unsigned char *mod, *exp, *inp;
+	int mod_len;
+
+	mod_len = mex->inputdatalength;
+
+	if (mod_len <= 128) {
+		struct type50_meb1_msg *meb1 = ap_msg->message;
+		memset(meb1, 0, sizeof(*meb1));
+		ap_msg->length = sizeof(*meb1);
+		meb1->header.msg_type_code = TYPE50_TYPE_CODE;
+		meb1->header.msg_len = sizeof(*meb1);
+		meb1->keyblock_type = TYPE50_MEB1_FMT;
+		mod = meb1->modulus + sizeof(meb1->modulus) - mod_len;
+		exp = meb1->exponent + sizeof(meb1->exponent) - mod_len;
+		inp = meb1->message + sizeof(meb1->message) - mod_len;
+	} else {
+		struct type50_meb2_msg *meb2 = ap_msg->message;
+		memset(meb2, 0, sizeof(*meb2));
+		ap_msg->length = sizeof(*meb2);
+		meb2->header.msg_type_code = TYPE50_TYPE_CODE;
+		meb2->header.msg_len = sizeof(*meb2);
+		meb2->keyblock_type = TYPE50_MEB2_FMT;
+		mod = meb2->modulus + sizeof(meb2->modulus) - mod_len;
+		exp = meb2->exponent + sizeof(meb2->exponent) - mod_len;
+		inp = meb2->message + sizeof(meb2->message) - mod_len;
+	}
+
+	if (copy_from_user(mod, mex->n_modulus, mod_len) ||
+	    copy_from_user(exp, mex->b_key, mod_len) ||
+	    copy_from_user(inp, mex->inputdata, mod_len))
+		return -EFAULT;
+	return 0;
+}
+
+/**
+ * Convert a ICACRT message to a type50 CRT message.
+ *
+ * @zdev: crypto device pointer
+ * @zreq: crypto request pointer
+ * @crt: pointer to user input data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+static int ICACRT_msg_to_type50CRT_msg(struct zcrypt_device *zdev,
+				       struct ap_message *ap_msg,
+				       struct ica_rsa_modexpo_crt *crt)
+{
+	int mod_len, short_len, long_len, long_offset;
+	unsigned char *p, *q, *dp, *dq, *u, *inp;
+
+	mod_len = crt->inputdatalength;
+	short_len = mod_len / 2;
+	long_len = mod_len / 2 + 8;
+
+	/*
+	 * CEX2A cannot handle p, dp, or U > 128 bytes.
+	 * If we have one of these, we need to do extra checking.
+	 */
+	if (long_len > 128) {
+		/*
+		 * zcrypt_rsa_crt already checked for the leading
+		 * zeroes of np_prime, bp_key and u_mult_inc.
+		 */
+		long_offset = long_len - 128;
+		long_len = 128;
+	} else
+		long_offset = 0;
+
+	/*
+	 * Instead of doing extra work for p, dp, U > 64 bytes, we'll just use
+	 * the larger message structure.
+	 */
+	if (long_len <= 64) {
+		struct type50_crb1_msg *crb1 = ap_msg->message;
+		memset(crb1, 0, sizeof(*crb1));
+		ap_msg->length = sizeof(*crb1);
+		crb1->header.msg_type_code = TYPE50_TYPE_CODE;
+		crb1->header.msg_len = sizeof(*crb1);
+		crb1->keyblock_type = TYPE50_CRB1_FMT;
+		p = crb1->p + sizeof(crb1->p) - long_len;
+		q = crb1->q + sizeof(crb1->q) - short_len;
+		dp = crb1->dp + sizeof(crb1->dp) - long_len;
+		dq = crb1->dq + sizeof(crb1->dq) - short_len;
+		u = crb1->u + sizeof(crb1->u) - long_len;
+		inp = crb1->message + sizeof(crb1->message) - mod_len;
+	} else {
+		struct type50_crb2_msg *crb2 = ap_msg->message;
+		memset(crb2, 0, sizeof(*crb2));
+		ap_msg->length = sizeof(*crb2);
+		crb2->header.msg_type_code = TYPE50_TYPE_CODE;
+		crb2->header.msg_len = sizeof(*crb2);
+		crb2->keyblock_type = TYPE50_CRB2_FMT;
+		p = crb2->p + sizeof(crb2->p) - long_len;
+		q = crb2->q + sizeof(crb2->q) - short_len;
+		dp = crb2->dp + sizeof(crb2->dp) - long_len;
+		dq = crb2->dq + sizeof(crb2->dq) - short_len;
+		u = crb2->u + sizeof(crb2->u) - long_len;
+		inp = crb2->message + sizeof(crb2->message) - mod_len;
+	}
+
+	if (copy_from_user(p, crt->np_prime + long_offset, long_len) ||
+	    copy_from_user(q, crt->nq_prime, short_len) ||
+	    copy_from_user(dp, crt->bp_key + long_offset, long_len) ||
+	    copy_from_user(dq, crt->bq_key, short_len) ||
+	    copy_from_user(u, crt->u_mult_inv + long_offset, long_len) ||
+	    copy_from_user(inp, crt->inputdata, mod_len))
+		return -EFAULT;
+
+
+	return 0;
+}
+
+/**
+ * Copy results from a type 80 reply message back to user space.
+ *
+ * @zdev: crypto device pointer
+ * @reply: reply AP message.
+ * @data: pointer to user output data
+ * @length: size of user output data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+static int convert_type80(struct zcrypt_device *zdev,
+			  struct ap_message *reply,
+			  char __user *outputdata,
+			  unsigned int outputdatalength)
+{
+	struct type80_hdr *t80h = reply->message;
+	unsigned char *data;
+
+	if (t80h->len < sizeof(*t80h) + outputdatalength) {
+		/* The result is too short, the CEX2A card may not do that.. */
+		zdev->online = 0;
+		return -EAGAIN;	/* repeat the request on a different device. */
+	}
+	BUG_ON(t80h->len > CEX2A_MAX_RESPONSE_SIZE);
+	data = reply->message + t80h->len - outputdatalength;
+	if (copy_to_user(outputdata, data, outputdatalength))
+		return -EFAULT;
+	return 0;
+}
+
+static int convert_response(struct zcrypt_device *zdev,
+			    struct ap_message *reply,
+			    char __user *outputdata,
+			    unsigned int outputdatalength)
+{
+	/* Response type byte is the second byte in the response. */
+	switch (((unsigned char *) reply->message)[1]) {
+	case TYPE82_RSP_CODE:
+	case TYPE88_RSP_CODE:
+		return convert_error(zdev, reply);
+	case TYPE80_RSP_CODE:
+		return convert_type80(zdev, reply,
+				      outputdata, outputdatalength);
+	default: /* Unknown response type, this should NEVER EVER happen */
+		PRINTK("Unrecognized Message Header: %08x%08x\n",
+		       *(unsigned int *) reply->message,
+		       *(unsigned int *) (reply->message+4));
+		zdev->online = 0;
+		return -EAGAIN;	/* repeat the request on a different device. */
+	}
+}
+
+/**
+ * This function is called from the AP bus code after a crypto request
+ * "msg" has finished with the reply message "reply".
+ * It is called from tasklet context.
+ * @ap_dev: pointer to the AP device
+ * @msg: pointer to the AP message
+ * @reply: pointer to the AP reply message
+ */
+static void zcrypt_cex2a_receive(struct ap_device *ap_dev,
+				 struct ap_message *msg,
+				 struct ap_message *reply)
+{
+	static struct error_hdr error_reply = {
+		.type = TYPE82_RSP_CODE,
+		.reply_code = REP82_ERROR_MACHINE_FAILURE,
+	};
+	struct type80_hdr *t80h = reply->message;
+	int length;
+
+	/* Copy the reply message to the request message buffer. */
+	if (IS_ERR(reply))
+		memcpy(msg->message, &error_reply, sizeof(error_reply));
+	else if (t80h->type == TYPE80_RSP_CODE) {
+		length = min(CEX2A_MAX_RESPONSE_SIZE, (int) t80h->len);
+		memcpy(msg->message, reply->message, length);
+	} else
+		memcpy(msg->message, reply->message, sizeof error_reply);
+	complete((struct completion *) msg->private);
+}
+
+static atomic_t zcrypt_step = ATOMIC_INIT(0);
+
+/**
+ * The request distributor calls this function if it picked the CEX2A
+ * device to handle a modexpo request.
+ * @zdev: pointer to zcrypt_device structure that identifies the
+ *	  CEX2A device to the request distributor
+ * @mex: pointer to the modexpo request buffer
+ */
+static long zcrypt_cex2a_modexpo(struct zcrypt_device *zdev,
+				 struct ica_rsa_modexpo *mex)
+{
+	struct ap_message ap_msg;
+	struct completion work;
+	int rc;
+
+	ap_msg.message = (void *) kmalloc(CEX2A_MAX_MESSAGE_SIZE, GFP_KERNEL);
+	if (!ap_msg.message)
+		return -ENOMEM;
+	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
+				atomic_inc_return(&zcrypt_step);
+	ap_msg.private = &work;
+	rc = ICAMEX_msg_to_type50MEX_msg(zdev, &ap_msg, mex);
+	if (rc)
+		goto out_free;
+	init_completion(&work);
+	ap_queue_message(zdev->ap_dev, &ap_msg);
+	rc = wait_for_completion_interruptible_timeout(
+				&work, CEX2A_CLEANUP_TIME);
+	if (rc > 0)
+		rc = convert_response(zdev, &ap_msg, mex->outputdata,
+				      mex->outputdatalength);
+	else {
+		/* Signal pending or message timed out. */
+		ap_cancel_message(zdev->ap_dev, &ap_msg);
+		if (rc == 0)
+			/* Message timed out. */
+			rc = -ETIME;
+	}
+out_free:
+	kfree(ap_msg.message);
+	return rc;
+}
+
+/**
+ * The request distributor calls this function if it picked the CEX2A
+ * device to handle a modexpo_crt request.
+ * @zdev: pointer to zcrypt_device structure that identifies the
+ *	  CEX2A device to the request distributor
+ * @crt: pointer to the modexpoc_crt request buffer
+ */
+static long zcrypt_cex2a_modexpo_crt(struct zcrypt_device *zdev,
+				     struct ica_rsa_modexpo_crt *crt)
+{
+	struct ap_message ap_msg;
+	struct completion work;
+	int rc;
+
+	ap_msg.message = (void *) kmalloc(CEX2A_MAX_MESSAGE_SIZE, GFP_KERNEL);
+	if (!ap_msg.message)
+		return -ENOMEM;
+	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
+				atomic_inc_return(&zcrypt_step);
+	ap_msg.private = &work;
+	rc = ICACRT_msg_to_type50CRT_msg(zdev, &ap_msg, crt);
+	if (rc)
+		goto out_free;
+	init_completion(&work);
+	ap_queue_message(zdev->ap_dev, &ap_msg);
+	rc = wait_for_completion_interruptible_timeout(
+				&work, CEX2A_CLEANUP_TIME);
+	if (rc > 0)
+		rc = convert_response(zdev, &ap_msg, crt->outputdata,
+				      crt->outputdatalength);
+	else {
+		/* Signal pending or message timed out. */
+		ap_cancel_message(zdev->ap_dev, &ap_msg);
+		if (rc == 0)
+			/* Message timed out. */
+			rc = -ETIME;
+	}
+out_free:
+	kfree(ap_msg.message);
+	return rc;
+}
+
+/**
+ * The crypto operations for a CEX2A card.
+ */
+static struct zcrypt_ops zcrypt_cex2a_ops = {
+	.rsa_modexpo = zcrypt_cex2a_modexpo,
+	.rsa_modexpo_crt = zcrypt_cex2a_modexpo_crt,
+};
+
+/**
+ * Probe function for CEX2A cards. It always accepts the AP device
+ * since the bus_match already checked the hardware type.
+ * @ap_dev: pointer to the AP device.
+ */
+static int zcrypt_cex2a_probe(struct ap_device *ap_dev)
+{
+	struct zcrypt_device *zdev;
+	int rc;
+
+	zdev = kzalloc(sizeof(*zdev), GFP_KERNEL);
+	if (!zdev)
+		return -ENOMEM;
+	spin_lock_init(&zdev->lock);
+	INIT_LIST_HEAD(&zdev->list);
+	zdev->ap_dev = ap_dev;
+	zdev->ops = &zcrypt_cex2a_ops;
+	zdev->online = 1;
+	zdev->user_space_type = ZCRYPT_CEX2A;
+	zdev->type_string = "CEX2A";
+	zdev->min_mod_size = CEX2A_MIN_MOD_SIZE;
+	zdev->max_mod_size = CEX2A_MAX_MOD_SIZE;
+	zdev->short_crt = 1;
+	zdev->speed_rating = CEX2A_SPEED_RATING;
+	zdev->reply.message = kmalloc(CEX2A_MAX_RESPONSE_SIZE, GFP_KERNEL);
+	if (!zdev->reply.message) {
+		rc = -ENOMEM;
+		goto out_free;
+	}
+	zdev->reply.length = CEX2A_MAX_RESPONSE_SIZE;
+	ap_dev->reply = &zdev->reply;
+	ap_dev->private = zdev;
+	rc = zcrypt_device_register(zdev);
+	if (rc)
+		goto out_free;
+	return 0;
+
+out_free:
+	ap_dev->private = NULL;
+	kfree(zdev);
+	return rc;
+}
+
+/**
+ * This is called to remove the extended CEX2A driver information
+ * if an AP device is removed.
+ */
+static void zcrypt_cex2a_remove(struct ap_device *ap_dev)
+{
+	struct zcrypt_device *zdev = ap_dev->private;
+
+	zcrypt_device_unregister(zdev);
+}
+
+/**
+ * This is called to release the extended CEX2A driver information
+ * if an AP device is release.
+ */
+static void zcrypt_cex2a_release(struct ap_device *ap_dev)
+{
+	struct zcrypt_device *zdev = ap_dev->private;
+
+	kfree(zdev);
+}
+
+int __init zcrypt_cex2a_init(void)
+{
+	return ap_driver_register(&zcrypt_cex2a_driver, THIS_MODULE, "cex2a");
+}
+
+void __exit zcrypt_cex2a_exit(void)
+{
+	ap_driver_unregister(&zcrypt_cex2a_driver);
+}
+
+#ifndef CONFIG_ZCRYPT_MONOLITHIC
+module_init(zcrypt_cex2a_init);
+module_exit(zcrypt_cex2a_exit);
+#endif
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_cex2a.h linux-2.6-patched/drivers/s390/crypto/zcrypt_cex2a.h
--- linux-2.6/drivers/s390/crypto/zcrypt_cex2a.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_cex2a.h	2006-07-04 18:31:37.000000000 +0200
@@ -0,0 +1,126 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_cex2a.h
+ *
+ *  zcrypt 2.0.0
+ *
+ *  Copyright (C)  2001, 2006 IBM Corporation
+ *  Author(s): Robert Burroughs
+ *	       Eric Rossman (edrossma@us.ibm.com)
+ *
+ *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
+ *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
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
+#ifndef _ZCRYPT_CEX2A_H_
+#define _ZCRYPT_CEX2A_H_
+
+/**
+ * The type 50 message family is associated with a CEX2A card.
+ *
+ * The four members of the family are described below.
+ *
+ * Note that all unsigned char arrays are right-justified and left-padded
+ * with zeroes.
+ *
+ * Note that all reserved fields must be zeroes.
+ */
+struct type50_hdr {
+	unsigned char	reserved1;
+	unsigned char	msg_type_code;	/* 0x50 */
+	unsigned short	msg_len;
+	unsigned char	reserved2;
+	unsigned char	ignored;
+	unsigned short	reserved3;
+} __attribute__((packed));
+
+#define TYPE50_TYPE_CODE	0x50
+
+#define TYPE50_MEB1_FMT		0x0001
+#define TYPE50_MEB2_FMT		0x0002
+#define TYPE50_CRB1_FMT		0x0011
+#define TYPE50_CRB2_FMT		0x0012
+
+/* Mod-Exp, with a small modulus */
+struct type50_meb1_msg {
+	struct type50_hdr header;
+	unsigned short	keyblock_type;	/* 0x0001 */
+	unsigned char	reserved[6];
+	unsigned char	exponent[128];
+	unsigned char	modulus[128];
+	unsigned char	message[128];
+} __attribute__((packed));
+
+/* Mod-Exp, with a large modulus */
+struct type50_meb2_msg {
+	struct type50_hdr header;
+	unsigned short	keyblock_type;	/* 0x0002 */
+	unsigned char	reserved[6];
+	unsigned char	exponent[256];
+	unsigned char	modulus[256];
+	unsigned char	message[256];
+} __attribute__((packed));
+
+/* CRT, with a small modulus */
+struct type50_crb1_msg {
+	struct type50_hdr header;
+	unsigned short	keyblock_type;	/* 0x0011 */
+	unsigned char	reserved[6];
+	unsigned char	p[64];
+	unsigned char	q[64];
+	unsigned char	dp[64];
+	unsigned char	dq[64];
+	unsigned char	u[64];
+	unsigned char	message[128];
+} __attribute__((packed));
+
+/* CRT, with a large modulus */
+struct type50_crb2_msg {
+	struct type50_hdr header;
+	unsigned short	keyblock_type;	/* 0x0012 */
+	unsigned char	reserved[6];
+	unsigned char	p[128];
+	unsigned char	q[128];
+	unsigned char	dp[128];
+	unsigned char	dq[128];
+	unsigned char	u[128];
+	unsigned char	message[256];
+} __attribute__((packed));
+
+/**
+ * The type 80 response family is associated with a CEX2A card.
+ *
+ * Note that all unsigned char arrays are right-justified and left-padded
+ * with zeroes.
+ *
+ * Note that all reserved fields must be zeroes.
+ */
+
+#define TYPE80_RSP_CODE 0x80
+
+struct type80_hdr {
+	unsigned char	reserved1;
+	unsigned char	type;		/* 0x80 */
+	unsigned short	len;
+	unsigned char	code;		/* 0x00 */
+	unsigned char	reserved2[3];
+	unsigned char	reserved3[8];
+} __attribute__((packed));
+
+int zcrypt_cex2a_init(void);
+void zcrypt_cex2a_exit(void);
+
+#endif /* _ZCRYPT_CEX2A_H_ */
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_error.h linux-2.6-patched/drivers/s390/crypto/zcrypt_error.h
--- linux-2.6/drivers/s390/crypto/zcrypt_error.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_error.h	2006-07-04 18:31:37.000000000 +0200
@@ -0,0 +1,133 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_error.h
+ *
+ *  zcrypt 2.0.0
+ *
+ *  Copyright (C)  2001, 2006 IBM Corporation
+ *  Author(s): Robert Burroughs
+ *	       Eric Rossman (edrossma@us.ibm.com)
+ *
+ *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
+ *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
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
+#ifndef _ZCRYPT_ERROR_H_
+#define _ZCRYPT_ERROR_H_
+
+#include "zcrypt_api.h"
+
+/**
+ * Reply Messages
+ *
+ * Error reply messages are of two types:
+ *    82:  Error (see below)
+ *    88:  Error (see below)
+ * Both type 82 and type 88 have the same structure in the header.
+ *
+ * Request reply messages are of three known types:
+ *    80:  Reply from a Type 50 Request (see CEX2A-RELATED STRUCTS)
+ *    84:  Reply from a Type 4 Request (see PCICA-RELATED STRUCTS)
+ *    86:  Reply from a Type 6 Request (see PCICC/PCIXCC/CEX2C-RELATED STRUCTS)
+ *
+ */
+struct error_hdr {
+	unsigned char reserved1;	/* 0x00			*/
+	unsigned char type;		/* 0x82 or 0x88		*/
+	unsigned char reserved2[2];	/* 0x0000		*/
+	unsigned char reply_code;	/* reply code		*/
+	unsigned char reserved3[3];	/* 0x000000		*/
+};
+
+#define TYPE82_RSP_CODE 0x82
+#define TYPE88_RSP_CODE 0x88
+
+#define REP82_ERROR_MACHINE_FAILURE  0x10
+#define REP82_ERROR_PREEMPT_FAILURE  0x12
+#define REP82_ERROR_CHECKPT_FAILURE  0x14
+#define REP82_ERROR_MESSAGE_TYPE     0x20
+#define REP82_ERROR_INVALID_COMM_CD  0x21	/* Type 84	*/
+#define REP82_ERROR_INVALID_MSG_LEN  0x23
+#define REP82_ERROR_RESERVD_FIELD    0x24	/* was 0x50	*/
+#define REP82_ERROR_FORMAT_FIELD     0x29
+#define REP82_ERROR_INVALID_COMMAND  0x30
+#define REP82_ERROR_MALFORMED_MSG    0x40
+#define REP82_ERROR_RESERVED_FIELDO  0x50	/* old value	*/
+#define REP82_ERROR_WORD_ALIGNMENT   0x60
+#define REP82_ERROR_MESSAGE_LENGTH   0x80
+#define REP82_ERROR_OPERAND_INVALID  0x82
+#define REP82_ERROR_OPERAND_SIZE     0x84
+#define REP82_ERROR_EVEN_MOD_IN_OPND 0x85
+#define REP82_ERROR_RESERVED_FIELD   0x88
+#define REP82_ERROR_TRANSPORT_FAIL   0x90
+#define REP82_ERROR_PACKET_TRUNCATED 0xA0
+#define REP82_ERROR_ZERO_BUFFER_LEN  0xB0
+
+#define REP88_ERROR_MODULE_FAILURE   0x10
+
+#define REP88_ERROR_MESSAGE_TYPE     0x20
+#define REP88_ERROR_MESSAGE_MALFORMD 0x22
+#define REP88_ERROR_MESSAGE_LENGTH   0x23
+#define REP88_ERROR_RESERVED_FIELD   0x24
+#define REP88_ERROR_KEY_TYPE	     0x34
+#define REP88_ERROR_INVALID_KEY      0x82	/* CEX2A	*/
+#define REP88_ERROR_OPERAND	     0x84	/* CEX2A	*/
+#define REP88_ERROR_OPERAND_EVEN_MOD 0x85	/* CEX2A	*/
+
+static inline int convert_error(struct zcrypt_device *zdev,
+				struct ap_message *reply)
+{
+	struct error_hdr *ehdr = reply->message;
+
+	PRINTK("Hardware error : Type %02x Message Header: %08x%08x\n",
+	       ehdr->type, *(unsigned int *) reply->message,
+	       *(unsigned int *) (reply->message + 4));
+
+	switch (ehdr->reply_code) {
+	case REP82_ERROR_OPERAND_INVALID:
+	case REP82_ERROR_OPERAND_SIZE:
+	case REP82_ERROR_EVEN_MOD_IN_OPND:
+	case REP88_ERROR_MESSAGE_MALFORMD:
+	//   REP88_ERROR_INVALID_KEY		// '82' CEX2A
+	//   REP88_ERROR_OPERAND		// '84' CEX2A
+	//   REP88_ERROR_OPERAND_EVEN_MOD	// '85' CEX2A
+		/* Invalid input data. */
+		return -EINVAL;
+	case REP82_ERROR_MESSAGE_TYPE:
+	//   REP88_ERROR_MESSAGE_TYPE		// '20' CEX2A
+		/**
+		 * To sent a message of the wrong type is a bug in the
+		 * device driver. Warn about it, disable the device
+		 * and then repeat the request.
+		 */
+		WARN_ON(1);
+		zdev->online = 0;
+		return -EAGAIN;
+	case REP82_ERROR_TRANSPORT_FAIL:
+	case REP82_ERROR_MACHINE_FAILURE:
+	//   REP88_ERROR_MODULE_FAILURE		// '10' CEX2A
+		/* If a card fails disable it and repeat the request. */
+		zdev->online = 0;
+		return -EAGAIN;
+	default:
+		PRINTKW("unknown type %02x reply code = %d\n",
+			ehdr->type, ehdr->reply_code);
+		zdev->online = 0;
+		return -EAGAIN;	/* repeat the request on a different device. */
+	}
+}
+
+#endif /* _ZCRYPT_ERROR_H_ */
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcica.c linux-2.6-patched/drivers/s390/crypto/zcrypt_pcica.c
--- linux-2.6/drivers/s390/crypto/zcrypt_pcica.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcica.c	2006-07-04 18:31:37.000000000 +0200
@@ -0,0 +1,439 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_pcica.c
+ *
+ *  zcrypt 2.0.0
+ *
+ *  Copyright (C)  2001, 2006 IBM Corporation
+ *  Author(s): Robert Burroughs
+ *	       Eric Rossman (edrossma@us.ibm.com)
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
+#include <linux/err.h>
+#include <asm/atomic.h>
+#include <asm/uaccess.h>
+
+#include "ap_bus.h"
+#include "zcrypt_api.h"
+#include "zcrypt_error.h"
+#include "zcrypt_pcica.h"
+
+#define PCICA_MIN_MOD_SIZE	  1	/*    8 bits	*/
+#define PCICA_MAX_MOD_SIZE	256	/* 2048 bits	*/
+
+#define PCICA_SPEED_RATING	2800
+
+#define PCICA_MAX_MESSAGE_SIZE	0x3a0	/* sizeof(struct type4_lcr)	     */
+#define PCICA_MAX_RESPONSE_SIZE 0x110	/* max outputdatalength + type80_hdr */
+
+#define PCICA_CLEANUP_TIME	(15*HZ)
+
+static struct ap_device_id zcrypt_pcica_ids[] = {
+	{ AP_DEVICE(AP_DEVICE_TYPE_PCICA) },
+	{ /* end of list */ },
+};
+
+#ifndef CONFIG_ZCRYPT_MONOLITHIC
+MODULE_DEVICE_TABLE(ap, zcrypt_pcica_ids);
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("PCICA Cryptographic Coprocessor device driver, "
+		   "Copyright 2001, 2006 IBM Corporation");
+MODULE_LICENSE("GPL");
+#endif
+
+static int zcrypt_pcica_probe(struct ap_device *ap_dev);
+static void zcrypt_pcica_remove(struct ap_device *ap_dev);
+static void zcrypt_pcica_release(struct ap_device *ap_dev);
+static void zcrypt_pcica_receive(struct ap_device *, struct ap_message *,
+				 struct ap_message *);
+
+static struct ap_driver zcrypt_pcica_driver = {
+	.probe = zcrypt_pcica_probe,
+	.remove = zcrypt_pcica_remove,
+	.release = zcrypt_pcica_release,
+	.receive = zcrypt_pcica_receive,
+	.ids = zcrypt_pcica_ids,
+};
+
+/**
+ * Convert a ICAMEX message to a type4 MEX message.
+ *
+ * @zdev: crypto device pointer
+ * @zreq: crypto request pointer
+ * @mex: pointer to user input data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+static int ICAMEX_msg_to_type4MEX_msg(struct zcrypt_device *zdev,
+				      struct ap_message *ap_msg,
+				      struct ica_rsa_modexpo *mex)
+{
+	unsigned char *modulus, *exponent, *message;
+	int mod_len;
+
+	mod_len = mex->inputdatalength;
+
+	if (mod_len <= 128) {
+		struct type4_sme *sme = ap_msg->message;
+		memset(sme, 0, sizeof(*sme));
+		ap_msg->length = sizeof(*sme);
+		sme->header.msg_fmt = TYPE4_SME_FMT;
+		sme->header.msg_len = sizeof(*sme);
+		sme->header.msg_type_code = TYPE4_TYPE_CODE;
+		sme->header.request_code = TYPE4_REQU_CODE;
+		modulus = sme->modulus + sizeof(sme->modulus) - mod_len;
+		exponent = sme->exponent + sizeof(sme->exponent) - mod_len;
+		message = sme->message + sizeof(sme->message) - mod_len;
+	} else {
+		struct type4_lme *lme = ap_msg->message;
+		memset(lme, 0, sizeof(*lme));
+		ap_msg->length = sizeof(*lme);
+		lme->header.msg_fmt = TYPE4_LME_FMT;
+		lme->header.msg_len = sizeof(*lme);
+		lme->header.msg_type_code = TYPE4_TYPE_CODE;
+		lme->header.request_code = TYPE4_REQU_CODE;
+		modulus = lme->modulus + sizeof(lme->modulus) - mod_len;
+		exponent = lme->exponent + sizeof(lme->exponent) - mod_len;
+		message = lme->message + sizeof(lme->message) - mod_len;
+	}
+
+	if (copy_from_user(modulus, mex->n_modulus, mod_len) ||
+	    copy_from_user(exponent, mex->b_key, mod_len) ||
+	    copy_from_user(message, mex->inputdata, mod_len))
+		return -EFAULT;
+	return 0;
+}
+
+/**
+ * Convert a ICACRT message to a type4 CRT message.
+ *
+ * @zdev: crypto device pointer
+ * @zreq: crypto request pointer
+ * @crt: pointer to user input data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+static int ICACRT_msg_to_type4CRT_msg(struct zcrypt_device *zdev,
+				      struct ap_message *ap_msg,
+				      struct ica_rsa_modexpo_crt *crt)
+{
+	unsigned char *p, *q, *dp, *dq, *u, *inp;
+	int mod_len, short_len, long_len;
+
+	mod_len = crt->inputdatalength;
+	short_len = mod_len / 2;
+	long_len = mod_len / 2 + 8;
+
+	if (mod_len <= 128) {
+		struct type4_scr *scr = ap_msg->message;
+		memset(scr, 0, sizeof(*scr));
+		ap_msg->length = sizeof(*scr);
+		scr->header.msg_type_code = TYPE4_TYPE_CODE;
+		scr->header.request_code = TYPE4_REQU_CODE;
+		scr->header.msg_fmt = TYPE4_SCR_FMT;
+		scr->header.msg_len = sizeof(*scr);
+		p = scr->p + sizeof(scr->p) - long_len;
+		q = scr->q + sizeof(scr->q) - short_len;
+		dp = scr->dp + sizeof(scr->dp) - long_len;
+		dq = scr->dq + sizeof(scr->dq) - short_len;
+		u = scr->u + sizeof(scr->u) - long_len;
+		inp = scr->message + sizeof(scr->message) - mod_len;
+	} else {
+		struct type4_lcr *lcr = ap_msg->message;
+		memset(lcr, 0, sizeof(*lcr));
+		ap_msg->length = sizeof(*lcr);
+		lcr->header.msg_type_code = TYPE4_TYPE_CODE;
+		lcr->header.request_code = TYPE4_REQU_CODE;
+		lcr->header.msg_fmt = TYPE4_LCR_FMT;
+		lcr->header.msg_len = sizeof(*lcr);
+		p = lcr->p + sizeof(lcr->p) - long_len;
+		q = lcr->q + sizeof(lcr->q) - short_len;
+		dp = lcr->dp + sizeof(lcr->dp) - long_len;
+		dq = lcr->dq + sizeof(lcr->dq) - short_len;
+		u = lcr->u + sizeof(lcr->u) - long_len;
+		inp = lcr->message + sizeof(lcr->message) - mod_len;
+	}
+
+	if (copy_from_user(p, crt->np_prime, long_len) ||
+	    copy_from_user(q, crt->nq_prime, short_len) ||
+	    copy_from_user(dp, crt->bp_key, long_len) ||
+	    copy_from_user(dq, crt->bq_key, short_len) ||
+	    copy_from_user(u, crt->u_mult_inv, long_len) ||
+	    copy_from_user(inp, crt->inputdata, mod_len))
+		return -EFAULT;
+	return 0;
+}
+
+/**
+ * Copy results from a type 84 reply message back to user space.
+ *
+ * @zdev: crypto device pointer
+ * @reply: reply AP message.
+ * @data: pointer to user output data
+ * @length: size of user output data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+static inline int convert_type84(struct zcrypt_device *zdev,
+				 struct ap_message *reply,
+				 char __user *outputdata,
+				 unsigned int outputdatalength)
+{
+	struct type84_hdr *t84h = reply->message;
+	char *data;
+
+	if (t84h->len < sizeof(*t84h) + outputdatalength) {
+		/* The result is too short, the PCICA card may not do that.. */
+		zdev->online = 0;
+		return -EAGAIN;	/* repeat the request on a different device. */
+	}
+	BUG_ON(t84h->len > PCICA_MAX_RESPONSE_SIZE);
+	data = reply->message + t84h->len - outputdatalength;
+	if (copy_to_user(outputdata, data, outputdatalength))
+		return -EFAULT;
+	return 0;
+}
+
+static int convert_response(struct zcrypt_device *zdev,
+			    struct ap_message *reply,
+			    char __user *outputdata,
+			    unsigned int outputdatalength)
+{
+	/* Response type byte is the second byte in the response. */
+	switch (((unsigned char *) reply->message)[1]) {
+	case TYPE82_RSP_CODE:
+	case TYPE88_RSP_CODE:
+		return convert_error(zdev, reply);
+	case TYPE84_RSP_CODE:
+		return convert_type84(zdev, reply,
+				      outputdata, outputdatalength);
+	default: /* Unknown response type, this should NEVER EVER happen */
+		PRINTK("Unrecognized Message Header: %08x%08x\n",
+		       *(unsigned int *) reply->message,
+		       *(unsigned int *) (reply->message+4));
+		zdev->online = 0;
+		return -EAGAIN;	/* repeat the request on a different device. */
+	}
+}
+
+/**
+ * This function is called from the AP bus code after a crypto request
+ * "msg" has finished with the reply message "reply".
+ * It is called from tasklet context.
+ * @ap_dev: pointer to the AP device
+ * @msg: pointer to the AP message
+ * @reply: pointer to the AP reply message
+ */
+static void zcrypt_pcica_receive(struct ap_device *ap_dev,
+				 struct ap_message *msg,
+				 struct ap_message *reply)
+{
+	static struct error_hdr error_reply = {
+		.type = TYPE82_RSP_CODE,
+		.reply_code = REP82_ERROR_MACHINE_FAILURE,
+	};
+	struct type84_hdr *t84h = reply->message;
+	int length;
+
+	/* Copy the reply message to the request message buffer. */
+	if (IS_ERR(reply))
+		memcpy(msg->message, &error_reply, sizeof(error_reply));
+	else if (t84h->code == TYPE84_RSP_CODE) {
+		length = min(PCICA_MAX_RESPONSE_SIZE, (int) t84h->len);
+		memcpy(msg->message, reply->message, length);
+	} else
+		memcpy(msg->message, reply->message, sizeof error_reply);
+	complete((struct completion *) msg->private);
+}
+
+static atomic_t zcrypt_step = ATOMIC_INIT(0);
+
+/**
+ * The request distributor calls this function if it picked the PCICA
+ * device to handle a modexpo request.
+ * @zdev: pointer to zcrypt_device structure that identifies the
+ *	  PCICA device to the request distributor
+ * @mex: pointer to the modexpo request buffer
+ */
+static long zcrypt_pcica_modexpo(struct zcrypt_device *zdev,
+				 struct ica_rsa_modexpo *mex)
+{
+	struct ap_message ap_msg;
+	struct completion work;
+	int rc;
+
+	ap_msg.message = (void *) kmalloc(PCICA_MAX_MESSAGE_SIZE, GFP_KERNEL);
+	if (!ap_msg.message)
+		return -ENOMEM;
+	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
+				atomic_inc_return(&zcrypt_step);
+	ap_msg.private = &work;
+	rc = ICAMEX_msg_to_type4MEX_msg(zdev, &ap_msg, mex);
+	if (rc)
+		goto out_free;
+	init_completion(&work);
+	ap_queue_message(zdev->ap_dev, &ap_msg);
+	rc = wait_for_completion_interruptible_timeout(
+				&work, PCICA_CLEANUP_TIME);
+	if (rc > 0)
+		rc = convert_response(zdev, &ap_msg, mex->outputdata,
+				      mex->outputdatalength);
+	else {
+		/* Signal pending or message timed out. */
+		ap_cancel_message(zdev->ap_dev, &ap_msg);
+		if (rc == 0)
+			/* Message timed out. */
+			rc = -ETIME;
+	}
+out_free:
+	kfree(ap_msg.message);
+	return rc;
+}
+
+/**
+ * The request distributor calls this function if it picked the PCICA
+ * device to handle a modexpo_crt request.
+ * @zdev: pointer to zcrypt_device structure that identifies the
+ *	  PCICA device to the request distributor
+ * @crt: pointer to the modexpoc_crt request buffer
+ */
+static long zcrypt_pcica_modexpo_crt(struct zcrypt_device *zdev,
+				     struct ica_rsa_modexpo_crt *crt)
+{
+	struct ap_message ap_msg;
+	struct completion work;
+	int rc;
+
+	ap_msg.message = (void *) kmalloc(PCICA_MAX_MESSAGE_SIZE, GFP_KERNEL);
+	if (!ap_msg.message)
+		return -ENOMEM;
+	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
+				atomic_inc_return(&zcrypt_step);
+	ap_msg.private = &work;
+	rc = ICACRT_msg_to_type4CRT_msg(zdev, &ap_msg, crt);
+	if (rc)
+		goto out_free;
+	init_completion(&work);
+	ap_queue_message(zdev->ap_dev, &ap_msg);
+	rc = wait_for_completion_interruptible_timeout(
+				&work, PCICA_CLEANUP_TIME);
+	if (rc > 0)
+		rc = convert_response(zdev, &ap_msg, crt->outputdata,
+				      crt->outputdatalength);
+	else {
+		/* Signal pending or message timed out. */
+		ap_cancel_message(zdev->ap_dev, &ap_msg);
+		if (rc == 0)
+			/* Message timed out. */
+			rc = -ETIME;
+	}
+out_free:
+	kfree(ap_msg.message);
+	return rc;
+}
+
+/**
+ * The crypto operations for a PCICA card.
+ */
+static struct zcrypt_ops zcrypt_pcica_ops = {
+	.rsa_modexpo = zcrypt_pcica_modexpo,
+	.rsa_modexpo_crt = zcrypt_pcica_modexpo_crt,
+};
+
+/**
+ * Probe function for PCICA cards. It always accepts the AP device
+ * since the bus_match already checked the hardware type.
+ * @ap_dev: pointer to the AP device.
+ */
+static int zcrypt_pcica_probe(struct ap_device *ap_dev)
+{
+	struct zcrypt_device *zdev;
+	int rc;
+
+	zdev = kzalloc(sizeof(*zdev), GFP_KERNEL);
+	if (!zdev)
+		return -ENOMEM;
+	spin_lock_init(&zdev->lock);
+	INIT_LIST_HEAD(&zdev->list);
+	zdev->ap_dev = ap_dev;
+	zdev->ops = &zcrypt_pcica_ops;
+	zdev->online = 1;
+	zdev->user_space_type = ZCRYPT_PCICA;
+	zdev->type_string = "PCICA";
+	zdev->min_mod_size = PCICA_MIN_MOD_SIZE;
+	zdev->max_mod_size = PCICA_MAX_MOD_SIZE;
+	zdev->speed_rating = PCICA_SPEED_RATING;
+	zdev->reply.message = kmalloc(PCICA_MAX_RESPONSE_SIZE, GFP_KERNEL);
+	if (!zdev->reply.message) {
+		rc = -ENOMEM;
+		goto out_free;
+	}
+	zdev->reply.length = PCICA_MAX_RESPONSE_SIZE;
+	ap_dev->reply = &zdev->reply;
+	ap_dev->private = zdev;
+	rc = zcrypt_device_register(zdev);
+	if (rc)
+		goto out_free;
+	return 0;
+
+out_free:
+	ap_dev->private = NULL;
+	kfree(zdev);
+	return rc;
+}
+
+/**
+ * This is called to remove the extended PCICA driver information
+ * if an AP device is removed.
+ */
+static void zcrypt_pcica_remove(struct ap_device *ap_dev)
+{
+	struct zcrypt_device *zdev = ap_dev->private;
+
+	zcrypt_device_unregister(zdev);
+}
+
+/**
+ * This is called to release the extended PCICA driver information
+ * if an AP device is release.
+ */
+static void zcrypt_pcica_release(struct ap_device *ap_dev)
+{
+	struct zcrypt_device *zdev = ap_dev->private;
+
+	kfree(zdev);
+}
+
+int __init zcrypt_pcica_init(void)
+{
+	return ap_driver_register(&zcrypt_pcica_driver, THIS_MODULE, "pcica");
+}
+
+void __exit zcrypt_pcica_exit(void)
+{
+	ap_driver_unregister(&zcrypt_pcica_driver);
+}
+
+#ifndef CONFIG_ZCRYPT_MONOLITHIC
+module_init(zcrypt_pcica_init);
+module_exit(zcrypt_pcica_exit);
+#endif
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcica.h linux-2.6-patched/drivers/s390/crypto/zcrypt_pcica.h
--- linux-2.6/drivers/s390/crypto/zcrypt_pcica.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcica.h	2006-07-04 18:31:37.000000000 +0200
@@ -0,0 +1,117 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_pcica.h
+ *
+ *  zcrypt 2.0.0
+ *
+ *  Copyright (C)  2001, 2006 IBM Corporation
+ *  Author(s): Robert Burroughs
+ *	       Eric Rossman (edrossma@us.ibm.com)
+ *
+ *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
+ *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
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
+#ifndef _ZCRYPT_PCICA_H_
+#define _ZCRYPT_PCICA_H_
+
+/**
+ * The type 4 message family is associated with a PCICA card.
+ *
+ * The four members of the family are described below.
+ *
+ * Note that all unsigned char arrays are right-justified and left-padded
+ * with zeroes.
+ *
+ * Note that all reserved fields must be zeroes.
+ */
+struct type4_hdr {
+	unsigned char  reserved1;
+	unsigned char  msg_type_code;	/* 0x04 */
+	unsigned short msg_len;
+	unsigned char  request_code;	/* 0x40 */
+	unsigned char  msg_fmt;
+	unsigned short reserved2;
+} __attribute__((packed));
+
+#define TYPE4_TYPE_CODE 0x04
+#define TYPE4_REQU_CODE 0x40
+
+#define TYPE4_SME_FMT 0x00
+#define TYPE4_LME_FMT 0x10
+#define TYPE4_SCR_FMT 0x40
+#define TYPE4_LCR_FMT 0x50
+
+/* Mod-Exp, with a small modulus */
+struct type4_sme {
+	struct type4_hdr header;
+	unsigned char	 message[128];
+	unsigned char	 exponent[128];
+	unsigned char	 modulus[128];
+} __attribute__((packed));
+
+/* Mod-Exp, with a large modulus */
+struct type4_lme {
+	struct type4_hdr header;
+	unsigned char	 message[256];
+	unsigned char	 exponent[256];
+	unsigned char	 modulus[256];
+} __attribute__((packed));
+
+/* CRT, with a small modulus */
+struct type4_scr {
+	struct type4_hdr header;
+	unsigned char	 message[128];
+	unsigned char	 dp[72];
+	unsigned char	 dq[64];
+	unsigned char	 p[72];
+	unsigned char	 q[64];
+	unsigned char	 u[72];
+} __attribute__((packed));
+
+/* CRT, with a large modulus */
+struct type4_lcr {
+	struct type4_hdr header;
+	unsigned char	 message[256];
+	unsigned char	 dp[136];
+	unsigned char	 dq[128];
+	unsigned char	 p[136];
+	unsigned char	 q[128];
+	unsigned char	 u[136];
+} __attribute__((packed));
+
+/**
+ * The type 84 response family is associated with a PCICA card.
+ *
+ * Note that all unsigned char arrays are right-justified and left-padded
+ * with zeroes.
+ *
+ * Note that all reserved fields must be zeroes.
+ */
+
+struct type84_hdr {
+	unsigned char  reserved1;
+	unsigned char  code;
+	unsigned short len;
+	unsigned char  reserved2[4];
+} __attribute__((packed));
+
+#define TYPE84_RSP_CODE 0x84
+
+int zcrypt_pcica_init(void);
+void zcrypt_pcica_exit(void);
+
+#endif /* _ZCRYPT_PCICA_H_ */
