Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbTGLMRb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 08:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbTGLMRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 08:17:31 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:34746 "HELO
	develer.com") by vger.kernel.org with SMTP id S265422AbTGLMR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 08:17:29 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org
Subject: Re: 2.5.75 as-iosched.c & asm-generic/div64.h breakage (PATCH)
Date: Sat, 12 Jul 2003 14:31:41 +0200
User-Agent: KMail/1.5.9
Cc: axboe@suse.de, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200307112136.h6BLapXt005156@harpo.it.uu.se>
In-Reply-To: <200307112136.h6BLapXt005156@harpo.it.uu.se>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307121431.41737.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 July 2003 23:36, Mikael Pettersson wrote:

 > Perhaps, but it's my opinion that do_div() needs to be made more
 > robust, since arch-specific data abstraction means that callers in
 > generic code don't always know if some value is u32 or u64.
 >
 > So your change should be in do_div() itself, not in its callers.


Even if this sector_t case is to be done with sector_div(), I agree
that more type safety in do_div() would be a desidearable feature.

We can't turn do_div() into an inline, so we must resort to the
same "useless pointer compare" trick also employed by the min() and max()
macros. Actually, this change immediately helps finding few places where
do_div() was being used incorrectly.

I've tested on both m68knommu and i386 (replacing asm-i386/div64.h with
asm-generic/div64.h). 64bit platforms are unaffected by this patch.

Linus, please apply.

--------------------------------------------------------------------------

 - __div64_32(): remove __attribute_pure__ qualifier from the prototype
   since this function obviously clobbers memory through &(n);

 - do_div(): add a check to ensure (n) is type-compatible with uint64_t;

 - as_update_iohist(): Use sector_div() instead of do_div().
   (Whether the result of the addition should always be stored in 64bits
   regardless of CONFIG_LBD is still being discussed, therefore it's
   unadderessed here);

 - Fix all places where do_div() was being called with a bad divisor argument.

diff -Nru linux-2.5.75.orig/include/asm-generic/div64.h linux-2.5.75/include/asm-generic/div64.h
--- linux-2.5.75.orig/include/asm-generic/div64.h	2003-07-10 22:14:11.000000000 +0200
+++ linux-2.5.75/include/asm-generic/div64.h	2003-07-12 13:18:18.000000000 +0200
@@ -32,11 +32,15 @@
 
 #elif BITS_PER_LONG == 32
 
-extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor) __attribute_pure__;
+extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
 
+/* The unnecessary pointer compare is there
+ * to check for type safety (n must be 64bit)
+ */
 # define do_div(n,base) ({				\
 	uint32_t __base = (base);			\
 	uint32_t __rem;					\
+	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
 	if (likely(((n) >> 32) == 0)) {			\
 		__rem = (uint32_t)(n) % __base;		\
 		(n) = (uint32_t)(n) / __base;		\
diff -Nru linux-2.5.75.orig/drivers/block/as-iosched.c linux-2.5.75/drivers/block/as-iosched.c
--- linux-2.5.75.orig/drivers/block/as-iosched.c	2003-07-10 22:04:00.000000000 +0200
+++ linux-2.5.75/drivers/block/as-iosched.c	2003-07-12 13:28:01.000000000 +0200
@@ -837,7 +837,7 @@
 		aic->seek_total += 256*seek_dist;
 		if (aic->seek_samples) {
 			aic->seek_mean = aic->seek_total + 128;
-			do_div(aic->seek_mean, aic->seek_samples);
+			sector_div(aic->seek_mean, aic->seek_samples);
 		}
 		aic->seek_samples = (aic->seek_samples>>1)
 					+ (aic->seek_samples>>2);
diff -Nru linux-2.5.75.orig/lib/vsprintf.c linux-2.5.75/lib/vsprintf.c
--- linux-2.5.75.orig/lib/vsprintf.c	2003-07-10 22:14:14.000000000 +0200
+++ linux-2.5.75/lib/vsprintf.c	2003-07-12 13:37:04.000000000 +0200
@@ -127,7 +127,7 @@
 #define SPECIAL	32		/* 0x */
 #define LARGE	64		/* use 'ABCDEF' instead of 'abcdef' */
 
-static char * number(char * buf, char * end, long long num, int base, int size, int precision, int type)
+static char * number(char * buf, char * end, unsigned long long num, int base, int size, int precision, int type)
 {
 	char c,sign,tmp[66];
 	const char *digits;
diff -Nru linux-2.5.75.orig/mm/vmscan.c linux-2.5.75/mm/vmscan.c
--- linux-2.5.75.orig/mm/vmscan.c	2003-07-10 22:05:27.000000000 +0200
+++ linux-2.5.75/mm/vmscan.c	2003-07-12 13:20:29.000000000 +0200
@@ -147,7 +147,7 @@
 
 	pages = nr_used_zone_pages();
 	list_for_each_entry(shrinker, &shrinker_list, list) {
-		long long delta;
+		uint64_t delta;
 
 		delta = scanned * shrinker->seeks;
 		delta *= (*shrinker->shrinker)(0, gfp_mask);

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


