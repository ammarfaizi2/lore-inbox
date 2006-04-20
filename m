Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWDTTTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWDTTTY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWDTTTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:19:24 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11562 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750881AbWDTTTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:19:23 -0400
Date: Thu, 20 Apr 2006 21:19:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
Message-ID: <20060420191954.GG4717@suse.de>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org> <20060419200001.fe2385f4.diegocg@gmail.com> <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org> <20060420145041.GE4717@suse.de> <Pine.LNX.4.64.0604200818490.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604200818490.3701@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20 2006, Linus Torvalds wrote:
> 
> 
> On Thu, 20 Apr 2006, Jens Axboe wrote:
> > 
> > >  - an ioctl/fcntl to set the maximum size of the buffer. Right now it's 
> > >    hardcoded to 16 "buffer entries" (which in turn are normally limited to 
> > >    one page each, although there's nothing that _requires_ that a buffer 
> > >    entry always be a page).
> > 
> > This is on a TODO, but not very high up since I've yet to see a case
> > where the current 16 page limitation is an issue. I'm sure something
> > will come up eventually, but until then I'd rather not bother.
> 
> The real reason for limiting the number of buffer entries is not to make 
> the number _larger_ (although that can be a performance optimization), but 
> to make it _smaller_ or at least knowing/limiting how big it is.
> 
> It doesn't matter with the current interfaces which are mostly agnostic as 
> to how big the buffer is, but it _does_ matter with vmsplice().
> 
> Why?
> 
> Simple: for a vmsplice() user, it's very important to know when they can 
> start re-using the buffer(s) that they used vmsplice() on previously. And 
> while the user could just ask the kernel how many bytes are left in the 
> pipe buffer, that's pretty inefficient for many normal streaming cases.
> 
> The _efficient_ way is to make the user-space buffer that you use for 
> splicing information to another entity a circular buffer that is at least 
> as large as any of the splice pipes involved in the transfer (depending on 
> use. In many cases, you will probably want to make the user-space buffer 
> _twice_ as big as the kernel buffer, which makes the tracking even easier: 
> while half of the buffer is busy, you can write to the half that is 
> guaranteed to not be in the kernel buffer, so you effectively do "double 
> buffering")
> 
> So if you do that, then you can continue to write to the buffer without 
> ever worrying about re-use, because you know that by the time you wrap 
> around, the kernel buffer will have been flushed out, or the vmsplice() 
> would have blocked, waiting for the receiver. So now you no longer need to 
> worry about "how much has flushed" - you only need to worry about doing 
> the vmsplice() call at least twice per buffer traversal (assuming the 
> "user buffer is double the size of the kernel buffer" approach).
> 
> So you could do a very efficient "stdio-like" implementation for logging, 
> for example, since this allows you to re-use the same pages over and over 
> for splicing, without ever having any copying overhead, and without ever 
> having to play VM-related games (ie you don't need to do unmaps or 
> mprotects or anything expensive like that in order to get a new page or 
> something).
> 
> But in order to do that, you really do need to know (and preferably set) 
> the size of the splice buffer. Otherwise, if the in-kernel splice buffer 
> is larger than the circular buffer you use in user space, the kernel will 
> add the same page _twice_ to the buffer, and you'll overwrite the data 
> that you already spliced.

Good point, as you can tell I had other uses in mind for this. I'd
prefer using fcntl for this instead of an ioctl - how about a set of
matching F_SETPIPESZ/F_GETPIPESZ or something in that order? Right now
we can just -EINVAL stub the pipe size setting, but really implement the
pipe size getting.

Other suggestions?

The vmsplice addition itself is pretty slim:

 splice.c |  163 +++++++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 132 insertions(+), 31 deletions(-)

> (Now, you still need to be very careful with vmsplice() in general, since 
> it leaves the data page writable in the source VM and thus allows for all 
> kinds of confusion, but the theory here is "give them rope". Rope enough 
> to do clever things always ends up being rope enough to hang yourself too. 
> Tough.).

Oh definitely :-)

-- 
Jens Axboe

