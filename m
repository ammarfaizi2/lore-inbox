Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWANMrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWANMrT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 07:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWANMqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 07:46:10 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:12194 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751229AbWANMqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 07:46:05 -0500
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Date: Sat, 14 Jan 2006 14:46:04 +0200
Message-Id: <20060114122412.068398000@localhost>
References: <20060114122249.246354000@localhost>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: [patch 03/10] slab: have index_of bug at compile time
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

I noticed the code for index_of is a creative way of finding the cache
index using the compiler to optimize to a single hard coded number.  But
I couldn't help noticing that it uses two methods to let you know that
someone used it wrong.  One is at compile time (the correct way), and
the other is at run time (not good).

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Manfred Spraul <manfred@colorfullife.com>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 mm/slab.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -314,6 +314,8 @@ struct kmem_list3 __initdata initkmem_li
  */
 static __always_inline int index_of(const size_t size)
 {
+	extern void __bad_size(void);
+
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 
@@ -324,12 +326,9 @@ static __always_inline int index_of(cons
 		i++;
 #include "linux/kmalloc_sizes.h"
 #undef CACHE
-		{
-			extern void __bad_size(void);
-			__bad_size();
-		}
+		__bad_size();
 	} else
-		BUG();
+		__bad_size();
 	return 0;
 }
 

--

