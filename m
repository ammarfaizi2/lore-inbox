Return-Path: <linux-kernel-owner+w=401wt.eu-S1755095AbWL2Xv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755095AbWL2Xv4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 18:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755094AbWL2Xvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 18:51:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34679 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755093AbWL2Xvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 18:51:54 -0500
Date: Fri, 29 Dec 2006 15:51:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
Message-Id: <20061229155118.3feb0c17.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612291431200.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
	<20061228114517.3315aee7.akpm@osdl.org>
	<Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
	<20061228.143815.41633302.davem@davemloft.net>
	<3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
	<Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
	<Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
	<20061229141632.51c8c080.akpm@osdl.org>
	<Pine.LNX.4.64.0612291431200.4473@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2006 14:42:51 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Fri, 29 Dec 2006, Andrew Morton wrote:
> > 
> > - The above change means that we do extra writeout.  If a page is dirtied
> >   once, kjournald will write it and then pdflush will come along and
> >   needlessly write it again.
> 
> There's zero extra writeout for any flushing that flushes BY PAGES.
> 
> Only broken flushers that flush by buffer heads (which really really 
> really shouldn't be done any more: welcome to the 21st century) will cause 
> extra writeouts. And those extra writeouts are obviously required for all 
> the dirty state to actually hit the disk - which is the point of the 
> patch.
> 
> So they're not "extra" - they are "required for correct working".

They're extra.  As in "can be optimised away".

> But I can't stress the fact enough that people SHOULD NOT do writeback by 
> buffer heads. The buffer head has been purely an "IO entity" for the last 
> several years now, and it's not a cache entity.

The buffer_head is not an IO container.  It is the kernel's core
representation of a disk block.  Usually (but not always) it is backed by
some memory which is in pagecache.  We can feed buffer_heads into IO
containers via submit_bh(), but that's far from the only thing we use
buffer_heads for.  We should have done s/buffer_head/block/g years ago.

JBD implements physical block-based journalling, so it is 100% appropriate
that JBD deal with these disk blocks using their buffer_head
representation.

That being said, ordered-data mode isn't really part of the JBD journalling
system at all (the data doesn't get journalled!) - ordered-mode is an
add-on to the JBD journal to make the metadata which we're about to journal
point at more-likely-to-be-correct data.

JBD's ordered-mode writeback is just a sync and I see no conceptual
problems with killing its old buffer_head based sync and moving it into the
21st century.

> Anybody who does writeback 
> by buffer heads is basically bypassing the real cache (the page cache), 
> and that's why all the problems happen.
> 
> I think ext3 is terminally crap by now. It still uses buffer heads in 
> places where it really really shouldn't,

The ordered-data mode flush: sure.  The rest of JBD's use of buffer_heads
is quite appropriate.

> and as a result, things like 
> directory accesses are simply slower than they should be. Sadly, I don't 
> think ext4 is going to fix any of this, either.

I thought I fixed the performance problem?

Somewhat nastily, but as ext3 directories are metadata it is appropriate
that modifications to them be done in terms of buffer_heads (ie: blocks).

> It's all just too inherently wrongly designed around the buffer head 
> (which was correct in 1995, but hasn't been correct for a long time in the 
> kernel any more).
> 
> > - Poor old IO accounting broke again.
> 
> No. That's why I used "set_page_dirty()" and did it that strange ugly way 
> ("set page dirty, even though it's already dirty, and even though the very 
> next thing we will do is TestClearPageDirty???").

nfs_set_page_dirty() and reiserfs_set_page_dirty() should now bail if
PageDirty() to avoid needless work.

> > - For a long time I've wanted to nuke the current ext3/jbd ordered-data
> >   implementation altogether, and just make kjournald call into the
> >   standard writeback code to do a standard suberblock->inodes->pages walk.
> 
> I really would like to see less of the buffer-head-based stuff, and yes, 
> more of the normal inode page walking. I don't think you can "order" 
> accesses within a page anyway, exactly because of memory mapping issues, 
> so any page ordering is not about buffer heads on the page itself, it 
> should be purely about metadata.

In this context ext3's "ordered" mode means "sync the file contents before
journalling the metadata which points at it".

> > - It's pretty obnoxious that the VM now sets a clean page "dirty" and
> >   then proceeds to modify its contents.  It would be nice to stop doing
> >   that.
> 
> No. I think this really the fundamental confusion people had. People 
> thought that setting the page dirty meant that it was no longer being 
> modified.

No.  Setting a page (or bh, or inode) dirty means "this is known to have
been modified".  ie: this cached entity is now out of sync with backing
store.

Ho hum.  I don't care much, really.  But then, I understand how all this
stuff works.  Try explaining to someone the relationship between
pte-dirtiness, page-dirtiness, radix-tree-dirtiness and
buffer_head-dirtiness.

