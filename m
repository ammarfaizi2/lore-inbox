Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265589AbSKPGrx>; Sat, 16 Nov 2002 01:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbSKPGrx>; Sat, 16 Nov 2002 01:47:53 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:727 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S265589AbSKPGrr>; Sat, 16 Nov 2002 01:47:47 -0500
Date: Sat, 16 Nov 2002 01:53:57 -0500
From: Akira Tsukamoto <at541@columbia.edu>
To: linux-kernel@vger.kernel.org
Subject: [CFT][PATCH]  2.5.47 Athlon/Druon, much faster copy_user function
Cc: Hirokazu Takahashi <taka@valinux.co.jp>, Andrew Morton <akpm@digeo.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andi Kleen <ak@suse.de>
Message-Id: <20021115235234.8DE4.AT541@columbia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at pop015.verizon.net from [138.89.33.207] at Sat, 16 Nov 2002 00:54:35 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a faster copy_to/from_user function for athlon/duron.
(300% faster in file read/write?)

L2 cache size for Athlon(256)/Duron(64) should be adjusted on run-time.

I appreciate trying this patch who owns Athlon/Duron CPU.

1)
I have been using Taka’s file or socket benchmark program for 
this purpose, if any better testing tools?
On the benchmark, athlon copy function is extremely fast.

read/write file test
http://dns.suna-asobi.com/~akira-t/linux/taka-bench/fileio2.c
org-copy: file read/write
buf(0x886e000) copied 24.0 Mbytes in 0.080 seconds at 299.4 Mbytes/sec
buf(0x886e001) copied 24.0 Mbytes in 0.129 seconds at 186.7 Mbytes/sec
buf(0x886e002) copied 24.0 Mbytes in 0.129 seconds at 186.4 Mbytes/sec
buf(0x886e003) copied 24.0 Mbytes in 0.129 seconds at 185.7 Mbytes/sec
(Entire log is here, http://dns.suna-asobi.com/~akira-t/linux/taka-bench/org-copy-file.log)
athlon-fast_copy: file read/write
buf(0x886e000) copied 24.0 Mbytes in 0.025 seconds at 959.2 Mbytes/sec
buf(0x886e001) copied 24.0 Mbytes in 0.032 seconds at 745.8 Mbytes/sec
buf(0x886e002) copied 24.0 Mbytes in 0.033 seconds at 731.4 Mbytes/sec
buf(0x886e003) copied 24.0 Mbytes in 0.032 seconds at 742.7 Mbytes/sec
(Entire log is here, http://dns.suna-asobi.com/~akira-t/linux/taka-bench/aki-copy-file.log)

network test
http://dns.suna-asobi.com/~akira-t/linux/taka-bench/netio2.c
org-copy: socket
0x846e000+0 -> 0x804e000+0 send/recv: 0.034387 seconds at 116.3 Mbytes/sec
0x846e000+1 -> 0x804e000+1 send/recv: 0.043644 seconds at 91.7 Mbytes/sec
0x846e000+2 -> 0x804e000+2 send/recv: 0.044038 seconds at 90.8 Mbytes/sec
0x846e000+3 -> 0x804e000+3 send/recv: 0.043457 seconds at 92.0 Mbytes/sec
(Entire log is here, http://dns.suna-asobi.com/~akira-t/linux/taka-bench/org-copy-net.log)
athlon-fast_copy: socket 
0x846e000+0 -> 0x804e000+0 send/recv: 0.019374 seconds at 206.5 Mbytes/sec
0x846e000+1 -> 0x804e000+1 send/recv: 0.036772 seconds at 108.8 Mbytes/sec
0x846e000+2 -> 0x804e000+2 send/recv: 0.037353 seconds at 107.1 Mbytes/sec
0x846e000+3 -> 0x804e000+3 send/recv: 0.040598 seconds at 98.5 Mbytes/sec
(Entire log is here, http://dns.suna-asobi.com/~akira-t/linux/taka-bench/aki-copy-net.log)

2) Last Friday was my first day to touch gcc assembler, and I really 
appreciate if there any suggestion for the aki_copy().  
Should I save all the mmx registers? I didn't but seems to work ok.

3) From the comment from Andi and Andrew last time, statically compiling 
for each CPU is not really optimal for the Linux distributors.  
I saw Denis Vlasenko’s csum_copy routines with boot-time selection, and 
it looked good. I think it is a good idea to do the same for the copy_user 
functions.

4) I think this is just a mistake in the current kernel.

config X86_INTEL_USERCOPY
 	bool
-	depends on MPENTIUM4 || MPENTIUMIII || M586MMX
+	depends on MPENTIUM4 || MPENTIUMIII || M686
 	default y

The intel_faster_copy is slower for Pentium MMX and faster for PenII.

Akira


--- linux-2.5.47/arch/i386/lib/usercopy.c	Thu Oct 31 22:40:01 2002
+++ linux-2.5.47-aki/arch/i386/lib/usercopy.c	Sat Nov 16 00:42:46 2002
@@ -337,6 +337,354 @@
 __copy_user_intel(void *to, const void *from,unsigned long size);
 #endif /* CONFIG_X86_INTEL_USERCOPY */
 
+#ifdef CONFIG_MK7
+/* Ahtlon version */
+/* akira version, specific to Athlon/Duron CPU
+ * 'size' must be larger than 256 */
+static unsigned long 
+aki_copy(void *to, const void *from, unsigned long size) {
+	__asm__ __volatile(
+			/* These are just saving it for later use */
+		"       movl %4, %%edx\n"
+		"       push %%edi\n"
+		"       movl %%ecx, %%ebx\n"
+			/* Athlon speeds up a lot when the address to read is 
+			 * aligned at 32bit(8bytes) boundary */
+		"       movl %%esi, %%ecx\n"
+		"       negl %%ecx\n"
+		"       andl $7, %%ecx\n"
+		"       subl %%ecx, %%ebx\n"
+		"80:    rep; movsb\n"
+			/* Here is one trick to speed up, it is prefetching
+			 * entire 'from' or up to L2 cache size, which ever is
+			 * smaller. 
+			 * I used movl instead of special instruction, such as
+			 * prefetch or prefetchnta because movl was faster 
+			 * when combining with movq, used in later. */
+		"       movl %%ebx, %%eax\n"
+		"       shrl $8, %%eax\n"
+		"       cmpl %%edx, %%eax\n"
+		"       jbe  10f\n"
+		"       movl %%edx, %%eax\n"
+		"       .align 2\n"
+		"10:    movl   0(%%esi, %%ecx), %%edx\n"
+		"11:    movl  64(%%esi, %%ecx), %%edx\n"
+		"12:    movl 128(%%esi, %%ecx), %%edx\n"
+		"13:    movl 192(%%esi, %%ecx), %%edx\n"
+		"       addl $256, %%ecx\n"
+		"       decl %%eax\n"
+		"       jnz  10b\n"
+		//                " femms\n"
+			/* Bulk transfer by using movq and movntq, every 
+			 * iteration 64 bytes. There is movl in the first line
+			 * but it is not a mistake. I put movl there because it
+			 * is a second prefetch for the next reading 
+			 * iteration, speeds up about 4 or 5%. */
+		"21:    movl %%ebx, %%ecx\n"
+		"       shrl $6, %%ecx\n"
+		"       .align 2\n"
+		"20:\n"
+		"       movl  64(%%esi), %%eax\n"
+		"30:    movq   (%%esi), %%mm0\n"
+		"31:    movq  8(%%esi), %%mm1\n"
+		"32:    movq 16(%%esi), %%mm2\n"
+		"33:    movq 24(%%esi), %%mm3\n"
+		"34:    movq 32(%%esi), %%mm4\n"
+		"35:    movq 40(%%esi), %%mm5\n"
+		"36:    movq 48(%%esi), %%mm6\n"
+		"37:    movq 56(%%esi), %%mm7\n"
+		"40:    movntq %%mm0,   (%%edi)\n"
+		"41:    movntq %%mm1,  8(%%edi)\n"
+		"42:    movntq %%mm2, 16(%%edi)\n"
+		"43:    movntq %%mm3, 24(%%edi)\n"
+		"44:    movntq %%mm4, 32(%%edi)\n"
+		"45:    movntq %%mm5, 40(%%edi)\n"
+		"46:    movntq %%mm6, 48(%%edi)\n"
+		"47:    movntq %%mm7, 56(%%edi)\n"
+		"       addl $64, %%esi\n"
+		"       addl $64, %%edi\n"
+		"       decl %%ecx\n"
+		"       jnz  20b\n"
+		"       sfence\n"
+		"       femms\n"
+			/* Finish the remaining data, which did not fit 
+			 * into 64 bytes.*/
+		"       movl %%ebx, %%ecx\n"
+		"       andl $0x3f, %%ecx\n"
+		"90:    rep; movsb\n"
+			/* This is a postfetch for the written data,
+			 * because the moved data is likely to be used right 
+			 * after this copy function but the movntq does not
+			 * leave them in the L2 cache, so doing it here. */
+#if 0
+		"       pop %%edi\n"
+		"       prefetchnta    (%%edi, %%ecx)\n"
+		"       prefetchnta  64(%%edi, %%ecx)\n"
+		"       prefetchnta 128(%%edi, %%ecx)\n"
+		"       prefetchnta 192(%%edi, %%ecx)\n"
+#endif
+#if 1			/* 0 turn off postfetch */
+		"       movl %%edi, %%eax\n"
+		"       popl %%edi\n"
+		"       subl %%edi, %%eax\n"
+		//		"       movl %%edx, %%edi\n"
+		"       shrl $8, %%eax\n"
+		"       jz   100f\n"
+		"       cmpl $256, %%eax\n"
+		"       jbe  50f\n"
+		"       movl $256, %%eax\n"
+		"       .align 2\n"
+		"50:\n"
+#if 0			/* 1 use 'prefetch' or 0 use movl for postfetch */
+		"       prefetcht0    (%%edi, %%ecx)\n"
+		"       prefetcht0  64(%%edi, %%ecx)\n"
+		"       prefetcht0 128(%%edi, %%ecx)\n"
+		"       prefetcht0 192(%%edi, %%ecx)\n"
+#else
+		//		"       prefetchnta 256(%%edi, %%ecx)\n"
+		"       movl   0(%%edi, %%ecx), %%edx\n"
+		"       movl  64(%%edi, %%ecx), %%edx\n"
+		"       movl 128(%%edi, %%ecx), %%edx\n"
+		"       movl 192(%%edi, %%ecx), %%edx\n"
+#endif
+		"       addl $256, %%ecx\n"
+		"       decl %%eax\n"
+		"       jnz  50b\n"
+		"       xorl %%ecx, %%ecx\n"
+#endif
+		"100:\n"
+
+		".section .fixup,\"ax\"\n"
+			/* Page fault occured during prefetch, go back and 
+			 * start data transfer. */
+		"1:\n"
+		"       jmp 21b\n"
+		"2:\n"
+		"3:\n"
+		"       sfence\n"
+		"       femms\n"
+		"       shll $6, %%ecx\n"
+		"       andl $0x3f, %%ebx\n"
+		"       addl %%ebx, %%ecx\n"
+		"       jmp 90b\n"
+		"8:\n"
+		"       addl %%ebx, %%ecx\n"
+		"99:\n"
+		"       popl %%edi\n"
+		"       jmp 100b\n"
+
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"       .align 4\n"
+		"       .long 10b, 1b\n"
+		"       .long 11b, 1b\n"
+		"       .long 12b, 1b\n"
+		"       .long 13b, 1b\n"
+#if 0
+		"       .long 20b, 2b\n"
+		"       .long 30b, 3b\n"
+		"       .long 31b, 3b\n"
+		"       .long 32b, 3b\n"
+		"       .long 33b, 3b\n"
+		"       .long 34b, 3b\n"
+		"       .long 35b, 3b\n"
+		"       .long 36b, 3b\n"
+		"       .long 37b, 3b\n"
+#endif
+		"       .long 40b, 3b\n"
+		"       .long 41b, 3b\n"
+		"       .long 42b, 3b\n"
+		"       .long 43b, 3b\n"
+		"       .long 44b, 3b\n"
+		"       .long 45b, 3b\n"
+		"       .long 46b, 3b\n"
+		"       .long 47b, 3b\n"
+		"       .long 80b, 8b\n"
+		"       .long 90b, 99b\n"
+		".previous"
+
+		: "=&c"(size)
+		: "0"(size), "D"(to), "S"(from), 
+		  "r"(current_cpu_data.x86_cache_size * 1024 / 256)
+		: "eax", "ebx", "edx", "memory");
+  return size;
+}
+
+static unsigned long 
+aki_copy_zeroing(void *to, const void *from, unsigned long size) {
+	__asm__ __volatile(
+			/* These are just saving it for later use */
+		"       movl %4, %%edx\n"
+		"       push %%edi\n"
+		"       movl %%ecx, %%ebx\n"
+			/* Athlon speeds up a lot when the address to read is 
+			 * aligned at 32bit(8bytes) boundary */
+		"       movl %%esi, %%ecx\n"
+		"       negl %%ecx\n"
+		"       andl $7, %%ecx\n"
+		"       subl %%ecx, %%ebx\n"
+		"80:    rep; movsb\n"
+			/* Here is one trick to speed up, it is prefetching
+			 * entire 'from' or up to L2 cache size, which ever is
+			 * smaller. 
+			 * I used movl instead of special instruction, such as
+			 * prefetch or prefetchnta because movl was faster 
+			 * when combining with movq, used in later. */
+		"       movl %%ebx, %%eax\n"
+		"       shrl $8, %%eax\n"
+		"       jz   11f\n"
+		"       cmpl %%edx, %%eax\n"
+		"       jbe  10f\n"
+		"       movl %%edx, %%eax\n"
+		"       .align 2\n"
+		"10:    movl 192(%%esi, %%ecx), %%edx\n"
+		"11:    movl   0(%%esi, %%ecx), %%edx\n"
+		"12:    movl  64(%%esi, %%ecx), %%edx\n"
+		"13:    movl 128(%%esi, %%ecx), %%edx\n"
+		"       addl $256, %%ecx\n"
+		"       decl %%eax\n"
+		"       jnz  10b\n"
+		//                " femms\n"
+			/* Bulk transfer by using movq and movntq, every 
+			 * iteration 64 bytes. There is movl in the first line
+			 * but it is not a mistake. I put movl there because it
+			 * is a second prefetch for the next reading 
+			 * iteration, speeds up about 4 or 5%. */
+		"21:    movl %%ebx, %%ecx\n"
+		"       shrl $6, %%ecx\n"
+		"       .align 2\n"
+		"20:\n"
+		"       movl  64(%%esi), %%eax\n"
+		"30:    movq   (%%esi), %%mm0\n"
+		"31:    movq  8(%%esi), %%mm1\n"
+		"32:    movq 16(%%esi), %%mm2\n"
+		"33:    movq 24(%%esi), %%mm3\n"
+		"34:    movq 32(%%esi), %%mm4\n"
+		"35:    movq 40(%%esi), %%mm5\n"
+		"36:    movq 48(%%esi), %%mm6\n"
+		"37:    movq 56(%%esi), %%mm7\n"
+		"40:    movntq %%mm0,   (%%edi)\n"
+		"41:    movntq %%mm1,  8(%%edi)\n"
+		"42:    movntq %%mm2, 16(%%edi)\n"
+		"43:    movntq %%mm3, 24(%%edi)\n"
+		"44:    movntq %%mm4, 32(%%edi)\n"
+		"45:    movntq %%mm5, 40(%%edi)\n"
+		"46:    movntq %%mm6, 48(%%edi)\n"
+		"47:    movntq %%mm7, 56(%%edi)\n"
+		"       addl $64, %%esi\n"
+		"       addl $64, %%edi\n"
+		"       decl %%ecx\n"
+		"       jnz  20b\n"
+		"       sfence\n"
+		"       femms\n"
+			/* Finish the remaining data, which did not fit 
+			 * into 64 bytes.*/
+		"       movl %%ebx, %%ecx\n"
+		"       andl $0x3f, %%ecx\n"
+		"90:    rep; movsb\n"
+			/* This is a postfetch for the written data,
+			 * because the moved data is likely to be used right 
+			 * after this copy function but the movntq does not
+			 * leave them in the L2 cache, so doing it here. */
+#if 0
+		"       popl %%edi\n"
+		"       prefetchnta    (%%edi, %%ecx)\n"
+		"       prefetchnta  64(%%edi, %%ecx)\n"
+		"       prefetchnta 128(%%edi, %%ecx)\n"
+		"       prefetchnta 192(%%edi, %%ecx)\n"
+#endif
+#if 1			/* 0 turn off postfetch */
+		"       movl %%edi, %%eax\n"
+		"       popl %%edi\n"
+		"       subl %%edi, %%eax\n"
+		//		"       movl %%edx, %%edi\n"
+		"       shrl $8, %%eax\n"
+		"       jz   100f\n"
+		"       cmpl $256, %%eax\n"
+		"       jbe  50f\n"
+		"       movl $256, %%eax\n"
+		"       .align 2\n"
+		"50:\n"
+#if 1			/* 1 use 'prefetch' or 0 use movl for postfetch */
+		"       prefetcht0    (%%edi, %%ecx)\n"
+		"       prefetcht0  64(%%edi, %%ecx)\n"
+		"       prefetcht0 128(%%edi, %%ecx)\n"
+		"       prefetcht0 192(%%edi, %%ecx)\n"
+#else
+		//		"       prefetchnta 256(%%edi, %%ecx)\n"
+		"       movl   0(%%edi, %%ecx), %%edx\n"
+		"       movl  64(%%edi, %%ecx), %%edx\n"
+		"       movl 128(%%edi, %%ecx), %%edx\n"
+		"       movl 192(%%edi, %%ecx), %%edx\n"
+#endif
+		"       addl $256, %%ecx\n"
+		"       decl %%eax\n"
+		"       jnz  50b\n"
+		"       xorl %%ecx, %%ecx\n"
+#endif
+		"100:\n"
+
+		".section .fixup,\"ax\"\n"
+			/* Page fault occured during prefetch, go back and 
+			 * start data transfer. */
+		"1:\n"
+		"       jmp 21b\n"
+		"2:\n"
+		"3:\n"
+		"       sfence\n"
+		"       femms\n"
+		"       shll $6, %%ecx\n"
+		"       andl $0x3f, %%ebx\n"
+		"       addl %%ebx, %%ecx\n"
+		"       jmp 90b\n"
+		"8:\n"
+		"       addl %%ebx, %%ecx\n"
+		"99:\n"
+		"       movl %%ecx, %%ebx\n"
+		"       xorl %%eax,%%eax\n"
+		"       rep; stosb\n"
+		"       movl %%ebx, %%ecx\n"
+		"       popl %%edi\n"
+		"       jmp 100b\n"
+
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"       .align 4\n"
+		"       .long 10b, 1b\n"
+		"       .long 11b, 1b\n"
+		"       .long 12b, 1b\n"
+		"       .long 13b, 1b\n"
+		"       .long 20b, 2b\n"
+		"       .long 30b, 3b\n"
+		"       .long 31b, 3b\n"
+		"       .long 32b, 3b\n"
+		"       .long 33b, 3b\n"
+		"       .long 34b, 3b\n"
+		"       .long 35b, 3b\n"
+		"       .long 36b, 3b\n"
+		"       .long 37b, 3b\n"
+#if 0
+		"       .long 40b, 3b\n"
+		"       .long 41b, 3b\n"
+		"       .long 42b, 3b\n"
+		"       .long 43b, 3b\n"
+		"       .long 44b, 3b\n"
+		"       .long 45b, 3b\n"
+		"       .long 46b, 3b\n"
+		"       .long 47b, 3b\n"
+#endif
+		"       .long 80b, 8b\n"
+		"       .long 90b, 99b\n"
+		".previous"
+
+		: "=&c"(size)
+		: "0"(size), "D"(to), "S"(from), 
+		  "r"(current_cpu_data.x86_cache_size * 1024 / 256)
+		: "eax", "ebx", "edx", "memory");
+  return size;
+}
+#endif /* CONFIG_MK7 */
+
 /* Generic arbitrary sized copy.  */
 #define __copy_user(to,from,size)					\
 do {									\
@@ -416,7 +764,25 @@
 		: "memory");						\
 } while (0)
 
+#ifdef CONFIG_MK7
+unsigned long __copy_to_user(void *to, const void *from, unsigned long n)
+{
+	if (n < 256)
+		__copy_user(to, from, n);
+	else
+		n = aki_copy(to, from, n);
+	return n;
+}
 
+unsigned long __copy_from_user(void *to, const void *from, unsigned long n)
+{
+	if (n < 256)
+		__copy_user_zeroing(to, from, n);
+	else 
+		n = aki_copy_zeroing(to, from, n);
+	return n;
+}
+#else
 unsigned long __copy_to_user(void *to, const void *from, unsigned long n)
 {
 	if (movsl_is_ok(to, from, n))
@@ -434,6 +800,7 @@
 		n = __copy_user_zeroing_intel(to, from, n);
 	return n;
 }
+#endif /* CONFIG_MK7 */
 
 unsigned long copy_to_user(void *to, const void *from, unsigned long n)
 {


