Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWJEVsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWJEVsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWJEVsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:48:38 -0400
Received: from mga07.intel.com ([143.182.124.22]:37914 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932295AbWJEVsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:48:36 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,266,1157353200"; 
   d="scan'208"; a="127516716:sNHT33327791"
From: Reinette Chatre <reinette.chatre@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] bitmap: parse input from kernel and user buffers
Date: Thu, 5 Oct 2006 14:48:34 -0700
User-Agent: KMail/1.9.4
Cc: Inaky Perez-Gonzalez <inaky@linux.intel.com>,
       Joe Korty <joe.korty@ccur.com>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, reinette.chatre@linux.intel.com
References: <200610041756.30528.reinette.chatre@linux.intel.com> <20061004185747.4cb64048.akpm@osdl.org> <200610051249.07856.reinette.chatre@linux.intel.com>
In-Reply-To: <200610051249.07856.reinette.chatre@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051448.34866.reinette.chatre@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lib/bitmap.c:bitmap_parse() is a library function that received as
input a user buffer. This seemed to have originated from the way 
the write_proc function of the /proc filesystem operates.

This has been reworked to not use kmalloc and eliminates a lot
of get_user() overhead by performing one access_ok before using
__get_user().
We need to test if we are in kernel or user space (is_user) and access
the buffer differently. We cannot use __get_user() to access kernel
addresses in all cases, for example in architectures with separate
address space for kernel and user.

This function will be useful for other uses as well; for example,
taking input  for /sysfs instead of /proc, so it was changed to accept
kernel buffers. We have this use for the Linux UWB project, as part
as the upcoming bandwidth allocator code.

Only a few routines used this function and they were changed too.

Signed-off-by: Reinette Chatre <reinette.chatre@linux.intel.com>

---
This is an updated version of patch 
bitmap-bitmap_parse-takes-a-kernel-buffer-instead-of-a-user-buffer.patch 

Andi Kleen and Cristoph Hellwig have confirmed that in architectures
with separate address space __get_user() won't work

With the usage of access_ok() before __get_user(), is it still necessary
to check the return code of __get_user()? We currently do this.

 include/linux/bitmap.h   |   13 +++++++++--
 include/linux/cpumask.h  |   14 ++++++------
 include/linux/nodemask.h |   14 ++++++------
 kernel/irq/proc.c        |    2 -
 kernel/profile.c         |    2 -
 lib/bitmap.c             |   54 +++++++++++++++++++++++++++++++++++++----------
 6 files changed, 70 insertions(+), 29 deletions(-)

diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/include/linux/bitmap.h linux-2.6.hg/include/linux/bitmap.h
--- linux-2.6.hg.vanilla/include/linux/bitmap.h	2006-10-02 14:04:35.000000000 -0700
+++ linux-2.6.hg/include/linux/bitmap.h	2006-10-05 13:49:23.000000000 -0700
@@ -46,7 +46,8 @@
  * bitmap_remap(dst, src, old, new, nbits)	*dst = map(old, new)(src)
  * bitmap_bitremap(oldbit, old, new, nbits)	newbit = map(old, new)(oldbit)
  * bitmap_scnprintf(buf, len, src, nbits)	Print bitmap src to buf
- * bitmap_parse(ubuf, ulen, dst, nbits)		Parse bitmap dst from user buf
+ * bitmap_parse(buf, buflen, dst, nbits)	Parse bitmap dst from kernel buf
+ * bitmap_parse_user(ubuf, ulen, dst, nbits)	Parse bitmap dst from user buf
  * bitmap_scnlistprintf(buf, len, src, nbits)	Print bitmap src as list to buf
  * bitmap_parselist(buf, dst, nbits)		Parse bitmap dst from list
  * bitmap_find_free_region(bitmap, bits, order)	Find and allocate bit region
@@ -106,7 +107,9 @@ extern int __bitmap_weight(const unsigne
 
 extern int bitmap_scnprintf(char *buf, unsigned int len,
 			const unsigned long *src, int nbits);
-extern int bitmap_parse(const char __user *ubuf, unsigned int ulen,
+extern int __bitmap_parse(const char *buf, unsigned int buflen, int is_user,
+			unsigned long *dst, int nbits);
+extern int bitmap_parse_user(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
 extern int bitmap_scnlistprintf(char *buf, unsigned int len,
 			const unsigned long *src, int nbits);
@@ -270,6 +273,12 @@ static inline void bitmap_shift_left(uns
 		__bitmap_shift_left(dst, src, n, nbits);
 }
 
+static inline int bitmap_parse(const char *buf, unsigned int buflen,
+			unsigned long *maskp, int nmaskbits)
+{
+	return __bitmap_parse(buf, buflen, 0, maskp, nmaskbits);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/lib/bitmap.c linux-2.6.hg/lib/bitmap.c
--- linux-2.6.hg.vanilla/lib/bitmap.c	2006-10-02 14:04:39.000000000 -0700
+++ linux-2.6.hg/lib/bitmap.c	2006-10-05 13:50:03.000000000 -0700
@@ -316,10 +316,11 @@ int bitmap_scnprintf(char *buf, unsigned
 EXPORT_SYMBOL(bitmap_scnprintf);
 
 /**
- * bitmap_parse - convert an ASCII hex string into a bitmap.
- * @ubuf: pointer to buffer in user space containing string.
- * @ubuflen: buffer size in bytes.  If string is smaller than this
+ * __bitmap_parse - convert an ASCII hex string into a bitmap.
+ * @buf: pointer to buffer containing string.
+ * @buflen: buffer size in bytes.  If string is smaller than this
  *    then it must be terminated with a \0.
+ * @is_user: location of buffer, 0 indicates kernel space
  * @maskp: pointer to bitmap array that will contain result.
  * @nmaskbits: size of bitmap, in bits.
  *
@@ -330,11 +331,13 @@ EXPORT_SYMBOL(bitmap_scnprintf);
  * characters and for grouping errors such as "1,,5", ",44", "," and "".
  * Leading and trailing whitespace accepted, but not embedded whitespace.
  */
-int bitmap_parse(const char __user *ubuf, unsigned int ubuflen,
-        unsigned long *maskp, int nmaskbits)
+int __bitmap_parse(const char *buf, unsigned int buflen,
+		int is_user, unsigned long *maskp,
+		int nmaskbits)
 {
 	int c, old_c, totaldigits, ndigits, nchunks, nbits;
 	u32 chunk;
+	const char __user *ubuf = buf;
 
 	bitmap_zero(maskp, nmaskbits);
 
@@ -343,11 +346,15 @@ int bitmap_parse(const char __user *ubuf
 		chunk = ndigits = 0;
 
 		/* Get the next chunk of the bitmap */
-		while (ubuflen) {
+		while (buflen) {
 			old_c = c;
-			if (get_user(c, ubuf++))
-				return -EFAULT;
-			ubuflen--;
+			if (is_user) {
+				if (__get_user(c, ubuf++))
+					return -EFAULT;
+			}
+			else
+				c = *buf++;
+			buflen--;
 			if (isspace(c))
 				continue;
 
@@ -388,11 +395,36 @@ int bitmap_parse(const char __user *ubuf
 		nbits += (nchunks == 1) ? nbits_to_hold_value(chunk) : CHUNKSZ;
 		if (nbits > nmaskbits)
 			return -EOVERFLOW;
-	} while (ubuflen && c == ',');
+	} while (buflen && c == ',');
 
 	return 0;
 }
-EXPORT_SYMBOL(bitmap_parse);
+EXPORT_SYMBOL(__bitmap_parse);
+
+/**
+ * bitmap_parse_user()
+ *
+ * @ubuf: pointer to user buffer containing string.
+ * @ulen: buffer size in bytes.  If string is smaller than this
+ *    then it must be terminated with a \0.
+ * @maskp: pointer to bitmap array that will contain result.
+ * @nmaskbits: size of bitmap, in bits.
+ *
+ * Wrapper for __bitmap_parse(), providing it with user buffer.
+ *
+ * We cannot have this as an inline function in bitmap.h because it needs
+ * linux/uaccess.h to get the access_ok() declaration and this causes
+ * cyclic dependencies.
+ */
+int bitmap_parse_user(const char __user *ubuf,
+			unsigned int ulen, unsigned long *maskp,
+			int nmaskbits)
+{
+	if (!access_ok(VERIFY_READ, ubuf, ulen))
+		return -EFAULT;
+	return __bitmap_parse((const char *)ubuf, ulen, 1, maskp, nmaskbits);
+}
+EXPORT_SYMBOL(bitmap_parse_user);
 
 /*
  * bscnl_emit(buf, buflen, rbot, rtop, bp)
diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/include/linux/cpumask.h linux-2.6.hg/include/linux/cpumask.h
--- linux-2.6.hg.vanilla/include/linux/cpumask.h	2006-10-02 14:04:35.000000000 -0700
+++ linux-2.6.hg/include/linux/cpumask.h	2006-10-05 13:49:23.000000000 -0700
@@ -8,8 +8,8 @@
  * See detailed comments in the file linux/bitmap.h describing the
  * data type on which these cpumasks are based.
  *
- * For details of cpumask_scnprintf() and cpumask_parse(),
- * see bitmap_scnprintf() and bitmap_parse() in lib/bitmap.c.
+ * For details of cpumask_scnprintf() and cpumask_parse_user(),
+ * see bitmap_scnprintf() and bitmap_parse_user() in lib/bitmap.c.
  * For details of cpulist_scnprintf() and cpulist_parse(), see
  * bitmap_scnlistprintf() and bitmap_parselist(), also in bitmap.c.
  * For details of cpu_remap(), see bitmap_bitremap in lib/bitmap.c
@@ -49,7 +49,7 @@
  * unsigned long *cpus_addr(mask)	Array of unsigned long's in mask
  *
  * int cpumask_scnprintf(buf, len, mask) Format cpumask for printing
- * int cpumask_parse(ubuf, ulen, mask)	Parse ascii string as cpumask
+ * int cpumask_parse_user(ubuf, ulen, mask)	Parse ascii string as cpumask
  * int cpulist_scnprintf(buf, len, mask) Format cpumask as list for printing
  * int cpulist_parse(buf, map)		Parse ascii string as cpulist
  * int cpu_remap(oldbit, old, new)	newbit = map(old, new)(oldbit)
@@ -273,12 +273,12 @@ static inline int __cpumask_scnprintf(ch
 	return bitmap_scnprintf(buf, len, srcp->bits, nbits);
 }
 
-#define cpumask_parse(ubuf, ulen, dst) \
-			__cpumask_parse((ubuf), (ulen), &(dst), NR_CPUS)
-static inline int __cpumask_parse(const char __user *buf, int len,
+#define cpumask_parse_user(ubuf, ulen, dst) \
+			__cpumask_parse_user((ubuf), (ulen), &(dst), NR_CPUS)
+static inline int __cpumask_parse_user(const char __user *buf, int len,
 					cpumask_t *dstp, int nbits)
 {
-	return bitmap_parse(buf, len, dstp->bits, nbits);
+	return bitmap_parse_user(buf, len, dstp->bits, nbits);
 }
 
 #define cpulist_scnprintf(buf, len, src) \
diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/kernel/irq/proc.c linux-2.6.hg/kernel/irq/proc.c
--- linux-2.6.hg.vanilla/kernel/irq/proc.c	2006-10-02 14:04:38.000000000 -0700
+++ linux-2.6.hg/kernel/irq/proc.c	2006-10-05 13:49:23.000000000 -0700
@@ -57,7 +57,7 @@ static int irq_affinity_write_proc(struc
 	if (!irq_desc[irq].chip->set_affinity || no_irq_affinity)
 		return -EIO;
 
-	err = cpumask_parse(buffer, count, new_value);
+	err = cpumask_parse_user(buffer, count, new_value);
 	if (err)
 		return err;
 
diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/kernel/profile.c linux-2.6.hg/kernel/profile.c
--- linux-2.6.hg.vanilla/kernel/profile.c	2006-10-02 14:04:38.000000000 -0700
+++ linux-2.6.hg/kernel/profile.c	2006-10-05 13:49:23.000000000 -0700
@@ -396,7 +396,7 @@ static int prof_cpu_mask_write_proc (str
 	unsigned long full_count = count, err;
 	cpumask_t new_value;
 
-	err = cpumask_parse(buffer, count, new_value);
+	err = cpumask_parse_user(buffer, count, new_value);
 	if (err)
 		return err;
 
diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/include/linux/nodemask.h linux-2.6.hg/include/linux/nodemask.h
--- linux-2.6.hg.vanilla/include/linux/nodemask.h	2006-10-03 16:58:10.000000000 -0700
+++ linux-2.6.hg/include/linux/nodemask.h	2006-10-05 13:49:23.000000000 -0700
@@ -8,8 +8,8 @@
  * See detailed comments in the file linux/bitmap.h describing the
  * data type on which these nodemasks are based.
  *
- * For details of nodemask_scnprintf() and nodemask_parse(),
- * see bitmap_scnprintf() and bitmap_parse() in lib/bitmap.c.
+ * For details of nodemask_scnprintf() and nodemask_parse_user(),
+ * see bitmap_scnprintf() and bitmap_parse_user() in lib/bitmap.c.
  * For details of nodelist_scnprintf() and nodelist_parse(), see
  * bitmap_scnlistprintf() and bitmap_parselist(), also in bitmap.c.
  * For details of node_remap(), see bitmap_bitremap in lib/bitmap.c.
@@ -51,7 +51,7 @@
  * unsigned long *nodes_addr(mask)	Array of unsigned long's in mask
  *
  * int nodemask_scnprintf(buf, len, mask) Format nodemask for printing
- * int nodemask_parse(ubuf, ulen, mask)	Parse ascii string as nodemask
+ * int nodemask_parse_user(ubuf, ulen, mask)	Parse ascii string as nodemask
  * int nodelist_scnprintf(buf, len, mask) Format nodemask as list for printing
  * int nodelist_parse(buf, map)		Parse ascii string as nodelist
  * int node_remap(oldbit, old, new)	newbit = map(old, new)(oldbit)
@@ -288,12 +288,12 @@ static inline int __nodemask_scnprintf(c
 	return bitmap_scnprintf(buf, len, srcp->bits, nbits);
 }
 
-#define nodemask_parse(ubuf, ulen, dst) \
-			__nodemask_parse((ubuf), (ulen), &(dst), MAX_NUMNODES)
-static inline int __nodemask_parse(const char __user *buf, int len,
+#define nodemask_parse_user(ubuf, ulen, dst) \
+		__nodemask_parse_user((ubuf), (ulen), &(dst), MAX_NUMNODES)
+static inline int __nodemask_parse_user(const char __user *buf, int len,
 					nodemask_t *dstp, int nbits)
 {
-	return bitmap_parse(buf, len, dstp->bits, nbits);
+	return bitmap_parse_user(buf, len, dstp->bits, nbits);
 }
 
 #define nodelist_scnprintf(buf, len, src) \
