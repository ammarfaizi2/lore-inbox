Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbTDQVot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 17:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTDQVot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 17:44:49 -0400
Received: from [12.47.58.203] ([12.47.58.203]:11235 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262624AbTDQVos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 17:44:48 -0400
Date: Thu, 17 Apr 2003 14:55:27 -0700
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stop swapoff 3/3 OOMkill
Message-Id: <20030417145527.00de9fb6.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0304172147330.2039-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304172142530.2039-100000@localhost.localdomain>
	<Pine.LNX.4.44.0304172147330.2039-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Apr 2003 21:56:36.0556 (UTC) FILETIME=[379298C0:01C3052C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> Current behaviour is that once swapoff has filled memory, other tasks
> get OOMkilled one by one until it completes, or more likely hangs.
> Better that swapoff be the first choice for OOMkill.

This calls for __GFP_NORETRY.  It will disable the oom-kill and the infinite
retry in the page allocator.  So we will have:

__GFP_REPEAT:

	retry the allocation, but the caller can handle a failure.
	eg: pte_alloc_one().

	__GFP_REPEAT _may_ end up returning NULL.  It depends on the VM
	implemention - eg it would in -aa kernels.  

__GFP_NOFAIL:

	retry the allocation inifinitely, regardless of the VM implementation. 
	For jbd_kmalloc() and others.

__GFP_NORETRY:

	Don't oom-kill and don't retry.   For swapoff.

I've implemented a __GFP_REPEAT, and don't like it, because it blurs the
__GFP_REPEAT and __GFP_NOFAIL requirements.  I'll add __GFP_NORETRY and we
can then pass that into read_swap_cache_async() and handle the error.

Sound good?


