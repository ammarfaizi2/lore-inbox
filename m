Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934957AbWKXQOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934957AbWKXQOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 11:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934956AbWKXQOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 11:14:53 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:50328 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S934505AbWKXQOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 11:14:52 -0500
Date: Fri, 24 Nov 2006 19:14:06 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 1/6] kevent: Description.
Message-ID: <20061124161406.GA5054@2ka.mipt.ru>
References: <11641265982190@2ka.mipt.ru> <4564E162.8040901@redhat.com> <20061123115240.GA20294@2ka.mipt.ru> <4565FA60.9000402@redhat.com> <20061124110143.GF13600@2ka.mipt.ru> <456718A3.1070108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456718A3.1070108@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 24 Nov 2006 19:14:07 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2006 at 08:06:59AM -0800, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >>I know this is how it's done now.  But it is not where it has to end. 
> >>IMO we have to get to a solution where new events are posted to the ring 
> >>buffer asynchronously, i.e., without a thread calling kevent_wait.  And 
> >>then you need the extra parameter and verification.  Even if it's today 
> >>not needed we have to future-proof the interface since it cannot be 
> >>changed once in use.
> >
> >There is a special flag in kevent_user to wake it if there are no ready
> >events - kernel thread which has added new events will set it and thus
> >subsequent kevent_wait() will return with updated indexes - userspace
> >must check indexes after kevent_wait().
> 
> You misunderstand.  I don't want to return without waiting unconditionally.
> 
> There is a race which has to be closed.  It's exactly the same as in the 
> futex syscall.  I've shown the interaction between the kernel and the 
> thread in the previous mail.  There is inevitably a time difference 
> between the thread checking whether the ring buffer is empty and the 
> kernel putting the thread to sleep in the kevent_wait call.
> 
> This is no problem with the current kevent_wait implementation since the 
> ring buffer is not filled asynchronously.  But if/when it will be the 
> kernel might add something to the ring buffer _after_ the thread checks 
> for an empty ring buffer and _before_ it enters the kernel in the 
> kevent_wait syscall.
> 
> The kevent_wait syscall will only wake the thread when a new event is 
> posted.  We do not in general want it to be woken when the ring buffer 
> is non empty.  This would create far too many unnecessary wakeups it 
> there is more than one thread working on the queue.
> 
> With the addition parameters for kevent_wait indicating when the calling 
> thread last checked the ring buffer the kernel can find out whether the 
> decision to call kevent_wait was made based on outdated information or 
> not.  Outdated in the case a new event has been posted.  In this case 
> the thread is not put to sleep but instead returns.

Read my mail again.

If kernel has put data asynchronously it will setup special flag, thus 
kevent_wait() will not sleep and will return, so thread will check new
entries and process them.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
