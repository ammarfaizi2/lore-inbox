Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWJCPQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWJCPQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWJCPQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:16:30 -0400
Received: from mga05.intel.com ([192.55.52.89]:27252 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S964833AbWJCPQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:16:30 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,251,1157353200"; 
   d="scan'208"; a="140949682:sNHT25978512"
From: Reinette Chatre <reinette.chatre@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of a user buffer
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Disposition: inline
Cc: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Date: Tue, 3 Oct 2006 08:16:27 -0700
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200610030816.27941.reinette.chatre@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lib/bitmap.c:bitmap_parse() is a library function that received as input a  user buffer. This seemed to have originated from the way the write_proc function of the /proc filesystem operates.

This function will be useful for other uses as well; for example, taking input  for /sysfs instead of /proc, so it was changed to accept kernel buffers. We have this use for the Linux UWB project, as part as the upcoming bandwidth allocator code.

Only a few routines used this function and they were changed too.
    
Signed-off-by: Reinette Chatre <reinette.chatre@linux.intel.com>
---

Applies to the current Linus' kernel tip.

 include/linux/bitmap.h   |    4 ++--
 include/linux/cpumask.h  |    2 +-
 include/linux/nodemask.h |    2 +-
 kernel/irq/proc.c        |   13 ++++++++++++-
 kernel/profile.c         |   13 ++++++++++++-
 lib/bitmap.c             |   15 +++++++--------
 6 files changed, 35 insertions(+), 14 deletions(-)

diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/include/linux/bitmap.h linux-2.6.hg/include/linux/bitmap.h
--- linux-2.6.hg.vanilla/include/linux/bitmap.h	2006-10-02 14:04:35.000000000 -0700
+++ linux-2.6.hg/include/linux/bitmap.h	2006-10-02 13:50:05.000000000 -0700
@@ -46,7 +46,7 @@
  * bitmap_remap(dst, src, old, new, nbits)	*dst = map(old, new)(src)
  * bitmap_bitremap(oldbit, old, new, nbits)	newbit = map(old, new)(oldbit)
  * bitmap_scnprintf(buf, len, src, nbits)	Print bitmap src to buf
- * bitmap_parse(ubuf, ulen, dst, nbits)		Parse bitmap dst from user buf
+ * bitmap_parse(buf, len, dst, nbits)		Parse bitmap dst from buf
  * bitmap_scnlistprintf(buf, len, src, nbits)	Print bitmap src as list to buf
  * bitmap_parselist(buf, dst, nbits)		Parse bitmap dst from list
  * bitmap_find_free_region(bitmap, bits, order)	Find and allocate bit region
@@ -106,7 +106,7 @@ extern int __bitmap_weight(const unsigne
 
 extern int bitmap_scnprintf(char *buf, unsigned int len,
 			const unsigned long *src, int nbits);
-extern int bitmap_parse(const char __user *ubuf, unsigned int ulen,
+extern int bitmap_parse(const char *buf, unsigned int len,
 			unsigned long *dst, int nbits);
 extern int bitmap_scnlistprintf(char *buf, unsigned int len,
 			const unsigned long *src, int nbits);
diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/lib/bitmap.c linux-2.6.hg/lib/bitmap.c
--- linux-2.6.hg.vanilla/lib/bitmap.c	2006-10-02 14:04:39.000000000 -0700
+++ linux-2.6.hg/lib/bitmap.c	2006-10-02 13:51:57.000000000 -0700
@@ -317,8 +317,8 @@ EXPORT_SYMBOL(bitmap_scnprintf);
 
 /**
  * bitmap_parse - convert an ASCII hex string into a bitmap.
- * @ubuf: pointer to buffer in user space containing string.
- * @ubuflen: buffer size in bytes.  If string is smaller than this
+ * @buf: pointer to buffer containing string.
+ * @buflen: buffer size in bytes.  If string is smaller than this
  *    then it must be terminated with a \0.
  * @maskp: pointer to bitmap array that will contain result.
  * @nmaskbits: size of bitmap, in bits.
@@ -330,7 +330,7 @@ EXPORT_SYMBOL(bitmap_scnprintf);
  * characters and for grouping errors such as "1,,5", ",44", "," and "".
  * Leading and trailing whitespace accepted, but not embedded whitespace.
  */
-int bitmap_parse(const char __user *ubuf, unsigned int ubuflen,
+int bitmap_parse(const char *buf, unsigned int buflen,
         unsigned long *maskp, int nmaskbits)
 {
 	int c, old_c, totaldigits, ndigits, nchunks, nbits;
@@ -343,11 +343,10 @@ int bitmap_parse(const char __user *ubuf
 		chunk = ndigits = 0;
 
 		/* Get the next chunk of the bitmap */
-		while (ubuflen) {
+		while (buflen) {
 			old_c = c;
-			if (get_user(c, ubuf++))
-				return -EFAULT;
-			ubuflen--;
+			c = *buf++;
+			buflen--;
 			if (isspace(c))
 				continue;
 
@@ -388,7 +387,7 @@ int bitmap_parse(const char __user *ubuf
 		nbits += (nchunks == 1) ? nbits_to_hold_value(chunk) : CHUNKSZ;
 		if (nbits > nmaskbits)
 			return -EOVERFLOW;
-	} while (ubuflen && c == ',');
+	} while (buflen && c == ',');
 
 	return 0;
 }
diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/include/linux/cpumask.h linux-2.6.hg/include/linux/cpumask.h
--- linux-2.6.hg.vanilla/include/linux/cpumask.h	2006-10-02 14:04:35.000000000 -0700
+++ linux-2.6.hg/include/linux/cpumask.h	2006-10-02 13:46:53.000000000 -0700
@@ -275,7 +275,7 @@ static inline int __cpumask_scnprintf(ch
 
 #define cpumask_parse(ubuf, ulen, dst) \
 			__cpumask_parse((ubuf), (ulen), &(dst), NR_CPUS)
-static inline int __cpumask_parse(const char __user *buf, int len,
+static inline int __cpumask_parse(const char *buf, int len,
 					cpumask_t *dstp, int nbits)
 {
 	return bitmap_parse(buf, len, dstp->bits, nbits);
diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/kernel/irq/proc.c linux-2.6.hg/kernel/irq/proc.c
--- linux-2.6.hg.vanilla/kernel/irq/proc.c	2006-10-02 14:04:38.000000000 -0700
+++ linux-2.6.hg/kernel/irq/proc.c	2006-10-02 13:46:53.000000000 -0700
@@ -53,11 +53,22 @@ static int irq_affinity_write_proc(struc
 {
 	unsigned int irq = (int)(long)data, full_count = count, err;
 	cpumask_t new_value, tmp;
+	char *kbuf;
+	unsigned long ret;
 
 	if (!irq_desc[irq].chip->set_affinity || no_irq_affinity)
 		return -EIO;
 
-	err = cpumask_parse(buffer, count, new_value);
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (kbuf == NULL)
+		return -ENOMEM;
+	ret = copy_from_user(kbuf, buffer, count);
+	if (ret != 0) {
+		kfree(kbuf);
+		return -EFAULT;
+	}
+	err = cpumask_parse(kbuf, count, new_value);
+	kfree(kbuf);
 	if (err)
 		return err;
 
diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/include/linux/nodemask.h linux-2.6.hg/include/linux/nodemask.h
--- linux-2.6.hg.vanilla/include/linux/nodemask.h	2006-10-02 14:04:36.000000000 -0700
+++ linux-2.6.hg/include/linux/nodemask.h	2006-10-02 13:46:53.000000000 -0700
@@ -290,7 +290,7 @@ static inline int __nodemask_scnprintf(c
 
 #define nodemask_parse(ubuf, ulen, dst) \
 			__nodemask_parse((ubuf), (ulen), &(dst), MAX_NUMNODES)
-static inline int __nodemask_parse(const char __user *buf, int len,
+static inline int __nodemask_parse(const char *buf, int len,
 					nodemask_t *dstp, int nbits)
 {
 	return bitmap_parse(buf, len, dstp->bits, nbits);
diff -uprN -X linux-2.6.hg.vanilla/Documentation/dontdiff linux-2.6.hg.vanilla/kernel/profile.c linux-2.6.hg/kernel/profile.c
--- linux-2.6.hg.vanilla/kernel/profile.c	2006-10-02 14:04:38.000000000 -0700
+++ linux-2.6.hg/kernel/profile.c	2006-10-02 13:46:53.000000000 -0700
@@ -395,8 +395,19 @@ static int prof_cpu_mask_write_proc (str
 	cpumask_t *mask = (cpumask_t *)data;
 	unsigned long full_count = count, err;
 	cpumask_t new_value;
+	char *kbuf;
+	unsigned long ret;
 
-	err = cpumask_parse(buffer, count, new_value);
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (kbuf == NULL)
+		return -ENOMEM;
+	ret = copy_from_user(kbuf, buffer, count);
+	if (ret != 0) {
+		kfree(kbuf);
+		return -EFAULT;
+	}
+	err = cpumask_parse(kbuf, count, new_value);
+	kfree(kbuf);
 	if (err)
 		return err;
 
