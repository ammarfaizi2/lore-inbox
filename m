Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWDTTeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWDTTeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWDTTeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:34:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32568 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751117AbWDTTeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:34:05 -0400
Date: Thu, 20 Apr 2006 21:34:31 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
Message-ID: <20060420193430.GH4717@suse.de>
References: <20060419200001.fe2385f4.diegocg@gmail.com> <Pine.LNX.4.64.0604191111170.3701@g5.osdl.org> <20060420145041.GE4717@suse.de> <20060420.122647.03915644.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420.122647.03915644.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20 2006, David S. Miller wrote:
> From: Jens Axboe <axboe@suse.de>
> Date: Thu, 20 Apr 2006 16:50:42 +0200
> 
> > On Wed, Apr 19 2006, Linus Torvalds wrote:
> > >  - vmsplice() system call to basically do a "write to the buffer", but 
> > >    using the reference counting and VM traversal to actually fill the 
> > >    buffer. This means that the user needs to be careful not to re-use the 
> > >    user-space buffer it spliced into the kernel-space one (contrast this 
> > >    to "write()", which copies the actual data, and you can thus re-use the 
> > >    buffer immediately after a successful write), but that is often easy to 
> > >    do.
> > 
> > This I already did, it was pretty easy and straight forward. I'll post
> > it soonish.
> 
> Do we plan to do vmsplice() to sockets?  That's interesting, but
> requires some serious cooperation from things like TCP so that
> the indication of "buffer can be reused now, thanks" is explicit
> and indicated as soon as ACK's come back for those parts of the
> data stream.

vmsplice() really just fills the pipe with the user data, at least that
is how I implemented it. Then you'd use splice to actually splice that
pipe to a socket, for instance.

> Even UDP would need to wait until the card is done with transmit,
> and we have DCCP and SCTP too.
> 
> People would want to be able to get event notifications of this,
> or do we plan to just block?  Blocking could be problematic,
> performance wise.
> 
> Anyways, I'm just stabbing in the dark.  It would be useful, because
> there is no real clan way to use sendfile() for zero copy of anonymous
> user data, and this vmsplice() thing seems like it could bridge that
> gap if we do it right.

It should be able to, yes. Seems to me it should just work like regular
splicing, with the difference that you'd have to wait for the reference
count to drop before reusing. One way would be to do as Linus suggests
and make the vmsplice call block or just return -EAGAIN if we are not
ready yet. With that pollable, that should suffice?

-- 
Jens Axboe

