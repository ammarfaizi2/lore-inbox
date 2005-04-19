Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVDSG2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVDSG2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 02:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVDSG2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 02:28:06 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:38661 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261340AbVDSG15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 02:27:57 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] sha512: use 64bit rotations
Date: Tue, 19 Apr 2005 09:26:53 +0300
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>
References: <200504190918.10279.vda@port.imtp.ilyichevsk.odessa.ua> <200504190921.34294.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200504190921.34294.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tSKZCSGK2y3nJIo"
Message-Id: <200504190926.53565.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tSKZCSGK2y3nJIo
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

this results in following code size changes on i386:

# size sha512_org.o sha512_be.o sha512_ror.o
   text    data     bss     dec     hex filename
   5339     364       0    5703    1647 sha512_org.o
   5221     364       0    5585    15d1 sha512_be.o
   5122     364       0    5486    156e sha512_ror.o

modprobe tcrypt:

testing sha384
test 1:
cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7
pass
test 2:
3391fdddfc8dc7393707a65b1b4709397cf8b1d162af05abfe8f450de5f36bc6b0455a8520bc4e6f5fe95b1fe3c8452b
pass
test 3:
09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039
pass
test 4:
3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
pass
testing sha384 across pages
test 1:
3d208973ab3508dbbd7e2c2862ba290ad3010e4978c198dc4d8fd014e582823a89e16f9b2a7bbc1ac938e2d199e8bea4
pass

testing sha512
test 1:
ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f
pass
test 2:
204a8fc6dda82f0a0ced7beb8e08a41657c16ef468b228a8279be331a703c33596fd15c13b1b07f9aa1d3bea57789ca031ad85c7a71dd70354ec631238ca3445
pass
test 3:
8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909
pass
test 4:
930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
pass
testing sha512 across pages
test 1:
930d0cefcb30ff1133b6898121f1cf3d27578afcafe8677c5257cf069911f75d8f5831b56ebfda67b278e66dff8b84fe2b2870f742a580d8edb41987232850c9
pass
--
vda

--Boundary-00=_tSKZCSGK2y3nJIo
Content-Type: text/x-diff;
  charset="koi8-r";
  name="2.ror.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.ror.patch"

diff -urpN 2.6.12-rc2.1.be/crypto/sha512.c 2.6.12-rc2.2.ror/crypto/sha512.c
--- 2.6.12-rc2.1.be/crypto/sha512.c	Mon Apr 18 23:31:54 2005
+++ 2.6.12-rc2.2.ror/crypto/sha512.c	Mon Apr 18 23:37:20 2005
@@ -43,11 +43,6 @@ static inline u64 Maj(u64 x, u64 y, u64 
         return (x & y) | (z & (x | y));
 }
 
-static inline u64 RORu64(u64 x, u64 y)
-{
-        return (x >> y) | (x << (64 - y));
-}
-
 static const u64 sha512_K[80] = {
         0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL, 0xb5c0fbcfec4d3b2fULL,
         0xe9b5dba58189dbbcULL, 0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
@@ -78,10 +73,10 @@ static const u64 sha512_K[80] = {
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

--Boundary-00=_tSKZCSGK2y3nJIo--

