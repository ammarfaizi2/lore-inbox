Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261729AbUKADIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbUKADIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 22:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUKADIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 22:08:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54716 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261729AbUKADIN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 22:08:13 -0500
Date: Mon, 1 Nov 2004 03:08:10 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: [PATCH] Use optimised byteswap again
Message-ID: <20041101030810.GH8958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looks like Al's patch to sparsify the byteorder code prevented use of the
assembler-optimised code.  Not that I can blame him -- three underscores
are C-coded and two underscores are assembly-optimised.

Index: linux-2.6/include/linux/byteorder/big_endian.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/byteorder/big_endian.h,v
retrieving revision 1.3
diff -u -p -r1.3 big_endian.h
--- linux-2.6/include/linux/byteorder/big_endian.h	11 Oct 2004 21:41:36 -0000	1.3
+++ linux-2.6/include/linux/byteorder/big_endian.h	1 Nov 2004 02:59:17 -0000
@@ -27,12 +27,12 @@
 #define __constant_be32_to_cpu(x) ((__force __u32)(__be32)(x))
 #define __constant_cpu_to_be16(x) ((__force __be16)(__u16)(x))
 #define __constant_be16_to_cpu(x) ((__force __u16)(__be16)(x))
-#define __cpu_to_le64(x) ((__force __le64)___swab64((x)))
-#define __le64_to_cpu(x) ___swab64((__force __u64)(__le64)(x))
-#define __cpu_to_le32(x) ((__force __le32)___swab32((x)))
-#define __le32_to_cpu(x) ___swab32((__force __u32)(__le32)(x))
-#define __cpu_to_le16(x) ((__force __le16)___swab16((x)))
-#define __le16_to_cpu(x) ___swab16((__force __u16)(__le16)(x))
+#define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
+#define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
+#define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
+#define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
+#define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
+#define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
 #define __cpu_to_be64(x) ((__force __be64)(__u64)(x))
 #define __be64_to_cpu(x) ((__force __u64)(__be64)(x))
 #define __cpu_to_be32(x) ((__force __be32)(__u32)(x))
Index: linux-2.6/include/linux/byteorder/little_endian.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/byteorder/little_endian.h,v
retrieving revision 1.3
diff -u -p -r1.3 little_endian.h
--- linux-2.6/include/linux/byteorder/little_endian.h	11 Oct 2004 21:41:36 -0000	1.3
+++ linux-2.6/include/linux/byteorder/little_endian.h	1 Nov 2004 02:59:17 -0000
@@ -33,12 +33,12 @@
 #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
 #define __cpu_to_le16(x) ((__force __le16)(__u16)(x))
 #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
-#define __cpu_to_be64(x) ((__force __be64)___swab64((x)))
-#define __be64_to_cpu(x) ___swab64((__force __u64)(__be64)(x))
-#define __cpu_to_be32(x) ((__force __be32)___swab32((x)))
-#define __be32_to_cpu(x) ___swab32((__force __u32)(__be32)(x))
-#define __cpu_to_be16(x) ((__force __be16)___swab16((x)))
-#define __be16_to_cpu(x) ___swab16((__force __u16)(__be16)(x))
+#define __cpu_to_be64(x) ((__force __be64)__swab64((x)))
+#define __be64_to_cpu(x) __swab64((__force __u64)(__be64)(x))
+#define __cpu_to_be32(x) ((__force __be32)__swab32((x)))
+#define __be32_to_cpu(x) __swab32((__force __u32)(__be32)(x))
+#define __cpu_to_be16(x) ((__force __be16)__swab16((x)))
+#define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
 
 static inline __le64 __cpu_to_le64p(const __u64 *p)
 {

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
