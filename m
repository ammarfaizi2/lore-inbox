Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUDCUCs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 15:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUDCUCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 15:02:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:64713 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261915AbUDCUCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 15:02:46 -0500
Date: Sat, 3 Apr 2004 12:02:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: hch@infradead.org, hugh@veritas.com, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap
 complexity fix
Message-Id: <20040403120227.398268aa.akpm@osdl.org>
In-Reply-To: <20040403174043.GK2307@dualathlon.random>
References: <20040402001535.GG18585@dualathlon.random>
	<Pine.LNX.4.44.0404020145490.2423-100000@localhost.localdomain>
	<20040402011627.GK18585@dualathlon.random>
	<20040401173649.22f734cd.akpm@osdl.org>
	<20040402020022.GN18585@dualathlon.random>
	<20040402104334.A871@infradead.org>
	<20040402164634.GF21341@dualathlon.random>
	<20040403174043.GK2307@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> 
>  I'm very convinced that the alloc_pages API should be the same for all
>  archs w/o or w/ MMU, and I'm fine if we want to make the non-compound
>  retval the default (and change __GFP_NO_COMP to __GFP_COMP) in the long
>  run (to optimize all callers but hugetlbfs). For the short term
>  __GFP_NO_COMP and compound being the default is the safest (for all
>  archs).

This single patch which enables the compound page logic in
get_page()/put_page():


--- 25/include/linux/mm.h~a	2004-04-03 11:50:56.900246584 -0800
+++ 25-akpm/include/linux/mm.h	2004-04-03 11:50:59.189898504 -0800
@@ -236,7 +236,7 @@ struct page {
 
 extern void FASTCALL(__page_cache_release(struct page *));
 
-#ifdef CONFIG_HUGETLB_PAGE
+#ifndef CONFIG_HUGETLB_PAGE
 
 static inline int page_count(struct page *p)
 {


Increases a 3.5MB vmlinux by 15kB, a lot of it fastpath.  We should retain
this optimisation.

It might be better to switch over to address masking in get_user_pages()
and just dump all the compound page logic.  I don't immediately see how the
get_user_pages() caller can subsequently do put_page() against the correct
pageframe, but I assume you worked that out?

