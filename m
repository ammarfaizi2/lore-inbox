Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937057AbWLDQOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937057AbWLDQOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937060AbWLDQOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:14:36 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:45062 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937057AbWLDQOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:14:35 -0500
Date: Mon, 4 Dec 2006 09:14:35 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow 32-bit and 64-bit hashes
Message-ID: <20061204161435.GG3013@parisc-linux.org>
References: <20061204104749.GC3013@parisc-linux.org> <Pine.LNX.4.64.0612040746170.3476@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612040746170.3476@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 07:46:51AM -0800, Linus Torvalds wrote:
> On Mon, 4 Dec 2006, Matthew Wilcox wrote:
> >
> > The sym2 driver would like to hash a u32 value, and it could just
> > call hash_long() and rely on integer promotion on 64-bit machines, but
> > that seems a little wasteful.
> 
> Hmm. It would appear that the <linux/hash.h> file now needs 
> <linux/types.h>, no?

You're right.  It hasn't actually caused any problems, presumably due to
linux/types.h being included absolutely everywhere already, but it's
clearly the Right Thing To Do.  Updated patch:

-----

Allow 32-bit and 64-bit hashes
    
The sym2 driver would like to hash a u32 value, and it could just
call hash_long() and rely on integer promotion on 64-bit machines, but
that seems a little wasteful.
    
Following Arjan's suggestion, I split the existing hash_long into
hash_u32 and hash_u64, and made hash_long an alias to the appropriate
function.
    
Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff --git a/include/linux/hash.h b/include/linux/hash.h
index acf17bb..56ce6bf 100644
--- a/include/linux/hash.h
+++ b/include/linux/hash.h
@@ -3,6 +3,8 @@
 /* Fast hashing routine for a long.
    (C) 2002 William Lee Irwin III, IBM */
 
+#include <linux/types.h>
+
 /*
  * Knuth recommends primes in approximately golden ratio to the maximum
  * integer representable by a machine word for multiplicative hashing.
@@ -13,23 +15,36 @@
  * them can use shifts and additions instead of multiplications for
  * machines where multiplications are slow.
  */
-#if BITS_PER_LONG == 32
 /* 2^31 + 2^29 - 2^25 + 2^22 - 2^19 - 2^16 + 1 */
-#define GOLDEN_RATIO_PRIME 0x9e370001UL
-#elif BITS_PER_LONG == 64
+#define GOLDEN_RATIO_PRIME_32 0x9e370001UL
 /*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
-#define GOLDEN_RATIO_PRIME 0x9e37fffffffc0001UL
+#define GOLDEN_RATIO_PRIME_64 0x9e37fffffffc0001ULL
+
+#if BITS_PER_LONG == 32
+#define GOLDEN_RATIO_PRIME GOLDEN_RATIO_PRIME_32
+#define hash_long(val, bits) hash_u32(val, bits)
+#elif BITS_PER_LONG == 64
+#define GOLDEN_RATIO_PRIME GOLDEN_RATIO_PRIME_64
+#define hash_long(val, bits) hash_u64(val, bits)
 #else
 #error Define GOLDEN_RATIO_PRIME for your wordsize.
 #endif
 
-static inline unsigned long hash_long(unsigned long val, unsigned int bits)
+static inline unsigned long hash_u32(u32 val, unsigned int bits)
 {
-	unsigned long hash = val;
+	/* On some cpus multiply is faster, on others gcc will do shifts */
+	unsigned int hash = val * GOLDEN_RATIO_PRIME_32;
+
+	/* High bits are more random, so use them. */
+	return hash >> (32 - bits);
+}
+
+static inline unsigned long hash_u64(u64 val, unsigned int bits)
+{
+	u64 hash = val;
 
-#if BITS_PER_LONG == 64
 	/*  Sigh, gcc can't optimise this alone like it does for 32 bits. */
-	unsigned long n = hash;
+	u64 n = hash;
 	n <<= 18;
 	hash -= n;
 	n <<= 33;
@@ -42,13 +57,9 @@ static inline unsigned long hash_long(un
 	hash += n;
 	n <<= 2;
 	hash += n;
-#else
-	/* On some cpus multiply is faster, on others gcc will do shifts */
-	hash *= GOLDEN_RATIO_PRIME;
-#endif
 
 	/* High bits are more random, so use them. */
-	return hash >> (BITS_PER_LONG - bits);
+	return hash >> (64 - bits);
 }
 	
 static inline unsigned long hash_ptr(void *ptr, unsigned int bits)
