Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWGDQyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWGDQyO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWGDQyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:54:13 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:55545 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S932287AbWGDQxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:53:49 -0400
Date: Tue, 4 Jul 2006 18:53:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, rwuerthn@de.ibm.com,
       cornelia.huck@de.ibm.com
Subject: [patch 4/6] s390: zcrypt PCICC, PCIXCC coprocessor card ap bus drivers.
Message-ID: <20060704165349.GE6202@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Ralph Wuerthner <rwuerthn@de.ibm.com>

[patch 4/6] s390: zcrypt PCICC, PCIXCC coprocessor card ap bus drivers.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/zcrypt_cca_key.h |  350 ++++++++++++++++
 drivers/s390/crypto/zcrypt_pcicc.c   |  651 +++++++++++++++++++++++++++++++
 drivers/s390/crypto/zcrypt_pcicc.h   |  176 ++++++++
 drivers/s390/crypto/zcrypt_pcixcc.c  |  735 +++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/zcrypt_pcixcc.h  |   79 +++
 5 files changed, 1991 insertions(+)

diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_cca_key.h linux-2.6-patched/drivers/s390/crypto/zcrypt_cca_key.h
--- linux-2.6/drivers/s390/crypto/zcrypt_cca_key.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_cca_key.h	2006-07-04 18:31:38.000000000 +0200
@@ -0,0 +1,350 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_cca_key.h
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
+#ifndef _ZCRYPT_CCA_KEY_H_
+#define _ZCRYPT_CCA_KEY_H_
+
+struct T6_keyBlock_hdr {
+	unsigned short blen;
+	unsigned short ulen;
+	unsigned short flags;
+};
+
+/**
+ * mapping for the cca private ME key token.
+ * Three parts of interest here: the header, the private section and
+ * the public section.
+ *
+ * mapping for the cca key token header
+ */
+struct cca_token_hdr {
+	unsigned char  token_identifier;
+	unsigned char  version;
+	unsigned short token_length;
+	unsigned char  reserved[4];
+} __attribute__((packed));
+
+#define CCA_TKN_HDR_ID_EXT 0x1E
+
+/**
+ * mapping for the cca private ME section
+ */
+struct cca_private_ext_ME_sec {
+	unsigned char  section_identifier;
+	unsigned char  version;
+	unsigned short section_length;
+	unsigned char  private_key_hash[20];
+	unsigned char  reserved1[4];
+	unsigned char  key_format;
+	unsigned char  reserved2;
+	unsigned char  key_name_hash[20];
+	unsigned char  key_use_flags[4];
+	unsigned char  reserved3[6];
+	unsigned char  reserved4[24];
+	unsigned char  confounder[24];
+	unsigned char  exponent[128];
+	unsigned char  modulus[128];
+} __attribute__((packed));
+
+#define CCA_PVT_USAGE_ALL 0x80
+
+/**
+ * mapping for the cca public section
+ * In a private key, the modulus doesn't appear in the public
+ * section. So, an arbitrary public exponent of 0x010001 will be
+ * used, for a section length of 0x0F always.
+ */
+struct cca_public_sec {
+	unsigned char  section_identifier;
+	unsigned char  version;
+	unsigned short section_length;
+	unsigned char  reserved[2];
+	unsigned short exponent_len;
+	unsigned short modulus_bit_len;
+	unsigned short modulus_byte_len;    /* In a private key, this is 0 */
+} __attribute__((packed));
+
+/**
+ * mapping for the cca private CRT key 'token'
+ * The first three parts (the only parts considered in this release)
+ * are: the header, the private section and the public section.
+ * The header and public section are the same as for the
+ * struct cca_private_ext_ME
+ *
+ * Following the structure are the quantities p, q, dp, dq, u, pad,
+ * and modulus, in that order, where pad_len is the modulo 8
+ * complement of the residue modulo 8 of the sum of
+ * (p_len + q_len + dp_len + dq_len + u_len).
+ */
+struct cca_pvt_ext_CRT_sec {
+	unsigned char  section_identifier;
+	unsigned char  version;
+	unsigned short section_length;
+	unsigned char  private_key_hash[20];
+	unsigned char  reserved1[4];
+	unsigned char  key_format;
+	unsigned char  reserved2;
+	unsigned char  key_name_hash[20];
+	unsigned char  key_use_flags[4];
+	unsigned short p_len;
+	unsigned short q_len;
+	unsigned short dp_len;
+	unsigned short dq_len;
+	unsigned short u_len;
+	unsigned short mod_len;
+	unsigned char  reserved3[4];
+	unsigned short pad_len;
+	unsigned char  reserved4[52];
+	unsigned char  confounder[8];
+} __attribute__((packed));
+
+#define CCA_PVT_EXT_CRT_SEC_ID_PVT 0x08
+#define CCA_PVT_EXT_CRT_SEC_FMT_CL 0x40
+
+/**
+ * Set up private key fields of a type6 MEX message.
+ * Note that all numerics in the key token are big-endian,
+ * while the entries in the key block header are little-endian.
+ *
+ * @mex: pointer to user input data
+ * @p: pointer to memory area for the key
+ *
+ * Returns the size of the key area or -EFAULT
+ */
+static inline int zcrypt_type6_mex_key_de(struct ica_rsa_modexpo *mex,
+					  void *p, int big_endian)
+{
+	static struct cca_token_hdr static_pvt_me_hdr = {
+		.token_identifier	=  0x1E,
+		.token_length		=  0x0183,
+	};
+	static struct cca_private_ext_ME_sec static_pvt_me_sec = {
+		.section_identifier	=  0x02,
+		.section_length		=  0x016C,
+		.key_use_flags		= {0x80,0x00,0x00,0x00},
+	};
+	static struct cca_public_sec static_pub_me_sec = {
+		.section_identifier	=  0x04,
+		.section_length		=  0x000F,
+		.exponent_len		=  0x0003,
+	};
+	static char pk_exponent[3] = { 0x01, 0x00, 0x01 };
+	struct {
+		struct T6_keyBlock_hdr t6_hdr;
+		struct cca_token_hdr pvtMeHdr;
+		struct cca_private_ext_ME_sec pvtMeSec;
+		struct cca_public_sec pubMeSec;
+		char exponent[3];
+	} __attribute__((packed)) *key = p;
+	unsigned char *temp;
+
+	memset(key, 0, sizeof(*key));
+
+	if (big_endian) {
+		key->t6_hdr.blen = cpu_to_be16(0x189);
+		key->t6_hdr.ulen = cpu_to_be16(0x189 - 2);
+	} else {
+		key->t6_hdr.blen = cpu_to_le16(0x189);
+		key->t6_hdr.ulen = cpu_to_le16(0x189 - 2);
+	}
+	key->pvtMeHdr = static_pvt_me_hdr;
+	key->pvtMeSec = static_pvt_me_sec;
+	key->pubMeSec = static_pub_me_sec;
+	/**
+	 * In a private key, the modulus doesn't appear in the public
+	 * section. So, an arbitrary public exponent of 0x010001 will be
+	 * used.
+	 */
+	memcpy(key->exponent, pk_exponent, 3);
+
+	/* key parameter block */
+	temp = key->pvtMeSec.exponent +
+		sizeof(key->pvtMeSec.exponent) - mex->inputdatalength;
+	if (copy_from_user(temp, mex->b_key, mex->inputdatalength))
+		return -EFAULT;
+
+	/* modulus */
+	temp = key->pvtMeSec.modulus +
+		sizeof(key->pvtMeSec.modulus) - mex->inputdatalength;
+	if (copy_from_user(temp, mex->n_modulus, mex->inputdatalength))
+		return -EFAULT;
+	key->pubMeSec.modulus_bit_len = 8 * mex->inputdatalength;
+	return sizeof(*key);
+}
+
+/**
+ * Set up private key fields of a type6 MEX message. The _pad variant
+ * strips leading zeroes from the b_key.
+ * Note that all numerics in the key token are big-endian,
+ * while the entries in the key block header are little-endian.
+ *
+ * @mex: pointer to user input data
+ * @p: pointer to memory area for the key
+ *
+ * Returns the size of the key area or -EFAULT
+ */
+static inline int zcrypt_type6_mex_key_en(struct ica_rsa_modexpo *mex,
+					  void *p, int big_endian)
+{
+	static struct cca_token_hdr static_pub_hdr = {
+		.token_identifier	=  0x1E,
+	};
+	static struct cca_public_sec static_pub_sec = {
+		.section_identifier	=  0x04,
+	};
+	struct {
+		struct T6_keyBlock_hdr t6_hdr;
+		struct cca_token_hdr pubHdr;
+		struct cca_public_sec pubSec;
+		char exponent[0];
+	} __attribute__((packed)) *key = p;
+	unsigned char *temp;
+	int i;
+
+	memset(key, 0, sizeof(*key));
+
+	key->pubHdr = static_pub_hdr;
+	key->pubSec = static_pub_sec;
+
+	/* key parameter block */
+	temp = key->exponent;
+	if (copy_from_user(temp, mex->b_key, mex->inputdatalength))
+		return -EFAULT;
+	/* Strip leading zeroes from b_key. */
+	for (i = 0; i < mex->inputdatalength; i++)
+		if (temp[i])
+			break;
+	if (i >= mex->inputdatalength)
+		return -EINVAL;
+	memmove(temp, temp + i, mex->inputdatalength - i);
+	temp += mex->inputdatalength - i;
+	/* modulus */
+	if (copy_from_user(temp, mex->n_modulus, mex->inputdatalength))
+		return -EFAULT;
+
+	key->pubSec.modulus_bit_len = 8 * mex->inputdatalength;
+	key->pubSec.modulus_byte_len = mex->inputdatalength;
+	key->pubSec.exponent_len = mex->inputdatalength - i;
+	key->pubSec.section_length = sizeof(key->pubSec) +
+					2*mex->inputdatalength - i;
+	key->pubHdr.token_length =
+		key->pubSec.section_length + sizeof(key->pubHdr);
+	if (big_endian) {
+		key->t6_hdr.ulen = cpu_to_be16(key->pubHdr.token_length + 4);
+		key->t6_hdr.blen = cpu_to_be16(key->pubHdr.token_length + 6);
+	} else {
+		key->t6_hdr.ulen = cpu_to_le16(key->pubHdr.token_length + 4);
+		key->t6_hdr.blen = cpu_to_le16(key->pubHdr.token_length + 6);
+	}
+	return sizeof(*key) + 2*mex->inputdatalength - i;
+}
+
+/**
+ * Set up private key fields of a type6 CRT message.
+ * Note that all numerics in the key token are big-endian,
+ * while the entries in the key block header are little-endian.
+ *
+ * @mex: pointer to user input data
+ * @p: pointer to memory area for the key
+ *
+ * Returns the size of the key area or -EFAULT
+ */
+static inline int zcrypt_type6_crt_key(struct ica_rsa_modexpo_crt *crt,
+				       void *p, int big_endian)
+{
+	static struct cca_public_sec static_cca_pub_sec = {
+		.section_identifier = 4,
+		.section_length = 0x000f,
+		.exponent_len = 0x0003,
+	};
+	static char pk_exponent[3] = { 0x01, 0x00, 0x01 };
+	struct {
+		struct T6_keyBlock_hdr t6_hdr;
+		struct cca_token_hdr token;
+		struct cca_pvt_ext_CRT_sec pvt;
+		char key_parts[0];
+	} __attribute__((packed)) *key = p;
+	struct cca_public_sec *pub;
+	int short_len, long_len, pad_len, key_len, size;
+
+	memset(key, 0, sizeof(*key));
+
+	short_len = crt->inputdatalength / 2;
+	long_len = short_len + 8;
+	pad_len = -(3*long_len + 2*short_len) & 7;
+	key_len = 3*long_len + 2*short_len + pad_len + crt->inputdatalength;
+	size = sizeof(*key) + key_len + sizeof(*pub) + 3;
+
+	/* parameter block.key block */
+	if (big_endian) {
+		key->t6_hdr.blen = cpu_to_be16(size);
+		key->t6_hdr.ulen = cpu_to_be16(size - 2);
+	} else {
+		key->t6_hdr.blen = cpu_to_le16(size);
+		key->t6_hdr.ulen = cpu_to_le16(size - 2);
+	}
+
+	/* key token header */
+	key->token.token_identifier = CCA_TKN_HDR_ID_EXT;
+	key->token.token_length = size - 6;
+
+	/* private section */
+	key->pvt.section_identifier = CCA_PVT_EXT_CRT_SEC_ID_PVT;
+	key->pvt.section_length = sizeof(key->pvt) + key_len;
+	key->pvt.key_format = CCA_PVT_EXT_CRT_SEC_FMT_CL;
+	key->pvt.key_use_flags[0] = CCA_PVT_USAGE_ALL;
+	key->pvt.p_len = key->pvt.dp_len = key->pvt.u_len = long_len;
+	key->pvt.q_len = key->pvt.dq_len = short_len;
+	key->pvt.mod_len = crt->inputdatalength;
+	key->pvt.pad_len = pad_len;
+
+	/* key parts */
+	if (copy_from_user(key->key_parts, crt->np_prime, long_len) ||
+	    copy_from_user(key->key_parts + long_len,
+					crt->nq_prime, short_len) ||
+	    copy_from_user(key->key_parts + long_len + short_len,
+					crt->bp_key, long_len) ||
+	    copy_from_user(key->key_parts + 2*long_len + short_len,
+					crt->bq_key, short_len) ||
+	    copy_from_user(key->key_parts + 2*long_len + 2*short_len,
+					crt->u_mult_inv, long_len))
+		return -EFAULT;
+	memset(key->key_parts + 3*long_len + 2*short_len + pad_len,
+	       0xff, crt->inputdatalength);
+	pub = (struct cca_public_sec *)(key->key_parts + key_len);
+	*pub = static_cca_pub_sec;
+	pub->modulus_bit_len = 8 * crt->inputdatalength;
+	/**
+	 * In a private key, the modulus doesn't appear in the public
+	 * section. So, an arbitrary public exponent of 0x010001 will be
+	 * used.
+	 */
+	memcpy((char *) (pub + 1), pk_exponent, 3);
+	return size;
+}
+
+#endif /* _ZCRYPT_CCA_KEY_H_ */
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcicc.c linux-2.6-patched/drivers/s390/crypto/zcrypt_pcicc.c
--- linux-2.6/drivers/s390/crypto/zcrypt_pcicc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcicc.c	2006-07-04 18:31:38.000000000 +0200
@@ -0,0 +1,651 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_pcicc.c
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
+#include "zcrypt_pcicc.h"
+#include "zcrypt_cca_key.h"
+
+#define PCICC_MIN_MOD_SIZE	 64	/*  512 bits */
+#define PCICC_MAX_MOD_SIZE_OLD	128	/* 1024 bits */
+#define PCICC_MAX_MOD_SIZE	256	/* 2048 bits */
+
+/**
+ * PCICC cards need a speed rating of 0. This keeps them at the end of
+ * the zcrypt device list (see zcrypt_api.c). PCICC cards are only
+ * used if no other cards are present because they are slow and can only
+ * cope with PKCS12 padded requests. The logic is queer. PKCS11 padded
+ * requests are rejected. The modexpo function encrypts PKCS12 padded data
+ * and decrypts any non-PKCS12 padded data (except PKCS11) in the assumption
+ * that it's encrypted PKCS12 data. The modexpo_crt function always decrypts
+ * the data in the assumption that its PKCS12 encrypted data.
+ */
+#define PCICC_SPEED_RATING	0
+
+#define PCICC_MAX_MESSAGE_SIZE 0x710	/* max size type6 v1 crt message */
+#define PCICC_MAX_RESPONSE_SIZE 0x710	/* max size type86 v1 reply	 */
+
+#define PCICC_CLEANUP_TIME	(15*HZ)
+
+static struct ap_device_id zcrypt_pcicc_ids[] = {
+	{ AP_DEVICE(AP_DEVICE_TYPE_PCICC) },
+	{ /* end of list */ },
+};
+
+#ifndef CONFIG_ZCRYPT_MONOLITHIC
+MODULE_DEVICE_TABLE(ap, zcrypt_pcicc_ids);
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("PCICC Cryptographic Coprocessor device driver, "
+		   "Copyright 2001, 2006 IBM Corporation");
+MODULE_LICENSE("GPL");
+#endif
+
+static int zcrypt_pcicc_probe(struct ap_device *ap_dev);
+static void zcrypt_pcicc_remove(struct ap_device *ap_dev);
+static void zcrypt_pcicc_release(struct ap_device *ap_dev);
+static void zcrypt_pcicc_receive(struct ap_device *, struct ap_message *,
+				 struct ap_message *);
+
+static struct ap_driver zcrypt_pcicc_driver = {
+	.probe = zcrypt_pcicc_probe,
+	.remove = zcrypt_pcicc_remove,
+	.release = zcrypt_pcicc_release,
+	.receive = zcrypt_pcicc_receive,
+	.ids = zcrypt_pcicc_ids,
+};
+
+/**
+ * The following is used to initialize the CPRB passed to the PCICC card
+ * in a type6 message. The 3 fields that must be filled in at execution
+ * time are  req_parml, rpl_parml and usage_domain. Note that all three
+ * fields are *little*-endian. Actually, everything about this interface
+ * is ascii/little-endian, since the device has 'Intel inside'.
+ *
+ * The CPRB is followed immediately by the parm block.
+ * The parm block contains:
+ * - function code ('PD' 0x5044 or 'PK' 0x504B)
+ * - rule block (0x0A00 'PKCS-1.2' or 0x0A00 'ZERO-PAD')
+ * - VUD block
+ */
+static struct CPRB static_cprb = {
+	.cprb_len	= __constant_cpu_to_le16(0x0070),
+	.cprb_ver_id	=  0x41,
+	.func_id	= {0x54,0x32},
+	.checkpoint_flag=  0x01,
+	.svr_namel	= __constant_cpu_to_le16(0x0008),
+	.svr_name	= {'I','C','S','F',' ',' ',' ',' '}
+};
+
+/**
+ * Check the message for PKCS11 padding.
+ */
+static inline int is_PKCS11_padded(unsigned char *buffer, int length)
+{
+	int i;
+	if ((buffer[0] != 0x00) || (buffer[1] != 0x01))
+		return 0;
+	for (i = 2; i < length; i++)
+		if (buffer[i] != 0xFF)
+			break;
+	if (i < 10 || i == length)
+		return 0;
+	if (buffer[i] != 0x00)
+		return 0;
+	return 1;
+}
+
+/**
+ * Check the message for PKCS12 padding.
+ */
+static inline int is_PKCS12_padded(unsigned char *buffer, int length)
+{
+	int i;
+	if ((buffer[0] != 0x00) || (buffer[1] != 0x02))
+		return 0;
+	for (i = 2; i < length; i++)
+		if (buffer[i] == 0x00)
+			break;
+	if ((i < 10) || (i == length))
+		return 0;
+	if (buffer[i] != 0x00)
+		return 0;
+	return 1;
+}
+
+/**
+ * Convert a ICAMEX message to a type6 MEX message.
+ *
+ * @zdev: crypto device pointer
+ * @zreq: crypto request pointer
+ * @mex: pointer to user input data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+static int ICAMEX_msg_to_type6MEX_msg(struct zcrypt_device *zdev,
+				      struct ap_message *ap_msg,
+				      struct ica_rsa_modexpo *mex)
+{
+	static struct type6_hdr static_type6_hdr = {
+		.type		=  0x06,
+		.offset1	=  0x00000058,
+		.agent_id	= {0x01,0x00,0x43,0x43,0x41,0x2D,0x41,0x50,
+				   0x50,0x4C,0x20,0x20,0x20,0x01,0x01,0x01},
+		.function_code	= {'P','K'},
+	};
+	static struct function_and_rules_block static_pke_function_and_rules ={
+		.function_code	= {'P','K'},
+		.ulen		= __constant_cpu_to_le16(10),
+		.only_rule	= {'P','K','C','S','-','1','.','2'}
+	};
+	struct {
+		struct type6_hdr hdr;
+		struct CPRB cprb;
+		struct function_and_rules_block fr;
+		unsigned short length;
+		char text[0];
+	} __attribute__((packed)) *msg = ap_msg->message;
+	int vud_len, pad_len, size;
+
+	/* VUD.ciphertext */
+	if (copy_from_user(msg->text, mex->inputdata, mex->inputdatalength))
+		return -EFAULT;
+
+	if (is_PKCS11_padded(msg->text, mex->inputdatalength))
+		return -EINVAL;
+
+	/* static message header and f&r */
+	msg->hdr = static_type6_hdr;
+	msg->fr = static_pke_function_and_rules;
+
+	if (is_PKCS12_padded(msg->text, mex->inputdatalength)) {
+		/* strip the padding and adjust the data length */
+		pad_len = strnlen(msg->text + 2, mex->inputdatalength - 2) + 3;
+		if (pad_len <= 9 || pad_len >= mex->inputdatalength)
+			return -ENODEV;
+		vud_len = mex->inputdatalength - pad_len;
+		memmove(msg->text, msg->text + pad_len, vud_len);
+		msg->length = cpu_to_le16(vud_len + 2);
+
+		/* Set up key after the variable length text. */
+		size = zcrypt_type6_mex_key_en(mex, msg->text + vud_len, 0);
+		if (size < 0)
+			return size;
+		size += sizeof(*msg) + vud_len;	/* total size of msg */
+	} else {
+		vud_len = mex->inputdatalength;
+		msg->length = cpu_to_le16(2 + vud_len);
+
+		msg->hdr.function_code[1] = 'D';
+		msg->fr.function_code[1] = 'D';
+
+		/* Set up key after the variable length text. */
+		size = zcrypt_type6_mex_key_de(mex, msg->text + vud_len, 0);
+		if (size < 0)
+			return size;
+		size += sizeof(*msg) + vud_len;	/* total size of msg */
+	}
+
+	/* message header, cprb and f&r */
+	msg->hdr.ToCardLen1 = (size - sizeof(msg->hdr) + 3) & -4;
+	msg->hdr.FromCardLen1 = PCICC_MAX_RESPONSE_SIZE - sizeof(msg->hdr);
+
+	msg->cprb = static_cprb;
+	msg->cprb.usage_domain[0]= AP_QID_QUEUE(zdev->ap_dev->qid);
+	msg->cprb.req_parml = cpu_to_le16(size - sizeof(msg->hdr) -
+					   sizeof(msg->cprb));
+	msg->cprb.rpl_parml = cpu_to_le16(msg->hdr.FromCardLen1);
+
+	ap_msg->length = (size + 3) & -4;
+	return 0;
+}
+
+/**
+ * Convert a ICACRT message to a type6 CRT message.
+ *
+ * @zdev: crypto device pointer
+ * @zreq: crypto request pointer
+ * @crt: pointer to user input data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+static int ICACRT_msg_to_type6CRT_msg(struct zcrypt_device *zdev,
+				      struct ap_message *ap_msg,
+				      struct ica_rsa_modexpo_crt *crt)
+{
+	static struct type6_hdr static_type6_hdr = {
+		.type		=  0x06,
+		.offset1	=  0x00000058,
+		.agent_id	= {0x01,0x00,0x43,0x43,0x41,0x2D,0x41,0x50,
+				   0x50,0x4C,0x20,0x20,0x20,0x01,0x01,0x01},
+		.function_code	= {'P','D'},
+	};
+	static struct function_and_rules_block static_pkd_function_and_rules ={
+		.function_code	= {'P','D'},
+		.ulen		= __constant_cpu_to_le16(10),
+		.only_rule	= {'P','K','C','S','-','1','.','2'}
+	};
+	struct {
+		struct type6_hdr hdr;
+		struct CPRB cprb;
+		struct function_and_rules_block fr;
+		unsigned short length;
+		char text[0];
+	} __attribute__((packed)) *msg = ap_msg->message;
+	int size;
+
+	/* VUD.ciphertext */
+	msg->length = cpu_to_le16(2 + crt->inputdatalength);
+	if (copy_from_user(msg->text, crt->inputdata, crt->inputdatalength))
+		return -EFAULT;
+
+	if (is_PKCS11_padded(msg->text, crt->inputdatalength))
+		return -EINVAL;
+
+	/* Set up key after the variable length text. */
+	size = zcrypt_type6_crt_key(crt, msg->text + crt->inputdatalength, 0);
+	if (size < 0)
+		return size;
+	size += sizeof(*msg) + crt->inputdatalength;	/* total size of msg */
+
+	/* message header, cprb and f&r */
+	msg->hdr = static_type6_hdr;
+	msg->hdr.ToCardLen1 = (size -  sizeof(msg->hdr) + 3) & -4;
+	msg->hdr.FromCardLen1 = PCICC_MAX_RESPONSE_SIZE - sizeof(msg->hdr);
+
+	msg->cprb = static_cprb;
+	msg->cprb.usage_domain[0] = AP_QID_QUEUE(zdev->ap_dev->qid);
+	msg->cprb.req_parml = msg->cprb.rpl_parml =
+		cpu_to_le16(size - sizeof(msg->hdr) - sizeof(msg->cprb));
+
+	msg->fr = static_pkd_function_and_rules;
+
+	ap_msg->length = (size + 3) & -4;
+	return 0;
+}
+
+/**
+ * Copy results from a type 86 reply message back to user space.
+ *
+ * @zdev: crypto device pointer
+ * @reply: reply AP message.
+ * @data: pointer to user output data
+ * @length: size of user output data
+ *
+ * Returns 0 on success or -EINVAL, -EFAULT, -EAGAIN in case of an error.
+ */
+struct type86_reply {
+	struct type86_hdr hdr;
+	struct type86_fmt2_ext fmt2;
+	struct CPRB cprb;
+	unsigned char pad[4];	/* 4 byte function code/rules block ? */
+	unsigned short length;
+	char text[0];
+} __attribute__((packed));
+
+static int convert_type86(struct zcrypt_device *zdev,
+			  struct ap_message *reply,
+			  char __user *outputdata,
+			  unsigned int outputdatalength)
+{
+	static unsigned char static_pad[] = {
+		0x00,0x02,
+		0x1B,0x7B,0x5D,0xB5,0x75,0x01,0x3D,0xFD,
+		0x8D,0xD1,0xC7,0x03,0x2D,0x09,0x23,0x57,
+		0x89,0x49,0xB9,0x3F,0xBB,0x99,0x41,0x5B,
+		0x75,0x21,0x7B,0x9D,0x3B,0x6B,0x51,0x39,
+		0xBB,0x0D,0x35,0xB9,0x89,0x0F,0x93,0xA5,
+		0x0B,0x47,0xF1,0xD3,0xBB,0xCB,0xF1,0x9D,
+		0x23,0x73,0x71,0xFF,0xF3,0xF5,0x45,0xFB,
+		0x61,0x29,0x23,0xFD,0xF1,0x29,0x3F,0x7F,
+		0x17,0xB7,0x1B,0xA9,0x19,0xBD,0x57,0xA9,
+		0xD7,0x95,0xA3,0xCB,0xED,0x1D,0xDB,0x45,
+		0x7D,0x11,0xD1,0x51,0x1B,0xED,0x71,0xE9,
+		0xB1,0xD1,0xAB,0xAB,0x21,0x2B,0x1B,0x9F,
+		0x3B,0x9F,0xF7,0xF7,0xBD,0x63,0xEB,0xAD,
+		0xDF,0xB3,0x6F,0x5B,0xDB,0x8D,0xA9,0x5D,
+		0xE3,0x7D,0x77,0x49,0x47,0xF5,0xA7,0xFD,
+		0xAB,0x2F,0x27,0x35,0x77,0xD3,0x49,0xC9,
+		0x09,0xEB,0xB1,0xF9,0xBF,0x4B,0xCB,0x2B,
+		0xEB,0xEB,0x05,0xFF,0x7D,0xC7,0x91,0x8B,
+		0x09,0x83,0xB9,0xB9,0x69,0x33,0x39,0x6B,
+		0x79,0x75,0x19,0xBF,0xBB,0x07,0x1D,0xBD,
+		0x29,0xBF,0x39,0x95,0x93,0x1D,0x35,0xC7,
+		0xC9,0x4D,0xE5,0x97,0x0B,0x43,0x9B,0xF1,
+		0x16,0x93,0x03,0x1F,0xA5,0xFB,0xDB,0xF3,
+		0x27,0x4F,0x27,0x61,0x05,0x1F,0xB9,0x23,
+		0x2F,0xC3,0x81,0xA9,0x23,0x71,0x55,0x55,
+		0xEB,0xED,0x41,0xE5,0xF3,0x11,0xF1,0x43,
+		0x69,0x03,0xBD,0x0B,0x37,0x0F,0x51,0x8F,
+		0x0B,0xB5,0x89,0x5B,0x67,0xA9,0xD9,0x4F,
+		0x01,0xF9,0x21,0x77,0x37,0x73,0x79,0xC5,
+		0x7F,0x51,0xC1,0xCF,0x97,0xA1,0x75,0xAD,
+		0x35,0x9D,0xD3,0xD3,0xA7,0x9D,0x5D,0x41,
+		0x6F,0x65,0x1B,0xCF,0xA9,0x87,0x91,0x09
+	};
+	struct type86_reply *msg = reply->message;
+	unsigned short service_rc, service_rs;
+	unsigned int reply_len, pad_len;
+	char *data;
+
+	service_rc = le16_to_cpu(msg->cprb.ccp_rtcode);
+	if (unlikely(service_rc != 0)) {
+		service_rs = le16_to_cpu(msg->cprb.ccp_rscode);
+		if (service_rc == 8 && service_rs == 66) {
+			PDEBUG("Bad block format on PCICC\n");
+			return -EINVAL;
+		}
+		if (service_rc == 8 && service_rs == 65) {
+			PDEBUG("Probably an even modulus on PCICC\n");
+			return -EINVAL;
+		}
+		if (service_rc == 8 && service_rs == 770) {
+			PDEBUG("Invalid key length on PCICC\n");
+			zdev->max_mod_size = PCICC_MAX_MOD_SIZE_OLD;
+			return -EAGAIN;
+		}
+		if (service_rc == 8 && service_rs == 783) {
+			PDEBUG("Extended bitlengths not enabled on PCICC\n");
+			zdev->max_mod_size = PCICC_MAX_MOD_SIZE_OLD;
+			return -EAGAIN;
+		}
+		PRINTK("Unknown service rc/rs (PCICC): %d/%d\n",
+		       service_rc, service_rs);
+		zdev->online = 0;
+		return -EAGAIN;	/* repeat the request on a different device. */
+	}
+	data = msg->text;
+	reply_len = le16_to_cpu(msg->length) - 2;
+	if (reply_len > outputdatalength)
+		return -EINVAL;
+	/**
+	 * For all encipher requests, the length of the ciphertext (reply_len)
+	 * will always equal the modulus length. For MEX decipher requests
+	 * the output needs to get padded. Minimum pad size is 10.
+	 *
+	 * Currently, the cases where padding will be added is for:
+	 * - PCIXCC_MCL2 using a CRT form token (since PKD didn't support
+	 *   ZERO-PAD and CRT is only supported for PKD requests)
+	 * - PCICC, always
+	 */
+	pad_len = outputdatalength - reply_len;
+	if (pad_len > 0) {
+		if (pad_len < 10)
+			return -EINVAL;
+		/* 'restore' padding left in the PCICC/PCIXCC card. */
+		if (copy_to_user(outputdata, static_pad, pad_len - 1))
+			return -EFAULT;
+		if (put_user(0, outputdata + pad_len - 1))
+			return -EFAULT;
+	}
+	/* Copy the crypto response to user space. */
+	if (copy_to_user(outputdata + pad_len, data, reply_len))
+		return -EFAULT;
+	return 0;
+}
+
+static int convert_response(struct zcrypt_device *zdev,
+			    struct ap_message *reply,
+			    char __user *outputdata,
+			    unsigned int outputdatalength)
+{
+	struct type86_reply *msg = reply->message;
+
+	/* Response type byte is the second byte in the response. */
+	switch (msg->hdr.type) {
+	case TYPE82_RSP_CODE:
+	case TYPE88_RSP_CODE:
+		return convert_error(zdev, reply);
+	case TYPE86_RSP_CODE:
+		if (msg->hdr.reply_code)
+			return convert_error(zdev, reply);
+		if (msg->cprb.cprb_ver_id == 0x01)
+			return convert_type86(zdev, reply,
+					      outputdata, outputdatalength);
+		/* no break, incorrect cprb version is an unknown response */
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
+static void zcrypt_pcicc_receive(struct ap_device *ap_dev,
+				 struct ap_message *msg,
+				 struct ap_message *reply)
+{
+	static struct error_hdr error_reply = {
+		.type = TYPE82_RSP_CODE,
+		.reply_code = REP82_ERROR_MACHINE_FAILURE,
+	};
+	struct type86_reply *t86r = reply->message;
+	int length;
+
+	/* Copy the reply message to the request message buffer. */
+	if (IS_ERR(reply))
+		memcpy(msg->message, &error_reply, sizeof(error_reply));
+	else if (t86r->hdr.type == TYPE86_RSP_CODE &&
+		 t86r->cprb.cprb_ver_id == 0x01) {
+		length = sizeof(struct type86_reply) + t86r->length - 2;
+		length = min(PCICC_MAX_RESPONSE_SIZE, length);
+		memcpy(msg->message, reply->message, length);
+	} else
+		memcpy(msg->message, reply->message, sizeof error_reply);
+	complete((struct completion *) msg->private);
+}
+
+static atomic_t zcrypt_step = ATOMIC_INIT(0);
+
+/**
+ * The request distributor calls this function if it picked the PCICC
+ * device to handle a modexpo request.
+ * @zdev: pointer to zcrypt_device structure that identifies the
+ *	  PCICC device to the request distributor
+ * @mex: pointer to the modexpo request buffer
+ */
+static long zcrypt_pcicc_modexpo(struct zcrypt_device *zdev,
+				 struct ica_rsa_modexpo *mex)
+{
+	struct ap_message ap_msg;
+	struct completion work;
+	int rc;
+
+	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!ap_msg.message)
+		return -ENOMEM;
+	ap_msg.length = PAGE_SIZE;
+	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
+				atomic_inc_return(&zcrypt_step);
+	ap_msg.private = &work;
+	rc = ICAMEX_msg_to_type6MEX_msg(zdev, &ap_msg, mex);
+	if (rc)
+		goto out_free;
+	init_completion(&work);
+	ap_queue_message(zdev->ap_dev, &ap_msg);
+	rc = wait_for_completion_interruptible_timeout(
+				&work, PCICC_CLEANUP_TIME);
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
+	free_page((unsigned long) ap_msg.message);
+	return rc;
+}
+
+/**
+ * The request distributor calls this function if it picked the PCICC
+ * device to handle a modexpo_crt request.
+ * @zdev: pointer to zcrypt_device structure that identifies the
+ *	  PCICC device to the request distributor
+ * @crt: pointer to the modexpoc_crt request buffer
+ */
+static long zcrypt_pcicc_modexpo_crt(struct zcrypt_device *zdev,
+				     struct ica_rsa_modexpo_crt *crt)
+{
+	struct ap_message ap_msg;
+	struct completion work;
+	int rc;
+
+	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!ap_msg.message)
+		return -ENOMEM;
+	ap_msg.length = PAGE_SIZE;
+	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
+				atomic_inc_return(&zcrypt_step);
+	ap_msg.private = &work;
+	rc = ICACRT_msg_to_type6CRT_msg(zdev, &ap_msg, crt);
+	if (rc)
+		goto out_free;
+	init_completion(&work);
+	ap_queue_message(zdev->ap_dev, &ap_msg);
+	rc = wait_for_completion_interruptible_timeout(
+				&work, PCICC_CLEANUP_TIME);
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
+	free_page((unsigned long) ap_msg.message);
+	return rc;
+}
+
+/**
+ * The crypto operations for a PCICC card.
+ */
+static struct zcrypt_ops zcrypt_pcicc_ops = {
+	.rsa_modexpo = zcrypt_pcicc_modexpo,
+	.rsa_modexpo_crt = zcrypt_pcicc_modexpo_crt,
+};
+
+/**
+ * Probe function for PCICC cards. It always accepts the AP device
+ * since the bus_match already checked the hardware type.
+ * @ap_dev: pointer to the AP device.
+ */
+static int zcrypt_pcicc_probe(struct ap_device *ap_dev)
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
+	zdev->ops = &zcrypt_pcicc_ops;
+	zdev->online = 1;
+	zdev->user_space_type = ZCRYPT_PCICC;
+	zdev->type_string = "PCICC";
+	zdev->min_mod_size = PCICC_MIN_MOD_SIZE;
+	zdev->max_mod_size = PCICC_MAX_MOD_SIZE;
+	zdev->speed_rating = PCICC_SPEED_RATING;
+	zdev->reply.message = kmalloc(PCICC_MAX_RESPONSE_SIZE, GFP_KERNEL);
+	if (!zdev->reply.message) {
+		rc = -ENOMEM;
+		goto out_free;
+	}
+	zdev->reply.length = PCICC_MAX_RESPONSE_SIZE;
+	ap_dev->reply = &zdev->reply;
+	ap_dev->private = zdev;
+	rc = zcrypt_device_register(zdev);
+	if (rc)
+		goto out_free;
+	return 0;
+
+ out_free:
+	ap_dev->private = NULL;
+	kfree(zdev);
+	return rc;
+}
+
+/**
+ * This is called to remove the extended PCICC driver information
+ * if an AP device is removed.
+ */
+static void zcrypt_pcicc_remove(struct ap_device *ap_dev)
+{
+	struct zcrypt_device *zdev = ap_dev->private;
+
+	zcrypt_device_unregister(zdev);
+}
+
+/**
+ * This is called to release the extended PCICC driver information
+ * if an AP device is release.
+ */
+static void zcrypt_pcicc_release(struct ap_device *ap_dev)
+{
+	struct zcrypt_device *zdev = ap_dev->private;
+
+	kfree(zdev);
+}
+
+int __init zcrypt_pcicc_init(void)
+{
+	return ap_driver_register(&zcrypt_pcicc_driver, THIS_MODULE, "pcicc");
+}
+
+void __exit zcrypt_pcicc_exit(void)
+{
+	ap_driver_unregister(&zcrypt_pcicc_driver);
+}
+
+#ifndef CONFIG_ZCRYPT_MONOLITHIC
+module_init(zcrypt_pcicc_init);
+module_exit(zcrypt_pcicc_exit);
+#endif
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcicc.h linux-2.6-patched/drivers/s390/crypto/zcrypt_pcicc.h
--- linux-2.6/drivers/s390/crypto/zcrypt_pcicc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcicc.h	2006-07-04 18:31:38.000000000 +0200
@@ -0,0 +1,176 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_pcicc.h
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
+#ifndef _ZCRYPT_PCICC_H_
+#define _ZCRYPT_PCICC_H_
+
+/**
+ * The type 6 message family is associated with PCICC or PCIXCC cards.
+ *
+ * It contains a message header followed by a CPRB, both of which
+ * are described below.
+ *
+ * Note that all reserved fields must be zeroes.
+ */
+struct type6_hdr {
+	unsigned char reserved1;	/* 0x00				*/
+	unsigned char type;		/* 0x06				*/
+	unsigned char reserved2[2];	/* 0x0000			*/
+	unsigned char right[4];		/* 0x00000000			*/
+	unsigned char reserved3[2];	/* 0x0000			*/
+	unsigned char reserved4[2];	/* 0x0000			*/
+	unsigned char apfs[4];		/* 0x00000000			*/
+	unsigned int  offset1;		/* 0x00000058 (offset to CPRB)	*/
+	unsigned int  offset2;		/* 0x00000000			*/
+	unsigned int  offset3;		/* 0x00000000			*/
+	unsigned int  offset4;		/* 0x00000000			*/
+	unsigned char agent_id[16];	/* PCICC:			*/
+					/*    0x0100			*/
+					/*    0x4343412d4150504c202020	*/
+					/*    0x010101			*/
+					/* PCIXCC:			*/
+					/*    0x4341000000000000	*/
+					/*    0x0000000000000000	*/
+	unsigned char rqid[2];		/* rqid.  internal to 603	*/
+	unsigned char reserved5[2];	/* 0x0000			*/
+	unsigned char function_code[2];	/* for PKD, 0x5044 (ascii 'PD')	*/
+	unsigned char reserved6[2];	/* 0x0000			*/
+	unsigned int  ToCardLen1;	/* (request CPRB len + 3) & -4	*/
+	unsigned int  ToCardLen2;	/* db len 0x00000000 for PKD	*/
+	unsigned int  ToCardLen3;	/* 0x00000000			*/
+	unsigned int  ToCardLen4;	/* 0x00000000			*/
+	unsigned int  FromCardLen1;	/* response buffer length	*/
+	unsigned int  FromCardLen2;	/* db len 0x00000000 for PKD	*/
+	unsigned int  FromCardLen3;	/* 0x00000000			*/
+	unsigned int  FromCardLen4;	/* 0x00000000			*/
+} __attribute__((packed));
+
+/**
+ * CPRB
+ *	  Note that all shorts, ints and longs are little-endian.
+ *	  All pointer fields are 32-bits long, and mean nothing
+ *
+ *	  A request CPRB is followed by a request_parameter_block.
+ *
+ *	  The request (or reply) parameter block is organized thus:
+ *	    function code
+ *	    VUD block
+ *	    key block
+ */
+struct CPRB {
+	unsigned short cprb_len;	/* CPRB length			 */
+	unsigned char cprb_ver_id;	/* CPRB version id.		 */
+	unsigned char pad_000;		/* Alignment pad byte.		 */
+	unsigned char srpi_rtcode[4];	/* SRPI return code LELONG	 */
+	unsigned char srpi_verb;	/* SRPI verb type		 */
+	unsigned char flags;		/* flags			 */
+	unsigned char func_id[2];	/* function id			 */
+	unsigned char checkpoint_flag;	/*				 */
+	unsigned char resv2;		/* reserved			 */
+	unsigned short req_parml;	/* request parameter buffer	 */
+					/* length 16-bit little endian	 */
+	unsigned char req_parmp[4];	/* request parameter buffer	 *
+					 * pointer (means nothing: the	 *
+					 * parameter buffer follows	 *
+					 * the CPRB).			 */
+	unsigned char req_datal[4];	/* request data buffer		 */
+					/* length	  ULELONG	 */
+	unsigned char req_datap[4];	/* request data buffer		 */
+					/* pointer			 */
+	unsigned short rpl_parml;	/* reply  parameter buffer	 */
+					/* length 16-bit little endian	 */
+	unsigned char pad_001[2];	/* Alignment pad bytes. ULESHORT */
+	unsigned char rpl_parmp[4];	/* reply parameter buffer	 *
+					 * pointer (means nothing: the	 *
+					 * parameter buffer follows	 *
+					 * the CPRB).			 */
+	unsigned char rpl_datal[4];	/* reply data buffer len ULELONG */
+	unsigned char rpl_datap[4];	/* reply data buffer		 */
+					/* pointer			 */
+	unsigned short ccp_rscode;	/* server reason code	ULESHORT */
+	unsigned short ccp_rtcode;	/* server return code	ULESHORT */
+	unsigned char repd_parml[2];	/* replied parameter len ULESHORT*/
+	unsigned char mac_data_len[2];	/* Mac Data Length	ULESHORT */
+	unsigned char repd_datal[4];	/* replied data length	ULELONG	 */
+	unsigned char req_pc[2];	/* PC identifier		 */
+	unsigned char res_origin[8];	/* resource origin		 */
+	unsigned char mac_value[8];	/* Mac Value			 */
+	unsigned char logon_id[8];	/* Logon Identifier		 */
+	unsigned char usage_domain[2];	/* cdx				 */
+	unsigned char resv3[18];	/* reserved for requestor	 */
+	unsigned short svr_namel;	/* server name length  ULESHORT	 */
+	unsigned char svr_name[8];	/* server name			 */
+} __attribute__((packed));
+
+/**
+ * The type 86 message family is associated with PCICC and PCIXCC cards.
+ *
+ * It contains a message header followed by a CPRB.  The CPRB is
+ * the same as the request CPRB, which is described above.
+ *
+ * If format is 1, an error condition exists and no data beyond
+ * the 8-byte message header is of interest.
+ *
+ * The non-error message is shown below.
+ *
+ * Note that all reserved fields must be zeroes.
+ */
+struct type86_hdr {
+	unsigned char reserved1;	/* 0x00				*/
+	unsigned char type;		/* 0x86				*/
+	unsigned char format;		/* 0x01 (error) or 0x02 (ok)	*/
+	unsigned char reserved2;	/* 0x00				*/
+	unsigned char reply_code;	/* reply code (see above)	*/
+	unsigned char reserved3[3];	/* 0x000000			*/
+} __attribute__((packed));
+
+#define TYPE86_RSP_CODE 0x86
+#define TYPE86_FMT2	0x02
+
+struct type86_fmt2_ext {
+	unsigned char	  reserved[4];	/* 0x00000000			*/
+	unsigned char	  apfs[4];	/* final status			*/
+	unsigned int	  count1;	/* length of CPRB + parameters	*/
+	unsigned int	  offset1;	/* offset to CPRB		*/
+	unsigned int	  count2;	/* 0x00000000			*/
+	unsigned int	  offset2;	/* db offset 0x00000000 for PKD	*/
+	unsigned int	  count3;	/* 0x00000000			*/
+	unsigned int	  offset3;	/* 0x00000000			*/
+	unsigned int	  count4;	/* 0x00000000			*/
+	unsigned int	  offset4;	/* 0x00000000			*/
+} __attribute__((packed));
+
+struct function_and_rules_block {
+	unsigned char function_code[2];
+	unsigned short ulen;
+	unsigned char only_rule[8];
+} __attribute__((packed));
+
+int zcrypt_pcicc_init(void);
+void zcrypt_pcicc_exit(void);
+
+#endif /* _ZCRYPT_PCICC_H_ */
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcixcc.c linux-2.6-patched/drivers/s390/crypto/zcrypt_pcixcc.c
--- linux-2.6/drivers/s390/crypto/zcrypt_pcixcc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcixcc.c	2006-07-04 18:31:38.000000000 +0200
@@ -0,0 +1,735 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_pcixcc.c
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
+#include <linux/delay.h>
+#include <asm/atomic.h>
+#include <asm/uaccess.h>
+
+#include "ap_bus.h"
+#include "zcrypt_api.h"
+#include "zcrypt_error.h"
+#include "zcrypt_pcicc.h"
+#include "zcrypt_pcixcc.h"
+#include "zcrypt_cca_key.h"
+
+#define PCIXCC_MIN_MOD_SIZE	 16	/*  128 bits	*/
+#define PCIXCC_MIN_MOD_SIZE_OLD	 64	/*  512 bits	*/
+#define PCIXCC_MAX_MOD_SIZE	256	/* 2048 bits	*/
+
+#define PCIXCC_MCL2_SPEED_RATING	7870	/* FIXME: needs finetuning */
+#define PCIXCC_MCL3_SPEED_RATING	7870
+#define CEX2C_SPEED_RATING		8540
+
+#define PCIXCC_MAX_ICA_MESSAGE_SIZE 0x77c  /* max size type6 v2 crt message */
+#define PCIXCC_MAX_ICA_RESPONSE_SIZE 0x77c /* max size type86 v2 reply	    */
+
+#define PCIXCC_MAX_XCRB_MESSAGE_SIZE (12*1024)
+#define PCIXCC_MAX_XCRB_RESPONSE_SIZE PCIXCC_MAX_XCRB_MESSAGE_SIZE
+#define PCIXCC_MAX_XCRB_DATA_SIZE (11*1024)
+#define PCIXCC_MAX_XCRB_REPLY_SIZE (5*1024)
+
+#define PCIXCC_MAX_RESPONSE_SIZE PCIXCC_MAX_XCRB_RESPONSE_SIZE
+
+#define PCIXCC_CLEANUP_TIME	(15*HZ)
+
+static struct ap_device_id zcrypt_pcixcc_ids[] = {
+	{ AP_DEVICE(AP_DEVICE_TYPE_PCIXCC) },
+	{ AP_DEVICE(AP_DEVICE_TYPE_CEX2C) },
+	{ /* end of list */ },
+};
+
+#ifndef CONFIG_ZCRYPT_MONOLITHIC
+MODULE_DEVICE_TABLE(ap, zcrypt_pcixcc_ids);
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("PCIXCC Cryptographic Coprocessor device driver, "
+		   "Copyright 2001, 2006 IBM Corporation");
+MODULE_LICENSE("GPL");
+#endif
+
+static int zcrypt_pcixcc_probe(struct ap_device *ap_dev);
+static void zcrypt_pcixcc_remove(struct ap_device *ap_dev);
+static void zcrypt_pcixcc_release(struct ap_device *ap_dev);
+static void zcrypt_pcixcc_receive(struct ap_device *, struct ap_message *,
+				 struct ap_message *);
+
+static struct ap_driver zcrypt_pcixcc_driver = {
+	.probe = zcrypt_pcixcc_probe,
+	.remove = zcrypt_pcixcc_remove,
+	.release = zcrypt_pcixcc_release,
+	.receive = zcrypt_pcixcc_receive,
+	.ids = zcrypt_pcixcc_ids,
+};
+
+/**
+ * The following is used to initialize the CPRBX passed to the PCIXCC/CEX2C
+ * card in a type6 message. The 3 fields that must be filled in at execution
+ * time are  req_parml, rpl_parml and usage_domain.
+ * Everything about this interface is ascii/big-endian, since the
+ * device does *not* have 'Intel inside'.
+ *
+ * The CPRBX is followed immediately by the parm block.
+ * The parm block contains:
+ * - function code ('PD' 0x5044 or 'PK' 0x504B)
+ * - rule block (one of:)
+ *   + 0x000A 'PKCS-1.2' (MCL2 'PD')
+ *   + 0x000A 'ZERO-PAD' (MCL2 'PK')
+ *   + 0x000A 'ZERO-PAD' (MCL3 'PD' or CEX2C 'PD')
+ *   + 0x000A 'MRP     ' (MCL3 'PK' or CEX2C 'PK')
+ * - VUD block
+ */
+static struct CPRBX static_cprbx = {
+	.cprb_len	=  0x00DC,
+	.cprb_ver_id	=  0x02,
+	.func_id	= {0x54,0x32},
+};
+
+/**
+ * Convert a ICAMEX message to a type6 MEX message.
+ *
+ * @zdev: crypto device pointer
+ * @ap_msg: pointer to AP message
+ * @mex: pointer to user input data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+static int ICAMEX_msg_to_type6MEX_msgX(struct zcrypt_device *zdev,
+				       struct ap_message *ap_msg,
+				       struct ica_rsa_modexpo *mex)
+{
+	static struct type6_hdr static_type6_hdrX = {
+		.type		=  0x06,
+		.offset1	=  0x00000058,
+		.agent_id	= {'C','A',},
+		.function_code	= {'P','K'},
+	};
+	static struct function_and_rules_block static_pke_fnr = {
+		.function_code	= {'P','K'},
+		.ulen		= 10,
+		.only_rule	= {'M','R','P',' ',' ',' ',' ',' '}
+	};
+	static struct function_and_rules_block static_pke_fnr_MCL2 = {
+		.function_code	= {'P','K'},
+		.ulen		= 10,
+		.only_rule	= {'Z','E','R','O','-','P','A','D'}
+	};
+	struct {
+		struct type6_hdr hdr;
+		struct CPRBX cprbx;
+		struct function_and_rules_block fr;
+		unsigned short length;
+		char text[0];
+	} __attribute__((packed)) *msg = ap_msg->message;
+	int size;
+
+	/* VUD.ciphertext */
+	msg->length = mex->inputdatalength + 2;
+	if (copy_from_user(msg->text, mex->inputdata, mex->inputdatalength))
+		return -EFAULT;
+
+	/* Set up key which is located after the variable length text. */
+	size = zcrypt_type6_mex_key_en(mex, msg->text+mex->inputdatalength, 1);
+	if (size < 0)
+		return size;
+	size += sizeof(*msg) + mex->inputdatalength;
+
+	/* message header, cprbx and f&r */
+	msg->hdr = static_type6_hdrX;
+	msg->hdr.ToCardLen1 = size - sizeof(msg->hdr);
+	msg->hdr.FromCardLen1 = PCIXCC_MAX_ICA_RESPONSE_SIZE - sizeof(msg->hdr);
+
+	msg->cprbx = static_cprbx;
+	msg->cprbx.domain = AP_QID_QUEUE(zdev->ap_dev->qid);
+	msg->cprbx.rpl_msgbl = msg->hdr.FromCardLen1;
+
+	msg->fr = (zdev->user_space_type == ZCRYPT_PCIXCC_MCL2) ?
+		static_pke_fnr_MCL2 : static_pke_fnr;
+
+	msg->cprbx.req_parml = size - sizeof(msg->hdr) - sizeof(msg->cprbx);
+
+	ap_msg->length = size;
+	return 0;
+}
+
+/**
+ * Convert a ICACRT message to a type6 CRT message.
+ *
+ * @zdev: crypto device pointer
+ * @ap_msg: pointer to AP message
+ * @crt: pointer to user input data
+ *
+ * Returns 0 on success or -EFAULT.
+ */
+static int ICACRT_msg_to_type6CRT_msgX(struct zcrypt_device *zdev,
+				       struct ap_message *ap_msg,
+				       struct ica_rsa_modexpo_crt *crt)
+{
+	static struct type6_hdr static_type6_hdrX = {
+		.type		=  0x06,
+		.offset1	=  0x00000058,
+		.agent_id	= {'C','A',},
+		.function_code	= {'P','D'},
+	};
+	static struct function_and_rules_block static_pkd_fnr = {
+		.function_code	= {'P','D'},
+		.ulen		= 10,
+		.only_rule	= {'Z','E','R','O','-','P','A','D'}
+	};
+
+	static struct function_and_rules_block static_pkd_fnr_MCL2 = {
+		.function_code	= {'P','D'},
+		.ulen		= 10,
+		.only_rule	= {'P','K','C','S','-','1','.','2'}
+	};
+	struct {
+		struct type6_hdr hdr;
+		struct CPRBX cprbx;
+		struct function_and_rules_block fr;
+		unsigned short length;
+		char text[0];
+	} __attribute__((packed)) *msg = ap_msg->message;
+	int size;
+
+	/* VUD.ciphertext */
+	msg->length = crt->inputdatalength + 2;
+	if (copy_from_user(msg->text, crt->inputdata, crt->inputdatalength))
+		return -EFAULT;
+
+	/* Set up key which is located after the variable length text. */
+	size = zcrypt_type6_crt_key(crt, msg->text + crt->inputdatalength, 1);
+	if (size < 0)
+		return size;
+	size += sizeof(*msg) + crt->inputdatalength;	/* total size of msg */
+
+	/* message header, cprbx and f&r */
+	msg->hdr = static_type6_hdrX;
+	msg->hdr.ToCardLen1 = size -  sizeof(msg->hdr);
+	msg->hdr.FromCardLen1 = PCIXCC_MAX_ICA_RESPONSE_SIZE - sizeof(msg->hdr);
+
+	msg->cprbx = static_cprbx;
+	msg->cprbx.domain = AP_QID_QUEUE(zdev->ap_dev->qid);
+	msg->cprbx.req_parml = msg->cprbx.rpl_msgbl =
+		size - sizeof(msg->hdr) - sizeof(msg->cprbx);
+
+	msg->fr = (zdev->user_space_type == ZCRYPT_PCIXCC_MCL2) ?
+		static_pkd_fnr_MCL2 : static_pkd_fnr;
+
+	ap_msg->length = size;
+	return 0;
+}
+
+/**
+ * Copy results from a type 86 ICA reply message back to user space.
+ *
+ * @zdev: crypto device pointer
+ * @reply: reply AP message.
+ * @data: pointer to user output data
+ * @length: size of user output data
+ *
+ * Returns 0 on success or -EINVAL, -EFAULT, -EAGAIN in case of an error.
+ */
+struct type86x_reply {
+	struct type86_hdr hdr;
+	struct type86_fmt2_ext fmt2;
+	struct CPRBX cprbx;
+	unsigned char pad[4];	/* 4 byte function code/rules block ? */
+	unsigned short length;
+	char text[0];
+} __attribute__((packed));
+
+static int convert_type86_ica(struct zcrypt_device *zdev,
+			  struct ap_message *reply,
+			  char __user *outputdata,
+			  unsigned int outputdatalength)
+{
+	static unsigned char static_pad[] = {
+		0x00,0x02,
+		0x1B,0x7B,0x5D,0xB5,0x75,0x01,0x3D,0xFD,
+		0x8D,0xD1,0xC7,0x03,0x2D,0x09,0x23,0x57,
+		0x89,0x49,0xB9,0x3F,0xBB,0x99,0x41,0x5B,
+		0x75,0x21,0x7B,0x9D,0x3B,0x6B,0x51,0x39,
+		0xBB,0x0D,0x35,0xB9,0x89,0x0F,0x93,0xA5,
+		0x0B,0x47,0xF1,0xD3,0xBB,0xCB,0xF1,0x9D,
+		0x23,0x73,0x71,0xFF,0xF3,0xF5,0x45,0xFB,
+		0x61,0x29,0x23,0xFD,0xF1,0x29,0x3F,0x7F,
+		0x17,0xB7,0x1B,0xA9,0x19,0xBD,0x57,0xA9,
+		0xD7,0x95,0xA3,0xCB,0xED,0x1D,0xDB,0x45,
+		0x7D,0x11,0xD1,0x51,0x1B,0xED,0x71,0xE9,
+		0xB1,0xD1,0xAB,0xAB,0x21,0x2B,0x1B,0x9F,
+		0x3B,0x9F,0xF7,0xF7,0xBD,0x63,0xEB,0xAD,
+		0xDF,0xB3,0x6F,0x5B,0xDB,0x8D,0xA9,0x5D,
+		0xE3,0x7D,0x77,0x49,0x47,0xF5,0xA7,0xFD,
+		0xAB,0x2F,0x27,0x35,0x77,0xD3,0x49,0xC9,
+		0x09,0xEB,0xB1,0xF9,0xBF,0x4B,0xCB,0x2B,
+		0xEB,0xEB,0x05,0xFF,0x7D,0xC7,0x91,0x8B,
+		0x09,0x83,0xB9,0xB9,0x69,0x33,0x39,0x6B,
+		0x79,0x75,0x19,0xBF,0xBB,0x07,0x1D,0xBD,
+		0x29,0xBF,0x39,0x95,0x93,0x1D,0x35,0xC7,
+		0xC9,0x4D,0xE5,0x97,0x0B,0x43,0x9B,0xF1,
+		0x16,0x93,0x03,0x1F,0xA5,0xFB,0xDB,0xF3,
+		0x27,0x4F,0x27,0x61,0x05,0x1F,0xB9,0x23,
+		0x2F,0xC3,0x81,0xA9,0x23,0x71,0x55,0x55,
+		0xEB,0xED,0x41,0xE5,0xF3,0x11,0xF1,0x43,
+		0x69,0x03,0xBD,0x0B,0x37,0x0F,0x51,0x8F,
+		0x0B,0xB5,0x89,0x5B,0x67,0xA9,0xD9,0x4F,
+		0x01,0xF9,0x21,0x77,0x37,0x73,0x79,0xC5,
+		0x7F,0x51,0xC1,0xCF,0x97,0xA1,0x75,0xAD,
+		0x35,0x9D,0xD3,0xD3,0xA7,0x9D,0x5D,0x41,
+		0x6F,0x65,0x1B,0xCF,0xA9,0x87,0x91,0x09
+	};
+	struct type86x_reply *msg = reply->message;
+	unsigned short service_rc, service_rs;
+	unsigned int reply_len, pad_len;
+	char *data;
+
+	service_rc = msg->cprbx.ccp_rtcode;
+	if (unlikely(service_rc != 0)) {
+		service_rs = msg->cprbx.ccp_rscode;
+		if (service_rc == 8 && service_rs == 66) {
+			PDEBUG("Bad block format on PCIXCC/CEX2C\n");
+			return -EINVAL;
+		}
+		if (service_rc == 8 && service_rs == 65) {
+			PDEBUG("Probably an even modulus on PCIXCC/CEX2C\n");
+			return -EINVAL;
+		}
+		if (service_rc == 8 && service_rs == 770) {
+			PDEBUG("Invalid key length on PCIXCC/CEX2C\n");
+			zdev->min_mod_size = PCIXCC_MIN_MOD_SIZE_OLD;
+			return -EAGAIN;
+		}
+		if (service_rc == 8 && service_rs == 783) {
+			PDEBUG("Extended bitlengths not enabled on PCIXCC/CEX2C\n");
+			zdev->min_mod_size = PCIXCC_MIN_MOD_SIZE_OLD;
+			return -EAGAIN;
+		}
+		PRINTK("Unknown service rc/rs (PCIXCC/CEX2C): %d/%d\n",
+		       service_rc, service_rs);
+		zdev->online = 0;
+		return -EAGAIN;	/* repeat the request on a different device. */
+	}
+	data = msg->text;
+	reply_len = msg->length - 2;
+	if (reply_len > outputdatalength)
+		return -EINVAL;
+	/**
+	 * For all encipher requests, the length of the ciphertext (reply_len)
+	 * will always equal the modulus length. For MEX decipher requests
+	 * the output needs to get padded. Minimum pad size is 10.
+	 *
+	 * Currently, the cases where padding will be added is for:
+	 * - PCIXCC_MCL2 using a CRT form token (since PKD didn't support
+	 *   ZERO-PAD and CRT is only supported for PKD requests)
+	 * - PCICC, always
+	 */
+	pad_len = outputdatalength - reply_len;
+	if (pad_len > 0) {
+		if (pad_len < 10)
+			return -EINVAL;
+		/* 'restore' padding left in the PCICC/PCIXCC card. */
+		if (copy_to_user(outputdata, static_pad, pad_len - 1))
+			return -EFAULT;
+		if (put_user(0, outputdata + pad_len - 1))
+			return -EFAULT;
+	}
+	/* Copy the crypto response to user space. */
+	if (copy_to_user(outputdata + pad_len, data, reply_len))
+		return -EFAULT;
+	return 0;
+}
+
+static int convert_response_ica(struct zcrypt_device *zdev,
+			    struct ap_message *reply,
+			    char __user *outputdata,
+			    unsigned int outputdatalength)
+{
+	struct type86x_reply *msg = reply->message;
+
+	/* Response type byte is the second byte in the response. */
+	switch (((unsigned char *) reply->message)[1]) {
+	case TYPE82_RSP_CODE:
+	case TYPE88_RSP_CODE:
+		return convert_error(zdev, reply);
+	case TYPE86_RSP_CODE:
+		if (msg->hdr.reply_code)
+			return convert_error(zdev, reply);
+		if (msg->cprbx.cprb_ver_id == 0x02)
+			return convert_type86_ica(zdev, reply,
+						  outputdata, outputdatalength);
+		/* no break, incorrect cprb version is an unknown response */
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
+static void zcrypt_pcixcc_receive(struct ap_device *ap_dev,
+				  struct ap_message *msg,
+				  struct ap_message *reply)
+{
+	static struct error_hdr error_reply = {
+		.type = TYPE82_RSP_CODE,
+		.reply_code = REP82_ERROR_MACHINE_FAILURE,
+	};
+	struct type86x_reply *t86r = reply->message;
+	int length;
+
+	/* Copy the reply message to the request message buffer. */
+	if (IS_ERR(reply))
+		memcpy(msg->message, &error_reply, sizeof(error_reply));
+	else if (t86r->hdr.type == TYPE86_RSP_CODE &&
+		 t86r->cprbx.cprb_ver_id == 0x02) {
+		length = sizeof(struct type86x_reply) + t86r->length - 2;
+		length = min(PCIXCC_MAX_ICA_RESPONSE_SIZE, length);
+		memcpy(msg->message, reply->message, length);
+	} else
+		memcpy(msg->message, reply->message, sizeof error_reply);
+	complete((struct completion *) msg->private);
+}
+
+static atomic_t zcrypt_step = ATOMIC_INIT(0);
+
+/**
+ * The request distributor calls this function if it picked the PCIXCC/CEX2C
+ * device to handle a modexpo request.
+ * @zdev: pointer to zcrypt_device structure that identifies the
+ *	  PCIXCC/CEX2C device to the request distributor
+ * @mex: pointer to the modexpo request buffer
+ */
+static long zcrypt_pcixcc_modexpo(struct zcrypt_device *zdev,
+				  struct ica_rsa_modexpo *mex)
+{
+	struct ap_message ap_msg;
+	struct completion work;
+	int rc;
+
+	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!ap_msg.message)
+		return -ENOMEM;
+	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
+				atomic_inc_return(&zcrypt_step);
+	ap_msg.private = &work;
+	rc = ICAMEX_msg_to_type6MEX_msgX(zdev, &ap_msg, mex);
+	if (rc)
+		goto out_free;
+	init_completion(&work);
+	ap_queue_message(zdev->ap_dev, &ap_msg);
+	rc = wait_for_completion_interruptible_timeout(
+				&work, PCIXCC_CLEANUP_TIME);
+	if (rc > 0)
+		rc = convert_response_ica(zdev, &ap_msg, mex->outputdata,
+					  mex->outputdatalength);
+	else {
+		/* Signal pending or message timed out. */
+		ap_cancel_message(zdev->ap_dev, &ap_msg);
+		if (rc == 0)
+			/* Message timed out. */
+			rc = -ETIME;
+	}
+out_free:
+	free_page((unsigned long) ap_msg.message);
+	return rc;
+}
+
+/**
+ * The request distributor calls this function if it picked the PCIXCC/CEX2C
+ * device to handle a modexpo_crt request.
+ * @zdev: pointer to zcrypt_device structure that identifies the
+ *	  PCIXCC/CEX2C device to the request distributor
+ * @crt: pointer to the modexpoc_crt request buffer
+ */
+static long zcrypt_pcixcc_modexpo_crt(struct zcrypt_device *zdev,
+				      struct ica_rsa_modexpo_crt *crt)
+{
+	struct ap_message ap_msg;
+	struct completion work;
+	int rc;
+
+	ap_msg.message = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!ap_msg.message)
+		return -ENOMEM;
+	ap_msg.psmid = (((unsigned long long) current->pid) << 32) +
+				atomic_inc_return(&zcrypt_step);
+	ap_msg.private = &work;
+	rc = ICACRT_msg_to_type6CRT_msgX(zdev, &ap_msg, crt);
+	if (rc)
+		goto out_free;
+	init_completion(&work);
+	ap_queue_message(zdev->ap_dev, &ap_msg);
+	rc = wait_for_completion_interruptible_timeout(
+				&work, PCIXCC_CLEANUP_TIME);
+	if (rc > 0)
+		rc = convert_response_ica(zdev, &ap_msg, crt->outputdata,
+					  crt->outputdatalength);
+	else {
+		/* Signal pending or message timed out. */
+		ap_cancel_message(zdev->ap_dev, &ap_msg);
+		if (rc == 0)
+			/* Message timed out. */
+			rc = -ETIME;
+	}
+out_free:
+	free_page((unsigned long) ap_msg.message);
+	return rc;
+}
+
+/**
+ * The crypto operations for a PCIXCC/CEX2C card.
+ */
+static struct zcrypt_ops zcrypt_pcixcc_ops = {
+	.rsa_modexpo = zcrypt_pcixcc_modexpo,
+	.rsa_modexpo_crt = zcrypt_pcixcc_modexpo_crt,
+};
+
+/**
+ * Micro-code detection function. Its sends a message to a pcixcc card
+ * to find out the microcode level.
+ * @ap_dev: pointer to the AP device.
+ */
+static int zcrypt_pcixcc_mcl(struct ap_device *ap_dev)
+{
+	static unsigned char msg[] = {
+		0x00,0x06,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x58,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x43,0x41,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x50,0x4B,0x00,0x00,
+		0x00,0x00,0x01,0xC4,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x07,0x24,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0xDC,0x02,0x00,0x00,0x00,0x54,0x32,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xE8,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x07,0x24,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+		0x00,0x00,0x00,0x00,0x50,0x4B,0x00,0x0A,
+		0x4D,0x52,0x50,0x20,0x20,0x20,0x20,0x20,
+		0x00,0x42,0x00,0x01,0x02,0x03,0x04,0x05,
+		0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,
+		0x0E,0x0F,0x00,0x11,0x22,0x33,0x44,0x55,
+		0x66,0x77,0x88,0x99,0xAA,0xBB,0xCC,0xDD,
+		0xEE,0xFF,0xFF,0xEE,0xDD,0xCC,0xBB,0xAA,
+		0x99,0x88,0x77,0x66,0x55,0x44,0x33,0x22,
+		0x11,0x00,0x01,0x23,0x45,0x67,0x89,0xAB,
+		0xCD,0xEF,0xFE,0xDC,0xBA,0x98,0x76,0x54,
+		0x32,0x10,0x00,0x9A,0x00,0x98,0x00,0x00,
+		0x1E,0x00,0x00,0x94,0x00,0x00,0x00,0x00,
+		0x04,0x00,0x00,0x8C,0x00,0x00,0x00,0x40,
+		0x02,0x00,0x00,0x40,0xBA,0xE8,0x23,0x3C,
+		0x75,0xF3,0x91,0x61,0xD6,0x73,0x39,0xCF,
+		0x7B,0x6D,0x8E,0x61,0x97,0x63,0x9E,0xD9,
+		0x60,0x55,0xD6,0xC7,0xEF,0xF8,0x1E,0x63,
+		0x95,0x17,0xCC,0x28,0x45,0x60,0x11,0xC5,
+		0xC4,0x4E,0x66,0xC6,0xE6,0xC3,0xDE,0x8A,
+		0x19,0x30,0xCF,0x0E,0xD7,0xAA,0xDB,0x01,
+		0xD8,0x00,0xBB,0x8F,0x39,0x9F,0x64,0x28,
+		0xF5,0x7A,0x77,0x49,0xCC,0x6B,0xA3,0x91,
+		0x97,0x70,0xE7,0x60,0x1E,0x39,0xE1,0xE5,
+		0x33,0xE1,0x15,0x63,0x69,0x08,0x80,0x4C,
+		0x67,0xC4,0x41,0x8F,0x48,0xDF,0x26,0x98,
+		0xF1,0xD5,0x8D,0x88,0xD9,0x6A,0xA4,0x96,
+		0xC5,0x84,0xD9,0x30,0x49,0x67,0x7D,0x19,
+		0xB1,0xB3,0x45,0x4D,0xB2,0x53,0x9A,0x47,
+		0x3C,0x7C,0x55,0xBF,0xCC,0x85,0x00,0x36,
+		0xF1,0x3D,0x93,0x53
+	};
+	unsigned long long psmid;
+	struct CPRBX *cprbx;
+	char *reply;
+	int rc, i;
+
+	reply = (void *) get_zeroed_page(GFP_KERNEL);
+	if (!reply)
+		return -ENOMEM;
+
+	rc = ap_send(ap_dev->qid, 0x0102030405060708ULL, msg, sizeof(msg));
+	if (rc)
+		goto out_free;
+
+	/* Wait for the test message to complete. */
+	for (i = 0; i < 6; i++) {
+		mdelay(300);
+		rc = ap_recv(ap_dev->qid, &psmid, reply, 4096);
+		if (rc == 0 && psmid == 0x0102030405060708ULL)
+			break;
+	}
+
+	if (i >= 6) {
+		/* Got no answer. */
+		rc = -ENODEV;
+		goto out_free;
+	}
+
+	cprbx = (struct CPRBX *) (reply + 48);
+	if (cprbx->ccp_rtcode == 8 && cprbx->ccp_rscode == 33)
+		rc = ZCRYPT_PCIXCC_MCL2;
+	else
+		rc = ZCRYPT_PCIXCC_MCL3;
+out_free:
+	free_page((unsigned long) reply);
+	return rc;
+}
+
+/**
+ * Probe function for PCIXCC/CEX2C cards. It always accepts the AP device
+ * since the bus_match already checked the hardware type. The PCIXCC
+ * cards come in two flavours: micro code level 2 and micro code level 3.
+ * This is checked by sending a test message to the device.
+ * @ap_dev: pointer to the AP device.
+ */
+static int zcrypt_pcixcc_probe(struct ap_device *ap_dev)
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
+	zdev->ops = &zcrypt_pcixcc_ops;
+	zdev->online = 1;
+	if (ap_dev->device_type == AP_DEVICE_TYPE_PCIXCC) {
+		rc = zcrypt_pcixcc_mcl(ap_dev);
+		if (rc < 0) {
+			kfree(zdev);
+			return rc;
+		}
+		zdev->user_space_type = rc;
+		if (rc == ZCRYPT_PCIXCC_MCL2) {
+			zdev->type_string = "PCIXCC_MCL2";
+			zdev->speed_rating = PCIXCC_MCL2_SPEED_RATING;
+			zdev->min_mod_size = PCIXCC_MIN_MOD_SIZE_OLD;
+			zdev->max_mod_size = PCIXCC_MAX_MOD_SIZE;
+		} else {
+			zdev->type_string = "PCIXCC_MCL3";
+			zdev->speed_rating = PCIXCC_MCL3_SPEED_RATING;
+			zdev->min_mod_size = PCIXCC_MIN_MOD_SIZE;
+			zdev->max_mod_size = PCIXCC_MAX_MOD_SIZE;
+		}
+	} else {
+		zdev->user_space_type = ZCRYPT_CEX2C;
+		zdev->type_string = "CEX2C";
+		zdev->speed_rating = CEX2C_SPEED_RATING;
+		zdev->min_mod_size = PCIXCC_MIN_MOD_SIZE;
+		zdev->max_mod_size = PCIXCC_MAX_MOD_SIZE;
+	}
+	zdev->reply.message = kmalloc(PCIXCC_MAX_RESPONSE_SIZE, GFP_KERNEL);
+	if (!zdev->reply.message) {
+		rc = -ENOMEM;
+		goto out_free;
+	}
+	zdev->reply.length = PCIXCC_MAX_RESPONSE_SIZE;
+	ap_dev->reply = &zdev->reply;
+	ap_dev->private = zdev;
+	rc = zcrypt_device_register(zdev);
+	if (rc)
+		goto out_free;
+	return 0;
+
+ out_free:
+	ap_dev->private = NULL;
+	kfree(zdev);
+	return rc;
+}
+
+/**
+ * This is called to remove the extended PCIXCC/CEX2C driver information
+ * if an AP device is removed.
+ */
+static void zcrypt_pcixcc_remove(struct ap_device *ap_dev)
+{
+	struct zcrypt_device *zdev = ap_dev->private;
+
+	zcrypt_device_unregister(zdev);
+}
+
+/**
+ * This is called to release the extended PCIXCC/CEX2C driver information
+ * if an AP device is released.
+ */
+static void zcrypt_pcixcc_release(struct ap_device *ap_dev)
+{
+	struct zcrypt_device *zdev = ap_dev->private;
+
+	kfree(zdev);
+}
+
+int __init zcrypt_pcixcc_init(void)
+{
+	return ap_driver_register(&zcrypt_pcixcc_driver, THIS_MODULE, "pcixcc");
+}
+
+void __exit zcrypt_pcixcc_exit(void)
+{
+	ap_driver_unregister(&zcrypt_pcixcc_driver);
+}
+
+#ifndef CONFIG_ZCRYPT_MONOLITHIC
+module_init(zcrypt_pcixcc_init);
+module_exit(zcrypt_pcixcc_exit);
+#endif
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_pcixcc.h linux-2.6-patched/drivers/s390/crypto/zcrypt_pcixcc.h
--- linux-2.6/drivers/s390/crypto/zcrypt_pcixcc.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_pcixcc.h	2006-07-04 18:31:38.000000000 +0200
@@ -0,0 +1,79 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_pcixcc.h
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
+#ifndef _ZCRYPT_PCIXCC_H_
+#define _ZCRYPT_PCIXCC_H_
+
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
+struct CPRBX {
+	unsigned short cprb_len;	/* CPRB length	      220	 */
+	unsigned char  cprb_ver_id;	/* CPRB version id.   0x02	 */
+	unsigned char  pad_000[3];	/* Alignment pad bytes		 */
+	unsigned char  func_id[2];	/* function id	      0x5432	 */
+	unsigned char  cprb_flags[4];	/* Flags			 */
+	unsigned int   req_parml;	/* request parameter buffer len	 */
+	unsigned int   req_datal;	/* request data buffer		 */
+	unsigned int   rpl_msgbl;	/* reply  message block length	 */
+	unsigned int   rpld_parml;	/* replied parameter block len	 */
+	unsigned int   rpl_datal;	/* reply data block len		 */
+	unsigned int   rpld_datal;	/* replied data block len	 */
+	unsigned int   req_extbl;	/* request extension block len	 */
+	unsigned char  pad_001[4];	/* reserved			 */
+	unsigned int   rpld_extbl;	/* replied extension block len	 */
+	unsigned char  req_parmb[16];	/* request parm block 'address'	 */
+	unsigned char  req_datab[16];	/* request data block 'address'	 */
+	unsigned char  rpl_parmb[16];	/* reply parm block 'address'	 */
+	unsigned char  rpl_datab[16];	/* reply data block 'address'	 */
+	unsigned char  req_extb[16];	/* request extension block 'addr'*/
+	unsigned char  rpl_extb[16];	/* reply extension block 'addres'*/
+	unsigned short ccp_rtcode;	/* server return code		 */
+	unsigned short ccp_rscode;	/* server reason code		 */
+	unsigned int   mac_data_len;	/* Mac Data Length		 */
+	unsigned char  logon_id[8];	/* Logon Identifier		 */
+	unsigned char  mac_value[8];	/* Mac Value			 */
+	unsigned char  mac_content_flgs;/* Mac content flag byte	 */
+	unsigned char  pad_002;		/* Alignment			 */
+	unsigned short domain;		/* Domain			 */
+	unsigned char  pad_003[12];	/* Domain masks			 */
+	unsigned char  pad_004[36];	/* reserved			 */
+} __attribute__((packed));
+
+int zcrypt_pcixcc_init(void);
+void zcrypt_pcixcc_exit(void);
+
+#endif /* _ZCRYPT_PCIXCC_H_ */
