Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUIDNqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUIDNqQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 09:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUIDNqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 09:46:16 -0400
Received: from pxy2allmi.all.mi.charter.com ([24.247.15.40]:1476 "EHLO
	proxy2-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S262837AbUIDNp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 09:45:56 -0400
Message-ID: <4139C6E2.1050000@quark.didntduck.org>
Date: Sat, 04 Sep 2004 09:45:06 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040809
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] explicity align tss->stack
Content-Type: multipart/mixed;
 boundary="------------090405050206030806020203"
X-Charter-Information: 
X-Charter-Scan: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090405050206030806020203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Use an alignment attribute on the stack member of struct tss_struct 
instead of padding.  Also mark the limit of the TSS segment.

--
				Brian Gerst

--------------090405050206030806020203
Content-Type: text/plain;
 name="tss-stack-align"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tss-stack-align"

diff -urN linux-2.6.9-rc1-bk/include/asm-i386/desc.h linux/include/asm-i386/desc.h
--- linux-2.6.9-rc1-bk/include/asm-i386/desc.h	2004-08-25 11:52:00.000000000 -0400
+++ linux/include/asm-i386/desc.h	2004-09-04 09:20:29.216440282 -0400
@@ -47,7 +47,7 @@
 static inline void __set_tss_desc(unsigned int cpu, unsigned int entry, void *addr)
 {
 	_set_tssldt_desc(&per_cpu(cpu_gdt_table, cpu)[entry], (int)addr,
-		offsetof(struct tss_struct, __cacheline_filler) - 1, 0x89);
+		offsetof(struct tss_struct, tss_limit) - 1, 0x89);
 }
 
 #define set_tss_desc(cpu,addr) __set_tss_desc(cpu, GDT_ENTRY_TSS, addr)
diff -urN linux-2.6.9-rc1-bk/include/asm-i386/processor.h linux/include/asm-i386/processor.h
--- linux-2.6.9-rc1-bk/include/asm-i386/processor.h	2004-09-03 02:13:03.000000000 -0400
+++ linux/include/asm-i386/processor.h	2004-09-04 09:20:40.573961012 -0400
@@ -391,14 +391,11 @@
 	 * be within the limit.
 	 */
 	unsigned long	io_bitmap[IO_BITMAP_LONGS + 1];
-	/*
-	 * pads the TSS to be cacheline-aligned (size is 0x100)
-	 */
-	unsigned long __cacheline_filler[37];
+	unsigned long	tss_limit[0];
 	/*
 	 * .. and then another 0x100 bytes for emergency kernel stack
 	 */
-	unsigned long stack[64];
+	unsigned long	stack[64] __attribute__((aligned(0x100)));
 } __attribute__((packed));
 
 #define ARCH_MIN_TASKALIGN	16

--------------090405050206030806020203--
