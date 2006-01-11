Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932659AbWAKIvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932659AbWAKIvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWAKIvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:51:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2530 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932659AbWAKIvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:51:54 -0500
Date: Wed, 11 Jan 2006 00:51:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
Message-Id: <20060111005134.3306b69a.akpm@osdl.org>
In-Reply-To: <20060111082359.GV15897@opteron.random>
References: <20051213193735.GE3092@opteron.random>
	<20051213130227.2efac51e.akpm@osdl.org>
	<20051213211441.GH3092@opteron.random>
	<20051216135147.GV5270@opteron.random>
	<20060110062425.GA15897@opteron.random>
	<43C484BF.2030602@yahoo.com.au>
	<20060111082359.GV15897@opteron.random>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
>  On Wed, Jan 11, 2006 at 03:08:31PM +1100, Nick Piggin wrote:
>  > I'd be inclined to think a lock_page is not a big SMP scalability
>  > problem because the struct page's cacheline(s) will be written to
>  > several times in the process of refcounting anyway. Such a workload
>  > would also be running into tree_lock as well.
> 
>  I seem to recall you wanted to make the tree_lock a readonly lock for
>  readers for the exact same scalability reason? do_no_page is quite a
>  fast path for the tree lock too. But I totally agree the unavoidable is
>  the atomic_inc though, good point, so it worth more to remove the
>  tree_lock than to remove the page lock, the tree_lock can be avoided the
>  atomic_inc on page->_count not.
> 
>  The other bonus that makes this attractive is that then we can drop the
>  *whole* vm_truncate_count mess... vm_truncate_count and
>  inode->trunate_count exists for the only single reason that do_no_page
>  must not map into the pte a page that is under truncation.

I think you'll find this hard - filemap_nopage() is the first to find the
page but we need lock coverage up in do_no_page().  So the ->nopage
protocol will need to be changed to "must return with the page locked".  Or
we add a new ->nopage_locked and call that if the vm_ops implements it.

But I agree it's a good change if we can pull it off.
