Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVFQOJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVFQOJb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 10:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbVFQOJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 10:09:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:55762 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261981AbVFQOJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 10:09:24 -0400
Date: Fri, 17 Jun 2005 16:10:40 +0200
From: Jens Axboe <axboe@suse.de>
To: spaminos-ker@yahoo.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
Message-ID: <20050617141039.GL6957@suse.de>
References: <20050614000352.7289d8f1.akpm@osdl.org> <20050614232154.17077.qmail@web30701.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614232154.17077.qmail@web30701.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14 2005, spaminos-ker@yahoo.com wrote:
> --- Andrew Morton <akpm@osdl.org> wrote:
> > > For some reason, doing a "cp" or appending to files is very fast. I suspect
> > > that vi's mmap calls are the reason for the latency problem.
> > 
> > Don't know.  Try to work out (from vmstat or diskstats) how much reading is
> > going on.
> > 
> > Try stracing the check, see if your version of vi is doing a sync() or
> > something odd like that.
> 
> The read/write patterns of the background process is about 35% reads.
> 
> vi is indeed doing a sync on the open file, and that's where the time
> was spend.  So I just changed my test to simply opening a file,
> writing some data in it and calling flush on the fd.
> 
> I also reduced the sleep to 1s instead of 1m, and here are the
> results:
> 
> cfq: 20,20,21,21,20,22,20,20,18,21 - avg 20.3 noop:
> 12,12,12,13,5,10,10,12,12,13 - avg 11.1 deadline:
> 16,9,16,14,10,6,8,8,15,9 - avg 11.1 as: 6,11,14,11,9,15,16,9,8,9 - avg
> 10.8
> 
> As you can see, cfq stands out (and it should stand out the other
> way).

This doesn't look good (or expected) at all. In the initial posting you
mention this being an ide driver - I want to make sure if it's hda or
sata driven (eg sda or similar)?

> > OK, well if the latency is mainly due to reads then one would hope that the
> > anticipatory scheduler would do better than that.
> 
> I suspect the latency is due to writes: it seems (and correct me if I
> am wrong) that write requests are enqueued in one giant queue, thus
> the cfq algorithm can not be applied to the requests.

That is correct. Each process has a sync queue associated with it, async
requests like writes go to a per-device async queue. The cost of
tracking who dirtied a given page was too large and not worth it.
Perhaps rmap could be used to lookup who has a specific page mapped...

> But then, why would other i/o schedulers perform better in that case?

Yeah, the global write queue doesn't explain anything, the other
schedulers either share read/write queue or have a seperate single write
queue as well.

I'll try and reproduce (and fix) your problem.

-- 
Jens Axboe

