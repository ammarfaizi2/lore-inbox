Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965222AbWFIFpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbWFIFpx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 01:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWFIFpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 01:45:53 -0400
Received: from gw.goop.org ([64.81.55.164]:20689 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965219AbWFIFpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 01:45:52 -0400
Message-ID: <44890B05.2070303@goop.org>
Date: Thu, 08 Jun 2006 22:45:41 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Auke Kok <auke-jan.h.kok@intel.com>
CC: Matt Mackall <mpm@selenic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Using netconsole for debugging suspend/resume
References: <44886381.9050506@goop.org> <20060608210702.GD24227@waste.org> <4488D4DE.3000100@goop.org> <4489038C.3050901@intel.com>
In-Reply-To: <4489038C.3050901@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Auke Kok wrote:
> netconsole should retry. There is no timeout programmed here since 
> that might
> lose important information, and you rather want netconsole to survive 
> an odd
> unplugged cable then to lose vital debugging information when the 
> system is
> busy for instance. (losing link will cause the interface to be down 
> and thus
> the queue to be stopped)
Well, the trouble is that it ends up spinning forever in the suspend 
case.  The driver's suspend routine has XOFFed the queue, and its never 
going to come back if netconsole clogs everything up over it.

Perhaps the correct fix isn't at the netpoll level, but at the 
netconsole level, but the behaviour of "suspend ethernet, netconsole 
drops bits into the bucket until the ether comes back" seems to be the 
best we can hope for.

The present behaviour is definitely bad, since it will prevent any 
system from suspending while using netconsole, so you'd need to make it 
modular and rmmod/modprobe it around the suspend event - definitely 
losing more information.

Also it means that if you kick a cable, the machine will eventually lock 
up, which doesn't seem like the best behaviour...

Even so, it will wait for 1 second per skb sent (20000 x 50uS) to wait 
for the queue to be started, so it will be pretty slow, and will recover 
from little hiccups without losing much.

> polling is for receives. We're basically telling the stack not to poll 
> our
> interface anymore.
OK, I see.

> e1000_suspend saves the entire configuration of the device and puts it in
> Wake-on-Lan mode, allowing it to be waken up by your 'zap' in the 
> proper way.
Not sure that's terribly useful.  It would be nice to be able to zap the 
ethernet to get a console dump from early stages, but talking to the 
device depends on all the intermediate PCI stuff being set up first, so 
netconsole could cause even more of a mess.
>> Then the e1000 would resume normally, including restarting the xmit 
>> queue so that netconsole can start again immediately; any netconsole 
>> output before the e1000 resume would be lost, of course (I guess it 
>> could be buffered).  That would suit me for now.
>
> after coming out of suspend, e1000_resume is called which basically
> reinitializes the entire device. In the entire sequence it is unlikely 
> that
> you'll actually be able to maintain netconsole in the first boot stage 
> - the
> network device will not be initialized by the kernel yet, and 
> obviously will
> be useless until e1000_resume is called!
Yes, but I think that's OK for what I'm looking at.  The problems I'm 
seeing happen later, and as I said in the first mail, I'm willing to 
accept a bletcherous hack if necessary (though obviously something clean 
and mergable would be preferable).

At the netpoll level, assuming that netpoll_send_skb doesn't busywait 
forever while the queue is XOFFed, it will toss things until the moment 
the ethernet device queue is up, and then it will resume as normal.

> I'm not sure that tweaking e1000 to survive longer is the answer here, 
> and you
> might be better off trying to have netconsole graciously wait
> (msleep_interruptable instead of udelay?)
Pretty sure netpoll can't sleep there...

> In any case, I see the biggest
> problem in the early boot stage when all nics are basically uninitialized
> until resume starts. You just can't assign it an IP address for 
> instance that
> easy, and even resume causes the device to reset and thus link 
> renegotiation,
> adding crucial seconds to the time that the link is down, in which 
> time you're
> stacking up netconsole messages, or worse, fail to initialize netconsole
netconsole has already been initialized.  It doesn't need reinit on resume.

> I hope this helps - I can't help but thinking that netconsole definately
> wasn't designed with this in mind.
Perhaps not, but it isn't far from being a useful tool in this case.  
Its much better than the alternative of having no information at all 
about the whole process.

    J
