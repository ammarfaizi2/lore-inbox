Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWFMTy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWFMTy7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWFMTy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:54:58 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:2527 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932150AbWFMTyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:54:47 -0400
Date: Tue, 13 Jun 2006 21:54:46 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] i386 syscall opcode reordering (pipelining)
Message-ID: <20060613195446.GD24167@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'd guess that this version features improved pipeline parallelism,
since we isolate competing %ebx accesses (_syscall4()) and
stack push operations (_syscall5()), right?

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc6-mm2.orig/include/asm-i386/unistd.h linux-2.6.17-rc6-mm2.my/include/asm-i386/unistd.h
--- linux-2.6.17-rc6-mm2.orig/include/asm-i386/unistd.h	2006-06-13 19:28:15.000000000 +0200
+++ linux-2.6.17-rc6-mm2.my/include/asm-i386/unistd.h	2006-06-13 19:40:07.000000000 +0200
@@ -400,7 +400,7 @@
 type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5) \
 { \
 long __res; \
-__asm__ volatile ("push %%ebx ; movl %2,%%ebx ; movl %1,%%eax ; " \
+__asm__ volatile ("push %%ebx ; movl %1,%%eax ; movl %2,%%ebx ; " \
                   "int $0x80 ; pop %%ebx" \
 	: "=a" (__res) \
 	: "i" (__NR_##name),"ri" ((long)(arg1)),"c" ((long)(arg2)), \
@@ -415,8 +415,8 @@
 { \
 long __res; \
   struct { long __a1; long __a6; } __s = { (long)arg1, (long)arg6 }; \
-__asm__ volatile ("push %%ebp ; push %%ebx ; movl 4(%2),%%ebp ; " \
-                  "movl 0(%2),%%ebx ; movl %1,%%eax ; int $0x80 ; " \
+__asm__ volatile ("push %%ebp ; movl %1,%%eax ; push %%ebx ; " \
+                  "movl 4(%2),%%ebp ; movl 0(%2),%%ebx ; int $0x80 ; " \
                   "pop %%ebx ;  pop %%ebp" \
 	: "=a" (__res) \
 	: "i" (__NR_##name),"0" ((long)(&__s)),"c" ((long)(arg2)), \
