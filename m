Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWFZGGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWFZGGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 02:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbWFZGGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 02:06:11 -0400
Received: from cantor2.suse.de ([195.135.220.15]:15320 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932459AbWFZGGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 02:06:09 -0400
From: Neil Brown <neilb@suse.de>
To: David Howells <dhowells@redhat.com>
Date: Mon, 26 Jun 2006 16:05:47 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17567.31035.471039.999828@cse.unsw.edu.au>
Cc: balbir@in.ibm.com, akpm@osdl.org, aviro@redhat.com, jblunck@suse.de,
       dev@openvz.org, olh@suse.de, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Destroy the dentries contributed by a superblock on unmounting 
In-Reply-To: message from David Howells on Sunday June 25
References: <17566.12727.489041.220653@cse.unsw.edu.au>
	<17564.52290.338084.934211@cse.unsw.edu.au>
	<15603.1150978967@warthog.cambridge.redhat.com>
	<553.1151156031@warthog.cambridge.redhat.com>
	<20946.1151251352@warthog.cambridge.redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday June 25, dhowells@redhat.com wrote:
> Neil Brown <neilb@suse.de> wrote:
> 
> >  - The test for IS_ROOT surprises me.  I thought anonymous dentries
> >    were all IS_ROOT.   Maybe this changes with your shared-superblock
> >    changes? 
> 
> I know they start out as root dentries, but are they required to stay so?

The 'anon' entries are linked together with d_hash, so if any anon
entry were given a parent, it would also be given a name and the
d_hash would be used for something else.  So I think "yes- they are
required to stay so".  It might not hurt to have a
WARN_ON(!IS_ROOT()) though.

> > The logic looks like it should be:
> 
> Two points:
> 
>  (1) The second while loop really wants to be a do-while loop.  We have to go
>      around it at least once, since the first loop brings it to that
>      condition.

It certainly can be a do-while.  As the preceding loop leaves the
condition true, a do-while or a while() will have the same result,
though the while() will do one extra (unneeded) test.  So the choice
should be based on what makes the code clearest, and that it often a
subjective question.

> 
>  (2) We need to drop a reference on a dentry node for which we've drained all
>      the children, but we need to do it after the test to see whether it has
>      any children.  This means you'd need to put the atomic_dec() in the
>      condition of the do-while statement.
> 
>      To have a while-loop instead, you'd have to get a reference on every node
>      you considered, even if you're just going to immediately drop that
>      reference again.

Yes, I had glossed over that bit of reference counting.  I don't see a
big problem with having an atomic_inc before the loop and an
atomic_dec at the top, but I can see that others might not like it.

> 
> >     Which I think makes it a lot more readable (obviously I have left
> >     out lots of the details in the above.
> 
> But not necessarily right.  Basically, the goto to consume_leaf when we've
> drained the parent is a sort of shortcut.
> 
> >   - The section that I have called 'stuff-1' above seems excessive.
> >     Everytime you visit a dentry with children, you remove them from
> >     the unused list (if present) and d_drop them from the hash.  After
> >     the first time, these should all be no-ops.
> 
> "After the first time"?  I don't see what you're getting at.  It is executed
> once per directory.

Uhmmm. Yes, I see.  You don't did that loop when stepping down to a
directory, not when stepping back up to it.  I was confused, sorry.

> 
> >     If there some particular reason for this that I'm not seeing (which case
> >     I'd like a comment) or can you just unuse/drop the dentry just before
> >     freeing it
> 
> Well, I'd like to avoid holding the dcache_lock as much as possible, and,
> theoretically, around that while loop is the only place in which dcache_lock
> needs to be held.  As long as the filesystem isn't trying to mangle the dentry
> tree whilst we're trying to unmount it, nothing else will be mucking around
> with them (now that shrink_dcache_memory() has been fixed).

That's a good reason.  I hadn't thought of that.  Thanks.

> 
> No... you should be able to handle gotos:-)
> 
> I've restructured it a little (see attached).
> 
> I've made the descend_to_leaf loop into an infinite for-loop.
...
> The consume-leaf loop is tricky to turn into a while-loop, a for-loop or a
> do-loop since as I said above: I need to call atomic_dec() on the second+
> times round the loop, but after the condition has been evaluated to true.

If I asked really nicely, could you make consume_empty_leaf an
infinite loop too?

> +	    for (;;) {
> +		/* consume this leaf */
> +		BUG_ON(atomic_read(&dentry->d_count) != 0);
> +
> +		spin_lock(&dentry->d_lock);
......
> +
> +		if (!list_empty(&dentry->d_subdirs))
> +			break;
> +		/* the parent is now empty and can be itself
> +		 * consumed */
> +		atomic_dec(&dentry->d_count);
> +	    }
> +
> +	    dentry = list_entry(dentry->d_subdirs.next,
> +				    struct dentry, d_u.d_child);

At least I then get the visual clues that indenting gives. (pretty please).

But I'm happy to give it my Ack even without that.  It makes much more
sense (to me) to do it that way than to move lots of dentries onto the
unused list, then prune those, then try again .....

Thanks,
NeilBrown
