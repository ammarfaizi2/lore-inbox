Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWHQFgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWHQFgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 01:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWHQFgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 01:36:50 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:14830 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751300AbWHQFgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 01:36:50 -0400
Date: Thu, 17 Aug 2006 09:36:36 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Daniel Phillips <phillips@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Message-ID: <20060817053636.GA30920@2ka.mipt.ru>
References: <1155127040.12225.25.camel@twins> <20060809130752.GA17953@2ka.mipt.ru> <1155130353.12225.53.camel@twins> <20060809.165431.118952392.davem@davemloft.net> <1155189988.12225.100.camel@twins> <44DF888F.1010601@google.com> <20060814051323.GA1335@2ka.mipt.ru> <44E3F525.3060303@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <44E3F525.3060303@google.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 17 Aug 2006 09:36:38 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 09:48:37PM -0700, Daniel Phillips (phillips@google.com) wrote:
> Evgeniy Polyakov wrote:
> >On Sun, Aug 13, 2006 at 01:16:15PM -0700, Daniel Phillips 
> >(phillips@google.com) wrote:
> >>Indeed.  The rest of the corner cases like netfilter, layered protocol and
> >>so on need to be handled, however they do not need to be handled right now
> >>in order to make remote storage on a lan work properly.  The sane thing 
> >>for
> >>the immediate future is to flag each socket as safe for remote block IO or
> >>not, then gradually widen the scope of what is safe.  We need to set up an
> >>opt in strategy for network block IO that views such network subsystems as
> >>ipfilter as not safe by default, until somebody puts in the work to make
> >>them safe.
> >
> >Just for clarification - it will be completely impossible to login using 
> >openssh or some other priveledge separation protocol to the machine due
> >to the nature of unix sockets. So you will be unable to manage your
> >storage system just because it is in OOM - it is not what is expected
> >from reliable system.
> 
> The system is not OOM, it is in reclaim, a transient condition that will be
> resolved in normal course by IO progress.  However you raise an excellent
> point: if there is any remote management that we absolutely require to be
> available while remote IO is interrupted - manual failover for example -
> then we must supply a means of carrying out such remote administration, that
> is guaranteed not to deadlock on a normal mode memory request.  This ends up
> as a new network stack feature I think, and probably a theoretical one for
> the time being since we don't actually know of any such mandatory login
> that must be carried out while remote disk IO is suspended.

That is why you are not allowed to depend on main system's allocator
problems. That is why network can have it's own allocator.

> >>But really, if you expect to run reliable block IO to Zanzibar over an ssh
> >>tunnel through a firewall, then you might also consider taking up bungie
> >>jumping with the cord tied to your neck.
> >
> >Just pure openssh for control connection (admin should be able to
> >login).
> 
> And the admin will be able to, but in the cluster stack itself we don't
> bless such stupidity as emailing an admin to ask for a login in order to
> break a tie over which node should take charge of DLM recovery.

No, you can't since openssh and any other priveledge separation
mechanisms use adtional sockets to transfer data between it's parts,
unix sockets require page sized allocation frequently which will endup
with 8k allocation in slab.
You will not be able to login using openssh.

> Regards,
> 
> Da niel

-- 
	Evgeniy Polyakov
