Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264318AbUDTXO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbUDTXO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264373AbUDTXN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:13:59 -0400
Received: from mail.cyclades.com ([64.186.161.6]:2702 "EHLO mail.cyclades.com")
	by vger.kernel.org with ESMTP id S264356AbUDTXNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:13:11 -0400
Date: Tue, 20 Apr 2004 20:13:52 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: manfred@colorfullife.com, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-user signal pending and message queue limits
Message-ID: <20040420231351.GB13826@logos.cnet>
References: <20040419212810.GB10956@logos.cnet> <20040419224940.GY31589@devserv.devel.redhat.com> <20040420141319.GB13259@logos.cnet> <20040420130439.23fae566.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420130439.23fae566.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 01:04:39PM -0700, Andrew Morton wrote:
> Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> >
> >  I wonder if it is a good idea to base mqueue limitation on the number of
> > > message queues and not take into account how big they are.
> > > 64 message queues with 1 byte msgsize and 1 maxmsg is certainly quite
> > > harmless and the system could have even more queues for such a user,
> > > while 64 message queues with 16K msgsize (current default) and 40 maxmsg
> > > (also default) eats ~ 40M of kernel memory.
> > 
> > Indeed, it seems more correct to account for something else than "nr of message queues".
> > 
> > Memory occupied sounds better, yeap?
> > 
> > I'm sending the patch anyway, we can use the same RLIMIT_MSGQUEUE and user->msg_queues later 
> > on with another meaning. 
> > 
> > Here it goes the update version, Andrew:
> 
> But we still have the global mq and signal limits?  These permit local
> denials of service attacks.  See
> http://seclists.org/lists/linux-kernel/2004/Apr/2065.html

Right, but one user can't starve the whole system anymore. You need 4 users starving
their quotas for it to become a local denial of service attack. But you are right, 
we can remove the global pending signal. I will prepare and test 
another patch tomorrow morning.

As for mqueues, currently root is allowed to allocate infinite number of mqueues. We 
want to remove that and calculate on the amount of memory allocated. I'll also think 
about it and come with an implementation tomorrow morning.

> The major advantage of your work is that we can now remove those limits. 
> You'll be needing a 2.4 backport ;)

Yeap. :) 

And we also need to do the userspace part. ulimit is part of bash, so 
probably all shell's should be awared of this? I never looked
how "ulimit" utility works.
