Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268246AbUIMRPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268246AbUIMRPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 13:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268298AbUIMRPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 13:15:39 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:12009 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S268246AbUIMRPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 13:15:34 -0400
Date: Mon, 13 Sep 2004 19:14:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: hugh@veritas.com
Cc: zippel@linux-m68k.org, zam@namesys.com, pj@sgi.com, wli@holomorphy.com,
       reiser@namesys.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined    atomic_sub_and_test
Message-ID: <20040913171435.GA3566@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > But Bill already said he doesn't want it, [...]
> > > 
> > > -		 		 if (atomic_sub_and_test(bio->bi_vcnt, &fq->nr_submitted))
> > > +		 		 if (atomic_sub_return(bio->bi_vcnt, &fq->nr_submitted) == 0)
> > 
> > And that is more portable how?
> 
> It's more portable in that all but s390 already provide it
> (and I expect Martin will be happy to add it).

Well, adding the missing s390 atomic operations is easy (see patch).
But I really doubt that it will make a measurable difference in
performance on ANY architecture. You could do this with a
(atomic_add_return(-x, &v) == 0) ...

blue skies,
  Martin.

---

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add atomic[64]_add_and_test, atomic[64]_sub_return and
atomic[64]_sub_and_test primitives.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 include/asm-s390/atomic.h |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

diff -urN linux-2.6/include/asm-s390/atomic.h linux-2.6-s390/include/asm-s390/atomic.h
--- linux-2.6/include/asm-s390/atomic.h	2004-08-14 12:54:48.000000000 +0200
+++ linux-2.6-s390/include/asm-s390/atomic.h	2004-09-13 19:04:13.000000000 +0200
@@ -53,6 +53,10 @@
 {
 	return __CS_LOOP(v, i, "ar");
 }
+static __inline__ int atomic_add_and_test(int i, atomic_t * v)
+{
+	return __CS_LOOP(v, i, "ar") == 0;
+}
 static __inline__ int atomic_add_negative(int i, atomic_t * v)
 {
 	return __CS_LOOP(v, i, "ar") < 0;
@@ -61,6 +65,14 @@
 {
 	       __CS_LOOP(v, i, "sr");
 }
+static __inline__ int atomic_sub_return(int i, atomic_t * v)
+{
+	return __CS_LOOP(v, i, "sr");
+}
+static __inline__ int atomic_sub_and_test(int i, atomic_t * v)
+{
+	return __CS_LOOP(v, i, "sr") == 0;
+}
 static __inline__ void atomic_inc(volatile atomic_t * v)
 {
 	       __CS_LOOP(v, 1, "ar");
@@ -127,6 +139,10 @@
 {
 	return __CSG_LOOP(v, i, "agr");
 }
+static __inline__ long long atomic64_add_and_test(int i, atomic64_t * v)
+{
+	return __CSG_LOOP(v, i, "agr") == 0;
+}
 static __inline__ long long atomic64_add_negative(int i, atomic64_t * v)
 {
 	return __CSG_LOOP(v, i, "agr") < 0;
@@ -135,6 +151,14 @@
 {
 	       __CSG_LOOP(v, i, "sgr");
 }
+static __inline__ long long atomic64_sub_return(int i, atomic64_t * v)
+{
+	return __CSG_LOOP(v, i, "sgr");
+}
+static __inline__ long long atomic64_sub_and_test(int i, atomic64_t * v)
+{
+	return __CSG_LOOP(v, i, "agr") == 0;
+}
 static __inline__ void atomic64_inc(volatile atomic64_t * v)
 {
 	       __CSG_LOOP(v, 1, "agr");
