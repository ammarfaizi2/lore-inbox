Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVFHMN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVFHMN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 08:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVFHMN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 08:13:56 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:1262 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261230AbVFHMNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 08:13:36 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Wed, 8 Jun 2005 15:13:09 +0300
User-Agent: KMail/1.5.4
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
References: <20050607212706.GB7962@stusta.de> <200506081339.57012.vda@ilport.com.ua> <20050608111200.GG3641@stusta.de>
In-Reply-To: <20050608111200.GG3641@stusta.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_VDupCCnhxjSaN9n"
Message-Id: <200506081513.09828.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_VDupCCnhxjSaN9n
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 08 June 2005 14:12, Adrian Bunk wrote:
> On Wed, Jun 08, 2005 at 01:39:56PM +0300, Denis Vlasenko wrote:
> >...
> > NB: gcc 3.4.3 can use excessive stack in degenerate cases, so please
> > include gcc version in your reports.
> 
> But this can't occur in the kernel.

It can. I saw the OOPS myself.
One of the functions in crypto/wp512.c was compiled with 3k+ stack usage.
--
vda

--Boundary-00=_VDupCCnhxjSaN9n
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.wp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.wp.patch"

diff -urpN linux-2.6.12-rc2.1.be_le/crypto/wp512.c linux-2.6.12-rc2.2.wp/crypto/wp512.c
--- linux-2.6.12-rc2.1.be_le/crypto/wp512.c	Thu Apr 21 23:21:24 2005
+++ linux-2.6.12-rc2.2.wp/crypto/wp512.c	Thu Apr 21 23:42:36 2005
@@ -793,80 +793,90 @@ static void wp512_process_buffer(struct 
 	state[6] = block[6] ^ (K[6] = wctx->hash[6]);
 	state[7] = block[7] ^ (K[7] = wctx->hash[7]);
 
+#if 1
+ #define X(a) a ^=
+ #define XEND ;
+#else
+/* gcc -O2 (3.4.3) optimizer bug:
+** this will cause excessive spills (~3K stack used)
+** See http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21141 */
+ #define X(a) ^
+ #define XEND
+#endif
 	for (r = 1; r <= WHIRLPOOL_ROUNDS; r++) {
 
-		L[0] = C0[(int)(K[0] >> 56)       ] ^
-			   C1[(int)(K[7] >> 48) & 0xff] ^
-			   C2[(int)(K[6] >> 40) & 0xff] ^
-			   C3[(int)(K[5] >> 32) & 0xff] ^
-			   C4[(int)(K[4] >> 24) & 0xff] ^
-			   C5[(int)(K[3] >> 16) & 0xff] ^
-			   C6[(int)(K[2] >>  8) & 0xff] ^
-			   C7[(int)(K[1]      ) & 0xff] ^
-			   rc[r];
-
-		L[1] = C0[(int)(K[1] >> 56)       ] ^
-			   C1[(int)(K[0] >> 48) & 0xff] ^
-			   C2[(int)(K[7] >> 40) & 0xff] ^
-			   C3[(int)(K[6] >> 32) & 0xff] ^
-			   C4[(int)(K[5] >> 24) & 0xff] ^
-			   C5[(int)(K[4] >> 16) & 0xff] ^
-			   C6[(int)(K[3] >>  8) & 0xff] ^
-			   C7[(int)(K[2]      ) & 0xff];
-
-		L[2] = C0[(int)(K[2] >> 56)       ] ^
-			   C1[(int)(K[1] >> 48) & 0xff] ^
-			   C2[(int)(K[0] >> 40) & 0xff] ^
-			   C3[(int)(K[7] >> 32) & 0xff] ^
-			   C4[(int)(K[6] >> 24) & 0xff] ^
-			   C5[(int)(K[5] >> 16) & 0xff] ^
-			   C6[(int)(K[4] >>  8) & 0xff] ^
-			   C7[(int)(K[3]      ) & 0xff];
-
-		L[3] = C0[(int)(K[3] >> 56)       ] ^
-			   C1[(int)(K[2] >> 48) & 0xff] ^
-			   C2[(int)(K[1] >> 40) & 0xff] ^
-			   C3[(int)(K[0] >> 32) & 0xff] ^
-			   C4[(int)(K[7] >> 24) & 0xff] ^
-			   C5[(int)(K[6] >> 16) & 0xff] ^
-			   C6[(int)(K[5] >>  8) & 0xff] ^
-			   C7[(int)(K[4]      ) & 0xff];
-
-		L[4] = C0[(int)(K[4] >> 56)       ] ^
-			   C1[(int)(K[3] >> 48) & 0xff] ^
-			   C2[(int)(K[2] >> 40) & 0xff] ^
-			   C3[(int)(K[1] >> 32) & 0xff] ^
-			   C4[(int)(K[0] >> 24) & 0xff] ^
-			   C5[(int)(K[7] >> 16) & 0xff] ^
-			   C6[(int)(K[6] >>  8) & 0xff] ^
-			   C7[(int)(K[5]      ) & 0xff];
-
-		L[5] = C0[(int)(K[5] >> 56)       ] ^
-			   C1[(int)(K[4] >> 48) & 0xff] ^
-			   C2[(int)(K[3] >> 40) & 0xff] ^
-			   C3[(int)(K[2] >> 32) & 0xff] ^
-			   C4[(int)(K[1] >> 24) & 0xff] ^
-			   C5[(int)(K[0] >> 16) & 0xff] ^
-			   C6[(int)(K[7] >>  8) & 0xff] ^
-			   C7[(int)(K[6]      ) & 0xff];
-
-		L[6] = C0[(int)(K[6] >> 56)       ] ^
-			   C1[(int)(K[5] >> 48) & 0xff] ^
-			   C2[(int)(K[4] >> 40) & 0xff] ^
-			   C3[(int)(K[3] >> 32) & 0xff] ^
-			   C4[(int)(K[2] >> 24) & 0xff] ^
-			   C5[(int)(K[1] >> 16) & 0xff] ^
-			   C6[(int)(K[0] >>  8) & 0xff] ^
-			   C7[(int)(K[7]      ) & 0xff];
-
-		L[7] = C0[(int)(K[7] >> 56)       ] ^
-			   C1[(int)(K[6] >> 48) & 0xff] ^
-			   C2[(int)(K[5] >> 40) & 0xff] ^
-			   C3[(int)(K[4] >> 32) & 0xff] ^
-			   C4[(int)(K[3] >> 24) & 0xff] ^
-			   C5[(int)(K[2] >> 16) & 0xff] ^
-			   C6[(int)(K[1] >>  8) & 0xff] ^
-			   C7[(int)(K[0]      ) & 0xff];
+		L[0]  = C0[BYTE7(K[0])] XEND
+		X(L[0]) C1[BYTE6(K[7])] XEND
+		X(L[0]) C2[BYTE5(K[6])] XEND
+		X(L[0]) C3[BYTE4(K[5])] XEND
+		X(L[0]) C4[BYTE3(K[4])] XEND
+		X(L[0]) C5[BYTE2(K[3])] XEND
+		X(L[0]) C6[BYTE1(K[2])] XEND
+		X(L[0]) C7[BYTE0(K[1])] XEND
+		X(L[0]) rc[r];
+
+		L[1]  = C0[BYTE7(K[1])] XEND
+		X(L[1]) C1[BYTE6(K[0])] XEND
+		X(L[1]) C2[BYTE5(K[7])] XEND
+		X(L[1]) C3[BYTE4(K[6])] XEND
+		X(L[1]) C4[BYTE3(K[5])] XEND
+		X(L[1]) C5[BYTE2(K[4])] XEND
+		X(L[1]) C6[BYTE1(K[3])] XEND
+		X(L[1]) C7[BYTE0(K[2])];
+
+		L[2]  = C0[BYTE7(K[2])] XEND
+		X(L[2]) C1[BYTE6(K[1])] XEND
+		X(L[2]) C2[BYTE5(K[0])] XEND
+		X(L[2]) C3[BYTE4(K[7])] XEND
+		X(L[2]) C4[BYTE3(K[6])] XEND
+		X(L[2]) C5[BYTE2(K[5])] XEND
+		X(L[2]) C6[BYTE1(K[4])] XEND
+		X(L[2]) C7[BYTE0(K[3])];
+
+		L[3]  = C0[BYTE7(K[3])] XEND
+		X(L[3]) C1[BYTE6(K[2])] XEND
+		X(L[3]) C2[BYTE5(K[1])] XEND
+		X(L[3]) C3[BYTE4(K[0])] XEND
+		X(L[3]) C4[BYTE3(K[7])] XEND
+		X(L[3]) C5[BYTE2(K[6])] XEND
+		X(L[3]) C6[BYTE1(K[5])] XEND
+		X(L[3]) C7[BYTE0(K[4])];
+
+		L[4]  = C0[BYTE7(K[4])] XEND
+		X(L[4]) C1[BYTE6(K[3])] XEND
+		X(L[4]) C2[BYTE5(K[2])] XEND
+		X(L[4]) C3[BYTE4(K[1])] XEND
+		X(L[4]) C4[BYTE3(K[0])] XEND
+		X(L[4]) C5[BYTE2(K[7])] XEND
+		X(L[4]) C6[BYTE1(K[6])] XEND
+		X(L[4]) C7[BYTE0(K[5])];
+
+		L[5]  = C0[BYTE7(K[5])] XEND
+		X(L[5]) C1[BYTE6(K[4])] XEND
+		X(L[5]) C2[BYTE5(K[3])] XEND
+		X(L[5]) C3[BYTE4(K[2])] XEND
+		X(L[5]) C4[BYTE3(K[1])] XEND
+		X(L[5]) C5[BYTE2(K[0])] XEND
+		X(L[5]) C6[BYTE1(K[7])] XEND
+		X(L[5]) C7[BYTE0(K[6])];
+
+		L[6]  = C0[BYTE7(K[6])] XEND
+		X(L[6]) C1[BYTE6(K[5])] XEND
+		X(L[6]) C2[BYTE5(K[4])] XEND
+		X(L[6]) C3[BYTE4(K[3])] XEND
+		X(L[6]) C4[BYTE3(K[2])] XEND
+		X(L[6]) C5[BYTE2(K[1])] XEND
+		X(L[6]) C6[BYTE1(K[0])] XEND
+		X(L[6]) C7[BYTE0(K[7])];
+
+		L[7]  = C0[BYTE7(K[7])] XEND
+		X(L[7]) C1[BYTE6(K[6])] XEND
+		X(L[7]) C2[BYTE5(K[5])] XEND
+		X(L[7]) C3[BYTE4(K[4])] XEND
+		X(L[7]) C4[BYTE3(K[3])] XEND
+		X(L[7]) C5[BYTE2(K[2])] XEND
+		X(L[7]) C6[BYTE1(K[1])] XEND
+		X(L[7]) C7[BYTE0(K[0])];
 
 		K[0] = L[0];
 		K[1] = L[1];
@@ -877,85 +887,85 @@ static void wp512_process_buffer(struct 
 		K[6] = L[6];
 		K[7] = L[7];
 
-		L[0] = C0[(int)(state[0] >> 56)       ] ^
-			   C1[(int)(state[7] >> 48) & 0xff] ^
-			   C2[(int)(state[6] >> 40) & 0xff] ^
-			   C3[(int)(state[5] >> 32) & 0xff] ^
-			   C4[(int)(state[4] >> 24) & 0xff] ^
-			   C5[(int)(state[3] >> 16) & 0xff] ^
-			   C6[(int)(state[2] >>  8) & 0xff] ^
-			   C7[(int)(state[1]      ) & 0xff] ^
-			   K[0];
-
-		L[1] = C0[(int)(state[1] >> 56)       ] ^
-			   C1[(int)(state[0] >> 48) & 0xff] ^
-			   C2[(int)(state[7] >> 40) & 0xff] ^
-			   C3[(int)(state[6] >> 32) & 0xff] ^
-			   C4[(int)(state[5] >> 24) & 0xff] ^
-			   C5[(int)(state[4] >> 16) & 0xff] ^
-			   C6[(int)(state[3] >>  8) & 0xff] ^
-			   C7[(int)(state[2]      ) & 0xff] ^
-			   K[1];
-
-		L[2] = C0[(int)(state[2] >> 56)       ] ^
-			   C1[(int)(state[1] >> 48) & 0xff] ^
-			   C2[(int)(state[0] >> 40) & 0xff] ^
-			   C3[(int)(state[7] >> 32) & 0xff] ^
-			   C4[(int)(state[6] >> 24) & 0xff] ^
-			   C5[(int)(state[5] >> 16) & 0xff] ^
-			   C6[(int)(state[4] >>  8) & 0xff] ^
-			   C7[(int)(state[3]      ) & 0xff] ^
-			   K[2];
-
-		L[3] = C0[(int)(state[3] >> 56)       ] ^
-			   C1[(int)(state[2] >> 48) & 0xff] ^
-			   C2[(int)(state[1] >> 40) & 0xff] ^
-			   C3[(int)(state[0] >> 32) & 0xff] ^
-			   C4[(int)(state[7] >> 24) & 0xff] ^
-			   C5[(int)(state[6] >> 16) & 0xff] ^
-			   C6[(int)(state[5] >>  8) & 0xff] ^
-			   C7[(int)(state[4]      ) & 0xff] ^
-			   K[3];
-
-		L[4] = C0[(int)(state[4] >> 56)       ] ^
-			   C1[(int)(state[3] >> 48) & 0xff] ^
-			   C2[(int)(state[2] >> 40) & 0xff] ^
-			   C3[(int)(state[1] >> 32) & 0xff] ^
-			   C4[(int)(state[0] >> 24) & 0xff] ^
-			   C5[(int)(state[7] >> 16) & 0xff] ^
-			   C6[(int)(state[6] >>  8) & 0xff] ^
-			   C7[(int)(state[5]      ) & 0xff] ^
-			   K[4];
-
-		L[5] = C0[(int)(state[5] >> 56)       ] ^
-			   C1[(int)(state[4] >> 48) & 0xff] ^
-			   C2[(int)(state[3] >> 40) & 0xff] ^
-			   C3[(int)(state[2] >> 32) & 0xff] ^
-			   C4[(int)(state[1] >> 24) & 0xff] ^
-			   C5[(int)(state[0] >> 16) & 0xff] ^
-			   C6[(int)(state[7] >>  8) & 0xff] ^
-			   C7[(int)(state[6]      ) & 0xff] ^
-			   K[5];
-
-		L[6] = C0[(int)(state[6] >> 56)       ] ^
-			   C1[(int)(state[5] >> 48) & 0xff] ^
-			   C2[(int)(state[4] >> 40) & 0xff] ^
-			   C3[(int)(state[3] >> 32) & 0xff] ^
-			   C4[(int)(state[2] >> 24) & 0xff] ^
-			   C5[(int)(state[1] >> 16) & 0xff] ^
-			   C6[(int)(state[0] >>  8) & 0xff] ^
-			   C7[(int)(state[7]      ) & 0xff] ^
-			   K[6];
-
-		L[7] = C0[(int)(state[7] >> 56)       ] ^
-			   C1[(int)(state[6] >> 48) & 0xff] ^
-			   C2[(int)(state[5] >> 40) & 0xff] ^
-			   C3[(int)(state[4] >> 32) & 0xff] ^
-			   C4[(int)(state[3] >> 24) & 0xff] ^
-			   C5[(int)(state[2] >> 16) & 0xff] ^
-			   C6[(int)(state[1] >>  8) & 0xff] ^
-			   C7[(int)(state[0]      ) & 0xff] ^
-			   K[7];
+		L[0]  = C0[BYTE7(state[0])] XEND
+		X(L[0]) C1[BYTE6(state[7])] XEND
+		X(L[0]) C2[BYTE5(state[6])] XEND
+		X(L[0]) C3[BYTE4(state[5])] XEND
+		X(L[0]) C4[BYTE3(state[4])] XEND
+		X(L[0]) C5[BYTE2(state[3])] XEND
+		X(L[0]) C6[BYTE1(state[2])] XEND
+		X(L[0]) C7[BYTE0(state[1])] XEND
+		X(L[0]) K[0];
+
+		L[1]  = C0[BYTE7(state[1])] XEND
+		X(L[1]) C1[BYTE6(state[0])] XEND
+		X(L[1]) C2[BYTE5(state[7])] XEND
+		X(L[1]) C3[BYTE4(state[6])] XEND
+		X(L[1]) C4[BYTE3(state[5])] XEND
+		X(L[1]) C5[BYTE2(state[4])] XEND
+		X(L[1]) C6[BYTE1(state[3])] XEND
+		X(L[1]) C7[BYTE0(state[2])] XEND
+		X(L[1]) K[1];
+
+		L[2]  = C0[BYTE7(state[2])] XEND
+		X(L[2]) C1[BYTE6(state[1])] XEND
+		X(L[2]) C2[BYTE5(state[0])] XEND
+		X(L[2]) C3[BYTE4(state[7])] XEND
+		X(L[2]) C4[BYTE3(state[6])] XEND
+		X(L[2]) C5[BYTE2(state[5])] XEND
+		X(L[2]) C6[BYTE1(state[4])] XEND
+		X(L[2]) C7[BYTE0(state[3])] XEND
+		X(L[2]) K[2];
+
+		L[3]  = C0[BYTE7(state[3])] XEND
+		X(L[3]) C1[BYTE6(state[2])] XEND
+		X(L[3]) C2[BYTE5(state[1])] XEND
+		X(L[3]) C3[BYTE4(state[0])] XEND
+		X(L[3]) C4[BYTE3(state[7])] XEND
+		X(L[3]) C5[BYTE2(state[6])] XEND
+		X(L[3]) C6[BYTE1(state[5])] XEND
+		X(L[3]) C7[BYTE0(state[4])] XEND
+		X(L[3]) K[3];
+
+		L[4]  = C0[BYTE7(state[4])] XEND
+		X(L[4]) C1[BYTE6(state[3])] XEND
+		X(L[4]) C2[BYTE5(state[2])] XEND
+		X(L[4]) C3[BYTE4(state[1])] XEND
+		X(L[4]) C4[BYTE3(state[0])] XEND
+		X(L[4]) C5[BYTE2(state[7])] XEND
+		X(L[4]) C6[BYTE1(state[6])] XEND
+		X(L[4]) C7[BYTE0(state[5])] XEND
+		X(L[4]) K[4];
+
+		L[5]  = C0[BYTE7(state[5])] XEND
+		X(L[5]) C1[BYTE6(state[4])] XEND
+		X(L[5]) C2[BYTE5(state[3])] XEND
+		X(L[5]) C3[BYTE4(state[2])] XEND
+		X(L[5]) C4[BYTE3(state[1])] XEND
+		X(L[5]) C5[BYTE2(state[0])] XEND
+		X(L[5]) C6[BYTE1(state[7])] XEND
+		X(L[5]) C7[BYTE0(state[6])] XEND
+		X(L[5]) K[5];
+
+		L[6]  = C0[BYTE7(state[6])] XEND
+		X(L[6]) C1[BYTE6(state[5])] XEND
+		X(L[6]) C2[BYTE5(state[4])] XEND
+		X(L[6]) C3[BYTE4(state[3])] XEND
+		X(L[6]) C4[BYTE3(state[2])] XEND
+		X(L[6]) C5[BYTE2(state[1])] XEND
+		X(L[6]) C6[BYTE1(state[0])] XEND
+		X(L[6]) C7[BYTE0(state[7])] XEND
+		X(L[6]) K[6];
+
+		L[7]  = C0[BYTE7(state[7])] XEND
+		X(L[7]) C1[BYTE6(state[6])] XEND
+		X(L[7]) C2[BYTE5(state[5])] XEND
+		X(L[7]) C3[BYTE4(state[4])] XEND
+		X(L[7]) C4[BYTE3(state[3])] XEND
+		X(L[7]) C5[BYTE2(state[2])] XEND
+		X(L[7]) C6[BYTE1(state[1])] XEND
+		X(L[7]) C7[BYTE0(state[0])] XEND
+		X(L[7]) K[7];
 
 		state[0] = L[0];
 		state[1] = L[1];
@@ -979,7 +989,7 @@ static void wp512_process_buffer(struct 
 	wctx->hash[7] ^= state[7] ^ block[7];
 }
 
-static void wp512_init (void *ctx) {
+static void wp512_init(void *ctx) {
 	int i;
 	struct wp512_ctx *wctx = ctx;
 

--Boundary-00=_VDupCCnhxjSaN9n--

