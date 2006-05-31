Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWEaPM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWEaPM2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 11:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWEaPM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 11:12:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965057AbWEaPM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 11:12:27 -0400
Date: Wed, 31 May 2006 08:09:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0605310755210.24646@g5.osdl.org>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au>
 <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au>
 <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au>
 <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 May 2006, Linus Torvalds wrote:
> 
> The reason it's kicked by wait_on_page() is that is when it's needed.

Btw, that's not how it has always been done.

For the longest time, it was actually triggered by scheduler activity, in 
particular, plugging used to be a workqueue event that was triggered by 
the scheduler (or any explicit points when you wanted it to be triggered 
earlier).

So whenever you scheduled, _all_ plugs would be unplugged.

It was specialized to wait_for_page() in order to avoid unnecessary 
overhead in scheduling (making it more directed), and to allow you to 
leave the request around for further merging/sorting even if a process had 
to wait for something unrelated.

But in particular, the old non-directed unplug didn't work well in SMP 
environments (because _one_ CPU re-scheduling obviously doesn't mean 
anything for the _other_ CPU that is actually working on setting up the 
request queue).

The point being that we could certainly do it somewhere else. Doing it in 
wait_for_page() (and at least historically, in waiting for bh's) is really 
nothing more than trying to have as few points as possible where it's 
done, and at the same time not missing any.

And yes, I'd _love_ to have better interfaces to let people take advantage 
of this than sys_readahead(). sys_readahead() was a 5-minute hack that 
actually does generate wonderful IO patterns, but it is also not all that 
useful (too specialized, and non-portable).

I tried at one point to make us do directory inode read-ahead (ie put the 
inodes on a read-ahead queue when doing a directory listing), but that 
failed miserably. All the low-level filesystems are very much designed to 
have inode reading be synchronous, and it would have implied major surgery 
to do (and, sadly, my preliminary numbers also seemed to say that it might 
be a huge time waster, with enough users just wanting the filenames and 
not the inodes).

The thing is, right now we have very bad IO patterns for things that 
traverse whole directory trees (like doign a "tar" or a "diff" of a tree 
that is cold in the cache) because we have way too many serialization 
points. We do a good job of prefetching within a file, but if you have 
source trees etc, the median size for files is often smaller than a single 
page, so the prefetching ends up being a non-issue most of the time, and 
we do _zero_ prefetching between files ;/

Now, the reason we don't do it is that it seems to be damn hard to do. No 
question about that. Especially since it's only worth doing (obviously) on 
the cold-cache case, and that's also when we likely have very little 
information about what the access patterns might be.. Oh, well.

Even with sys_readahead(), my simple "pre-read a whole tree" often ended 
up waiting for inode IO (although at least the fact that several inodes 
fit in one block gets _some_ of that).

			Linus
