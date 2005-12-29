Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVL2OJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVL2OJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVL2OJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:09:54 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:23439 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750723AbVL2OJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:09:53 -0500
Date: Thu, 29 Dec 2005 16:09:44 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: kus Kusche Klaus <kus@keba.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       clameter@sgi.com, mpm@selenic.com
Subject: RE: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323303@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.58.0512291605060.24628@sbz-30.cs.Helsinki.FI>
References: <AAD6DA242BC63C488511C611BD51F367323303@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2005, kus Kusche Klaus wrote:
> CONFIG_BUG was on. I turned on some more debugging CONFIGs
> (SLAB, PREEMPT, IRQ_FLAGS, VM, BUGVERBOSE, ERRORS), retried, and got
> this
> (note the very early BUG and two "MM: invalid domain"):

I think you'll get those with slob as well. The slab allocator hasn't had 
the chance to initialize itself yet so they're probably not related.

On Thu, 29 Dec 2005, kus Kusche Klaus wrote:
> Unhandled fault: alignment exception (0xc0207003) at 0x00000163
> Internal error: : c0207003 [#1]
> Modules linked in:
> CPU: 0
> PC is at get_page_from_freelist+0x1c/0x400
> LR is at __alloc_pages+0x68/0x2c0
> pc : [<c0257cac>]    lr : [<c02580f8>]    Not tainted
> sp : c0399e78  ip : c0399ec0  fp : c0399ebc
> r10: c039d724  r9 : c03a29d8  r8 : 00000000
> r7 : c039c068  r6 : 000000d0  r5 : c03a2994  r4 : c039d724
> r3 : 00000044  r2 : 0000000b  r1 : 00000000  r0 : 000200d0

I am still betting on alloc_pages_node(). You could try the following to 
prove me wrong. It's not a real fix though.

			Pekka

Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -1205,7 +1205,7 @@ static void *kmem_getpages(kmem_cache_t 
 	int i;
 
 	flags |= cachep->gfpflags;
-	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+	page = alloc_pages(flags, cachep->gfporder);
 	if (!page)
 		return NULL;
 	addr = page_address(page);
