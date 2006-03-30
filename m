Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWC3HPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWC3HPy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWC3HPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:15:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:11633 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751205AbWC3HPx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:15:53 -0500
Date: Thu, 30 Mar 2006 09:16:01 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060330071601.GH13476@suse.de>
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org> <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603291624420.27203@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(So Linus basically handled everything here, I'll make some scattered
comments where I made changes).

On Wed, Mar 29 2006, Linus Torvalds wrote:
> > - splice() doesn't check for (len < 0), like read() and write() do. 
> >   Should it?
> 
> Umm. More likely better to just do rw_verify_area() instead, which limits 
> it to MAX_INT. Although it probably doesn't matter, for the above obvious 
> reason anyway (ie we end up doing everything on a page-granular area 
> anyway).

I've added rw_verify_area() calls now.

> > - what does `flags' do, anyway?  The whole thing is undocumented and
> >   almost uncommented.
> 
> Right now "flags" doesn't do anything at all, and you should just pass in 
> zero.
> 
> But if we ever do a "move" vs "copy" hint, we'll want something.

Precisely. I already have something in progress for that...

> > - the tmp_page trick in anon_pipe_buf_release() seems to be unrelated to
> >   the splice() work.  It should be a separate patch and any peformance
> >   testing (needed, please) should be decoupled from that change.
> 
> It's not unrelated. Note the new "page_count() == 1" test.

Yes, this is needed to make migrating pages from a pipe to the page
cache possible.

> > - The logic in do_splice() hurts my brain.  "if `in' is a pipe then
> >   splice from `in-as-a-pipe' to `out' else if `out' is a pipe then splice
> >   from `in' to 'out-as-a-pipe'.  Make sense, I guess, but I do wonder "what
> >   would happen if those tests were reversed?".  Nothing, I guess.
> 
> Why would it matter? If both are pipes, then one is as good as the other. 
> You just want to pick the version that is potentially more efficient, if 
> there is any difference (and there is).
> 
> However, I don't think Jens actually did the pipe->pipe case at all (ie 
> pipes don't have the "splice_read()" function yet).

No it's not there yet, coverage will increase soon :)

> > 
> > - In pipe_to_file():
> > 
> >   - Shouldn't it be using GFP_HIGHUSER()?
> 
> Some filesystems may not like having highpages. 
> 
> I suspect it should be "mapping_gfp_mask(mapping)".

I actually already made it GFP_HIGHUSER yesterday in a non-yet committed
patch, so I'll check up on this and make the change.

-- 
Jens Axboe

