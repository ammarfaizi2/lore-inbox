Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVH2R4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVH2R4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 13:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVH2R4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 13:56:32 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:19354 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751246AbVH2R4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 13:56:20 -0400
Date: Mon, 29 Aug 2005 19:56:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, edrossma@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 7/10] s390: crypto driver update.
Message-ID: <20050829175615.GG6796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 7/10] s390: crypto driver update.

From: Eric Rossman <edrossma@us.ibm.com>

crypto device driver update:
 - Suppress syslog messages for some return codes.
 - Fix incorrect bounds checking in /proc interface.
 - Remove hotplug calls.
 - Remove linux version checks.
 - Remove device workqueue on module unload.

Signed-off-by: Eric Rossman <edrossma@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/crypto/z90common.h   |    3 
 drivers/s390/crypto/z90hardware.c |  127 +++++++++----------
 drivers/s390/crypto/z90main.c     |  246 ++++++--------------------------------
 3 files changed, 106 insertions(+), 270 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/z90common.h linux-2.6-patched/drivers/s390/crypto/z90common.h
--- linux-2.6/drivers/s390/crypto/z90common.h	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90common.h	2005-08-29 19:18:10.000000000 +0200
@@ -27,7 +27,7 @@
 #ifndef _Z90COMMON_H_
 #define _Z90COMMON_H_
 
-#define VERSION_Z90COMMON_H "$Revision: 1.16 $"
+#define VERSION_Z90COMMON_H "$Revision: 1.17 $"
 
 
 #define RESPBUFFSIZE 256
@@ -164,5 +164,4 @@ struct CPRBX {
 #define UMIN(a,b) ((a) < (b) ? (a) : (b))
 #define IS_EVEN(x) ((x) == (2 * ((x) / 2)))
 
-
 #endif
diff -urpN linux-2.6/drivers/s390/crypto/z90hardware.c linux-2.6-patched/drivers/s390/crypto/z90hardware.c
--- linux-2.6/drivers/s390/crypto/z90hardware.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90hardware.c	2005-08-29 19:18:10.000000000 +0200
@@ -32,7 +32,7 @@
 #include "z90crypt.h"
 #include "z90common.h"
 
-#define VERSION_Z90HARDWARE_C "$Revision: 1.33 $"
+#define VERSION_Z90HARDWARE_C "$Revision: 1.34 $"
 
 char z90hardware_version[] __initdata =
 	"z90hardware.o (" VERSION_Z90HARDWARE_C "/"
@@ -283,48 +283,6 @@ struct type6_msg {
 	struct CPRB	 CPRB;
 };
 
-union request_msg {
-	union  type4_msg t4msg;
-	struct type6_msg t6msg;
-};
-
-struct request_msg_ext {
-	int		  q_nr;
-	unsigned char	  *psmid;
-	union request_msg reqMsg;
-};
-
-struct type82_hdr {
-	unsigned char reserved1;
-	unsigned char type;
-	unsigned char reserved2[2];
-	unsigned char reply_code;
-	unsigned char reserved3[3];
-};
-
-#define TYPE82_RSP_CODE 0x82
-
-#define REPLY_ERROR_MACHINE_FAILURE  0x10
-#define REPLY_ERROR_PREEMPT_FAILURE  0x12
-#define REPLY_ERROR_CHECKPT_FAILURE  0x14
-#define REPLY_ERROR_MESSAGE_TYPE     0x20
-#define REPLY_ERROR_INVALID_COMM_CD  0x21
-#define REPLY_ERROR_INVALID_MSG_LEN  0x23
-#define REPLY_ERROR_RESERVD_FIELD    0x24
-#define REPLY_ERROR_FORMAT_FIELD     0x29
-#define REPLY_ERROR_INVALID_COMMAND  0x30
-#define REPLY_ERROR_MALFORMED_MSG    0x40
-#define REPLY_ERROR_RESERVED_FIELDO  0x50
-#define REPLY_ERROR_WORD_ALIGNMENT   0x60
-#define REPLY_ERROR_MESSAGE_LENGTH   0x80
-#define REPLY_ERROR_OPERAND_INVALID  0x82
-#define REPLY_ERROR_OPERAND_SIZE     0x84
-#define REPLY_ERROR_EVEN_MOD_IN_OPND 0x85
-#define REPLY_ERROR_RESERVED_FIELD   0x88
-#define REPLY_ERROR_TRANSPORT_FAIL   0x90
-#define REPLY_ERROR_PACKET_TRUNCATED 0xA0
-#define REPLY_ERROR_ZERO_BUFFER_LEN  0xB0
-
 struct type86_hdr {
 	unsigned char reserved1;
 	unsigned char type;
@@ -338,7 +296,7 @@ struct type86_hdr {
 #define TYPE86_FMT2	0x02
 
 struct type86_fmt2_msg {
-	struct type86_hdr hdr;
+	struct type86_hdr header;
 	unsigned char	  reserved[4];
 	unsigned char	  apfs[4];
 	unsigned int	  count1;
@@ -538,6 +496,8 @@ static struct function_and_rules_block s
 	{'M','R','P',' ',' ',' ',' ',' '}
 };
 
+static unsigned char static_PKE_function_code[2] = {0x50, 0x4B};
+
 struct T6_keyBlock_hdrX {
 	unsigned short blen;
 	unsigned short ulen;
@@ -688,9 +648,38 @@ static struct cca_public_sec static_cca_
 #define RESPONSE_CPRB_SIZE  0x000006B8
 #define RESPONSE_CPRBX_SIZE 0x00000724
 
-#define CALLER_HEADER 12
+struct error_hdr {
+	unsigned char reserved1;
+	unsigned char type;
+	unsigned char reserved2[2];
+	unsigned char reply_code;
+	unsigned char reserved3[3];
+};
 
-static unsigned char static_PKE_function_code[2] = {0x50, 0x4B};
+#define TYPE82_RSP_CODE 0x82
+
+#define REP82_ERROR_MACHINE_FAILURE  0x10
+#define REP82_ERROR_PREEMPT_FAILURE  0x12
+#define REP82_ERROR_CHECKPT_FAILURE  0x14
+#define REP82_ERROR_MESSAGE_TYPE     0x20
+#define REP82_ERROR_INVALID_COMM_CD  0x21
+#define REP82_ERROR_INVALID_MSG_LEN  0x23
+#define REP82_ERROR_RESERVD_FIELD    0x24
+#define REP82_ERROR_FORMAT_FIELD     0x29
+#define REP82_ERROR_INVALID_COMMAND  0x30
+#define REP82_ERROR_MALFORMED_MSG    0x40
+#define REP82_ERROR_RESERVED_FIELDO  0x50
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
+#define CALLER_HEADER 12
 
 static inline int
 testq(int q_nr, int *q_depth, int *dev_type, struct ap_status_word *stat)
@@ -1212,9 +1201,9 @@ send_to_AP(int dev_nr, int cdx, int msg_
 	struct ap_status_word stat_word;
 	enum devstat stat;
 	int ccode;
+	u32 *q_nr_p = (u32 *)msg_ext;
 
-	((struct request_msg_ext *) msg_ext)->q_nr =
-		(dev_nr << SKIP_BITL) + cdx;
+	*q_nr_p = (dev_nr << SKIP_BITL) + cdx;
 	PDEBUG("msg_len passed to sen: %d\n", msg_len);
 	PDEBUG("q number passed to sen: %02x%02x%02x%02x\n",
 	       msg_ext[0], msg_ext[1], msg_ext[2], msg_ext[3]);
@@ -2104,7 +2093,7 @@ convert_response(unsigned char *response
 		 int *respbufflen_p, unsigned char *resp_buff)
 {
 	struct ica_rsa_modexpo *icaMsg_p = (struct ica_rsa_modexpo *) buffer;
-	struct type82_hdr *t82h_p = (struct type82_hdr *) response;
+	struct error_hdr *errh_p = (struct error_hdr *) response;
 	struct type84_hdr *t84h_p = (struct type84_hdr *) response;
 	struct type86_fmt2_msg *t86m_p =  (struct type86_fmt2_msg *) response;
 	int reply_code, service_rc, service_rs, src_l;
@@ -2117,12 +2106,13 @@ convert_response(unsigned char *response
 	service_rc = 0;
 	service_rs = 0;
 	src_l = 0;
-	switch (t82h_p->type) {
+	switch (errh_p->type) {
 	case TYPE82_RSP_CODE:
-		reply_code = t82h_p->reply_code;
-		src_p = (unsigned char *)t82h_p;
-		PRINTK("Hardware error: Type 82 Message Header: "
+		reply_code = errh_p->reply_code;
+		src_p = (unsigned char *)errh_p;
+		PRINTK("Hardware error: Type %02X Message Header: "
 		       "%02x%02x%02x%02x%02x%02x%02x%02x\n",
+		       errh_p->type,
 		       src_p[0], src_p[1], src_p[2], src_p[3],
 		       src_p[4], src_p[5], src_p[6], src_p[7]);
 		break;
@@ -2131,7 +2121,7 @@ convert_response(unsigned char *response
 		src_p = response + (int)t84h_p->len - src_l;
 		break;
 	case TYPE86_RSP_CODE:
-		reply_code = t86m_p->hdr.reply_code;
+		reply_code = t86m_p->header.reply_code;
 		if (reply_code != 0)
 			break;
 		cprb_p = (struct CPRB *)
@@ -2143,6 +2133,9 @@ convert_response(unsigned char *response
 				le2toI(cprb_p->ccp_rscode, &service_rs);
 				if ((service_rc == 8) && (service_rs == 66))
 					PDEBUG("Bad block format on PCICC\n");
+				else if ((service_rc == 8) && (service_rs == 65))
+					PDEBUG("Probably an even modulus on "
+					       "PCICC\n");
 				else if ((service_rc == 8) && (service_rs == 770)) {
 					PDEBUG("Invalid key length on PCICC\n");
 					unset_ext_bitlens();
@@ -2155,7 +2148,7 @@ convert_response(unsigned char *response
 					return REC_USE_PCICA;
 				}
 				else
-					PRINTK("service rc/rs: %d/%d\n",
+					PRINTK("service rc/rs (PCICC): %d/%d\n",
 					       service_rc, service_rs);
 				return REC_OPERAND_INV;
 			}
@@ -2169,7 +2162,10 @@ convert_response(unsigned char *response
 			if (service_rc != 0) {
 				service_rs = (int) cprbx_p->ccp_rscode;
 				if ((service_rc == 8) && (service_rs == 66))
-					PDEBUG("Bad block format on PCXICC\n");
+					PDEBUG("Bad block format on PCIXCC\n");
+				else if ((service_rc == 8) && (service_rs == 65))
+					PDEBUG("Probably an even modulus on "
+					       "PCIXCC\n");
 				else if ((service_rc == 8) && (service_rs == 770)) {
 					PDEBUG("Invalid key length on PCIXCC\n");
 					unset_ext_bitlens();
@@ -2182,7 +2178,7 @@ convert_response(unsigned char *response
 					return REC_USE_PCICA;
 				}
 				else
-					PRINTK("service rc/rs: %d/%d\n",
+					PRINTK("service rc/rs (PCIXCC): %d/%d\n",
 					       service_rc, service_rs);
 				return REC_OPERAND_INV;
 			}
@@ -2195,20 +2191,25 @@ convert_response(unsigned char *response
 		}
 		break;
 	default:
+		src_p = (unsigned char *)errh_p;
+		PRINTK("Unrecognized Message Header: "
+		       "%02x%02x%02x%02x%02x%02x%02x%02x\n",
+		       src_p[0], src_p[1], src_p[2], src_p[3],
+		       src_p[4], src_p[5], src_p[6], src_p[7]);
 		return REC_BAD_MESSAGE;
 	}
 
 	if (reply_code)
 		switch (reply_code) {
-		case REPLY_ERROR_OPERAND_INVALID:
+		case REP82_ERROR_OPERAND_INVALID:
 			return REC_OPERAND_INV;
-		case REPLY_ERROR_OPERAND_SIZE:
+		case REP82_ERROR_OPERAND_SIZE:
 			return REC_OPERAND_SIZE;
-		case REPLY_ERROR_EVEN_MOD_IN_OPND:
+		case REP82_ERROR_EVEN_MOD_IN_OPND:
 			return REC_EVEN_MOD;
-		case REPLY_ERROR_MESSAGE_TYPE:
+		case REP82_ERROR_MESSAGE_TYPE:
 			return WRONG_DEVICE_TYPE;
-		case REPLY_ERROR_TRANSPORT_FAIL:
+		case REP82_ERROR_TRANSPORT_FAIL:
 			PRINTKW("Transport failed (APFS = %02X%02X%02X%02X)\n",
 				t86m_p->apfs[0], t86m_p->apfs[1],
 				t86m_p->apfs[2], t86m_p->apfs[3]);
@@ -2229,7 +2230,7 @@ convert_response(unsigned char *response
 	PDEBUG("Length returned = %d\n", src_l);
 	tgt_p = resp_buff + icaMsg_p->outputdatalength - src_l;
 	memcpy(tgt_p, src_p, src_l);
-	if ((t82h_p->type == TYPE86_RSP_CODE) && (resp_buff < tgt_p)) {
+	if ((errh_p->type == TYPE86_RSP_CODE) && (resp_buff < tgt_p)) {
 		memset(resp_buff, 0, icaMsg_p->outputdatalength - src_l);
 		if (pad_msg(resp_buff, icaMsg_p->outputdatalength, src_l))
 			return REC_INVALID_PAD;
diff -urpN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2005-08-29 19:18:10.000000000 +0200
@@ -31,6 +31,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>   // for tasklets
 #include <linux/ioctl32.h>
+#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kobject_uevent.h>
@@ -39,19 +40,8 @@
 #include <linux/version.h>
 #include "z90crypt.h"
 #include "z90common.h"
-#ifndef Z90CRYPT_USE_HOTPLUG
-#include <linux/miscdevice.h>
-#endif
-
-#define VERSION_CODE(vers, rel, seq) (((vers)<<16) | ((rel)<<8) | (seq))
-#if LINUX_VERSION_CODE < VERSION_CODE(2,4,0) /* version < 2.4 */
-#  error "This kernel is too old: not supported"
-#endif
-#if LINUX_VERSION_CODE > VERSION_CODE(2,7,0) /* version > 2.6 */
-#  error "This kernel is too recent: not supported by this file"
-#endif
 
-#define VERSION_Z90MAIN_C "$Revision: 1.57 $"
+#define VERSION_Z90MAIN_C "$Revision: 1.62 $"
 
 static char z90main_version[] __initdata =
 	"z90main.o (" VERSION_Z90MAIN_C "/"
@@ -63,21 +53,12 @@ extern char z90hardware_version[];
  * Defaults that may be modified.
  */
 
-#ifndef Z90CRYPT_USE_HOTPLUG
 /**
  * You can specify a different minor at compile time.
  */
 #ifndef Z90CRYPT_MINOR
 #define Z90CRYPT_MINOR	MISC_DYNAMIC_MINOR
 #endif
-#else
-/**
- * You can specify a different major at compile time.
- */
-#ifndef Z90CRYPT_MAJOR
-#define Z90CRYPT_MAJOR	0
-#endif
-#endif
 
 /**
  * You can specify a different domain at compile time or on the insmod
@@ -97,7 +78,7 @@ extern char z90hardware_version[];
  * older than CLEANUPTIME seconds in the past.
  */
 #ifndef CLEANUPTIME
-#define CLEANUPTIME 20
+#define CLEANUPTIME 15
 #endif
 
 /**
@@ -298,6 +279,10 @@ struct z90crypt {
  * it contains the request; at READ, the response. The function
  * send_to_crypto_device converts the request to device-dependent
  * form and use the caller's OPEN-allocated buffer for the response.
+ *
+ * For the contents of caller_dev_dep_req and caller_dev_dep_req_p
+ * because that points to it, see the discussion in z90hardware.c.
+ * Search for "extended request message block".
  */
 struct caller {
 	int		 caller_buf_l;		 // length of original request
@@ -398,24 +383,9 @@ static int z90crypt_status_write(struct 
 				 unsigned long, void *);
 
 /**
- * Hotplug support
- */
-
-#ifdef Z90CRYPT_USE_HOTPLUG
-#define Z90CRYPT_HOTPLUG_ADD	 1
-#define Z90CRYPT_HOTPLUG_REMOVE	 2
-
-static void z90crypt_hotplug_event(int, int, int);
-#endif
-
-/**
  * Storage allocated at initialization and used throughout the life of
  * this insmod
  */
-#ifdef Z90CRYPT_USE_HOTPLUG
-static int z90crypt_major = Z90CRYPT_MAJOR;
-#endif
-
 static int domain = DOMAIN_INDEX;
 static struct z90crypt z90crypt;
 static int quiesce_z90crypt;
@@ -444,14 +414,12 @@ static struct file_operations z90crypt_f
 	.release	= z90crypt_release
 };
 
-#ifndef Z90CRYPT_USE_HOTPLUG
 static struct miscdevice z90crypt_misc_device = {
 	.minor	    = Z90CRYPT_MINOR,
 	.name	    = DEV_NAME,
 	.fops	    = &z90crypt_fops,
 	.devfs_name = DEV_NAME
 };
-#endif
 
 /**
  * Documentation values.
@@ -603,7 +571,6 @@ z90crypt_init_module(void)
 		return -EINVAL;
 	}
 
-#ifndef Z90CRYPT_USE_HOTPLUG
 	/* Register as misc device with given minor (or get a dynamic one). */
 	result = misc_register(&z90crypt_misc_device);
 	if (result < 0) {
@@ -611,18 +578,6 @@ z90crypt_init_module(void)
 			z90crypt_misc_device.minor, result);
 		return result;
 	}
-#else
-	/* Register the major (or get a dynamic one). */
-	result = register_chrdev(z90crypt_major, REG_NAME, &z90crypt_fops);
-	if (result < 0) {
-		PRINTKW("register_chrdev (major %d) failed with %d.\n",
-			z90crypt_major, result);
-		return result;
-	}
-
-	if (z90crypt_major == 0)
-		z90crypt_major = result;
-#endif
 
 	PDEBUG("Registered " DEV_NAME " with result %d\n", result);
 
@@ -645,11 +600,6 @@ z90crypt_init_module(void)
 	} else
 		PRINTK("No devices at startup\n");
 
-#ifdef Z90CRYPT_USE_HOTPLUG
-	/* generate hotplug event for device node generation */
-	z90crypt_hotplug_event(z90crypt_major, 0, Z90CRYPT_HOTPLUG_ADD);
-#endif
-
 	/* Initialize globals. */
 	spin_lock_init(&queuespinlock);
 
@@ -701,17 +651,10 @@ z90crypt_init_module(void)
 	return 0; // success
 
 init_module_cleanup:
-#ifndef Z90CRYPT_USE_HOTPLUG
 	if ((nresult = misc_deregister(&z90crypt_misc_device)))
 		PRINTK("misc_deregister failed with %d.\n", nresult);
 	else
 		PDEBUG("misc_deregister successful.\n");
-#else
-	if ((nresult = unregister_chrdev(z90crypt_major, REG_NAME)))
-		PRINTK("unregister_chrdev failed with %d.\n", nresult);
-	else
-		PDEBUG("unregister_chrdev successful.\n");
-#endif
 
 	return result; // failure
 }
@@ -728,19 +671,10 @@ z90crypt_cleanup_module(void)
 
 	remove_proc_entry("driver/z90crypt", 0);
 
-#ifndef Z90CRYPT_USE_HOTPLUG
 	if ((nresult = misc_deregister(&z90crypt_misc_device)))
 		PRINTK("misc_deregister failed with %d.\n", nresult);
 	else
 		PDEBUG("misc_deregister successful.\n");
-#else
-	z90crypt_hotplug_event(z90crypt_major, 0, Z90CRYPT_HOTPLUG_REMOVE);
-
-	if ((nresult = unregister_chrdev(z90crypt_major, REG_NAME)))
-		PRINTK("unregister_chrdev failed with %d.\n", nresult);
-	else
-		PDEBUG("unregister_chrdev successful.\n");
-#endif
 
 	/* Remove the tasks */
 	tasklet_kill(&reader_tasklet);
@@ -748,6 +682,9 @@ z90crypt_cleanup_module(void)
 	del_timer(&config_timer);
 	del_timer(&cleanup_timer);
 
+	if (z90_device_work)
+		destroy_workqueue(z90_device_work);
+
 	destroy_z90crypt();
 
 	PRINTKN("Unloaded.\n");
@@ -766,8 +703,6 @@ z90crypt_cleanup_module(void)
  *     z90crypt_status_write
  *	 disable_card
  *	 enable_card
- *	 scan_char
- *	 scan_string
  *
  * Helper functions:
  *     z90crypt_rsa
@@ -1057,9 +992,10 @@ remove_device(struct device *device_p)
  * The MCL must be applied and the newer bitlengths enabled for these to work.
  *
  * Card Type    Old limit    New limit
+ * PCICA          ??-2048     same (the lower limit is less than 128 bit...)
  * PCICC         512-1024     512-2048
- * PCIXCC_MCL2   512-2048     no change (applying this MCL == card is MCL3+)
- * PCIXCC_MCL3   512-2048     128-2048
+ * PCIXCC_MCL2   512-2048     ----- (applying any GA LIC will make an MCL3 card)
+ * PCIXCC_MCL3   -----        128-2048
  * CEX2C         512-2048     128-2048
  *
  * ext_bitlens (extended bitlengths) is a global, since you should not apply an
@@ -1104,7 +1040,7 @@ select_device_type(int *dev_type_p, int 
 	if (PCICA_avail || PCIXCC_MCL3_avail || CEX2C_avail) {
 		/**
 		 * bitlength is a factor, PCICA is the most capable, even with
-		 * the new MCL.
+		 * the new MCL for PCIXCC.
 		 */
 		if ((bytelength < PCIXCC_MIN_MOD_SIZE) ||
 		    (!ext_bitlens && (bytelength < OLD_PCIXCC_MIN_MOD_SIZE))) {
@@ -2144,73 +2080,15 @@ enable_card(int card_index)
 	z90crypt.hdware_info->type_mask[devp->dev_type].user_disabled_count--;
 }
 
-static inline int
-scan_char(unsigned char *bf, unsigned int len,
-	  unsigned int *offs, unsigned int *p_eof, unsigned char c)
-{
-	unsigned int i, found;
-
-	found = 0;
-	for (i = 0; i < len; i++) {
-		if (bf[i] == c) {
-			found = 1;
-			break;
-		}
-		if (bf[i] == '\0') {
-			*p_eof = 1;
-			break;
-		}
-		if (bf[i] == '\n') {
-			break;
-		}
-	}
-	*offs = i+1;
-	return found;
-}
-
-static inline int
-scan_string(unsigned char *bf, unsigned int len,
-	    unsigned int *offs, unsigned int *p_eof, unsigned char *s)
-{
-	unsigned int temp_len, temp_offs, found, eof;
-
-	temp_len = temp_offs = found = eof = 0;
-	while (!eof && !found) {
-		found = scan_char(bf+temp_len, len-temp_len,
-				  &temp_offs, &eof, *s);
-
-		temp_len += temp_offs;
-		if (eof) {
-			found = 0;
-			break;
-		}
-
-		if (found) {
-			if (len >= temp_offs+strlen(s)) {
-				found = !strncmp(bf+temp_len-1, s, strlen(s));
-				if (found) {
-					*offs = temp_len+strlen(s)-1;
-					break;
-				}
-			} else {
-				found = 0;
-				*p_eof = 1;
-				break;
-			}
-		}
-	}
-	return found;
-}
-
 static int
 z90crypt_status_write(struct file *file, const char __user *buffer,
 		      unsigned long count, void *data)
 {
-	int i, j, len, offs, found, eof;
-	unsigned char *lbuf;
+	int j, eol;
+	unsigned char *lbuf, *ptr;
 	unsigned int local_count;
 
-#define LBUFSIZE 600
+#define LBUFSIZE 1200
 	lbuf = kmalloc(LBUFSIZE, GFP_KERNEL);
 	if (!lbuf) {
 		PRINTK("kmalloc failed!\n");
@@ -2227,49 +2105,46 @@ z90crypt_status_write(struct file *file,
 		return -EFAULT;
 	}
 
-	lbuf[local_count-1] = '\0';
+	lbuf[local_count] = '\0';
 
-	len = 0;
-	eof = 0;
-	found = 0;
-	while (!eof) {
-		found = scan_string(lbuf+len, local_count-len, &offs, &eof,
-				    "Online devices");
-		len += offs;
-		if (found == 1)
-			break;
+	ptr = strstr(lbuf, "Online devices");
+	if (ptr == 0) {
+		PRINTK("Unable to parse data (missing \"Online devices\")\n");
+		kfree(lbuf);
+		return count;
 	}
 
-	if (eof) {
+	ptr = strstr(ptr, "\n");
+	if (ptr == 0) {
+		PRINTK("Unable to parse data (missing newline after \"Online devices\")\n");
 		kfree(lbuf);
 		return count;
 	}
+	ptr++;
 
-	if (found)
-		found = scan_char(lbuf+len, local_count-len, &offs, &eof, '\n');
-
-	if (!found || eof) {
+	if (strstr(ptr, "Waiting work element counts") == NULL) {
+		PRINTK("Unable to parse data (missing \"Waiting work element counts\")\n");
 		kfree(lbuf);
 		return count;
 	}
 
-	len += offs;
 	j = 0;
-	for (i = 0; i < 80; i++) {
-		switch (*(lbuf+len+i)) {
+	eol = 0;
+	while ((j < 64) && (*ptr != '\0')) {
+		switch (*ptr) {
 		case '\t':
 		case ' ':
 			break;
 		case '\n':
 		default:
-			eof = 1;
+			eol = 1;
 			break;
-		case '0':
-		case '1':
-		case '2':
-		case '3':
-		case '4':
-		case '5':
+		case '0':	// no device
+		case '1':	// PCICA
+		case '2':	// PCICC
+		case '3':	// PCIXCC_MCL2
+		case '4':	// PCIXCC_MCL3
+		case '5':	// CEX2C
 			j++;
 			break;
 		case 'd':
@@ -2283,8 +2158,9 @@ z90crypt_status_write(struct file *file,
 			j++;
 			break;
 		}
-		if (eof)
+		if (eol)
 			break;
+		ptr++;
 	}
 
 	kfree(lbuf);
@@ -3479,45 +3355,5 @@ probe_PCIXCC_type(struct device *devPtr)
 	return rv;
 }
 
-#ifdef Z90CRYPT_USE_HOTPLUG
-static void
-z90crypt_hotplug_event(int dev_major, int dev_minor, int action)
-{
-#ifdef CONFIG_HOTPLUG
-	char *argv[3];
-	char *envp[6];
-	char  major[20];
-	char  minor[20];
-
-	sprintf(major, "MAJOR=%d", dev_major);
-	sprintf(minor, "MINOR=%d", dev_minor);
-
-	argv[0] = hotplug_path;
-	argv[1] = "z90crypt";
-	argv[2] = 0;
-
-	envp[0] = "HOME=/";
-	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-
-	switch (action) {
-	case Z90CRYPT_HOTPLUG_ADD:
-		envp[2] = "ACTION=add";
-		break;
-	case Z90CRYPT_HOTPLUG_REMOVE:
-		envp[2] = "ACTION=remove";
-		break;
-	default:
-		BUG();
-		break;
-	}
-	envp[3] = major;
-	envp[4] = minor;
-	envp[5] = 0;
-
-	call_usermodehelper(argv[0], argv, envp, 0);
-#endif
-}
-#endif
-
 module_init(z90crypt_init_module);
 module_exit(z90crypt_cleanup_module);
