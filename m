Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbWH1B4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWH1B4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 21:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWH1B4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 21:56:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46497 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932173AbWH1B4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 21:56:15 -0400
Date: Mon, 28 Aug 2006 11:55:57 +1000
From: David Chinner <dgc@sgi.com>
To: Neil Brown <neilb@suse.de>
Cc: David Chinner <dgc@sgi.com>, Andi Kleen <ak@suse.de>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: RFC - how to balance Dirty+Writeback in the face of slow  writeback.
Message-ID: <20060828015557.GI807830@melbourne.sgi.com>
References: <20060816231448.cc71fde7.akpm@osdl.org> <20060818001102.GW51703024@melbourne.sgi.com> <20060817232942.c35b1371.akpm@osdl.org> <20060818070314.GE798@suse.de> <p73hd0998is.fsf@verdi.suse.de> <17640.65491.458305.525471@cse.unsw.edu.au> <20060821031505.GQ51703024@melbourne.sgi.com> <17641.24478.496091.79901@cse.unsw.edu.au> <20060821142802.GU51703024@melbourne.sgi.com> <17646.35231.690105.300713@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17646.35231.690105.300713@cse.unsw.edu.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 03:24:47PM +1000, Neil Brown wrote:
> On Tuesday August 22, dgc@sgi.com wrote:
> > AFAICT, all we need to do is prevent interactions between bdis and
> > the current problem is that we loop on clean bdis waiting for slow
> > dirty ones to drain.
> > 
> > My thoughts are along the lines of a decay in nr_to_write between
> > loop iterations when we don't write out enough pages (i.e. clean
> > bdi) so we break out of the loop sooner rather than later.
> 
> I don't understand the purpose of the decay.  Once you are sure the
> bdi is clean, why not break out of the loop straight away?

Simply to slow down the rate at which any process is dirtying
memory. The decay only becomes active when you're writing to a
clean device when there are lots of dirty pages on a slow device,
otherwise it's a no-op.

To illustrate the problem of breaking straight out of the throttle
loop, even though we hit the dirty rate limit we may have
dirtied pages on multiple bdis but we are only flushing on one of
them.  Hence we could potentially trigger increasing numbers of
dirty pages if we don't back off in some way when throttling here
even though the device we throttled on was clean.

e.g. Think of writing data to a slow device, then a log entry to a fast
device, and every time the write to the fast device triggers the
throttling which gets cleaned and we go and dirty more pages on
the slow device immediately without throttling....

> Also, your code is a little confusing.  The 

Sorry, it was a quick hack to illustrate my thinking.....

> So I would like us to break out of the loop as soon as there is good
> reason to believe the bdi is clean.

Which was exactly my line of thinking, but tempered by the fact that
just breaking out of the loop could introduce a nasty problem....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
