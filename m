Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266173AbUJATfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266173AbUJATfD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266296AbUJATeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:34:06 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:10246 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266249AbUJATby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:31:54 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: jmorris@redhat.com, davem@davemloft.net
Subject: [PATCH] small sha256 cleanup
Date: Fri, 1 Oct 2004 22:31:45 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hCbXBQiKY75VsFV"
Message-Id: <200410012231.45867.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_hCbXBQiKY75VsFV
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Looks like open-coded be_to_cpu.
GCC produces rather poor code for this.
be_to_cpu produces asm()s which are ~4 times shorter.

Compile-tested only.

I am not sure whether input can be 32bit-unaligned.
If it indeed can be, replace:

((u32*)(input))[I]  ->  get_unaligned( ((u32*)(input))+I )
--
vda

--Boundary-00=_hCbXBQiKY75VsFV
Content-Type: text/x-diff;
  charset="koi8-r";
  name="sha256.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sha256.c.diff"

--- linux-2.6.9-rc3/crypto/sha256.c.org	Thu Sep 30 07:32:12 2004
+++ linux-2.6.9-rc3/crypto/sha256.c	Thu Sep 30 07:33:06 2004
@@ -63,15 +63,7 @@
 
 static inline void LOAD_OP(int I, u32 *W, const u8 *input)
 {
-	u32 t1 = input[(4 * I)] & 0xff;
-
-	t1 <<= 8;
-	t1 |= input[(4 * I) + 1] & 0xff;
-	t1 <<= 8;
-	t1 |= input[(4 * I) + 2] & 0xff;
-	t1 <<= 8;
-	t1 |= input[(4 * I) + 3] & 0xff;
-	W[I] = t1;
+	W[I] = __be32_to_cpu( ((u32*)(input))[I] );
 }
 
 static inline void BLEND_OP(int I, u32 *W)

--Boundary-00=_hCbXBQiKY75VsFV--

