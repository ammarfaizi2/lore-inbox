Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWGDQyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWGDQyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWGDQyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:54:55 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:16092 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932287AbWGDQyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:54:22 -0400
Date: Tue, 4 Jul 2006 18:54:23 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, rwuerthn@de.ibm.com,
       cornelia.huck@de.ibm.com
Subject: [patch 6/6] s390: zcrypt secure key cryptography extension.
Message-ID: <20060704165423.GG6202@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

[patch 6/6] s390: zcrypt secure key cryptography extension.

Allow the user space to send extended cprb messages directly to the
PCIXCC / CEX2C cards. This allows the CCA library to construct special
crypto requests that use "secure" keys that are stored on the card.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_api.c     |  105 +++++++++++++
 drivers/s390/crypto/zcrypt_api.h     |    3 
 drivers/s390/crypto/zcrypt_cca_key.h |    2 
 drivers/s390/crypto/zcrypt_cex2a.c   |    2 
 drivers/s390/crypto/zcrypt_cex2a.h   |    2 
 drivers/s390/crypto/zcrypt_error.h   |    2 
 drivers/s390/crypto/zcrypt_mono.c    |    2 
 drivers/s390/crypto/zcrypt_pcica.c   |    2 
 drivers/s390/crypto/zcrypt_pcica.h   |    2 
 drivers/s390/crypto/zcrypt_pcicc.c   |    2 
 drivers/s390/crypto/zcrypt_pcicc.h   |    2 
 drivers/s390/crypto/zcrypt_pcixcc.c  |  263 +++++++++++++++++++++++++++++++++--
 drivers/s390/crypto/zcrypt_pcixcc.h  |    2 
 include/asm-s390/zcrypt.h            |   80 ++++++++++
 14 files changed, 445 insertions(+), 26 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_api.c linux-2.6-patched/drivers/s390/crypto/zcrypt_api.c
--- linux-2.6/drivers/s390/crypto/zcrypt_api.c	2006-07-04 18:31:36.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_api.c	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_api.c
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
@@ -321,6 +321,34 @@ static long zcrypt_rsa_crt(struct ica_rs
 	return -EINVAL;
 }
 
+static long zcrypt_send_cprb(struct ica_xcRB *xcRB)
+{
+	struct zcrypt_device *zdev;
+	int rc;
+
+	spin_lock_bh(&zcrypt_device_lock);
+	list_for_each_entry(zdev, &zcrypt_device_list, list) {
+		if (!zdev->online || !zdev->ops->send_cprb ||
+		    (xcRB->user_defined != AUTOSELECT &&
+			AP_QID_DEVICE(zdev->ap_dev->qid) != xcRB->user_defined)
+		    )
+			continue;
+		get_device(&zdev->ap_dev->device);
+		zdev->request_count++;
+		__zcrypt_decrease_preference(zdev);
+		spin_unlock_bh(&zcrypt_device_lock);
+		rc = zdev->ops->send_cprb(zdev, xcRB);
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
 static void zcrypt_status_mask(char status[AP_DEVICES])
 {
 	struct zcrypt_device *zdev;
@@ -464,6 +492,18 @@ static long zcrypt_unlocked_ioctl(struct
 			return rc;
 		return put_user(crt.outputdatalength, &ucrt->outputdatalength);
 	}
+	case ZSECSENDCPRB: {
+		struct ica_xcRB __user *uxcRB = (void __user *) arg;
+		struct ica_xcRB xcRB;
+		if (copy_from_user(&xcRB, uxcRB, sizeof(xcRB)))
+			return -EFAULT;
+		do {
+			rc = zcrypt_send_cprb(&xcRB);
+		} while (rc == -EAGAIN);
+		if (copy_to_user(uxcRB, &xcRB, sizeof(xcRB)))
+			return -EFAULT;
+		return rc;
+	}
 	case Z90STAT_STATUS_MASK: {
 		char status[AP_DEVICES];
 		zcrypt_status_mask(status);
@@ -612,6 +652,67 @@ static long trans_modexpo_crt32(struct f
 	return rc;
 }
 
+struct compat_ica_xcRB {
+	unsigned short	agent_ID;
+	unsigned int	user_defined;
+	unsigned short	request_ID;
+	unsigned int	request_control_blk_length;
+	unsigned char	padding1[16 - sizeof (compat_uptr_t)];
+	compat_uptr_t	request_control_blk_addr;
+	unsigned int	request_data_length;
+	char		padding2[16 - sizeof (compat_uptr_t)];
+	compat_uptr_t	request_data_address;
+	unsigned int	reply_control_blk_length;
+	char		padding3[16 - sizeof (compat_uptr_t)];
+	compat_uptr_t	reply_control_blk_addr;
+	unsigned int	reply_data_length;
+	char		padding4[16 - sizeof (compat_uptr_t)];
+	compat_uptr_t	reply_data_addr;
+	unsigned short	priority_window;
+	unsigned int	status;
+} __attribute__((packed));
+
+static long trans_xcRB32(struct file *filp, unsigned int cmd,
+			 unsigned long arg)
+{
+	struct compat_ica_xcRB __user *uxcRB32 = compat_ptr(arg);
+	struct compat_ica_xcRB xcRB32;
+	struct ica_xcRB xcRB64;
+	long rc;
+
+	if (copy_from_user(&xcRB32, uxcRB32, sizeof(xcRB32)))
+		return -EFAULT;
+	xcRB64.agent_ID = xcRB32.agent_ID;
+	xcRB64.user_defined = xcRB32.user_defined;
+	xcRB64.request_ID = xcRB32.request_ID;
+	xcRB64.request_control_blk_length =
+		xcRB32.request_control_blk_length;
+	xcRB64.request_control_blk_addr =
+		compat_ptr(xcRB32.request_control_blk_addr);
+	xcRB64.request_data_length =
+		xcRB32.request_data_length;
+	xcRB64.request_data_address =
+		compat_ptr(xcRB32.request_data_address);
+	xcRB64.reply_control_blk_length =
+		xcRB32.reply_control_blk_length;
+	xcRB64.reply_control_blk_addr =
+		compat_ptr(xcRB32.reply_control_blk_addr);
+	xcRB64.reply_data_length = xcRB32.reply_data_length;
+	xcRB64.reply_data_addr =
+		compat_ptr(xcRB32.reply_data_addr);
+	xcRB64.priority_window = xcRB32.priority_window;
+	xcRB64.status = xcRB32.status;
+	do {
+		rc = zcrypt_send_cprb(&xcRB64);
+	} while (rc == -EAGAIN);
+	xcRB32.reply_control_blk_length = xcRB64.reply_control_blk_length;
+	xcRB32.reply_data_length = xcRB64.reply_data_length;
+	xcRB32.status = xcRB64.status;
+	if (copy_to_user(uxcRB32, &xcRB32, sizeof(xcRB32)))
+			return -EFAULT;
+	return rc;
+}
+
 long zcrypt_compat_ioctl(struct file *filp, unsigned int cmd,
 			 unsigned long arg)
 {
@@ -619,6 +720,8 @@ long zcrypt_compat_ioctl(struct file *fi
 		return trans_modexpo32(filp, cmd, arg);
 	if (cmd == ICARSACRT)
 		return trans_modexpo_crt32(filp, cmd, arg);
+	if (cmd == ZSECSENDCPRB)
+		return trans_xcRB32(filp, cmd, arg);
 	return zcrypt_unlocked_ioctl(filp, cmd, arg);
 }
 #endif
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_api.h linux-2.6-patched/drivers/s390/crypto/zcrypt_api.h
--- linux-2.6/drivers/s390/crypto/zcrypt_api.h	2006-07-04 18:31:36.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_api.h	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_api.h
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
@@ -106,6 +106,7 @@ struct zcrypt_ops {
 	long (*rsa_modexpo)(struct zcrypt_device *, struct ica_rsa_modexpo *);
 	long (*rsa_modexpo_crt)(struct zcrypt_device *,
 				struct ica_rsa_modexpo_crt *);
+	long (*send_cprb)(struct zcrypt_device *, struct ica_xcRB *);
 };
 
 struct zcrypt_device {
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_cca_key.h linux-2.6-patched/drivers/s390/crypto/zcrypt_cca_key.h
--- linux-2.6/drivers/s390/crypto/zcrypt_cca_key.h	2006-07-04 18:32:54.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_cca_key.h	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_cca_key.h
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_cex2a.c linux-2.6-patched/drivers/s390/crypto/zcrypt_cex2a.c
--- linux-2.6/drivers/s390/crypto/zcrypt_cex2a.c	2006-07-04 18:31:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_cex2a.c	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_cex2a.c
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_cex2a.h linux-2.6-patched/drivers/s390/crypto/zcrypt_cex2a.h
--- linux-2.6/drivers/s390/crypto/zcrypt_cex2a.h	2006-07-04 18:31:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_cex2a.h	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_cex2a.h
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_error.h linux-2.6-patched/drivers/s390/crypto/zcrypt_error.h
--- linux-2.6/drivers/s390/crypto/zcrypt_error.h	2006-07-04 18:31:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_error.h	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_error.h
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_mono.c linux-2.6-patched/drivers/s390/crypto/zcrypt_mono.c
--- linux-2.6/drivers/s390/crypto/zcrypt_mono.c	2006-07-04 18:32:55.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_mono.c	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_mono.c
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcica.c linux-2.6-patched/drivers/s390/crypto/zcrypt_pcica.c
--- linux-2.6/drivers/s390/crypto/zcrypt_pcica.c	2006-07-04 18:31:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcica.c	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_pcica.c
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcica.h linux-2.6-patched/drivers/s390/crypto/zcrypt_pcica.h
--- linux-2.6/drivers/s390/crypto/zcrypt_pcica.h	2006-07-04 18:31:38.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcica.h	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_pcica.h
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcicc.c linux-2.6-patched/drivers/s390/crypto/zcrypt_pcicc.c
--- linux-2.6/drivers/s390/crypto/zcrypt_pcicc.c	2006-07-04 18:32:54.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcicc.c	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_pcicc.c
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcicc.h linux-2.6-patched/drivers/s390/crypto/zcrypt_pcicc.h
--- linux-2.6/drivers/s390/crypto/zcrypt_pcicc.h	2006-07-04 18:32:54.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcicc.h	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_pcicc.h
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcixcc.c linux-2.6-patched/drivers/s390/crypto/zcrypt_pcixcc.c
--- linux-2.6/drivers/s390/crypto/zcrypt_pcixcc.c	2006-07-04 18:32:54.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcixcc.c	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_pcixcc.c
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
@@ -60,6 +60,15 @@
 
 #define PCIXCC_CLEANUP_TIME	(15*HZ)
 
+#define CEIL4(x) ((((x)+3)/4)*4)
+
+struct response_type {
+	struct completion work;
+	int type;
+};
+#define PCIXCC_RESPONSE_TYPE_ICA  0
+#define PCIXCC_RESPONSE_TYPE_XCRB 1
+
 static struct ap_device_id zcrypt_pcixcc_ids[] = {
 	{ AP_DEVICE(AP_DEVICE_TYPE_PCIXCC) },
 	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2C) },
@@ -246,6 +255,108 @@ static int ICACRT_msg_to_type6CRT_msgX(s
 }
 
 /**
+ * Convert a XCRB message to a type6 CPRB message.
+ *
+ * @zdev: crypto device pointer
+ * @ap_msg: pointer to AP message
+ * @xcRB: pointer to user input data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+struct type86_fmt2_msg {
+	struct type86_hdr hdr;
+	struct type86_fmt2_ext fmt2;
+} __attribute__((packed));
+
+static int XCRB_msg_to_type6CPRB_msgX(struct zcrypt_device *zdev,
+				       struct ap_message *ap_msg,
+				       struct ica_xcRB *xcRB)
+{
+	static struct type6_hdr static_type6_hdrX = {
+		.type		=  0x06,
+		.offset1	=  0x00000058,
+	};
+	struct {
+		struct type6_hdr hdr;
+		struct ica_CPRBX cprbx;
+	} __attribute__((packed)) *msg = ap_msg->message;
+
+	int rcblen = CEIL4(xcRB->request_control_blk_length);
+	int replylen;
+	char *req_data = ap_msg->message + sizeof(struct type6_hdr) + rcblen;
+	char *function_code;
+
+	/* length checks */
+	ap_msg->length = sizeof(struct type6_hdr) +
+		CEIL4(xcRB->request_control_blk_length) +
+		xcRB->request_data_length;
+	if (ap_msg->length > PCIXCC_MAX_XCRB_MESSAGE_SIZE) {
+		PRINTK("Combined message is too large (%ld/%d/%d).\n",
+		    sizeof(struct type6_hdr),
+		    xcRB->request_control_blk_length,
+		    xcRB->request_data_length);
+		return -EFAULT;
+	}
+	if (CEIL4(xcRB->reply_control_blk_length) >
+	    PCIXCC_MAX_XCRB_REPLY_SIZE) {
+		PDEBUG("Reply CPRB length is too large (%d).\n",
+		    xcRB->request_control_blk_length);
+		return -EFAULT;
+	}
+	if (CEIL4(xcRB->reply_data_length) > PCIXCC_MAX_XCRB_DATA_SIZE) {
+		PDEBUG("Reply data block length is too large (%d).\n",
+		    xcRB->reply_data_length);
+		return -EFAULT;
+	}
+	replylen = CEIL4(xcRB->reply_control_blk_length) +
+		CEIL4(xcRB->reply_data_length) +
+		sizeof(struct type86_fmt2_msg);
+	if (replylen > PCIXCC_MAX_XCRB_RESPONSE_SIZE) {
+		PDEBUG("Reply CPRB + data block > PCIXCC_MAX_XCRB_RESPONSE_SIZE"
+		       " (%d/%d/%d).\n",
+		       sizeof(struct type86_fmt2_msg),
+		       xcRB->reply_control_blk_length,
+		       xcRB->reply_data_length);
+		xcRB->reply_control_blk_length = PCIXCC_MAX_XCRB_RESPONSE_SIZE -
+			(sizeof(struct type86_fmt2_msg) +
+			    CEIL4(xcRB->reply_data_length));
+		PDEBUG("Capping Reply CPRB length at %d\n",
+		       xcRB->reply_control_blk_length);
+	}
+
+	/* prepare type6 header */
+	msg->hdr = static_type6_hdrX;
+	memcpy(msg->hdr.agent_id , &(xcRB->agent_ID), sizeof(xcRB->agent_ID));
+	msg->hdr.ToCardLen1 = xcRB->request_control_blk_length;
+	if (xcRB->request_data_length) {
+		msg->hdr.offset2 = msg->hdr.offset1 + rcblen;
+		msg->hdr.ToCardLen2 = xcRB->request_data_length;
+	}
+	msg->hdr.FromCardLen1 = xcRB->reply_control_blk_length;
+	msg->hdr.FromCardLen2 = xcRB->reply_data_length;
+
+	/* prepare CPRB */
+	if (copy_from_user(&(msg->cprbx), xcRB->request_control_blk_addr,
+		    xcRB->request_control_blk_length))
+		return -EFAULT;
+	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
+	    xcRB->request_control_blk_length) {
+		PDEBUG("cprb_len too large (%d/%d)\n", msg->cprbx.cprb_len,
+		    xcRB->request_control_blk_length);
+		return -EFAULT;
+	}
+	function_code = ((unsigned char *)&msg->cprbx) + msg->cprbx.cprb_len;
+	memcpy(msg->hdr.function_code, function_code, sizeof(msg->hdr.function_code));
+
+	/* copy data block */
+	if (xcRB->request_data_length &&
+	    copy_from_user(req_data, xcRB->request_data_address,
+		xcRB->request_data_length))
+		return -EFAULT;
+	return 0;
+}
+
+/**
  * Copy results from a type 86 ICA reply message back to user space.
  *
  * @zdev: crypto device pointer
@@ -365,6 +476,37 @@ static int convert_type86_ica(struct zcr
 	return 0;
 }
 
+/**
+ * Copy results from a type 86 XCRB reply message back to user space.
+ *
+ * @zdev: crypto device pointer
+ * @reply: reply AP message.
+ * @xcRB: pointer to XCRB
+ *
+ * Returns 0 on success or -EINVAL, -EFAULT, -EAGAIN in case of an error.
+ */
+static int convert_type86_xcrb(struct zcrypt_device *zdev,
+			       struct ap_message *reply,
+			       struct ica_xcRB *xcRB)
+{
+	struct type86_fmt2_msg *msg = reply->message;
+	char *data = reply->message;
+
+	/* Copy CPRB to user */
+	if (copy_to_user(xcRB->reply_control_blk_addr,
+		data + msg->fmt2.offset1, msg->fmt2.count1))
+		return -EFAULT;
+	xcRB->reply_control_blk_length = msg->fmt2.count1;
+
+	/* Copy data buffer to user */
+	if (msg->fmt2.count2)
+		if (copy_to_user(xcRB->reply_data_addr,
+			data + msg->fmt2.offset2, msg->fmt2.count2))
+			return -EFAULT;
+	xcRB->reply_data_length = msg->fmt2.count2;
+	return 0;
+}
+
 static int convert_response_ica(struct zcrypt_device *zdev,
 			    struct ap_message *reply,
 			    char __user *outputdata,
@@ -393,6 +535,36 @@ static int convert_response_ica(struct z
 	}
 }
 
+static int convert_response_xcrb(struct zcrypt_device *zdev,
+			    struct ap_message *reply,
+			    struct ica_xcRB *xcRB)
+{
+	struct type86x_reply *msg = reply->message;
+
+	/* Response type byte is the second byte in the response. */
+	switch (((unsigned char *) reply->message)[1]) {
+	case TYPE82_RSP_CODE:
+	case TYPE88_RSP_CODE:
+		xcRB->status = 0x0008044DL; /* HDD_InvalidParm */
+		return convert_error(zdev, reply);
+	case TYPE86_RSP_CODE:
+		if (msg->hdr.reply_code) {
+			memcpy(&(xcRB->status), msg->fmt2.apfs, sizeof(u32));
+			return convert_error(zdev, reply);
+		}
+		if (msg->cprbx.cprb_ver_id == 0x02)
+			return convert_type86_xcrb(zdev, reply, xcRB);
+		/* no break, incorrect cprb version is an unknown response */
+	default: /* Unknown response type, this should NEVER EVER happen */
+		PRINTK("Unrecognized Message Header: %08x%08x\n",
+		       *(unsigned int *) reply->message,
+		       *(unsigned int *) (reply->message+4));
+		xcRB->status = 0x0008044DL; /* HDD_InvalidParm */
+		zdev->online = 0;
+		return -EAGAIN;	/* repeat the request on a different device. */
+	}
+}
+
 /**
  * This function is called from the AP bus code after a crypto request
  * "msg" has finished with the reply message "reply".
@@ -409,6 +581,8 @@ static void zcrypt_pcixcc_receive(struct
 		.type = TYPE82_RSP_CODE,
 		.reply_code = REP82_ERROR_MACHINE_FAILURE,
 	};
+	struct response_type *resp_type =
+		(struct response_type *) msg->private;
 	struct type86x_reply *t86r = reply->message;
 	int length;
 
@@ -417,12 +591,27 @@ static void zcrypt_pcixcc_receive(struct
 		memcpy(msg->message, &error_reply, sizeof(error_reply));
 	else if (t86r->hdr.type == TYPE86_RSP_CODE &&
 		 t86r->cprbx.cprb_ver_id == 0x02) {
-		length = sizeof(struct type86x_reply) + t86r->length - 2;
-		length = min(PCIXCC_MAX_ICA_RESPONSE_SIZE, length);
-		memcpy(msg->message, reply->message, length);
+		switch (resp_type->type) {
+		case PCIXCC_RESPONSE_TYPE_ICA:
+			length = sizeof(struct type86x_reply)
+				+ t86r->length - 2;
+			length = min(PCIXCC_MAX_ICA_RESPONSE_SIZE, length);
+			memcpy(msg->message, reply->message, length);
+			break;
+		case PCIXCC_RESPONSE_TYPE_XCRB:
+			length = t86r->fmt2.offset2 + t86r->fmt2.count2;
+			length = min(PCIXCC_MAX_XCRB_RESPONSE_SIZE, length);
+			memcpy(msg->message, reply->message, length);
+			break;
+		default:
+			PRINTK("Invalid internal response type: %i\n",
+			    resp_type->type);
+			memcpy(msg->message, &error_reply,
+			    sizeof error_reply);
+		}
 	} else
 		memcpy(msg->message, reply->message, sizeof error_reply);
-	complete((struct completion *) msg->private);
+	complete(&(resp_type->work));
 }
 
 static atomic_t zcrypt_step = ATOMIC_INIT(0);
@@ -438,7 +627,9 @@ static long zcrypt_pcixcc_modexpo(struct
 				  struct ica_rsa_modexpo *mex)
 {
 	struct ap_message ap_msg;
-	struct completion work;
+	struct response_type resp_type = {
+		.type = PCIXCC_RESPONSE_TYPE_ICA,
+	};
 	int rc;
 
 	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
@@ -446,14 +637,14 @@ static long zcrypt_pcixcc_modexpo(struct
 		return -ENOMEM;
 	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg.private = &work;
+	ap_msg.private = &resp_type;
 	rc = ICAMEX_msg_to_type6MEX_msgX(zdev, &ap_msg, mex);
 	if (rc)
 		goto out_free;
-	init_completion(&work);
+	init_completion(&resp_type.work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
 	rc = wait_for_completion_interruptible_timeout(
-				&work, PCIXCC_CLEANUP_TIME);
+				&resp_type.work, PCIXCC_CLEANUP_TIME);
 	if (rc > 0)
 		rc = convert_response_ica(zdev, &ap_msg, mex->outputdata,
 					  mex->outputdatalength);
@@ -480,7 +671,9 @@ static long zcrypt_pcixcc_modexpo_crt(st
 				      struct ica_rsa_modexpo_crt *crt)
 {
 	struct ap_message ap_msg;
-	struct completion work;
+	struct response_type resp_type = {
+		.type = PCIXCC_RESPONSE_TYPE_ICA,
+	};
 	int rc;
 
 	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
@@ -488,14 +681,14 @@ static long zcrypt_pcixcc_modexpo_crt(st
 		return -ENOMEM;
 	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
 				atomic_inc_return(&zcrypt_step);
-	ap_msg.private = &work;
+	ap_msg.private = &resp_type;
 	rc = ICACRT_msg_to_type6CRT_msgX(zdev, &ap_msg, crt);
 	if (rc)
 		goto out_free;
-	init_completion(&work);
+	init_completion(&resp_type.work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
 	rc = wait_for_completion_interruptible_timeout(
-				&work, PCIXCC_CLEANUP_TIME);
+				&resp_type.work, PCIXCC_CLEANUP_TIME);
 	if (rc > 0)
 		rc = convert_response_ica(zdev, &ap_msg, crt->outputdata,
 					  crt->outputdatalength);
@@ -512,11 +705,55 @@ out_free:
 }
 
 /**
+ * The request distributor calls this function if it picked the PCIXCC/CEX2C
+ * device to handle a send_cprb request.
+ * @zdev: pointer to zcrypt_device structure that identifies the
+ *	  PCIXCC/CEX2C device to the request distributor
+ * @xcRB: pointer to the send_cprb request buffer
+ */
+long zcrypt_pcixcc_send_cprb(struct zcrypt_device *zdev, struct ica_xcRB *xcRB)
+{
+	struct ap_message ap_msg;
+	struct response_type resp_type = {
+		.type = PCIXCC_RESPONSE_TYPE_XCRB,
+	};
+	int rc;
+
+	ap_msg.message = (void *) kmalloc(PCIXCC_MAX_XCRB_MESSAGE_SIZE, GFP_KERNEL);
+	if (!ap_msg.message)
+		return -ENOMEM;
+	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
+				atomic_inc_return(&zcrypt_step);
+	ap_msg.private = &resp_type;
+	rc = XCRB_msg_to_type6CPRB_msgX(zdev, &ap_msg, xcRB);
+	if (rc)
+		goto out_free;
+	init_completion(&resp_type.work);
+	ap_queue_message(zdev->ap_dev, &ap_msg);
+	rc = wait_for_completion_interruptible_timeout(
+				&resp_type.work, PCIXCC_CLEANUP_TIME);
+	if (rc > 0)
+		rc = convert_response_xcrb(zdev, &ap_msg, xcRB);
+	else {
+		/* Signal pending or message timed out. */
+		ap_cancel_message(zdev->ap_dev, &ap_msg);
+		if (rc == 0)
+			/* Message timed out. */
+			rc = -ETIME;
+	}
+out_free:
+	memset(ap_msg.message, 0x0, ap_msg.length);
+	kfree(ap_msg.message);
+	return rc;
+}
+
+/**
  * The crypto operations for a PCIXCC/CEX2C card.
  */
 static struct zcrypt_ops zcrypt_pcixcc_ops = {
 	.rsa_modexpo = zcrypt_pcixcc_modexpo,
 	.rsa_modexpo_crt = zcrypt_pcixcc_modexpo_crt,
+	.send_cprb = zcrypt_pcixcc_send_cprb,
 };
 
 /**
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcixcc.h linux-2.6-patched/drivers/s390/crypto/zcrypt_pcixcc.h
--- linux-2.6/drivers/s390/crypto/zcrypt_pcixcc.h	2006-07-04 18:32:54.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcixcc.h	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  linux/drivers/s390/crypto/zcrypt_pcixcc.h
  *
- *  zcrypt 2.0.0
+ *  zcrypt 2.1.0
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
diff -urpN linux-2.6/include/asm-s390/zcrypt.h linux-2.6-patched/include/asm-s390/zcrypt.h
--- linux-2.6/include/asm-s390/zcrypt.h	2006-07-04 18:31:36.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/zcrypt.h	2006-07-04 18:32:55.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  include/asm-s390/zcrypt.h
  *
- *  zcrypt 2.0.0 (user-visible header)
+ *  zcrypt 2.1.0 (user-visible header)
  *
  *  Copyright (C)  2001, 2006 IBM Corporation
  *  Author(s): Robert Burroughs
@@ -79,6 +79,83 @@ struct ica_rsa_modexpo_crt {
 	char __user *	u_mult_inv;
 };
 
+/**
+ * CPRBX
+ *	  Note that all shorts and ints are big-endian.
+ *	  All pointer fields are 16 bytes long, and mean nothing.
+ *
+ *	  A request CPRB is followed by a request_parameter_block.
+ *
+ *	  The request (or reply) parameter block is organized thus:
+ *	    function code
+ *	    VUD block
+ *	    key block
+ */
+struct ica_CPRBX {
+	unsigned short	cprb_len;	/* CPRB length	      220	 */
+	unsigned char	cprb_ver_id;	/* CPRB version id.   0x02	 */
+	unsigned char	pad_000[3];	/* Alignment pad bytes		 */
+	unsigned char	func_id[2];	/* function id	      0x5432	 */
+	unsigned char	cprb_flags[4];	/* Flags			 */
+	unsigned int	req_parml;	/* request parameter buffer len	 */
+	unsigned int	req_datal;	/* request data buffer		 */
+	unsigned int	rpl_msgbl;	/* reply  message block length	 */
+	unsigned int	rpld_parml;	/* replied parameter block len	 */
+	unsigned int	rpl_datal;	/* reply data block len		 */
+	unsigned int	rpld_datal;	/* replied data block len	 */
+	unsigned int	req_extbl;	/* request extension block len	 */
+	unsigned char	pad_001[4];	/* reserved			 */
+	unsigned int	rpld_extbl;	/* replied extension block len	 */
+	unsigned char	padx000[16 - sizeof (char *)];
+	unsigned char *	req_parmb;	/* request parm block 'address'	 */
+	unsigned char	padx001[16 - sizeof (char *)];
+	unsigned char *	req_datab;	/* request data block 'address'	 */
+	unsigned char	padx002[16 - sizeof (char *)];
+	unsigned char *	rpl_parmb;	/* reply parm block 'address'	 */
+	unsigned char	padx003[16 - sizeof (char *)];
+	unsigned char *	rpl_datab;	/* reply data block 'address'	 */
+	unsigned char	padx004[16 - sizeof (char *)];
+	unsigned char *	req_extb;	/* request extension block 'addr'*/
+	unsigned char	padx005[16 - sizeof (char *)];
+	unsigned char *	rpl_extb;	/* reply extension block 'addres'*/
+	unsigned short	ccp_rtcode;	/* server return code		 */
+	unsigned short	ccp_rscode;	/* server reason code		 */
+	unsigned int	mac_data_len;	/* Mac Data Length		 */
+	unsigned char	logon_id[8];	/* Logon Identifier		 */
+	unsigned char	mac_value[8];	/* Mac Value			 */
+	unsigned char	mac_content_flgs;/* Mac content flag byte	 */
+	unsigned char	pad_002;	/* Alignment			 */
+	unsigned short	domain;		/* Domain			 */
+	unsigned char	usage_domain[4];/* Usage domain			 */
+	unsigned char	cntrl_domain[4];/* Control domain		 */
+	unsigned char	S390enf_mask[4];/* S/390 enforcement mask	 */
+	unsigned char	pad_004[36];	/* reserved			 */
+};
+
+/**
+ * xcRB
+ */
+struct ica_xcRB {
+	unsigned short	agent_ID;
+	unsigned int	user_defined;
+	unsigned short	request_ID;
+	unsigned int	request_control_blk_length;
+	unsigned char	padding1[16 - sizeof (char *)];
+	char __user *	request_control_blk_addr;
+	unsigned int	request_data_length;
+	char		padding2[16 - sizeof (char *)];
+	char __user *	request_data_address;
+	unsigned int	reply_control_blk_length;
+	char		padding3[16 - sizeof (char *)];
+	char __user *	reply_control_blk_addr;
+	unsigned int	reply_data_length;
+	char		padding4[16 - sizeof (char *)];
+	char __user *	reply_data_addr;
+	unsigned short	priority_window;
+	unsigned int	status;
+} __attribute__((packed));
+#define AUTOSELECT ((unsigned int)0xFFFFFFFF)
+
 #define ZCRYPT_IOCTL_MAGIC 'z'
 
 /**
@@ -187,6 +264,7 @@ struct ica_rsa_modexpo_crt {
  */
 #define ICARSAMODEXPO	_IOC(_IOC_READ|_IOC_WRITE, ZCRYPT_IOCTL_MAGIC, 0x05, 0)
 #define ICARSACRT	_IOC(_IOC_READ|_IOC_WRITE, ZCRYPT_IOCTL_MAGIC, 0x06, 0)
+#define ZSECSENDCPRB	_IOC(_IOC_READ|_IOC_WRITE, ZCRYPT_IOCTL_MAGIC, 0x81, 0)
 
 /* New status calls */
 #define Z90STAT_TOTALCOUNT	_IOR(ZCRYPT_IOCTL_MAGIC, 0x40, int)
