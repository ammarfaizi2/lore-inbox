Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267033AbUBGTBH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 14:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267036AbUBGTBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 14:01:07 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32986 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267033AbUBGTA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 14:00:59 -0500
Date: Sat, 7 Feb 2004 20:00:51 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Gerard Roudier <groudier@free.fr>
Cc: matthew@wil.cx, linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: [patch] sym53c8xx_2: warning: "BYTE_ORDER" is not defined
Message-ID: <20040207190051.GN26093@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

when compiling 2.6.2-mm1 (this problem doesn't seem to be specific
to -mm)) with -Wundef I got many of the following warnings:

<--  snip  -->

...
  CC      drivers/scsi/sym53c8xx_2/sym_fw.o
In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:80,
                 from drivers/scsi/sym53c8xx_2/sym_fw.c:56:
drivers/scsi/sym53c8xx_2/sym_misc.h:227:9: warning: "BYTE_ORDER" is not  defined
drivers/scsi/sym53c8xx_2/sym_misc.h:227:23: warning: "BIG_ENDIAN" is not  defined
...

<--  snip  -->


I don't see a BYTE_ORDER defined anywhere.


And it seems that the whole #ifdef'ed block isn't used anywhere.
Is it OK to remove it (patch below)?


cu
Adrian

--- linux-2.6.2-mm1/drivers/scsi/sym53c8xx_2/sym_misc.h.old	2004-02-07 19:43:05.000000000 +0100
+++ linux-2.6.2-mm1/drivers/scsi/sym53c8xx_2/sym_misc.h	2004-02-07 19:54:37.000000000 +0100
@@ -222,42 +222,6 @@
 #define sym_is_bit(p, n)	(((u32 *)(p))[(n)>>5] &   (1<<((n)&0x1f)))
 
 /*
- *  Portable but silly implemented byte order primitives.
- */
-#if	BYTE_ORDER == BIG_ENDIAN
-
-#define __revb16(x) (	(((u16)(x) & (u16)0x00ffU) << 8) | \
-			(((u16)(x) & (u16)0xff00U) >> 8) 	)
-#define __revb32(x) (	(((u32)(x) & 0x000000ffU) << 24) | \
-			(((u32)(x) & 0x0000ff00U) <<  8) | \
-			(((u32)(x) & 0x00ff0000U) >>  8) | \
-			(((u32)(x) & 0xff000000U) >> 24)	)
-
-#define __htole16(v)	__revb16(v)
-#define __htole32(v)	__revb32(v)
-#define __le16toh(v)	__htole16(v)
-#define __le32toh(v)	__htole32(v)
-
-static __inline u16	_htole16(u16 v) { return __htole16(v); }
-static __inline u32	_htole32(u32 v) { return __htole32(v); }
-#define _le16toh	_htole16
-#define _le32toh	_htole32
-
-#else	/* LITTLE ENDIAN */
-
-#define __htole16(v)	(v)
-#define __htole32(v)	(v)
-#define __le16toh(v)	(v)
-#define __le32toh(v)	(v)
-
-#define _htole16(v)	(v)
-#define _htole32(v)	(v)
-#define _le16toh(v)	(v)
-#define _le32toh(v)	(v)
-
-#endif	/* BYTE_ORDER */
-
-/*
  * The below round up/down macros are to be used with a constant 
  * as argument (sizeof(...) for example), for the compiler to 
  * optimize the whole thing.
