Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUEWEoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUEWEoo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 00:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbUEWEon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 00:44:43 -0400
Received: from lakermmtao06.cox.net ([68.230.240.33]:7105 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262238AbUEWEol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 00:44:41 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <E71ABE1E-AC73-11D8-AD98-000393ACC76E@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [PATCH 2.6][REPOST] Missing _raw_write_trylock for PPC/SMP
Date: Sun, 23 May 2004 00:44:40 -0400
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just implemented _raw_write_trylock for PPC32  There are probably 
bugs in it as
I'm a little rusty on my PPC assembly.  It needs someone skilled in PPC 
asm to look
at it, but hopefully it will work.  It compiles, but nothing currently 
in the kernel proper
uses it aside from write_trylock which is also currently unused.

Cheers,
Kyle Moffett


--- linux-2.6.6/include/asm-ppc/spinlock.h	2004-05-09 
22:32:28.000000000 -0400
+++ linux/include/asm-ppc/spinlock.h	2004-05-20 20:12:44.000000000 -0400
@@ -135,6 +135,28 @@
  	: "cr0", "memory");
  }

+static __inline__ int _raw_write_trylock(rwlock_t *rw)
+{
+	unsigned int tmp;
+	unsigned int ret;
+	
+	__asm__ __volatile__(
+"1:     lwarx           %0,0,%2         # write_trylock\n\
+	cmpwi           0,%0,0\n\
+	li              %1,0\n\
+	bne-            2f\n"
+	PPC405_ERR77(0,%1)
+"       stwcx.          %3,0,%2\n\
+	bne-            1b\n\
+	li              %1,1\n\
+	isync\n\
+2:"     : "=&r"(tmp), "=&r"(ret)
+	: "r"(&rw->lock), "r"(-1)
+	: "cr0", "memory");
+	
+	return ret;
+}
+
  static __inline__ void _raw_write_lock(rwlock_t *rw)
  {
  	unsigned int tmp;

Cheers,
Kyle Moffett

