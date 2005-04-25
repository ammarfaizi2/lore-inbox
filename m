Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVDYHUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVDYHUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 03:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVDYHUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 03:20:08 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:58564 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262546AbVDYHT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 03:19:58 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] i386: optimize swab64
Date: Mon, 25 Apr 2005 10:19:30 +0300
User-Agent: KMail/1.5.4
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504251019.30173.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that swab64 explicitly swaps 32-bit halves, but this is
not really needed because CPU is 32-bit anyway and we can
just tell GCC to treat registers as being swapped.

Example of resulting code:

       mov    0x20(%ecx,%edi,8),%eax
       mov    0x24(%ecx,%edi,8),%edx
       lea    0x1(%edi),%esi
       mov    %esi,0xfffffdf4(%ebp)
       mov    %eax,%ebx
       mov    %edx,%esi
       bswap  %ebx
       bswap  %esi
       mov    %esi,0xffffff74(%ebp,%edi,8)
       mov    %ebx,0xffffff78(%ebp,%edi,8)

As you can see, swap is achieved simply by using
appropriate registers in last two insns.

(Why does gcc do extra register moves just before bswaps
is another question. No regression here, old code had them too)

Run-tested.
--
vda

diff -urpN linux-2.6.12-rc2.0.orig/include/asm-i386/byteorder.h linux-2.6.12-rc2.z.cur/include/asm-i386/byteorder.h
--- linux-2.6.12-rc2.0.orig/include/asm-i386/byteorder.h	Tue Oct 19 00:54:36 2004
+++ linux-2.6.12-rc2.z.cur/include/asm-i386/byteorder.h	Sun Apr 24 22:38:14 2005
@@ -25,6 +25,8 @@ static __inline__ __attribute_const__ __
 	return x;
 }

+/* NB: swap of 32-bit halves is achieved by asm constraints.
+** This will save a xchgl in many cases */
 static __inline__ __attribute_const__ __u64 ___arch__swab64(__u64 val)
 {
 	union {
@@ -33,13 +35,13 @@ static __inline__ __attribute_const__ __
 	} v;
 	v.u = val;
 #ifdef CONFIG_X86_BSWAP
-	asm("bswapl %0 ; bswapl %1 ; xchgl %0,%1"
-	    : "=r" (v.s.a), "=r" (v.s.b)
+	asm("bswapl %0 ; bswapl %1"
+	    : "=r" (v.s.b), "=r" (v.s.a)
 	    : "0" (v.s.a), "1" (v.s.b));
 #else
-   v.s.a = ___arch__swab32(v.s.a);
+	v.s.a = ___arch__swab32(v.s.a);
 	v.s.b = ___arch__swab32(v.s.b);
-	asm("xchgl %0,%1" : "=r" (v.s.a), "=r" (v.s.b) : "0" (v.s.a), "1" (v.s.b));
+	asm("" : "=r" (v.s.b), "=r" (v.s.a) : "0" (v.s.a), "1" (v.s.b));
 #endif
 	return v.u;
 }

