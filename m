Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbTEFKMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 06:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262498AbTEFKMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 06:12:09 -0400
Received: from [217.157.19.70] ([217.157.19.70]:6416 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S262497AbTEFKMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 06:12:08 -0400
Date: Tue, 6 May 2003 12:24:39 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: marcelo@conectiva.com.br
cc: Christoph Hellwig <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined
 (trivial)
In-Reply-To: <20030506110259.A29633@infradead.org>
Message-ID: <Pine.LNX.4.40.0305061216060.13598-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Here is a patch to fix the following problem (revised as Christoph
suggested): In 2.4.21-rc1 some inline functions are added to
asm-i386/byteorder.h. When __STRICT_ANSI__ is defined, __u64 doesn't get
defined by asm-i386/types.h, but it is used in one of the new inline
functions, __arch__swab64() - this causes a compile error for any program
that includes linux/cdrom.h and is built with -ansi. See also Christoph's
other comments on the list.

On Tue, 6 May 2003, Christoph Hellwig wrote:
> [..]
> You might want to reorder the code a bit to have only one
> __STRICT_ANSI__ ifdef, but else it looks fine.

// Thomas


--- linux-2.4.21-rc1-orig/include/asm-i386/byteorder.h	2003-05-06 09:52:33.000000000 +0100
+++ linux-2.4.21-rc1-ac4/include/asm-i386/byteorder.h	2003-05-06 11:20:01.000000000 +0100
@@ -34,7 +34,7 @@
 		return x;
 }

-
+#ifndef __STRICT_ANSI__
 static inline __u64 ___arch__swab64(__u64 val)
 {
 	union {
@@ -54,12 +54,14 @@
 	return v.u;
 }

+#define __BYTEORDER_HAS_U64__
 #define __arch__swab64(x) ___arch__swab64(x)
+
+#endif /* !__STRICT_ANSI__ */
+
 #define __arch__swab32(x) ___arch__swab32(x)
 #define __arch__swab16(x) ___arch__swab16(x)

-#define __BYTEORDER_HAS_U64__
-
 #endif /* __GNUC__ */

 #include <linux/byteorder/little_endian.h>

