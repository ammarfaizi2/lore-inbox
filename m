Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUIMQK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUIMQK5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266487AbUIMQIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:08:43 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:25837 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S266096AbUIMQDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:03:48 -0400
Date: Mon, 13 Sep 2004 18:03:28 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Hugh Dickins <hugh@veritas.com>
cc: Alex Zarochentsev <zam@namesys.com>, Paul Jackson <pj@sgi.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined   
 atomic_sub_and_test
In-Reply-To: <Pine.LNX.4.44.0409131545100.17907-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0409131731400.877@scrub.home>
References: <Pine.LNX.4.44.0409131545100.17907-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Sep 2004, Hugh Dickins wrote:

> Go ahead and send the patches changing all the arches that have it to
> define __ARCH_HAS_ATOMIC_SUB_AND_TEST, and add asm-generic/atomic.h
> for those that don't etc; but to me that seems like a waste of time -

Well, just doing it for atomic_sub_and_test would indeed be not really 
useful, but adding the missing macros isn't that difficult.
I'm still curious what's up with this portability argument...

bye, Roman

diff -ur linux-2.6.9-rc1-mm5.org/include/asm-arm/atomic.h linux-2.6.9-rc1-mm5/include/asm-arm/atomic.h
--- linux-2.6.9-rc1-mm5.org/include/asm-arm/atomic.h	2004-09-13 17:28:55.000000000 +0200
+++ linux-2.6.9-rc1-mm5/include/asm-arm/atomic.h	2004-09-13 17:40:18.000000000 +0200
@@ -147,6 +147,8 @@
 #define atomic_sub(i, v)	(void) atomic_sub_return(i, v)
 #define atomic_dec(v)		(void) atomic_sub_return(1, v)
 
+#define atomic_add_and_test(i,v) (atomic_add_return((i), (v)) == 0)
+#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
 #define atomic_inc_and_test(v)	(atomic_add_return(1, v) == 0)
 #define atomic_dec_and_test(v)	(atomic_sub_return(1, v) == 0)
 #define atomic_inc_return(v)    (atomic_add_return(1, v))
diff -ur linux-2.6.9-rc1-mm5.org/include/asm-arm26/atomic.h linux-2.6.9-rc1-mm5/include/asm-arm26/atomic.h
--- linux-2.6.9-rc1-mm5.org/include/asm-arm26/atomic.h	2004-09-13 17:28:54.000000000 +0200
+++ linux-2.6.9-rc1-mm5/include/asm-arm26/atomic.h	2004-09-13 17:56:11.000000000 +0200
@@ -123,6 +123,9 @@
 	return atomic_add_return(-i, v);
 }
 
+#define atomic_add_and_test(i,v)	(atomic_add_return((i), (v)) == 0)
+#define atomic_sub_and_test(i,v)	(atomic_sub_return((i), (v)) == 0)
+#define atomic_inc_and_test(v)		(atomic_add_return(1, v) == 0)
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
diff -ur linux-2.6.9-rc1-mm5.org/include/asm-h8300/atomic.h linux-2.6.9-rc1-mm5/include/asm-h8300/atomic.h
--- linux-2.6.9-rc1-mm5.org/include/asm-h8300/atomic.h	2004-06-17 10:40:26.000000000 +0200
+++ linux-2.6.9-rc1-mm5/include/asm-h8300/atomic.h	2004-09-13 17:45:43.000000000 +0200
@@ -26,6 +26,7 @@
 
 #define atomic_add(i, v) atomic_add_return(i, v)
 #define atomic_add_negative(a, v)	(atomic_add_return((a), (v)) < 0)
+#define atomic_add_and_test(i,v)	(atomic_add_return((i), (v)) == 0)
 
 static __inline__ int atomic_sub_return(int i, atomic_t *v)
 {
@@ -37,6 +38,7 @@
 }
 
 #define atomic_sub(i, v) atomic_sub_return(i, v)
+#define atomic_sub_and_test(i,v)	(atomic_sub_return((i), (v)) == 0)
 
 static __inline__ int atomic_inc_return(atomic_t *v)
 {
diff -ur linux-2.6.9-rc1-mm5.org/include/asm-parisc/atomic.h linux-2.6.9-rc1-mm5/include/asm-parisc/atomic.h
--- linux-2.6.9-rc1-mm5.org/include/asm-parisc/atomic.h	2004-06-17 10:41:22.000000000 +0200
+++ linux-2.6.9-rc1-mm5/include/asm-parisc/atomic.h	2004-09-13 17:46:19.000000000 +0200
@@ -196,8 +196,10 @@
  * other cases.
  */
 #define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+#define atomic_add_and_test(i,v) (atomic_add_return((i), (v)) == 0)
 
 #define atomic_dec_and_test(v)	(atomic_dec_return(v) == 0)
+#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
 
 #define ATOMIC_INIT(i)	{ (i) }
 
diff -ur linux-2.6.9-rc1-mm5.org/include/asm-s390/atomic.h linux-2.6.9-rc1-mm5/include/asm-s390/atomic.h
--- linux-2.6.9-rc1-mm5.org/include/asm-s390/atomic.h	2004-06-17 10:41:39.000000000 +0200
+++ linux-2.6.9-rc1-mm5/include/asm-s390/atomic.h	2004-09-13 17:51:17.000000000 +0200
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
diff -ur linux-2.6.9-rc1-mm5.org/include/asm-sparc/atomic.h linux-2.6.9-rc1-mm5/include/asm-sparc/atomic.h
--- linux-2.6.9-rc1-mm5.org/include/asm-sparc/atomic.h	2004-06-17 10:41:51.000000000 +0200
+++ linux-2.6.9-rc1-mm5/include/asm-sparc/atomic.h	2004-09-13 17:51:52.000000000 +0200
@@ -44,8 +44,10 @@
  * other cases.
  */
 #define atomic_inc_and_test(v) (atomic_inc_return(v) == 0)
+#define atomic_add_and_test(i,v) (atomic_add_return((i), (v)) == 0)
 
 #define atomic_dec_and_test(v) (atomic_dec_return(v) == 0)
+#define atomic_sub_and_test(i,v) (atomic_sub_return((i), (v)) == 0)
 
 /* This is the old 24-bit implementation.  It's still used internally
  * by some sparc-specific code, notably the semaphore implementation.
