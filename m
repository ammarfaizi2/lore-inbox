Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSEGWpr>; Tue, 7 May 2002 18:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315235AbSEGWpq>; Tue, 7 May 2002 18:45:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1437 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315192AbSEGWpo>;
	Tue, 7 May 2002 18:45:44 -0400
Date: Tue, 07 May 2002 16:42:25 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Adrian Bunk <bunk@fs.tum.de>, Dave Jones <davej@suse.de>,
        Brian Gerst <bgerst@didntduck.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
Message-ID: <283120000.1020814945@flay>
In-Reply-To: <278490000.1020811234@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Compiling misc.c with -O0 gives a better error message:
>> 
>> <--  snip  -->
>> 
>> ...
>> ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o
>> piggy.o
>> misc.o: In function `outb_quad':
>> misc.o(.text+0x289c): undefined reference to `__io_virt_debug'
>> make[2]: *** [bvmlinux] Error 1
>> make[2]: Leaving directory
>> `/home/bunk/linux/kernel-2.5/linux-2.5.14-modular/arch/i386/boot/compressed'
> 
> Seems like you're not linking in lib/iodebug.c for some reason.
> 
> outb_quad calls readb, which calls __io_virt, which calls __io_virt_debug,
> which is defined in iodebug.c

Does this fix it ? (completely untested, and against an old version ... sorry).

--- virgin-2.5.9-dj1/arch/i386/boot/compressed/misc.c	Mon Apr 22 15:29:26 2002
+++ virgin-2.5.9-dj1/arch/i386/boot/compressed/misc.c.local	Tue May  7 16:39:39 2002
@@ -202,10 +202,10 @@
 	SCREEN_INFO.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
-	outb_p(14, vidport);
-	outb_p(0xff & (pos >> 9), vidport+1);
-	outb_p(15, vidport);
-	outb_p(0xff & (pos >> 1), vidport+1);
+	outb_p_local(14, vidport);
+	outb_p_local(0xff & (pos >> 9), vidport+1);
+	outb_p_local(15, vidport);
+	outb_p_local(0xff & (pos >> 1), vidport+1);
 }
 
 static void* memset(void* s, int c, size_t n)
--- virgin-2.5.9-dj1/include/asm-i386/io.h	Tue Apr 23 14:19:39 2002
+++ virgin-2.5.9-dj1/include/asm-i386/io.h.local	Tue May  7 16:38:56 2002
@@ -371,6 +371,15 @@
 	__asm__ __volatile__("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port)); \
 	return value; \
 } \
+static inline void out##bwl##_local_p(unsigned type value, int port) { \
+	out##bwl##_local(value, port); \
+	slow_down_io(); \
+} \
+static inline unsigned type in##bwl##_local_p(int port) { \
+	unsigned type value = in##bwl##_local(port); \
+	slow_down_io(); \
+	return value; \
+} \
 __BUILDIO(bwl,bw,type) \
 static inline void out##bwl##_p(unsigned type value, int port) { \
 	out##bwl(value, port); \

