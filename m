Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVLIPaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVLIPaY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVLIPaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:30:22 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:52932 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964796AbVLIPaO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:30:14 -0500
Date: Fri, 9 Dec 2005 16:30:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, edrossma@us.ibm.com, cohuck@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 17/17] s390: add support for cex2a crypto cards.
Message-ID: <20051209153002.GR6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Rossman <edrossma@us.ibm.com>

[patch 17/17] s390: add support for cex2a crypto cards.

Signed-off-by: Eric Rossman <edrossma@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 drivers/s390/crypto/z90common.h   |    9 -
 drivers/s390/crypto/z90crypt.h    |   13 +
 drivers/s390/crypto/z90hardware.c |  301 ++++++++++++++++++++++++++++++++++++--
 drivers/s390/crypto/z90main.c     |  111 +++++++++-----
 4 files changed, 383 insertions(+), 51 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/z90common.h linux-2.6-patched/drivers/s390/crypto/z90common.h
--- linux-2.6/drivers/s390/crypto/z90common.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90common.h	2005-12-09 14:26:07.000000000 +0100
@@ -1,9 +1,9 @@
 /*
  *  linux/drivers/s390/crypto/z90common.h
  *
- *  z90crypt 1.3.2
+ *  z90crypt 1.3.3
  *
- *  Copyright (C)  2001, 2004 IBM Corporation
+ *  Copyright (C)  2001, 2005 IBM Corporation
  *  Author(s): Robert Burroughs (burrough@us.ibm.com)
  *             Eric Rossman (edrossma@us.ibm.com)
  *
@@ -91,12 +91,13 @@ enum hdstat {
 #define TSQ_FATAL_ERROR 34
 #define RSQ_FATAL_ERROR 35
 
-#define Z90CRYPT_NUM_TYPES	5
+#define Z90CRYPT_NUM_TYPES	6
 #define PCICA		0
 #define PCICC		1
 #define PCIXCC_MCL2	2
 #define PCIXCC_MCL3	3
 #define CEX2C		4
+#define CEX2A		5
 #define NILDEV		-1
 #define ANYDEV		-1
 #define PCIXCC_UNK	-2
@@ -105,7 +106,7 @@ enum hdevice_type {
 	PCICC_HW  = 3,
 	PCICA_HW  = 4,
 	PCIXCC_HW = 5,
-	OTHER_HW  = 6,
+	CEX2A_HW  = 6,
 	CEX2C_HW  = 7
 };
 
diff -urpN linux-2.6/drivers/s390/crypto/z90crypt.h linux-2.6-patched/drivers/s390/crypto/z90crypt.h
--- linux-2.6/drivers/s390/crypto/z90crypt.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90crypt.h	2005-12-09 14:26:07.000000000 +0100
@@ -1,9 +1,9 @@
 /*
  *  linux/drivers/s390/crypto/z90crypt.h
  *
- *  z90crypt 1.3.2
+ *  z90crypt 1.3.3
  *
- *  Copyright (C)  2001, 2004 IBM Corporation
+ *  Copyright (C)  2001, 2005 IBM Corporation
  *  Author(s): Robert Burroughs (burrough@us.ibm.com)
  *             Eric Rossman (edrossma@us.ibm.com)
  *
@@ -29,11 +29,11 @@
 
 #include <linux/ioctl.h>
 
-#define VERSION_Z90CRYPT_H "$Revision: 1.11 $"
+#define VERSION_Z90CRYPT_H "$Revision: 1.2.2.4 $"
 
 #define z90crypt_VERSION 1
 #define z90crypt_RELEASE 3	// 2 = PCIXCC, 3 = rewrite for coding standards
-#define z90crypt_VARIANT 2	// 2 = added PCIXCC MCL3 and CEX2C support
+#define z90crypt_VARIANT 3	// 3 = CEX2A support
 
 /**
  * struct ica_rsa_modexpo
@@ -122,6 +122,9 @@ struct ica_rsa_modexpo_crt {
  *   Z90STAT_CEX2CCOUNT
  *     Return an integer count of all CEX2Cs.
  *
+ *   Z90STAT_CEX2ACOUNT
+ *     Return an integer count of all CEX2As.
+ *
  *   Z90STAT_REQUESTQ_COUNT
  *     Return an integer count of the number of entries waiting to be
  *     sent to a device.
@@ -144,6 +147,7 @@ struct ica_rsa_modexpo_crt {
  *       0x03: PCIXCC_MCL2
  *       0x04: PCIXCC_MCL3
  *       0x05: CEX2C
+ *       0x06: CEX2A
  *       0x0d: device is disabled via the proc filesystem
  *
  *   Z90STAT_QDEPTH_MASK
@@ -199,6 +203,7 @@ struct ica_rsa_modexpo_crt {
 #define Z90STAT_PCIXCCMCL2COUNT	_IOR(Z90_IOCTL_MAGIC, 0x4b, int)
 #define Z90STAT_PCIXCCMCL3COUNT	_IOR(Z90_IOCTL_MAGIC, 0x4c, int)
 #define Z90STAT_CEX2CCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x4d, int)
+#define Z90STAT_CEX2ACOUNT	_IOR(Z90_IOCTL_MAGIC, 0x4e, int)
 #define Z90STAT_REQUESTQ_COUNT	_IOR(Z90_IOCTL_MAGIC, 0x44, int)
 #define Z90STAT_PENDINGQ_COUNT	_IOR(Z90_IOCTL_MAGIC, 0x45, int)
 #define Z90STAT_TOTALOPEN_COUNT _IOR(Z90_IOCTL_MAGIC, 0x46, int)
diff -urpN linux-2.6/drivers/s390/crypto/z90hardware.c linux-2.6-patched/drivers/s390/crypto/z90hardware.c
--- linux-2.6/drivers/s390/crypto/z90hardware.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90hardware.c	2005-12-09 14:26:07.000000000 +0100
@@ -1,9 +1,9 @@
 /*
  *  linux/drivers/s390/crypto/z90hardware.c
  *
- *  z90crypt 1.3.2
+ *  z90crypt 1.3.3
  *
- *  Copyright (C)  2001, 2004 IBM Corporation
+ *  Copyright (C)  2001, 2005 IBM Corporation
  *  Author(s): Robert Burroughs (burrough@us.ibm.com)
  *             Eric Rossman (edrossma@us.ibm.com)
  *
@@ -648,6 +648,87 @@ static struct cca_public_sec static_cca_
 #define RESPONSE_CPRB_SIZE  0x000006B8
 #define RESPONSE_CPRBX_SIZE 0x00000724
 
+struct type50_hdr {
+	u8    reserved1;
+	u8    msg_type_code;
+	u16   msg_len;
+	u8    reserved2;
+	u8    ignored;
+	u16   reserved3;
+};
+
+#define TYPE50_TYPE_CODE 0x50
+
+#define TYPE50_MEB1_LEN (sizeof(struct type50_meb1_msg))
+#define TYPE50_MEB2_LEN (sizeof(struct type50_meb2_msg))
+#define TYPE50_CRB1_LEN (sizeof(struct type50_crb1_msg))
+#define TYPE50_CRB2_LEN (sizeof(struct type50_crb2_msg))
+
+#define TYPE50_MEB1_FMT 0x0001
+#define TYPE50_MEB2_FMT 0x0002
+#define TYPE50_CRB1_FMT 0x0011
+#define TYPE50_CRB2_FMT 0x0012
+
+struct type50_meb1_msg {
+	struct type50_hdr	header;
+	u16			keyblock_type;
+	u8			reserved[6];
+	u8			exponent[128];
+	u8			modulus[128];
+	u8			message[128];
+};
+
+struct type50_meb2_msg {
+	struct type50_hdr	header;
+	u16			keyblock_type;
+	u8			reserved[6];
+	u8			exponent[256];
+	u8			modulus[256];
+	u8			message[256];
+};
+
+struct type50_crb1_msg {
+	struct type50_hdr	header;
+	u16			keyblock_type;
+	u8			reserved[6];
+	u8			p[64];
+	u8			q[64];
+	u8			dp[64];
+	u8			dq[64];
+	u8			u[64];
+	u8			message[128];
+};
+
+struct type50_crb2_msg {
+	struct type50_hdr	header;
+	u16			keyblock_type;
+	u8			reserved[6];
+	u8			p[128];
+	u8			q[128];
+	u8			dp[128];
+	u8			dq[128];
+	u8			u[128];
+	u8			message[256];
+};
+
+union type50_msg {
+	struct type50_meb1_msg meb1;
+	struct type50_meb2_msg meb2;
+	struct type50_crb1_msg crb1;
+	struct type50_crb2_msg crb2;
+};
+
+struct type80_hdr {
+	u8	reserved1;
+	u8	type;
+	u16	len;
+	u8	code;
+	u8	reserved2[3];
+	u8	reserved3[8];
+};
+
+#define TYPE80_RSP_CODE 0x80
+
 struct error_hdr {
 	unsigned char reserved1;
 	unsigned char type;
@@ -657,6 +738,7 @@ struct error_hdr {
 };
 
 #define TYPE82_RSP_CODE 0x82
+#define TYPE88_RSP_CODE 0x88
 
 #define REP82_ERROR_MACHINE_FAILURE  0x10
 #define REP82_ERROR_PREEMPT_FAILURE  0x12
@@ -679,6 +761,22 @@ struct error_hdr {
 #define REP82_ERROR_PACKET_TRUNCATED 0xA0
 #define REP82_ERROR_ZERO_BUFFER_LEN  0xB0
 
+#define REP88_ERROR_MODULE_FAILURE   0x10
+#define REP88_ERROR_MODULE_TIMEOUT   0x11
+#define REP88_ERROR_MODULE_NOTINIT   0x13
+#define REP88_ERROR_MODULE_NOTAVAIL  0x14
+#define REP88_ERROR_MODULE_DISABLED  0x15
+#define REP88_ERROR_MODULE_IN_DIAGN  0x17
+#define REP88_ERROR_FASTPATH_DISABLD 0x19
+#define REP88_ERROR_MESSAGE_TYPE     0x20
+#define REP88_ERROR_MESSAGE_MALFORMD 0x22
+#define REP88_ERROR_MESSAGE_LENGTH   0x23
+#define REP88_ERROR_RESERVED_FIELD   0x24
+#define REP88_ERROR_KEY_TYPE         0x34
+#define REP88_ERROR_INVALID_KEY      0x82
+#define REP88_ERROR_OPERAND          0x84
+#define REP88_ERROR_OPERAND_EVEN_MOD 0x85
+
 #define CALLER_HEADER 12
 
 static inline int
@@ -1029,10 +1127,6 @@ query_online(int deviceNr, int cdx, int 
 			stat = HD_ONLINE;
 			*q_depth = t_depth + 1;
 			switch (t_dev_type) {
-			case OTHER_HW:
-				stat = HD_NOT_THERE;
-				*dev_type = NILDEV;
-				break;
 			case PCICA_HW:
 				*dev_type = PCICA;
 				break;
@@ -1045,6 +1139,9 @@ query_online(int deviceNr, int cdx, int 
 			case CEX2C_HW:
 				*dev_type = CEX2C;
 				break;
+			case CEX2A_HW:
+				*dev_type = CEX2A;
+				break;
 			default:
 				*dev_type = NILDEV;
 				break;
@@ -2029,6 +2126,177 @@ ICACRT_msg_to_type6CRT_msgX(struct ica_r
 	return 0;
 }
 
+static int
+ICAMEX_msg_to_type50MEX_msg(struct ica_rsa_modexpo *icaMex_p, int *z90cMsg_l_p,
+			    union type50_msg *z90cMsg_p)
+{
+	int mod_len, msg_size, mod_tgt_len, exp_tgt_len, inp_tgt_len;
+	unsigned char *mod_tgt, *exp_tgt, *inp_tgt;
+	union type50_msg *tmp_type50_msg;
+
+	mod_len = icaMex_p->inputdatalength;
+
+	msg_size = ((mod_len <= 128) ? TYPE50_MEB1_LEN : TYPE50_MEB2_LEN) +
+		    CALLER_HEADER;
+
+	memset(z90cMsg_p, 0, msg_size);
+
+	tmp_type50_msg = (union type50_msg *)
+		((unsigned char *) z90cMsg_p + CALLER_HEADER);
+
+	tmp_type50_msg->meb1.header.msg_type_code = TYPE50_TYPE_CODE;
+
+	if (mod_len <= 128) {
+		tmp_type50_msg->meb1.header.msg_len = TYPE50_MEB1_LEN;
+		tmp_type50_msg->meb1.keyblock_type = TYPE50_MEB1_FMT;
+		mod_tgt = tmp_type50_msg->meb1.modulus;
+		mod_tgt_len = sizeof(tmp_type50_msg->meb1.modulus);
+		exp_tgt = tmp_type50_msg->meb1.exponent;
+		exp_tgt_len = sizeof(tmp_type50_msg->meb1.exponent);
+		inp_tgt = tmp_type50_msg->meb1.message;
+		inp_tgt_len = sizeof(tmp_type50_msg->meb1.message);
+	} else {
+		tmp_type50_msg->meb2.header.msg_len = TYPE50_MEB2_LEN;
+		tmp_type50_msg->meb2.keyblock_type = TYPE50_MEB2_FMT;
+		mod_tgt = tmp_type50_msg->meb2.modulus;
+		mod_tgt_len = sizeof(tmp_type50_msg->meb2.modulus);
+		exp_tgt = tmp_type50_msg->meb2.exponent;
+		exp_tgt_len = sizeof(tmp_type50_msg->meb2.exponent);
+		inp_tgt = tmp_type50_msg->meb2.message;
+		inp_tgt_len = sizeof(tmp_type50_msg->meb2.message);
+	}
+
+	mod_tgt += (mod_tgt_len - mod_len);
+	if (copy_from_user(mod_tgt, icaMex_p->n_modulus, mod_len))
+		return SEN_RELEASED;
+	if (is_empty(mod_tgt, mod_len))
+		return SEN_USER_ERROR;
+	exp_tgt += (exp_tgt_len - mod_len);
+	if (copy_from_user(exp_tgt, icaMex_p->b_key, mod_len))
+		return SEN_RELEASED;
+	if (is_empty(exp_tgt, mod_len))
+		return SEN_USER_ERROR;
+	inp_tgt += (inp_tgt_len - mod_len);
+	if (copy_from_user(inp_tgt, icaMex_p->inputdata, mod_len))
+		return SEN_RELEASED;
+	if (is_empty(inp_tgt, mod_len))
+		return SEN_USER_ERROR;
+
+	*z90cMsg_l_p = msg_size - CALLER_HEADER;
+
+	return 0;
+}
+
+static int
+ICACRT_msg_to_type50CRT_msg(struct ica_rsa_modexpo_crt *icaMsg_p,
+			    int *z90cMsg_l_p, union type50_msg *z90cMsg_p)
+{
+	int mod_len, short_len, long_len, tmp_size, p_tgt_len, q_tgt_len,
+	    dp_tgt_len, dq_tgt_len, u_tgt_len, inp_tgt_len, long_offset;
+	unsigned char *p_tgt, *q_tgt, *dp_tgt, *dq_tgt, *u_tgt, *inp_tgt,
+		      temp[8];
+	union type50_msg *tmp_type50_msg;
+
+	mod_len = icaMsg_p->inputdatalength;
+	short_len = mod_len / 2;
+	long_len = mod_len / 2 + 8;
+	long_offset = 0;
+
+	if (long_len > 128) {
+		memset(temp, 0x00, sizeof(temp));
+		if (copy_from_user(temp, icaMsg_p->np_prime, long_len-128))
+			return SEN_RELEASED;
+		if (!is_empty(temp, 8))
+			return SEN_NOT_AVAIL;
+		if (copy_from_user(temp, icaMsg_p->bp_key, long_len-128))
+			return SEN_RELEASED;
+		if (!is_empty(temp, 8))
+			return SEN_NOT_AVAIL;
+		if (copy_from_user(temp, icaMsg_p->u_mult_inv, long_len-128))
+			return SEN_RELEASED;
+		if (!is_empty(temp, 8))
+			return SEN_NOT_AVAIL;
+		long_offset = long_len - 128;
+		long_len = 128;
+	}
+
+	tmp_size = ((mod_len <= 128) ? TYPE50_CRB1_LEN : TYPE50_CRB2_LEN) +
+		    CALLER_HEADER;
+
+	memset(z90cMsg_p, 0, tmp_size);
+
+	tmp_type50_msg = (union type50_msg *)
+		((unsigned char *) z90cMsg_p + CALLER_HEADER);
+
+	tmp_type50_msg->crb1.header.msg_type_code = TYPE50_TYPE_CODE;
+	if (long_len <= 64) {
+		tmp_type50_msg->crb1.header.msg_len = TYPE50_CRB1_LEN;
+		tmp_type50_msg->crb1.keyblock_type = TYPE50_CRB1_FMT;
+		p_tgt = tmp_type50_msg->crb1.p;
+		p_tgt_len = sizeof(tmp_type50_msg->crb1.p);
+		q_tgt = tmp_type50_msg->crb1.q;
+		q_tgt_len = sizeof(tmp_type50_msg->crb1.q);
+		dp_tgt = tmp_type50_msg->crb1.dp;
+		dp_tgt_len = sizeof(tmp_type50_msg->crb1.dp);
+		dq_tgt = tmp_type50_msg->crb1.dq;
+		dq_tgt_len = sizeof(tmp_type50_msg->crb1.dq);
+		u_tgt = tmp_type50_msg->crb1.u;
+		u_tgt_len = sizeof(tmp_type50_msg->crb1.u);
+		inp_tgt = tmp_type50_msg->crb1.message;
+		inp_tgt_len = sizeof(tmp_type50_msg->crb1.message);
+	} else {
+		tmp_type50_msg->crb2.header.msg_len = TYPE50_CRB2_LEN;
+		tmp_type50_msg->crb2.keyblock_type = TYPE50_CRB2_FMT;
+		p_tgt = tmp_type50_msg->crb2.p;
+		p_tgt_len = sizeof(tmp_type50_msg->crb2.p);
+		q_tgt = tmp_type50_msg->crb2.q;
+		q_tgt_len = sizeof(tmp_type50_msg->crb2.q);
+		dp_tgt = tmp_type50_msg->crb2.dp;
+		dp_tgt_len = sizeof(tmp_type50_msg->crb2.dp);
+		dq_tgt = tmp_type50_msg->crb2.dq;
+		dq_tgt_len = sizeof(tmp_type50_msg->crb2.dq);
+		u_tgt = tmp_type50_msg->crb2.u;
+		u_tgt_len = sizeof(tmp_type50_msg->crb2.u);
+		inp_tgt = tmp_type50_msg->crb2.message;
+		inp_tgt_len = sizeof(tmp_type50_msg->crb2.message);
+	}
+
+	p_tgt += (p_tgt_len - long_len);
+	if (copy_from_user(p_tgt, icaMsg_p->np_prime + long_offset, long_len))
+		return SEN_RELEASED;
+	if (is_empty(p_tgt, long_len))
+		return SEN_USER_ERROR;
+	q_tgt += (q_tgt_len - short_len);
+	if (copy_from_user(q_tgt, icaMsg_p->nq_prime, short_len))
+		return SEN_RELEASED;
+	if (is_empty(q_tgt, short_len))
+		return SEN_USER_ERROR;
+	dp_tgt += (dp_tgt_len - long_len);
+	if (copy_from_user(dp_tgt, icaMsg_p->bp_key + long_offset, long_len))
+		return SEN_RELEASED;
+	if (is_empty(dp_tgt, long_len))
+		return SEN_USER_ERROR;
+	dq_tgt += (dq_tgt_len - short_len);
+	if (copy_from_user(dq_tgt, icaMsg_p->bq_key, short_len))
+		return SEN_RELEASED;
+	if (is_empty(dq_tgt, short_len))
+		return SEN_USER_ERROR;
+	u_tgt += (u_tgt_len - long_len);
+	if (copy_from_user(u_tgt, icaMsg_p->u_mult_inv + long_offset, long_len))
+		return SEN_RELEASED;
+	if (is_empty(u_tgt, long_len))
+		return SEN_USER_ERROR;
+	inp_tgt += (inp_tgt_len - mod_len);
+	if (copy_from_user(inp_tgt, icaMsg_p->inputdata, mod_len))
+		return SEN_RELEASED;
+	if (is_empty(inp_tgt, mod_len))
+		return SEN_USER_ERROR;
+
+	*z90cMsg_l_p = tmp_size - CALLER_HEADER;
+
+	return 0;
+}
+
 int
 convert_request(unsigned char *buffer, int func, unsigned short function,
 		int cdx, int dev_type, int *msg_l_p, unsigned char *msg_p)
@@ -2071,6 +2339,16 @@ convert_request(unsigned char *buffer, i
 				cdx, msg_l_p, (struct type6_msg *) msg_p,
 				dev_type);
 	}
+	if (dev_type == CEX2A) {
+		if (func == ICARSACRT)
+			return ICACRT_msg_to_type50CRT_msg(
+				(struct ica_rsa_modexpo_crt *) buffer,
+				msg_l_p, (union type50_msg *) msg_p);
+		else
+			return ICAMEX_msg_to_type50MEX_msg(
+				(struct ica_rsa_modexpo *) buffer,
+				msg_l_p, (union type50_msg *) msg_p);
+	}
 
 	return 0;
 }
@@ -2081,8 +2359,8 @@ unset_ext_bitlens(void)
 {
 	if (!ext_bitlens_msg_count) {
 		PRINTK("Unable to use coprocessors for extended bitlengths. "
-		       "Using PCICAs (if present) for extended bitlengths. "
-		       "This is not an error.\n");
+		       "Using PCICAs/CEX2As (if present) for extended "
+		       "bitlengths. This is not an error.\n");
 		ext_bitlens_msg_count++;
 	}
 	ext_bitlens = 0;
@@ -2094,6 +2372,7 @@ convert_response(unsigned char *response
 {
 	struct ica_rsa_modexpo *icaMsg_p = (struct ica_rsa_modexpo *) buffer;
 	struct error_hdr *errh_p = (struct error_hdr *) response;
+	struct type80_hdr *t80h_p = (struct type80_hdr *) response;
 	struct type84_hdr *t84h_p = (struct type84_hdr *) response;
 	struct type86_fmt2_msg *t86m_p =  (struct type86_fmt2_msg *) response;
 	int reply_code, service_rc, service_rs, src_l;
@@ -2108,6 +2387,7 @@ convert_response(unsigned char *response
 	src_l = 0;
 	switch (errh_p->type) {
 	case TYPE82_RSP_CODE:
+	case TYPE88_RSP_CODE:
 		reply_code = errh_p->reply_code;
 		src_p = (unsigned char *)errh_p;
 		PRINTK("Hardware error: Type %02X Message Header: "
@@ -2116,6 +2396,10 @@ convert_response(unsigned char *response
 		       src_p[0], src_p[1], src_p[2], src_p[3],
 		       src_p[4], src_p[5], src_p[6], src_p[7]);
 		break;
+	case TYPE80_RSP_CODE:
+		src_l = icaMsg_p->outputdatalength;
+		src_p = response + (int)t80h_p->len - src_l;
+		break;
 	case TYPE84_RSP_CODE:
 		src_l = icaMsg_p->outputdatalength;
 		src_p = response + (int)t84h_p->len - src_l;
@@ -2202,6 +2486,7 @@ convert_response(unsigned char *response
 	if (reply_code)
 		switch (reply_code) {
 		case REP82_ERROR_OPERAND_INVALID:
+		case REP88_ERROR_MESSAGE_MALFORMD:
 			return REC_OPERAND_INV;
 		case REP82_ERROR_OPERAND_SIZE:
 			return REC_OPERAND_SIZE;
diff -urpN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2005-12-09 14:21:46.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2005-12-09 14:26:08.000000000 +0100
@@ -229,7 +229,7 @@ struct device_x {
  */
 struct device {
 	int		 dev_type;	    // PCICA, PCICC, PCIXCC_MCL2,
-					    // PCIXCC_MCL3, CEX2C
+					    // PCIXCC_MCL3, CEX2C, CEX2A
 	enum devstat	 dev_stat;	    // current device status
 	int		 dev_self_x;	    // Index in array
 	int		 disabled;	    // Set when device is in error
@@ -296,26 +296,30 @@ struct caller {
 /**
  * Function prototypes from z90hardware.c
  */
-enum hdstat query_online(int, int, int, int *, int *);
-enum devstat reset_device(int, int, int);
-enum devstat send_to_AP(int, int, int, unsigned char *);
-enum devstat receive_from_AP(int, int, int, unsigned char *, unsigned char *);
-int convert_request(unsigned char *, int, short, int, int, int *,
-		    unsigned char *);
-int convert_response(unsigned char *, unsigned char *, int *, unsigned char *);
+enum hdstat query_online(int deviceNr, int cdx, int resetNr, int *q_depth,
+			 int *dev_type);
+enum devstat reset_device(int deviceNr, int cdx, int resetNr);
+enum devstat send_to_AP(int dev_nr, int cdx, int msg_len, unsigned char *msg_ext);
+enum devstat receive_from_AP(int dev_nr, int cdx, int resplen,
+			     unsigned char *resp, unsigned char *psmid);
+int convert_request(unsigned char *buffer, int func, unsigned short function,
+		    int cdx, int dev_type, int *msg_l_p, unsigned char *msg_p);
+int convert_response(unsigned char *response, unsigned char *buffer,
+		     int *respbufflen_p, unsigned char *resp_buff);
 
 /**
  * Low level function prototypes
  */
-static int create_z90crypt(int *);
-static int refresh_z90crypt(int *);
-static int find_crypto_devices(struct status *);
-static int create_crypto_device(int);
-static int destroy_crypto_device(int);
+static int create_z90crypt(int *cdx_p);
+static int refresh_z90crypt(int *cdx_p);
+static int find_crypto_devices(struct status *deviceMask);
+static int create_crypto_device(int index);
+static int destroy_crypto_device(int index);
 static void destroy_z90crypt(void);
-static int refresh_index_array(struct status *, struct device_x *);
-static int probe_device_type(struct device *);
-static int probe_PCIXCC_type(struct device *);
+static int refresh_index_array(struct status *status_str,
+			       struct device_x *index_array);
+static int probe_device_type(struct device *devPtr);
+static int probe_PCIXCC_type(struct device *devPtr);
 
 /**
  * proc fs definitions
@@ -426,7 +430,7 @@ static struct miscdevice z90crypt_misc_d
 MODULE_AUTHOR("zSeries Linux Crypto Team: Robert H. Burroughs, Eric D. Rossman"
 	      "and Jochen Roehrig");
 MODULE_DESCRIPTION("zSeries Linux Cryptographic Coprocessor device driver, "
-		   "Copyright 2001, 2004 IBM Corporation");
+		   "Copyright 2001, 2005 IBM Corporation");
 MODULE_LICENSE("GPL");
 module_param(domain, int, 0);
 MODULE_PARM_DESC(domain, "domain index for device");
@@ -861,6 +865,12 @@ get_status_CEX2Ccount(void)
 }
 
 static inline int
+get_status_CEX2Acount(void)
+{
+	return z90crypt.hdware_info->type_mask[CEX2A].st_count;
+}
+
+static inline int
 get_status_requestq_count(void)
 {
 	return requestq_count;
@@ -1009,11 +1019,13 @@ static inline int
 select_device_type(int *dev_type_p, int bytelength)
 {
 	static int count = 0;
-	int PCICA_avail, PCIXCC_MCL3_avail, CEX2C_avail, index_to_use;
+	int PCICA_avail, PCIXCC_MCL3_avail, CEX2C_avail, CEX2A_avail,
+	    index_to_use;
 	struct status *stat;
 	if ((*dev_type_p != PCICC) && (*dev_type_p != PCICA) &&
 	    (*dev_type_p != PCIXCC_MCL2) && (*dev_type_p != PCIXCC_MCL3) &&
-	    (*dev_type_p != CEX2C) && (*dev_type_p != ANYDEV))
+	    (*dev_type_p != CEX2C) && (*dev_type_p != CEX2A) &&
+	    (*dev_type_p != ANYDEV))
 		return -1;
 	if (*dev_type_p != ANYDEV) {
 		stat = &z90crypt.hdware_info->type_mask[*dev_type_p];
@@ -1023,7 +1035,13 @@ select_device_type(int *dev_type_p, int 
 		return -1;
 	}
 
-	/* Assumption: PCICA, PCIXCC_MCL3, and CEX2C are all similar in speed */
+	/**
+	 * Assumption: PCICA, PCIXCC_MCL3, CEX2C, and CEX2A are all similar in
+	 * speed.
+	 *
+	 * PCICA and CEX2A do NOT co-exist, so it would be either one or the
+	 * other present.
+	 */
 	stat = &z90crypt.hdware_info->type_mask[PCICA];
 	PCICA_avail = stat->st_count -
 			(stat->disabled_count + stat->user_disabled_count);
@@ -1033,29 +1051,38 @@ select_device_type(int *dev_type_p, int 
 	stat = &z90crypt.hdware_info->type_mask[CEX2C];
 	CEX2C_avail = stat->st_count -
 			(stat->disabled_count + stat->user_disabled_count);
-	if (PCICA_avail || PCIXCC_MCL3_avail || CEX2C_avail) {
+	stat = &z90crypt.hdware_info->type_mask[CEX2A];
+	CEX2A_avail = stat->st_count -
+			(stat->disabled_count + stat->user_disabled_count);
+	if (PCICA_avail || PCIXCC_MCL3_avail || CEX2C_avail || CEX2A_avail) {
 		/**
-		 * bitlength is a factor, PCICA is the most capable, even with
-		 * the new MCL for PCIXCC.
+		 * bitlength is a factor, PCICA or CEX2A are the most capable,
+		 * even with the new MCL for PCIXCC.
 		 */
 		if ((bytelength < PCIXCC_MIN_MOD_SIZE) ||
 		    (!ext_bitlens && (bytelength < OLD_PCIXCC_MIN_MOD_SIZE))) {
-			if (!PCICA_avail)
-				return -1;
-			else {
+			if (PCICA_avail) {
 				*dev_type_p = PCICA;
 				return 0;
 			}
+			if (CEX2A_avail) {
+				*dev_type_p = CEX2A;
+				return 0;
+			}
+			return -1;
 		}
 
 		index_to_use = count % (PCICA_avail + PCIXCC_MCL3_avail +
-					CEX2C_avail);
+					CEX2C_avail + CEX2A_avail);
 		if (index_to_use < PCICA_avail)
 			*dev_type_p = PCICA;
 		else if (index_to_use < (PCICA_avail + PCIXCC_MCL3_avail))
 			*dev_type_p = PCIXCC_MCL3;
-		else
+		else if (index_to_use < (PCICA_avail + PCIXCC_MCL3_avail +
+					 CEX2C_avail))
 			*dev_type_p = CEX2C;
+		else
+			*dev_type_p = CEX2A;
 		count++;
 		return 0;
 	}
@@ -1360,7 +1387,7 @@ build_caller(struct work_element *we_p, 
 
 	if ((we_p->devtype != PCICC) && (we_p->devtype != PCICA) &&
 	    (we_p->devtype != PCIXCC_MCL2) && (we_p->devtype != PCIXCC_MCL3) &&
-	    (we_p->devtype != CEX2C))
+	    (we_p->devtype != CEX2C) && (we_p->devtype != CEX2A))
 		return SEN_NOT_AVAIL;
 
 	memcpy(caller_p->caller_id, we_p->caller_id,
@@ -1429,7 +1456,8 @@ get_crypto_request_buffer(struct work_el
 
 	if ((we_p->devtype != PCICA) && (we_p->devtype != PCICC) &&
 	    (we_p->devtype != PCIXCC_MCL2) && (we_p->devtype != PCIXCC_MCL3) &&
-	    (we_p->devtype != CEX2C) && (we_p->devtype != ANYDEV)) {
+	    (we_p->devtype != CEX2C) && (we_p->devtype != CEX2A) &&
+	    (we_p->devtype != ANYDEV)) {
 		PRINTK("invalid device type\n");
 		return SEN_USER_ERROR;
 	}
@@ -1504,8 +1532,9 @@ get_crypto_request_buffer(struct work_el
 
 	function = PCI_FUNC_KEY_ENCRYPT;
 	switch (we_p->devtype) {
-	/* PCICA does everything with a simple RSA mod-expo operation */
+	/* PCICA and CEX2A do everything with a simple RSA mod-expo operation */
 	case PCICA:
+	case CEX2A:
 		function = PCI_FUNC_KEY_ENCRYPT;
 		break;
 	/**
@@ -1663,7 +1692,8 @@ z90crypt_rsa(struct priv_data *private_d
 		 * trigger a fallback to software.
 		 */
 		case -EINVAL:
-			if (we_p->devtype != PCICA)
+			if ((we_p->devtype != PCICA) &&
+			    (we_p->devtype != CEX2A))
 				rv = -EGETBUFF;
 			break;
 		case -ETIMEOUT:
@@ -1780,6 +1810,12 @@ z90crypt_unlocked_ioctl(struct file *fil
 			ret = -EFAULT;
 		break;
 
+	case Z90STAT_CEX2ACOUNT:
+		tempstat = get_status_CEX2Acount();
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) != 0)
+			ret = -EFAULT;
+		break;
+
 	case Z90STAT_REQUESTQ_COUNT:
 		tempstat = get_status_requestq_count();
 		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) != 0)
@@ -2020,6 +2056,8 @@ z90crypt_status(char *resp_buff, char **
 		get_status_PCIXCCMCL3count());
 	len += sprintf(resp_buff+len, "CEX2C count: %d\n",
 		get_status_CEX2Ccount());
+	len += sprintf(resp_buff+len, "CEX2A count: %d\n",
+		get_status_CEX2Acount());
 	len += sprintf(resp_buff+len, "requestq count: %d\n",
 		get_status_requestq_count());
 	len += sprintf(resp_buff+len, "pendingq count: %d\n",
@@ -2027,8 +2065,8 @@ z90crypt_status(char *resp_buff, char **
 	len += sprintf(resp_buff+len, "Total open handles: %d\n\n",
 		get_status_totalopen_count());
 	len += sprinthx(
-		"Online devices: 1: PCICA, 2: PCICC, 3: PCIXCC (MCL2), "
-		"4: PCIXCC (MCL3), 5: CEX2C",
+		"Online devices: 1=PCICA 2=PCICC 3=PCIXCC(MCL2) "
+		"4=PCIXCC(MCL3) 5=CEX2C 6=CEX2A",
 		resp_buff+len,
 		get_status_status_mask(workarea),
 		Z90CRYPT_NUM_APS);
@@ -2141,6 +2179,7 @@ z90crypt_status_write(struct file *file,
 		case '3':	// PCIXCC_MCL2
 		case '4':	// PCIXCC_MCL3
 		case '5':	// CEX2C
+		case '6':       // CEX2A
 			j++;
 			break;
 		case 'd':
@@ -3008,7 +3047,9 @@ create_crypto_device(int index)
 			z90crypt.hdware_info->device_type_array[index] = 4;
 		else if (deviceType == CEX2C)
 			z90crypt.hdware_info->device_type_array[index] = 5;
-		else
+		else if (deviceType == CEX2A)
+			z90crypt.hdware_info->device_type_array[index] = 6;
+		else // No idea how this would happen.
 			z90crypt.hdware_info->device_type_array[index] = -1;
 	}
 
