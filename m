Return-Path: <linux-kernel-owner+w=401wt.eu-S1755075AbWL2Wnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbWL2Wnq (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755077AbWL2Wnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:43:46 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60221 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755074AbWL2Wnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:43:45 -0500
Date: Fri, 29 Dec 2006 14:42:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
In-Reply-To: <20061229141632.51c8c080.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612291431200.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
 <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
 <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org> <20061229141632.51c8c080.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Andrew Morton wrote:
> 
> - The above change means that we do extra writeout.  If a page is dirtied
>   once, kjournald will write it and then pdflush will come along and
>   needlessly write it again.

There's zero extra writeout for any flushing that flushes BY PAGES.

Only broken flushers that flush by buffer heads (which really really 
really shouldn't be done any more: welcome to the 21st century) will cause 
extra writeouts. And those extra writeouts are obviously required for all 
the dirty state to actually hit the disk - which is the point of the 
patch.

So they're not "extra" - they are "required for correct working".

But I can't stress the fact enough that people SHOULD NOT do writeback by 
buffer heads. The buffer head has been purely an "IO entity" for the last 
several years now, and it's not a cache entity. Anybody who does writeback 
by buffer heads is basically bypassing the real cache (the page cache), 
and that's why all the problems happen.

I think ext3 is terminally crap by now. It still uses buffer heads in 
places where it really really shouldn't, and as a result, things like 
directory accesses are simply slower than they should be. Sadly, I don't 
think ext4 is going to fix any of this, either.

It's all just too inherently wrongly designed around the buffer head 
(which was correct in 1995, but hasn't been correct for a long time in the 
kernel any more).

> - Poor old IO accounting broke again.

No. That's why I used "set_page_dirty()" and did it that strange ugly way 
("set page dirty, even though it's already dirty, and even though the very 
next thing we will do is TestClearPageDirty???").

That code looks strange as a result, which is why it now has more comments 
on it than actual code ;)

> - People were saying that ext2 and ext3,data=writeback were also showing
>   corruption.  What's up with that?

I thought the "ext3,data=writeback" case was reported to be fine by 
several people?

I'm not sure about ext2. I didn't look at what it did based on buffer 
heads. I would have expected it to be ok.

That said, at least one report was later shown to be bogus (errors due to 
out of disk, not due to actual errors ;).

> - For a long time I've wanted to nuke the current ext3/jbd ordered-data
>   implementation altogether, and just make kjournald call into the
>   standard writeback code to do a standard suberblock->inodes->pages walk.

I really would like to see less of the buffer-head-based stuff, and yes, 
more of the normal inode page walking. I don't think you can "order" 
accesses within a page anyway, exactly because of memory mapping issues, 
so any page ordering is not about buffer heads on the page itself, it 
should be purely about metadata.

> - It's pretty obnoxious that the VM now sets a clean page "dirty" and
>   then proceeds to modify its contents.  It would be nice to stop doing
>   that.

No. I think this really the fundamental confusion people had. People 
thought that setting the page dirty meant that it was no longer being 
modified. It hasn't meant that in a LONG time - ever since the whole 
DIRTY_TAG thing, the most important part of the PG_dirty thing has really 
been that it's now efficiently findable by the writeout logic.

And that is very much what the whole page accounting _depends_ on. When we 
mmap a page, we need to mark it "findable" as dirty _before_ people 
actually start writing to it, because it's too late afterwards.

>   We could stop marking the page dirty in do_wp_page() and create a new
>   VM counter "NR_PTE_DIRTY", which means
> 
>     "number of mapping_cap_account_dirty() pages which have a dirty pte
>     pointing at them".

Well, then you need to change what PAGE_MAPPING_TAG_DIRTY means too.

That's very fundamental. That DIRTY _tag_ is now even more important than 
the PG_dirty bit itself, since that's what we actually use to _access_ 
those things.

		Linus
