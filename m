Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWD0Ho6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWD0Ho6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWD0Ho5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:44:57 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20546 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932426AbWD0Ho5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:44:57 -0400
Date: Thu, 27 Apr 2006 09:45:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, npiggin@suse.de,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060427074533.GJ9211@suse.de>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org> <20060426191557.GA9211@suse.de> <20060426131200.516cbabc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20060426131200.516cbabc.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 26 2006, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > With a 16-page gang lookup in splice, the top profile for the 4-client
> > case (which is now at 4GiB/sec instead of 3) are:
> > 
> > samples  %        symbol name
> > 30396    36.7217  __do_page_cache_readahead
> > 25843    31.2212  find_get_pages_contig
> > 9699     11.7174  default_idle
> 
> __do_page_cache_readahead() should use gang lookup.  We never got around to
> that, mainly because nothing really demonstrated a need.
> 
> It's a problem that __do_page_cache_readahead() is being called at all -
> with everything in pagecache we should be auto-turning-off readahead.  This
> happens because splice is calling the low-level do_pagecache_readahead(). 
> If you convert it to use page_cache_readahead(), that will all vanish if
> readahead is working right.

You are right, I modified it to use page_cache_readahead() and that
looks a lot better for the vanilla kernel. Here's a new graph of
2.6.17-rc3 and 2.6.17-rc3-lockless. Both base kernels are the splice
branch, so it contains the contig lookup change as well.

I'm still doing only up to nr_cpus clients, as numbers start to
fluctuate above that.

Things look pretty bad for the lockless kernel though, Nick any idea
what is going on there? The splice change is pretty simple, see the top
three patches here:

http://brick.kernel.dk/git/?p=linux-2.6-block.git;a=shortlog;h=splice

The top profile for the 4-client case looks like this:

samples  %        symbol name
77955    77.7141  find_get_pages_contig
8034      8.0092  splice_to_pipe
5092      5.0763  default_idle
4330      4.3166  do_splice_to
1323      1.3189  sys_splice

where vanilla is nowhere near that bad. I added a third graph, which is
lockless with the top patch backed out again so it's using
find_get_page() for each page. The top profile then looks like this for
the 4-client case:

samples  %        symbol name
10685    39.2730  default_idle
4120     15.1432  find_get_page
2608      9.5858  sys_splice
1729      6.3550  radix_tree_lookup_slot
1708      6.2778  splice_from_pipe
1071      3.9365  splice_to_pipe

Finally, I'll just note that the find_get_pages_contig() was modified
for the lockless kernel (read_lock -> spin_lock), so it isn't something
silly :-)

-- 
Jens Axboe


--jRHKVT23PllUwdXP
Content-Type: image/png
Content-Disposition: attachment; filename="lockless-3.png"
Content-Transfer-Encoding: base64

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

--jRHKVT23PllUwdXP--
