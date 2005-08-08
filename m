Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVHHRzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVHHRzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVHHRzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:55:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:1525 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932164AbVHHRzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:55:36 -0400
Message-ID: <42F79C7D.5060406@mvista.com>
Date: Mon, 08 Aug 2005 10:55:09 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH]  PPC64: large INITRD causes kernel not to boot
References: <42E97236.6080404@mvista.com> <42EA6580.9010204@mvista.com>
In-Reply-To: <42EA6580.9010204@mvista.com>
Content-Type: multipart/mixed;
 boundary="------------060200030206080105020103"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------060200030206080105020103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In PPC64 there are number of problems in arch/ppc64/boot/main.c that 
prevent a kernel from making use of a large (greater than ~16MB) INITRD. 
This is 64 bit architecture and really large INITRD images should be 
possible.

Simply put the existing code has a fixed reservation (claim) address and 
once the kernel plus initrd image are large enough to pass this address 
all sorts of bad things occur. The fix is the dynamically establish the 
first claim address above the loaded kernel plus initrd (plus some 
"padding" and rounding)

mark

Signed-off-by: Mark Bellon <mbellon@mvista.com>


--------------060200030206080105020103
Content-Type: text/x-patch;
 name="common_initrd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="common_initrd.patch"

Index: linux-2.6.12.3/arch/ppc64/boot/main.c
===================================================================
--- linux-2.6.12.3.orig/arch/ppc64/boot/main.c
+++ linux-2.6.12.3/arch/ppc64/boot/main.c
@@ -22,7 +22,7 @@
 extern void printf(const char *fmt, ...);
 extern int sprintf(char *buf, const char *fmt, ...);
 void gunzip(void *, int, unsigned char *, int *);
-void *claim(unsigned int, unsigned int, unsigned int);
+void *claim(unsigned long, unsigned long, unsigned long);
 void flush_cache(void *, unsigned long);
 void pause(void);
 extern void exit(void);
@@ -31,9 +31,8 @@
 void *memmove(void *dest, const void *src, unsigned long n);
 void *memcpy(void *dest, const void *src, unsigned long n);
 
-/* Value picked to match that used by yaboot */
-#define PROG_START	0x01400000
-#define RAM_END		(256<<20) // Fixme: use OF */
+#define	ONE_MB		0x100000
+#define RAM_END		(512<<20) // Fixme: use OF */
 
 char *avail_ram;
 char *begin_avail, *end_avail;
@@ -75,13 +74,13 @@
 
 #define DEBUG
 
-static unsigned long claim_base = PROG_START;
+static unsigned long claim_base;
 
 static unsigned long try_claim(unsigned long size)
 {
 	unsigned long addr = 0;
 
-	for(; claim_base < RAM_END; claim_base += 0x100000) {
+	for(; claim_base < RAM_END; claim_base += ONE_MB) {
 #ifdef DEBUG
 		printf("    trying: 0x%08lx\n\r", claim_base);
 #endif
@@ -112,7 +111,23 @@
 	if (getprop(chosen_handle, "stdin", &stdin, sizeof(stdin)) != 4)
 		exit();
 
-	printf("zImage starting: loaded at 0x%x\n\r", (unsigned)_start);
+	printf("zImage starting: loaded at 0x%lx\n\r", (unsigned long)_start);
+
+	/*
+	 * The first available claim_base must be "out of the way" -
+	 * well above _start + kernel_size + initrd + overhead.
+	 */
+
+	claim_base = ((unsigned long) _start) +
+				((unsigned long) vmlinux_filesize) +
+				(unsigned long)(_initrd_end - _initrd_start) +
+				ONE_MB;
+
+	/*
+	 * Now round up the claim_base to a nice 1 MB boundary.
+	 */
+
+	claim_base = ((claim_base + ONE_MB - 1) / ONE_MB) * ONE_MB;
 
 	/*
 	 * Now we try to claim some memory for the kernel itself
@@ -122,7 +137,7 @@
 	 * size... In practice we add 1Mb, that is enough, but we should really
 	 * consider fixing the Makefile to put a _raw_ kernel in there !
 	 */
-	vmlinux_memsize += 0x100000;
+	vmlinux_memsize += ONE_MB;
 	printf("Allocating 0x%lx bytes for kernel ...\n\r", vmlinux_memsize);
 	vmlinux.addr = try_claim(vmlinux_memsize);
 	if (vmlinux.addr == 0) {

--------------060200030206080105020103--
