Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUAOEka (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 23:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUAOEka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 23:40:30 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:59525 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261188AbUAOEkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 23:40:21 -0500
Date: Wed, 14 Jan 2004 20:40:09 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: paulus@samba.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040114204009.3dc4c225.pj@sgi.com>
In-Reply-To: <20040115002703.GA20971@tsunami.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok - here is a patch that should fix lib/mask.c displaying and parsing
cpumasks for 64 bit big endian architectures.  It has only been tested
on 64 bit little endian architectures ;).  Technically, it is against
2.6.1-mm3, though it should work against any kernel with a lib/mask.c
file, since this is the first change to that file.

The comments in the patch explain the details.

Thanks to Paul Mackerras for the "eor-1" coding suggestion, and to Joe
Korty for keeping me honest.

Tomorrow I will attempt a patch to change the ascii format for masks to
zero-fill each word (8 ascii hex chars, representing 32 bits).


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1507  -> 1.1508 
#	          lib/mask.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/14	pj@sgi.com	1.1508
# Swizzle u32 wordp[] indexing to handle 64 bit big-endian arch.
# --------------------------------------------
#
diff -Nru a/lib/mask.c b/lib/mask.c
--- a/lib/mask.c	Wed Jan 14 20:29:14 2004
+++ b/lib/mask.c	Wed Jan 14 20:29:14 2004
@@ -33,15 +33,16 @@
  * about any such struct details, relying on inline macros in
  * files such as cpumask.h to pass in an unsigned long pointer
  * and a length (in bytes), describing the mask contents.
- * The 32bit words in the array are in little-endian order,
- * low order word first.  Beware that this is the reverse order
- * of the ascii representation.
+ *
+ * This layout of masks is determined by the macros in bitops.h,
+ * which pre-date masks.  The bitop operations were formalized
+ * before the mask data type to which they apply.
  *
  * Even though the size of the input mask is provided in bytes,
- * the following code may assume that the mask is a multiple of
- * 32 or 64 bit words long, and ignore any fractional portion
- * of a word at the end.  The main reason the size is passed in
- * bytes is because it is so easy to write 'sizeof(somemask_t)'
+ * the following code may assume that the mask size is a multiple
+ * of sizeof(long), and ignore any fractional portion of a word
+ * at the end.  The main reason the size is passed in bytes is
+ * because it is so easy to write 'sizeof(somemask_t)'.
  * in the macros.
  *
  * Masks are not a single,simple type, like classic 'C'
@@ -72,6 +73,36 @@
 #define BASE 16			/* masks are input in hex (base 16) */
 #define NUL ((char)'\0')	/* nul-terminator */
 
+/*
+ * The following M32X() macro and associated comment really
+ * belong in include/linux/mask.h, which declares the 'mask'
+ * data type to which bitops apply.  However mask.h doesn't
+ * exist yet in the main Linux development line ...
+ */
+
+/*
+ * Masks are arrays of unsigned long.  This is almost the same
+ * as an array of unsigned ints, except on 64 bit big endian
+ * architectures, in which the two 32-bit int halves of each long
+ * are reversed (big 32-bit halfword first, naturally).
+ *
+ * Use this M32X (for "Mask 32-bit indeX") macro to index the
+ * i-th word of a mask declared as an array of 32 bit words.
+ *
+ * Usage example accessing 32-bit words in mask[] in order,
+ * smallest first:
+ *    u32 mask[MASKLENGTH];
+ *    int i;
+ *    for (i = 0; i < MASKLENGTH; i++)
+ *        ... mask[M32X(i)] ...
+ */
+#include <asm/byteorder.h>
+#if BITS_PER_LONG == 64 && defined(__BIG_ENDIAN)
+#define M32X(i) ((i)^1)
+#elif BITS_PER_LONG == 32 || defined(__LITTLE_ENDIAN)
+#define M32X(i) (i)
+#endif
+
 /**
  * __mask_snprintf_len - represent multi-word bit mask as string.
  * @buf: The buffer to place the result into
@@ -93,10 +124,11 @@
 	int len = 0;
 	char *sep = "";
 
-	while (i >= 1 && wordp[i] == 0)
+	while (i >= 1 && wordp[M32X(i)] == 0)
 		i--;
 	while (i >= 0) {
-		len += snprintf(buf+len, buflen-len, "%s%x", sep, wordp[i]);
+		len += snprintf(buf+len, buflen-len,
+			"%s%x", sep, wordp[M32X(i)]);
 		sep = ",";
 		i--;
 	}
@@ -165,13 +197,13 @@
 		t = simple_strtoull(p, 0, BASE);
 		if (t != (u32)t)
 			return -EOVERFLOW;
-		wordp[j++] = t;
+		wordp[M32X(j++)] = t;
 	}
 	--j;
 	while (i < j) {
-		u32 t = wordp[i];
-		wordp[i] = wordp[j];
-		wordp[j] = t;
+		u32 t = wordp[M32X(i)];
+		wordp[M32X(i)] = wordp[M32X(j)];
+		wordp[M32X(j)] = t;
 		i++, --j;
 	}
 	return 0;


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
