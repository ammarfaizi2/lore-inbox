Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267182AbUFZQJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267182AbUFZQJA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267183AbUFZQJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:09:00 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:45284 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267182AbUFZQIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:08:39 -0400
Subject: [PATCH] Fix the cpumask rewrite
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>
Cc: PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 Jun 2004 11:08:29 -0500
Message-Id: <1088266111.1943.15.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

ChangeSet 1.1828.1.25 2004/06/24 08:51:00 akpm@osdl.org
  [PATCH] cpumask: rewrite cpumask.h - single bitmap based implementation
  
  From: Paul Jackson <pj@sgi.com>
  
  Major rewrite of cpumask to use a single implementation, as a struct-wrapped
  bitmap.
 
Altered the cpumask iterators to add a volatile to the bitmap type. 
This might be correct for x86 and itanium, but it isn't for parisc where
our bitmap operators don't take volatile pointers.  This makes our
compile incredibly noisy in just about every file:

  CC      mm/rmap.o
In file included from include/linux/sched.h:15,
                 from include/linux/mm.h:4,
                 from mm/rmap.c:29:
include/linux/cpumask.h: In function `__cpu_set':
include/linux/cpumask.h:86: warning: passing arg 2 of `set_bit' discards
qualifiers from pointer target type
include/linux/cpumask.h: In function `__cpu_clear':
include/linux/cpumask.h:92: warning: passing arg 2 of `clear_bit'
discards qualifiers from pointer target type

Since whether the bitmap operators are volatile or not is within the
province of the architecture to decide, I think the correct fix is just
to drop the spurious volatiles from cpumask.h

James

===== include/linux/cpumask.h 1.15 vs edited =====
--- 1.15/include/linux/cpumask.h	2004-06-24 13:57:31 -05:00
+++ edited/include/linux/cpumask.h	2004-06-26 11:00:14 -05:00
@@ -81,13 +81,13 @@
 extern cpumask_t _unused_cpumask_arg_;
 
 #define cpu_set(cpu, dst) __cpu_set((cpu), &(dst))
-static inline void __cpu_set(int cpu, volatile cpumask_t *dstp)
+static inline void __cpu_set(int cpu, cpumask_t *dstp)
 {
 	set_bit(cpu, dstp->bits);
 }
 
 #define cpu_clear(cpu, dst) __cpu_clear((cpu), &(dst))
-static inline void __cpu_clear(int cpu, volatile cpumask_t *dstp)
+static inline void __cpu_clear(int cpu, cpumask_t *dstp)
 {
 	clear_bit(cpu, dstp->bits);
 }

