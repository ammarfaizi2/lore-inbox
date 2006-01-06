Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWAFKpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWAFKpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 05:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWAFKpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 05:45:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12691 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932205AbWAFKpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 05:45:30 -0500
Subject: [patch 3/7]  mark several functions __always_inline
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu
In-Reply-To: <1136543825.2940.8.camel@laptopd505.fenrus.org>
References: <1136543825.2940.8.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 11:39:59 +0100
Message-Id: <1136543999.2940.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Mark several functions as __always_inline
From: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>

This patch marks a number of functions as 'must inline'. The functions affected
by this patch need to be inlined because they use knowledge that their arguments 
are constant so that most of the function optimizes away. At this point this patch 
does not change behavior, it's for documentation only (and for future patches in the
inline series)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@infradead.org>

----


Index: linux-2.6.15/include/asm-i386/bitops.h
===================================================================
--- linux-2.6.15.orig/include/asm-i386/bitops.h
+++ linux-2.6.15/include/asm-i386/bitops.h
@@ -247,7 +247,7 @@ static inline int test_and_change_bit(in
 static int test_bit(int nr, const volatile void * addr);
 #endif
 
-static inline int constant_test_bit(int nr, const volatile unsigned long *addr)
+static __always_inline int constant_test_bit(int nr, const volatile unsigned long *addr)
 {
 	return ((1UL << (nr & 31)) & (addr[nr >> 5])) != 0;
 }
Index: linux-2.6.15/include/asm-i386/current.h
===================================================================
--- linux-2.6.15.orig/include/asm-i386/current.h
+++ linux-2.6.15/include/asm-i386/current.h
@@ -5,7 +5,7 @@
 
 struct task_struct;
 
-static inline struct task_struct * get_current(void)
+static __always_inline struct task_struct * get_current(void)
 {
 	return current_thread_info()->task;
 }
Index: linux-2.6.15/include/asm-i386/string.h
===================================================================
--- linux-2.6.15.orig/include/asm-i386/string.h
+++ linux-2.6.15/include/asm-i386/string.h
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
Index: linux-2.6.15/include/linux/mm.h
===================================================================
--- linux-2.6.15.orig/include/linux/mm.h
+++ linux-2.6.15/include/linux/mm.h
@@ -507,7 +507,7 @@ static inline void set_page_links(struct
 extern struct page *mem_map;
 #endif
 
-static inline void *lowmem_page_address(struct page *page)
+static __always_inline void *lowmem_page_address(struct page *page)
 {
 	return __va(page_to_pfn(page) << PAGE_SHIFT);
 }
Index: linux-2.6.15/include/asm-i386/uaccess.h
===================================================================
--- linux-2.6.15.orig/include/asm-i386/uaccess.h
+++ linux-2.6.15/include/asm-i386/uaccess.h
@@ -411,7 +411,7 @@ unsigned long __must_check __copy_from_u
  * Returns number of bytes that could not be copied.
  * On success, this will be zero.
  */
-static inline unsigned long __must_check
+static __always_inline unsigned long __must_check
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
 	if (__builtin_constant_p(n)) {
@@ -432,7 +432,7 @@ __copy_to_user_inatomic(void __user *to,
 	return __copy_to_user_ll(to, from, n);
 }
 
-static inline unsigned long __must_check
+static __always_inline unsigned long __must_check
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
        might_sleep();
@@ -456,7 +456,7 @@ __copy_to_user(void __user *to, const vo
  * If some data could not be copied, this function will pad the copied
  * data to the requested size using zero bytes.
  */
-static inline unsigned long
+static __always_inline unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
 	if (__builtin_constant_p(n)) {
@@ -477,7 +477,7 @@ __copy_from_user_inatomic(void *to, cons
 	return __copy_from_user_ll(to, from, n);
 }
 
-static inline unsigned long
+static __always_inline unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
        might_sleep();
Index: linux-2.6.15/include/asm-x86_64/uaccess.h
===================================================================
--- linux-2.6.15.orig/include/asm-x86_64/uaccess.h
+++ linux-2.6.15/include/asm-x86_64/uaccess.h
@@ -244,7 +244,7 @@ extern unsigned long copy_to_user(void _
 extern unsigned long copy_from_user(void *to, const void __user *from, unsigned len); 
 extern unsigned long copy_in_user(void __user *to, const void __user *from, unsigned len); 
 
-static inline int __copy_from_user(void *dst, const void __user *src, unsigned size) 
+static __always_inline int __copy_from_user(void *dst, const void __user *src, unsigned size) 
 { 
        int ret = 0;
 	if (!__builtin_constant_p(size))
@@ -273,7 +273,7 @@ static inline int __copy_from_user(void 
 	}
 }	
 
-static inline int __copy_to_user(void __user *dst, const void *src, unsigned size) 
+static __always_inline int __copy_to_user(void __user *dst, const void *src, unsigned size) 
 { 
        int ret = 0;
 	if (!__builtin_constant_p(size))
@@ -305,7 +305,7 @@ static inline int __copy_to_user(void __
 }	
 
 
-static inline int __copy_in_user(void __user *dst, const void __user *src, unsigned size) 
+static __always_inline int __copy_in_user(void __user *dst, const void __user *src, unsigned size) 
 { 
        int ret = 0;
 	if (!__builtin_constant_p(size))


