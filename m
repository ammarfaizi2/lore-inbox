Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269627AbRHADvj>; Tue, 31 Jul 2001 23:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269628AbRHADvc>; Tue, 31 Jul 2001 23:51:32 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:7351 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S269627AbRHADvX>; Tue, 31 Jul 2001 23:51:23 -0400
Subject: [PATCH] 2.4.8-pre3 NTFS update (1.1.16)
To: torvalds@transmeta.com
Date: Wed, 1 Aug 2001 04:51:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15Rn2h-0000E5-00@virgo.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello Linus,

Please apply below patch which updates the NTFS driver. Patch is against
2.4.8-pre3, doesn't touch any non-NTFS code and is successfully tested
with the NTFS filesystems I threw at it.

Detailed description of patch:

- Removed non-functional uni_xlate mount options.
- Clarified the semantics of the utf8 and iocharset mount options.
- Threw out the non-functional mount options for using hard coded 
character set conversion. Only kept utf8 one.
- Fixed handling of mount options and proper handling of faulty mount 
options on remount.
- Cleaned up character conversion which basically became simplified a lot
due to the removal of the above mentioned mount options.
- Made character conversion to be always consistent. Previously we could
output to the VFS file names which we would then not accept back from the
VFS so in effect we were generating ghost entries in the directory 
listings which could not be accessed by any means.
- Simplified time conversion functions drastically without
sacrificing accuracy, now the offending function is 3 lines instead of
two pages of code. (-8
- Fixed a use of a pointer before the check for the pointer being NULL,
reported by the Stanford checker.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/
  
------linux-2.4.8-pre3-ntfs-1.1.16.diff------

diff -urN linux-2.4.8-pre3.vanilla/fs/ntfs/dir.c linux-2.4.8-pre3.tmd/fs/ntfs/dir.c
--- linux-2.4.8-pre3.vanilla/fs/ntfs/dir.c	Tue Jul 31 18:24:04 2001
+++ linux-2.4.8-pre3.tmd/fs/ntfs/dir.c	Tue Jul 31 17:39:45 2001
@@ -789,7 +789,7 @@
 	int block;
 	int start;
 	ntfs_attribute *attr;
-	ntfs_volume *vol = ino->vol;
+	ntfs_volume *vol;
 	int byte, bit;
 	int error = 0;
 
@@ -797,6 +797,7 @@
 		ntfs_error("No inode passed to getdir_unsorted\n");
 		return -EINVAL;
 	}
+       	vol = ino->vol;
 	if (!vol) {
 		ntfs_error("Inode %d has no volume\n", ino->i_number);
 		return -EINVAL;
diff -urN linux-2.4.8-pre3.vanilla/fs/ntfs/support.c linux-2.4.8-pre3.tmd/fs/ntfs/support.c
--- linux-2.4.8-pre3.vanilla/fs/ntfs/support.c	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-pre3.tmd/fs/ntfs/support.c	Tue Jul 31 17:36:16 2001
@@ -225,147 +225,81 @@
 	return ntfs_unixutc2ntutc(CURRENT_TIME);
 }
 
-/* When printing unicode characters base64, use this table. It is not strictly
- * base64, but the Linux vfat encoding. base64 has the disadvantage of using
- * the slash. */
-static char uni2esc[64] = 
-	    "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+-";
-
-static unsigned char esc2uni(char c)
-{
-	if (c <  '0') return 255;
-	if (c <= '9') return c - '0';
-	if (c <  'A') return 255;
-	if (c <= 'Z') return c - 'A' + 10;
-	if (c <  'a') return 255;
-	if (c <= 'z') return c - 'a' + 36;
-	if (c == '+') return 62;
-	if (c == '-') return 63;
-	return 255;
-}
-
 int ntfs_dupuni2map(ntfs_volume *vol, ntfs_u16 *in, int in_len, char **out,
-		    int *out_len)
+		int *out_len)
 {
-	int i, o, val, chl, chi;
+	int i, o, chl, chi;
 	char *result, *buf, charbuf[NLS_MAX_CHARSET_SIZE];
-	struct nls_table* nls = vol->nls_map;
+	struct nls_table *nls = vol->nls_map;
 
 	result = ntfs_malloc(in_len + 1);
 	if (!result)
 		return -ENOMEM;
 	*out_len = in_len;
-	result[in_len] = '\0';
 	for (i = o = 0; i < in_len; i++) {
-		int cl, ch;
-		/* FIXME: byte order? */
-		cl = in[i] & 0xFF;
-		ch = (in[i] >> 8) & 0xFF;
-		if (!nls) {
-			if (!ch) {
-				result[o++] = cl;
-				continue;
-			}
-		} else {
-			/* FIXME: byte order? */
-			wchar_t uni = in[i];
-			if ((chl = nls->uni2char(uni, charbuf,
-						NLS_MAX_CHARSET_SIZE)) > 0) {
-				/* adjust result buffer */
-				if (chl > 1) {
-					buf = ntfs_malloc(*out_len + chl - 1);
-					if (!buf) {
-						ntfs_free(result);
-						return -ENOMEM;
-					}
-					memcpy(buf, result, o);
+		/* FIXME: Byte order? */
+		wchar_t uni = in[i];
+		if ((chl = nls->uni2char(uni, charbuf,
+				NLS_MAX_CHARSET_SIZE)) > 0) {
+			/* Adjust result buffer. */
+			if (chl > 1) {
+				buf = ntfs_malloc(*out_len + chl - 1);
+				if (!buf) {
 					ntfs_free(result);
-					result = buf;
-					*out_len += (chl - 1);
+					return -ENOMEM;
 				}
-				for (chi = 0; chi < chl; chi++)
-					result[o++] = charbuf[chi];
-			} else
-				result[o++] = '?';
-			continue;
-		}
-		if (!(vol->nct & nct_uni_xlate))
-			goto inval;
-		/* realloc */
-		buf = ntfs_malloc(*out_len + 3);
-		if (!buf) {
-			ntfs_free(result);
-			return -ENOMEM;
-		}
-		memcpy(buf, result, o);
-		ntfs_free(result);
-		result = buf;
-		*out_len += 3;
-		result[o++] = ':';
-		if (vol->nct & nct_uni_xlate_vfat) {
-			val = (cl << 8) + ch;
-			result[o+2] = uni2esc[val & 0x3f];
-			val >>= 6;
-			result[o+1] = uni2esc[val & 0x3f];
-			val >>= 6;
-			result[o] = uni2esc[val & 0x3f];
-			o += 3;
+				memcpy(buf, result, o);
+				ntfs_free(result);
+				result = buf;
+				*out_len += (chl - 1);
+			}
+			for (chi = 0; chi < chl; chi++)
+				result[o++] = charbuf[chi];
 		} else {
-			val = (ch << 8) + cl;
-			result[o++] = uni2esc[val & 0x3f];
-			val >>= 6;
-			result[o++] = uni2esc[val & 0x3f];
-			val >>= 6;
-			result[o++] = uni2esc[val & 0x3f];
+			/* Invalid character. */
+			printk(KERN_ERR "NTFS: Unicode name contains a "
+					"character that cannot be converted "
+					"to chosen character set. Remount "
+					"with utf8 encoding and this should "
+					"work.\n");
+			ntfs_free(result);
+			return -EILSEQ;
 		}
 	}
+	result[*out_len] = '\0';
 	*out = result;
 	return 0;
- inval:
-	ntfs_free(result);
-	*out = 0;
-	return -EILSEQ;
 }
 
 int ntfs_dupmap2uni(ntfs_volume *vol, char* in, int in_len, ntfs_u16 **out,
-		    int *out_len)
+		int *out_len)
 {
 	int i, o;
-	ntfs_u16* result;
-	struct nls_table* nls = vol->nls_map;
+	ntfs_u16 *result;
+	struct nls_table *nls = vol->nls_map;
 
-	*out=result = ntfs_malloc(2 * in_len);
+	*out = result = ntfs_malloc(2 * in_len);
 	if (!result)
 		return -ENOMEM;
 	*out_len = in_len;
-	for (i = o = 0; i < in_len; i++, o++){
+	for (i = o = 0; i < in_len; i++, o++) {
 		wchar_t uni;
-		if (in[i] != ':' || (vol->nct & nct_uni_xlate) == 0){
-			int charlen;
-			charlen = nls->char2uni(&in[i], in_len-i, &uni);
-			if (charlen < 0)
-				return charlen;
-			*out_len -= (charlen - 1);
-			i += (charlen - 1);
-		} else {
-			unsigned char c1, c2, c3;
-			*out_len -= 3;
-			c1 = esc2uni(in[++i]);
-			c2 = esc2uni(in[++i]);
-			c3 = esc2uni(in[++i]);
-			if (c1 == 255 || c2 == 255 || c3 == 255)
-				uni = 0;
-			else if (vol->nct & nct_uni_xlate_vfat) {
-				uni = (((c2 & 0x3) << 6) + c3) << 8 |
-				      ((c1 << 4) + (c2 >> 2));
-			} else {
-				uni = ((c3 << 4) + (c2 >> 2)) << 8 |
-				      (((c2 & 0x3) << 6) + c1);
-			}
+		int charlen;
+
+		charlen = nls->char2uni(&in[i], in_len - i, &uni);
+		if (charlen < 0) {
+			printk(KERN_ERR "NTFS: Name contains a character that "
+					"cannot be converted to Unicode.\n");
+			ntfs_free(result);
+			return charlen;
 		}
-		/* FIXME: byte order? */
+		*out_len -= charlen - 1;
+		i += charlen - 1;
+		/* FIXME: Byte order? */
 		result[o] = uni;
 		if (!result[o]) {
+			printk(KERN_ERR "NTFS: Name contains a character that "
+					"cannot be converted to Unicode.\n");
 			ntfs_free(result);
 			return -EILSEQ;
 		}
diff -urN linux-2.4.8-pre3.vanilla/fs/ntfs/util.c linux-2.4.8-pre3.tmd/fs/ntfs/util.c
--- linux-2.4.8-pre3.vanilla/fs/ntfs/util.c	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-pre3.tmd/fs/ntfs/util.c	Tue Jul 31 17:37:59 2001
@@ -13,12 +13,15 @@
 #include "util.h"
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <asm/div64.h>		/* For do_div(). */
 #include "support.h"
 
-/* Converts a single wide character to a sequence of utf8 bytes.
+/*
+ * Converts a single wide character to a sequence of utf8 bytes.
  * The character is represented in host byte order.
- * Returns the number of bytes, or 0 on error. */
-static int to_utf8(ntfs_u16 c, unsigned char* buf)
+ * Returns the number of bytes, or 0 on error.
+ */
+static int to_utf8(ntfs_u16 c, unsigned char *buf)
 {
 	if (c == 0)
 		return 0; /* No support for embedded 0 runes. */
@@ -34,22 +37,21 @@
 		}
 		return 2;
 	}
-	if (c < 0x10000) {
-		if (buf) {
-			buf[0] = 0xe0 | (c >> 12);
-			buf[1] = 0x80 | ((c >> 6) & 0x3f);
-			buf[2] = 0x80 | (c & 0x3f);
-		}
-		return 3;
+	/* c < 0x10000 */
+	if (buf) {
+		buf[0] = 0xe0 | (c >> 12);
+		buf[1] = 0x80 | ((c >> 6) & 0x3f);
+		buf[2] = 0x80 | (c & 0x3f);
 	}
-	/* We don't support characters above 0xFFFF in NTFS. */
-	return 0;
+	return 3;
 }
 
-/* Decodes a sequence of utf8 bytes into a single wide character.
+/*
+ * Decodes a sequence of utf8 bytes into a single wide character.
  * The character is returned in host byte order.
- * Returns the number of bytes consumed, or 0 on error. */
-static int from_utf8(const unsigned char* str, ntfs_u16 *c)
+ * Returns the number of bytes consumed, or 0 on error.
+ */
+static int from_utf8(const unsigned char *str, ntfs_u16 *c)
 {
 	int l = 0, i;
 
@@ -80,11 +82,12 @@
 	return l;
 }
 
-/* Converts wide string to UTF-8. Expects two in- and two out-parameters.
+/*
+ * Converts wide string to UTF-8. Expects two in- and two out-parameters.
  * Returns 0 on success, or error code. 
  * The caller has to free the result string.
- * There is no support for UTF-16, yet. */
-static int ntfs_dupuni2utf8(ntfs_u16* in, int in_len, char **out, int *out_len)
+ */
+static int ntfs_dupuni2utf8(ntfs_u16 *in, int in_len, char **out, int *out_len)
 {
 	int i, tmp;
 	int len8;
@@ -92,15 +95,14 @@
 
 	ntfs_debug(DEBUG_NAME1, "converting l = %d\n", in_len);
 	/* Count the length of the resulting UTF-8. */
-	for (i = len8 = 0; i < in_len; i++){
+	for (i = len8 = 0; i < in_len; i++) {
 		tmp = to_utf8(NTFS_GETU16(in + i), 0);
 		if (!tmp)
-			/* invalid character */
+			/* Invalid character. */
 			return -EILSEQ;
 		len8 += tmp;
 	}
 	*out = result = ntfs_malloc(len8 + 1); /* allow for zero-termination */
-
 	if (!result)
 		return -ENOMEM;
 	result[len8] = '\0';
@@ -111,10 +113,12 @@
 	return 0;
 }
 
-/* Converts an UTF-8 sequence to a wide string. Same conventions as the
- * previous function. */
+/*
+ * Converts an UTF-8 sequence to a wide string. Same conventions as the
+ * previous function.
+ */
 static int ntfs_duputf82uni(unsigned char* in, int in_len, ntfs_u16** out,
-			    int *out_len)
+		int *out_len)
 {
 	int i, tmp;
 	int len16;
@@ -131,76 +135,30 @@
 		return -ENOMEM;
 	result[len16] = 0;
 	*out_len = len16;
-	for (i = len16 = 0; i < in_len; i += tmp, len16++)
-	{
+	for (i = len16 = 0; i < in_len; i += tmp, len16++) {
 		tmp = from_utf8(in + i, &wtmp);
 		NTFS_PUTU16(result + len16, wtmp);
 	}
 	return 0;
 }
 
-/* See above. Produces ISO-8859-1 from wide strings. */
-static int ntfs_dupuni288591(ntfs_u16* in, int in_len, char** out, int *out_len)
-{
-	int i;
-	char *result;
-
-	/* Check for characters out of range. */
-	for (i = 0; i < in_len; i++)
-		if (NTFS_GETU16(in + i) >= 256)
-			return -EILSEQ;
-	*out = result = ntfs_malloc(in_len + 1);
-	if (!result)
-		return -ENOMEM;
-	result[in_len] = '\0';
-	*out_len = in_len;
-	for (i = 0; i < in_len; i++)
-		result[i] = (unsigned char)NTFS_GETU16(in + i);
-	return 0;
-}
-
-/* See above. */
-static int ntfs_dup885912uni(unsigned char* in, int in_len, ntfs_u16 **out,
-			     int *out_len)
-{
-	int i;
-
-	ntfs_u16* result;
-	*out = result = ntfs_malloc(2 * in_len);
-	if (!result)
-		return -ENOMEM;
-	*out_len = in_len;
-	for (i = 0; i < in_len; i++)
-		NTFS_PUTU16(result + i, in[i]);
-	return 0;
-}
-
-/* Encodings dispatcher */
+/* Encodings dispatchers. */
 int ntfs_encodeuni(ntfs_volume *vol, ntfs_u16 *in, int in_len, char **out,
-		   int *out_len)
+		int *out_len)
 {
-	if (vol->nct & nct_utf8)
-		return ntfs_dupuni2utf8(in, in_len, out, out_len);
-	else if (vol->nct & nct_iso8859_1)
-		return ntfs_dupuni288591(in, in_len, out, out_len);
-	else if(vol->nct & (nct_map | nct_uni_xlate))
-		/* uni_xlate is handled inside map. */
+	if (vol->nls_map)
 		return ntfs_dupuni2map(vol, in, in_len, out, out_len);
 	else
-		return -EINVAL; /* unknown encoding */
+		return ntfs_dupuni2utf8(in, in_len, out, out_len);
 }
 
 int ntfs_decodeuni(ntfs_volume *vol, char *in, int in_len, ntfs_u16 **out,
-		   int *out_len)
+		int *out_len)
 {
-	if (vol->nct & nct_utf8)
-		return ntfs_duputf82uni(in, in_len, out, out_len);
-	else if (vol->nct & nct_iso8859_1)
-		return ntfs_dup885912uni(in, in_len, out, out_len);
-	else if (vol->nct & (nct_map | nct_uni_xlate))
+	if (vol->nls_map)
 		return ntfs_dupmap2uni(vol, in, in_len, out, out_len);
 	else
-		return -EINVAL;
+		return ntfs_duputf82uni(in, in_len, out, out_len);
 }
 
 /* Same address space copies. */
@@ -224,18 +182,6 @@
 	return result;
 }
 
-#if 0
-/* Copy len unicode characters from from to to. :) */
-void ntfs_uni2ascii(char *to, short int *from, int len)
-{
-	int i;
-
-	for (i = 0; i < len; i++)
-		to[i] = NTFS_GETU16(from + i);
-	to[i] = '\0';
-}
-#endif
-
 /* Copy len ascii characters from from to to. :) */
 void ntfs_ascii2uni(short int *to, char *from, int len)
 {
@@ -279,57 +225,26 @@
 	return 0;
 }
 
+#define NTFS_TIME_OFFSET ((ntfs_time64_t)(369*365 + 89) * 24 * 3600 * 10000000)
+
 /* Convert the NT UTC (based 1.1.1601, in hundred nanosecond units)
  * into Unix UTC (based 1.1.1970, in seconds). */
 ntfs_time_t ntfs_ntutc2unixutc(ntfs_time64_t ntutc)
 {
-/* This is very gross because:
- * 1: We must do 64-bit division on a 32-bit machine.
- * 2: We can't use libgcc for long long operations in the kernel.
- * 3: Floating point math in the kernel would corrupt user data. */
-	const unsigned int D = 10000000;
-	unsigned int H = (unsigned int)(ntutc >> 32);
-	unsigned int L = (unsigned int)ntutc;
-	unsigned int numerator2;
-	unsigned int lowseconds;
-	unsigned int result;
-
-	/* It is best to subtract 0x019db1ded53e8000 first. */
-	/* Then the 1601-based date becomes a 1970-based date. */
-	if (L < (unsigned)0xd53e8000)
-		H--;
-	L -= (unsigned)0xd53e8000;
-	H -= (unsigned)0x019db1de;
-
-	/* Now divide 64-bit numbers on a 32-bit machine. :-)
-	 * With the subtraction already done, the result fits in 32 bits.
-	 * The numerator fits in 56 bits and the denominator fits
-	 * in 24 bits, so we can shift by 8 bits to make this work. */
-
-	numerator2  = (H << 8) | (L >> 24);
-	result      = (numerator2 / D);   /* shifted 24 right!! */
-	lowseconds  = result << 24;
-
-	numerator2  = ((numerator2 - result * D) << 8) | ((L >> 16) & 0xff);
-	result      = (numerator2 / D);   /* shifted 16 right!! */
-	lowseconds |= result << 16;
-
-	numerator2  = ((numerator2 - result * D) << 8) | ((L >> 8) & 0xff);
-	result      = (numerator2 / D);   /* shifted 8 right!! */
-	lowseconds |= result << 8;
-
-	numerator2  = ((numerator2 - result * D) << 8) | (L & 0xff);
-	result      = (numerator2 / D);   /* not shifted */
-	lowseconds |= result;
-
-	return lowseconds;
+	/* Subtract the NTFS time offset, then convert to 1s intervals. */
+	ntfs_time64_t t = ntutc - NTFS_TIME_OFFSET;
+	do_div(t, 10000000);
+	return (ntfs_time_t)t;
 }
 
 /* Convert the Unix UTC into NT UTC. */
 ntfs_time64_t ntfs_unixutc2ntutc(ntfs_time_t t)
 {
-	return ((t + (ntfs_time64_t)(369 * 365 + 89) * 24 * 3600) * 10000000);
+	/* Convert to 100ns intervals and then add the NTFS time offset. */
+	return (ntfs_time64_t)t * 10000000 + NTFS_TIME_OFFSET;
 }
+
+#undef NTFS_TIME_OFFSET
 
 /* Fill index name. */
 void ntfs_indexname(char *buf, int type)
diff -urN linux-2.4.8-pre3.vanilla/fs/ntfs/util.h linux-2.4.8-pre3.tmd/fs/ntfs/util.h
--- linux-2.4.8-pre3.vanilla/fs/ntfs/util.h	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-pre3.tmd/fs/ntfs/util.h	Tue Jul 31 17:12:43 2001
@@ -5,18 +5,6 @@
  * Copyright (C) 2001 Anton Altaparmakov (AIA)
  */
 
-/* Which character set is used for file names. */
-/*  Translate everything to UTF-8. */
-#define nct_utf8             1
-/*  Translate to 8859-1. */
-#define nct_iso8859_1        2
-/*  Quote unprintables with ":". */
-#define nct_uni_xlate        4
-/*  Do that in the vfat way instead of the documented way. */
-#define nct_uni_xlate_vfat   8
-/*  Use a mapping table to determine printables. */
-#define nct_map              16
-
 /* The first 16 inodes correspond to NTFS special files. */
 typedef enum {
 	FILE_$Mft	= 0,
@@ -42,9 +30,6 @@
 
 /* String operations */
 /*  Copy Unicode <-> ASCII */
-#if 0
-void ntfs_uni2ascii(char *to, char *from, int len);
-#endif
 void ntfs_ascii2uni(short int *to, char *from, int len);
 
 /*  Comparison */
diff -urN linux-2.4.8-pre3.vanilla/include/linux/ntfs_fs_sb.h linux-2.4.8-pre3.tmd/include/linux/ntfs_fs_sb.h
--- linux-2.4.8-pre3.vanilla/include/linux/ntfs_fs_sb.h	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-pre3.tmd/include/linux/ntfs_fs_sb.h	Tue Jul 31 15:42:21 2001
@@ -8,7 +8,6 @@
 	ntfs_uid_t uid;
 	ntfs_gid_t gid;
 	ntmode_t umask;
-        unsigned int nct;
 	void *nls_map;
 	unsigned int ngt;
 	/* Configuration provided by user with the ntfstools.
diff -urN linux-2.4.8-pre3.vanilla/fs/ntfs/fs.c linux-2.4.8-pre3.tmd/fs/ntfs/fs.c
--- linux-2.4.8-pre3.vanilla/fs/ntfs/fs.c	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-pre3.tmd/fs/ntfs/fs.c	Tue Jul 31 18:37:45 2001
@@ -1,8 +1,8 @@
 /*
  * fs.c - NTFS driver for Linux 2.4.x
  *
- * Development has as of recently (since June '01) been sponsored
- * by Legato Systems, Inc. (http://www.legato.com)
+ * Legato Systems, Inc. (http://www.legato.com) have sponsored Anton
+ * Altaparmakov to develop NTFS on Linux since June 2001.
  *
  * Copyright (C) 1995-1997, 1999 Martin von Löwis
  * Copyright (C) 1996 Richard Russon
@@ -286,25 +286,25 @@
 }
 
 /* Parse the (re)mount options. */
-static int parse_options(ntfs_volume* vol, char *opt)
+static int parse_options(ntfs_volume *vol, char *opt, int remount)
 {
-	char *value;
-
-	vol->uid = vol->gid = 0;
-	vol->umask = 0077;
-	vol->ngt = ngt_nt;
-	vol->nls_map = 0;
-	vol->nct = 0;
+	char *value;		/* Defaults if not specified and !remount. */
+	ntfs_uid_t uid = -1;	/* 0, root user only */
+	ntfs_gid_t gid = -1;	/* 0, root user only */
+	int umask = -1;		/* 0077, owner access only */
+	unsigned int ngt = -1;	/* ngt_nt */
+	void *nls_map = NULL;	/* Try to load the default NLS. */
+	int use_utf8 = -1;	/* If no NLS specified and loading the default
+				   NLS failed use utf8. */
 	if (!opt)
 		goto done;
-	for (opt = strtok(opt, ","); opt; opt = strtok(NULL, ","))
-	{
+	for (opt = strtok(opt, ","); opt; opt = strtok(NULL, ",")) {
 		if ((value = strchr(opt, '=')) != NULL)
 			*value ++= '\0';
 		if (strcmp(opt, "uid") == 0) {
 			if (!value || !*value)
 				goto needs_arg;
-			vol->uid = simple_strtoul(value, &value, 0);
+			uid = simple_strtoul(value, &value, 0);
 			if (*value) {
 				printk(KERN_ERR "NTFS: uid invalid argument\n");
 				return 0;
@@ -312,7 +312,7 @@
 		} else if (strcmp(opt, "gid") == 0) {
 			if (!value || !*value)
 				goto needs_arg;
-			vol->gid = simple_strtoul(value, &value, 0);
+			gid = simple_strtoul(value, &value, 0);
 			if (*value) {
 				printk(KERN_ERR "NTFS: gid invalid argument\n");
 				return 0;
@@ -320,79 +320,86 @@
 		} else if (strcmp(opt, "umask") == 0) {
 			if (!value || !*value)
 				goto needs_arg;
-			vol->umask = simple_strtoul(value, &value, 0);
+			umask = simple_strtoul(value, &value, 0);
 			if (*value) {
 				printk(KERN_ERR "NTFS: umask invalid "
 						"argument\n");
 				return 0;
 			}
-		} else if (strcmp(opt, "iocharset") == 0) {
-			if (!value || !*value)
-				goto needs_arg;
-			vol->nls_map = load_nls(value);
-			vol->nct |= nct_map;
-			if (!vol->nls_map) {
-				printk(KERN_ERR "NTFS: charset not found");
-				return 0;
-			}
 		} else if (strcmp(opt, "posix") == 0) {
 			int val;
 			if (!value || !*value)
 				goto needs_arg;
 			if (!simple_getbool(value, &val))
 				goto needs_bool;
-			vol->ngt = val ? ngt_posix : ngt_nt;
+			ngt = val ? ngt_posix : ngt_nt;
 		} else if (strcmp(opt, "show_sys_files") == 0) {
 			int val = 0;
 			if (!value || !*value)
 				val = 1;
 			else if (!simple_getbool(value, &val))
 				goto needs_bool;
-			vol->ngt = val ? ngt_full : ngt_nt;
-		} else if (strcmp(opt, "utf8") == 0) {
-			int val = 0;
+			ngt = val ? ngt_full : ngt_nt;
+		} else if (strcmp(opt, "iocharset") == 0) {
 			if (!value || !*value)
-				val = 1;
-			else if (!simple_getbool(value, &val))
-				goto needs_bool;
-			if (val)
-				vol->nct |= nct_utf8;
-		} else if (strcmp(opt, "uni_xlate") == 0) {
+				goto needs_arg;
+			nls_map = load_nls(value);
+			if (!nls_map) {
+				printk(KERN_ERR "NTFS: charset not found");
+				return 0;
+			}
+		} else if (strcmp(opt, "utf8") == 0) {
 			int val = 0;
-			/* No argument: uni_vfat. boolean argument: uni_vfat.
-			 * "2": uni. */
 			if (!value || !*value)
 				val = 1;
-			else if (strcmp(value, "2") == 0)
-				vol->nct |= nct_uni_xlate;
 			else if (!simple_getbool(value, &val))
 				goto needs_bool;
-			if (val)
-				vol->nct |= nct_uni_xlate_vfat | nct_uni_xlate;
+			use_utf8 = val;
 		} else {
 			printk(KERN_ERR "NTFS: unkown option '%s'\n", opt);
 			return 0;
 		}
 	}
-	if (vol->nct & nct_utf8 & (nct_map | nct_uni_xlate)) {
-		printk(KERN_ERR "utf8 cannot be combined with iocharset or "
-				"uni_xlate\n");
-		return 0;
-	}
- done:
-	if ((vol->nct & (nct_uni_xlate | nct_map | nct_utf8)) == 0)
-		/* default to UTF-8 */
-		vol->nct = nct_utf8;
-	if (!vol->nls_map) {
-		vol->nls_map = load_nls_default();
-		if (vol->nls_map)
-			vol->nct = nct_map | (vol->nct&nct_uni_xlate);
-	}
+done:
+	if (use_utf8 != -1 && use_utf8) {
+		if (nls_map) {
+			unload_nls(nls_map);
+			printk(KERN_ERR "NTFS: utf8 cannot be combined with "
+					"iocharset.\n");
+			return 0;
+		}
+		if (remount && vol->nls_map)
+			unload_nls(vol->nls_map);
+		vol->nls_map = NULL;
+	} else {
+		if (nls_map) {
+			if (remount && vol->nls_map)
+				unload_nls(vol->nls_map);
+			vol->nls_map = nls_map;
+		} else if (!remount || (remount && !use_utf8 && !vol->nls_map))
+			vol->nls_map = load_nls_default();
+	}
+	if (uid != -1)
+		vol->uid = uid;
+	else if (!remount)
+		vol->uid = 0;
+	if (gid != -1)
+		vol->gid = gid;
+	else if (!remount)
+		vol->gid = 0;
+	if (umask != -1)
+		vol->umask = (ntmode_t)umask;
+	else if (!remount)
+		vol->umask = 0077;
+	if (ngt != -1)
+		vol->ngt = ngt;
+	else if (!remount)
+		vol->ngt = ngt_nt;
 	return 1;
- needs_arg:
+needs_arg:
 	printk(KERN_ERR "NTFS: %s needs an argument", opt);
 	return 0;
- needs_bool:
+needs_bool:
 	printk(KERN_ERR "NTFS: %s needs boolean argument", opt);
 	return 0;
 }
@@ -898,7 +905,7 @@
 /* Called when remounting a filesystem by do_remount_sb() in fs/super.c. */
 static int ntfs_remount_fs(struct super_block *sb, int *flags, char *options)
 {
-	if (!parse_options(NTFS_SB2VOL(sb), options))
+	if (!parse_options(NTFS_SB2VOL(sb), options, 1))
 		return -EINVAL;
 	return 0;
 }
@@ -1003,7 +1010,7 @@
 
 	ntfs_debug(DEBUG_OTHER, "ntfs_read_super\n");
 	vol = NTFS_SB2VOL(sb);
-	if (!parse_options(vol, (char*)options))
+	if (!parse_options(vol, (char*)options, 0))
 		goto ntfs_read_super_vol;
 	/* Assume a 512 bytes block device for now. */
 	set_blocksize(sb->s_dev, 512);
diff -urN linux-2.4.8-pre3.vanilla/fs/ntfs/Makefile linux-2.4.8-pre3.tmd/fs/ntfs/Makefile
--- linux-2.4.8-pre3.vanilla/fs/ntfs/Makefile	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-pre3.tmd/fs/ntfs/Makefile	Tue Jul 31 18:34:51 2001
@@ -5,7 +5,7 @@
 obj-y   := fs.o sysctl.o support.o util.o inode.o dir.o super.o attr.o unistr.o
 obj-m   := $(O_TARGET)
 # New version format started 3 February 2001.
-EXTRA_CFLAGS = -DNTFS_VERSION=\"1.1.15\" #-DDEBUG
+EXTRA_CFLAGS = -DNTFS_VERSION=\"1.1.16\" #-DDEBUG
 
 include $(TOPDIR)/Rules.make
 
diff -urN linux-2.4.8-pre3.vanilla/Documentation/filesystems/ntfs.txt linux-2.4.8-pre3.tmd/Documentation/filesystems/ntfs.txt
--- linux-2.4.8-pre3.vanilla/Documentation/filesystems/ntfs.txt	Mon Jul 16 23:14:10 2001
+++ linux-2.4.8-pre3.tmd/Documentation/filesystems/ntfs.txt	Tue Jul 31 18:36:52 2001
@@ -1,8 +1,8 @@
 NTFS Overview
 =============
 
-Driver development has as of recently (since June '01) been sponsored
-by Legato Systems, Inc. (http://www.legato.com)
+Legato Systems, Inc. (http://www.legato.com) have sponsored Anton Altaparmakov
+to develop NTFS on Linux since June 2001.
 
 To mount an NTFS volume, use the filesystem type 'ntfs'. The driver
 currently works only in read-only mode, with no fault-tolerance supported.
@@ -36,15 +36,17 @@
 
 iocharset=name		Character set to use when returning file names.
 			Unlike VFAT, NTFS suppresses names that contain
-			unconvertible characters
-
-utf8=<bool>		Use UTF-8 for converting file names
-
-uni_xlate=<bool>,2	Use the VFAT-style encoding for file names outside
-			the current character set. A boolean value will
-			enable the feature, a value of 2 will enable the
-			encoding as documented in vfat.txt:
-				':', (u & 0x3f), ((u>>6) & 0x3f), (u>>12),
+			unconvertible characters. Note that most character
+			sets contain insufficient characters to represent all
+			possible Unicode characters that can exist on NTFS. To
+			be sure you are not missing any files, you are advised
+			to use the iocharset=utf8 which should be capable of
+			representing all Unicode characters.
+
+utf8=<bool>		Use UTF-8 for converting file names. - It is preferable
+			to use iocharset=utf8 instead, but if the utf8 NLS is
+			not available, you can use this utf8 option, which
+			enables the driver's builtin utf8 conversion functions.
 
 uid=
 gid=
@@ -80,6 +82,27 @@
 
 ChangeLog
 =========
+
+NTFS 1.1.16:
+
+	- Removed non-functional uni_xlate mount options.
+	- Clarified the semantics of the utf8 and iocharset mount options.
+	- Threw out the non-functional mount options for using hard coded
+	  character set conversion. Only kept utf8 one.
+	- Fixed handling of mount options and proper handling of faulty mount
+	  options on remount.
+	- Cleaned up character conversion which basically became simplified a
+	  lot due to the removal of the above mentioned mount options.
+	- Made character conversion to be always consistent. Previously we
+	  could output to the VFS file names which we would then not accept
+	  back from the VFS so in effect we were generating ghost entries in
+	  the directory listings which could not be accessed by any means.
+	- Simplified time conversion functions drastically without sacrificing
+	  accuracy. (-8
+	- Fixed a use of a pointer before the check for the pointer being
+	  NULL, reported by the Stanford checker.
+	- Fixed several missing error checks, reported by the Stanford
+	  checker and fixed by Rasmus Andersen.
 
 NTFS 1.1.15 (changes since kernel 2.4.4's NTFS driver):
 

