Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWC3Au7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWC3Au7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 19:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWC3Au6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 19:50:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751323AbWC3Au6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 19:50:58 -0500
Date: Wed, 29 Mar 2006 16:50:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
In-Reply-To: <20060329143758.607c1ccc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Mar 2006, Andrew Morton wrote:
> 
> - splice() take a size_t length.  Should it be taking a 64-bit length?

No. You can't splice more than the kernel buffers anyway (ie currently 
PIPE_BUFFERS pages, ie ~64kB, although in theory somebody could use large 
pages for it), so 64-bit would be total overkill.

> - splice() doesn't check for (len < 0), like read() and write() do. 
>   Should it?

Umm. More likely better to just do rw_verify_area() instead, which limits 
it to MAX_INT. Although it probably doesn't matter, for the above obvious 
reason anyway (ie we end up doing everything on a page-granular area 
anyway).

> - Please don't call it `len'.  VFS has to deal with "lengths" which can
>   be in units of PAGE_CACHE_SIZE, fs blocksize, 512-bytes sectors or bytes,
>   and it gets confusing.  Our liking for variable names like `len' and
>   `count' just makes it worse.

I don't see that being problematic. I agree that if "len" is in pages, we 
should call it something else (like 'npages'), but the fact that we 
commonly use "len" for byte-lengths just sounds sane.

> - why is the `flags' arg to sys_splice() unsigned long?  Can it be `int'?

flags are always unsigned long, haven't you noticed? Besides, they should 
never be signed, if you do bitmasks and shifting on them: "int" is 
strictly worse than "unsigned" when we're talking flags.

> - what does `flags' do, anyway?  The whole thing is undocumented and
>   almost uncommented.

Right now "flags" doesn't do anything at all, and you should just pass in 
zero.

But if we ever do a "move" vs "copy" hint, we'll want something.

> - the tmp_page trick in anon_pipe_buf_release() seems to be unrelated to
>   the splice() work.  It should be a separate patch and any peformance
>   testing (needed, please) should be decoupled from that change.

It's not unrelated. Note the new "page_count() == 1" test.

> - All the operations do foo(in, out, ...).  It's a bit more conventional
>   to do foo(out, in, ...).

You think? What convention do we have? We don't say "cp dst src", we say 
"cp src dst".

The "destination first" convention is insane. It only makes sense for 
assignments, and these aren't assignments.

> - The logic in do_splice() hurts my brain.  "if `in' is a pipe then
>   splice from `in-as-a-pipe' to `out' else if `out' is a pipe then splice
>   from `in' to 'out-as-a-pipe'.  Make sense, I guess, but I do wonder "what
>   would happen if those tests were reversed?".  Nothing, I guess.

Why would it matter? If both are pipes, then one is as good as the other. 
You just want to pick the version that is potentially more efficient, if 
there is any difference (and there is).

However, I don't think Jens actually did the pipe->pipe case at all (ie 
pipes don't have the "splice_read()" function yet).

> 
> - In pipe_to_file():
> 
>   - Shouldn't it be using GFP_HIGHUSER()?

Some filesystems may not like having highpages. 

I suspect it should be "mapping_gfp_mask(mapping)".

> What does the feature do?  How would one use it in an application?  Is it
> intended that it be generalised to other kinds of address_spaces?  If so,
> which ones, and what implementation problems might we expect?

You'd use it instead of "sendfile()".

Think of it as a hell of a lot more capable than "sendfile()" can ever be. 
It can take input from anything that just has "splice_read()", and move it 
to anything else, without doing any extra copies.

So imagine a streaming media thing, with a DVB card. Imaging wanting to 
push all that data around the system without doing a "read()" into user 
space and then a "write()" out to a file.

Also, imagine doing a "tee()" system call that can duplicate the pages 
from one pipe into two other pipes. By just incrementing the page count. 
So that your media streaming application can stream to both a file _and_ 
to live video (or whatever else) without doubling the buffering and doing 
memcpy.

		Linus
