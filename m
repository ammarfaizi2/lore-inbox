Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVL3JlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVL3JlL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 04:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVL3JlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 04:41:10 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:20669 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751233AbVL3JlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 04:41:09 -0500
Date: Fri, 30 Dec 2005 10:40:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Jakub Jelinek <jakub@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230094045.GA5799@elte.hu>
References: <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051229143846.GA18833@infradead.org> <1135868049.2935.49.camel@laptopd505.fenrus.org> <20051229153529.GH3811@stusta.de> <20051229154241.GY22293@devserv.devel.redhat.com> <p73oe2zexx9.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73oe2zexx9.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> There are important exceptions like: 
> 
> - Code that really wants to do compile time constant resolution
> (like the x86 copy_*_user)  and even throws linker errors when wrong.
> - Anything in a include file (otherwise it gets duplicated for
> every #include which can actually increase text size a lot) 
> - There is some code which absolutely needs inline in the x86-64 
> vsyscall code.
> 
> But arguably they should be force_inline.

FYI, i picked up a couple of those in the 3rd patch that i sent 
yesterday (see below too). That patch marks a handful of functions 
__always_inline. This improved size by another 2-3%. Not bad from a 
small patch:

 asm-i386/apic.h        |    6 +++---
 asm-i386/bitops.h      |    2 +-
 asm-i386/current.h     |    2 +-
 asm-i386/string.h      |    8 ++++----
 linux/buffer_head.h    |   10 +++++-----
 linux/byteorder/swab.h |   18 +++++++++---------
 linux/mm.h             |    2 +-
 linux/slab.h           |    2 +-
 8 files changed, 25 insertions(+), 25 deletions(-)

> I'm not quite sure I buy Ingo's original argument also.  If he's only 
> looking at text size then with the above fixed then he ideally would 
> like to not inline anything (because except these exceptions above 
> .text usually near always shrinks when not inlining). But that's not 
> necessarily best for performance.

well, i think the numbers talk for themselves. Here are my latest 
results:

---- 
The effect of the patches on x86, using a generic .config is:

    text    data     bss     dec     hex filename
 3286166  869852  387260 4543278  45532e vmlinux-orig
 3194123  955168  387260 4536551  4538e7 vmlinux-inline
 3119495  884960  387748 4392203  43050b vmlinux-inline+units
 3051709  869380  387748 4308837  41bf65 vmlinux-inline+units+fixes
 3049357  868928  387748 4306033  41b471 vmlinux-inline+units+fixes+capable

i.e. a 7.8% code-size reduction. Using a tiny .config gives:

   text    data     bss     dec     hex filename
 437271   77646   32192  547109   85925 vmlinux-orig
 452694   77646   32192  562532   89564 vmlinux-inline
 431891   77422   32128  541441   84301 vmlinux-inline+units
 414803   77422   32128  524353   80041 vmlinux-inline+units+fixes
 414020   77422   32128  523570   7fd32 vmlinux-inline+units+fixes+capable

or an 5.6% reduction.

i've also done test-builds with CC_OPTIMIZE_FOR_SIZE disabled:

    text    data     bss     dec     hex filename
 4080998  870384  387260 5338642  517612 vmlinux-orig
 4084421  872024  387260 5343705  5189d9 vmlinux-inline
 4010957  834048  387748 5232753  4fd871 vmlinux-inline+units
 4010039  833112  387748 5230899  4fd133 vmlinux-inline+units+fixes
 4007617  833120  387748 5228485  4fc7c5 vmlinux-inline+units+fixes+capable

or a 1.8% code size reduction.

	Ingo

--------
Subject: mark a handful of inline functions as 'must inline'

this patch marks a number of functions as 'must inline' - so that they
get inlined even if optimizing for size. This patch gives another 2-3%
of size saved, when CONFIG_CC_OPTIMIZE_FOR_SIZE is enabled.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 include/asm-i386/apic.h        |    6 +++---
 include/asm-i386/bitops.h      |    2 +-
 include/asm-i386/current.h     |    2 +-
 include/asm-i386/string.h      |    8 ++++----
 include/linux/buffer_head.h    |   10 +++++-----
 include/linux/byteorder/swab.h |   18 +++++++++---------
 include/linux/mm.h             |    2 +-
 include/linux/slab.h           |    2 +-
 8 files changed, 25 insertions(+), 25 deletions(-)

Index: linux-gcc.q/include/asm-i386/apic.h
===================================================================
--- linux-gcc.q.orig/include/asm-i386/apic.h
+++ linux-gcc.q/include/asm-i386/apic.h
@@ -49,17 +49,17 @@ static inline void lapic_enable(void)
  * Basic functions accessing APICs.
  */
 
-static __inline void apic_write(unsigned long reg, unsigned long v)
+static __always_inline void apic_write(unsigned long reg, unsigned long v)
 {
 	*((volatile unsigned long *)(APIC_BASE+reg)) = v;
 }
 
-static __inline void apic_write_atomic(unsigned long reg, unsigned long v)
+static __always_inline void apic_write_atomic(unsigned long reg, unsigned long v)
 {
 	xchg((volatile unsigned long *)(APIC_BASE+reg), v);
 }
 
-static __inline unsigned long apic_read(unsigned long reg)
+static __always_inline unsigned long apic_read(unsigned long reg)
 {
 	return *((volatile unsigned long *)(APIC_BASE+reg));
 }
Index: linux-gcc.q/include/asm-i386/bitops.h
===================================================================
--- linux-gcc.q.orig/include/asm-i386/bitops.h
+++ linux-gcc.q/include/asm-i386/bitops.h
@@ -247,7 +247,7 @@ static inline int test_and_change_bit(in
 static int test_bit(int nr, const volatile void * addr);
 #endif
 
-static inline int constant_test_bit(int nr, const volatile unsigned long *addr)
+static __always_inline int constant_test_bit(int nr, const volatile unsigned long *addr)
 {
 	return ((1UL << (nr & 31)) & (addr[nr >> 5])) != 0;
 }
Index: linux-gcc.q/include/asm-i386/current.h
===================================================================
--- linux-gcc.q.orig/include/asm-i386/current.h
+++ linux-gcc.q/include/asm-i386/current.h
@@ -5,7 +5,7 @@
 
 struct task_struct;
 
-static inline struct task_struct * get_current(void)
+static __always_inline struct task_struct * get_current(void)
 {
 	return current_thread_info()->task;
 }
Index: linux-gcc.q/include/asm-i386/string.h
===================================================================
--- linux-gcc.q.orig/include/asm-i386/string.h
+++ linux-gcc.q/include/asm-i386/string.h
@@ -201,7 +201,7 @@ __asm__ __volatile__(
 return __res;
 }
 
-static inline void * __memcpy(void * to, const void * from, size_t n)
+static __always_inline void * __memcpy(void * to, const void * from, size_t n)
 {
 int d0, d1, d2;
 __asm__ __volatile__(
@@ -223,7 +223,7 @@ return (to);
  * This looks ugly, but the compiler can optimize it totally,
  * as the count is constant.
  */
-static inline void * __constant_memcpy(void * to, const void * from, size_t n)
+static __always_inline void * __constant_memcpy(void * to, const void * from, size_t n)
 {
 	long esi, edi;
 	if (!n) return to;
@@ -367,7 +367,7 @@ return s;
  * things 32 bits at a time even when we don't know the size of the
  * area at compile-time..
  */
-static inline void * __constant_c_memset(void * s, unsigned long c, size_t count)
+static __always_inline void * __constant_c_memset(void * s, unsigned long c, size_t count)
 {
 int d0, d1;
 __asm__ __volatile__(
@@ -416,7 +416,7 @@ extern char *strstr(const char *cs, cons
  * This looks horribly ugly, but the compiler can optimize it totally,
  * as we by now know that both pattern and count is constant..
  */
-static inline void * __constant_c_and_count_memset(void * s, unsigned long pattern, size_t count)
+static __always_inline void * __constant_c_and_count_memset(void * s, unsigned long pattern, size_t count)
 {
 	switch (count) {
 		case 0:
Index: linux-gcc.q/include/linux/buffer_head.h
===================================================================
--- linux-gcc.q.orig/include/linux/buffer_head.h
+++ linux-gcc.q/include/linux/buffer_head.h
@@ -72,15 +72,15 @@ struct buffer_head {
  * and buffer_foo() functions.
  */
 #define BUFFER_FNS(bit, name)						\
-static inline void set_buffer_##name(struct buffer_head *bh)		\
+static __always_inline void set_buffer_##name(struct buffer_head *bh)	\
 {									\
 	set_bit(BH_##bit, &(bh)->b_state);				\
 }									\
-static inline void clear_buffer_##name(struct buffer_head *bh)		\
+static __always_inline void clear_buffer_##name(struct buffer_head *bh)	\
 {									\
 	clear_bit(BH_##bit, &(bh)->b_state);				\
 }									\
-static inline int buffer_##name(const struct buffer_head *bh)		\
+static __always_inline int buffer_##name(const struct buffer_head *bh)	\
 {									\
 	return test_bit(BH_##bit, &(bh)->b_state);			\
 }
@@ -89,11 +89,11 @@ static inline int buffer_##name(const st
  * test_set_buffer_foo() and test_clear_buffer_foo()
  */
 #define TAS_BUFFER_FNS(bit, name)					\
-static inline int test_set_buffer_##name(struct buffer_head *bh)	\
+static __always_inline int test_set_buffer_##name(struct buffer_head *bh)\
 {									\
 	return test_and_set_bit(BH_##bit, &(bh)->b_state);		\
 }									\
-static inline int test_clear_buffer_##name(struct buffer_head *bh)	\
+static __always_inline int test_clear_buffer_##name(struct buffer_head *bh)\
 {									\
 	return test_and_clear_bit(BH_##bit, &(bh)->b_state);		\
 }									\
Index: linux-gcc.q/include/linux/byteorder/swab.h
===================================================================
--- linux-gcc.q.orig/include/linux/byteorder/swab.h
+++ linux-gcc.q/include/linux/byteorder/swab.h
@@ -130,34 +130,34 @@
 #endif /* OPTIMIZE */
 
 
-static __inline__ __attribute_const__ __u16 __fswab16(__u16 x)
+static __always_inline __attribute_const__ __u16 __fswab16(__u16 x)
 {
 	return __arch__swab16(x);
 }
-static __inline__ __u16 __swab16p(const __u16 *x)
+static __always_inline __u16 __swab16p(const __u16 *x)
 {
 	return __arch__swab16p(x);
 }
-static __inline__ void __swab16s(__u16 *addr)
+static __always_inline void __swab16s(__u16 *addr)
 {
 	__arch__swab16s(addr);
 }
 
-static __inline__ __attribute_const__ __u32 __fswab32(__u32 x)
+static __always_inline __attribute_const__ __u32 __fswab32(__u32 x)
 {
 	return __arch__swab32(x);
 }
-static __inline__ __u32 __swab32p(const __u32 *x)
+static __always_inline __u32 __swab32p(const __u32 *x)
 {
 	return __arch__swab32p(x);
 }
-static __inline__ void __swab32s(__u32 *addr)
+static __always_inline void __swab32s(__u32 *addr)
 {
 	__arch__swab32s(addr);
 }
 
 #ifdef __BYTEORDER_HAS_U64__
-static __inline__ __attribute_const__ __u64 __fswab64(__u64 x)
+static __always_inline __attribute_const__ __u64 __fswab64(__u64 x)
 {
 #  ifdef __SWAB_64_THRU_32__
 	__u32 h = x >> 32;
@@ -167,11 +167,11 @@ static __inline__ __attribute_const__ __
 	return __arch__swab64(x);
 #  endif
 }
-static __inline__ __u64 __swab64p(const __u64 *x)
+static __always_inline __u64 __swab64p(const __u64 *x)
 {
 	return __arch__swab64p(x);
 }
-static __inline__ void __swab64s(__u64 *addr)
+static __always_inline void __swab64s(__u64 *addr)
 {
 	__arch__swab64s(addr);
 }
Index: linux-gcc.q/include/linux/mm.h
===================================================================
--- linux-gcc.q.orig/include/linux/mm.h
+++ linux-gcc.q/include/linux/mm.h
@@ -507,7 +507,7 @@ static inline void set_page_links(struct
 extern struct page *mem_map;
 #endif
 
-static inline void *lowmem_page_address(struct page *page)
+static __always_inline void *lowmem_page_address(struct page *page)
 {
 	return __va(page_to_pfn(page) << PAGE_SHIFT);
 }
Index: linux-gcc.q/include/linux/slab.h
===================================================================
--- linux-gcc.q.orig/include/linux/slab.h
+++ linux-gcc.q/include/linux/slab.h
@@ -76,7 +76,7 @@ struct cache_sizes {
 extern struct cache_sizes malloc_sizes[];
 extern void *__kmalloc(size_t, gfp_t);
 
-static inline void *kmalloc(size_t size, gfp_t flags)
+static __always_inline void *kmalloc(size_t size, gfp_t flags)
 {
 	if (__builtin_constant_p(size)) {
 		int i = 0;
