Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbWACU2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbWACU2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWACUZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:25:53 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:38311 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964778AbWACUZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:25:48 -0500
Subject: [patch 3/9] slab: have index_of bug at compile time
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       colpatch@us.ibm.com, rostedt@goodmis.org, clameter@sgi.com,
       penberg@cs.helsinki.fi
Date: Tue, 03 Jan 2006 22:25:46 +0200
Message-Id: <1136319946.8629.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
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
@@ -315,6 +315,8 @@ struct kmem_list3 __initdata initkmem_li
  */
 static __always_inline int index_of(const size_t size)
 {
+	extern void __bad_size(void);
+
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 
@@ -325,12 +327,9 @@ static __always_inline int index_of(cons
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


