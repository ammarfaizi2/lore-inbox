Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWDTUIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWDTUIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWDTUIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:08:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:58456 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751240AbWDTUIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:08:16 -0400
Date: Thu, 20 Apr 2006 22:08:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Linh Dang <linhd@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
Message-ID: <20060420200847.GM4717@suse.de>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org> <20060419200001.fe2385f4.diegocg@gmail.com> <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org> <20060420145041.GE4717@suse.de> <wn5fyk85bw7.fsf@linhd-2.ca.nortel.com> <20060420194914.GL4717@suse.de> <wn53bg858b2.fsf@linhd-2.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wn53bg858b2.fsf@linhd-2.ca.nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20 2006, Linh Dang wrote:
> Jens Axboe <axboe@suse.de> wrote:
> 
> > On Thu, Apr 20 2006, Linh Dang wrote:
> >> Jens Axboe <axboe@suse.de> wrote:
> >>
> >>> On Wed, Apr 19 2006, Linus Torvalds wrote:
> >>>> There are some other buffer management system calls that I
> >>>> haven't done yet (and when I say "I haven't done yet", I
> >>>> obviously mean "that I hope some other sucker will do for me,
> >>>> since I'm lazy"), but that are obvious future extensions:
> >>>
> >>> Well it's worked so far, hasn't it? :-)
> >>>
> >>>> - an ioctl/fcntl to set the maximum size of the buffer. Right now
> >>>> it's hardcoded to 16 "buffer entries" (which in turn are normally
> >>>> limited to one page each, although there's nothing that
> >>>> _requires_ that a buffer entry always be a page).
> >>>
> >>> This is on a TODO, but not very high up since I've yet to see a
> >>> case where the current 16 page limitation is an issue. I'm sure
> >>> something will come up eventually, but until then I'd rather not
> >>> bother.
> >>
> >> DVD burning! splicing those huge VOB files into the dvd device
> >> would be nice. And believe me, the current 16 entries of the pipe
> >> is nowhere enough to sustain burning at 8X avg speed or higher.
> >>
> >> It's a special case but it'd benefit a LOT of ppl ;-)
> >
> > (don't drop the cc list)
> >
> > DVD burning probably isn't a good splice fit, since you need to do
> > more than actually just point the device at the data. SG_IO is
> > already zero-copy as it maps the user data into the kernel without
> > copying, so there's very little room for improvement there to begin
> > with.
> 
> DVD burning on linux is mostly:
> 
>         mkisofs .... | growisofs ....
> 
> Ideally, on mkisofs side, we'd be able to:
> 
>   - write some data/padding into the pipe
>   - splice a HUGE file into the pipe
>   - write some data/padding into the pipe
>   - splice a HUGE file into the pipe
>   ...
> 
> On growisofs side, we'd be able to:
> 
>   - send some commands
>   - splice N MBs of data from the pipe to the driver
>   - send some commands
>   - splice M MBs of data from the pipe to the driver
>   ...

On the mkisofs side you have a good point, splice/vmsplice could be
really useful there! I was too narrowly thinking of burning already made
iso files which is easier of course. You'd need to invent a new way to
do SG_IO with a pipe buffer, but that's really implementation detail.
The mkisofs part is already doable with the current code, with the size
restriction naturally.

> What'd be nice is an ioctl to change the size of the pipe between
> mkisofs and growisofs.

Yes fully agree. It is something that will be done eventually, but since
it requires redoing pipe_inode_info bufs[] it is a little invasive on
fs/pipe.c. You could even allow it to grow dynamically, lots of
possibilities...

-- 
Jens Axboe

