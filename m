Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUH1NTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUH1NTv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 09:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUH1NTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 09:19:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:10428 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265887AbUH1NTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 09:19:30 -0400
Date: Sat, 28 Aug 2004 15:19:18 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: clameter@sgi.com, paulus@samba.org, ak@muc.de, davem@davemloft.net,
       wli@holomorphy.com, davem@redhat.com, raybry@sgi.com,
       benh@kernel.crashing.org, manfred@colorfullife.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       vrajesh@umich.edu, hugh@veritas.com
Subject: Re: page fault scalability patch final : i386 tested, x86_64
 support added
Message-Id: <20040828151918.578c78f9.ak@suse.de>
In-Reply-To: <20040827223954.7d021aac.akpm@osdl.org>
References: <Pine.LNX.4.58.0408151924250.4480@schroedinger.engr.sgi.com>
	<20040816143903.GY11200@holomorphy.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B679F@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67A9@mtv-atc-605e--n.corp.sgi.com>
	<B6E8046E1E28D34EB815A11AC8CA3129027B67B4@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0408271616001.14712@schroedinger.engr.sgi.com>
	<20040827233602.GB1024@wotan.suse.de>
	<Pine.LNX.4.58.0408271717400.15597@schroedinger.engr.sgi.com>
	<20040827172337.638275c3.davem@davemloft.net>
	<20040827173641.5cfb79f6.akpm@osdl.org>
	<20040828010253.GA50329@muc.de>
	<20040827183940.33b38bc2.akpm@osdl.org>
	<16687.59671.869708.795999@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0408272021070.16607@schroedinger.engr.sgi.com>
	<20040827204241.25da512b.akpm@osdl.org>
	<Pine.LNX.4.58.0408272121300.16949@schroedinger.engr.sgi.com>
	<20040827223954.7d021aac.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 22:39:54 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > On Fri, 27 Aug 2004, Andrew Morton wrote:
> > 
> > > Christoph Lameter <clameter@sgi.com> wrote:
> > > >
> > > >  So I think the move to atomic for rss acceptable?
> > >
> > > Short-term, yes.  Longer term (within 12 months), no - 50-bit addresses on
> > > power5 will cause it to overflow.
> > 
> > I would expect the page size to rise as well. On IA64 we already have
> > 16KB-64KB pages corresponding to 256TB - 1PB. Having to manage a couple of
> > billion pages could be a significant performance impact. Better increase
> > the page size.
> 
> I don't know if that's an option on the power architecture.

On x86-64 it isn't an option.

> 
> And we need larger atomic types _anyway_ for page->_count.  An unprivileged
> app can mmap the same page 4G times and can then munmap it once.  Do it on
> purpose and it's a security hole.  Due it by accident and it's a crash.
> 
> > I still would also like to see atomic64_t. I think there was a patch
> > posted to linux-ia64 a couple of months back introducing atomic64_t but it
> > was rejected since it would not be supportable on other arches.
> 
> atomic64_t already appears to be implemented on alpha, ia64, mips, s390 and
> sparc64.

Here's a patch to add it to x86-64: 

-Andi

-------------------------------------------------------------------------------------

Add atomic64_t type to x86-64


diff -u linux-2.6.8-work/include/asm-x86_64/atomic.h-o linux-2.6.8-work/include/asm-x86_64/atomic.h
--- linux-2.6.8-work/include/asm-x86_64/atomic.h-o	2004-03-21 21:11:54.000000000 +0100
+++ linux-2.6.8-work/include/asm-x86_64/atomic.h	2004-08-28 15:15:46.000000000 +0200
@@ -178,6 +178,166 @@
 	return c;
 }
 
+/* An 64bit atomic type */ 
+
+typedef struct { volatile long counter; } atomic64_t;
+
+#define ATOMIC64_INIT(i)	{ (i) }
+
+/**
+ * atomic64_read - read atomic64 variable
+ * @v: pointer of type atomic64_t
+ * 
+ * Atomically reads the value of @v.
+ * Doesn't imply a read memory barrier.
+ */ 
+#define atomic64_read(v)		((v)->counter)
+
+/**
+ * atomic64_set - set atomic64 variable
+ * @v: pointer to type atomic64_t
+ * @i: required value
+ * 
+ * Atomically sets the value of @v to @i.
+ */ 
+#define atomic64_set(v,i)		(((v)->counter) = (i))
+
+/**
+ * atomic64_add - add integer to atomic64 variable
+ * @i: integer value to add
+ * @v: pointer to type atomic64_t
+ * 
+ * Atomically adds @i to @v.
+ */
+static __inline__ void atomic64_add(long i, atomic64_t *v)
+{
+	__asm__ __volatile__(
+		LOCK "addq %1,%0"
+		:"=m" (v->counter)
+		:"ir" (i), "m" (v->counter));
+}
+
+/**
+ * atomic64_sub - subtract the atomic64 variable
+ * @i: integer value to subtract
+ * @v: pointer to type atomic64_t
+ * 
+ * Atomically subtracts @i from @v.
+ */
+static __inline__ void atomic64_sub(long i, atomic64_t *v)
+{
+	__asm__ __volatile__(
+		LOCK "subq %1,%0"
+		:"=m" (v->counter)
+		:"ir" (i), "m" (v->counter));
+}
+
+/**
+ * atomic64_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer to type atomic64_t
+ * 
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __inline__ int atomic64_sub_and_test(long i, atomic64_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		LOCK "subq %2,%0; sete %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"ir" (i), "m" (v->counter) : "memory");
+	return c;
+}
+
+/**
+ * atomic64_inc - increment atomic64 variable
+ * @v: pointer to type atomic64_t
+ * 
+ * Atomically increments @v by 1.
+ */ 
+static __inline__ void atomic64_inc(atomic64_t *v)
+{
+	__asm__ __volatile__(
+		LOCK "incq %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+}
+
+/**
+ * atomic64_dec - decrement atomic64 variable
+ * @v: pointer to type atomic64_t
+ * 
+ * Atomically decrements @v by 1.
+ */ 
+static __inline__ void atomic64_dec(atomic64_t *v)
+{
+	__asm__ __volatile__(
+		LOCK "decq %0"
+		:"=m" (v->counter)
+		:"m" (v->counter));
+}
+
+/**
+ * atomic64_dec_and_test - decrement and test
+ * @v: pointer to type atomic64_t
+ * 
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */ 
+static __inline__ int atomic64_dec_and_test(atomic64_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		LOCK "decq %0; sete %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"m" (v->counter) : "memory");
+	return c != 0;
+}
+
+/**
+ * atomic64_inc_and_test - increment and test 
+ * @v: pointer to type atomic64_t
+ * 
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */ 
+static __inline__ int atomic64_inc_and_test(atomic64_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		LOCK "incq %0; sete %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"m" (v->counter) : "memory");
+	return c != 0;
+}
+
+/**
+ * atomic64_add_negative - add and test if negative
+ * @v: pointer to atomic64_t
+ * @i: integer value to add
+ * 
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */ 
+static __inline__ long atomic64_add_negative(long i, atomic64_t *v)
+{
+	unsigned char c;
+
+	__asm__ __volatile__(
+		LOCK "addq %2,%0; sets %1"
+		:"=m" (v->counter), "=qm" (c)
+		:"ir" (i), "m" (v->counter) : "memory");
+	return c;
+}
+
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
 __asm__ __volatile__(LOCK "andl %0,%1" \
