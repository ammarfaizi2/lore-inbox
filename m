Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270054AbUJHSMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270054AbUJHSMQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270089AbUJHSMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:12:14 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:49330 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S270058AbUJHRlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:41:20 -0400
Date: Fri, 8 Oct 2004 19:41:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (11/12): crypto device driver.
Message-ID: <20041008174104.GC7705@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: crypto device driver.

From: Eric Rossman <edrossma@us.ibm.com>

crypto driver changes:
 - Add support for zero-pad and crypto express II (CEX2C).

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/crypto/z90common.h   |   69 +++-
 drivers/s390/crypto/z90crypt.h    |   73 ++--
 drivers/s390/crypto/z90hardware.c |  285 ++++++++++------
 drivers/s390/crypto/z90main.c     |  653 +++++++++++++++++++++++++++-----------
 4 files changed, 756 insertions(+), 324 deletions(-)

diff -urN linux-2.6/drivers/s390/crypto/z90common.h linux-2.6-patched/drivers/s390/crypto/z90common.h
--- linux-2.6/drivers/s390/crypto/z90common.h	2004-08-14 12:56:23.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90common.h	2004-10-08 19:19:18.000000000 +0200
@@ -1,11 +1,11 @@
 /*
  *  linux/drivers/s390/misc/z90common.h
  *
- *  z90crypt 1.3.1
+ *  z90crypt 1.3.2
  *
  *  Copyright (C)  2001, 2004 IBM Corporation
  *  Author(s): Robert Burroughs (burrough@us.ibm.com)
- *	       Eric Rossman (edrossma@us.ibm.com)
+ *             Eric Rossman (edrossma@us.ibm.com)
  *
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
  *
@@ -16,7 +16,7 @@
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
@@ -27,12 +27,13 @@
 #ifndef _Z90COMMON_
 #define _Z90COMMON_
 
-#define VERSION_Z90COMMON_H "$Revision: 1.8 $"
+#define VERSION_Z90COMMON_H "$Revision: 1.15 $"
 
 
 #define RESPBUFFSIZE 256
 #define PCI_FUNC_KEY_DECRYPT 0x5044
 #define PCI_FUNC_KEY_ENCRYPT 0x504B
+extern int ext_bitlens;
 
 enum devstat {
 	DEV_GONE,
@@ -56,6 +57,7 @@
 	HD_TSQ_EXCEPTION
 };
 
+#define Z90C_NO_DEVICES		1
 #define Z90C_AMBIGUOUS_DOMAIN	2
 #define Z90C_INCORRECT_DOMAIN	3
 #define ENOTINIT		4
@@ -74,13 +76,13 @@
 #define REC_OPERAND_SIZE 9
 #define REC_EVEN_MOD	10
 #define REC_NO_WORK	11
-#define REC_HARDWAR_ERR 12
-#define REC_NO_RESPONSE 13
+#define REC_HARDWAR_ERR	12
+#define REC_NO_RESPONSE	13
 #define REC_RETRY_DEV	14
 #define REC_USER_GONE	15
-#define REC_BAD_MESSAGE 16
-#define REC_INVALID_PAD 17
-#define REC_RELEASED	28
+#define REC_BAD_MESSAGE	16
+#define REC_INVALID_PAD	17
+#define REC_USE_PCICA	18
 
 #define WRONG_DEVICE_TYPE 20
 
@@ -89,18 +91,55 @@
 #define TSQ_FATAL_ERROR 34
 #define RSQ_FATAL_ERROR 35
 
-#define PCICA	0
-#define PCICC	1
-#define PCIXCC	2
-#define NILDEV	-1
-#define ANYDEV	-1
+#define Z90CRYPT_NUM_TYPES	5
+#define PCICA		0
+#define PCICC		1
+#define PCIXCC_MCL2	2
+#define PCIXCC_MCL3	3
+#define CEX2C		4
+#define NILDEV		-1
+#define ANYDEV		-1
+#define PCIXCC_UNK	-2
 
 enum hdevice_type {
 	PCICC_HW  = 3,
 	PCICA_HW  = 4,
 	PCIXCC_HW = 5,
 	OTHER_HW  = 6,
-	OTHER2_HW = 7
+	CEX2C_HW  = 7
+};
+
+struct CPRBX {
+	unsigned short cprb_len;
+	unsigned char  cprb_ver_id;
+	unsigned char  pad_000[3];
+	unsigned char  func_id[2];
+	unsigned char  cprb_flags[4];
+	unsigned int   req_parml;
+	unsigned int   req_datal;
+	unsigned int   rpl_msgbl;
+	unsigned int   rpld_parml;
+	unsigned int   rpl_datal;
+	unsigned int   rpld_datal;
+	unsigned int   req_extbl;
+	unsigned char  pad_001[4];
+	unsigned int   rpld_extbl;
+	unsigned char  req_parmb[16];
+	unsigned char  req_datab[16];
+	unsigned char  rpl_parmb[16];
+	unsigned char  rpl_datab[16];
+	unsigned char  req_extb[16];
+	unsigned char  rpl_extb[16];
+	unsigned short ccp_rtcode;
+	unsigned short ccp_rscode;
+	unsigned int   mac_data_len;
+	unsigned char  logon_id[8];
+	unsigned char  mac_value[8];
+	unsigned char  mac_content_flgs;
+	unsigned char  pad_002;
+	unsigned short domain;
+	unsigned char  pad_003[12];
+	unsigned char  pad_004[36];
 };
 
 #ifndef DEV_NAME
diff -urN linux-2.6/drivers/s390/crypto/z90crypt.h linux-2.6-patched/drivers/s390/crypto/z90crypt.h
--- linux-2.6/drivers/s390/crypto/z90crypt.h	2004-08-14 12:55:09.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90crypt.h	2004-10-08 19:19:18.000000000 +0200
@@ -1,11 +1,11 @@
 /*
  *  linux/drivers/s390/misc/z90crypt.h
  *
- *  z90crypt 1.3.1
+ *  z90crypt 1.3.2
  *
  *  Copyright (C)  2001, 2004 IBM Corporation
  *  Author(s): Robert Burroughs (burrough@us.ibm.com)
- *	       Eric Rossman (edrossma@us.ibm.com)
+ *             Eric Rossman (edrossma@us.ibm.com)
  *
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
  *
@@ -16,7 +16,7 @@
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
@@ -29,11 +29,20 @@
 
 #include <linux/ioctl.h>
 
-#define VERSION_Z90CRYPT_H "$Revision: 1.2 $"
+#define VERSION_Z90CRYPT_H "$Revision: 1.10 $"
 
 #define z90crypt_VERSION 1
 #define z90crypt_RELEASE 3	// 2 = PCIXCC, 3 = rewrite for coding standards
-#define z90crypt_VARIANT 1
+#define z90crypt_VARIANT 2	// 2 = added PCIXCC MCL3 and CEX2C support
+
+/**
+ * If we are not using the sparse checker, __user has no use.
+ */
+#ifdef __CHECKER__
+# define __user		__attribute__((noderef, address_space(1)))
+#else
+# define __user
+#endif
 
 /**
  * struct ica_rsa_modexpo
@@ -93,16 +102,16 @@
  *     This takes an ica_rsa_modexpo struct as its arg.
  *
  *     NOTE: please refer to the comments preceding this structure
- *	     for the implementation details for the contents of the
- *	     block
+ *           for the implementation details for the contents of the
+ *           block
  *
  *   ICARSACRT
  *     Perform an RSA operation using a Chinese-Remainder Theorem key
  *     This takes an ica_rsa_modexpo_crt struct as its arg.
  *
  *     NOTE: please refer to the comments preceding this structure
- *	     for the implementation details for the contents of the
- *	     block
+ *           for the implementation details for the contents of the
+ *           block
  *
  *   Z90STAT_TOTALCOUNT
  *     Return an integer count of all device types together.
@@ -113,8 +122,14 @@
  *   Z90STAT_PCICCCOUNT
  *     Return an integer count of all PCICCs.
  *
- *   Z90STAT_PCIXCCCOUNT
- *     Return an integer count of all PCIXCCs.
+ *   Z90STAT_PCIXCCMCL2COUNT
+ *     Return an integer count of all MCL2 PCIXCCs.
+ *
+ *   Z90STAT_PCIXCCMCL3COUNT
+ *     Return an integer count of all MCL3 PCIXCCs.
+ *
+ *   Z90STAT_CEX2CCOUNT
+ *     Return an integer count of all CEX2Cs.
  *
  *   Z90STAT_REQUESTQ_COUNT
  *     Return an integer count of the number of entries waiting to be
@@ -133,10 +148,12 @@
  *   Z90STAT_STATUS_MASK
  *     Return an 64 element array of unsigned chars for the status of
  *     all devices.
- *	 0x01: PCICA
- *	 0x02: PCICC
- *	 0x03: PCIXCC
- *	 0x0d: device is disabled via the proc filesystem
+ *       0x01: PCICA
+ *       0x02: PCICC
+ *       0x03: PCIXCC_MCL2
+ *       0x04: PCIXCC_MCL3
+ *       0x05: CEX2C
+ *       0x0d: device is disabled via the proc filesystem
  *
  *   Z90STAT_QDEPTH_MASK
  *     Return an 64 element array of unsigned chars for the queue
@@ -152,18 +169,23 @@
  *     This takes an ica_z90_status struct as its arg.
  *
  *     NOTE: this ioctl() is deprecated, and has been replaced with
- *	     single ioctl()s for each type of status being requested
+ *           single ioctl()s for each type of status being requested
+ *
+ *   Z90STAT_PCIXCCCOUNT (deprecated)
+ *     Return an integer count of all PCIXCCs (MCL2 + MCL3).
+ *     This is DEPRECATED now that MCL3 PCIXCCs are treated differently from
+ *     MCL2 PCIXCCs.
  *
  *   Z90QUIESCE (not recommended)
  *     Quiesce the driver.  This is intended to stop all new
- *     requests from being processed.  Its use is not recommended,
+ *     requests from being processed.  Its use is NOT recommended,
  *     except in circumstances where there is no other way to stop
  *     callers from accessing the driver.  Its original use was to
  *     allow the driver to be "drained" of work in preparation for
  *     a system shutdown.
  *
  *     NOTE: once issued, this ban on new work cannot be undone
- *	     except by unloading and reloading the driver.
+ *           except by unloading and reloading the driver.
  */
 
 /**
@@ -172,8 +194,9 @@
 #define ICARSAMODEXPO	_IOC(_IOC_READ|_IOC_WRITE, Z90_IOCTL_MAGIC, 0x05, 0)
 #define ICARSACRT	_IOC(_IOC_READ|_IOC_WRITE, Z90_IOCTL_MAGIC, 0x06, 0)
 
-/* DEPRECATED status call (bound for removal SOON) */
+/* DEPRECATED status calls (bound for removal at some point) */
 #define ICAZ90STATUS	_IOR(Z90_IOCTL_MAGIC, 0x10, struct ica_z90_status)
+#define Z90STAT_PCIXCCCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x43, int)
 
 /* unrelated to ICA callers */
 #define Z90QUIESCE	_IO(Z90_IOCTL_MAGIC, 0x11)
@@ -182,7 +205,9 @@
 #define Z90STAT_TOTALCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x40, int)
 #define Z90STAT_PCICACOUNT	_IOR(Z90_IOCTL_MAGIC, 0x41, int)
 #define Z90STAT_PCICCCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x42, int)
-#define Z90STAT_PCIXCCCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x43, int)
+#define Z90STAT_PCIXCCMCL2COUNT	_IOR(Z90_IOCTL_MAGIC, 0x4b, int)
+#define Z90STAT_PCIXCCMCL3COUNT	_IOR(Z90_IOCTL_MAGIC, 0x4c, int)
+#define Z90STAT_CEX2CCOUNT	_IOR(Z90_IOCTL_MAGIC, 0x4d, int)
 #define Z90STAT_REQUESTQ_COUNT	_IOR(Z90_IOCTL_MAGIC, 0x44, int)
 #define Z90STAT_PENDINGQ_COUNT	_IOR(Z90_IOCTL_MAGIC, 0x45, int)
 #define Z90STAT_TOTALOPEN_COUNT _IOR(Z90_IOCTL_MAGIC, 0x46, int)
@@ -199,8 +224,9 @@
 #define ERELEASED 131	// user released while ioctl pending
 #define EQUIESCE  132	// z90crypt quiescing (no more work allowed)
 #define ETIMEOUT  133	// request timed out
-#define EUNKNOWN  134	// some unrecognized error occured
-#define EGETBUFF  135	// Error getting buffer
+#define EUNKNOWN  134	// some unrecognized error occured (retry may succeed)
+#define EGETBUFF  135	// Error getting buffer or hardware lacks capability
+			// (retry in software)
 
 /**
  * DEPRECATED STRUCTURES
@@ -222,7 +248,8 @@
 	int pendingqWaitCount;
 	int totalOpenCount;
 	int cryptoDomain;
-	// status: 0=not there. 1=PCICA. 2=PCICC. 3=PCIXCC
+	// status: 0=not there, 1=PCICA, 2=PCICC, 3=PCIXCC_MCL2, 4=PCIXCC_MCL3,
+	//         5=CEX2C
 	unsigned char status[MASK_LENGTH];
 	// qdepth: # work elements waiting for each device
 	unsigned char qdepth[MASK_LENGTH];
diff -urN linux-2.6/drivers/s390/crypto/z90hardware.c linux-2.6-patched/drivers/s390/crypto/z90hardware.c
--- linux-2.6/drivers/s390/crypto/z90hardware.c	2004-08-14 12:54:48.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90hardware.c	2004-10-08 19:19:18.000000000 +0200
@@ -1,11 +1,11 @@
 /*
  *  linux/drivers/s390/misc/z90hardware.c
  *
- *  z90crypt 1.3.1
+ *  z90crypt 1.3.2
  *
  *  Copyright (C)  2001, 2004 IBM Corporation
  *  Author(s): Robert Burroughs (burrough@us.ibm.com)
- *	       Eric Rossman (edrossma@us.ibm.com)
+ *             Eric Rossman (edrossma@us.ibm.com)
  *
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
  *
@@ -16,7 +16,7 @@
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
@@ -32,7 +32,7 @@
 #include "z90crypt.h"
 #include "z90common.h"
 
-#define VERSION_Z90HARDWARE_C "$Revision: 1.19 $"
+#define VERSION_Z90HARDWARE_C "$Revision: 1.32 $"
 
 char z90chardware_version[] __initdata =
 	"z90hardware.o (" VERSION_Z90HARDWARE_C "/"
@@ -224,7 +224,7 @@
 	unsigned char right[4];
 	unsigned char reserved3[2];
 	unsigned char reserved4[2];
-	unsigned char pfs[4];
+	unsigned char apfs[4];
 	unsigned int  offset1;
 	unsigned int  offset2;
 	unsigned int  offset3;
@@ -278,39 +278,6 @@
 	unsigned char svr_name[8];
 };
 
-struct CPRBX {
-	unsigned short cprb_len;
-	unsigned char  cprb_ver_id;
-	unsigned char  pad_000[3];
-	unsigned char  func_id[2];
-	unsigned char  cprb_flags[4];
-	unsigned int   req_parml;
-	unsigned int   req_datal;
-	unsigned int   rpl_msgbl;
-	unsigned int   rpld_parml;
-	unsigned int   rpl_datal;
-	unsigned int   rpld_datal;
-	unsigned int   req_extbl;
-	unsigned char  pad_001[4];
-	unsigned int   rpld_extbl;
-	unsigned char  req_parmb[16];
-	unsigned char  req_datab[16];
-	unsigned char  rpl_parmb[16];
-	unsigned char  rpl_datab[16];
-	unsigned char  req_extb[16];
-	unsigned char  rpl_extb[16];
-	unsigned short ccp_rtcode;
-	unsigned short ccp_rscode;
-	unsigned int   mac_data_len;
-	unsigned char  logon_id[8];
-	unsigned char  mac_value[8];
-	unsigned char  mac_content_flgs;
-	unsigned char  pad_002;
-	unsigned short domain;
-	unsigned char  pad_003[12];
-	unsigned char  pad_004[36];
-};
-
 struct type6_msg {
 	struct type6_hdr header;
 	struct CPRB	 CPRB;
@@ -347,12 +314,13 @@
 #define REPLY_ERROR_FORMAT_FIELD     0x29
 #define REPLY_ERROR_INVALID_COMMAND  0x30
 #define REPLY_ERROR_MALFORMED_MSG    0x40
-#define REPLY_ERROR_RESERVED_FIELD   0x50
+#define REPLY_ERROR_RESERVED_FIELDO  0x50
 #define REPLY_ERROR_WORD_ALIGNMENT   0x60
 #define REPLY_ERROR_MESSAGE_LENGTH   0x80
 #define REPLY_ERROR_OPERAND_INVALID  0x82
 #define REPLY_ERROR_OPERAND_SIZE     0x84
 #define REPLY_ERROR_EVEN_MOD_IN_OPND 0x85
+#define REPLY_ERROR_RESERVED_FIELD   0x88
 #define REPLY_ERROR_TRANSPORT_FAIL   0x90
 #define REPLY_ERROR_PACKET_TRUNCATED 0xA0
 #define REPLY_ERROR_ZERO_BUFFER_LEN  0xB0
@@ -379,7 +347,7 @@
 	unsigned int	  offset2;
 	unsigned int	  count3;
 	unsigned int	  offset3;
-	unsigned int	  ount4;
+	unsigned int	  count4;
 	unsigned int	  offset4;
 };
 
@@ -546,18 +514,30 @@
 	 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00}
 };
 
-static struct function_and_rules_block static_pkd_function_and_rulesX = {
+static struct function_and_rules_block static_pkd_function_and_rulesX_MCL2 = {
 	{0x50,0x44},
 	{0x00,0x0A},
 	{'P','K','C','S','-','1','.','2'}
 };
 
-static struct function_and_rules_block static_pke_function_and_rulesX = {
+static struct function_and_rules_block static_pke_function_and_rulesX_MCL2 = {
 	{0x50,0x4B},
 	{0x00,0x0A},
 	{'Z','E','R','O','-','P','A','D'}
 };
 
+static struct function_and_rules_block static_pkd_function_and_rulesX = {
+	{0x50,0x44},
+	{0x00,0x0A},
+	{'Z','E','R','O','-','P','A','D'}
+};
+
+static struct function_and_rules_block static_pke_function_and_rulesX = {
+	{0x50,0x4B},
+	{0x00,0x0A},
+	{'M','R','P',' ',' ',' ',' ',' '}
+};
+
 struct T6_keyBlock_hdrX {
 	unsigned short blen;
 	unsigned short ulen;
@@ -701,11 +681,9 @@
 
 #define FIXED_TYPE6_CR_LENX 0x000001E3
 
-#ifndef MAX_RESPONSE_SIZE
 #define MAX_RESPONSE_SIZE 0x00000710
 
 #define MAX_RESPONSEX_SIZE 0x0000077C
-#endif
 
 #define RESPONSE_CPRB_SIZE  0x000006B8
 #define RESPONSE_CPRBX_SIZE 0x00000724
@@ -1063,7 +1041,6 @@
 			*q_depth = t_depth + 1;
 			switch (t_dev_type) {
 			case OTHER_HW:
-			case OTHER2_HW:
 				stat = HD_NOT_THERE;
 				*dev_type = NILDEV;
 				break;
@@ -1074,7 +1051,10 @@
 				*dev_type = PCICC;
 				break;
 			case PCIXCC_HW:
-				*dev_type = PCIXCC;
+				*dev_type = PCIXCC_UNK;
+				break;
+			case CEX2C_HW:
+				*dev_type = CEX2C;
 				break;
 			default:
 				*dev_type = NILDEV;
@@ -1133,6 +1113,7 @@
 		default:
 			stat = HD_NOT_THERE;
 			break_out = 1;
+			break;
 		}
 		if (break_out)
 			break;
@@ -1170,18 +1151,11 @@
 			switch (stat_word.response_code) {
 			case AP_RESPONSE_NORMAL:
 				stat = DEV_ONLINE;
-				if (stat_word.q_stat_flags &
-				    AP_Q_STATUS_EMPTY)
+				if (stat_word.q_stat_flags & AP_Q_STATUS_EMPTY)
 					break_out = 1;
 				break;
 			case AP_RESPONSE_Q_NOT_AVAIL:
-				stat = DEV_GONE;
-				break_out = 1;
-				break;
 			case AP_RESPONSE_DECONFIGURED:
-				stat = DEV_GONE;
-				break_out = 1;
-				break;
 			case AP_RESPONSE_CHECKSTOPPED:
 				stat = DEV_GONE;
 				break_out = 1;
@@ -1195,6 +1169,7 @@
 		default:
 			stat = DEV_GONE;
 			break_out = 1;
+			break;
 		}
 		if (break_out == 1)
 			break;
@@ -1251,7 +1226,7 @@
 	       msg_ext[0], msg_ext[1], msg_ext[2], msg_ext[3],
 	       msg_ext[4], msg_ext[5], msg_ext[6], msg_ext[7],
 	       msg_ext[8], msg_ext[9], msg_ext[10], msg_ext[11]);
-	print_buffer(msg_ext+12, msg_len);
+	print_buffer(msg_ext+CALLER_HEADER, msg_len);
 #endif
 
 	ccode = sen(msg_len, msg_ext, &stat_word);
@@ -1283,14 +1258,15 @@
 		break;
 	default:
 		stat = DEV_GONE;
+		break;
 	}
 
 	return stat;
 }
 
 enum devstat
-receive_from_AP(int dev_nr, int cdx, int resplen,
-		unsigned char *resp, unsigned char *psmid)
+receive_from_AP(int dev_nr, int cdx, int resplen, unsigned char *resp,
+		unsigned char *psmid)
 {
 	int ccode;
 	struct ap_status_word stat_word;
@@ -1543,6 +1519,7 @@
 	struct type6_hdr *tp6Hdr_p;
 	struct CPRB *cprb_p;
 	struct cca_private_ext_ME *key_p;
+	static int deprecated_msg_count = 0;
 
 	mod_len = icaMsg_p->inputdatalength;
 	tmp_size = FIXED_TYPE6_ME_LEN + mod_len;
@@ -1593,13 +1570,19 @@
 		return SEN_USER_ERROR;
 
 	if (is_common_public_key(temp, mod_len)) {
-		PRINTK("Common public key used for modex decrypt\n");
+		if (deprecated_msg_count < 20) {
+			PRINTK("Common public key used for modex decrypt\n");
+			deprecated_msg_count++;
+			if (deprecated_msg_count == 20)
+				PRINTK("No longer issuing messages about common"
+				       " public key for modex decrypt.\n");
+		}
 		return SEN_NOT_AVAIL;
 	}
 
 	temp = key_p->pvtMESec.modulus + sizeof(key_p->pvtMESec.modulus)
 	       - mod_len;
-	if (copy_from_user(temp, icaMsg_p->n_modulus, mod_len) != 0)
+	if (copy_from_user(temp, icaMsg_p->n_modulus, mod_len))
 		return SEN_RELEASED;
 	if (is_empty(temp, mod_len))
 		return SEN_USER_ERROR;
@@ -1617,24 +1600,33 @@
 {
 	int mod_len, vud_len, exp_len, key_len;
 	int pad_len, tmp_size, total_CPRB_len, parmBlock_l, i;
-	unsigned char temp_exp[256], *exp_p, *temp;
+	unsigned char *temp_exp, *exp_p, *temp;
 	struct type6_hdr *tp6Hdr_p;
 	struct CPRB *cprb_p;
 	struct cca_public_key *key_p;
 	struct T6_keyBlock_hdr *keyb_p;
 
+	temp_exp = kmalloc(256, GFP_KERNEL);
+	if (!temp_exp)
+		return EGETBUFF;
 	mod_len = icaMsg_p->inputdatalength;
-	if (copy_from_user(temp_exp, icaMsg_p->b_key, mod_len))
+	if (copy_from_user(temp_exp, icaMsg_p->b_key, mod_len)) {
+		kfree(temp_exp);
 		return SEN_RELEASED;
-	if (is_empty(temp_exp, mod_len))
+	}
+	if (is_empty(temp_exp, mod_len)) {
+		kfree(temp_exp);
 		return SEN_USER_ERROR;
+	}
 
 	exp_p = temp_exp;
 	for (i = 0; i < mod_len; i++)
 		if (exp_p[i])
 			break;
-	if (i >= mod_len)
+	if (i >= mod_len) {
+		kfree(temp_exp);
 		return SEN_USER_ERROR;
+	}
 
 	exp_len = mod_len - i;
 	exp_p += i;
@@ -1665,17 +1657,25 @@
 		 sizeof(struct function_and_rules_block));
 	temp += sizeof(struct function_and_rules_block);
 	temp += 2;
-	if (copy_from_user(temp, icaMsg_p->inputdata, mod_len))
+	if (copy_from_user(temp, icaMsg_p->inputdata, mod_len)) {
+		kfree(temp_exp);
 		return SEN_RELEASED;
-	if (is_empty(temp, mod_len))
+	}
+	if (is_empty(temp, mod_len)) {
+		kfree(temp_exp);
 		return SEN_USER_ERROR;
-	if (temp[0] != 0x00 || temp[1] != 0x02)
+	}
+	if ((temp[0] != 0x00) || (temp[1] != 0x02)) {
+		kfree(temp_exp);
 		return SEN_NOT_AVAIL;
+	}
 	for (i = 2; i < mod_len; i++)
 		if (temp[i] == 0x00)
 			break;
-	if ((i < 9) || (i > (mod_len - 2)))
+	if ((i < 9) || (i > (mod_len - 2))) {
+		kfree(temp_exp);
 		return SEN_NOT_AVAIL;
+	}
 	pad_len = i + 1;
 	vud_len = mod_len - pad_len;
 	memmove(temp, temp+pad_len, vud_len);
@@ -1689,6 +1689,7 @@
 	key_p = (struct cca_public_key *)temp;
 	temp = key_p->pubSec.exponent;
 	memcpy(temp, exp_p, exp_len);
+	kfree(temp_exp);
 	temp += exp_len;
 	if (copy_from_user(temp, icaMsg_p->n_modulus, mod_len))
 		return SEN_RELEASED;
@@ -1697,7 +1698,7 @@
 	key_p->pubSec.modulus_bit_len = 8 * mod_len;
 	key_p->pubSec.modulus_byte_len = mod_len;
 	key_p->pubSec.exponent_len = exp_len;
-	key_p->pubSec.section_length = 12 + mod_len + exp_len;
+	key_p->pubSec.section_length = CALLER_HEADER + mod_len + exp_len;
 	key_len = key_p->pubSec.section_length + sizeof(struct cca_token_hdr);
 	key_p->pubHdr.token_length = key_len;
 	key_len += 4;
@@ -1824,27 +1825,37 @@
 
 static int
 ICAMEX_msg_to_type6MEX_msgX(struct ica_rsa_modexpo *icaMsg_p, int cdx,
-			    int *z90cMsg_l_p, struct type6_msg *z90cMsg_p)
+			    int *z90cMsg_l_p, struct type6_msg *z90cMsg_p,
+			    int dev_type)
 {
 	int mod_len, exp_len, vud_len, tmp_size, total_CPRB_len, parmBlock_l;
 	int key_len, i;
-	unsigned char temp_exp[256], *tgt_p, *temp, *exp_p;
+	unsigned char *temp_exp, *tgt_p, *temp, *exp_p;
 	struct type6_hdr *tp6Hdr_p;
 	struct CPRBX *cprbx_p;
 	struct cca_public_key *key_p;
 	struct T6_keyBlock_hdrX *keyb_p;
 
+	temp_exp = kmalloc(256, GFP_KERNEL);
+	if (!temp_exp)
+		return EGETBUFF;
 	mod_len = icaMsg_p->inputdatalength;
-	if (copy_from_user(temp_exp, icaMsg_p->b_key, mod_len))
+	if (copy_from_user(temp_exp, icaMsg_p->b_key, mod_len)) {
+		kfree(temp_exp);
 		return SEN_RELEASED;
-	if (is_empty(temp_exp, mod_len))
+	}
+	if (is_empty(temp_exp, mod_len)) {
+		kfree(temp_exp);
 		return SEN_USER_ERROR;
+	}
 	exp_p = temp_exp;
 	for (i = 0; i < mod_len; i++)
 		if (exp_p[i])
 			break;
-	if (i >= mod_len)
+	if (i >= mod_len) {
+		kfree(temp_exp);
 		return SEN_USER_ERROR;
+	}
 	exp_len = mod_len - i;
 	exp_p += i;
 	PDEBUG("exp_len after computation: %08x\n", exp_len);
@@ -1867,15 +1878,23 @@
 	cprbx_p->domain = (unsigned short)cdx;
 	cprbx_p->rpl_msgbl = RESPONSE_CPRBX_SIZE;
 	tgt_p += sizeof(struct CPRBX);
-	memcpy(tgt_p, &static_pke_function_and_rulesX,
-	       sizeof(struct function_and_rules_block));
+	if (dev_type == PCIXCC_MCL2)
+		memcpy(tgt_p, &static_pke_function_and_rulesX_MCL2,
+		       sizeof(struct function_and_rules_block));
+	else
+		memcpy(tgt_p, &static_pke_function_and_rulesX,
+		       sizeof(struct function_and_rules_block));
 	tgt_p += sizeof(struct function_and_rules_block);
 
 	tgt_p += 2;
-	if (copy_from_user(tgt_p, icaMsg_p->inputdata, mod_len))
-	      return SEN_RELEASED;
-	if (is_empty(tgt_p, mod_len))
-	      return SEN_USER_ERROR;
+	if (copy_from_user(tgt_p, icaMsg_p->inputdata, mod_len)) {
+		kfree(temp_exp);
+		return SEN_RELEASED;
+	}
+	if (is_empty(tgt_p, mod_len)) {
+		kfree(temp_exp);
+		return SEN_USER_ERROR;
+	}
 	tgt_p -= 2;
 	*((short *)tgt_p) = (short) vud_len;
 	tgt_p += vud_len;
@@ -1885,15 +1904,16 @@
 	key_p = (struct cca_public_key *)tgt_p;
 	temp = key_p->pubSec.exponent;
 	memcpy(temp, exp_p, exp_len);
+	kfree(temp_exp);
 	temp += exp_len;
 	if (copy_from_user(temp, icaMsg_p->n_modulus, mod_len))
-	      return SEN_RELEASED;
+		return SEN_RELEASED;
 	if (is_empty(temp, mod_len))
-	      return SEN_USER_ERROR;
+		return SEN_USER_ERROR;
 	key_p->pubSec.modulus_bit_len = 8 * mod_len;
 	key_p->pubSec.modulus_byte_len = mod_len;
 	key_p->pubSec.exponent_len = exp_len;
-	key_p->pubSec.section_length = 12 + mod_len + exp_len;
+	key_p->pubSec.section_length = CALLER_HEADER + mod_len + exp_len;
 	key_len = key_p->pubSec.section_length + sizeof(struct cca_token_hdr);
 	key_p->pubHdr.token_length = key_len;
 	key_len += 4;
@@ -1908,7 +1928,8 @@
 
 static int
 ICACRT_msg_to_type6CRT_msgX(struct ica_rsa_modexpo_crt *icaMsg_p, int cdx,
-			    int *z90cMsg_l_p, struct type6_msg *z90cMsg_p)
+			    int *z90cMsg_l_p, struct type6_msg *z90cMsg_p,
+			    int dev_type)
 {
 	int mod_len, vud_len, tmp_size, total_CPRB_len, parmBlock_l, short_len;
 	int long_len, pad_len, keyPartsLen, tmp_l;
@@ -1943,8 +1964,12 @@
 	cprbx_p->req_parml = parmBlock_l;
 	cprbx_p->rpl_msgbl = parmBlock_l;
 	tgt_p += sizeof(struct CPRBX);
-	memcpy(tgt_p, &static_pkd_function_and_rulesX,
-	       sizeof(struct function_and_rules_block));
+	if (dev_type == PCIXCC_MCL2)
+		memcpy(tgt_p, &static_pkd_function_and_rulesX_MCL2,
+		       sizeof(struct function_and_rules_block));
+	else
+		memcpy(tgt_p, &static_pkd_function_and_rulesX,
+		       sizeof(struct function_and_rules_block));
 	tgt_p += sizeof(struct function_and_rules_block);
 	*((short *)tgt_p) = (short) vud_len;
 	tgt_p += 2;
@@ -2043,20 +2068,37 @@
 				(struct ica_rsa_modexpo *) buffer,
 				cdx, msg_l_p, (struct type6_msg *) msg_p);
 	}
-	if (dev_type == PCIXCC) {
+	if ((dev_type == PCIXCC_MCL2) ||
+	    (dev_type == PCIXCC_MCL3) ||
+	    (dev_type == CEX2C)) {
 		if (func == ICARSACRT)
 			return ICACRT_msg_to_type6CRT_msgX(
 				(struct ica_rsa_modexpo_crt *) buffer,
-				cdx, msg_l_p, (struct type6_msg *) msg_p);
+				cdx, msg_l_p, (struct type6_msg *) msg_p,
+				dev_type);
 		else
 			return ICAMEX_msg_to_type6MEX_msgX(
 				(struct ica_rsa_modexpo *) buffer,
-				cdx, msg_l_p, (struct type6_msg *) msg_p);
+				cdx, msg_l_p, (struct type6_msg *) msg_p,
+				dev_type);
 	}
 
 	return 0;
 }
 
+int ext_bitlens_msg_count = 0;
+static inline void
+unset_ext_bitlens(void)
+{
+	if (!ext_bitlens_msg_count) {
+		PRINTK("Unable to use coprocessors for extended bitlengths. "
+		       "Using PCICAs (if present) for extended bitlengths. "
+		       "This is not an error.\n");
+		ext_bitlens_msg_count++;
+	}
+	ext_bitlens = 0;
+}
+
 int
 convert_response(unsigned char *response, unsigned char *buffer,
 		 int *respbufflen_p, unsigned char *resp_buff)
@@ -2064,8 +2106,8 @@
 	struct ica_rsa_modexpo *icaMsg_p = (struct ica_rsa_modexpo *) buffer;
 	struct type82_hdr *t82h_p = (struct type82_hdr *) response;
 	struct type84_hdr *t84h_p = (struct type84_hdr *) response;
-	struct type86_hdr *t86h_p = (struct type86_hdr *) response;
-	int rv, reply_code, service_rc, service_rs, src_l;
+	struct type86_fmt2_msg *t86m_p =  (struct type86_fmt2_msg *) response;
+	int reply_code, service_rc, service_rs, src_l;
 	unsigned char *src_p, *tgt_p;
 	struct CPRB *cprb_p;
 	struct CPRBX *cprbx_p;
@@ -2075,11 +2117,9 @@
 	service_rc = 0;
 	service_rs = 0;
 	src_l = 0;
-	rv = 0;
 	switch (t82h_p->type) {
 	case TYPE82_RSP_CODE:
 		reply_code = t82h_p->reply_code;
-		rv = 4;
 		src_p = (unsigned char *)t82h_p;
 		PRINTK("Hardware error: Type 82 Message Header: "
 		       "%02x%02x%02x%02x%02x%02x%02x%02x\n",
@@ -2091,15 +2131,9 @@
 		src_p = response + (int)t84h_p->len - src_l;
 		break;
 	case TYPE86_RSP_CODE:
-		reply_code = t86h_p->reply_code;
-		if (t86h_p->format != TYPE86_FMT2) {
-			rv = 4;
-			break;
-		}
-		if (reply_code != 0) {
-			rv = 4;
+		reply_code = t86m_p->hdr.reply_code;
+		if (reply_code != 0)
 			break;
-		}
 		cprb_p = (struct CPRB *)
 			(response + sizeof(struct type86_fmt2_msg));
 		cprbx_p = (struct CPRBX *) cprb_p;
@@ -2108,11 +2142,22 @@
 			if (service_rc != 0) {
 				le2toI(cprb_p->ccp_rscode, &service_rs);
 				if ((service_rc == 8) && (service_rs == 66))
-					PDEBUG("8/66 on PCICC\n");
+					PDEBUG("Bad block format on PCICC\n");
+				else if ((service_rc == 8) && (service_rs == 770)) {
+					PDEBUG("Invalid key length on PCICC\n");
+					unset_ext_bitlens();
+					return REC_USE_PCICA;
+				}
+				else if ((service_rc == 8) && (service_rs == 783)) {
+					PDEBUG("Extended bitlengths not enabled"
+					       "on PCICC\n");
+					unset_ext_bitlens();
+					return REC_USE_PCICA;
+				}
 				else
 					PRINTK("service rc/rs: %d/%d\n",
 					       service_rc, service_rs);
-				rv = 8;
+				return REC_OPERAND_INV;
 			}
 			src_p = (unsigned char *)cprb_p + sizeof(struct CPRB);
 			src_p += 4;
@@ -2124,11 +2169,22 @@
 			if (service_rc != 0) {
 				service_rs = (int) cprbx_p->ccp_rscode;
 				if ((service_rc == 8) && (service_rs == 66))
-					PDEBUG("8/66 on PCIXCC\n");
+					PDEBUG("Bad block format on PCXICC\n");
+				else if ((service_rc == 8) && (service_rs == 770)) {
+					PDEBUG("Invalid key length on PCIXCC\n");
+					unset_ext_bitlens();
+					return REC_USE_PCICA;
+				}
+				else if ((service_rc == 8) && (service_rs == 783)) {
+					PDEBUG("Extended bitlengths not enabled"
+					       "on PCIXCC\n");
+					unset_ext_bitlens();
+					return REC_USE_PCICA;
+				}
 				else
 					PRINTK("service rc/rs: %d/%d\n",
 					       service_rc, service_rs);
-				rv = 8;
+				return REC_OPERAND_INV;
 			}
 			src_p = (unsigned char *)
 				cprbx_p + sizeof(struct CPRBX);
@@ -2139,12 +2195,10 @@
 		}
 		break;
 	default:
-		break;
+		return REC_BAD_MESSAGE;
 	}
 
-	if (rv == 8)
-		return 8;
-	if (rv == 4)
+	if (reply_code)
 		switch (reply_code) {
 		case REPLY_ERROR_OPERAND_INVALID:
 			return REC_OPERAND_INV;
@@ -2154,8 +2208,14 @@
 			return REC_EVEN_MOD;
 		case REPLY_ERROR_MESSAGE_TYPE:
 			return WRONG_DEVICE_TYPE;
+		case REPLY_ERROR_TRANSPORT_FAIL:
+			PRINTKW("Transport failed (APFS = %02X%02X%02X%02X)\n",
+				t86m_p->apfs[0], t86m_p->apfs[1],
+				t86m_p->apfs[2], t86m_p->apfs[3]);
+			return REC_HARDWAR_ERR;
 		default:
-			return 12;
+			PRINTKW("reply code = %d\n", reply_code);
+			return REC_HARDWAR_ERR;
 		}
 
 	if (service_rc != 0)
@@ -2171,14 +2231,13 @@
 	memcpy(tgt_p, src_p, src_l);
 	if ((t82h_p->type == TYPE86_RSP_CODE) && (resp_buff < tgt_p)) {
 		memset(resp_buff, 0, icaMsg_p->outputdatalength - src_l);
-		rv = pad_msg(resp_buff, icaMsg_p->outputdatalength, src_l);
-		if (rv != 0)
-			return rv;
+		if (pad_msg(resp_buff, icaMsg_p->outputdatalength, src_l))
+			return REC_INVALID_PAD;
 	}
 	*respbufflen_p = icaMsg_p->outputdatalength;
 	if (*respbufflen_p == 0)
 		PRINTK("Zero *respbufflen_p\n");
 
-	return rv;
+	return 0;
 }
 
diff -urN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2004-08-14 12:54:47.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2004-10-08 19:19:18.000000000 +0200
@@ -1,11 +1,11 @@
 /*
  *  linux/drivers/s390/misc/z90main.c
  *
- *  z90crypt 1.3.1
+ *  z90crypt 1.3.2
  *
  *  Copyright (C)  2001, 2004 IBM Corporation
  *  Author(s): Robert Burroughs (burrough@us.ibm.com)
- *	       Eric Rossman (edrossma@us.ibm.com)
+ *             Eric Rossman (edrossma@us.ibm.com)
  *
  *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
  *
@@ -16,7 +16,7 @@
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
@@ -50,7 +50,7 @@
 #  error "This kernel is too recent: not supported by this file"
 #endif
 
-#define VERSION_Z90MAIN_C "$Revision: 1.31 $"
+#define VERSION_Z90MAIN_C "$Revision: 1.54 $"
 
 static char z90cmain_version[] __initdata =
 	"z90main.o (" VERSION_Z90MAIN_C "/"
@@ -116,9 +116,15 @@
 
 /**
  * Reader should run every READERTIME milliseconds
+ * With the 100Hz patch for s390, z90crypt can lock the system solid while
+ * under heavy load. We'll try to avoid that.
  */
 #ifndef READERTIME
+#if HZ > 1000
 #define READERTIME 2
+#else
+#define READERTIME 10
+#endif
 #endif
 
 /**
@@ -209,18 +215,13 @@
 #ifndef Z90CRYPT_NUM_DEVS
 #define Z90CRYPT_NUM_DEVS Z90CRYPT_NUM_APS
 #endif
-#ifndef Z90CRYPT_NUM_TYPES
-#define Z90CRYPT_NUM_TYPES 3
-#endif
 
 /**
  * Buffer size for receiving responses. The maximum Response Size
  * is actually the maximum request size, since in an error condition
  * the request itself may be returned unchanged.
  */
-#ifndef MAX_RESPONSE_SIZE
 #define MAX_RESPONSE_SIZE 0x0000077C
-#endif
 
 /**
  * A count and status-byte mask
@@ -246,7 +247,8 @@
  * All devices are arranged in a single array: 64 APs
  */
 struct device {
-	int		 dev_type;	    // PCICA, PCICC, or PCIXCC
+	int		 dev_type;	    // PCICA, PCICC, PCIXCC_MCL2,
+					    // PCIXCC_MCL3, CEX2C
 	enum devstat	 dev_stat;	    // current device status
 	int		 dev_self_x;	    // Index in array
 	int		 disabled;	    // Set when device is in error
@@ -328,6 +330,7 @@
 static void destroy_z90crypt(void);
 static int refresh_index_array(struct status *, struct device_x *);
 static int probe_device_type(struct device *);
+static int probe_PCIXCC_type(struct device *);
 
 /**
  * proc fs definitions
@@ -449,9 +452,9 @@
 /**
  * Documentation values.
  */
-MODULE_AUTHOR("zLinux Crypto Team: Robert H. Burroughs, Eric D. Rossman"
+MODULE_AUTHOR("zSeries Linux Crypto Team: Robert H. Burroughs, Eric D. Rossman"
 	      "and Jochen Roehrig");
-MODULE_DESCRIPTION("zLinux Cryptographic Coprocessor device driver, "
+MODULE_DESCRIPTION("zSeries Linux Cryptographic Coprocessor device driver, "
 		   "Copyright 2001, 2004 IBM Corporation");
 MODULE_LICENSE("GPL");
 module_param(domain, int, 0);
@@ -554,7 +557,8 @@
 
 static int compatible_ioctls[] = {
 	ICAZ90STATUS, Z90QUIESCE, Z90STAT_TOTALCOUNT, Z90STAT_PCICACOUNT,
-	Z90STAT_PCICCCOUNT, Z90STAT_PCIXCCCOUNT, Z90STAT_REQUESTQ_COUNT,
+	Z90STAT_PCICCCOUNT, Z90STAT_PCIXCCCOUNT, Z90STAT_PCIXCCMCL2COUNT,
+	Z90STAT_PCIXCCMCL3COUNT, Z90STAT_CEX2CCOUNT, Z90STAT_REQUESTQ_COUNT,
 	Z90STAT_PENDINGQ_COUNT, Z90STAT_TOTALOPEN_COUNT, Z90STAT_DOMAIN_INDEX,
 	Z90STAT_STATUS_MASK, Z90STAT_QDEPTH_MASK, Z90STAT_PERDEV_REQCNT,
 };
@@ -575,20 +579,33 @@
 	int result, i;
 
 	result = register_ioctl32_conversion(ICARSAMODEXPO, trans_modexpo32);
+	if (result == -EBUSY) {
+		unregister_ioctl32_conversion(ICARSAMODEXPO);
+		result = register_ioctl32_conversion(ICARSAMODEXPO,
+						     trans_modexpo32);
+	}
 	if (result)
 		return result;
 	result = register_ioctl32_conversion(ICARSACRT, trans_modexpo_crt32);
+	if (result == -EBUSY) {
+		unregister_ioctl32_conversion(ICARSACRT);
+		result = register_ioctl32_conversion(ICARSACRT,
+						     trans_modexpo_crt32);
+	}
 	if (result)
 		return result;
 
 	for(i = 0; i < ARRAY_SIZE(compatible_ioctls); i++) {
-		result = register_ioctl32_conversion(compatible_ioctls[i],NULL);
-		if (result) {
-			z90_unregister_ioctl32s();
-			return result;
+		result = register_ioctl32_conversion(compatible_ioctls[i], 0);
+		if (result == -EBUSY) {
+			unregister_ioctl32_conversion(compatible_ioctls[i]);
+			result = register_ioctl32_conversion(
+						       compatible_ioctls[i], 0);
 		}
+		if (result)
+			return result;
 	}
-	return result;
+	return 0;
 }
 #else // !CONFIG_COMPAT
 static inline void z90_unregister_ioctl32s(void)
@@ -612,10 +629,15 @@
 
 	PDEBUG("PID %d\n", PID());
 
+	if ((domain < -1) || (domain > 15)) {
+		PRINTKW("Invalid param: domain = %d.  Not loading.\n", domain);
+		return -EINVAL;
+	}
+
 #ifndef Z90CRYPT_USE_HOTPLUG
 	/* Register as misc device with given minor (or get a dynamic one). */
 	result = misc_register(&z90crypt_misc_device);
-	if (result <0) {
+	if (result < 0) {
 		PRINTKW(KERN_ERR "misc_register (minor %d) failed with %d\n",
 			z90crypt_misc_device.minor, result);
 		return result;
@@ -923,7 +945,26 @@
 static inline int
 get_status_PCIXCCcount(void)
 {
-	return z90crypt.hdware_info->type_mask[PCIXCC].st_count;
+	return z90crypt.hdware_info->type_mask[PCIXCC_MCL2].st_count +
+	       z90crypt.hdware_info->type_mask[PCIXCC_MCL3].st_count;
+}
+
+static inline int
+get_status_PCIXCCMCL2count(void)
+{
+	return z90crypt.hdware_info->type_mask[PCIXCC_MCL2].st_count;
+}
+
+static inline int
+get_status_PCIXCCMCL3count(void)
+{
+	return z90crypt.hdware_info->type_mask[PCIXCC_MCL3].st_count;
+}
+
+static inline int
+get_status_CEX2Ccount(void)
+{
+	return z90crypt.hdware_info->type_mask[CEX2C].st_count;
 }
 
 static inline int
@@ -1016,8 +1057,8 @@
 	we_p->audit[2] = 0x00;
 	we_p->resp_buff_size = 0;
 	we_p->retcode = 0;
-	we_p->devindex = -1; // send_to_crypto selects the device
-	we_p->devtype = -1;  // getCryptoBuffer selects the type
+	we_p->devindex = -1;
+	we_p->devtype = -1;
 	atomic_set(&we_p->alarmrung, 0);
 	init_waitqueue_head(&we_p->waitq);
 	INIT_LIST_HEAD(&(we_p->liste));
@@ -1040,42 +1081,113 @@
 static inline void
 remove_device(struct device *device_p)
 {
-	if (!device_p || device_p->disabled != 0)
+	if (!device_p || (device_p->disabled != 0))
 		return;
 	device_p->disabled = 1;
 	z90crypt.hdware_info->type_mask[device_p->dev_type].disabled_count++;
 	z90crypt.hdware_info->hdware_mask.disabled_count++;
 }
 
+/**
+ * Bitlength limits for each card
+ *
+ * There are new MCLs which allow more bitlengths. See the table for details.
+ * The MCL must be applied and the newer bitlengths enabled for these to work.
+ *
+ * Card Type    Old limit    New limit
+ * PCICC         512-1024     512-2048
+ * PCIXCC_MCL2   512-2048     no change (applying this MCL == card is MCL3+)
+ * PCIXCC_MCL3   512-2048     128-2048
+ * CEX2C         512-2048     128-2048
+ *
+ * ext_bitlens (extended bitlengths) is a global, since you should not apply an
+ * MCL to just one card in a machine. We assume, at first, that all cards have
+ * these capabilities.
+ */
+int ext_bitlens = 1; // This is global
+#define PCIXCC_MIN_MOD_SIZE	 16	//  128 bits
+#define OLD_PCIXCC_MIN_MOD_SIZE	 64	//  512 bits
+#define PCICC_MIN_MOD_SIZE	 64	//  512 bits
+#define OLD_PCICC_MAX_MOD_SIZE	128	// 1024 bits
+#define MAX_MOD_SIZE		256	// 2048 bits
+
 static inline int
-select_device_type(int *dev_type_p)
+select_device_type(int *dev_type_p, int bytelength)
 {
+	static int count = 0;
+	int PCICA_avail, PCIXCC_MCL3_avail, CEX2C_avail, index_to_use;
 	struct status *stat;
 	if ((*dev_type_p != PCICC) && (*dev_type_p != PCICA) &&
-	    (*dev_type_p != PCIXCC) && (*dev_type_p != ANYDEV))
+	    (*dev_type_p != PCIXCC_MCL2) && (*dev_type_p != PCIXCC_MCL3) &&
+	    (*dev_type_p != CEX2C) && (*dev_type_p != ANYDEV))
 		return -1;
 	if (*dev_type_p != ANYDEV) {
 		stat = &z90crypt.hdware_info->type_mask[*dev_type_p];
 		if (stat->st_count >
-		    stat->disabled_count + stat->user_disabled_count)
+		    (stat->disabled_count + stat->user_disabled_count))
 			return 0;
 		return -1;
 	}
 
+	/* Assumption: PCICA, PCIXCC_MCL3, and CEX2C are all similar in speed */
 	stat = &z90crypt.hdware_info->type_mask[PCICA];
-	if (stat->st_count > stat->disabled_count + stat->user_disabled_count) {
-		*dev_type_p = PCICA;
+	PCICA_avail = stat->st_count -
+			(stat->disabled_count + stat->user_disabled_count);
+	stat = &z90crypt.hdware_info->type_mask[PCIXCC_MCL3];
+	PCIXCC_MCL3_avail = stat->st_count -
+			(stat->disabled_count + stat->user_disabled_count);
+	stat = &z90crypt.hdware_info->type_mask[CEX2C];
+	CEX2C_avail = stat->st_count -
+			(stat->disabled_count + stat->user_disabled_count);
+	if (PCICA_avail || PCIXCC_MCL3_avail || CEX2C_avail) {
+		/**
+		 * bitlength is a factor, PCICA is the most capable, even with
+		 * the new MCL.
+		 */
+		if ((bytelength < PCIXCC_MIN_MOD_SIZE) ||
+		    (!ext_bitlens && (bytelength < OLD_PCIXCC_MIN_MOD_SIZE))) {
+			if (!PCICA_avail)
+				return -1;
+			else {
+				*dev_type_p = PCICA;
+				return 0;
+			}
+		}
+
+		index_to_use = count % (PCICA_avail + PCIXCC_MCL3_avail +
+					CEX2C_avail);
+		if (index_to_use < PCICA_avail)
+			*dev_type_p = PCICA;
+		else if (index_to_use < (PCICA_avail + PCIXCC_MCL3_avail))
+			*dev_type_p = PCIXCC_MCL3;
+		else
+			*dev_type_p = CEX2C;
+		count++;
 		return 0;
 	}
 
-	stat = &z90crypt.hdware_info->type_mask[PCIXCC];
-	if (stat->st_count > stat->disabled_count + stat->user_disabled_count) {
-		*dev_type_p = PCIXCC;
+	/* Less than OLD_PCIXCC_MIN_MOD_SIZE cannot go to a PCIXCC_MCL2 */
+	if (bytelength < OLD_PCIXCC_MIN_MOD_SIZE)
+		return -1;
+	stat = &z90crypt.hdware_info->type_mask[PCIXCC_MCL2];
+	if (stat->st_count >
+	    (stat->disabled_count + stat->user_disabled_count)) {
+		*dev_type_p = PCIXCC_MCL2;
 		return 0;
 	}
 
+	/**
+	 * Less than PCICC_MIN_MOD_SIZE or more than OLD_PCICC_MAX_MOD_SIZE
+	 * (if we don't have the MCL applied and the newer bitlengths enabled)
+	 * cannot go to a PCICC
+	 */
+	if ((bytelength < PCICC_MIN_MOD_SIZE) ||
+	    (!ext_bitlens && (bytelength > OLD_PCICC_MAX_MOD_SIZE))) {
+		return -1;
+	}
 	stat = &z90crypt.hdware_info->type_mask[PCICC];
-	if (stat->st_count > stat->disabled_count + stat->user_disabled_count) {
+	if (stat->st_count >
+	    (stat->disabled_count + stat->user_disabled_count)) {
 		*dev_type_p = PCICC;
 		return 0;
 	}
@@ -1087,7 +1199,7 @@
  * Try the selected number, then the selected type (can be ANYDEV)
  */
 static inline int
-select_device(int *dev_type_p, int *device_nr_p)
+select_device(int *dev_type_p, int *device_nr_p, int bytelength)
 {
 	int i, indx, devTp, low_count, low_indx;
 	struct device_x *index_p;
@@ -1099,9 +1211,9 @@
 		dev_ptr = z90crypt.device_p[*device_nr_p];
 
 		if (dev_ptr &&
-		    dev_ptr->dev_stat != DEV_GONE &&
-		    dev_ptr->disabled == 0 &&
-		    dev_ptr->user_disabled == 0) {
+		    (dev_ptr->dev_stat != DEV_GONE) &&
+		    (dev_ptr->disabled == 0) &&
+		    (dev_ptr->user_disabled == 0)) {
 			PDEBUG("selected by number, index = %d\n",
 			       *device_nr_p);
 			*dev_type_p = dev_ptr->dev_type;
@@ -1111,7 +1223,7 @@
 	*device_nr_p = -1;
 	PDEBUG("trying type = %d\n", *dev_type_p);
 	devTp = *dev_type_p;
-	if (select_device_type(&devTp) == -1) {
+	if (select_device_type(&devTp, bytelength) == -1) {
 		PDEBUG("failed to select by type\n");
 		return -1;
 	}
@@ -1123,11 +1235,11 @@
 		indx = index_p->device_index[i];
 		dev_ptr = z90crypt.device_p[indx];
 		if (dev_ptr &&
-		    dev_ptr->dev_stat != DEV_GONE &&
-		    dev_ptr->disabled == 0 &&
-		    dev_ptr->user_disabled == 0 &&
-		    devTp == dev_ptr->dev_type &&
-		    low_count > dev_ptr->dev_caller_count) {
+		    (dev_ptr->dev_stat != DEV_GONE) &&
+		    (dev_ptr->disabled == 0) &&
+		    (dev_ptr->user_disabled == 0) &&
+		    (devTp == dev_ptr->dev_type) &&
+		    (low_count > dev_ptr->dev_caller_count)) {
 			low_count = dev_ptr->dev_caller_count;
 			low_indx = indx;
 		}
@@ -1142,12 +1254,13 @@
 	struct caller *caller_p;
 	struct device *device_p;
 	int dev_nr;
+	int bytelen = ((struct ica_rsa_modexpo *)we_p->buffer)->inputdatalength;
 
 	if (!we_p->requestptr)
 		return SEN_FATAL_ERROR;
 	caller_p = (struct caller *)we_p->requestptr;
 	dev_nr = we_p->devindex;
-	if (select_device(&we_p->devtype, &dev_nr) == -1) {
+	if (select_device(&we_p->devtype, &dev_nr, bytelen) == -1) {
 		if (z90crypt.hdware_info->hdware_mask.st_count != 0)
 			return SEN_RETRY;
 		else
@@ -1297,15 +1410,6 @@
 {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 
 /**
- * MIN_MOD_SIZE is a PCICC and PCIXCC limit.
- * MAX_PCICC_MOD_SIZE is a hard limit for the PCICC.
- * MAX_MOD_SIZE is a hard limit for the PCIXCC and PCICA.
- */
-#define MIN_MOD_SIZE 64
-#define MAX_PCICC_MOD_SIZE 128
-#define MAX_MOD_SIZE 256
-
-/**
  * Used in device configuration functions
  */
 #define MAX_RESET 90
@@ -1361,7 +1465,8 @@
 	struct caller *caller_p = (struct caller *)we_p->requestptr;
 
 	if ((we_p->devtype != PCICC) && (we_p->devtype != PCICA) &&
-	    (we_p->devtype != PCIXCC))
+	    (we_p->devtype != PCIXCC_MCL2) && (we_p->devtype != PCIXCC_MCL3) &&
+	    (we_p->devtype != CEX2C))
 		return SEN_NOT_AVAIL;
 
 	memcpy(caller_p->caller_id, we_p->caller_id,
@@ -1393,9 +1498,8 @@
 		return;
 	if (caller_p->caller_liste.next && caller_p->caller_liste.prev)
 		if (!list_empty(&caller_p->caller_liste)) {
-			list_del(&caller_p->caller_liste);
+			list_del_init(&caller_p->caller_liste);
 			device_p->dev_caller_count--;
-			INIT_LIST_HEAD(&caller_p->caller_liste);
 		}
 	memset(caller_p->caller_id, 0, sizeof(caller_p->caller_id));
 }
@@ -1430,7 +1534,8 @@
 	}
 
 	if ((we_p->devtype != PCICA) && (we_p->devtype != PCICC) &&
-	    (we_p->devtype != PCIXCC) && (we_p->devtype != ANYDEV)) {
+	    (we_p->devtype != PCIXCC_MCL2) && (we_p->devtype != PCIXCC_MCL3) &&
+	    (we_p->devtype != CEX2C) && (we_p->devtype != ANYDEV)) {
 		PRINTK("invalid device type\n");
 		return SEN_USER_ERROR;
 	}
@@ -1494,7 +1599,7 @@
 	if (rv != 0)
 		return rv;
 
-	if (select_device_type(&we_p->devtype) < 0)
+	if (select_device_type(&we_p->devtype, mex_p->inputdatalength) < 0)
 		return SEN_NOT_AVAIL;
 
 	temp_buffer = (unsigned char *)we_p + sizeof(struct work_element) +
@@ -1510,13 +1615,19 @@
 		function = PCI_FUNC_KEY_ENCRYPT;
 		break;
 	/**
-	 * PCIXCC does all Mod-Expo form with a simple RSA mod-expo
+	 * PCIXCC_MCL2 does all Mod-Expo form with a simple RSA mod-expo
 	 * operation, and all CRT forms with a PKCS-1.2 format decrypt.
+	 * PCIXCC_MCL3 and CEX2C do all Mod-Expo and CRT forms with a simple RSA
+	 * mod-expo operation
 	 */
-	case PCIXCC:
-		/* Anything less than MIN_MOD_SIZE MUST go to a PCICA */
-		if (mex_p->inputdatalength < MIN_MOD_SIZE)
-			return SEN_NOT_AVAIL;
+	case PCIXCC_MCL2:
+		if (we_p->funccode == ICARSAMODEXPO)
+			function = PCI_FUNC_KEY_ENCRYPT;
+		else
+			function = PCI_FUNC_KEY_DECRYPT;
+		break;
+	case PCIXCC_MCL3:
+	case CEX2C:
 		if (we_p->funccode == ICARSAMODEXPO)
 			function = PCI_FUNC_KEY_ENCRYPT;
 		else
@@ -1526,14 +1637,6 @@
 	 * PCICC does everything as a PKCS-1.2 format request
 	 */
 	case PCICC:
-		/* Anything less than MIN_MOD_SIZE MUST go to a PCICA */
-		if (mex_p->inputdatalength < MIN_MOD_SIZE) {
-			return SEN_NOT_AVAIL;
-		}
-		/* Anythings over MAX_PCICC_MOD_SIZE MUST go to a PCICA */
-		if (mex_p->inputdatalength > MAX_PCICC_MOD_SIZE) {
-			return SEN_NOT_AVAIL;
-		}
 		/* PCICC cannot handle input that is is PKCS#1.1 padded */
 		if (is_PKCS11_padded(temp_buffer, mex_p->inputdatalength)) {
 			return SEN_NOT_AVAIL;
@@ -1593,6 +1696,7 @@
 		rv = -ENODEV;
 		break;
 	case SEN_NOT_AVAIL:
+	case EGETBUFF:
 		rv = -EGETBUFF;
 		break;
 	default:
@@ -1613,14 +1717,14 @@
 	spin_lock_irq(&queuespinlock);
 	list_for_each(lptr, &request_list) {
 		if (lptr == &we_p->liste) {
-			list_del(lptr);
+			list_del_init(lptr);
 			requestq_count--;
 			break;
 		}
 	}
 	list_for_each(lptr, &pending_list) {
 		if (lptr == &we_p->liste) {
-			list_del(lptr);
+			list_del_init(lptr);
 			pendingq_count--;
 			break;
 		}
@@ -1659,14 +1763,13 @@
 	if ((we_p->status[0] & STAT_FAILED)) {
 		switch (rv) {
 		/**
-		 * EINVAL *after* receive is almost always padding
-		 * error issued by a PCICC or PCIXCC. We convert this
-		 * return value to -EGETBUFF which should trigger a
-		 * fallback to software.
+		 * EINVAL *after* receive is almost always a padding error or
+		 * length error issued by a coprocessor (not an accelerator).
+		 * We convert this return value to -EGETBUFF which should
+		 * trigger a fallback to software.
 		 */
 		case -EINVAL:
-			if ((we_p->devtype == PCICC) ||
-			    (we_p->devtype == PCIXCC))
+			if (we_p->devtype != PCICA)
 				rv = -EGETBUFF;
 			break;
 		case -ETIMEOUT:
@@ -1710,7 +1813,8 @@
 	unsigned int *reqcnt;
 	struct ica_z90_status *pstat;
 	int ret, i, loopLim, tempstat;
-	static int deprecated_msg_count = 0;
+	static int deprecated_msg_count1 = 0;
+	static int deprecated_msg_count2 = 0;
 
 	PDEBUG("filp %p (PID %d), cmd 0x%08X\n", filp, PID(), cmd);
 	PDEBUG("cmd 0x%08X: dir %s, size 0x%04X, type 0x%02X, nr 0x%02X\n",
@@ -1765,8 +1869,20 @@
 			ret = -EFAULT;
 		break;
 
-	case Z90STAT_PCIXCCCOUNT:
-		tempstat = get_status_PCIXCCcount();
+	case Z90STAT_PCIXCCMCL2COUNT:
+		tempstat = get_status_PCIXCCMCL2count();
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) != 0)
+			ret = -EFAULT;
+		break;
+
+	case Z90STAT_PCIXCCMCL3COUNT:
+		tempstat = get_status_PCIXCCMCL3count();
+		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) != 0)
+			ret = -EFAULT;
+		break;
+
+	case Z90STAT_CEX2CCOUNT:
+		tempstat = get_status_CEX2Ccount();
 		if (copy_to_user((int __user *)arg, &tempstat, sizeof(int)) != 0)
 			ret = -EFAULT;
 		break;
@@ -1838,10 +1954,10 @@
 
 		/* THIS IS DEPRECATED.	USE THE NEW STATUS CALLS */
 	case ICAZ90STATUS:
-		if (deprecated_msg_count < 100) {
+		if (deprecated_msg_count1 < 20) {
 			PRINTK("deprecated call to ioctl (ICAZ90STATUS)!\n");
-			deprecated_msg_count++;
-			if (deprecated_msg_count == 100)
+			deprecated_msg_count1++;
+			if (deprecated_msg_count1 == 20)
 				PRINTK("No longer issuing messages related to "
 				       "deprecated call to ICAZ90STATUS.\n");
 		}
@@ -1869,6 +1985,21 @@
 		kfree(pstat);
 		break;
 
+		/* THIS IS DEPRECATED.	USE THE NEW STATUS CALLS */
+	case Z90STAT_PCIXCCCOUNT:
+		if (deprecated_msg_count2 < 20) {
+			PRINTK("deprecated ioctl (Z90STAT_PCIXCCCOUNT)!\n");
+			deprecated_msg_count2++;
+			if (deprecated_msg_count2 == 20)
+				PRINTK("No longer issuing messages about depre"
+				       "cated ioctl Z90STAT_PCIXCCCOUNT.\n");
+		}
+
+		tempstat = get_status_PCIXCCcount();
+		if (copy_to_user((int *)arg, &tempstat, sizeof(int)) != 0)
+			ret = -EFAULT;
+		break;
+
 	case Z90QUIESCE:
 		if (current->euid != 0) {
 			PRINTK("QUIESCE fails: euid %d\n",
@@ -1990,8 +2121,12 @@
 		get_status_PCICAcount());
 	len += sprintf(resp_buff+len, "PCICC count: %d\n",
 		get_status_PCICCcount());
-	len += sprintf(resp_buff+len, "PCIXCC count: %d\n",
-		get_status_PCIXCCcount());
+	len += sprintf(resp_buff+len, "PCIXCC MCL2 count: %d\n",
+		get_status_PCIXCCMCL2count());
+	len += sprintf(resp_buff+len, "PCIXCC MCL3 count: %d\n",
+		get_status_PCIXCCMCL3count());
+	len += sprintf(resp_buff+len, "CEX2C count: %d\n",
+		get_status_CEX2Ccount());
 	len += sprintf(resp_buff+len, "requestq count: %d\n",
 		get_status_requestq_count());
 	len += sprintf(resp_buff+len, "pendingq count: %d\n",
@@ -1999,7 +2134,8 @@
 	len += sprintf(resp_buff+len, "Total open handles: %d\n\n",
 		get_status_totalopen_count());
 	len += sprinthx(
-		"Online devices: 1 means PCICA, 2 means PCICC, 3 means PCIXCC",
+		"Online devices: 1: PCICA, 2: PCICC, 3: PCIXCC (MCL2), "
+		"4: PCIXCC (MCL3), 5: CEX2C",
 		resp_buff+len,
 		get_status_status_mask(workarea),
 		Z90CRYPT_NUM_APS);
@@ -2171,6 +2307,8 @@
 		case '1':
 		case '2':
 		case '3':
+		case '4':
+		case '5':
 			j++;
 			break;
 		case 'd':
@@ -2228,9 +2366,8 @@
 	dev_ptr = z90crypt.device_p[index];
 	rv = 0;
 	do {
-		PDEBUG("Dequeue called for device %d\n", index);
 		if (!dev_ptr || dev_ptr->disabled) {
-			rv = REC_NO_RESPONSE;
+			rv = REC_NO_WORK; // a disabled device can't return work
 			break;
 		}
 		if (dev_ptr->dev_self_x != index) {
@@ -2244,6 +2381,7 @@
 			PRINTK("dev_resp_l = %d, dev_resp_p = %p\n",
 			       dev_ptr->dev_resp_l, dev_ptr->dev_resp_p);
 		} else {
+			PDEBUG("Dequeue called for device %d\n", index);
 			dv = receive_from_AP(index, z90crypt.cdx,
 					     dev_ptr->dev_resp_l,
 					     dev_ptr->dev_resp_p, psmid);
@@ -2283,15 +2421,18 @@
 			if (!memcmp(caller_p->caller_id, psmid,
 				    sizeof(caller_p->caller_id))) {
 				if (!list_empty(&caller_p->caller_liste)) {
-					list_del(ptr);
+					list_del_init(ptr);
 					dev_ptr->dev_caller_count--;
-					INIT_LIST_HEAD(&caller_p->caller_liste);
 					break;
 				}
 			}
 			caller_p = 0;
 		}
 		if (!caller_p) {
+			PRINTKW("Unable to locate PSMID %02X%02X%02X%02X%02X"
+				"%02X%02X%02X in device list\n",
+				psmid[0], psmid[1], psmid[2], psmid[3],
+				psmid[4], psmid[5], psmid[6], psmid[7]);
 			rv = REC_USER_GONE;
 			break;
 		}
@@ -2300,22 +2441,22 @@
 		rv = convert_response(dev_ptr->dev_resp_p,
 				      caller_p->caller_buf_p, buff_len_p, buff);
 		switch (rv) {
+		case REC_USE_PCICA:
+			break;
 		case REC_OPERAND_INV:
-			PDEBUG("dev %d: user error %d\n", index, rv);
+		case REC_OPERAND_SIZE:
+		case REC_EVEN_MOD:
+		case REC_INVALID_PAD:
+			PDEBUG("device %d: 'user error' %d\n", index, rv);
 			break;
 		case WRONG_DEVICE_TYPE:
 		case REC_HARDWAR_ERR:
 		case REC_BAD_MESSAGE:
-			PRINTK("dev %d: hardware error %d\n",
-			       index, rv);
+			PRINTKW("device %d: hardware error %d\n", index, rv);
 			rv = REC_NO_RESPONSE;
 			break;
-		case REC_RELEASED:
-			PDEBUG("dev %d: REC_RELEASED = %d\n",
-			       index, rv);
-			break;
 		default:
-			PDEBUG("dev %d: rv = %d\n", index, rv);
+			PDEBUG("device %d: rv = %d\n", index, rv);
 			break;
 		}
 	} while (0);
@@ -2329,6 +2470,7 @@
 			PRINTK("Zero *buff_len_p\n");
 		break;
 	case REC_NO_RESPONSE:
+		PRINTKW("Removing device %d from availability\n", index);
 		remove_device(dev_ptr);
 		break;
 	}
@@ -2349,7 +2491,7 @@
 		return;
 	requestq_count--;
 	rq_p = list_entry(request_list.next, struct work_element, liste);
-	list_del(&rq_p->liste);
+	list_del_init(&rq_p->liste);
 	rq_p->audit[1] |= FP_REMREQUEST;
 	if (rq_p->devtype == SHRT2DEVPTR(index)->dev_type) {
 		rq_p->devindex = SHRT2LONG(index);
@@ -2408,7 +2550,7 @@
 	list_for_each_safe(lptr, tptr, &pending_list) {
 		pq_p = list_entry(lptr, struct work_element, liste);
 		if (!memcmp(pq_p->caller_id, psmid, sizeof(pq_p->caller_id))) {
-			list_del(lptr);
+			list_del_init(lptr);
 			pendingq_count--;
 			pq_p->audit[1] |= FP_NOTPENDING;
 			break;
@@ -2441,6 +2583,10 @@
 			pq_p->retcode = -EINVAL;
 			pq_p->status[0] |= STAT_FAILED;
 			break;
+		case REC_USE_PCICA:
+			pq_p->retcode = -ERESTARTSYS;
+			pq_p->status[0] |= STAT_FAILED;
+			break;
 		case REC_NO_RESPONSE:
 		default:
 			if (z90crypt.mask.st_count > 1)
@@ -2461,7 +2607,7 @@
  * return TRUE if the work element should be removed from the queue
  */
 static inline int
-helper_receive_rc(int index, int *rc_p, int *workavail_p)
+helper_receive_rc(int index, int *rc_p)
 {
 	switch (*rc_p) {
 	case 0:
@@ -2469,26 +2615,26 @@
 	case REC_OPERAND_SIZE:
 	case REC_EVEN_MOD:
 	case REC_INVALID_PAD:
-		return 1;
+	case REC_USE_PCICA:
+		break;
 
 	case REC_BUSY:
 	case REC_NO_WORK:
 	case REC_EMPTY:
 	case REC_RETRY_DEV:
 	case REC_FATAL_ERROR:
-		break;
+		return 0;
 
 	case REC_NO_RESPONSE:
-		*workavail_p = 0;
 		break;
 
 	default:
-		PRINTK("rc %d, device %d\n", *rc_p, SHRT2LONG(index));
+		PRINTK("rc %d, device %d converted to REC_NO_RESPONSE\n",
+		       *rc_p, SHRT2LONG(index));
 		*rc_p = REC_NO_RESPONSE;
-		*workavail_p = 0;
 		break;
 	}
-	return 0;
+	return 1;
 }
 
 static inline void
@@ -2503,21 +2649,18 @@
 static void
 z90crypt_reader_task(unsigned long ptr)
 {
-	int workavail, remaining, index, rc, buff_len;
+	int workavail, index, rc, buff_len;
 	unsigned char	psmid[8];
 	unsigned char __user *resp_addr;
 	static unsigned char buff[1024];
 
-	PDEBUG("jiffies %ld\n", jiffies);
-
 	/**
 	 * we use workavail = 2 to ensure 2 passes with nothing dequeued before
-	 * exiting the loop. If remaining == 0 after the loop, there is no work
-	 * remaining on the queues.
+	 * exiting the loop. If pendingq_count == 0 after the loop, there is no
+	 * work remaining on the queues.
 	 */
 	resp_addr = 0;
 	workavail = 2;
-	remaining = 0;
 	buff_len = 0;
 	while (workavail) {
 		workavail--;
@@ -2535,7 +2678,7 @@
 							&resp_addr);
 			PDEBUG("Dequeued: rc = %d.\n", rc);
 
-			if (helper_receive_rc(index, &rc, &workavail)) {
+			if (helper_receive_rc(index, &rc)) {
 				if (rc != REC_NO_RESPONSE) {
 					helper_send_work(index);
 					workavail = 2;
@@ -2547,19 +2690,14 @@
 			}
 
 			if (rc == REC_FATAL_ERROR)
-				remaining = 0;
-			else if (rc != REC_NO_RESPONSE)
-				remaining +=
-					SHRT2DEVPTR(index)->dev_caller_count;
+				PRINTKW("REC_FATAL_ERROR from device %d!\n",
+					SHRT2LONG(index));
 		}
 		spin_unlock_irq(&queuespinlock);
 	}
 
-	if (remaining) {
-		spin_lock_irq(&queuespinlock);
+	if (pendingq_count)
 		z90crypt_schedule_reader_timer();
-		spin_unlock_irq(&queuespinlock);
-	}
 }
 
 static inline void
@@ -2606,7 +2744,7 @@
 		pq_p->status[0] |= STAT_FAILED;
 		unbuild_caller(LONG2DEVPTR(pq_p->devindex),
 			       (struct caller *)pq_p->requestptr);
-		list_del(lptr);
+		list_del_init(lptr);
 		pendingq_count--;
 		pq_p->audit[1] |= FP_NOTPENDING;
 		pq_p->audit[1] |= FP_AWAKENING;
@@ -2618,7 +2756,7 @@
 		pq_p = list_entry(lptr, struct work_element, liste);
 		pq_p->retcode = -ENODEV;
 		pq_p->status[0] |= STAT_FAILED;
-		list_del(lptr);
+		list_del_init(lptr);
 		requestq_count--;
 		pq_p->audit[1] |= FP_REMREQUEST;
 		pq_p->audit[1] |= FP_AWAKENING;
@@ -2640,12 +2778,21 @@
 		pq_p = list_entry(lptr, struct work_element, liste);
 		if (pq_p->requestsent >= timelimit)
 			break;
+		PRINTKW("Purging(PQ) PSMID %02X%02X%02X%02X%02X%02X%02X%02X\n",
+		       ((struct caller *)pq_p->requestptr)->caller_id[0],
+		       ((struct caller *)pq_p->requestptr)->caller_id[1],
+		       ((struct caller *)pq_p->requestptr)->caller_id[2],
+		       ((struct caller *)pq_p->requestptr)->caller_id[3],
+		       ((struct caller *)pq_p->requestptr)->caller_id[4],
+		       ((struct caller *)pq_p->requestptr)->caller_id[5],
+		       ((struct caller *)pq_p->requestptr)->caller_id[6],
+		       ((struct caller *)pq_p->requestptr)->caller_id[7]);
 		pq_p->retcode = -ETIMEOUT;
 		pq_p->status[0] |= STAT_FAILED;
 		/* get this off any caller queue it may be on */
 		unbuild_caller(LONG2DEVPTR(pq_p->devindex),
 			       (struct caller *) pq_p->requestptr);
-		list_del(lptr);
+		list_del_init(lptr);
 		pendingq_count--;
 		pq_p->audit[1] |= FP_TIMEDOUT;
 		pq_p->audit[1] |= FP_NOTPENDING;
@@ -2663,9 +2810,18 @@
 			pq_p = list_entry(lptr, struct work_element, liste);
 			if (pq_p->requestsent >= timelimit)
 				break;
+		PRINTKW("Purging(RQ) PSMID %02X%02X%02X%02X%02X%02X%02X%02X\n",
+		       ((struct caller *)pq_p->requestptr)->caller_id[0],
+		       ((struct caller *)pq_p->requestptr)->caller_id[1],
+		       ((struct caller *)pq_p->requestptr)->caller_id[2],
+		       ((struct caller *)pq_p->requestptr)->caller_id[3],
+		       ((struct caller *)pq_p->requestptr)->caller_id[4],
+		       ((struct caller *)pq_p->requestptr)->caller_id[5],
+		       ((struct caller *)pq_p->requestptr)->caller_id[6],
+		       ((struct caller *)pq_p->requestptr)->caller_id[7]);
 			pq_p->retcode = -ETIMEOUT;
 			pq_p->status[0] |= STAT_FAILED;
-			list_del(lptr);
+			list_del_init(lptr);
 			requestq_count--;
 			pq_p->audit[1] |= FP_TIMEDOUT;
 			pq_p->audit[1] |= FP_REMREQUEST;
@@ -2737,15 +2893,15 @@
 {
 	enum hdstat hd_stat;
 	int q_depth, dev_type;
-	int i, j, k;
+	int indx, chkdom, numdomains;
 
-	q_depth = dev_type = k = 0;
-	for (i = 0; i < z90crypt.max_count; i++) {
+	q_depth = dev_type = numdomains = 0;
+	for (chkdom = 0; chkdom <= 15; cdx_array[chkdom++] = -1);
+	for (indx = 0; indx < z90crypt.max_count; indx++) {
 		hd_stat = HD_NOT_THERE;
-		for (j = 0; j <= 15; cdx_array[j++] = -1);
-		k = 0;
-		for (j = 0; j <= 15; j++) {
-			hd_stat = query_online(i, j, MAX_RESET,
+		numdomains = 0;
+		for (chkdom = 0; chkdom <= 15; chkdom++) {
+			hd_stat = query_online(indx, chkdom, MAX_RESET,
 					       &q_depth, &dev_type);
 			if (hd_stat == HD_TSQ_EXCEPTION) {
 				z90crypt.terminating = 1;
@@ -2753,29 +2909,30 @@
 				break;
 			}
 			if (hd_stat == HD_ONLINE) {
-				cdx_array[k++] = j;
-				if (*cdx_p == j) {
+				cdx_array[numdomains++] = chkdom;
+				if (*cdx_p == chkdom) {
 					*correct_cdx_found  = 1;
 					break;
 				}
 			}
 		}
-		if ((*correct_cdx_found == 1) || (k != 0))
+		if ((*correct_cdx_found == 1) || (numdomains != 0))
 			break;
 		if (z90crypt.terminating)
 			break;
 	}
-	return k;
+	return numdomains;
 }
 
 static inline int
 probe_crypto_domain(int *cdx_p)
 {
 	int cdx_array[16];
-	int correct_cdx_found, k;
+	char cdx_array_text[53], temp[5];
+	int correct_cdx_found, numdomains;
 
 	correct_cdx_found = 0;
-	k = helper_scan_devices(cdx_array, cdx_p, &correct_cdx_found);
+	numdomains = helper_scan_devices(cdx_array, cdx_p, &correct_cdx_found);
 
 	if (z90crypt.terminating)
 		return TSQ_FATAL_ERROR;
@@ -2783,23 +2940,31 @@
 	if (correct_cdx_found)
 		return 0;
 
-	if (k == 0) {
-		*cdx_p = 0;
-		return 0;
+	if (numdomains == 0) {
+		PRINTKW("Unable to find crypto domain: No devices found\n");
+		return Z90C_NO_DEVICES;
 	}
 
-	if (k == 1) {
-		if ((*cdx_p == -1) || !z90crypt.domain_established) {
+	if (numdomains == 1) {
+		if (*cdx_p == -1) {
 			*cdx_p = cdx_array[0];
 			return 0;
 		}
-		if (*cdx_p != cdx_array[0]) {
-			PRINTK("incorrect domain: specified = %d, found = %d\n",
-			       *cdx_p, cdx_array[0]);
-			return Z90C_INCORRECT_DOMAIN;
-		}
+		PRINTKW("incorrect domain: specified = %d, found = %d\n",
+		       *cdx_p, cdx_array[0]);
+		return Z90C_INCORRECT_DOMAIN;
 	}
 
+	numdomains--;
+	sprintf(cdx_array_text, "%d", cdx_array[numdomains]);
+	while (numdomains) {
+		numdomains--;
+		sprintf(temp, ", %d", cdx_array[numdomains]);
+		strcat(cdx_array_text, temp);
+	}
+
+	PRINTKW("ambiguous domain detected: specified = %d, found array = %s\n",
+		*cdx_p, cdx_array_text);
 	return Z90C_AMBIGUOUS_DOMAIN;
 }
 
@@ -2807,7 +2972,7 @@
 refresh_z90crypt(int *cdx_p)
 {
 	int i, j, indx, rv;
-	struct status local_mask;
+	static struct status local_mask;
 	struct device *devPtr;
 	unsigned char oldStat, newStat;
 	int return_unchanged;
@@ -2818,25 +2983,14 @@
 		return TSQ_FATAL_ERROR;
 	rv = 0;
 	if (!z90crypt.hdware_info->hdware_mask.st_count &&
-	    !z90crypt.domain_established)
+	    !z90crypt.domain_established) {
 		rv = probe_crypto_domain(cdx_p);
-	if (z90crypt.terminating)
-		return TSQ_FATAL_ERROR;
-	if (rv) {
-		switch (rv) {
-		case Z90C_AMBIGUOUS_DOMAIN:
-			PRINTK("ambiguous domain detected\n");
-			break;
-		case Z90C_INCORRECT_DOMAIN:
-			PRINTK("incorrect domain specified\n");
-			break;
-		default:
-			PRINTK("probe domain returned %d\n", rv);
-			break;
-		}
-		return rv;
-	}
-	if (*cdx_p) {
+		if (z90crypt.terminating)
+			return TSQ_FATAL_ERROR;
+		if (rv == Z90C_NO_DEVICES)
+			return 0; // try later
+		if (rv)
+			return rv;
 		z90crypt.cdx = *cdx_p;
 		z90crypt.domain_established = 1;
 	}
@@ -2999,14 +3153,28 @@
 				return rv;
 			}
 		}
+		if (dev_ptr->dev_type == PCIXCC_UNK) {
+			rv = probe_PCIXCC_type(dev_ptr);
+			if (rv) {
+				PRINTK("rv = %d from probe_PCIXCC_type %d\n",
+				       rv, index);
+				kfree(dev_ptr->dev_resp_p);
+				kfree(dev_ptr);
+				return rv;
+			}
+		}
 		deviceType = dev_ptr->dev_type;
 		z90crypt.dev_type_array[index] = deviceType;
 		if (deviceType == PCICA)
 			z90crypt.hdware_info->device_type_array[index] = 1;
 		else if (deviceType == PCICC)
 			z90crypt.hdware_info->device_type_array[index] = 2;
-		else if (deviceType == PCIXCC)
+		else if (deviceType == PCIXCC_MCL2)
 			z90crypt.hdware_info->device_type_array[index] = 3;
+		else if (deviceType == PCIXCC_MCL3)
+			z90crypt.hdware_info->device_type_array[index] = 4;
+		else if (deviceType == CEX2C)
+			z90crypt.hdware_info->device_type_array[index] = 5;
 		else
 			z90crypt.hdware_info->device_type_array[index] = -1;
 	}
@@ -3086,7 +3254,7 @@
 	memset((void *)&z90crypt, 0, sizeof(z90crypt));
 }
 
-static unsigned char static_testmsg[] = {
+static unsigned char static_testmsg[384] = {
 0x00,0x00,0x00,0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x00,0x06,0x00,0x00,
 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x58,
 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x43,0x43,
@@ -3118,7 +3286,7 @@
 {
 	int rv, dv, i, index, length;
 	unsigned char psmid[8];
-	static unsigned char loc_testmsg[384];
+	static unsigned char loc_testmsg[sizeof(static_testmsg)];
 
 	index = devPtr->dev_self_x;
 	rv = 0;
@@ -3212,8 +3380,146 @@
 	return rv;
 }
 
+static unsigned char MCL3_testmsg[] = {
+0x00,0x00,0x00,0x00,0xEE,0xEE,0xEE,0xEE,0xEE,0xEE,0xEE,0xEE,
+0x00,0x06,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x58,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x43,0x41,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x50,0x4B,0x00,0x00,0x00,0x00,0x01,0xC4,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x07,0x24,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xDC,0x02,0x00,0x00,0x00,0x54,0x32,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xE8,0x00,0x00,0x00,0x00,0x00,0x00,0x07,0x24,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
+0x00,0x00,0x00,0x00,0x50,0x4B,0x00,0x0A,0x4D,0x52,0x50,0x20,0x20,0x20,0x20,0x20,
+0x00,0x42,0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,
+0x0E,0x0F,0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77,0x88,0x99,0xAA,0xBB,0xCC,0xDD,
+0xEE,0xFF,0xFF,0xEE,0xDD,0xCC,0xBB,0xAA,0x99,0x88,0x77,0x66,0x55,0x44,0x33,0x22,
+0x11,0x00,0x01,0x23,0x45,0x67,0x89,0xAB,0xCD,0xEF,0xFE,0xDC,0xBA,0x98,0x76,0x54,
+0x32,0x10,0x00,0x9A,0x00,0x98,0x00,0x00,0x1E,0x00,0x00,0x94,0x00,0x00,0x00,0x00,
+0x04,0x00,0x00,0x8C,0x00,0x00,0x00,0x40,0x02,0x00,0x00,0x40,0xBA,0xE8,0x23,0x3C,
+0x75,0xF3,0x91,0x61,0xD6,0x73,0x39,0xCF,0x7B,0x6D,0x8E,0x61,0x97,0x63,0x9E,0xD9,
+0x60,0x55,0xD6,0xC7,0xEF,0xF8,0x1E,0x63,0x95,0x17,0xCC,0x28,0x45,0x60,0x11,0xC5,
+0xC4,0x4E,0x66,0xC6,0xE6,0xC3,0xDE,0x8A,0x19,0x30,0xCF,0x0E,0xD7,0xAA,0xDB,0x01,
+0xD8,0x00,0xBB,0x8F,0x39,0x9F,0x64,0x28,0xF5,0x7A,0x77,0x49,0xCC,0x6B,0xA3,0x91,
+0x97,0x70,0xE7,0x60,0x1E,0x39,0xE1,0xE5,0x33,0xE1,0x15,0x63,0x69,0x08,0x80,0x4C,
+0x67,0xC4,0x41,0x8F,0x48,0xDF,0x26,0x98,0xF1,0xD5,0x8D,0x88,0xD9,0x6A,0xA4,0x96,
+0xC5,0x84,0xD9,0x30,0x49,0x67,0x7D,0x19,0xB1,0xB3,0x45,0x4D,0xB2,0x53,0x9A,0x47,
+0x3C,0x7C,0x55,0xBF,0xCC,0x85,0x00,0x36,0xF1,0x3D,0x93,0x53
+};
+
+static int
+probe_PCIXCC_type(struct device *devPtr)
+{
+	int rv, dv, i, index, length;
+	unsigned char psmid[8];
+	static unsigned char loc_testmsg[548];
+	struct CPRBX *cprbx_p;
+
+	index = devPtr->dev_self_x;
+	rv = 0;
+	do {
+		memcpy(loc_testmsg, MCL3_testmsg, sizeof(MCL3_testmsg));
+		length = sizeof(MCL3_testmsg) - 0x0C;
+		dv = send_to_AP(index, z90crypt.cdx, length, loc_testmsg);
+		if (dv) {
+			PDEBUG("dv returned = %d\n", dv);
+			if (dv == DEV_SEN_EXCEPTION) {
+				rv = SEN_FATAL_ERROR;
+				PRINTKC("exception in send to AP %d\n", index);
+				break;
+			}
+			PDEBUG("return value from send_to_AP: %d\n", rv);
+			switch (dv) {
+			case DEV_GONE:
+				PDEBUG("dev %d not available\n", index);
+				rv = SEN_NOT_AVAIL;
+				break;
+			case DEV_ONLINE:
+				rv = 0;
+				break;
+			case DEV_EMPTY:
+				rv = SEN_NOT_AVAIL;
+				break;
+			case DEV_NO_WORK:
+				rv = SEN_FATAL_ERROR;
+				break;
+			case DEV_BAD_MESSAGE:
+				rv = SEN_USER_ERROR;
+				break;
+			case DEV_QUEUE_FULL:
+				rv = SEN_QUEUE_FULL;
+				break;
+			default:
+				PRINTK("unknown dv=%d for dev %d\n", dv, index);
+				rv = SEN_NOT_AVAIL;
+				break;
+			}
+		}
+
+		if (rv)
+			break;
+
+		for (i = 0; i < 6; i++) {
+			mdelay(300);
+			dv = receive_from_AP(index, z90crypt.cdx,
+					     devPtr->dev_resp_l,
+					     devPtr->dev_resp_p, psmid);
+			PDEBUG("dv returned by DQ = %d\n", dv);
+			if (dv == DEV_REC_EXCEPTION) {
+				rv = REC_FATAL_ERROR;
+				PRINTKC("exception in dequeue %d\n",
+					index);
+				break;
+			}
+			switch (dv) {
+			case DEV_ONLINE:
+				rv = 0;
+				break;
+			case DEV_EMPTY:
+				rv = REC_EMPTY;
+				break;
+			case DEV_NO_WORK:
+				rv = REC_NO_WORK;
+				break;
+			case DEV_BAD_MESSAGE:
+			case DEV_GONE:
+			default:
+				rv = REC_NO_RESPONSE;
+				break;
+			}
+			if ((rv != 0) && (rv != REC_NO_WORK))
+				break;
+			if (rv == 0)
+				break;
+		}
+		if (rv)
+			break;
+		cprbx_p = (struct CPRBX *) (devPtr->dev_resp_p + 48);
+		if ((cprbx_p->ccp_rtcode == 8) && (cprbx_p->ccp_rscode == 33)) {
+			devPtr->dev_type = PCIXCC_MCL2;
+			PDEBUG("device %d is MCL2\n", index);
+		} else {
+			devPtr->dev_type = PCIXCC_MCL3;
+			PDEBUG("device %d is MCL3\n", index);
+		}
+	} while (0);
+	/* In a general error case, the card is not marked online */
+	return rv;
+}
+
 #ifdef Z90CRYPT_USE_HOTPLUG
-void
+static void
 z90crypt_hotplug_event(int dev_major, int dev_minor, int action)
 {
 #ifdef CONFIG_HOTPLUG
@@ -3241,6 +3547,7 @@
 		break;
 	default:
 		BUG();
+		break;
 	}
 	envp[3] = major;
 	envp[4] = minor;
