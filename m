Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265846AbTF3L2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 07:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbTF3L2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 07:28:10 -0400
Received: from 12-207-41-15.client.attbi.com ([12.207.41.15]:30475 "EHLO
	skarpsey.home.lan") by vger.kernel.org with ESMTP id S265846AbTF3L2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 07:28:04 -0400
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ___arch__swab64() causing compile breakage
Date: Mon, 30 Jun 2003 06:44:22 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WKCA/s58x3U96mm"
Message-Id: <200306300644.22712.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_WKCA/s58x3U96mm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I just noticed that with the new implementation of 
___arch__swab64 in 2.4.21 (i386), kdemultimedia-3.1.x won't 
compile.  Basically it tries to include <linux/cdrom.h>, which 
in turn tries to include <asm/byteorder.h>, and it tries to 
compile it all with g++ -ansi.  ___arch__swab64() is partly to 
blame.

Now as much as we may call this a KDE bug, the old 
___arch__swab64 implementation didn't have this problem.  In the 
old implementation, both the __u64 type (from <asm/types.h>) and 
the ___arch__swab64() macro (which depends on the __u64 type) 
didn't get defined in userland for __STRICT_ANSI__ code.

With the new implementation taken from SGI XFS, __u64 still isn't 
defined for __STRICT_ANSI__ code, but ___arch__swab64() is 
exposed to the world no matter what.  Run that through gcc 
-ansi, and you get an instant parse error! ;)

That's reason enough to rectify this annoying little 
inconsistency.  I suggest we either let both code bits stay with 
__STRICT_ANSI__ defined, or we leave out at least the 
___arch__swab64() macro with __STRICT_ANSI__ defined.  I'm 
personally in favor of putting the old __STRICT_ANSI__ check 
around the new ___arch__swab64().

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

--Boundary-00=_WKCA/s58x3U96mm
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.4.21-swab64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.4.21-swab64.patch"

diff -Naur linux-2.4.20/include/asm-i386/byteorder.h linux-2.4.20-swab64/include/asm-i386/byteorder.h
--- linux-2.4.20/include/asm-i386/byteorder.h	2003-05-26 23:29:50.000000000 -0500
+++ linux-2.4.20-swab64/include/asm-i386/byteorder.h	2003-05-26 23:32:52.000000000 -0500
@@ -34,7 +34,7 @@
 		return x;
 }
 
-
+#if !defined(__STRICT_ANSI__) || defined(__KERNEL__)
 static inline __u64 ___arch__swab64(__u64 val) 
 { 
 	union { 
@@ -55,10 +55,12 @@
 } 
 
 #define __arch__swab64(x) ___arch__swab64(x)
+#define __BYTEORDER_HAS_U64__
+#endif
+
 #define __arch__swab32(x) ___arch__swab32(x)
 #define __arch__swab16(x) ___arch__swab16(x)
 
-#define __BYTEORDER_HAS_U64__
 
 #endif /* __GNUC__ */
 

--Boundary-00=_WKCA/s58x3U96mm--

