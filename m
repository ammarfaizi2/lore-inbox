Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUJATdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUJATdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUJATdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:33:53 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:12038 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266252AbUJATcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:32:06 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: jmorris@redhat.com, davem@davemloft.net
Subject: [PATCH] small sha512 cleanup
Date: Fri, 1 Oct 2004 22:31:51 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nCbXBiDqlN+sKon"
Message-Id: <200410012231.51816.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_nCbXBiDqlN+sKon
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looks like open-coded be_to_cpu.
GCC produces rather poor code for this.
be_to_cpu produces asm()s which are ~4 times shorter.

Compile-tested only.

I am not sure whether input can be 64bit-unaligned.
If it indeed can be, replace:

((u64*)(input))[I]  ->  get_unaligned( ((u64*)(input))+I )
--
vda

--Boundary-00=_nCbXBiDqlN+sKon
Content-Type: text/x-diff;
  charset="koi8-r";
  name="sha512.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sha512.c.diff"

Replaces tons of GCC-produced horror code
with nice small one.
While we're at it, fix whitespace.

--- linux-2.6.9-rc3/crypto/sha512.c.org	Thu Sep 30 07:09:44 2004
+++ linux-2.6.9-rc3/crypto/sha512.c	Thu Sep 30 07:10:36 2004
@@ -104,27 +104,12 @@
 
 static inline void LOAD_OP(int I, u64 *W, const u8 *input)
 {
-        u64 t1  = input[(8*I)  ] & 0xff;
-        t1 <<= 8;
-        t1 |= input[(8*I)+1] & 0xff;
-        t1 <<= 8;
-        t1 |= input[(8*I)+2] & 0xff;
-        t1 <<= 8;
-        t1 |= input[(8*I)+3] & 0xff;
-        t1 <<= 8;
-        t1 |= input[(8*I)+4] & 0xff;
-        t1 <<= 8;
-        t1 |= input[(8*I)+5] & 0xff;
-        t1 <<= 8;
-        t1 |= input[(8*I)+6] & 0xff;
-        t1 <<= 8;
-        t1 |= input[(8*I)+7] & 0xff;
-        W[I] = t1;
+	W[I] = __be64_to_cpu( ((u64*)(input))[I] );
 }
 
 static inline void BLEND_OP(int I, u64 *W)
 {
-        W[I] = s1(W[I-2]) + W[I-7] + s0(W[I-15]) + W[I-16];
+	W[I] = s1(W[I-2]) + W[I-7] + s0(W[I-15]) + W[I-16];
 }
 
 static void

--Boundary-00=_nCbXBiDqlN+sKon--

