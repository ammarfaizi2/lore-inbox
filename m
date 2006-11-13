Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755323AbWKMTFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323AbWKMTFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755333AbWKMTFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:05:41 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:52001 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1755323AbWKMTFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:05:41 -0500
Message-ID: <4558C3EB.1070400@openvz.org>
Date: Mon, 13 Nov 2006 22:13:47 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: [PATCH]: OOM can panic due to processes stuck in __alloc_pages()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OOM can panic due to the processes stuck in __alloc_pages()
doing infinite rebalance loop while no memory can be reclaimed.
OOM killer tries to kill some processes, but unfortunetaly,
rebalance label was moved by someone below the TIF_MEMDIE check,
so buddy allocator doesn't see that process is OOM-killed
and it can simply fail the allocation :/

Observed in reality on RHEL4(2.6.9)+OpenVZ kernel when a user doing
some memory allocation tricks triggered OOM panic.

Signed-Off-By: Denis Lunev <den@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@openvz.org>

--- ./mm/page_alloc.c.oomx	2006-11-08 17:44:16.000000000 +0300
+++ ./mm/page_alloc.c	2006-11-13 21:57:33.000000000 +0300
@@ -1251,6 +1251,7 @@ restart:
 
 	/* This allocation should allow future memory freeing. */
 
+rebalance:
 	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
 			&& !in_interrupt()) {
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
@@ -1272,7 +1273,6 @@ nofail_alloc:
 	if (!wait)
 		goto nopage;
 
-rebalance:
 	cond_resched();
 
 	/* We now go into synchronous reclaim */
