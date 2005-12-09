Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVLIP0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVLIP0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 10:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVLIP0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 10:26:09 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:13308 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932294AbVLIP0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 10:26:04 -0500
Date: Fri, 9 Dec 2005 16:26:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, jan.glauber@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 7/17] s390: in-kernel crypto rename.
Message-ID: <20051209152602.GH6532@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Glauber <jan.glauber@de.ibm.com>

[patch 7/17] s390: in-kernel crypto rename.

Replace all references to z990 by s390 in the in-kernel crypto
files in arch/s390/crypto. The code is not specific to a particular
machine (z990) but to the s390 platform. Big diff, does nothing..

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/crypto/Makefile           |    6 
 arch/s390/crypto/crypt_s390.h       |  383 ++++++++++++++++++++++++++++++++++++
 arch/s390/crypto/crypt_s390_query.c |  113 ++++++++++
 arch/s390/crypto/crypt_z990.h       |  374 -----------------------------------
 arch/s390/crypto/crypt_z990_query.c |  111 ----------
 arch/s390/crypto/des_s390.c         |  284 ++++++++++++++++++++++++++
 arch/s390/crypto/des_z990.c         |  284 --------------------------
 arch/s390/crypto/sha1_s390.c        |  167 +++++++++++++++
 arch/s390/crypto/sha1_z990.c        |  167 ---------------
 arch/s390/defconfig                 |    4 
 crypto/Kconfig                      |    8 
 11 files changed, 956 insertions(+), 945 deletions(-)

diff -urpN linux-2.6/arch/s390/crypto/crypt_s390.h linux-2.6-patched/arch/s390/crypto/crypt_s390.h
--- linux-2.6/arch/s390/crypto/crypt_s390.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/crypt_s390.h	2005-12-09 14:24:26.000000000 +0100
@@ -0,0 +1,383 @@
+/*
+ * Cryptographic API.
+ *
+ * Support for s390 cryptographic instructions.
+ *
+ *   Copyright (C) 2003 IBM Deutschland GmbH, IBM Corporation
+ *   Author(s): Thomas Spatzier (tspat@de.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ */
+#ifndef _CRYPTO_ARCH_S390_CRYPT_S390_H
+#define _CRYPTO_ARCH_S390_CRYPT_S390_H
+
+#include <asm/errno.h>
+
+#define CRYPT_S390_OP_MASK 0xFF00
+#define CRYPT_S390_FUNC_MASK 0x00FF
+
+/* s930 cryptographic operations */
+enum crypt_s390_operations {
+	CRYPT_S390_KM   = 0x0100,
+	CRYPT_S390_KMC  = 0x0200,
+	CRYPT_S390_KIMD = 0x0300,
+	CRYPT_S390_KLMD = 0x0400,
+	CRYPT_S390_KMAC = 0x0500
+};
+
+/* function codes for KM (CIPHER MESSAGE) instruction
+ * 0x80 is the decipher modifier bit
+ */
+enum crypt_s390_km_func {
+	KM_QUERY            = CRYPT_S390_KM | 0,
+	KM_DEA_ENCRYPT      = CRYPT_S390_KM | 1,
+	KM_DEA_DECRYPT      = CRYPT_S390_KM | 1 | 0x80,
+	KM_TDEA_128_ENCRYPT = CRYPT_S390_KM | 2,
+	KM_TDEA_128_DECRYPT = CRYPT_S390_KM | 2 | 0x80,
+	KM_TDEA_192_ENCRYPT = CRYPT_S390_KM | 3,
+	KM_TDEA_192_DECRYPT = CRYPT_S390_KM | 3 | 0x80,
+};
+
+/* function codes for KMC (CIPHER MESSAGE WITH CHAINING)
+ * instruction
+ */
+enum crypt_s390_kmc_func {
+	KMC_QUERY            = CRYPT_S390_KMC | 0,
+	KMC_DEA_ENCRYPT      = CRYPT_S390_KMC | 1,
+	KMC_DEA_DECRYPT      = CRYPT_S390_KMC | 1 | 0x80,
+	KMC_TDEA_128_ENCRYPT = CRYPT_S390_KMC | 2,
+	KMC_TDEA_128_DECRYPT = CRYPT_S390_KMC | 2 | 0x80,
+	KMC_TDEA_192_ENCRYPT = CRYPT_S390_KMC | 3,
+	KMC_TDEA_192_DECRYPT = CRYPT_S390_KMC | 3 | 0x80,
+};
+
+/* function codes for KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST)
+ * instruction
+ */
+enum crypt_s390_kimd_func {
+	KIMD_QUERY   = CRYPT_S390_KIMD | 0,
+	KIMD_SHA_1   = CRYPT_S390_KIMD | 1,
+};
+
+/* function codes for KLMD (COMPUTE LAST MESSAGE DIGEST)
+ * instruction
+ */
+enum crypt_s390_klmd_func {
+	KLMD_QUERY   = CRYPT_S390_KLMD | 0,
+	KLMD_SHA_1   = CRYPT_S390_KLMD | 1,
+};
+
+/* function codes for KMAC (COMPUTE MESSAGE AUTHENTICATION CODE)
+ * instruction
+ */
+enum crypt_s390_kmac_func {
+	KMAC_QUERY    = CRYPT_S390_KMAC | 0,
+	KMAC_DEA      = CRYPT_S390_KMAC | 1,
+	KMAC_TDEA_128 = CRYPT_S390_KMAC | 2,
+	KMAC_TDEA_192 = CRYPT_S390_KMAC | 3
+};
+
+/* status word for s390 crypto instructions' QUERY functions */
+struct crypt_s390_query_status {
+	u64 high;
+	u64 low;
+};
+
+/*
+ * Standard fixup and ex_table sections for crypt_s390 inline functions.
+ * label 0: the s390 crypto operation
+ * label 1: just after 1 to catch illegal operation exception
+ *          (unsupported model)
+ * label 6: the return point after fixup
+ * label 7: set error value if exception _in_ crypto operation
+ * label 8: set error value if illegal operation exception
+ * [ret] is the variable to receive the error code
+ * [ERR] is the error code value
+ */
+#ifndef __s390x__
+#define __crypt_s390_fixup \
+	".section .fixup,\"ax\" \n"	\
+	"7:	lhi	%0,%h[e1] \n"	\
+	"	bras	1,9f \n"	\
+	"	.long	6b \n"		\
+	"8:	lhi	%0,%h[e2] \n"	\
+	"	bras	1,9f \n"	\
+	"	.long	6b \n"		\
+	"9:	l	1,0(1) \n"	\
+	"	br	1 \n"		\
+	".previous \n"			\
+	".section __ex_table,\"a\" \n"	\
+	"	.align	4 \n"		\
+	"	.long	0b,7b \n"	\
+	"	.long	1b,8b \n"	\
+	".previous"
+#else /* __s390x__ */
+#define __crypt_s390_fixup \
+	".section .fixup,\"ax\" \n"	\
+	"7:	lhi	%0,%h[e1] \n"	\
+	"	jg	6b \n"		\
+	"8:	lhi	%0,%h[e2] \n"	\
+	"	jg	6b \n"		\
+	".previous\n"			\
+	".section __ex_table,\"a\" \n"	\
+	"	.align	8 \n"		\
+	"	.quad	0b,7b \n"	\
+	"	.quad	1b,8b \n"	\
+	".previous"
+#endif /* __s390x__ */
+
+/*
+ * Standard code for setting the result of s390 crypto instructions.
+ * %0: the register which will receive the result
+ * [result]: the register containing the result (e.g. second operand length
+ * to compute number of processed bytes].
+ */
+#ifndef __s390x__
+#define __crypt_s390_set_result \
+	"	lr	%0,%[result] \n"
+#else /* __s390x__ */
+#define __crypt_s390_set_result \
+	"	lgr	%0,%[result] \n"
+#endif
+
+/*
+ * Executes the KM (CIPHER MESSAGE) operation of the CPU.
+ * @param func: the function code passed to KM; see crypt_s390_km_func
+ * @param param: address of parameter block; see POP for details on each func
+ * @param dest: address of destination memory area
+ * @param src: address of source memory area
+ * @param src_len: length of src operand in bytes
+ * @returns < zero for failure, 0 for the query func, number of processed bytes
+ * 	for encryption/decryption funcs
+ */
+static inline int
+crypt_s390_km(long func, void* param, u8* dest, const u8* src, long src_len)
+{
+	register long __func asm("0") = func & CRYPT_S390_FUNC_MASK;
+	register void* __param asm("1") = param;
+	register u8* __dest asm("4") = dest;
+	register const u8* __src asm("2") = src;
+	register long __src_len asm("3") = src_len;
+	int ret;
+
+	ret = 0;
+	__asm__ __volatile__ (
+		"0:	.insn	rre,0xB92E0000,%1,%2 \n" /* KM opcode */
+		"1:	brc	1,0b \n" /* handle partial completion */
+		__crypt_s390_set_result
+		"6:	\n"
+		__crypt_s390_fixup
+		: "+d" (ret), "+a" (__dest), "+a" (__src),
+		  [result] "+d" (__src_len)
+		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
+		  "a" (__param)
+		: "cc", "memory"
+	);
+	if (ret >= 0 && func & CRYPT_S390_FUNC_MASK){
+		ret = src_len - ret;
+	}
+	return ret;
+}
+
+/*
+ * Executes the KMC (CIPHER MESSAGE WITH CHAINING) operation of the CPU.
+ * @param func: the function code passed to KM; see crypt_s390_kmc_func
+ * @param param: address of parameter block; see POP for details on each func
+ * @param dest: address of destination memory area
+ * @param src: address of source memory area
+ * @param src_len: length of src operand in bytes
+ * @returns < zero for failure, 0 for the query func, number of processed bytes
+ * 	for encryption/decryption funcs
+ */
+static inline int
+crypt_s390_kmc(long func, void* param, u8* dest, const u8* src, long src_len)
+{
+	register long __func asm("0") = func & CRYPT_S390_FUNC_MASK;
+	register void* __param asm("1") = param;
+	register u8* __dest asm("4") = dest;
+	register const u8* __src asm("2") = src;
+	register long __src_len asm("3") = src_len;
+	int ret;
+
+	ret = 0;
+	__asm__ __volatile__ (
+		"0:	.insn	rre,0xB92F0000,%1,%2 \n" /* KMC opcode */
+		"1:	brc	1,0b \n" /* handle partial completion */
+		__crypt_s390_set_result
+		"6:	\n"
+		__crypt_s390_fixup
+		: "+d" (ret), "+a" (__dest), "+a" (__src),
+		  [result] "+d" (__src_len)
+		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
+		  "a" (__param)
+		: "cc", "memory"
+	);
+	if (ret >= 0 && func & CRYPT_S390_FUNC_MASK){
+		ret = src_len - ret;
+	}
+	return ret;
+}
+
+/*
+ * Executes the KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST) operation
+ * of the CPU.
+ * @param func: the function code passed to KM; see crypt_s390_kimd_func
+ * @param param: address of parameter block; see POP for details on each func
+ * @param src: address of source memory area
+ * @param src_len: length of src operand in bytes
+ * @returns < zero for failure, 0 for the query func, number of processed bytes
+ * 	for digest funcs
+ */
+static inline int
+crypt_s390_kimd(long func, void* param, const u8* src, long src_len)
+{
+	register long __func asm("0") = func & CRYPT_S390_FUNC_MASK;
+	register void* __param asm("1") = param;
+	register const u8* __src asm("2") = src;
+	register long __src_len asm("3") = src_len;
+	int ret;
+
+	ret = 0;
+	__asm__ __volatile__ (
+		"0:	.insn	rre,0xB93E0000,%1,%1 \n" /* KIMD opcode */
+		"1:	brc	1,0b \n" /* handle partical completion */
+		__crypt_s390_set_result
+		"6:	\n"
+		__crypt_s390_fixup
+		: "+d" (ret), "+a" (__src), [result] "+d" (__src_len)
+		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
+		  "a" (__param)
+		: "cc", "memory"
+	);
+	if (ret >= 0 && (func & CRYPT_S390_FUNC_MASK)){
+		ret = src_len - ret;
+	}
+	return ret;
+}
+
+/*
+ * Executes the KLMD (COMPUTE LAST MESSAGE DIGEST) operation of the CPU.
+ * @param func: the function code passed to KM; see crypt_s390_klmd_func
+ * @param param: address of parameter block; see POP for details on each func
+ * @param src: address of source memory area
+ * @param src_len: length of src operand in bytes
+ * @returns < zero for failure, 0 for the query func, number of processed bytes
+ * 	for digest funcs
+ */
+static inline int
+crypt_s390_klmd(long func, void* param, const u8* src, long src_len)
+{
+	register long __func asm("0") = func & CRYPT_S390_FUNC_MASK;
+	register void* __param asm("1") = param;
+	register const u8* __src asm("2") = src;
+	register long __src_len asm("3") = src_len;
+	int ret;
+
+	ret = 0;
+	__asm__ __volatile__ (
+		"0:	.insn	rre,0xB93F0000,%1,%1 \n" /* KLMD opcode */
+		"1:	brc	1,0b \n" /* handle partical completion */
+		__crypt_s390_set_result
+		"6:	\n"
+		__crypt_s390_fixup
+		: "+d" (ret), "+a" (__src), [result] "+d" (__src_len)
+		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
+		  "a" (__param)
+		: "cc", "memory"
+	);
+	if (ret >= 0 && func & CRYPT_S390_FUNC_MASK){
+		ret = src_len - ret;
+	}
+	return ret;
+}
+
+/*
+ * Executes the KMAC (COMPUTE MESSAGE AUTHENTICATION CODE) operation
+ * of the CPU.
+ * @param func: the function code passed to KM; see crypt_s390_klmd_func
+ * @param param: address of parameter block; see POP for details on each func
+ * @param src: address of source memory area
+ * @param src_len: length of src operand in bytes
+ * @returns < zero for failure, 0 for the query func, number of processed bytes
+ * 	for digest funcs
+ */
+static inline int
+crypt_s390_kmac(long func, void* param, const u8* src, long src_len)
+{
+	register long __func asm("0") = func & CRYPT_S390_FUNC_MASK;
+	register void* __param asm("1") = param;
+	register const u8* __src asm("2") = src;
+	register long __src_len asm("3") = src_len;
+	int ret;
+
+	ret = 0;
+	__asm__ __volatile__ (
+		"0:	.insn	rre,0xB91E0000,%5,%5 \n" /* KMAC opcode */
+		"1:	brc	1,0b \n" /* handle partical completion */
+		__crypt_s390_set_result
+		"6:	\n"
+		__crypt_s390_fixup
+		: "+d" (ret), "+a" (__src), [result] "+d" (__src_len)
+		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
+		  "a" (__param)
+		: "cc", "memory"
+	);
+	if (ret >= 0 && func & CRYPT_S390_FUNC_MASK){
+		ret = src_len - ret;
+	}
+	return ret;
+}
+
+/**
+ * Tests if a specific crypto function is implemented on the machine.
+ * @param func:	the function code of the specific function; 0 if op in general
+ * @return	1 if func available; 0 if func or op in general not available
+ */
+static inline int
+crypt_s390_func_available(int func)
+{
+	int ret;
+
+	struct crypt_s390_query_status status = {
+		.high = 0,
+		.low = 0
+	};
+	switch (func & CRYPT_S390_OP_MASK){
+		case CRYPT_S390_KM:
+			ret = crypt_s390_km(KM_QUERY, &status, NULL, NULL, 0);
+			break;
+		case CRYPT_S390_KMC:
+			ret = crypt_s390_kmc(KMC_QUERY, &status, NULL, NULL, 0);
+			break;
+		case CRYPT_S390_KIMD:
+			ret = crypt_s390_kimd(KIMD_QUERY, &status, NULL, 0);
+			break;
+		case CRYPT_S390_KLMD:
+			ret = crypt_s390_klmd(KLMD_QUERY, &status, NULL, 0);
+			break;
+		case CRYPT_S390_KMAC:
+			ret = crypt_s390_kmac(KMAC_QUERY, &status, NULL, 0);
+			break;
+		default:
+			ret = 0;
+			return ret;
+	}
+	if (ret >= 0){
+		func &= CRYPT_S390_FUNC_MASK;
+		func &= 0x7f; //mask modifier bit
+		if (func < 64){
+			ret = (status.high >> (64 - func - 1)) & 0x1;
+		} else {
+			ret = (status.low >> (128 - func - 1)) & 0x1;
+		}
+	} else {
+		ret = 0;
+	}
+	return ret;
+}
+
+#endif // _CRYPTO_ARCH_S390_CRYPT_S390_H
diff -urpN linux-2.6/arch/s390/crypto/crypt_s390_query.c linux-2.6-patched/arch/s390/crypto/crypt_s390_query.c
--- linux-2.6/arch/s390/crypto/crypt_s390_query.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/crypt_s390_query.c	2005-12-09 14:24:26.000000000 +0100
@@ -0,0 +1,113 @@
+/*
+ * Cryptographic API.
+ *
+ * Support for s390 cryptographic instructions.
+ * Testing module for querying processor crypto capabilities.
+ *
+ * Copyright (c) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s): Thomas Spatzier (tspat@de.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/errno.h>
+#include "crypt_s390.h"
+
+static void query_available_functions(void)
+{
+	printk(KERN_INFO "#####################\n");
+
+	/* query available KM functions */
+	printk(KERN_INFO "KM_QUERY: %d\n",
+		crypt_s390_func_available(KM_QUERY));
+	printk(KERN_INFO "KM_DEA: %d\n",
+		crypt_s390_func_available(KM_DEA_ENCRYPT));
+	printk(KERN_INFO "KM_TDEA_128: %d\n",
+		crypt_s390_func_available(KM_TDEA_128_ENCRYPT));
+	printk(KERN_INFO "KM_TDEA_192: %d\n",
+		crypt_s390_func_available(KM_TDEA_192_ENCRYPT));
+
+	/* query available KMC functions */
+	printk(KERN_INFO "KMC_QUERY: %d\n",
+		crypt_s390_func_available(KMC_QUERY));
+	printk(KERN_INFO "KMC_DEA: %d\n",
+		crypt_s390_func_available(KMC_DEA_ENCRYPT));
+	printk(KERN_INFO "KMC_TDEA_128: %d\n",
+		crypt_s390_func_available(KMC_TDEA_128_ENCRYPT));
+	printk(KERN_INFO "KMC_TDEA_192: %d\n",
+		crypt_s390_func_available(KMC_TDEA_192_ENCRYPT));
+
+	/* query available KIMD fucntions */
+	printk(KERN_INFO "KIMD_QUERY: %d\n",
+		crypt_s390_func_available(KIMD_QUERY));
+	printk(KERN_INFO "KIMD_SHA_1: %d\n",
+		crypt_s390_func_available(KIMD_SHA_1));
+
+	/* query available KLMD functions */
+	printk(KERN_INFO "KLMD_QUERY: %d\n",
+		crypt_s390_func_available(KLMD_QUERY));
+	printk(KERN_INFO "KLMD_SHA_1: %d\n",
+		crypt_s390_func_available(KLMD_SHA_1));
+
+	/* query available KMAC functions */
+	printk(KERN_INFO "KMAC_QUERY: %d\n",
+		crypt_s3990_func_available(KMAC_QUERY));
+	printk(KERN_INFO "KMAC_DEA: %d\n",
+		crypt_s390_func_available(KMAC_DEA));
+	printk(KERN_INFO "KMAC_TDEA_128: %d\n",
+		crypt_s390_func_available(KMAC_TDEA_128));
+	printk(KERN_INFO "KMAC_TDEA_192: %d\n",
+		crypt_s390_func_available(KMAC_TDEA_192));
+}
+
+static int init(void)
+{
+	struct crypt_s390_query_status status = {
+		.high = 0,
+		.low = 0
+	};
+
+	printk(KERN_INFO "crypt_s390: querying available crypto functions\n");
+	crypt_s390_km(KM_QUERY, &status, NULL, NULL, 0);
+	printk(KERN_INFO "KM:\t%016llx %016llx\n",
+			(unsigned long long) status.high,
+			(unsigned long long) status.low);
+	status.high = status.low = 0;
+	crypt_s390_kmc(KMC_QUERY, &status, NULL, NULL, 0);
+	printk(KERN_INFO "KMC:\t%016llx %016llx\n",
+			(unsigned long long) status.high,
+			(unsigned long long) status.low);
+	status.high = status.low = 0;
+	crypt_s390_kimd(KIMD_QUERY, &status, NULL, 0);
+	printk(KERN_INFO "KIMD:\t%016llx %016llx\n",
+			(unsigned long long) status.high,
+			(unsigned long long) status.low);
+	status.high = status.low = 0;
+	crypt_s390_klmd(KLMD_QUERY, &status, NULL, 0);
+	printk(KERN_INFO "KLMD:\t%016llx %016llx\n",
+			(unsigned long long) status.high,
+			(unsigned long long) status.low);
+	status.high = status.low = 0;
+	crypt_s390_kmac(KMAC_QUERY, &status, NULL, 0);
+	printk(KERN_INFO "KMAC:\t%016llx %016llx\n",
+			(unsigned long long) status.high,
+			(unsigned long long) status.low);
+
+	query_available_functions();
+	return -ECANCELED;
+}
+
+static void __exit cleanup(void)
+{
+}
+
+module_init(init);
+module_exit(cleanup);
+
+MODULE_LICENSE("GPL");
diff -urpN linux-2.6/arch/s390/crypto/crypt_z990.h linux-2.6-patched/arch/s390/crypto/crypt_z990.h
--- linux-2.6/arch/s390/crypto/crypt_z990.h	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/crypto/crypt_z990.h	2005-12-09 14:24:26.000000000 +0100
@@ -1,374 +0,0 @@
-/*
- * Cryptographic API.
- *
- * Support for z990 cryptographic instructions.
- *
- *   Copyright (C) 2003 IBM Deutschland GmbH, IBM Corporation
- *   Author(s): Thomas Spatzier (tspat@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- */
-#ifndef _CRYPTO_ARCH_S390_CRYPT_Z990_H
-#define _CRYPTO_ARCH_S390_CRYPT_Z990_H
-
-#include <asm/errno.h>
-
-#define CRYPT_Z990_OP_MASK 0xFF00
-#define CRYPT_Z990_FUNC_MASK 0x00FF
-
-
-/*z990 cryptographic operations*/
-enum crypt_z990_operations {
-	CRYPT_Z990_KM   = 0x0100,
-	CRYPT_Z990_KMC  = 0x0200,
-	CRYPT_Z990_KIMD = 0x0300,
-	CRYPT_Z990_KLMD = 0x0400,
-	CRYPT_Z990_KMAC = 0x0500
-};
-
-/*function codes for KM (CIPHER MESSAGE) instruction*/
-enum crypt_z990_km_func {
-	KM_QUERY            = CRYPT_Z990_KM | 0,
-	KM_DEA_ENCRYPT      = CRYPT_Z990_KM | 1,
-	KM_DEA_DECRYPT      = CRYPT_Z990_KM | 1 | 0x80, //modifier bit->decipher
-	KM_TDEA_128_ENCRYPT = CRYPT_Z990_KM | 2,
-	KM_TDEA_128_DECRYPT = CRYPT_Z990_KM | 2 | 0x80,
-	KM_TDEA_192_ENCRYPT = CRYPT_Z990_KM | 3,
-	KM_TDEA_192_DECRYPT = CRYPT_Z990_KM | 3 | 0x80,
-};
-
-/*function codes for KMC (CIPHER MESSAGE WITH CHAINING) instruction*/
-enum crypt_z990_kmc_func {
-	KMC_QUERY            = CRYPT_Z990_KMC | 0,
-	KMC_DEA_ENCRYPT      = CRYPT_Z990_KMC | 1,
-	KMC_DEA_DECRYPT      = CRYPT_Z990_KMC | 1 | 0x80, //modifier bit->decipher
-	KMC_TDEA_128_ENCRYPT = CRYPT_Z990_KMC | 2,
-	KMC_TDEA_128_DECRYPT = CRYPT_Z990_KMC | 2 | 0x80,
-	KMC_TDEA_192_ENCRYPT = CRYPT_Z990_KMC | 3,
-	KMC_TDEA_192_DECRYPT = CRYPT_Z990_KMC | 3 | 0x80,
-};
-
-/*function codes for KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST) instruction*/
-enum crypt_z990_kimd_func {
-	KIMD_QUERY   = CRYPT_Z990_KIMD | 0,
-	KIMD_SHA_1   = CRYPT_Z990_KIMD | 1,
-};
-
-/*function codes for KLMD (COMPUTE LAST MESSAGE DIGEST) instruction*/
-enum crypt_z990_klmd_func {
-	KLMD_QUERY   = CRYPT_Z990_KLMD | 0,
-	KLMD_SHA_1   = CRYPT_Z990_KLMD | 1,
-};
-
-/*function codes for KMAC (COMPUTE MESSAGE AUTHENTICATION CODE) instruction*/
-enum crypt_z990_kmac_func {
-	KMAC_QUERY    = CRYPT_Z990_KMAC | 0,
-	KMAC_DEA      = CRYPT_Z990_KMAC | 1,
-	KMAC_TDEA_128 = CRYPT_Z990_KMAC | 2,
-	KMAC_TDEA_192 = CRYPT_Z990_KMAC | 3
-};
-
-/*status word for z990 crypto instructions' QUERY functions*/
-struct crypt_z990_query_status {
-	u64 high;
-	u64 low;
-};
-
-/*
- * Standard fixup and ex_table sections for crypt_z990 inline functions.
- * label 0: the z990 crypto operation
- * label 1: just after 1 to catch illegal operation exception on non-z990
- * label 6: the return point after fixup
- * label 7: set error value if exception _in_ crypto operation
- * label 8: set error value if illegal operation exception
- * [ret] is the variable to receive the error code
- * [ERR] is the error code value
- */
-#ifndef __s390x__
-#define __crypt_z990_fixup \
-	".section .fixup,\"ax\" \n"	\
-	"7:	lhi	%0,%h[e1] \n"	\
-	"	bras	1,9f \n"	\
-	"	.long	6b \n"		\
-	"8:	lhi	%0,%h[e2] \n"	\
-	"	bras	1,9f \n"	\
-	"	.long	6b \n"		\
-	"9:	l	1,0(1) \n"	\
-	"	br	1 \n"		\
-	".previous \n"			\
-	".section __ex_table,\"a\" \n"	\
-	"	.align	4 \n"		\
-	"	.long	0b,7b \n"	\
-	"	.long	1b,8b \n"	\
-	".previous"
-#else /* __s390x__ */
-#define __crypt_z990_fixup \
-	".section .fixup,\"ax\" \n"	\
-	"7:	lhi	%0,%h[e1] \n"	\
-	"	jg	6b \n"		\
-	"8:	lhi	%0,%h[e2] \n"	\
-	"	jg	6b \n"		\
-	".previous\n"			\
-	".section __ex_table,\"a\" \n"	\
-	"	.align	8 \n"		\
-	"	.quad	0b,7b \n"	\
-	"	.quad	1b,8b \n"	\
-	".previous"
-#endif /* __s390x__ */
-
-/*
- * Standard code for setting the result of z990 crypto instructions.
- * %0: the register which will receive the result
- * [result]: the register containing the result (e.g. second operand length
- * to compute number of processed bytes].
- */
-#ifndef __s390x__
-#define __crypt_z990_set_result \
-	"	lr	%0,%[result] \n"
-#else /* __s390x__ */
-#define __crypt_z990_set_result \
-	"	lgr	%0,%[result] \n"
-#endif
-
-/*
- * Executes the KM (CIPHER MESSAGE) operation of the z990 CPU.
- * @param func: the function code passed to KM; see crypt_z990_km_func
- * @param param: address of parameter block; see POP for details on each func
- * @param dest: address of destination memory area
- * @param src: address of source memory area
- * @param src_len: length of src operand in bytes
- * @returns < zero for failure, 0 for the query func, number of processed bytes
- * 	for encryption/decryption funcs
- */
-static inline int
-crypt_z990_km(long func, void* param, u8* dest, const u8* src, long src_len)
-{
-	register long __func asm("0") = func & CRYPT_Z990_FUNC_MASK;
-	register void* __param asm("1") = param;
-	register u8* __dest asm("4") = dest;
-	register const u8* __src asm("2") = src;
-	register long __src_len asm("3") = src_len;
-	int ret;
-
-	ret = 0;
-	__asm__ __volatile__ (
-		"0:	.insn	rre,0xB92E0000,%1,%2 \n" //KM opcode
-		"1:	brc	1,0b \n" //handle partial completion
-		__crypt_z990_set_result
-		"6:	\n"
-		__crypt_z990_fixup
-		: "+d" (ret), "+a" (__dest), "+a" (__src),
-		  [result] "+d" (__src_len)
-		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
-		  "a" (__param)
-		: "cc", "memory"
-	);
-	if (ret >= 0 && func & CRYPT_Z990_FUNC_MASK){
-		ret = src_len - ret;
-	}
-	return ret;
-}
-
-/*
- * Executes the KMC (CIPHER MESSAGE WITH CHAINING) operation of the z990 CPU.
- * @param func: the function code passed to KM; see crypt_z990_kmc_func
- * @param param: address of parameter block; see POP for details on each func
- * @param dest: address of destination memory area
- * @param src: address of source memory area
- * @param src_len: length of src operand in bytes
- * @returns < zero for failure, 0 for the query func, number of processed bytes
- * 	for encryption/decryption funcs
- */
-static inline int
-crypt_z990_kmc(long func, void* param, u8* dest, const u8* src, long src_len)
-{
-	register long __func asm("0") = func & CRYPT_Z990_FUNC_MASK;
-	register void* __param asm("1") = param;
-	register u8* __dest asm("4") = dest;
-	register const u8* __src asm("2") = src;
-	register long __src_len asm("3") = src_len;
-	int ret;
-
-	ret = 0;
-	__asm__ __volatile__ (
-		"0:	.insn	rre,0xB92F0000,%1,%2 \n" //KMC opcode
-		"1:	brc	1,0b \n" //handle partial completion
-		__crypt_z990_set_result
-		"6:	\n"
-		__crypt_z990_fixup
-		: "+d" (ret), "+a" (__dest), "+a" (__src),
-		  [result] "+d" (__src_len)
-		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
-		  "a" (__param)
-		: "cc", "memory"
-	);
-	if (ret >= 0 && func & CRYPT_Z990_FUNC_MASK){
-		ret = src_len - ret;
-	}
-	return ret;
-}
-
-/*
- * Executes the KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST) operation
- * of the z990 CPU.
- * @param func: the function code passed to KM; see crypt_z990_kimd_func
- * @param param: address of parameter block; see POP for details on each func
- * @param src: address of source memory area
- * @param src_len: length of src operand in bytes
- * @returns < zero for failure, 0 for the query func, number of processed bytes
- * 	for digest funcs
- */
-static inline int
-crypt_z990_kimd(long func, void* param, const u8* src, long src_len)
-{
-	register long __func asm("0") = func & CRYPT_Z990_FUNC_MASK;
-	register void* __param asm("1") = param;
-	register const u8* __src asm("2") = src;
-	register long __src_len asm("3") = src_len;
-	int ret;
-
-	ret = 0;
-	__asm__ __volatile__ (
-		"0:	.insn	rre,0xB93E0000,%1,%1 \n" //KIMD opcode
-		"1:	brc	1,0b \n" /*handle partical completion of kimd*/
-		__crypt_z990_set_result
-		"6:	\n"
-		__crypt_z990_fixup
-		: "+d" (ret), "+a" (__src), [result] "+d" (__src_len)
-		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
-		  "a" (__param)
-		: "cc", "memory"
-	);
-	if (ret >= 0 && (func & CRYPT_Z990_FUNC_MASK)){
-		ret = src_len - ret;
-	}
-	return ret;
-}
-
-/*
- * Executes the KLMD (COMPUTE LAST MESSAGE DIGEST) operation of the z990 CPU.
- * @param func: the function code passed to KM; see crypt_z990_klmd_func
- * @param param: address of parameter block; see POP for details on each func
- * @param src: address of source memory area
- * @param src_len: length of src operand in bytes
- * @returns < zero for failure, 0 for the query func, number of processed bytes
- * 	for digest funcs
- */
-static inline int
-crypt_z990_klmd(long func, void* param, const u8* src, long src_len)
-{
-	register long __func asm("0") = func & CRYPT_Z990_FUNC_MASK;
-	register void* __param asm("1") = param;
-	register const u8* __src asm("2") = src;
-	register long __src_len asm("3") = src_len;
-	int ret;
-
-	ret = 0;
-	__asm__ __volatile__ (
-		"0:	.insn	rre,0xB93F0000,%1,%1 \n" //KLMD opcode
-		"1:	brc	1,0b \n" /*handle partical completion of klmd*/
-		__crypt_z990_set_result
-		"6:	\n"
-		__crypt_z990_fixup
-		: "+d" (ret), "+a" (__src), [result] "+d" (__src_len)
-		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
-		  "a" (__param)
-		: "cc", "memory"
-	);
-	if (ret >= 0 && func & CRYPT_Z990_FUNC_MASK){
-		ret = src_len - ret;
-	}
-	return ret;
-}
-
-/*
- * Executes the KMAC (COMPUTE MESSAGE AUTHENTICATION CODE) operation
- * of the z990 CPU.
- * @param func: the function code passed to KM; see crypt_z990_klmd_func
- * @param param: address of parameter block; see POP for details on each func
- * @param src: address of source memory area
- * @param src_len: length of src operand in bytes
- * @returns < zero for failure, 0 for the query func, number of processed bytes
- * 	for digest funcs
- */
-static inline int
-crypt_z990_kmac(long func, void* param, const u8* src, long src_len)
-{
-	register long __func asm("0") = func & CRYPT_Z990_FUNC_MASK;
-	register void* __param asm("1") = param;
-	register const u8* __src asm("2") = src;
-	register long __src_len asm("3") = src_len;
-	int ret;
-
-	ret = 0;
-	__asm__ __volatile__ (
-		"0:	.insn	rre,0xB91E0000,%5,%5 \n" //KMAC opcode
-		"1:	brc	1,0b \n" /*handle partical completion of klmd*/
-		__crypt_z990_set_result
-		"6:	\n"
-		__crypt_z990_fixup
-		: "+d" (ret), "+a" (__src), [result] "+d" (__src_len)
-		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
-		  "a" (__param)
-		: "cc", "memory"
-	);
-	if (ret >= 0 && func & CRYPT_Z990_FUNC_MASK){
-		ret = src_len - ret;
-	}
-	return ret;
-}
-
-/**
- * Tests if a specific z990 crypto function is implemented on the machine.
- * @param func:	the function code of the specific function; 0 if op in general
- * @return	1 if func available; 0 if func or op in general not available
- */
-static inline int
-crypt_z990_func_available(int func)
-{
-	int ret;
-
-	struct crypt_z990_query_status status = {
-		.high = 0,
-		.low = 0
-	};
-	switch (func & CRYPT_Z990_OP_MASK){
-		case CRYPT_Z990_KM:
-			ret = crypt_z990_km(KM_QUERY, &status, NULL, NULL, 0);
-			break;
-		case CRYPT_Z990_KMC:
-			ret = crypt_z990_kmc(KMC_QUERY, &status, NULL, NULL, 0);
-			break;
-		case CRYPT_Z990_KIMD:
-			ret = crypt_z990_kimd(KIMD_QUERY, &status, NULL, 0);
-			break;
-		case CRYPT_Z990_KLMD:
-			ret = crypt_z990_klmd(KLMD_QUERY, &status, NULL, 0);
-			break;
-		case CRYPT_Z990_KMAC:
-			ret = crypt_z990_kmac(KMAC_QUERY, &status, NULL, 0);
-			break;
-		default:
-			ret = 0;
-			return ret;
-	}
-	if (ret >= 0){
-		func &= CRYPT_Z990_FUNC_MASK;
-		func &= 0x7f; //mask modifier bit
-		if (func < 64){
-			ret = (status.high >> (64 - func - 1)) & 0x1;
-		} else {
-			ret = (status.low >> (128 - func - 1)) & 0x1;
-		}
-	} else {
-		ret = 0;
-	}
-	return ret;
-}
-
-
-#endif // _CRYPTO_ARCH_S390_CRYPT_Z990_H
diff -urpN linux-2.6/arch/s390/crypto/crypt_z990_query.c linux-2.6-patched/arch/s390/crypto/crypt_z990_query.c
--- linux-2.6/arch/s390/crypto/crypt_z990_query.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/crypto/crypt_z990_query.c	2005-12-09 14:24:26.000000000 +0100
@@ -1,111 +0,0 @@
-/*
- * Cryptographic API.
- *
- * Support for z990 cryptographic instructions.
- * Testing module for querying processor crypto capabilities.
- *
- * Copyright (c) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
- * Author(s): Thomas Spatzier (tspat@de.ibm.com)
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- */
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <asm/errno.h>
-#include "crypt_z990.h"
-
-static void
-query_available_functions(void)
-{
-	printk(KERN_INFO "#####################\n");
-	//query available KM functions
-	printk(KERN_INFO "KM_QUERY: %d\n",
-			crypt_z990_func_available(KM_QUERY));
-	printk(KERN_INFO "KM_DEA: %d\n",
-			crypt_z990_func_available(KM_DEA_ENCRYPT));
-	printk(KERN_INFO "KM_TDEA_128: %d\n",
-			crypt_z990_func_available(KM_TDEA_128_ENCRYPT));
-	printk(KERN_INFO "KM_TDEA_192: %d\n",
-			crypt_z990_func_available(KM_TDEA_192_ENCRYPT));
-	//query available KMC functions
-	printk(KERN_INFO "KMC_QUERY: %d\n",
-			crypt_z990_func_available(KMC_QUERY));
-	printk(KERN_INFO "KMC_DEA: %d\n",
-			crypt_z990_func_available(KMC_DEA_ENCRYPT));
-	printk(KERN_INFO "KMC_TDEA_128: %d\n",
-			crypt_z990_func_available(KMC_TDEA_128_ENCRYPT));
-	printk(KERN_INFO "KMC_TDEA_192: %d\n",
-			crypt_z990_func_available(KMC_TDEA_192_ENCRYPT));
-	//query available KIMD fucntions
-	printk(KERN_INFO "KIMD_QUERY: %d\n",
-			crypt_z990_func_available(KIMD_QUERY));
-	printk(KERN_INFO "KIMD_SHA_1: %d\n",
-			crypt_z990_func_available(KIMD_SHA_1));
-	//query available KLMD functions
-	printk(KERN_INFO "KLMD_QUERY: %d\n",
-			crypt_z990_func_available(KLMD_QUERY));
-	printk(KERN_INFO "KLMD_SHA_1: %d\n",
-			crypt_z990_func_available(KLMD_SHA_1));
-	//query available KMAC functions
-	printk(KERN_INFO "KMAC_QUERY: %d\n",
-			crypt_z990_func_available(KMAC_QUERY));
-	printk(KERN_INFO "KMAC_DEA: %d\n",
-			crypt_z990_func_available(KMAC_DEA));
-	printk(KERN_INFO "KMAC_TDEA_128: %d\n",
-			crypt_z990_func_available(KMAC_TDEA_128));
-	printk(KERN_INFO "KMAC_TDEA_192: %d\n",
-			crypt_z990_func_available(KMAC_TDEA_192));
-}
-
-static int
-init(void)
-{
-	struct crypt_z990_query_status status = {
-		.high = 0,
-		.low = 0
-	};
-
-	printk(KERN_INFO "crypt_z990: querying available crypto functions\n");
-	crypt_z990_km(KM_QUERY, &status, NULL, NULL, 0);
-	printk(KERN_INFO "KM: %016llx %016llx\n",
-			(unsigned long long) status.high,
-			(unsigned long long) status.low);
-	status.high = status.low = 0;
-	crypt_z990_kmc(KMC_QUERY, &status, NULL, NULL, 0);
-	printk(KERN_INFO "KMC: %016llx %016llx\n",
-			(unsigned long long) status.high,
-			(unsigned long long) status.low);
-	status.high = status.low = 0;
-	crypt_z990_kimd(KIMD_QUERY, &status, NULL, 0);
-	printk(KERN_INFO "KIMD: %016llx %016llx\n",
-			(unsigned long long) status.high,
-			(unsigned long long) status.low);
-	status.high = status.low = 0;
-	crypt_z990_klmd(KLMD_QUERY, &status, NULL, 0);
-	printk(KERN_INFO "KLMD: %016llx %016llx\n",
-			(unsigned long long) status.high,
-			(unsigned long long) status.low);
-	status.high = status.low = 0;
-	crypt_z990_kmac(KMAC_QUERY, &status, NULL, 0);
-	printk(KERN_INFO "KMAC: %016llx %016llx\n",
-			(unsigned long long) status.high,
-			(unsigned long long) status.low);
-
-	query_available_functions();
-	return -1;
-}
-
-static void __exit
-cleanup(void)
-{
-}
-
-module_init(init);
-module_exit(cleanup);
-
-MODULE_LICENSE("GPL");
diff -urpN linux-2.6/arch/s390/crypto/des_s390.c linux-2.6-patched/arch/s390/crypto/des_s390.c
--- linux-2.6/arch/s390/crypto/des_s390.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/des_s390.c	2005-12-09 14:24:26.000000000 +0100
@@ -0,0 +1,284 @@
+/*
+ * Cryptographic API.
+ *
+ * s390 implementation of the DES Cipher Algorithm.
+ *
+ * Copyright (c) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s): Thomas Spatzier (tspat@de.ibm.com)
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <asm/scatterlist.h>
+#include <linux/crypto.h>
+#include "crypt_s390.h"
+#include "crypto_des.h"
+
+#define DES_BLOCK_SIZE 8
+#define DES_KEY_SIZE 8
+
+#define DES3_128_KEY_SIZE	(2 * DES_KEY_SIZE)
+#define DES3_128_BLOCK_SIZE	DES_BLOCK_SIZE
+
+#define DES3_192_KEY_SIZE	(3 * DES_KEY_SIZE)
+#define DES3_192_BLOCK_SIZE	DES_BLOCK_SIZE
+
+struct crypt_s390_des_ctx {
+	u8 iv[DES_BLOCK_SIZE];
+	u8 key[DES_KEY_SIZE];
+};
+
+struct crypt_s390_des3_128_ctx {
+	u8 iv[DES_BLOCK_SIZE];
+	u8 key[DES3_128_KEY_SIZE];
+};
+
+struct crypt_s390_des3_192_ctx {
+	u8 iv[DES_BLOCK_SIZE];
+	u8 key[DES3_192_KEY_SIZE];
+};
+
+static int
+des_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+{
+	struct crypt_s390_des_ctx *dctx;
+	int ret;
+
+	dctx = ctx;
+	//test if key is valid (not a weak key)
+	ret = crypto_des_check_key(key, keylen, flags);
+	if (ret == 0){
+		memcpy(dctx->key, key, keylen);
+	}
+	return ret;
+}
+
+
+static void
+des_encrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	struct crypt_s390_des_ctx *dctx;
+
+	dctx = ctx;
+	crypt_s390_km(KM_DEA_ENCRYPT, dctx->key, dst, src, DES_BLOCK_SIZE);
+}
+
+static void
+des_decrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	struct crypt_s390_des_ctx *dctx;
+
+	dctx = ctx;
+	crypt_s390_km(KM_DEA_DECRYPT, dctx->key, dst, src, DES_BLOCK_SIZE);
+}
+
+static struct crypto_alg des_alg = {
+	.cra_name		=	"des",
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	DES_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct crypt_s390_des_ctx),
+	.cra_module		=	THIS_MODULE,
+	.cra_list		=	LIST_HEAD_INIT(des_alg.cra_list),
+	.cra_u			=	{ .cipher = {
+	.cia_min_keysize	=	DES_KEY_SIZE,
+	.cia_max_keysize	=	DES_KEY_SIZE,
+	.cia_setkey		= 	des_setkey,
+	.cia_encrypt		=	des_encrypt,
+	.cia_decrypt		=	des_decrypt } }
+};
+
+/*
+ * RFC2451:
+ *
+ *   For DES-EDE3, there is no known need to reject weak or
+ *   complementation keys.  Any weakness is obviated by the use of
+ *   multiple keys.
+ *
+ *   However, if the two  independent 64-bit keys are equal,
+ *   then the DES3 operation is simply the same as DES.
+ *   Implementers MUST reject keys that exhibit this property.
+ *
+ */
+static int
+des3_128_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+{
+	int i, ret;
+	struct crypt_s390_des3_128_ctx *dctx;
+	const u8* temp_key = key;
+
+	dctx = ctx;
+	if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE))) {
+
+		*flags |= CRYPTO_TFM_RES_BAD_KEY_SCHED;
+		return -EINVAL;
+	}
+	for (i = 0; i < 2; i++,	temp_key += DES_KEY_SIZE) {
+		ret = crypto_des_check_key(temp_key, DES_KEY_SIZE, flags);
+		if (ret < 0)
+			return ret;
+	}
+	memcpy(dctx->key, key, keylen);
+	return 0;
+}
+
+static void
+des3_128_encrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	struct crypt_s390_des3_128_ctx *dctx;
+
+	dctx = ctx;
+	crypt_s390_km(KM_TDEA_128_ENCRYPT, dctx->key, dst, (void*)src,
+			DES3_128_BLOCK_SIZE);
+}
+
+static void
+des3_128_decrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	struct crypt_s390_des3_128_ctx *dctx;
+
+	dctx = ctx;
+	crypt_s390_km(KM_TDEA_128_DECRYPT, dctx->key, dst, (void*)src,
+			DES3_128_BLOCK_SIZE);
+}
+
+static struct crypto_alg des3_128_alg = {
+	.cra_name		=	"des3_ede128",
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	DES3_128_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct crypt_s390_des3_128_ctx),
+	.cra_module		=	THIS_MODULE,
+	.cra_list		=	LIST_HEAD_INIT(des3_128_alg.cra_list),
+	.cra_u			=	{ .cipher = {
+	.cia_min_keysize	=	DES3_128_KEY_SIZE,
+	.cia_max_keysize	=	DES3_128_KEY_SIZE,
+	.cia_setkey		= 	des3_128_setkey,
+	.cia_encrypt		=	des3_128_encrypt,
+	.cia_decrypt		=	des3_128_decrypt } }
+};
+
+/*
+ * RFC2451:
+ *
+ *   For DES-EDE3, there is no known need to reject weak or
+ *   complementation keys.  Any weakness is obviated by the use of
+ *   multiple keys.
+ *
+ *   However, if the first two or last two independent 64-bit keys are
+ *   equal (k1 == k2 or k2 == k3), then the DES3 operation is simply the
+ *   same as DES.  Implementers MUST reject keys that exhibit this
+ *   property.
+ *
+ */
+static int
+des3_192_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+{
+	int i, ret;
+	struct crypt_s390_des3_192_ctx *dctx;
+	const u8* temp_key;
+
+	dctx = ctx;
+	temp_key = key;
+	if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE) &&
+	    memcmp(&key[DES_KEY_SIZE], &key[DES_KEY_SIZE * 2],
+	    					DES_KEY_SIZE))) {
+
+		*flags |= CRYPTO_TFM_RES_BAD_KEY_SCHED;
+		return -EINVAL;
+	}
+	for (i = 0; i < 3; i++, temp_key += DES_KEY_SIZE) {
+		ret = crypto_des_check_key(temp_key, DES_KEY_SIZE, flags);
+		if (ret < 0){
+			return ret;
+		}
+	}
+	memcpy(dctx->key, key, keylen);
+	return 0;
+}
+
+static void
+des3_192_encrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	struct crypt_s390_des3_192_ctx *dctx;
+
+	dctx = ctx;
+	crypt_s390_km(KM_TDEA_192_ENCRYPT, dctx->key, dst, (void*)src,
+			DES3_192_BLOCK_SIZE);
+}
+
+static void
+des3_192_decrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	struct crypt_s390_des3_192_ctx *dctx;
+
+	dctx = ctx;
+	crypt_s390_km(KM_TDEA_192_DECRYPT, dctx->key, dst, (void*)src,
+			DES3_192_BLOCK_SIZE);
+}
+
+static struct crypto_alg des3_192_alg = {
+	.cra_name		=	"des3_ede",
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	DES3_192_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct crypt_s390_des3_192_ctx),
+	.cra_module		=	THIS_MODULE,
+	.cra_list		=	LIST_HEAD_INIT(des3_192_alg.cra_list),
+	.cra_u			=	{ .cipher = {
+	.cia_min_keysize	=	DES3_192_KEY_SIZE,
+	.cia_max_keysize	=	DES3_192_KEY_SIZE,
+	.cia_setkey		= 	des3_192_setkey,
+	.cia_encrypt		=	des3_192_encrypt,
+	.cia_decrypt		=	des3_192_decrypt } }
+};
+
+
+
+static int
+init(void)
+{
+	int ret;
+
+	if (!crypt_s390_func_available(KM_DEA_ENCRYPT) ||
+	    !crypt_s390_func_available(KM_TDEA_128_ENCRYPT) ||
+	    !crypt_s390_func_available(KM_TDEA_192_ENCRYPT)){
+		return -ENOSYS;
+	}
+
+	ret = 0;
+	ret |= (crypto_register_alg(&des_alg) == 0)? 0:1;
+	ret |= (crypto_register_alg(&des3_128_alg) == 0)? 0:2;
+	ret |= (crypto_register_alg(&des3_192_alg) == 0)? 0:4;
+	if (ret){
+		crypto_unregister_alg(&des3_192_alg);
+		crypto_unregister_alg(&des3_128_alg);
+		crypto_unregister_alg(&des_alg);
+		return -EEXIST;
+	}
+
+	printk(KERN_INFO "crypt_s390: des_s390 loaded.\n");
+	return 0;
+}
+
+static void __exit
+fini(void)
+{
+	crypto_unregister_alg(&des3_192_alg);
+	crypto_unregister_alg(&des3_128_alg);
+	crypto_unregister_alg(&des_alg);
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_ALIAS("des");
+MODULE_ALIAS("des3_ede");
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DES & Triple DES EDE Cipher Algorithms");
diff -urpN linux-2.6/arch/s390/crypto/des_z990.c linux-2.6-patched/arch/s390/crypto/des_z990.c
--- linux-2.6/arch/s390/crypto/des_z990.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/crypto/des_z990.c	2005-12-09 14:24:26.000000000 +0100
@@ -1,284 +0,0 @@
-/*
- * Cryptographic API.
- *
- * z990 implementation of the DES Cipher Algorithm.
- *
- * Copyright (c) 2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
- * Author(s): Thomas Spatzier (tspat@de.ibm.com)
- *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/errno.h>
-#include <asm/scatterlist.h>
-#include <linux/crypto.h>
-#include "crypt_z990.h"
-#include "crypto_des.h"
-
-#define DES_BLOCK_SIZE 8
-#define DES_KEY_SIZE 8
-
-#define DES3_128_KEY_SIZE	(2 * DES_KEY_SIZE)
-#define DES3_128_BLOCK_SIZE	DES_BLOCK_SIZE
-
-#define DES3_192_KEY_SIZE	(3 * DES_KEY_SIZE)
-#define DES3_192_BLOCK_SIZE	DES_BLOCK_SIZE
-
-struct crypt_z990_des_ctx {
-	u8 iv[DES_BLOCK_SIZE];
-	u8 key[DES_KEY_SIZE];
-};
-
-struct crypt_z990_des3_128_ctx {
-	u8 iv[DES_BLOCK_SIZE];
-	u8 key[DES3_128_KEY_SIZE];
-};
-
-struct crypt_z990_des3_192_ctx {
-	u8 iv[DES_BLOCK_SIZE];
-	u8 key[DES3_192_KEY_SIZE];
-};
-
-static int
-des_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
-{
-	struct crypt_z990_des_ctx *dctx;
-	int ret;
-
-	dctx = ctx;
-	//test if key is valid (not a weak key)
-	ret = crypto_des_check_key(key, keylen, flags);
-	if (ret == 0){
-		memcpy(dctx->key, key, keylen);
-	}
-	return ret;
-}
-
-
-static void
-des_encrypt(void *ctx, u8 *dst, const u8 *src)
-{
-	struct crypt_z990_des_ctx *dctx;
-
-	dctx = ctx;
-	crypt_z990_km(KM_DEA_ENCRYPT, dctx->key, dst, src, DES_BLOCK_SIZE);
-}
-
-static void
-des_decrypt(void *ctx, u8 *dst, const u8 *src)
-{
-	struct crypt_z990_des_ctx *dctx;
-
-	dctx = ctx;
-	crypt_z990_km(KM_DEA_DECRYPT, dctx->key, dst, src, DES_BLOCK_SIZE);
-}
-
-static struct crypto_alg des_alg = {
-	.cra_name		=	"des",
-	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
-	.cra_blocksize		=	DES_BLOCK_SIZE,
-	.cra_ctxsize		=	sizeof(struct crypt_z990_des_ctx),
-	.cra_module		=	THIS_MODULE,
-	.cra_list		=	LIST_HEAD_INIT(des_alg.cra_list),
-	.cra_u			=	{ .cipher = {
-	.cia_min_keysize	=	DES_KEY_SIZE,
-	.cia_max_keysize	=	DES_KEY_SIZE,
-	.cia_setkey		= 	des_setkey,
-	.cia_encrypt		=	des_encrypt,
-	.cia_decrypt		=	des_decrypt } }
-};
-
-/*
- * RFC2451:
- *
- *   For DES-EDE3, there is no known need to reject weak or
- *   complementation keys.  Any weakness is obviated by the use of
- *   multiple keys.
- *
- *   However, if the two  independent 64-bit keys are equal,
- *   then the DES3 operation is simply the same as DES.
- *   Implementers MUST reject keys that exhibit this property.
- *
- */
-static int
-des3_128_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
-{
-	int i, ret;
-	struct crypt_z990_des3_128_ctx *dctx;
-	const u8* temp_key = key;
-
-	dctx = ctx;
-	if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE))) {
-
-		*flags |= CRYPTO_TFM_RES_BAD_KEY_SCHED;
-		return -EINVAL;
-	}
-	for (i = 0; i < 2; i++,	temp_key += DES_KEY_SIZE) {
-		ret = crypto_des_check_key(temp_key, DES_KEY_SIZE, flags);
-		if (ret < 0)
-			return ret;
-	}
-	memcpy(dctx->key, key, keylen);
-	return 0;
-}
-
-static void
-des3_128_encrypt(void *ctx, u8 *dst, const u8 *src)
-{
-	struct crypt_z990_des3_128_ctx *dctx;
-
-	dctx = ctx;
-	crypt_z990_km(KM_TDEA_128_ENCRYPT, dctx->key, dst, (void*)src,
-			DES3_128_BLOCK_SIZE);
-}
-
-static void
-des3_128_decrypt(void *ctx, u8 *dst, const u8 *src)
-{
-	struct crypt_z990_des3_128_ctx *dctx;
-
-	dctx = ctx;
-	crypt_z990_km(KM_TDEA_128_DECRYPT, dctx->key, dst, (void*)src,
-			DES3_128_BLOCK_SIZE);
-}
-
-static struct crypto_alg des3_128_alg = {
-	.cra_name		=	"des3_ede128",
-	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
-	.cra_blocksize		=	DES3_128_BLOCK_SIZE,
-	.cra_ctxsize		=	sizeof(struct crypt_z990_des3_128_ctx),
-	.cra_module		=	THIS_MODULE,
-	.cra_list		=	LIST_HEAD_INIT(des3_128_alg.cra_list),
-	.cra_u			=	{ .cipher = {
-	.cia_min_keysize	=	DES3_128_KEY_SIZE,
-	.cia_max_keysize	=	DES3_128_KEY_SIZE,
-	.cia_setkey		= 	des3_128_setkey,
-	.cia_encrypt		=	des3_128_encrypt,
-	.cia_decrypt		=	des3_128_decrypt } }
-};
-
-/*
- * RFC2451:
- *
- *   For DES-EDE3, there is no known need to reject weak or
- *   complementation keys.  Any weakness is obviated by the use of
- *   multiple keys.
- *
- *   However, if the first two or last two independent 64-bit keys are
- *   equal (k1 == k2 or k2 == k3), then the DES3 operation is simply the
- *   same as DES.  Implementers MUST reject keys that exhibit this
- *   property.
- *
- */
-static int
-des3_192_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
-{
-	int i, ret;
-	struct crypt_z990_des3_192_ctx *dctx;
-	const u8* temp_key;
-
-	dctx = ctx;
-	temp_key = key;
-	if (!(memcmp(key, &key[DES_KEY_SIZE], DES_KEY_SIZE) &&
-	    memcmp(&key[DES_KEY_SIZE], &key[DES_KEY_SIZE * 2],
-	    					DES_KEY_SIZE))) {
-
-		*flags |= CRYPTO_TFM_RES_BAD_KEY_SCHED;
-		return -EINVAL;
-	}
-	for (i = 0; i < 3; i++, temp_key += DES_KEY_SIZE) {
-		ret = crypto_des_check_key(temp_key, DES_KEY_SIZE, flags);
-		if (ret < 0){
-			return ret;
-		}
-	}
-	memcpy(dctx->key, key, keylen);
-	return 0;
-}
-
-static void
-des3_192_encrypt(void *ctx, u8 *dst, const u8 *src)
-{
-	struct crypt_z990_des3_192_ctx *dctx;
-
-	dctx = ctx;
-	crypt_z990_km(KM_TDEA_192_ENCRYPT, dctx->key, dst, (void*)src,
-			DES3_192_BLOCK_SIZE);
-}
-
-static void
-des3_192_decrypt(void *ctx, u8 *dst, const u8 *src)
-{
-	struct crypt_z990_des3_192_ctx *dctx;
-
-	dctx = ctx;
-	crypt_z990_km(KM_TDEA_192_DECRYPT, dctx->key, dst, (void*)src,
-			DES3_192_BLOCK_SIZE);
-}
-
-static struct crypto_alg des3_192_alg = {
-	.cra_name		=	"des3_ede",
-	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
-	.cra_blocksize		=	DES3_192_BLOCK_SIZE,
-	.cra_ctxsize		=	sizeof(struct crypt_z990_des3_192_ctx),
-	.cra_module		=	THIS_MODULE,
-	.cra_list		=	LIST_HEAD_INIT(des3_192_alg.cra_list),
-	.cra_u			=	{ .cipher = {
-	.cia_min_keysize	=	DES3_192_KEY_SIZE,
-	.cia_max_keysize	=	DES3_192_KEY_SIZE,
-	.cia_setkey		= 	des3_192_setkey,
-	.cia_encrypt		=	des3_192_encrypt,
-	.cia_decrypt		=	des3_192_decrypt } }
-};
-
-
-
-static int
-init(void)
-{
-	int ret;
-
-	if (!crypt_z990_func_available(KM_DEA_ENCRYPT) ||
-	    !crypt_z990_func_available(KM_TDEA_128_ENCRYPT) ||
-	    !crypt_z990_func_available(KM_TDEA_192_ENCRYPT)){
-		return -ENOSYS;
-	}
-
-	ret = 0;
-	ret |= (crypto_register_alg(&des_alg) == 0)? 0:1;
-	ret |= (crypto_register_alg(&des3_128_alg) == 0)? 0:2;
-	ret |= (crypto_register_alg(&des3_192_alg) == 0)? 0:4;
-	if (ret){
-		crypto_unregister_alg(&des3_192_alg);
-		crypto_unregister_alg(&des3_128_alg);
-		crypto_unregister_alg(&des_alg);
-		return -EEXIST;
-	}
-
-	printk(KERN_INFO "crypt_z990: des_z990 loaded.\n");
-	return 0;
-}
-
-static void __exit
-fini(void)
-{
-	crypto_unregister_alg(&des3_192_alg);
-	crypto_unregister_alg(&des3_128_alg);
-	crypto_unregister_alg(&des_alg);
-}
-
-module_init(init);
-module_exit(fini);
-
-MODULE_ALIAS("des");
-MODULE_ALIAS("des3_ede");
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("DES & Triple DES EDE Cipher Algorithms");
diff -urpN linux-2.6/arch/s390/crypto/Makefile linux-2.6-patched/arch/s390/crypto/Makefile
--- linux-2.6/arch/s390/crypto/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/crypto/Makefile	2005-12-09 14:24:26.000000000 +0100
@@ -2,7 +2,7 @@
 # Cryptographic API
 #
 
-obj-$(CONFIG_CRYPTO_SHA1_Z990) += sha1_z990.o
-obj-$(CONFIG_CRYPTO_DES_Z990) += des_z990.o des_check_key.o
+obj-$(CONFIG_CRYPTO_SHA1_S390) += sha1_s390.o
+obj-$(CONFIG_CRYPTO_DES_S390) += des_s390.o des_check_key.o
 
-obj-$(CONFIG_CRYPTO_TEST) += crypt_z990_query.o
+obj-$(CONFIG_CRYPTO_TEST) += crypt_s390_query.o
diff -urpN linux-2.6/arch/s390/crypto/sha1_s390.c linux-2.6-patched/arch/s390/crypto/sha1_s390.c
--- linux-2.6/arch/s390/crypto/sha1_s390.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/crypto/sha1_s390.c	2005-12-09 14:24:26.000000000 +0100
@@ -0,0 +1,167 @@
+/*
+ * Cryptographic API.
+ *
+ * s390 implementation of the SHA1 Secure Hash Algorithm.
+ *
+ * Derived from cryptoapi implementation, adapted for in-place
+ * scatterlist interface.  Originally based on the public domain
+ * implementation written by Steve Reid.
+ *
+ * s390 Version:
+ *   Copyright (C) 2003 IBM Deutschland GmbH, IBM Corporation
+ *   Author(s): Thomas Spatzier (tspat@de.ibm.com)
+ *
+ * Derived from "crypto/sha1.c"
+ *   Copyright (c) Alan Smithee.
+ *   Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
+ *   Copyright (c) Jean-Francois Dive <jef@linuxbe.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/crypto.h>
+#include <asm/scatterlist.h>
+#include <asm/byteorder.h>
+#include "crypt_s390.h"
+
+#define SHA1_DIGEST_SIZE	20
+#define SHA1_BLOCK_SIZE		64
+
+struct crypt_s390_sha1_ctx {
+	u64 count;
+	u32 state[5];
+	u32 buf_len;
+	u8 buffer[2 * SHA1_BLOCK_SIZE];
+};
+
+static void
+sha1_init(void *ctx)
+{
+	static const struct crypt_s390_sha1_ctx initstate = {
+		.state = {
+			0x67452301,
+			0xEFCDAB89,
+			0x98BADCFE,
+			0x10325476,
+			0xC3D2E1F0
+		},
+	};
+	memcpy(ctx, &initstate, sizeof(initstate));
+}
+
+static void
+sha1_update(void *ctx, const u8 *data, unsigned int len)
+{
+	struct crypt_s390_sha1_ctx *sctx;
+	long imd_len;
+
+	sctx = ctx;
+	sctx->count += len * 8; //message bit length
+
+	//anything in buffer yet? -> must be completed
+	if (sctx->buf_len && (sctx->buf_len + len) >= SHA1_BLOCK_SIZE) {
+		//complete full block and hash
+		memcpy(sctx->buffer + sctx->buf_len, data,
+				SHA1_BLOCK_SIZE - sctx->buf_len);
+		crypt_s390_kimd(KIMD_SHA_1, sctx->state, sctx->buffer,
+				SHA1_BLOCK_SIZE);
+		data += SHA1_BLOCK_SIZE - sctx->buf_len;
+		len -= SHA1_BLOCK_SIZE - sctx->buf_len;
+		sctx->buf_len = 0;
+	}
+
+	//rest of data contains full blocks?
+	imd_len = len & ~0x3ful;
+	if (imd_len){
+		crypt_s390_kimd(KIMD_SHA_1, sctx->state, data, imd_len);
+		data += imd_len;
+		len -= imd_len;
+	}
+	//anything left? store in buffer
+	if (len){
+		memcpy(sctx->buffer + sctx->buf_len , data, len);
+		sctx->buf_len += len;
+	}
+}
+
+
+static void
+pad_message(struct crypt_s390_sha1_ctx* sctx)
+{
+	int index;
+
+	index = sctx->buf_len;
+	sctx->buf_len = (sctx->buf_len < 56)?
+		SHA1_BLOCK_SIZE:2 * SHA1_BLOCK_SIZE;
+	//start pad with 1
+	sctx->buffer[index] = 0x80;
+	//pad with zeros
+	index++;
+	memset(sctx->buffer + index, 0x00, sctx->buf_len - index);
+	//append length
+	memcpy(sctx->buffer + sctx->buf_len - 8, &sctx->count,
+			sizeof sctx->count);
+}
+
+/* Add padding and return the message digest. */
+static void
+sha1_final(void* ctx, u8 *out)
+{
+	struct crypt_s390_sha1_ctx *sctx = ctx;
+
+	//must perform manual padding
+	pad_message(sctx);
+	crypt_s390_kimd(KIMD_SHA_1, sctx->state, sctx->buffer, sctx->buf_len);
+	//copy digest to out
+	memcpy(out, sctx->state, SHA1_DIGEST_SIZE);
+	/* Wipe context */
+	memset(sctx, 0, sizeof *sctx);
+}
+
+static struct crypto_alg alg = {
+	.cra_name	=	"sha1",
+	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
+	.cra_blocksize	=	SHA1_BLOCK_SIZE,
+	.cra_ctxsize	=	sizeof(struct crypt_s390_sha1_ctx),
+	.cra_module	=	THIS_MODULE,
+	.cra_list       =       LIST_HEAD_INIT(alg.cra_list),
+	.cra_u		=	{ .digest = {
+	.dia_digestsize	=	SHA1_DIGEST_SIZE,
+	.dia_init   	= 	sha1_init,
+	.dia_update 	=	sha1_update,
+	.dia_final  	=	sha1_final } }
+};
+
+static int
+init(void)
+{
+	int ret = -ENOSYS;
+
+	if (crypt_s390_func_available(KIMD_SHA_1)){
+		ret = crypto_register_alg(&alg);
+		if (ret == 0){
+			printk(KERN_INFO "crypt_s390: sha1_s390 loaded.\n");
+		}
+	}
+	return ret;
+}
+
+static void __exit
+fini(void)
+{
+	crypto_unregister_alg(&alg);
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_ALIAS("sha1");
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA1 Secure Hash Algorithm");
diff -urpN linux-2.6/arch/s390/crypto/sha1_z990.c linux-2.6-patched/arch/s390/crypto/sha1_z990.c
--- linux-2.6/arch/s390/crypto/sha1_z990.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/arch/s390/crypto/sha1_z990.c	2005-12-09 14:24:26.000000000 +0100
@@ -1,167 +0,0 @@
-/*
- * Cryptographic API.
- *
- * z990 implementation of the SHA1 Secure Hash Algorithm.
- *
- * Derived from cryptoapi implementation, adapted for in-place
- * scatterlist interface.  Originally based on the public domain
- * implementation written by Steve Reid.
- *
- * s390 Version:
- *   Copyright (C) 2003 IBM Deutschland GmbH, IBM Corporation
- *   Author(s): Thomas Spatzier (tspat@de.ibm.com)
- *
- * Derived from "crypto/sha1.c"
- *   Copyright (c) Alan Smithee.
- *   Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
- *   Copyright (c) Jean-Francois Dive <jef@linuxbe.org>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- *
- */
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/crypto.h>
-#include <asm/scatterlist.h>
-#include <asm/byteorder.h>
-#include "crypt_z990.h"
-
-#define SHA1_DIGEST_SIZE	20
-#define SHA1_BLOCK_SIZE		64
-
-struct crypt_z990_sha1_ctx {
-        u64 count;
-        u32 state[5];
-	u32 buf_len;
-        u8 buffer[2 * SHA1_BLOCK_SIZE];
-};
-
-static void
-sha1_init(void *ctx)
-{
-	static const struct crypt_z990_sha1_ctx initstate = {
-		.state = {
-			0x67452301,
-			0xEFCDAB89,
-			0x98BADCFE,
-			0x10325476,
-			0xC3D2E1F0
-		},
-	};
-	memcpy(ctx, &initstate, sizeof(initstate));
-}
-
-static void
-sha1_update(void *ctx, const u8 *data, unsigned int len)
-{
-	struct crypt_z990_sha1_ctx *sctx;
-	long imd_len;
-
-	sctx = ctx;
-	sctx->count += len * 8; //message bit length
-
-	//anything in buffer yet? -> must be completed
-	if (sctx->buf_len && (sctx->buf_len + len) >= SHA1_BLOCK_SIZE) {
-		//complete full block and hash
-		memcpy(sctx->buffer + sctx->buf_len, data,
-				SHA1_BLOCK_SIZE - sctx->buf_len);
-		crypt_z990_kimd(KIMD_SHA_1, sctx->state, sctx->buffer,
-				SHA1_BLOCK_SIZE);
-		data += SHA1_BLOCK_SIZE - sctx->buf_len;
-		len -= SHA1_BLOCK_SIZE - sctx->buf_len;
-		sctx->buf_len = 0;
-	}
-
-	//rest of data contains full blocks?
-	imd_len = len & ~0x3ful;
-	if (imd_len){
-		crypt_z990_kimd(KIMD_SHA_1, sctx->state, data, imd_len);
-		data += imd_len;
-		len -= imd_len;
-	}
-	//anything left? store in buffer
-	if (len){
-		memcpy(sctx->buffer + sctx->buf_len , data, len);
-		sctx->buf_len += len;
-	}
-}
-
-
-static void
-pad_message(struct crypt_z990_sha1_ctx* sctx)
-{
-	int index;
-
-	index = sctx->buf_len;
-	sctx->buf_len = (sctx->buf_len < 56)?
-		SHA1_BLOCK_SIZE:2 * SHA1_BLOCK_SIZE;
-	//start pad with 1
-	sctx->buffer[index] = 0x80;
-	//pad with zeros
-	index++;
-	memset(sctx->buffer + index, 0x00, sctx->buf_len - index);
-	//append length
-	memcpy(sctx->buffer + sctx->buf_len - 8, &sctx->count,
-			sizeof sctx->count);
-}
-
-/* Add padding and return the message digest. */
-static void
-sha1_final(void* ctx, u8 *out)
-{
-	struct crypt_z990_sha1_ctx *sctx = ctx;
-
-	//must perform manual padding
-	pad_message(sctx);
-	crypt_z990_kimd(KIMD_SHA_1, sctx->state, sctx->buffer, sctx->buf_len);
-	//copy digest to out
-	memcpy(out, sctx->state, SHA1_DIGEST_SIZE);
-	/* Wipe context */
-	memset(sctx, 0, sizeof *sctx);
-}
-
-static struct crypto_alg alg = {
-	.cra_name	=	"sha1",
-	.cra_flags	=	CRYPTO_ALG_TYPE_DIGEST,
-	.cra_blocksize	=	SHA1_BLOCK_SIZE,
-	.cra_ctxsize	=	sizeof(struct crypt_z990_sha1_ctx),
-	.cra_module	=	THIS_MODULE,
-	.cra_list       =       LIST_HEAD_INIT(alg.cra_list),
-	.cra_u		=	{ .digest = {
-	.dia_digestsize	=	SHA1_DIGEST_SIZE,
-	.dia_init   	= 	sha1_init,
-	.dia_update 	=	sha1_update,
-	.dia_final  	=	sha1_final } }
-};
-
-static int
-init(void)
-{
-	int ret = -ENOSYS;
-
-	if (crypt_z990_func_available(KIMD_SHA_1)){
-		ret = crypto_register_alg(&alg);
-		if (ret == 0){
-			printk(KERN_INFO "crypt_z990: sha1_z990 loaded.\n");
-		}
-	}
-	return ret;
-}
-
-static void __exit
-fini(void)
-{
-	crypto_unregister_alg(&alg);
-}
-
-module_init(init);
-module_exit(fini);
-
-MODULE_ALIAS("sha1");
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("SHA1 Secure Hash Algorithm");
diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-12-09 14:24:19.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2005-12-09 14:25:05.000000000 +0100
@@ -632,13 +632,13 @@ CONFIG_CRYPTO=y
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
 # CONFIG_CRYPTO_SHA1 is not set
-# CONFIG_CRYPTO_SHA1_Z990 is not set
+# CONFIG_CRYPTO_SHA1_S390 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
 # CONFIG_CRYPTO_DES is not set
-# CONFIG_CRYPTO_DES_Z990 is not set
+# CONFIG_CRYPTO_DES_S390 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
diff -urpN linux-2.6/crypto/Kconfig linux-2.6-patched/crypto/Kconfig
--- linux-2.6/crypto/Kconfig	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6-patched/crypto/Kconfig	2005-12-09 14:24:26.000000000 +0100
@@ -40,8 +40,8 @@ config CRYPTO_SHA1
 	help
 	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
 
-config CRYPTO_SHA1_Z990
-	tristate "SHA1 digest algorithm for IBM zSeries z990"
+config CRYPTO_SHA1_S390
+	tristate "SHA1 digest algorithm (s390)"
 	depends on CRYPTO && ARCH_S390
 	help
 	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
@@ -98,8 +98,8 @@ config CRYPTO_DES
 	help
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
 
-config CRYPTO_DES_Z990
-	tristate "DES and Triple DES cipher algorithms for IBM zSeries z990"
+config CRYPTO_DES_S390
+	tristate "DES and Triple DES cipher algorithms (s390)"
 	depends on CRYPTO && ARCH_S390
 	help
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
