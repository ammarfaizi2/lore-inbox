Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWHaRxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWHaRxS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 13:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWHaRxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 13:53:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39059 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932422AbWHaRxR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 13:53:17 -0400
Date: Thu, 31 Aug 2006 10:53:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc5-git3 build error on i386 - include/asm/spinlock.h
In-Reply-To: <9a8748490608310115o288fe080pdac53e8d2b8d3f84@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0608311051230.27779@g5.osdl.org>
References: <9a8748490608310115o288fe080pdac53e8d2b8d3f84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Aug 2006, Jesper Juhl wrote:
>
> 2.6.18-rc5-git2 builds just fine, but with -git3 I get the following :

Yes, it was broken by a recent patch by Andi. It should be ok again now in 
my git tree.

For non-git users, here's the patch that should matter.

		Linus

----
commit 22db37ec5fd51b0c77b1dd5751b1cdc2672c08d6
Author: Chris Wright <chrisw@sous-sol.org>
Date:   Thu Aug 31 00:53:22 2006 -0700

    [PATCH] i386: rwlock.h fix smp alternatives fix
    
    Commit 8c74932779fc6f61b4c30145863a17125c1a296c ("i386: Remove
    alternative_smp") did not actually compile on x86 with CONFIG_SMP.
    
    This fixes the __build_read/write_lock helpers.  I've boot tested on
    SMP.
    
    [ Andi: "Oops, I think that was a quilt unrefreshed patch.  Sorry.  I
      fixed those before testing, but then still send out the old patch." ]
    
    Signed-off-by: Chris Wright <chrisw@sous-sol.org>
    Cc: Gerd Hoffmann <kraxel@suse.de>
    Acked-by: Andi Kleen <ak@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/include/asm-i386/rwlock.h b/include/asm-i386/rwlock.h
index 3ac1ba9..87c069c 100644
--- a/include/asm-i386/rwlock.h
+++ b/include/asm-i386/rwlock.h
@@ -21,21 +21,21 @@ #define RW_LOCK_BIAS		 0x01000000
 #define RW_LOCK_BIAS_STR	"0x01000000"
 
 #define __build_read_lock_ptr(rw, helper)   \
-	asm volatile(LOCK_PREFIX " ; subl $1,(%0)\n\t" \
+	asm volatile(LOCK_PREFIX " subl $1,(%0)\n\t" \
 			"jns 1f\n" \
 			"call " helper "\n\t" \
 			"1:\n" \
-			:"a" (rw) : "memory")
+			::"a" (rw) : "memory")
 
 #define __build_read_lock_const(rw, helper)   \
-	asm volatile(LOCK_PREFIX " ; subl $1,%0\n\t" \
+	asm volatile(LOCK_PREFIX " subl $1,%0\n\t" \
 			"jns 1f\n" \
 			"pushl %%eax\n\t" \
 			"leal %0,%%eax\n\t" \
 			"call " helper "\n\t" \
 			"popl %%eax\n\t" \
-			"1:\n" : \
-			"+m" (*(volatile int *)rw) : : "memory")
+			"1:\n" \
+			:"+m" (*(volatile int *)rw) : : "memory")
 
 #define __build_read_lock(rw, helper)	do { \
 						if (__builtin_constant_p(rw)) \
@@ -45,23 +45,21 @@ #define __build_read_lock(rw, helper)	do
 					} while (0)
 
 #define __build_write_lock_ptr(rw, helper) \
-	asm volatile(LOCK_PREFIX " ; subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
+	asm volatile(LOCK_PREFIX " subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
 			"jz 1f\n" \
 			"call " helper "\n\t" \
-			"1:\n", \
-			"subl $" RW_LOCK_BIAS_STR ",(%0)\n\t", \
-			:"a" (rw) : "memory")
+			"1:\n" \
+			::"a" (rw) : "memory")
 
 #define __build_write_lock_const(rw, helper) \
-	asm volatile(LOCK_PREFIX " ; subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
+	asm volatile(LOCK_PREFIX " subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
 			"jz 1f\n" \
 			"pushl %%eax\n\t" \
 			"leal %0,%%eax\n\t" \
 			"call " helper "\n\t" \
 			"popl %%eax\n\t" \
-			"1:\n", \
-			"subl $" RW_LOCK_BIAS_STR ",%0\n\t", \
-			"+m" (*(volatile int *)rw) : : "memory")
+			"1:\n" \
+			:"+m" (*(volatile int *)rw) : : "memory")
 
 #define __build_write_lock(rw, helper)	do { \
 						if (__builtin_constant_p(rw)) \
