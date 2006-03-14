Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752098AbWCNM7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbWCNM7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbWCNM7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:59:37 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:26330 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1752098AbWCNM7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:59:36 -0500
Date: Tue, 14 Mar 2006 20:59:15 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: A lockless pagecache for Linux
Message-ID: <20060314125915.GB4265@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Christoph Lameter <clameter@sgi.com>, Nick Piggin <npiggin@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux Memory Management <linux-mm@kvack.org>
References: <20060207021822.10002.30448.sendpatchset@linux.site> <Pine.LNX.4.64.0603131528180.13687@schroedinger.engr.sgi.com> <4416432E.1050904@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4416432E.1050904@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 03:14:38PM +1100, Nick Piggin wrote:
> Christoph Lameter wrote:
> >What you are proposing is to allow lockless read operations right? No 
> >lockless write? The concurrency issue that we currently have is multiple 
> >processes faulting in pages in different ranges from the same file. I 
> >think this is a rather typical usage scenario. Faulting in a page from a 
> >file for reading requires a write operation on the radix tree. The 
> >approach with a lockless read path does not help us. This proposed scheme 
> >would only help if pages are already faulted in and another process starts
> >using the same pages as an earlier process.
> >
> 
> Yep, lockless reads only to start with. I think you'll see some benefit
> because the read(2) and ->nopage paths also take read-side locks, so your
> write side will no longer have to contend with them.
> 
> It won't be a huge improvement in scalability though, maybe just a constant
> factor.
> 
> >Would it not be better to handle the radix tree in the same way as a page 
> >table? Have a lock at the lowest layer so that different sections of the 
> >radix tree can be locked by different processes? That would enable 
> >concurrent writes.
> >
> 
> Yeah this is the next step. Note that it is not the first step because I
> actually want to _speed up_ single threaded lookup paths, rather than
> slowing them down, otherwise it will never get accepted.
> 
> It also might add quite a large amount of complexity to the radix tree, so
> it may no longer be suitable for a generic data structure anymore (depends
> how it is implemented). But the write side should be easier than the
> read-side so I don't think there is too much to worry about. I already have
> some bits and pieces to make it fine-grained.

Maybe we can try another way to reduce the concurrent radix tree
writers problem: coordinating and serializing writers at high level.

Since kswapd is the major radix tree deleter, and readahead is the
major radix tree inserter, putting parts of them together in a loop
might reduce the contention noticeably.

The following pseudo-code shows the basic idea:
(Integrating kprefetchd is also possible. Just for simplicity...:)

PER_NODE(ra_queue);

kswapd()
{
        loop {
                loop {
                        free enough pages for top(ra_queue)
                }
                submit(pop(ra_queue));
                wait();
        }
}

readahead()
{
        assemble one ra_req

        if (ra_req immediately needed)
                submit(ra_req);
        else {
                push(ra_queue, ra_req);
                wakeup_kswapd();
        }
}

This scheme might reduce
        - direct page reclaim pressure
        - radix tree write lock contention
        - lru lock contention

Regards,
Wu
