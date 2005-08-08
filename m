Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbVHHXKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbVHHXKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHHXKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:10:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23694 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932347AbVHHXKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:10:11 -0400
Date: Mon, 8 Aug 2005 16:08:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to reclaim inode pages on demand
Message-Id: <20050808160844.04d1f7ac.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508081650160.26013@skynet>
References: <Pine.LNX.4.58.0508081650160.26013@skynet>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mel@csn.ul.ie> wrote:
>
> Hi,
> 
> I am working on a direct reclaim strategy to free up large blocks of
> contiguous pages. The part I have is working fine, but I am finding a
> hundreds of pages that are being used for inodes that I need to reclaim. I
> tried purging the inode lists using a variation of prune_icache() but it
> is not working out.
> 
> Given a struct page, that one knows is an inode, can anyone suggest the
> best way to find the inode using it and free it?

Simple answer: invalidate_mapping_pages(page->mapping, start, end).

Problem: races.  If you pick a random page up off the LRU and start playing
with its mapping, what stops that mapping from getting freed under your
feet?

If the caller has a ref on the inode (say, you came in via a syscall
against an fd) then fine.

But if you picked the page up off the LRU then to avoid super-rare oopses
you'll need to pin the address_space somehow.  One way is to

a) lock the page, which pins the address_space.

b) check that page->mapping is still non-NULL.  Bale if it is.

c) bump page->mapping->host->i_count

d) unlock the page

e) diddle away with the address_space.

f) iput() the inode.

But beware that iput() can do a *ton* of stuff, so you need to be not
holding any locks and to not be called from any fancy contexts.

