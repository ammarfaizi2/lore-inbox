Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVLUPes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVLUPes (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLUPes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:34:48 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:64501 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932435AbVLUPes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:34:48 -0500
Subject: [PATCH] SLAB - have index_of bug at compile time.
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Andrew Morton <akpm@osdl.org>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>, Shai Fultheim <shai@scalex86.org>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Christoph Lameter <christoph@lameter.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0512210803280.28477@gandalf.stny.rr.com>
References: <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
	 <1135093460.13138.302.camel@localhost.localdomain>
	 <20051220181921.GF3356@waste.org>
	 <1135106124.13138.339.camel@localhost.localdomain>
	 <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
	 <1135114971.13138.396.camel@localhost.localdomain>
	 <20051221065619.GC766@elte.hu>
	 <Pine.LNX.4.58.0512210909040.23799@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.58.0512210803280.28477@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 10:34:07 -0500
Message-Id: <1135179247.14810.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  after all the talk over SLAB and SLOBs I decided to make myself
useful, and I'm trying very hard to understand the Linux implementation
of SLAB.  So I'm going through ever line of code and examining it
thoroughly, when I find something that could be improved, either
performance wise (highly doubtful), clean up wise, documentation wise,
enhancement wise, or just have a question, I'll make myself known.

This email is enhancement wise. ;)

I noticed the code for index_of is a creative way of finding the cache
index using the compiler to optimize to a single hard coded number.  But
I couldn't help noticing that it uses two methods to let you know that
someone used it wrong.  One is at compile time (the correct way), and
the other is at run time (not good).

OK, this isn't really an enhancement since the code already works. But
this change can help those later who do real enhancements to SLAB.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.15-rc6/mm/slab.c
===================================================================
--- linux-2.6.15-rc6.orig/mm/slab.c	2005-12-20 16:47:05.000000000 -0500
+++ linux-2.6.15-rc6/mm/slab.c	2005-12-21 10:20:03.000000000 -0500
@@ -315,6 +315,8 @@
  */
 static __always_inline int index_of(const size_t size)
 {
+	extern void __bad_size(void);
+
 	if (__builtin_constant_p(size)) {
 		int i = 0;
 
@@ -325,12 +327,9 @@
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
 


