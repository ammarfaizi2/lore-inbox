Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266463AbUJAUv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266463AbUJAUv2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266631AbUJAUrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:47:51 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:35339 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266481AbUJAUiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:38:18 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: jmorris@redhat.com, davem@davemloft.net
Subject: [PATCH] reduce sha512_transform() stack usage, speedup
Date: Fri, 1 Oct 2004 23:38:11 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200410012231.51816.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410012231.51816.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_zAcXBGi30u/iYqU"
Message-Id: <200410012338.11301.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_zAcXBGi30u/iYqU
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On top of previous:

Patch moves large temporary u64 W[80]
from stack to ctx struct:

* reduces stack usage by 640 bytes
* saves one 640-byte memset() per sha512_transform()
  (we still do it after *all* iterations are done)
* quite unexpectedly saves 1.6k of code on i386
  because stack offsets now fit into 8bits
  and many stack addressing insns got 3 bytes smaller:

# size sha512.o.org sha512.o
text       data     bss     dec     hex filename
8281        372       0    8653    21cd sha512.o.org
6649        372       0    7021    1b6d sha512.o

# objdump -d sha512.o.org | cut -b9- >sha512.d.org
# objdump -d sha512.o | cut -b9- >sha512.d
# diff -u sha512.d.org sha512.d
[snip]
 :      8b 4b 28                mov    0x28(%ebx),%ecx
 :      8b 5b 2c                mov    0x2c(%ebx),%ebx
-:      89 8d 44 fd ff ff       mov    %ecx,0xfffffd44(%ebp)
-:      89 9d 48 fd ff ff       mov    %ebx,0xfffffd48(%ebp)
-:      89 9d f4 fc ff ff       mov    %ebx,0xfffffcf4(%ebp)
+:      89 4d c4                mov    %ecx,0xffffffc4(%ebp)
+:      89 5d c8                mov    %ebx,0xffffffc8(%ebp)
+:      89 9d 64 ff ff ff       mov    %ebx,0xffffff64(%ebp)
 :      8b 5d 08                mov    0x8(%ebp),%ebx
-:      89 8d f0 fc ff ff       mov    %ecx,0xfffffcf0(%ebp)
+:      89 8d 60 ff ff ff       mov    %ecx,0xffffff60(%ebp)
 :      8b 42 30                mov    0x30(%edx),%eax
 :      8b 52 34                mov    0x34(%edx),%edx
[snip]

WARNING: compile tested only.
--
vda

--Boundary-00=_zAcXBGi30u/iYqU
Content-Type: text/x-diff;
  charset="koi8-r";
  name="sha512.c.W.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sha512.c.W.patch"

--- linux-2.6.9-rc3/crypto/sha512.c.org	Fri Oct  1 22:17:14 2004
+++ linux-2.6.9-rc3/crypto/sha512.c	Fri Oct  1 23:20:13 2004
@@ -30,6 +30,7 @@
 	u64 state[8];
 	u32 count[4];
 	u8 buf[128];
+	u64 W[80];
 };
 
 static inline u64 Ch(u64 x, u64 y, u64 z)
@@ -113,10 +114,9 @@
 }
 
 static void
-sha512_transform(u64 *state, const u8 *input)
+sha512_transform(u64 *state, u64 *W, const u8 *input)
 {
 	u64 a, b, c, d, e, f, g, h, t1, t2;
-	u64 W[80];
 
 	int i;
 
@@ -157,7 +157,6 @@
 
 	/* erase our data */
 	a = b = c = d = e = f = g = h = t1 = t2 = 0;
-	memset(W, 0, 80 * sizeof(u64));
 }
 
 static void
@@ -215,10 +214,10 @@
 	/* Transform as many times as possible. */
 	if (len >= part_len) {
 		memcpy(&sctx->buf[index], data, part_len);
-		sha512_transform(sctx->state, sctx->buf);
+		sha512_transform(sctx->state, sctx->W, sctx->buf);
 
 		for (i = part_len; i + 127 < len; i+=128)
-			sha512_transform(sctx->state, &data[i]);
+			sha512_transform(sctx->state, sctx->W, &data[i]);
 
 		index = 0;
 	} else {
@@ -227,6 +226,9 @@
 
 	/* Buffer remaining input */
 	memcpy(&sctx->buf[index], &data[i], len - i);
+
+	/* erase our data */
+	memset(sctx->W, 0, sizeof(sctx->W));
 }
 
 static void

--Boundary-00=_zAcXBGi30u/iYqU--

