Return-Path: <linux-kernel-owner+w=401wt.eu-S1751298AbXAPQie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbXAPQie (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 11:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbXAPQid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 11:38:33 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:63740 "HELO pxy2nd.nifty.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751298AbXAPQic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 11:38:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=mbf.nifty.com;
  b=BS8MyzhjwQQbz5An3SmPQ93bviIzCDrGYn+vmY4OmUsQnG6lyTd5vfR49UPW7ou5qn1nQHQI8ffHj0d7Cq142Q==  ;
Date: Wed, 17 Jan 2007 01:37:35 +0900 (JST)
Message-Id: <20070117.013735.246840767.takada@mbf.nifty.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Adding to support Classic MediaGXm
From: takada <takada@mbf.nifty.com>
X-Mailer: Mew version 5.1 on Emacs 22.0.92 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I hope to support "classic" MediaGXm in kernel.
The DIR1 register of MediaGXm( or Geode) shows the following values for identify CPU.
For exsample, My MediaGXm shows 0x42.
We can read National Semiconductor's datasheet without any NDAs.
  http://www.national.com/pf/GX/GXLV.html

from datasheets:
DIR1
0x30 - 0x33 GXm rev. 1.0 - 2.3
0x34 - 0x4f GXm rev. 2.4 - 3.x
0x5x        GXm rev. 5.0 - 5.4
0x6x        GXLV
0x7x         (unknow)
0x8x	    Gx1

In nsc driver of X, accept 0x30 through 0x82. What will 0x7x mean?

diff -Narup linux-2.6.19.orig/arch/i386/kernel/cpu/cyrix.c linux-2.6.19.add/arch/i386/kernel/cpu/cyrix.c
--- linux-2.6.19.orig/arch/i386/kernel/cpu/cyrix.c	2006-11-30 06:57:37.000000000 +0900
+++ linux-2.6.19.add/arch/i386/kernel/cpu/cyrix.c	2007-01-16 20:43:39.000000000 +0900
@@ -285,10 +285,15 @@ static void __cpuinit init_cyrix(struct 
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
 			/* Enable cxMMX extensions (GX1 Datasheet 54) */
-			setCx86(CX86_CCR7, getCx86(CX86_CCR7)|1);
+			setCx86(CX86_CCR7, getCx86(CX86_CCR7) | 1);
 			
-			/* GXlv/GXm/GX1 */
-			if((dir1 >= 0x50 && dir1 <= 0x54) || dir1 >= 0x63)
+			/* 
+			 * GXm : 0x30 ... 0x5f GXm  datasheet 51
+			 * GXlv: 0x6x          GXlv datasheet 54
+			 *  ?  : 0x7x
+			 * GX1 : 0x8x          GX1  datasheet 56
+			 */
+			if((0x30 <= dir1 && dir1 <= 0x6f) || (0x80 <=dir1 && dir1 <= 0x8f))
 				geode_configure();
 			get_model_name(c);  /* get CPU marketing name */
 			return;
