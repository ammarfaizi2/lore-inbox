Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263125AbUDUO7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUDUO7j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263040AbUDUO7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:59:39 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:44997 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S263168AbUDUOti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:49:38 -0400
Date: Wed, 21 Apr 2004 16:49:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (8/9): crypto api.
Message-ID: <20040421144920.GI2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: crypto api.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add support for z990 crypto instructions to in-kernel crypto api.

diffstat:
 Documentation/s390/crypto/crypto-API.txt |   83 ++++++
 arch/s390/Makefile                       |    2 
 arch/s390/crypto/Makefile                |    8 
 arch/s390/crypto/crypt_z990.h            |  374 +++++++++++++++++++++++++++++++
 arch/s390/crypto/crypt_z990_query.c      |  111 +++++++++
 arch/s390/crypto/crypto_des.h            |   18 +
 arch/s390/crypto/des_check_key.c         |  130 ++++++++++
 arch/s390/crypto/des_z990.c              |  284 +++++++++++++++++++++++
 arch/s390/crypto/sha1_z990.c             |  167 +++++++++++++
 arch/s390/defconfig                      |    2 
 crypto/Kconfig                           |   12 
 11 files changed, 1190 insertions(+), 1 deletion(-)

diff -urN linux-2.6/Documentation/s390/crypto/crypto-API.txt linux-2.6-s390/Documentation/s390/crypto/crypto-API.txt
--- linux-2.6/Documentation/s390/crypto/crypto-API.txt	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/Documentation/s390/crypto/crypto-API.txt	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,83 @@
+crypto-API support for z990 Message Security Assist (MSA) instructions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+AUTHOR:	Thomas Spatzier (tspat@de.ibm.com)
+
+
+1. Introduction crypto-API
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+See Documentation/crypto/api-intro.txt for an introduction/description of the
+kernel crypto API.
+According to api-intro.txt support for z990 crypto instructions has been added
+in the algorithm api layer of the crypto API. Several files containing z990
+optimized implementations of crypto algorithms are placed in the
+arch/s390/crypto directory.
+
+
+2. Probing for availability of MSA
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+It should be possible to use Kernels with the z990 crypto implementations both
+on machines with MSA available an on those without MSA (pre z990 or z990
+without MSA). Therefore a simple probing mechanisms has been implemented:
+In the init function of each crypto module the availability of MSA and of the
+respective crypto algorithm in particular will be tested. If the algorithm is
+available the module will load and register its algorithm with the crypto API.
+
+If the respective crypto algorithm is not available, the init function will
+return -ENOSYS. In that case a fallback to the standard software implementation
+of the crypto algorithm must be taken ( -> the standard crypto modules are
+also build when compiling the kernel).
+
+
+3. Ensuring z990 crypto module preference
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+If z990 crypto instructions are available the optimized modules should be
+preferred instead of standard modules.
+
+3.1. compiled-in modules
+~~~~~~~~~~~~~~~~~~~~~~~~
+For compiled-in modules it has to be ensured that the z990 modules are linked
+before the standard crypto modules. Then, on system startup the init functions
+of z990 crypto modules will be called first and query for availability of z990
+crypto instructions. If instruction is available, the z990 module will register
+its crypto algorithm implementation -> the load of the standard module will fail
+since the algorithm is already registered.
+If z990 crypto instruction is not available the load of the z990 module will
+fail -> the standard module will load and register its algorithm.
+
+3.2. dynamic modules
+~~~~~~~~~~~~~~~~~~~~
+A system administrator has to take care of giving preference to z990 crypto
+modules. If MSA is available appropriate lines have to be added to
+/etc/modprobe.conf.
+
+Example:	z990 crypto instruction for SHA1 algorithm is available
+
+		add the following line to /etc/modprobe.conf (assuming the
+		z990 crypto modules for SHA1 is called sha1_z990):
+
+		alias sha1 sha1_z990
+
+		-> when the sha1 algorithm is requested through the crypto API
+		(which has a module autoloader) the z990 module will be loaded.
+
+TBD:	a userspace module probin mechanism
+	something like 'probe sha1 sha1_z990 sha1' in modprobe.conf
+	-> try module sha1_z990, if it fails to load load standard module sha1
+	the 'probe' statement is currently not supported in modprobe.conf
+
+
+4. Currently implemented z990 crypto algorithms
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The following crypto algorithms with z990 MSA support are currently implemented.
+The name of each algorithm under which it is registered in crypto API and the
+name of the respective module is given in square brackets.
+
+- SHA1 Digest Algorithm [sha1 -> sha1_z990]
+- DES Encrypt/Decrypt Algorithm (64bit key) [des -> des_z990]
+- Tripple DES Encrypt/Decrypt Algorithm (128bit key) [des3_ede128 -> des_z990]
+- Tripple DES Encrypt/Decrypt Algorithm (192bit key) [des3_ede -> des_z990]
+
+In order to load, for example, the sha1_z990 module when the sha1 algorithm is
+requested (see 3.2.) add 'alias sha1 sha1_z990' to /etc/modprobe.conf.
+
diff -urN linux-2.6/arch/s390/Makefile linux-2.6-s390/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	Wed Apr 21 16:29:40 2004
+++ linux-2.6-s390/arch/s390/Makefile	Wed Apr 21 16:29:40 2004
@@ -44,7 +44,7 @@
 head-$(CONFIG_ARCH_S390X)	+= arch/$(ARCH)/kernel/head64.o
 head-y				+= arch/$(ARCH)/kernel/init_task.o
 
-core-y		+= arch/$(ARCH)/mm/ arch/$(ARCH)/kernel/ \
+core-y		+= arch/$(ARCH)/mm/ arch/$(ARCH)/kernel/ arch/$(ARCH)/crypto/ \
 		   arch/$(ARCH)/appldata/
 libs-y		+= arch/$(ARCH)/lib/
 drivers-y	+= drivers/s390/
diff -urN linux-2.6/arch/s390/crypto/Makefile linux-2.6-s390/arch/s390/crypto/Makefile
--- linux-2.6/arch/s390/crypto/Makefile	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/crypto/Makefile	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,8 @@
+#
+# Cryptographic API
+#
+
+obj-$(CONFIG_CRYPTO_SHA1_Z990) += sha1_z990.o
+obj-$(CONFIG_CRYPTO_DES_Z990) += des_z990.o des_check_key.o
+
+obj-$(CONFIG_CRYPTO_TEST) += crypt_z990_query.o
diff -urN linux-2.6/arch/s390/crypto/crypt_z990.h linux-2.6-s390/arch/s390/crypto/crypt_z990.h
--- linux-2.6/arch/s390/crypto/crypt_z990.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/crypto/crypt_z990.h	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,374 @@
+/*
+ * Cryptographic API.
+ *
+ * Support for z990 cryptographic instructions.
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
+#ifndef _CRYPTO_ARCH_S390_CRYPT_Z990_H
+#define _CRYPTO_ARCH_S390_CRYPT_Z990_H
+
+#include <asm/errno.h>
+
+#define CRYPT_Z990_OP_MASK 0xFF00
+#define CRYPT_Z990_FUNC_MASK 0x00FF
+
+
+/*z990 cryptographic operations*/
+enum crypt_z990_operations {
+	CRYPT_Z990_KM   = 0x0100,
+	CRYPT_Z990_KMC  = 0x0200,
+	CRYPT_Z990_KIMD = 0x0300,
+	CRYPT_Z990_KLMD = 0x0400,
+	CRYPT_Z990_KMAC = 0x0500
+};
+
+/*function codes for KM (CIPHER MESSAGE) instruction*/
+enum crypt_z990_km_func {
+	KM_QUERY            = CRYPT_Z990_KM | 0,
+	KM_DEA_ENCRYPT      = CRYPT_Z990_KM | 1,
+	KM_DEA_DECRYPT      = CRYPT_Z990_KM | 1 | 0x80, //modifier bit->decipher
+	KM_TDEA_128_ENCRYPT = CRYPT_Z990_KM | 2,
+	KM_TDEA_128_DECRYPT = CRYPT_Z990_KM | 2 | 0x80,
+	KM_TDEA_192_ENCRYPT = CRYPT_Z990_KM | 3,
+	KM_TDEA_192_DECRYPT = CRYPT_Z990_KM | 3 | 0x80,
+};
+
+/*function codes for KMC (CIPHER MESSAGE WITH CHAINING) instruction*/
+enum crypt_z990_kmc_func {
+	KMC_QUERY            = CRYPT_Z990_KMC | 0,
+	KMC_DEA_ENCRYPT      = CRYPT_Z990_KMC | 1,
+	KMC_DEA_DECRYPT      = CRYPT_Z990_KMC | 1 | 0x80, //modifier bit->decipher
+	KMC_TDEA_128_ENCRYPT = CRYPT_Z990_KMC | 2,
+	KMC_TDEA_128_DECRYPT = CRYPT_Z990_KMC | 2 | 0x80,
+	KMC_TDEA_192_ENCRYPT = CRYPT_Z990_KMC | 3,
+	KMC_TDEA_192_DECRYPT = CRYPT_Z990_KMC | 3 | 0x80,
+};
+
+/*function codes for KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST) instruction*/
+enum crypt_z990_kimd_func {
+	KIMD_QUERY   = CRYPT_Z990_KIMD | 0,
+	KIMD_SHA_1   = CRYPT_Z990_KIMD | 1,
+};
+
+/*function codes for KLMD (COMPUTE LAST MESSAGE DIGEST) instruction*/
+enum crypt_z990_klmd_func {
+	KLMD_QUERY   = CRYPT_Z990_KLMD | 0,
+	KLMD_SHA_1   = CRYPT_Z990_KLMD | 1,
+};
+
+/*function codes for KMAC (COMPUTE MESSAGE AUTHENTICATION CODE) instruction*/
+enum crypt_z990_kmac_func {
+	KMAC_QUERY    = CRYPT_Z990_KMAC | 0,
+	KMAC_DEA      = CRYPT_Z990_KMAC | 1,
+	KMAC_TDEA_128 = CRYPT_Z990_KMAC | 2,
+	KMAC_TDEA_192 = CRYPT_Z990_KMAC | 3
+};
+
+/*status word for z990 crypto instructions' QUERY functions*/ 
+struct crypt_z990_query_status {
+	u64 high;
+	u64 low;
+};
+
+/*
+ * Standard fixup and ex_table sections for crypt_z990 inline functions.
+ * label 0: the z990 crypto operation
+ * label 1: just after 1 to catch illegal operation exception on non-z990
+ * label 6: the return point after fixup
+ * label 7: set error value if exception _in_ crypto operation
+ * label 8: set error value if illegal operation exception
+ * [ret] is the variable to receive the error code
+ * [ERR] is the error code value
+ */
+#ifndef __s390x__
+#define __crypt_z990_fixup \
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
+#define __crypt_z990_fixup \
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
+ * Standard code for setting the result of z990 crypto instructions.
+ * %0: the register which will receive the result
+ * [result]: the register containing the result (e.g. second operand length
+ * to compute number of processed bytes].
+ */
+#ifndef __s390x__
+#define __crypt_z990_set_result \
+	"	lr	%0,%[result] \n"
+#else /* __s390x__ */
+#define __crypt_z990_set_result \
+	"	lgr	%0,%[result] \n"
+#endif
+
+/*
+ * Executes the KM (CIPHER MESSAGE) operation of the z990 CPU.
+ * @param func: the function code passed to KM; see crypt_z990_km_func
+ * @param param: address of parameter block; see POP for details on each func
+ * @param dest: address of destination memory area
+ * @param src: address of source memory area
+ * @param src_len: length of src operand in bytes
+ * @returns < zero for failure, 0 for the query func, number of processed bytes
+ * 	for encryption/decryption funcs
+ */
+static inline int
+crypt_z990_km(long func, void* param, u8* dest, const u8* src, long src_len)
+{
+	register long __func asm("0") = func & CRYPT_Z990_FUNC_MASK;
+	register void* __param asm("1") = param;
+	register u8* __dest asm("4") = dest;
+	register const u8* __src asm("2") = src;
+	register long __src_len asm("3") = src_len;
+	int ret;
+	
+	ret = 0;
+	__asm__ __volatile__ (
+		"0:	.insn	rre,0xB92E0000,%1,%2 \n" //KM opcode
+		"1:	brc	1,0b \n" //handle partial completion
+		__crypt_z990_set_result
+		"6:	\n"
+		__crypt_z990_fixup
+		: "+d" (ret), "+a" (__dest), "+a" (__src),
+		  [result] "+d" (__src_len)
+		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
+		  "a" (__param)
+		: "cc", "memory"
+	);
+	if (ret >= 0 && func & CRYPT_Z990_FUNC_MASK){
+		ret = src_len - ret;
+	}
+	return ret;
+}
+
+/*
+ * Executes the KMC (CIPHER MESSAGE WITH CHAINING) operation of the z990 CPU.
+ * @param func: the function code passed to KM; see crypt_z990_kmc_func
+ * @param param: address of parameter block; see POP for details on each func
+ * @param dest: address of destination memory area
+ * @param src: address of source memory area
+ * @param src_len: length of src operand in bytes
+ * @returns < zero for failure, 0 for the query func, number of processed bytes
+ * 	for encryption/decryption funcs
+ */
+static inline int
+crypt_z990_kmc(long func, void* param, u8* dest, const u8* src, long src_len)
+{
+	register long __func asm("0") = func & CRYPT_Z990_FUNC_MASK;
+	register void* __param asm("1") = param;
+	register u8* __dest asm("4") = dest;
+	register const u8* __src asm("2") = src;
+	register long __src_len asm("3") = src_len;
+	int ret;
+	
+	ret = 0;
+	__asm__ __volatile__ (
+		"0:	.insn	rre,0xB92F0000,%1,%2 \n" //KMC opcode
+		"1:	brc	1,0b \n" //handle partial completion
+		__crypt_z990_set_result
+		"6:	\n"
+		__crypt_z990_fixup
+		: "+d" (ret), "+a" (__dest), "+a" (__src),
+		  [result] "+d" (__src_len)
+		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
+		  "a" (__param)
+		: "cc", "memory"
+	);
+	if (ret >= 0 && func & CRYPT_Z990_FUNC_MASK){
+		ret = src_len - ret;
+	}
+	return ret;
+}
+
+/*
+ * Executes the KIMD (COMPUTE INTERMEDIATE MESSAGE DIGEST) operation
+ * of the z990 CPU.
+ * @param func: the function code passed to KM; see crypt_z990_kimd_func
+ * @param param: address of parameter block; see POP for details on each func
+ * @param src: address of source memory area
+ * @param src_len: length of src operand in bytes
+ * @returns < zero for failure, 0 for the query func, number of processed bytes
+ * 	for digest funcs
+ */
+static inline int
+crypt_z990_kimd(long func, void* param, const u8* src, long src_len)
+{
+	register long __func asm("0") = func & CRYPT_Z990_FUNC_MASK;
+	register void* __param asm("1") = param;
+	register const u8* __src asm("2") = src;
+	register long __src_len asm("3") = src_len;
+	int ret;
+	
+	ret = 0;
+	__asm__ __volatile__ (
+		"0:	.insn	rre,0xB93E0000,%1,%1 \n" //KIMD opcode
+		"1:	brc	1,0b \n" /*handle partical completion of kimd*/
+		__crypt_z990_set_result
+		"6:	\n"
+		__crypt_z990_fixup
+		: "+d" (ret), "+a" (__src), [result] "+d" (__src_len)
+		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
+		  "a" (__param)
+		: "cc", "memory"
+	);
+	if (ret >= 0 && (func & CRYPT_Z990_FUNC_MASK)){
+		ret = src_len - ret;
+	}
+	return ret;
+}
+
+/*
+ * Executes the KLMD (COMPUTE LAST MESSAGE DIGEST) operation of the z990 CPU.
+ * @param func: the function code passed to KM; see crypt_z990_klmd_func
+ * @param param: address of parameter block; see POP for details on each func
+ * @param src: address of source memory area
+ * @param src_len: length of src operand in bytes
+ * @returns < zero for failure, 0 for the query func, number of processed bytes
+ * 	for digest funcs
+ */
+static inline int
+crypt_z990_klmd(long func, void* param, const u8* src, long src_len)
+{
+	register long __func asm("0") = func & CRYPT_Z990_FUNC_MASK;
+	register void* __param asm("1") = param;
+	register const u8* __src asm("2") = src;
+	register long __src_len asm("3") = src_len;
+	int ret;
+	
+	ret = 0;
+	__asm__ __volatile__ (
+		"0:	.insn	rre,0xB93F0000,%1,%1 \n" //KLMD opcode
+		"1:	brc	1,0b \n" /*handle partical completion of klmd*/
+		__crypt_z990_set_result
+		"6:	\n"
+		__crypt_z990_fixup
+		: "+d" (ret), "+a" (__src), [result] "+d" (__src_len)
+		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
+		  "a" (__param)
+		: "cc", "memory"
+	);
+	if (ret >= 0 && func & CRYPT_Z990_FUNC_MASK){
+		ret = src_len - ret;
+	}
+	return ret;
+}
+
+/*
+ * Executes the KMAC (COMPUTE MESSAGE AUTHENTICATION CODE) operation
+ * of the z990 CPU.
+ * @param func: the function code passed to KM; see crypt_z990_klmd_func
+ * @param param: address of parameter block; see POP for details on each func
+ * @param src: address of source memory area
+ * @param src_len: length of src operand in bytes
+ * @returns < zero for failure, 0 for the query func, number of processed bytes
+ * 	for digest funcs
+ */
+static inline int
+crypt_z990_kmac(long func, void* param, const u8* src, long src_len)
+{
+	register long __func asm("0") = func & CRYPT_Z990_FUNC_MASK;
+	register void* __param asm("1") = param;
+	register const u8* __src asm("2") = src;
+	register long __src_len asm("3") = src_len;
+	int ret;
+	
+	ret = 0;
+	__asm__ __volatile__ (
+		"0:	.insn	rre,0xB91E0000,%5,%5 \n" //KMAC opcode
+		"1:	brc	1,0b \n" /*handle partical completion of klmd*/
+		__crypt_z990_set_result
+		"6:	\n"
+		__crypt_z990_fixup
+		: "+d" (ret), "+a" (__src), [result] "+d" (__src_len)
+		: [e1] "K" (-EFAULT), [e2] "K" (-ENOSYS), "d" (__func),
+		  "a" (__param)	  
+		: "cc", "memory"
+	);
+	if (ret >= 0 && func & CRYPT_Z990_FUNC_MASK){
+		ret = src_len - ret;
+	}
+	return ret;
+}
+
+/**
+ * Tests if a specific z990 crypto function is implemented on the machine.
+ * @param func:	the function code of the specific function; 0 if op in general
+ * @return	1 if func available; 0 if func or op in general not available
+ */
+static inline int
+crypt_z990_func_available(int func)
+{
+	int ret;
+	
+	struct crypt_z990_query_status status = {
+		.high = 0,
+		.low = 0
+	};
+	switch (func & CRYPT_Z990_OP_MASK){
+		case CRYPT_Z990_KM:
+			ret = crypt_z990_km(KM_QUERY, &status, NULL, NULL, 0);
+			break;
+		case CRYPT_Z990_KMC:
+			ret = crypt_z990_kmc(KMC_QUERY, &status, NULL, NULL, 0);
+			break;
+		case CRYPT_Z990_KIMD:
+			ret = crypt_z990_kimd(KIMD_QUERY, &status, NULL, 0);
+			break;
+		case CRYPT_Z990_KLMD:
+			ret = crypt_z990_klmd(KLMD_QUERY, &status, NULL, 0);
+			break;
+		case CRYPT_Z990_KMAC:
+			ret = crypt_z990_kmac(KMAC_QUERY, &status, NULL, 0);
+			break;
+		default:
+			ret = 0;
+			return ret;
+	}
+	if (ret >= 0){
+		func &= CRYPT_Z990_FUNC_MASK;
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
+
+#endif // _CRYPTO_ARCH_S390_CRYPT_Z990_H
diff -urN linux-2.6/arch/s390/crypto/crypt_z990_query.c linux-2.6-s390/arch/s390/crypto/crypt_z990_query.c
--- linux-2.6/arch/s390/crypto/crypt_z990_query.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/crypto/crypt_z990_query.c	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,111 @@
+/*
+ * Cryptographic API.
+ *
+ * Support for z990 cryptographic instructions.
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
+#include "crypt_z990.h"
+
+static void
+query_available_functions(void)
+{
+	printk(KERN_INFO "#####################\n");
+	//query available KM functions
+	printk(KERN_INFO "KM_QUERY: %d\n",
+			crypt_z990_func_available(KM_QUERY));
+	printk(KERN_INFO "KM_DEA: %d\n",
+			crypt_z990_func_available(KM_DEA_ENCRYPT));
+	printk(KERN_INFO "KM_TDEA_128: %d\n",
+			crypt_z990_func_available(KM_TDEA_128_ENCRYPT));
+	printk(KERN_INFO "KM_TDEA_192: %d\n",
+			crypt_z990_func_available(KM_TDEA_192_ENCRYPT));
+	//query available KMC functions
+	printk(KERN_INFO "KMC_QUERY: %d\n",
+			crypt_z990_func_available(KMC_QUERY));
+	printk(KERN_INFO "KMC_DEA: %d\n",
+			crypt_z990_func_available(KMC_DEA_ENCRYPT));
+	printk(KERN_INFO "KMC_TDEA_128: %d\n",
+			crypt_z990_func_available(KMC_TDEA_128_ENCRYPT));
+	printk(KERN_INFO "KMC_TDEA_192: %d\n",
+			crypt_z990_func_available(KMC_TDEA_192_ENCRYPT));
+	//query available KIMD fucntions
+	printk(KERN_INFO "KIMD_QUERY: %d\n",
+			crypt_z990_func_available(KIMD_QUERY));
+	printk(KERN_INFO "KIMD_SHA_1: %d\n",
+			crypt_z990_func_available(KIMD_SHA_1));
+	//query available KLMD functions
+	printk(KERN_INFO "KLMD_QUERY: %d\n",
+			crypt_z990_func_available(KLMD_QUERY));
+	printk(KERN_INFO "KLMD_SHA_1: %d\n",
+			crypt_z990_func_available(KLMD_SHA_1));
+	//query available KMAC functions
+	printk(KERN_INFO "KMAC_QUERY: %d\n",
+			crypt_z990_func_available(KMAC_QUERY));
+	printk(KERN_INFO "KMAC_DEA: %d\n",
+			crypt_z990_func_available(KMAC_DEA));
+	printk(KERN_INFO "KMAC_TDEA_128: %d\n",
+			crypt_z990_func_available(KMAC_TDEA_128));
+	printk(KERN_INFO "KMAC_TDEA_192: %d\n",
+			crypt_z990_func_available(KMAC_TDEA_192));
+}
+
+static int
+init(void)
+{
+	struct crypt_z990_query_status status = {
+		.high = 0,
+		.low = 0
+	};
+
+	printk(KERN_INFO "crypt_z990: querying available crypto functions\n");
+	crypt_z990_km(KM_QUERY, &status, NULL, NULL, 0);
+	printk(KERN_INFO "KM: %016llx %016llx\n",
+			(unsigned long long) status.high,
+			(unsigned long long) status.low);
+	status.high = status.low = 0;
+	crypt_z990_kmc(KMC_QUERY, &status, NULL, NULL, 0);
+	printk(KERN_INFO "KMC: %016llx %016llx\n",
+			(unsigned long long) status.high,
+			(unsigned long long) status.low);
+	status.high = status.low = 0;
+	crypt_z990_kimd(KIMD_QUERY, &status, NULL, 0);
+	printk(KERN_INFO "KIMD: %016llx %016llx\n",
+			(unsigned long long) status.high,
+			(unsigned long long) status.low);
+	status.high = status.low = 0;
+	crypt_z990_klmd(KLMD_QUERY, &status, NULL, 0);
+	printk(KERN_INFO "KLMD: %016llx %016llx\n",
+			(unsigned long long) status.high,
+			(unsigned long long) status.low);
+	status.high = status.low = 0;
+	crypt_z990_kmac(KMAC_QUERY, &status, NULL, 0);
+	printk(KERN_INFO "KMAC: %016llx %016llx\n",
+			(unsigned long long) status.high,
+			(unsigned long long) status.low);
+	
+	query_available_functions();
+	return -1;
+}
+
+static void __exit
+cleanup(void)
+{
+}
+
+module_init(init);
+module_exit(cleanup);
+
+MODULE_LICENSE("GPL");
diff -urN linux-2.6/arch/s390/crypto/crypto_des.h linux-2.6-s390/arch/s390/crypto/crypto_des.h
--- linux-2.6/arch/s390/crypto/crypto_des.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/crypto/crypto_des.h	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,18 @@
+/* 
+ * Cryptographic API.
+ *
+ * Function for checking keys for the DES and Tripple DES Encryption
+ * algorithms.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#ifndef __CRYPTO_DES_H__
+#define __CRYPTO_DES_H__
+
+extern int crypto_des_check_key(const u8*, unsigned int, u32*);
+
+#endif //__CRYPTO_DES_H__
diff -urN linux-2.6/arch/s390/crypto/des_check_key.c linux-2.6-s390/arch/s390/crypto/des_check_key.c
--- linux-2.6/arch/s390/crypto/des_check_key.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/crypto/des_check_key.c	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,130 @@
+/* 
+ * Cryptographic API.
+ *
+ * Function for checking keys for the DES and Tripple DES Encryption
+ * algorithms.
+ *
+ * Originally released as descore by Dana L. How <how@isl.stanford.edu>.
+ * Modified by Raimar Falke <rf13@inf.tu-dresden.de> for the Linux-Kernel.
+ * Derived from Cryptoapi and Nettle implementations, adapted for in-place
+ * scatterlist interface.  Changed LGPL to GPL per section 3 of the LGPL.
+ *
+ * s390 Version:
+ *   Copyright (C) 2003 IBM Deutschland GmbH, IBM Corporation
+ *   Author(s): Thomas Spatzier (tspat@de.ibm.com)
+ *
+ * Derived from "crypto/des.c"
+ *   Copyright (c) 1992 Dana L. How.
+ *   Copyright (c) Raimar Falke <rf13@inf.tu-dresden.de> 
+ *   Copyright (c) Gisle S�lensminde <gisle@ii.uib.no>
+ *   Copyright (C) 2001 Niels M�ller.
+ *   Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/crypto.h>
+
+#define ROR(d,c,o)	((d) = (d) >> (c) | (d) << (o))
+
+static const u8 parity[] = {
+	8,1,0,8,0,8,8,0,0,8,8,0,8,0,2,8,0,8,8,0,8,0,0,8,8,0,0,8,0,8,8,3,
+	0,8,8,0,8,0,0,8,8,0,0,8,0,8,8,0,8,0,0,8,0,8,8,0,0,8,8,0,8,0,0,8,
+	0,8,8,0,8,0,0,8,8,0,0,8,0,8,8,0,8,0,0,8,0,8,8,0,0,8,8,0,8,0,0,8,
+	8,0,0,8,0,8,8,0,0,8,8,0,8,0,0,8,0,8,8,0,8,0,0,8,8,0,0,8,0,8,8,0,
+	0,8,8,0,8,0,0,8,8,0,0,8,0,8,8,0,8,0,0,8,0,8,8,0,0,8,8,0,8,0,0,8,
+	8,0,0,8,0,8,8,0,0,8,8,0,8,0,0,8,0,8,8,0,8,0,0,8,8,0,0,8,0,8,8,0,
+	8,0,0,8,0,8,8,0,0,8,8,0,8,0,0,8,0,8,8,0,8,0,0,8,8,0,0,8,0,8,8,0,
+	4,8,8,0,8,0,0,8,8,0,0,8,0,8,8,0,8,5,0,8,0,8,8,0,0,8,8,0,8,0,6,8,
+};
+
+/*
+ * RFC2451: Weak key checks SHOULD be performed.
+ */
+int
+crypto_des_check_key(const u8 *key, unsigned int keylen, u32 *flags)
+{
+	u32 n, w;
+
+	n  = parity[key[0]]; n <<= 4;
+	n |= parity[key[1]]; n <<= 4;
+	n |= parity[key[2]]; n <<= 4;
+	n |= parity[key[3]]; n <<= 4;
+	n |= parity[key[4]]; n <<= 4;
+	n |= parity[key[5]]; n <<= 4;
+	n |= parity[key[6]]; n <<= 4;
+	n |= parity[key[7]];
+	w = 0x88888888L;
+	
+	if ((*flags & CRYPTO_TFM_REQ_WEAK_KEY)
+	    && !((n - (w >> 3)) & w)) {  /* 1 in 10^10 keys passes this test */
+		if (n < 0x41415151) {
+			if (n < 0x31312121) {
+				if (n < 0x14141515) {
+					/* 01 01 01 01 01 01 01 01 */
+					if (n == 0x11111111) goto weak;
+					/* 01 1F 01 1F 01 0E 01 0E */
+					if (n == 0x13131212) goto weak;
+				} else {
+					/* 01 E0 01 E0 01 F1 01 F1 */
+					if (n == 0x14141515) goto weak;
+					/* 01 FE 01 FE 01 FE 01 FE */
+					if (n == 0x16161616) goto weak;
+				}
+			} else {
+				if (n < 0x34342525) {
+					/* 1F 01 1F 01 0E 01 0E 01 */
+					if (n == 0x31312121) goto weak;
+					/* 1F 1F 1F 1F 0E 0E 0E 0E (?) */
+					if (n == 0x33332222) goto weak;
+				} else {
+					/* 1F E0 1F E0 0E F1 0E F1 */
+					if (n == 0x34342525) goto weak;
+					/* 1F FE 1F FE 0E FE 0E FE */
+					if (n == 0x36362626) goto weak;
+				}
+			}
+		} else {
+			if (n < 0x61616161) {
+				if (n < 0x44445555) {
+					/* E0 01 E0 01 F1 01 F1 01 */
+					if (n == 0x41415151) goto weak;
+					/* E0 1F E0 1F F1 0E F1 0E */
+					if (n == 0x43435252) goto weak;
+				} else {
+					/* E0 E0 E0 E0 F1 F1 F1 F1 (?) */
+					if (n == 0x44445555) goto weak;
+					/* E0 FE E0 FE F1 FE F1 FE */
+					if (n == 0x46465656) goto weak;
+				}
+			} else {
+				if (n < 0x64646565) {
+					/* FE 01 FE 01 FE 01 FE 01 */
+					if (n == 0x61616161) goto weak;
+					/* FE 1F FE 1F FE 0E FE 0E */
+					if (n == 0x63636262) goto weak;
+				} else {
+					/* FE E0 FE E0 FE F1 FE F1 */
+					if (n == 0x64646565) goto weak;
+					/* FE FE FE FE FE FE FE FE */
+					if (n == 0x66666666) goto weak;
+				}
+			}
+		}
+	}
+	return 0;
+weak:
+	*flags |= CRYPTO_TFM_RES_WEAK_KEY;
+	return -EINVAL;
+}
+
+EXPORT_SYMBOL(crypto_des_check_key);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Key Check function for DES &  DES3 Cipher Algorithms");
diff -urN linux-2.6/arch/s390/crypto/des_z990.c linux-2.6-s390/arch/s390/crypto/des_z990.c
--- linux-2.6/arch/s390/crypto/des_z990.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/crypto/des_z990.c	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,284 @@
+/* 
+ * Cryptographic API.
+ *
+ * z990 implementation of the DES Cipher Algorithm.
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
+#include "crypt_z990.h"
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
+struct crypt_z990_des_ctx {
+	u8 iv[DES_BLOCK_SIZE];
+	u8 key[DES_KEY_SIZE];
+};
+
+struct crypt_z990_des3_128_ctx {
+	u8 iv[DES_BLOCK_SIZE];
+	u8 key[DES3_128_KEY_SIZE];
+};
+
+struct crypt_z990_des3_192_ctx {
+	u8 iv[DES_BLOCK_SIZE];
+	u8 key[DES3_192_KEY_SIZE];
+};
+
+static int
+des_setkey(void *ctx, const u8 *key, unsigned int keylen, u32 *flags)
+{
+	struct crypt_z990_des_ctx *dctx;
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
+	struct crypt_z990_des_ctx *dctx;
+	
+	dctx = ctx;
+	crypt_z990_km(KM_DEA_ENCRYPT, dctx->key, dst, src, DES_BLOCK_SIZE);
+}
+
+static void
+des_decrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	struct crypt_z990_des_ctx *dctx;
+	
+	dctx = ctx;
+	crypt_z990_km(KM_DEA_DECRYPT, dctx->key, dst, src, DES_BLOCK_SIZE);
+}
+
+static struct crypto_alg des_alg = {
+	.cra_name		=	"des",
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	DES_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct crypt_z990_des_ctx),
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
+	struct crypt_z990_des3_128_ctx *dctx;
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
+	struct crypt_z990_des3_128_ctx *dctx;
+	
+	dctx = ctx;
+	crypt_z990_km(KM_TDEA_128_ENCRYPT, dctx->key, dst, (void*)src,
+			DES3_128_BLOCK_SIZE);
+}
+
+static void
+des3_128_decrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	struct crypt_z990_des3_128_ctx *dctx;
+	
+	dctx = ctx;
+	crypt_z990_km(KM_TDEA_128_DECRYPT, dctx->key, dst, (void*)src,
+			DES3_128_BLOCK_SIZE);
+}
+
+static struct crypto_alg des3_128_alg = {
+	.cra_name		=	"des3_ede128",
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	DES3_128_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct crypt_z990_des3_128_ctx),
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
+	struct crypt_z990_des3_192_ctx *dctx;
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
+	struct crypt_z990_des3_192_ctx *dctx;
+	
+	dctx = ctx;
+	crypt_z990_km(KM_TDEA_192_ENCRYPT, dctx->key, dst, (void*)src,
+			DES3_192_BLOCK_SIZE);
+}
+
+static void
+des3_192_decrypt(void *ctx, u8 *dst, const u8 *src)
+{
+	struct crypt_z990_des3_192_ctx *dctx;
+	
+	dctx = ctx;
+	crypt_z990_km(KM_TDEA_192_DECRYPT, dctx->key, dst, (void*)src,
+			DES3_192_BLOCK_SIZE);
+}
+
+static struct crypto_alg des3_192_alg = {
+	.cra_name		=	"des3_ede",
+	.cra_flags		=	CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		=	DES3_192_BLOCK_SIZE,
+	.cra_ctxsize		=	sizeof(struct crypt_z990_des3_192_ctx),
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
+	if (!crypt_z990_func_available(KM_DEA_ENCRYPT) ||
+	    !crypt_z990_func_available(KM_TDEA_128_ENCRYPT) ||
+	    !crypt_z990_func_available(KM_TDEA_192_ENCRYPT)){
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
+	printk(KERN_INFO "crypt_z990: des_z990 loaded.\n");
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
diff -urN linux-2.6/arch/s390/crypto/sha1_z990.c linux-2.6-s390/arch/s390/crypto/sha1_z990.c
--- linux-2.6/arch/s390/crypto/sha1_z990.c	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/arch/s390/crypto/sha1_z990.c	Wed Apr 21 16:29:40 2004
@@ -0,0 +1,167 @@
+/*
+ * Cryptographic API.
+ *
+ * z990 implementation of the SHA1 Secure Hash Algorithm.
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
+#include "crypt_z990.h"
+
+#define SHA1_DIGEST_SIZE	20
+#define SHA1_BLOCK_SIZE		64
+
+struct crypt_z990_sha1_ctx {
+        u64 count;
+        u32 state[5];
+	u32 buf_len;
+        u8 buffer[2 * SHA1_BLOCK_SIZE];
+};
+
+static void
+sha1_init(void *ctx)
+{
+	static const struct crypt_z990_sha1_ctx initstate = {
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
+	struct crypt_z990_sha1_ctx *sctx;
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
+		crypt_z990_kimd(KIMD_SHA_1, sctx->state, sctx->buffer,
+				SHA1_BLOCK_SIZE);
+		data += SHA1_BLOCK_SIZE - sctx->buf_len;
+		len -= SHA1_BLOCK_SIZE - sctx->buf_len;
+		sctx->buf_len = 0;
+	}
+
+	//rest of data contains full blocks?
+	imd_len = len & ~0x3ful;
+	if (imd_len){
+		crypt_z990_kimd(KIMD_SHA_1, sctx->state, data, imd_len);
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
+pad_message(struct crypt_z990_sha1_ctx* sctx)
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
+	struct crypt_z990_sha1_ctx *sctx = ctx;
+	
+	//must perform manual padding
+	pad_message(sctx);
+	crypt_z990_kimd(KIMD_SHA_1, sctx->state, sctx->buffer, sctx->buf_len);
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
+	.cra_ctxsize	=	sizeof(struct crypt_z990_sha1_ctx),
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
+	if (crypt_z990_func_available(KIMD_SHA_1)){
+		ret = crypto_register_alg(&alg);
+		if (ret == 0){
+			printk(KERN_INFO "crypt_z990: sha1_z990 loaded.\n");
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
diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Wed Apr 21 16:29:40 2004
+++ linux-2.6-s390/arch/s390/defconfig	Wed Apr 21 16:29:40 2004
@@ -490,9 +490,11 @@
 # CONFIG_CRYPTO_MD4 is not set
 # CONFIG_CRYPTO_MD5 is not set
 # CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA1_Z990 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_DES is not set
+# CONFIG_CRYPTO_DES_Z990 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
 # CONFIG_CRYPTO_TWOFISH is not set
 # CONFIG_CRYPTO_SERPENT is not set
diff -urN linux-2.6/crypto/Kconfig linux-2.6-s390/crypto/Kconfig
--- linux-2.6/crypto/Kconfig	Wed Apr 21 16:29:15 2004
+++ linux-2.6-s390/crypto/Kconfig	Wed Apr 21 16:29:40 2004
@@ -39,6 +39,12 @@
 	depends on CRYPTO
 	help
 	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+	  
+config CRYPTO_SHA1_Z990
+	tristate "SHA1 digest algorithm for IBM zSeries z990"
+	depends on CRYPTO && ARCH_S390
+	help
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
 
 config CRYPTO_SHA256
 	tristate "SHA256 digest algorithm"
@@ -67,6 +73,12 @@
 	help
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
 
+config CRYPTO_DES_Z990
+	tristate "DES and Triple DES cipher algorithms for IBM zSeries z990"
+	depends on CRYPTO && ARCH_S390
+	help
+	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
+
 config CRYPTO_BLOWFISH
 	tristate "Blowfish cipher algorithm"
 	depends on CRYPTO
