Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWE3VeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWE3VeY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWE3VeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:34:24 -0400
Received: from sccrmhc13.comcast.net ([63.240.77.83]:20428 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932487AbWE3VeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:34:23 -0400
Date: Tue, 30 May 2006 14:36:49 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: explicitly disable BTB on ixp2350
Message-ID: <20060530213649.GA6169@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We don't enable the BTB on the ixp2350 as that can cause weird
crashes (erratum #42.)  However, some bootloaders enable the BTB,
which means that we have to disable the BTB explicitly.

Found thanks to Tom Rini.

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

Index: linux-2.6.17-rc3/arch/arm/mm/proc-xsc3.S
===================================================================
--- linux-2.6.17-rc3.orig/arch/arm/mm/proc-xsc3.S
+++ linux-2.6.17-rc3/arch/arm/mm/proc-xsc3.S
@@ -427,12 +427,13 @@ __xsc3_setup:
 #endif
 	mcr	p15, 0, r0, c1, c0, 1		@ set auxiliary control reg
 	mrc	p15, 0, r0, c1, c0, 0		@ get control register
-	bic	r0, r0, #0x0200			@ .... ..R. .... ....
 	bic	r0, r0, #0x0002			@ .... .... .... ..A.
 	orr	r0, r0, #0x0005			@ .... .... .... .C.M
 #if BTB_ENABLE
+	bic	r0, r0, #0x0200			@ .... ..R. .... ....
 	orr	r0, r0, #0x3900			@ ..VI Z..S .... ....
 #else
+	bic	r0, r0, #0x0a00			@ .... Z.R. .... ....
 	orr	r0, r0, #0x3100			@ ..VI ...S .... ....
 #endif
 #if L2_CACHE_ENABLE


-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
