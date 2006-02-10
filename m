Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWBJV37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWBJV37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWBJV37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 16:29:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932200AbWBJV36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 16:29:58 -0500
Date: Fri, 10 Feb 2006 13:28:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: oliver@neukum.org, nickpiggin@yahoo.com.au, linux@horizon.com,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-Id: <20060210132851.6cb5c6c7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602101315100.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
	<43ECDD9B.7090709@yahoo.com.au>
	<Pine.LNX.4.64.0602101056130.19172@g5.osdl.org>
	<200602102034.07531.oliver@neukum.org>
	<Pine.LNX.4.64.0602101152150.19172@g5.osdl.org>
	<20060210121130.57db39bc.akpm@osdl.org>
	<Pine.LNX.4.64.0602101315100.19172@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Fri, 10 Feb 2006, Andrew Morton wrote:
> > 
> > Yes, it would make sense to run balance_dirty_pages_ratelimited() inside
> > msync_pte_range().  So pdflush will get poked if we hit
> > background_dirty_ratio threshold, or we go into caller-initiated writeout
> > if we hit dirty_ratio.
> > 
> > But it's not completely trivial, because I don't think we want to be doing
> > blocking writeback with mmap_sem held.
> 
> Why not just do it once, at the end? 
> 

We could, sort-of.

balance_dirty_pages() is quite CPU-intensive (hence the presence of
balance_dirty_pages_ratelimited()).

balance_dirty_pages_ratelimited() expects to be called once per
page-dirtying.  

- We can't use balance_dirty_pages() because workloads which do lots of
  teeny msyncs would chew lots of CPU.

- We can't use balance_dirty_pages_ratelimited() because it thinks only a
  single page was dirtied.

So the thing to do is to change msync to keep track of how many pages were
dirtied, then at the end call

balance_dirty_pages_ratelimited_new_improved_api(mapping, nr_pages_dirtied).

Except an msync can cover multiple mappings, so we'd need to pop the lock
in the top-level loop, run the above for each VMA.  Not rocket-science, I
guess.
