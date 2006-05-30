Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWE3GMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWE3GMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 02:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWE3GMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 02:12:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:34028 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932153AbWE3GM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 02:12:29 -0400
From: Neil Brown <neilb@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Tue, 30 May 2006 16:12:09 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17531.57913.151520.946557@cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: message from Nick Piggin on Tuesday May 30
References: <447AC011.8050708@yahoo.com.au>
	<20060529121556.349863b8.akpm@osdl.org>
	<447B8CE6.5000208@yahoo.com.au>
	<20060529183201.0e8173bc.akpm@osdl.org>
	<447BB3FD.1070707@yahoo.com.au>
	<Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
	<447BD31E.7000503@yahoo.com.au>
	<447BD63D.2080900@yahoo.com.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 30, nickpiggin@yahoo.com.au wrote:
> Nick Piggin wrote:
> > Linus Torvalds wrote:
> > 
> >>
> >> Why do you think the IO layer should get larger requests?
> > 
> > 
> > For workloads where plugging helps (ie. lots of smaller, contiguous
> > requests going into the IO layer), should be pretty good these days
> > due to multiple readahead and writeback.
> 
> Let me try again.
> 
> For workloads where plugging helps (ie. lots of smaller, contiguous
> requests going into the IO layer), the request pattern should be
> pretty good without plugging these days, due to multiple page
> readahead and writeback.

Can I please put in a vote for not thinking that every device is disk
drive?

I find plugging fairly important for raid5, particularly for write.

The more whole-stripe writes I can get, the better throughput I get.
So I tend to keep a raid5 array plugged while any requests are
arriving, and interpret 'plugged' to mean that incomplete stripes
don't get processed while full stripes (needing no pre-reading) do get
processed.

The only way "large requests" are going to replace plugging is they
are perfectly aligned, which I don't expect to ever see.

As for your original problem.... I wonder if PG_locked is protecting
too much?  It protects against IO and it also protects against ->mapping
changes.  So if you want to ensure that ->mapping won't change, you
need to wait for any pending read request to finish, which seems a bit
dumb.
Maybe we need a new bit: PG_maplocked.  You are only allowed to change
->mapping or ->index of you hold PG_locked and PG_maplocked, you are
not allowed to wait for PG_locked while holding PG_maplocked, and
you can read ->mapping or ->index while PG_locked or PG_maplocked are
held.
Think of PG_locked like a mutex and PG_maplocked like a spinlock (and
probably use bit_spinlock to get it).

Then set_page_dirty_lock would use PG_maplocked to get access to
->mapping, and then hold a reference on the address_space while
calling into balance_dirty_pages ... I wonder how you hold a reference
on an address space...

There are presumably few pieces of code that change ->mapping.  Once
they all take PG_maplocked as well as PG_locked, you can start freeing
up other code to take PG_maplocked instead of PG_locked....

Does that make sense at all?  Do we have any spare page bits?

NeilBrown
