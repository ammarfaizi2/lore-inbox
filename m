Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263188AbSJ1ImN>; Mon, 28 Oct 2002 03:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263203AbSJ1ImN>; Mon, 28 Oct 2002 03:42:13 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:46820 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S263188AbSJ1ImH>; Mon, 28 Oct 2002 03:42:07 -0500
Message-ID: <3DBCF9D0.4030602@drugphish.ch>
Date: Mon, 28 Oct 2002 09:48:16 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       Momchil Velikov <velco@fadata.bg>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: New csum and csum_copy routines - and a test/benchmark program
References: <200210280819.g9S8Jfp25782@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: multipart/mixed;
 boundary="------------040903060500090209040909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040903060500090209040909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Denis Vlasenko wrote:
> I took some time to develop a little test/benchmark program
> for csum and csum_copy routines (used in networking).
> It has grown to include following features:

I needed the attached patch with changes to make it work on my machine. 
Could you comment on it, please? Also a Makefile would be nicer ;).

Cheers,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

--------------040903060500090209040909
Content-Type: text/plain;
 name="timing_csum_copy_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="timing_csum_copy_fix.diff"

diff -ur timing_csum_copy.3/copy_kpf.S timing_csum_copy.3-ratz/copy_kpf.S
--- timing_csum_copy.3/copy_kpf.S	Mon Oct 28 13:35:25 2002
+++ timing_csum_copy.3-ratz/copy_kpf.S	Mon Oct 28 09:41:11 2002
@@ -76,7 +76,7 @@
 	PREFETCH(128(%esi))
 	PREFETCH(192(%esi))
 	subl	$108, %esp
-	fsave	(%esp)		# save FPU - we'll use MMX...
+	fsave	(%esp)		# save FPU - we will use MMX...
 	fwait
 	testl	%esi, %esi	# clears CF
 10:
diff -ur timing_csum_copy.3/copy_ntq.c timing_csum_copy.3-ratz/copy_ntq.c
--- timing_csum_copy.3/copy_ntq.c	Sun Oct 27 02:14:12 2002
+++ timing_csum_copy.3-ratz/copy_ntq.c	Mon Oct 28 09:32:49 2002
@@ -1,6 +1,7 @@
 unsigned int ntq_copy(const char *src, char *dst,
                 int len, int sum, int *src_err_ptr, int *dst_err_ptr)
 {
+	int count;
 	char fpu_save[108];
 	__asm__ __volatile__ (
 		"	fsave	%0\n"
@@ -8,7 +9,7 @@
 			: /* output */ "=m"(fpu_save[0])
 	);
 
-	int count = len/8;
+	count = len/8;
 	__asm__ __volatile__ (
 		"	testl	%%ecx, %%ecx\n"	//carry unset - we need it
 		// these two back-to-back references actually _is_ the fastest way
diff -ur timing_csum_copy.3/copy_ntqpf.c timing_csum_copy.3-ratz/copy_ntqpf.c
--- timing_csum_copy.3/copy_ntqpf.c	Fri Oct 25 20:01:44 2002
+++ timing_csum_copy.3-ratz/copy_ntqpf.c	Mon Oct 28 09:33:08 2002
@@ -1,6 +1,7 @@
 unsigned int ntqpf_copy(const char *src, char *dst,
                 int len, int sum, int *src_err_ptr, int *dst_err_ptr)
 {
+	int count;
 	char fpu_save[108];
 	__asm__ __volatile__ (
 		"	"PREFETCH" (%0)\n"
@@ -15,7 +16,7 @@
 			: /* output */ "=m"(fpu_save[0])
 	);
 
-	int count = len/(8*8);
+	count = len/(8*8);
 	while(count--) {
 		__asm__ __volatile__ (
 		"1:	"PREFETCH" 256(%1)\n"
diff -ur timing_csum_copy.3/copy_ntqpf2.c timing_csum_copy.3-ratz/copy_ntqpf2.c
--- timing_csum_copy.3/copy_ntqpf2.c	Sun Oct 27 02:19:09 2002
+++ timing_csum_copy.3-ratz/copy_ntqpf2.c	Mon Oct 28 09:33:27 2002
@@ -1,6 +1,7 @@
 unsigned int ntqpf2_copy(const char *src, char *dst,
                 int len, int sum, int *src_err_ptr, int *dst_err_ptr)
 {
+	int count;
 	char fpu_save[108];
 	__asm__ __volatile__ (
 		"	"PREFETCH" (%0)\n"
@@ -15,7 +16,7 @@
 			: /* output */ "=m"(fpu_save[0])
 	);
 
-	int count = len/(8*8);
+	count = len/(8*8);
 	while(count--) {
 		__asm__ __volatile__ (
 		"1:	"PREFETCH" 256(%1)\n"
diff -ur timing_csum_copy.3/copy_ntqpfm.c timing_csum_copy.3-ratz/copy_ntqpfm.c
--- timing_csum_copy.3/copy_ntqpfm.c	Sun Oct 27 02:38:21 2002
+++ timing_csum_copy.3-ratz/copy_ntqpfm.c	Mon Oct 28 09:33:41 2002
@@ -1,6 +1,7 @@
 unsigned int ntqpfm_copy(const char *src, char *dst,
                 int len, int sum, int *src_err_ptr, int *dst_err_ptr)
 {
+	int count;
 	char xmm0[16];
 	__asm__ __volatile__ (
 		"	"PREFETCH" (%0)\n"
@@ -14,7 +15,7 @@
 			: /* output */ "=m"(xmm0[0])
 	);
 
-	int count = len/(8*8);
+	count = len/(8*8);
 	while(count--) {
 		__asm__ __volatile__ (
 		"1:	"PREFETCH" 256(%1)\n"
diff -ur timing_csum_copy.3/csum_kpf.S timing_csum_copy.3-ratz/csum_kpf.S
--- timing_csum_copy.3/csum_kpf.S	Mon Oct 28 13:35:30 2002
+++ timing_csum_copy.3-ratz/csum_kpf.S	Mon Oct 28 09:43:21 2002
@@ -73,7 +73,7 @@
 40:
 	PREFETCH(256(%esi))
 41:
-	addl/*	-128(%esi), %eax
+	addl	-128(%esi), %eax
 	adcl	-124(%esi), %eax
 	adcl	-120(%esi), %eax
 	adcl	-116(%esi), %eax
@@ -97,7 +97,7 @@
 	adcl	-44(%esi), %eax
 	adcl	-40(%esi), %eax
 	adcl	-36(%esi), %eax
-	adcl*/	-32(%esi), %eax
+	adcl	-32(%esi), %eax
 	adcl	-28(%esi), %eax
 	adcl	-24(%esi), %eax
 	adcl	-20(%esi), %eax
@@ -115,7 +115,7 @@
 	js	46f			
 	cmp	$8,%ecx			
 	jae	40b	# need prefetch
-	jmp	41b	# don't need it
+	jmp	41b	# do not need it
 46:
 	//adcl	$0, %eax
 	movl	%edx, %ecx
diff -ur timing_csum_copy.3/csum_pfm.c timing_csum_copy.3-ratz/csum_pfm.c
--- timing_csum_copy.3/csum_pfm.c	Sun Oct 27 02:41:17 2002
+++ timing_csum_copy.3-ratz/csum_pfm.c	Mon Oct 28 09:31:58 2002
@@ -1,5 +1,6 @@
 unsigned int pfm_csum(const unsigned char *src, int len, unsigned int sum)
 {
+	int count;
 	__asm__ __volatile__ (
 		"	"PREFETCH" (%0)\n"
 		"	"PREFETCH" 64(%0)\n"
@@ -8,8 +9,8 @@
 			: : "r" (src)
 	);
 
-	int count = len/(8*8);
-	while(count--)
 {
+	count = len/(8*8);
+	while(count--) {
 		__asm__ __volatile__ (
 		"1:	"PREFETCH" 256(%1)\n"
 		"	xorl	%%ecx, %%ecx\n"	//carry unset - we need it
diff -ur timing_csum_copy.3/csum_pfm2.c timing_csum_copy.3-ratz/csum_pfm2.c
--- timing_csum_copy.3/csum_pfm2.c	Sun Oct 27 02:42:04 2002
+++ timing_csum_copy.3-ratz/csum_pfm2.c	Mon Oct 28 09:32:27 2002
@@ -1,5 +1,6 @@
 unsigned int pfm2_csum(const unsigned char *src, int len, unsigned int sum)
 {
+	int count;
 	__asm__ __volatile__ (
 		"	"PREFETCH" (%0)\n"
 		"	"PREFETCH" 64(%0)\n"
@@ -8,8 +9,8 @@
 			: : "r" (src)
 	);
 
-	int count = len/(8*8);
-	while(count--)
 {
+	count = len/(8*8);
+	while(count--) {
 		__asm__ __volatile__ (
 		"1:	"PREFETCH" 256(%1)\n"
 		"	xorl	%%ecx, %%ecx\n"	//carry unset - we need it

--------------040903060500090209040909--

