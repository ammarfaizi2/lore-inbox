Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265285AbUEZBtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUEZBtx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 21:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUEZBtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 21:49:53 -0400
Received: from holomorphy.com ([207.189.100.168]:48275 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265285AbUEZBtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 21:49:22 -0400
Date: Tue, 25 May 2004 18:49:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: mochel@digitalimplant.org
Subject: Crusoe longrun utility LFS fixes
Message-ID: <20040526014918.GU1833@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat recently brought up that some changes around 2.6.5 affected the
longrun utility at http://kernel.org/pub/linux/utils/cpu/crusoe/
The following patch against the longrun utility makes it LFS clean
and to work according to Pat's testing.

This fix exonerates the microcode driver and/or the LFS-related changes
post-2.6.5 from causing the issue, which was -EINVAL from pread() in
post-2.6.5 kernels.


-- wli


--- longrun/Makefile.orig	2004-05-25 17:59:05.000000000 -0700
+++ longrun/Makefile	2004-05-25 18:09:59.000000000 -0700
@@ -1,7 +1,11 @@
+DEFINES:=_XOPEN_SOURCE=500 _LARGEFILE_SOURCE _LARGEFILE64_SOURCE _FILE_OFFSET_BITS=64
+CFLAGS:=-g -O2 -W -Wall $(addprefix -D, $(DEFINES))
+CC:=gcc
+
 all: longrun README
 
 longrun: longrun.c
-	gcc -g -O2 -W -Wall -o longrun longrun.c
+	$(CC) $(CFLAGS) $^ -o $@
 
 README: longrun.1
 	groff -Tascii -man longrun.1 | col -bx > README
--- longrun/longrun.c.orig	2004-05-25 17:57:43.000000000 -0700
+++ longrun/longrun.c	2004-05-25 18:29:55.000000000 -0700
@@ -32,7 +32,6 @@
 #include <string.h>
 #include <sys/io.h>
 #include <sys/sysmacros.h>
-#define __USE_UNIX98	/* for pread/pwrite */
 #include <unistd.h>
 
 #define MSR_DEVICE "/dev/cpu/0/msr"
@@ -124,7 +123,7 @@
 {
 	int nb;
 
-	nb = open(LR_NORTHBRIDGE, O_RDONLY);
+	nb = open64(LR_NORTHBRIDGE, O_RDONLY);
 	if (nb < 0) {
 		error_warn("error opening %s", LR_NORTHBRIDGE);
 		if (errno == ENOENT) {
@@ -132,18 +131,18 @@
 		}
 		exit(1);
 	}
-	if (pread(nb, atm, 1, ATM_ADDRESS) != 1) {
+	if (pread64(nb, atm, 1, ATM_ADDRESS) != 1) {
 		error_die("error reading %s", LR_NORTHBRIDGE);
 	}
 	close(nb);
 }
 
 /* note: if an output is NULL, then don't set it */
-void read_msr(long address, int *lower, int *upper)
+void read_msr(off64_t address, int *lower, int *upper)
 {
 	uint32_t data[2];
 
-	if (pread(msr_fd, &data, 8, address) != 8) {
+	if (pread64(msr_fd, &data, 8, address) != 8) {
 		error_die("error reading %s", msr_device);
 	}
 
@@ -151,24 +150,24 @@
 	if (upper) *upper = data[1];
 }
 
-void write_msr(long address, int lower, int upper)
+void write_msr(off64_t address, int lower, int upper)
 {
 	uint32_t data[2];
 
 	data[0] = (uint32_t) lower;
 	data[1] = (uint32_t) upper;
 
-	if (pwrite(msr_fd, &data, 8, address) != 8) {
+	if (pwrite64(msr_fd, &data, 8, address) != 8) {
 		error_die("error writing %s", msr_device);
 	}
 }
 
 /* note: if an output is NULL, then don't set it */
-void read_cpuid(long address, int *eax, int *ebx, int *ecx, int *edx)
+void read_cpuid(off64_t address, int *eax, int *ebx, int *ecx, int *edx)
 {
 	uint32_t data[4];
 
-	if (pread(cpuid_fd, &data, 16, address) != 16) {
+	if (pread64(cpuid_fd, &data, 16, address) != 16) {
 		error_die("error reading %s", cpuid_device);
 	}
 
@@ -404,7 +403,7 @@
 		exit(1);
 	}
 
-	if ((cpuid_fd = open(cpuid_device, O_RDWR)) < 0) {
+	if ((cpuid_fd = open64(cpuid_device, O_RDWR)) < 0) {
 		error_warn("error opening %s", cpuid_device);
 		if (errno == ENODEV) {
 			fprintf(stderr, "make sure your kernel was compiled with CONFIG_X86_CPUID=y\n");
@@ -412,7 +411,7 @@
 		exit(1);
 	}
 
-	if ((msr_fd = open(msr_device, O_RDWR)) < 0) {
+	if ((msr_fd = open64(msr_device, O_RDWR)) < 0) {
 		error_warn("error opening %s", msr_device);
 		if (errno == ENODEV) {
 			fprintf(stderr, "make sure your kernel was compiled with CONFIG_X86_MSR=y\n");
