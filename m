Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWEMEkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWEMEkm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 00:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWEMEkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 00:40:40 -0400
Received: from mail.suse.de ([195.135.220.2]:56543 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932330AbWEMEki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 00:40:38 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Sat, 13 May 2006 13:14:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17509.20239.993465.843942@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       paul.clements@steeleye.com
Subject: Re: [PATCH 002 of 8] md/bitmap: Remove bitmap writeback daemon.
In-Reply-To: message from Andrew Morton on Friday May 12
References: <20060512160121.7872.patches@notabene>
	<1060512060736.8006@suse.de>
	<20060512104035.5fee4e66.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday May 12, akpm@osdl.org wrote:
> NeilBrown <neilb@suse.de> wrote:
> >
> >  ./drivers/md/bitmap.c         |  115 ++----------------------------------------
> 
> hmm.  I hope we're not doing any of that filesystem I/O within the context
> of submit_bio() or kblockd or anything like that.  Looks OK from a quick
> scan.

No.  We do all the I/O from the context of the per-array thread.
However some IO requests cannot complete until the filesystem I/O
completes, so we need to be sure that the filesystem I/O won't block
waiting for memory, or fail with -ENOMEM.

> 
> a_ops->commit_write() already ran set_page_dirty(), so you don't need that
> in there.

Is that documented somewhere..... but yes, that seems to be right. Thanks.

> 
> I assume this always works in units of a complete page?  It's strange to do
> prepare_write() followed immediately by commit_write().  Normally
> prepare_write() will do some prereading, but it's smart enough to not do
> that if the caller is preparing to write the whole page.
> 

Yes, it is strange.  That was one of the things that made me want to
review this code and figure out how to do it "properly".

As far as I can see, much of 'address_space' is really an internal
interface to support routines used by the filesystem.  A filesystem
may choose to use address spaces, and has a fair degree of freedom
when it comes to which bits to make use of and exactly what they
mean.
About the only thing that *has* to be supported is ->writepages --
which has a fair degree of latitude in exactly what it does -- and
->writepage -- which can only be called after locking a page and
rechecking the ->mapping.

bitmap.c is currently trying to do something every different.
It uses ->readpage to get pages in the page cache (even though some
address spaces don't define ->readpage) and then holds onto those
pages without holding the page lock, and then calls ->writepage to
flush them out from time to time.
Before calling writepage it gets the pagelock, but doesn't re-check
that ->mapping is correct (there is nothing much it can do if it isn't
correct..).

I noticed this is particularly a problem with tmpfs.  When you call
writepage on a tmpfs page, the page is swizzled into the swap cache,
and ->mapping becomes NULL - not the behaviour that bitmap is
expecting.

Now I agree that tmpfs is an unusual case, and that storing a bitmap
in tmpfs doesn't make a lot of sense (though it can make some...) but
the point is that if a filesystem is allowed to move pages around like
that, then bitmap cannot hold on to pages in the page cache like it
wants to.  It simply isn't a well defined thing to do.


> We normally use PAGE_CACHE_SIZE for these things, not PAGE_SIZE.  Same diff.
> 

Yeah.... why is that?  Why have two names for exactly the same value?
How does a poor develop know when to use one and when the other?  More
particularly, how does one remember.
I would argue that the "same diff" should be no difference - not even
in spelling....

> If you have a page and you want to write the whole thing out then there's
> really no need to run prepare_write or commit_write at all.  Just
> initialise the whole page, run set_page_dirty() then write_one_page().
> 

I see that now.  But only after locking the page, and rechecking that
->mapping is correct, and if it isn't .... well, more work is involved
that bitmap is in a position to do.

> Perhaps it should check that the backing filesystem actually implements
> commit_write(), prepare_write(), readpage(), etc.  Some might not, and the
> user will get taught not to do that via an oops.
> 

Might help, but as I think you've gathered, I really want a whole
different approach to writing to the file.  One that I can justify as
being a "correct" use of interfaces, and also that I can be certain
will not block or fail on a kmalloc or similar.  Hence the bmap thing
later.


Thanks for your feedback.

NeilBrown
