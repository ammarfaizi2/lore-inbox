Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVIFWuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVIFWuz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbVIFWuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:50:55 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10479 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S1751090AbVIFWuy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:50:54 -0400
Message-ID: <431E1D1A.2090601@mvista.com>
Date: Tue, 06 Sep 2005 15:50:02 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org, akpm@osdl.org
Subject: [PATCH]  PPC64: large INITRD causes kernel not to boot [UPDATE]
Content-Type: multipart/mixed;
 boundary="------------080808030504090600060002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------080808030504090600060002
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
"padding" and rounding). If PROG_START is defined this will be used as 
the minimum safe address - currently known to be 0x01400000 for the 
firmwares tested so far.

We've talked about this in linuxppc64-dev@ozlabs.org and this is what 
seems to have settled out.

mark

Signed-off-by: Mark Bellon <mbellon@mvista.com>


--------------080808030504090600060002
Content-Type: text/plain;
 name="initrd-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="initrd-patch"

diff -Naur linux-2.6.13-orig/arch/ppc64/boot/main.c linux-2.6.13/arch/ppc64/boot/main.c
--- linux-2.6.13-orig/arch/ppc64/boot/main.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/arch/ppc64/boot/main.c	2005-09-06 15:42:22.000000000 -0700
@@ -20,7 +20,7 @@
 extern void printf(const char *fmt, ...);
 extern int sprintf(char *buf, const char *fmt, ...);
 void gunzip(void *, int, unsigned char *, int *);
-void *claim(unsigned int, unsigned int, unsigned int);
+void *claim(unsigned long, unsigned long, unsigned long);
 void flush_cache(void *, unsigned long);
 void pause(void);
 extern void exit(void);
@@ -31,7 +31,8 @@
 
 /* Value picked to match that used by yaboot */
 #define PROG_START	0x01400000
-#define RAM_END		(256<<20) // Fixme: use OF */
+#define RAM_END		(512<<20) // Fixme: use OF */
+#define	ONE_MB		0x100000
 
 char *avail_ram;
 char *begin_avail, *end_avail;
@@ -40,6 +41,7 @@
 unsigned int heap_max;
 
 extern char _start[];
+extern char _end[];
 extern char _vmlinux_start[];
 extern char _vmlinux_end[];
 extern char _initrd_start[];
@@ -73,13 +75,13 @@
 
 #undef DEBUG
 
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
@@ -110,7 +112,26 @@
 	if (getprop(chosen_handle, "stdin", &stdin, sizeof(stdin)) != 4)
 		exit();
 
-	printf("\n\rzImage starting: loaded at 0x%x\n\r", (unsigned)_start);
+	printf("\n\rzImage starting: loaded at 0x%lx\n\r", (unsigned long) _start);
+
+	/*
+	 * The first available claim_base must be above the end of the
+	 * the loaded kernel wrapper file (_start to _end includes the
+	 * initrd image if it is present) and rounded up to a nice
+	 * 1 MB boundary for good measure.
+	 */
+
+	claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
+
+#if defined(PROG_START)
+	/*
+	 * Maintain a "magic" minimum address. This keeps some older
+	 * firmware platforms running.
+	 */
+
+	if (claim_base < PROG_START)
+		claim_base = PROG_START;
+#endif
 
 	/*
 	 * Now we try to claim some memory for the kernel itself
@@ -120,7 +141,7 @@
 	 * size... In practice we add 1Mb, that is enough, but we should really
 	 * consider fixing the Makefile to put a _raw_ kernel in there !
 	 */
-	vmlinux_memsize += 0x100000;
+	vmlinux_memsize += ONE_MB;
 	printf("Allocating 0x%lx bytes for kernel ...\n\r", vmlinux_memsize);
 	vmlinux.addr = try_claim(vmlinux_memsize);
 	if (vmlinux.addr == 0) {

--------------080808030504090600060002--
