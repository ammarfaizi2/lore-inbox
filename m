Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWEaRsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWEaRsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 13:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWEaRsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 13:48:08 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35361 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751761AbWEaRsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 13:48:07 -0400
Date: Wed, 31 May 2006 19:50:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mason@suse.com, andrea@suse.de, hugh@veritas.com,
       torvalds@osdl.org
Subject: Re: [rfc][patch] remove racy sync_page?
Message-ID: <20060531175010.GW29535@suse.de>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <20060529201444.cd89e0d8.akpm@osdl.org> <20060530090549.GF4199@suse.de> <447D9D9C.1030602@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447D9D9C.1030602@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31 2006, Nick Piggin wrote:
> Hi Jens,
> Sorry, I don't think I gave you any reply to this...

No worries :)

> Jens Axboe wrote:
> >On Mon, May 29 2006, Andrew Morton wrote:
> >
> >>
> >>Mysterious question, that.  A few years ago I think Jens tried pulling
> >>unplugging out, but some devices still want it (magneto-optical
> >>storage iirc).  And I think we did try removing it, and it caused
> >>hurt.
> >
> >
> >I did, back when we had problems due to the blk_plug_lock being a global
> >one. I first wanted to investigate if plugging still made a difference,
> >otherwise we could've just ripped it out back than and the problem would
> >be solved. But it did get us about a 10% boost on normal SCSI drives
> >(don't think I tested MO drives at all), so it was fixed up.
> 
> Interesting. I'd like to know where from. I wonder if my idea of a
> process context plug/unplug would solve it...

As far as I recall, just doing a simple diff between source directories
on the same drive was a pretty good example of where the plugging gained
you some. A little on the benchmarks as well, iirc. I would have _loved_
to rip plugging out at that point, so while I may not remember the
details yet, don't think I did that work if I could have avoided it :-)

> >>>With splice, the mapping can change, so you can have the wrong
> >>>sync_page callback run against the page.
> >>
> >>Oh.
> >
> >
> >Maybe I'm being dense, but I don't see a problem there. You _should_
> >call the new mapping sync page if it has been migrated.
> 
> But can some other thread calling lock_page first find the old mapping,
> and then run its ->sync_page which finds the new mapping? While it may
> not matter for anyone in-tree, it does break the API so it would be
> better to either fix it or rip it out than be silently buggy.

It looks ok to me, you can inspect fs/splice.c:pipe_to_file() and see if
you can spot anything.

> >>>The ->pin() calls in pipe_to_file and pipe_to_sendpage?
> >>
> >>One for Jens...
> >
> >
> >splice never incs/decs any inode related reference counts, so if it
> >needs to then yes it's broken. Any references to kernel code that deals
> >with that?
> 
> Most code in the VM that has an inode/mapping gets called from the VFS,
> which already does its thing somehow (I guess something like the file
> pins the dentry which pins the inode). An iget might solve it. Or you
> could use the lock_page_nosync() if/when the patch goes in (although I
> don't want that to spread too far just yet).

I'll be sure to look over that, thanks!

-- 
Jens Axboe

