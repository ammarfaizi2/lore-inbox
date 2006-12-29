Return-Path: <linux-kernel-owner+w=401wt.eu-S965047AbWL2I70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWL2I70 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 03:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWL2I70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 03:59:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41332 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965049AbWL2I7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 03:59:25 -0500
Date: Fri, 29 Dec 2006 00:58:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       linux-kernel@vger.kernel.org, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, akpm@osdl.org, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
In-Reply-To: <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
 <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
 <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2006, Linus Torvalds wrote:
> 
> So everything I have ever seen says that the VM layer is actually doing 
> everything right.

That was true, but at the same time, it's not. Let me explain.

> That to me says: "somebody didn't actually write out out". The VM layer 
> asked the filesystem to do the write, but the filesystem just didn't do 
> it. I personally think it's because some buffer-head BH_dirty bit got 
> scrogged

Ok, I have proof of this now.

Here's a trace (with cycle counts), and with a new trace event added: this 
is for another corrupted page. I have:

 49105  PG 000015d8 (14800): mm/page-writeback.c:872 clean_for_io
 49106  PG 000015d8 (6900): mm/rmap.c:451 cleaning PTE b7fa6000
 49107  PG 000015d8 (9900): mm/page-writeback.c:914 set writeback
 49108  PG 000015d8 (6480): mm/page-writeback.c:916 setting TAG_WRITEBACK
 49109  PG 000015d8 (7110): mm/page-writeback.c:922 clearing TAG_DIRTY
 49110  PG 000015d8 (7190): fs/buffer.c:1713 no IO underway
 49111  PG 000015d8 (6180): mm/page-writeback.c:891 end writeback
 49112  PG 000015d8 (6460): mm/page-writeback.c:893 clearing TAG_WRITEBACK

where that first column is the trace event number again, and the "PG 
000015d8" is that corrupted page. The thing in the parenthesis is "CPU 
cycles since last event), and the important part to note is that this is 
indeed all one single thing with no actual IO anywhere (~7000 CPU cycles 
may sound like a lot, but (a) it's not that many cache misses and (b) a 
lot of it is the logging overhead - back-to-back log events will take 
about 3500 cycles) just because it does the actual ASCII printk() etc.

Also, the new event is:

	fs/buffer.c:1713 no IO underway

which is just the 

	if (nr_underway == 0)

case in fs/buffer.c

And I now finally really believe that I fully understand the corruption, 
but I don't have a simple solution, much less a patch.

What the problem basically boils down to is that "set_page_dirty()" is 
supposed to be a mark for dirtying THE WHOLE PAGE, but it really is not 
"the whole page when the 'set_page_dirty()' itself happens", but more of a 
"the next writepage() needs to write back the whole page" thing.

And that's not what "__set_page_dirty_buffers()" really does.

Because what "__set_page_dirty_buffers()" does is that AT THE TIME THE 
"set_page_dirty()" IS CALLED, it will mark all the buffers on that page as 
dirty. That may _sound_ like what we want, but it really isn't. Because by 
the time "writepage()" is actually called (which can be MUCH MUCH later), 
some internal filesystem activity may actually have cleaned one or more of 
those buffers in the meantime, and now we call "writepage()" (which really 
wants to write them _all_), and it will write only part of them, or none 
at all.

So the VM thought that since it did a "writepage()", all the dirty state 
at that point got written back. But it didn't - the filesystem could have 
written back part or all of the page much earlier, and the writepage() 
actually does nothing at all.

Both filesystem and VM actually _think_ they do the right thing, because 
they simply have totally different expectations. The filesystem thinks 
that it should care about dirty buffers (that got marked dirty _after_ 
they were dirtied), while the filesystem thinks that it cares about dirty 
_pages_ (that got dirted at any time _before_ "writepage()" was called).

Neither is really "wrong", per se, it's just that the two parts have 
different expectations, and the _combination_ just doesn't work. 
"set_page_dirty()" at some point meant "the writes have been done", but 
these days it really means something else.

Now, the reason there is no trivial patch is not that this is conceptually 
really hard to fix. I can see several different approaches to fixing it, 
but they all really boil down to two alternatives:

 (a) splitting the one "PG_dirty" bit up into two bits: the 
     "PG_writescheduled" bit and the "PG_alldirty" bit.

     The "PG_write_scheduled" bit would be the bit that the filesystem 
     would set when it has pending dirty data that it wrote itself (and 
     that may not cover the whole page), and is the part of PG_dirty that 
     sets the PAGECACHE_TAG_DIRTY. It's also what forces "writepage()" to 
     be called.

     The "PG_alldirty" bit is just an additional "somebody else dirtied 
     random parts of this page, and we don't know what" flag, which is set 
     by "set_page_dirty()" in addition to doing the PG_write_scheduled 
     stuff. We would test-and-clear it at "writepage()" time, and pass it 
     in to "writepages()" to tell the writepage() function that it can't 
     just write out its own small limited notion of what is dirty.

     (There are various variations on this whole theme: instead of having 
     a flag to "writepage()", we could split the "whole page" case out as 
     a separate callback or similar)

 (b) making sure that all "set_page_dirty()" calls are _after_ the page 
     has been marked dirty (which in the case of memory mapped pages would 
     mean that we would _not_ call it when we mark the page writable at 
     all, we would call it when we _remove_ the dirty bit and mark it 
     unwritable). That would have the nice fearture that it wouldn't 
     require any FS-level changes, which would be a nice thing - it would 
     basically make the VM dirty accounting work the way the FS layer now 
     already expects it to.

I think (b) is conceptually simpler, and I think I'll try it tomorrow 
after I've slept on it. The reason I mention (a) at all is that I like the 
conceptual notion of telling he filesystem ahead of time that "you're 
going to get a full dirty page", because what (b) will inevitably lead to 
is that the filesystem will maintain its own partial state, and then 
effectively just before it gets the writepage() notification, it will be 
told it was all pointless, because we just dirtied the whole thing. 

IOW, the advantage of (a) is also it's disadvantage: it tells the 
filesystem more. The disadvantage is that it would require VFS interface 
changes exactly to do that (ie the "mapping->set_page_dirty()" semantics 
would also be split up into two, and it would now be a "prepare to write 
the whole page during the next 'writepage()'" thing).

So to recap: the VM layer really expected "writepage()" to act as if it 
wrote out the whole page. It doesn't. Not in the presense of the buffer 
layer and the filesystem having written out some buffers independently of 
the VM layer earlier.

I think this also explains why "data=ordered" broke, and "data=writeback" 
didn't. When ext3 does "ordered" writebacks, it will do file data 
writebacks on its own, in _its_ order. In contrast, when it does 
"data=writeback", it will do the writebacks exactly as the VM presents 
them, and won't write any buffers on its own - which makes the bug go 
away, because now VM and FS end up agreeing about the semantics of 
"writepage()".

Andrew, do you see anything wrong in my thinking?

Peter - on a VM level, the fix would be:

 - remove the "set_page_dirty()" from the page fault path, and just set 
   the PAGECACHE_TAG_DIRTY instead.

 - clear_page_dirty_for_io() would now need to check the mappings of the 
   page even if it wasn't marked PG_dirty (or we'd have another page flag 
   for the "page is dirty in page tables"), which is kind of a mixture of 
   (a) and (b) cases above, except we don't expose it to the FS.

 - if it was dirty in the page tables, we do a "set_page_dirty()" after 
   cleaning the page tables, and then the rest of 
   "clear_page_dirty_for_io()" really boils down to a simple 
   "TestAndClearDirty(page)"

Hmm? I'd love it if somebody else wrote the patch and tested it, because 
I'm getting sick and tired of this bug ;)

		Linus
