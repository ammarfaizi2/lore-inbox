Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUJCKzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUJCKzf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 06:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267779AbUJCKzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 06:55:35 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:32012 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267709AbUJCKzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 06:55:31 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: jmorris@redhat.com, davem@davemloft.net
Subject: [PATCH] sha512: use asm-optimized bit rotation
Date: Sun, 3 Oct 2004 13:55:24 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cq9XBWdsb+6krBt"
Message-Id: <200410031355.24650.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_cq9XBWdsb+6krBt
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On top of 2.6.9-rc3 + "reduce sha512_transform() stack usage" +
+ "add rotate left/right ops to bitops.h" patches.

Switches sha512 to asm-optimized 64bit rotation.
Reduces sha512 code size by ~300 insns, ~1K:

# size sha512.o.old sha512.o
   text    data     bss     dec     hex filename
   6642     364       0    7006    1b5e sha512.o.old
   5587     364       0    5951    173f sha512.o

Run-tested with tcrypt module.

I also looked into optimizing cast[56] and sha256 by replacing
their 32bit rotation functions/macros, but it had no measurable effect
on i386. gcc seems to be on par with asm there.
--
vda

--Boundary-00=_cq9XBWdsb+6krBt
Content-Type: text/x-diff;
  charset="koi8-r";
  name="sha512.c.rot64.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sha512.c.rot64.diff"

--- linux-2.6.9-rc3.src/crypto/sha512.c	Sat Oct  2 21:53:05 2004
+++ linux-2.6.9-rc3rot.src/crypto/sha512.c	Sun Oct  3 12:53:18 2004
@@ -43,11 +43,6 @@ static inline u64 Maj(u64 x, u64 y, u64 
         return (x & y) | (z & (x | y));
 }
 
-static inline u64 RORu64(u64 x, u64 y)
-{
-        return (x >> y) | (x << (64 - y));
-}
-
 const u64 sha512_K[80] = {
         0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
         0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
@@ -78,10 +73,10 @@ const u64 sha512_K[80] = {
         0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL,
 };
 
-#define e0(x)       (RORu64(x,28) ^ RORu64(x,34) ^ RORu64(x,39))
-#define e1(x)       (RORu64(x,14) ^ RORu64(x,18) ^ RORu64(x,41))
-#define s0(x)       (RORu64(x, 1) ^ RORu64(x, 8) ^ (x >> 7))
-#define s1(x)       (RORu64(x,19) ^ RORu64(x,61) ^ (x >> 6))
+#define e0(x)       (ror64(x,28) ^ ror64(x,34) ^ ror64(x,39))
+#define e1(x)       (ror64(x,14) ^ ror64(x,18) ^ ror64(x,41))
+#define s0(x)       (ror64(x, 1) ^ ror64(x, 8) ^ (x >> 7))
+#define s1(x)       (ror64(x,19) ^ ror64(x,61) ^ (x >> 6))
 
 /* H* initial state for SHA-512 */
 #define H0         0x6a09e667f3bcc908ULL

--Boundary-00=_cq9XBWdsb+6krBt--

