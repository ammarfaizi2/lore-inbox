Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWEaEe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWEaEe4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 00:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWEaEe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 00:34:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:61118 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751673AbWEaEe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 00:34:56 -0400
From: Neil Brown <neilb@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Wed, 31 May 2006 14:34:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17533.7390.445811.302516@cse.unsw.edu.au>
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
	<17531.57913.151520.946557@cse.unsw.edu.au>
	<447BEFCF.5000406@yahoo.com.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 30, nickpiggin@yahoo.com.au wrote:
> Neil Brown wrote:
> > On Tuesday May 30, nickpiggin@yahoo.com.au wrote:
> > 
> > As for your original problem.... I wonder if PG_locked is protecting
> > too much?  It protects against IO and it also protects against ->mapping
> > changes.  So if you want to ensure that ->mapping won't change, you
> > need to wait for any pending read request to finish, which seems a bit
> > dumb.
> 
> I don't think that is the problem. set_page_dirty_lock is really
> unlikely to get held up on read IO: that'd mean there were two things
> writing into that page at the same time.

That's exactly my point - though I expand a bit more further down.
i.e. set_page_dirty_lock is unlikely to get held up on a read IO, however
it has to call into lock_page, and lock_page has no idea that it cannot be
waiting for IO, and so it has to call sync_page just in case.

> 
>  >
> > Maybe we need a new bit: PG_maplocked.  You are only allowed to change
> > ->mapping or ->index of you hold PG_locked and PG_maplocked, you are
> > not allowed to wait for PG_locked while holding PG_maplocked, and
> > you can read ->mapping or ->index while PG_locked or PG_maplocked are
> > held.
> > Think of PG_locked like a mutex and PG_maplocked like a spinlock (and
> > probably use bit_spinlock to get it).
> 
> Well the original problem is fixed by not doing the sync_page thing in
> set_page_dirty_lock. Is there any advantage to having another bit?
> Considering a) it will be very unlikely that a page is locked at the
> same time one would like to dirty it; and b) that would seem to imply
> adding extra atomic ops and barriers to reclaim and truncate (maybe
> others).

While I agree that avoiding the sync_page in this particular case is
likely to solve the problem, it seems rather fragile.  Sometimes you
need to call ->sync_page when waiting for a lock, sometimes you
don't.  Why the difference?  Because there really are two different
locks here masquerading as one.

Yes there would be extra atomic ops at reclaim and truncate.  Is that
a problem? I have no idea, but you sometimes need to break eggs to fix
an omelette.  I suspect the extra bit would be very lightly
contended.


> 
> > 
> > Then set_page_dirty_lock would use PG_maplocked to get access to
> > ->mapping, and then hold a reference on the address_space while
> > calling into balance_dirty_pages ... I wonder how you hold a reference
> > on an address space...
> 
> inode. Presumably PG_maplocked would pin it? I don't understand
> why you've brought balance_dirty_pages into it, though.
> 

hmmmm.... no idea, sorry.
I was trying to trace through set_page_dirty to see if it was safe to
call it under a spinlock (or a bit_spinlock in this case).  I must
have taken a wrong turn somewhere...

> > 
> > There are presumably few pieces of code that change ->mapping.  Once
> > they all take PG_maplocked as well as PG_locked, you can start freeing
> > up other code to take PG_maplocked instead of PG_locked....
> > 
> > Does that make sense at all?  Do we have any spare page bits?
> 
> I'm sure it could be made to work, but I don't really see the point.
> If someone really wanted to do it, I guess the right way to go is have
> a PG_readin counterpart to PG_writeback (or even extend PG_writeback
> to PG_io)...

Yes, PG_readin or PG_io would be better names, but might be hard to
have a graceful transition to that sort of naming.

And the point is that once you separated that function from PG_locked,
lock_page would not need to wait for IO, and so would not need to call
sync_page, and so your problem would evaporate.

NeilBrown
