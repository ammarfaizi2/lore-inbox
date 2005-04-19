Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVDSBQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVDSBQP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 21:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVDSBQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 21:16:14 -0400
Received: from alt.aurema.com ([203.217.18.57]:3977 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261250AbVDSBQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 21:16:00 -0400
Date: Tue, 19 Apr 2005 10:40:23 +1000
From: Kingsley Cheung <kingsley@aurema.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
Subject: Re: Relayfs Question: Use of relay_reset().  Potential race?
Message-ID: <20050419004023.GD4846@aurema.com>
Mail-Followup-To: Tom Zanussi <zanussi@us.ibm.com>,
	Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org
References: <20050323090254.GA10630@aurema.com> <20050418012951.GC4846@aurema.com> <16995.55497.569295.838562@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16995.55497.569295.838562@tut.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 10:56:57AM -0500, Tom Zanussi wrote:
> Kingsley Cheung writes:
>  > On Wed, Mar 23, 2005 at 08:02:54PM +1100, kingsley@aurema.com wrote:
>  > > Hi 
>  > > 
>  > > I'm using relayfs to relay data from a kernel module to user space on
>  > > a SuSE 2.6.5 kernel.  I'm not absolutely sure what version of relayfs
>  > > has been back ported to it.
>  > 
>  > Hi Tom,
>  > 
>  > Could you please have a look at the following use of relay_reset() in
>  > a kernel module as follows (compiled against pre-redux relayfs):
(snip)
>  > Is that legitimate?  The reason I ask is because I've been seeing
> 
> Yes, you should be able to reset the channel here, since at that point
> it's been closed.
> 
>  > garbled oopses with keventd and I've narrowed it to two things:
>  > 
>  > 1) Inadequate locking on my part in the kernel module, which I have
>  > addressed separately.
>  > 
>  > 2) A race with relay_reset() and keventd, which is probably of
>  > interest to you if you're still maintaining the pre-redux patches.
>  > 
>  > The race is due to the use of INIT_WORK in _reset_relay():
>  > 
>  > INIT_WORK(&rchan->wake_readers, NULL, NULL);
>  > INIT_WORK(&rchan->wake_writers, NULL, NULL);
>  > 
>  > However, at the time relay_reset() is called, it is possible that
>  > these work structures are still being used by keventd when under heavy
>  > loads.  The workaround I've used to fix this is to call
>  > flush_scheduled_work() before calling reset_relay() in the kernel
>  > module.  Perhaps that needs to be called in relay_reset() or
>  > _relay_reset()?

Tom,

Thanks for the prompt response. 

> Yes, flush_scheduled_work() should probably be called from
> __relay_reset() - thanks for catching this and suggesting the fix.

My pleasure.

> BTW, I've updated the old relayfs patch with your previous fixes and
> ported it to 2.6.11 - it hasn't appeared yet on the opersys website,
> so let me know if you want it and I'll send it, or I can just send you
> a new version after I make these changes...

Ok, good to hear.  I've been using the old patch against an earlier
version of the kernel, so I've no rush for a patch against 2.6.11 -
you can take your time with these new changes :)

>  > As well I'm not sure about the uses of INIT_WORK in
>  > _relay_realloc_buffer() and relay_release() - perhaps they need
>  > attention too.  I understand, however, that flush_schedule_work()
> 
> I'll take a look at this too - looks like there might be a potential
> problem if a channel was closed while a resize was in progress.  I
> don't think anyone's ever actually used resizing, but it should be
> fixed nonetheless.
> 
> Thanks,
> 
> Tom
> 

Right.  Thanks again for looking at it.

-- 
		Kingsley
