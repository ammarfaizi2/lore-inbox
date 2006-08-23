Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965101AbWHWS4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbWHWS4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 14:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWHWS4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 14:56:51 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:27787 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750749AbWHWS4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 14:56:50 -0400
Date: Wed, 23 Aug 2006 22:56:24 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take13 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060823185624.GA8438@2ka.mipt.ru>
References: <11563322941645@2ka.mipt.ru> <Pine.LNX.4.63.0608231313370.8007@alpha.polcom.net> <20060823122509.GA5744@2ka.mipt.ru> <Pine.LNX.4.63.0608231437170.8007@alpha.polcom.net> <20060823134227.GC29056@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060823134227.GC29056@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 23 Aug 2006 22:56:31 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 05:42:30PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> On Wed, Aug 23, 2006 at 03:05:15PM +0200, Grzegorz Kulewski (kangur@polcom.net) wrote:
> > >But you've rised an interesting question, I think it is good possibility
> > >to have such timeout per-event. Let me think a little about it.
> > >
> > >It can be done even without changing size of the kevent structure - by
> > >reusing ret_data (since it is not needed to have timeout when event is
> > >ready, and if it is not and timeout has expired, we can use a flag in
> > >ret_flags). That requires per-event timer or tricky state machine
> > >though. So I would ask core developers if we need such additional
> > >functionality?
> > 
> > Well, I will not comment on implementation because I don't know it too 
> > much. But what is in my opinion essetial is that:
> > 
> > a. Date-time of timeout is not changed or reset if nothing (including 
> > timeout) happens with this file descriptor. (This is to ensure we are 
> > tracing time from last event/operation on that fd not from call to wait 
> > function.)
> > 
> > b. Timeout is Date-time not amount of (mili)seconds, so no kernel or 
> > userspace work (like decrementing) needed if nothing happens with this fd.
> 
> Please note that memory is limited in kernelspace, so Date-time should
> not be that heavy. It is possible to reuse 64bits there without major
> surgery which should be enough for number of (...)seconds, but is not 
> enough to store real date. (although we can steal yet another 32 bits
> from ret_flags and reuse fields in req_flags).
> 
> > c. Time exceeded is event so userspace does not have to check all 
> > registered events/fds for timeout on them (like it has with todays event 
> > notification mechanisms).
> 
> It's not a problem.
> 
> > And it should be easy to use too... :)
> 
> It can be discussed at the very end :)

Actually thinking some more about this issues I've come to conclusion,
that it is not required.
User can always crate two kevents - one for timer and one for rela data
processing and put crossed referencies into both, so when one of them is
ready user could remove another.

> > >>3. I had read this new patchset (especially user interface part) and as I
> > >>see the user visible part is monolithic. There is only one struct for all
> > >>types of events. Did you consider making one genral struct (with type
> > >>field, reference to some event specific struct and possibly some other
> > >>fileds) and several small event specific struct (that can be added later
> > >>as needed)? If so why did you choose the monolithic way?
> > >
> > >Right now I do not see if it has some benifits to have such extensible
> > >structures. If other developers think that it worth it, it can be
> > >implemented.
> > 
> > Well, the only benefit I can see is that when somebody will invent some 
> > completly new event type that requires something more than current struct 
> > provides it will be easy to add.
> > 
> > Also user interface (and probably documentation) could be easier. For 
> > example one event specific struct for man page and no 
> > reserved/undocumented/for-extensions-or-futher-usage fields will be 
> > needed.
> 
> It can be done by selecting special event type, which in turn will reuse
> special fields as length.
> But variable-sized members can not be put into cache and without
> knowledge of it's size it is impossible to put htem into mapped buffer.

And thinking more about this issue, I can say that I'm again
variable-sized structures - they can not be placed into ring buffer (at
least into simple one), they do not allow allocation from cache, it is
impossible to get them correctly from userspace if there is now exact
knowledge about nature of that events and a lot of other problems.
If one strongly feels that it is required, it is possible to provide
userspace pointer in the ukevent structure, which then can be read in
->enqueue callback by kernelside (there is similar trick in network
AIO).

-- 
	Evgeniy Polyakov
