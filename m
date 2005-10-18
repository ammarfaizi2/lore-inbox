Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVJRQD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVJRQD2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 12:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVJRQD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 12:03:28 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:23001 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750730AbVJRQD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 12:03:27 -0400
Date: Tue, 18 Oct 2005 11:03:24 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] build break in include/asm-x86_64/atomic.h
Message-ID: <20051018160323.GA10863@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While building the latest -mm kernel on x86-64, I hit a build break (see
below).

....
  CC [M]  fs/ntfs/namei.o
In file included from include/linux/dcache.h:6,
                 from fs/ntfs/namei.c:23:
include/asm/atomic.h:383: error: parse error before '*' token
include/asm/atomic.h:384: warning: function declaration isn't a 
prototype
include/asm/atomic.h: In function `atomic_scrub':
include/asm/atomic.h:385: error: `u32' undeclared (first use in this 
function)
include/asm/atomic.h:385: error: (Each undeclared identifier is reported 
only once
include/asm/atomic.h:385: error: for each function it appears in.)
include/asm/atomic.h:385: error: parse error before "i"
include/asm/atomic.h:386: error: `i' undeclared (first use in this 
function)
include/asm/atomic.h:386: error: `size' undeclared (first use in this 
function)
include/asm/atomic.h:386: error: `virt_addr' undeclared (first use in 
this function)
include/asm/atomic.h:386: warning: left-hand operand of comma expression 
has no effect
make[2]: *** [fs/ntfs/namei.o] Error 1
make[1]: *** [fs/ntfs] Error 2
make: *** [fs] Error 2

The problem is the atomic_scrub function is attempting to use 'u32', 
which is not defined at this point.  If the 'u32's are defined (by 
including <asm/types.h>) or changed to 'unsigned int', there is no 
problem (and the kernel compiles, boots, and runs perfectly).

Below is a patch which changes the 'u32' to 'unsigned int'.  

Signed-off-by: Jon Mason <jdmason@us.ibm.com>

--- linux-2.6.14-rc4-mm1/include/asm-x86_64/atomic.h.orig	2005-10-18 08:42:38.000000000 -0500
+++ linux-2.6.14-rc4-mm1/include/asm-x86_64/atomic.h	2005-10-18 08:24:20.000000000 -0500
@@ -380,9 +380,9 @@ __asm__ __volatile__(LOCK "orl %0,%1" \
 
 /* ECC atomic, DMA, SMP and interrupt safe scrub function */
 
-static __inline__ void atomic_scrub(u32 *virt_addr, u32 size)
+static __inline__ void atomic_scrub(unsigned int *virt_addr, unsigned int size)
 {
-	u32 i;
+	unsigned int i;
 	for (i = 0; i < size / 4; i++, virt_addr++)
 		/* Very carefully read and write to memory atomically
 		 * so we are interrupt, DMA and SMP safe.
