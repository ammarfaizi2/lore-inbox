Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWGPL1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWGPL1e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 07:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWGPL1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 07:27:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:327 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751577AbWGPL1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 07:27:34 -0400
Date: Sun, 16 Jul 2006 13:26:33 +0200
From: Jens Axboe <axboe@suse.de>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] 0/15 IO scheduler improvements
Message-ID: <20060716112633.GB8936@suse.de>
References: <200607132350.47388.a1426z@gawab.com> <200607151535.04042.a1426z@gawab.com> <20060715174559.GF22724@suse.de> <200607152327.56763.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607152327.56763.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15 2006, Al Boldi wrote:
> Jens Axboe wrote:
> > On Sat, Jul 15 2006, Al Boldi wrote:
> > > Jens Axboe wrote:
> > > > On Fri, Jul 14 2006, Al Boldi wrote:
> > > > > Jens Axboe wrote:
> > > > > > On Thu, Jul 13 2006, Al Boldi wrote:
> > > > > > > Jens Axboe wrote:
> > > > > > > > This is a continuation of the patches posted yesterday, I
> > > > > > > > continued to build on them. The patch series does:
> > > > > > > >
> > > > > > > > - Move the hash backmerging into the elevator core.
> > > > > > > > - Move the rbtree handling into the elevator core.
> > > > > > > > - Abstract the FIFO handling into the elevator core.
> > > > > > > > - Kill the io scheduler private requests, that require
> > > > > > > > allocation/free for each request passed through the system.
> > > > > > > >
> > > > > > > > The result is a faster elevator core (and faster IO
> > > > > > > > schedulers), with a nice net reduction of kernel text and code
> > > > > > > > as well.
> > > > > > >
> > > > > > > Thanks!
> > > > > > >
> > > > > > > Your efforts are much appreciated, as the current situation is a
> > > > > > > bit awkward.
> > > > > >
> > > > > > It's a good step forward, at least.
> > > > > >
> > > > > > > > If you have time, please give this patch series a test spin
> > > > > > > > just to verify that everything still works for you. Thanks!
> > > > > > >
> > > > > > > Do you have a combo-patch against 2.6.17?
> > > > > >
> > > > > > Not really, but git let me generate one pretty easily. It has a
> > > > > > few select changes outside of the patchset as well, but should be
> > > > > > ok. It's not tested though, should work but the rbtree changes
> > > > > > needed to be done additionally. If it boots, it should work :-)
> > > > >
> > > > > patch applies ok
> > > > > compiles ok
> > > > > panics on boot at elv_rb_del
> > > > > patch -R succeeds with lot's of hunks
> > > >
> > > > So I most likely botched the rbtree conversion, sorry about that. Oh,
> > > > I think it's a silly reverted condition, can you try this one?
> > >
> > > Thanks!
> > >
> > > patch applies ok
> > > compiles ok
> > > boots ok
> > > patch -R succeeds with lot's of hunks
> > >
> > > Tried it anyway, and found an improvement only in cfq, where :
> > > echo 512 > /sys/block/hda/queue/max_sectors_kb
> > > gives full speed for 5-10 sec then drops to half speed
> > > other scheds lock into half speed
> > > echo 192 > /sys/block/hda/queue/max_sectors_kb
> > > gives full speed for all scheds
> >
> > Not sure what this all means (full speed for what?)
> 
> full speed = max HD thruput

Ok, for a cat test I see. This wasn't really obvious from what you
wrote, please be more detailed in what tests you are running!

> > The patchset mainly
> > focuses on optimizing the elevator core and schedulers, it wont give a
> > speedup unless your storage hardware is so fast that you are becoming
> > CPU bound. Since you are applying to 2.6.17, there are some CFQ changes
> > that do introduce behavioural changes.
> >
> > You should download
> >
> > http://brick.kernel.dk/snaps/blktrace-git-20060706102503.tar.gz
> >
> > and build+install it, then do:
> >
> > - blktrace /dev/hda
> > - run shortest test that shows the problem
> > - ctrl-c blktrace
> >
> > tar up the hda.* output from blktrace and put it somewhere where I can
> > reach it and I'll take a look.
> 
> The output is a bit large, so here is a summary:
> # echo 192 > /sys/block/hda/queue/max_sectors_kb
> # cat /dev/hda > /dev/null &
> # blktrace /dev/hda ( doesn't work; outputs zero trace)
> # blktrace /dev/hda -w 1 -o - | blkparse -i - > 
> /mnt/nfs/10.1/tmp/hdtrace.cfq.192

I don't see anything wrong in the small excerpts you posted, so can you
please just generate a few seconds log from a 192 sector and 512 sector
run and put them somewhere where I can download the two?

Just do the same sequence of commands you just did, but use -o 192_run
or something to keep the files. It's an interesting issue you have seen,
I'd like to get to the bottom of it.

-- 
Jens Axboe

