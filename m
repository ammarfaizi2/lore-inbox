Return-Path: <linux-kernel-owner+w=401wt.eu-S1753030AbWL2NQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030AbWL2NQy (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 08:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbWL2NQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 08:16:54 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:49585 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbWL2NQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 08:16:53 -0500
Date: Fri, 29 Dec 2006 16:14:53 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Jamal Hadi Salim <hadi@cyberus.ca>
Subject: Re: [take29 0/8] kevent: Generic event handling mechanism.
Message-ID: <20061229131452.GA5641@2ka.mipt.ru>
References: <3154985aa0591036@2ka.mipt.ru> <11668927001365@2ka.mipt.ru> <20061228160137.GA19301@elte.hu> <20061229085503.GB13816@2ka.mipt.ru> <20061229125427.GA23893@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061229125427.GA23893@elte.hu>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 29 Dec 2006 16:14:58 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 01:54:27PM +0100, Ingo Molnar (mingo@elte.hu) wrote:
> > > > Generic event handling mechanism.
> > > 
> > > i see it covers alot of event sources, but i cannot see block IO 
> > > notifications. Am i missing something?
> > 
> > Depending on what it is :) If you mean kevent based AIO, then it was 
> > dropped to reduce size of the patchset, and in favour of new AIO 
> > design.
> 
> yes, kevent based AIO. Could you please re-add it, preferably ontop of 
> Suparna's AIO patchset? I dont see how a "generic event handling 
> mechanism" can exclude block IO because we really need to see how it 
> plugs into (and plays along with) block AIO and how it performs relative 
> to block AIO to be able to judge whether this API and infrastructure 
> should be included in the kernel in its current form.

I like new design much more than my previous kevent based approach and
existing repeated call approach. I plan to start working on it jst after
New Year vacations are over (in about a week or two, it is the longest
vacations of the year in Russia, which are spent in a way which does not 
allow to hack or perform any other usefull work).
Kevent AIO was completely different thing than Suparna's AIO, and
although it hooked into block/fs subsystem on a bit different layer (I
exported ->get_block() callback), it was possible to fully separate AIO
from main code.

> > Other kinds of read/write notifications can be handled by poll/select 
> > notifications.
> 
> but poll/select notifications are just a second-degree way of doing an 
> IO state machine, and they are mostly there in kevents for completeness 
> and compatibility.

Yes, indeed.

> To be able to judge a "generic" event mechanism it really must support 
> block IO as well, natively. Without that we'd have the following obscene 
> API situation:
> 
>  - poll()/select(): supports everything but is slow and inaccurate
>  - epoll(): more modern API ontop of poll notifications
>  - async IO: supports block IO

Network AIO should not be different from block IO - it is essentially
the same mechanisms, which just have different lower layer from where
callbacks are invoked. 

>  - kevent supports almost everything /except/ block IO
> 
> so what we need is for kevents to support /all/ the important 
> high-performance event types natively:
> 
>  - networking
>  - block IO
>  - VFS namespace
>  - timers
> 
> (rarer things like mouse/input events can stay with poll notifications)
> 
> and it is /especially/ important to include block IO events in kevents 
> to be able to judge its performance and scalability relative to the 
> async IO API and infrastructure.

Yes, async IO is a significant part, and will be implemented, IMHO, new
design I highlighted in linux-fsdevel@ in AIO related thread is the way
to go (at least I will imlement it that way).

> 	Ingo

-- 
	Evgeniy Polyakov
