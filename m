Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbTEFJEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbTEFJEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:04:15 -0400
Received: from [217.157.19.70] ([217.157.19.70]:28942 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S262470AbTEFJEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:04:14 -0400
Date: Tue, 6 May 2003 11:16:45 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined
 (trivial)
Message-ID: <Pine.LNX.4.40.0305061034030.8287-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In 2.4.21-rc1 some inline functions are added to asm-i386/byteorder.h.
When __STRICT_ANSI__ is defined, __u64 doesn't get defined by
asm-i386/types.h, but it is used in one of the new inline functions,
__arch__swab64.

This causes files that use __STRICT_ANSI__ and include any file that
relies on byteorder.h to give a compile error:

make[4]: Entering directory `/var/tmp/portage/kdemultimedia-3.1.1/work/kdemultimedia-3.1.1/kioslave/audiocd'
/bin/sh ../../libtool --silent --mode=compile --tag=CXX g++ -DHAVE_CONFIG_H -I. -I. -I../.. -I/usr/kde/3.1/include -I/usr/qt/3/include -I/usr/X11R6/include      -DQT_THREAD_SUPPORT  -D_REENTRANT  -Wnon-virtual-dtor -Wno-long-long -Wundef -Wall -pedantic -W -Wpointer-arith -Wmissing-prototypes -Wwrite-strings -ansi -D_XOPEN_SOURCE=500 -D_BSD_SOURCE -Wcast-align -Wconversion -DNDEBUG -DNO_DEBUG -O2 -mcpu=athlon-xp -O2 -pipe -fno-exceptions -fno-check-new -DQT_CLEAN_NAMESPACE -DQT_NO_ASCII_CAST  -c -o audiocd.lo `test -f audiocd.cpp || echo './'`audiocd.cpp
In file included from /usr/include/linux/cdrom.h:14,
                 from audiocd.cpp:57:
/usr/include/asm/byteorder.h:38: syntax error before `(' token
[.....]

The following patch fixes the problem:

--- linux-2.4.21-rc1-orig/include/asm-i386/byteorder.h	2003-05-06 09:52:33.000000000 +0100
+++ linux-2.4.21-rc1-ac4-th/include/asm-i386/byteorder.h	2003-05-06 09:51:13.000000000 +0100
@@ -34,7 +34,7 @@
 		return x;
 }

-
+#ifndef __STRICT_ANSI__
 static inline __u64 ___arch__swab64(__u64 val)
 {
 	union {
@@ -53,12 +53,17 @@
 #endif
 	return v.u;
 }
+#endif /* !__STRICT_ANSI__ */

+#ifndef __STRICT_ANSI__
 #define __arch__swab64(x) ___arch__swab64(x)
+#endif
 #define __arch__swab32(x) ___arch__swab32(x)
 #define __arch__swab16(x) ___arch__swab16(x)

+#ifndef __STRICT_ANSI__
 #define __BYTEORDER_HAS_U64__
+#endif

 #endif /* __GNUC__ */


// Thomas

