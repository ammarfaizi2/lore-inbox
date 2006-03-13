Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWCMXG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWCMXG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 18:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWCMXG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 18:06:58 -0500
Received: from cantor2.suse.de ([195.135.220.15]:20447 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932086AbWCMXG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 18:06:57 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 14 Mar 2006 10:05:40 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17429.64196.857240.210610@cse.unsw.edu.au>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 004 of 4] Make address_space_operations->invalidatepage
 return void
In-Reply-To: message from Andrew Morton on Monday March 13
References: <20060313104910.15881.patches@notabene>
	<1060312235331.15985@suse.de>
	<1142267531.9971.5.camel@kleikamp.austin.ibm.com>
	<1142277225.9949.3.camel@kleikamp.austin.ibm.com>
	<20060313133625.26496547.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 13, akpm@osdl.org wrote:
> Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> >
> > On Mon, 2006-03-13 at 10:32 -0600, Dave Kleikamp wrote:
> >  > I'll try to stress test jfs with these patches to see if I can trigger
> >  > the an oops here.
> > 
> >  While stress testing on a jfs volume (dbench), I hit an assert in jbd:
> > 
> >  Assertion failure in journal_invalidatepage() at fs/jbd/transaction.c:1920: "!page_has_buffers(page)"
> 
> Yes, thanks, that assertion has become wrong.
> 
> --- devel/fs/jbd/transaction.c~make-address_space_operations-invalidatepage-return-void-jbd-fix	2006-03-13 13:33:12.000000000 -0800
> +++ devel-akpm/fs/jbd/transaction.c	2006-03-13 13:33:12.000000000 -0800
> @@ -1915,9 +1915,8 @@ void journal_invalidatepage(journal_t *j
>  	} while (bh != head);
>  
>  	if (!offset) {
> -		/* Maybe should BUG_ON !may_free - neilb */
> -		try_to_free_buffers(page);
> -		J_ASSERT(!page_has_buffers(page));
> +		if (may_free && try_to_free_buffers(page))
> +			J_ASSERT(!page_has_buffers(page));
>  	}
>  }
>  
> 
> However I'm more inclined to drop the whole patch, really - having
> ->invalidatepage() return a success indication makes sense.  The fact that
> we're currently not using that return value doesn't mean that we shouldn't,
> didn't and won't.

->invalidatepage is called either when truncating a file or when
purging the mapping of a file from the page cache.

The VM has waited for read or write back to complete and has ensured
that no new io will happen on the page.  The page, at least from
'offset' onwards, is idle.
Immediately after ->invalidatepage with offset==0 completes, the page
is removed from the pagecache.  It's a goner!

So I really don't think there is any sense for invalidation to be able
to fail.  The VM is saying "this page (or part of it) is going way.
Now."  The filesystem really has to let go.

I'm a little bit worried by this behaviour of journal_invalidatepage
in that it doesn't always free the buffers...
I guess it hasn't finished committing a write when a truncate that
discards that data comes along.  So it needs to hold on to the page to
write out those data blocks before forgetting about them.

But these machinations are completely "under-the-hood".  The VM really
doesn't need to know that ext3 is holding on to the page a bit longer.
A return value to tell the VM still doesn't make sense.

Note that ->releasepage does a similar thing but does have a return
value and here it is very meaningful.  Here the VM is say "I'd like
this page if you've finished with it".  It isn't that the file is
being truncated.  It is just a memory-reclamation action.  So a return
value makes sense.

Finally, having a return value leads developers to think they need to
return a value, which gives a wrong impression of what
->invalidatepage is for.

However, if you still don't like it.....

NeilBrown
