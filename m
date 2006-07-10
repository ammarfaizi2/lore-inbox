Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422667AbWGJPyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422667AbWGJPyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbWGJPyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:54:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:166 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422667AbWGJPyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:54:39 -0400
Date: Mon, 10 Jul 2006 08:54:31 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.18-rc1-mm1 oops on x86_64
In-Reply-To: <20060709132135.6c786cfb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607100851400.4491@schroedinger.engr.sgi.com>
References: <20060709021106.9310d4d1.akpm@osdl.org> <44B12C74.9090104@fr.ibm.com>
 <20060709132135.6c786cfb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006, Andrew Morton wrote:

> On Sun, 09 Jul 2006 18:19:00 +0200
> Cedric Le Goater <clg@fr.ibm.com> wrote:
> 
> > Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/
> > 
> > Kernel BUG at ...home/legoater/linux/2.6.18-rc1-mm1/mm/page_alloc.c:252
> 
> 	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
> 
> With your config, __GFP_HIGHMEM=0, so wham.

Hmm.. What this should be then is

VM_BUG_ON(gfp_flags & __GFP_WAIT)

in case of !CONFIG_HIGHMEM

So (not that nice though...)


Index: linux-2.6.17-mm6/mm/page_alloc.c
===================================================================
--- linux-2.6.17-mm6.orig/mm/page_alloc.c	2006-07-07 16:51:50.430063305 -0700
+++ linux-2.6.17-mm6/mm/page_alloc.c	2006-07-10 08:53:40.733541907 -0700
@@ -255,7 +255,11 @@ static inline void prep_zero_page(struct
 {
 	int i;
 
+#ifdef CONFIG_HIGHMEM
 	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
+#else
+	VM_BUG_ON((gfp_flags & __GFP_WAIT);
+#endif
 	/*
 	 * clear_highpage() will use KM_USER0, so it's a bug to use __GFP_ZERO
 	 * and __GFP_HIGHMEM from hard or soft interrupt context.
