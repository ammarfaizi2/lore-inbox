Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUEVH6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUEVH6L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 03:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUEVH6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 03:58:11 -0400
Received: from colin2.muc.de ([193.149.48.15]:28174 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264900AbUEVH6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 03:58:05 -0400
Date: 22 May 2004 09:58:05 +0200
Date: Sat, 22 May 2004 09:58:05 +0200
From: Andi Kleen <ak@muc.de>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Andi Kleen <ak@muc.de>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_SLOW_TIMESTAMPS was Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
Message-ID: <20040522075805.GB10462@colin2.muc.de>
References: <1WVF1-Nn-25@gated-at.bofh.it> <1WVYp-11I-5@gated-at.bofh.it> <1WXdS-279-41@gated-at.bofh.it> <1XiBG-2sN-37@gated-at.bofh.it> <1XF55-3Ij-7@gated-at.bofh.it> <1XHzV-5OV-9@gated-at.bofh.it> <m3zn83o20n.fsf_-_@averell.firstfloor.org> <40AE7824.1080702@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40AE7824.1080702@am.sony.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2004 at 02:44:04PM -0700, Tim Bird wrote:
> Andi Kleen wrote:
> 
> >Theodore Ts'o <tytso@mit.edu> writes:
> >
> >>B) When CONFIG_FAST_TIMESTAMPS is enabled, the kernel SHALL provide
> >>the following 2 routines:
> >>
> >>     2.1 void store_timestamp(timestamp_t *t)
> >
> >
> >sched_clock() already exists and does that, although it is a bit 
> >confusingly
> >named. 
> 
> I'm not familiar with this call - I'll take a look at it.
> Does this replace get_cycles()?

Kind of.

They have slightly different requirements based on their original
callers. get_cycles was only intended for the random device and all that matters
is that its result is somewhat, umm..., random. 

sched_clock is an unsynchronized over CPUs fast clock to be used by the 
scheduler.

At least on i386 they are currently implemented with the same mechanism,
but that doesn't need to be always the case.

> You acknowledge that newer TSC implementations (and things like
> it on other platforms) now avoid this problem.  In the future,
> I think this will be less of a problem.  Hopefully the specification
> and discussions like this will help inform other semiconductor
> vendors about desired features for fast timestamp clocks in new
> chips.

That's very optimistic.

I know x86s address it slowly, but most chips around still have a variable
TSC. The only x86 that has it fixed right now AFAIK is Intel's new Prescott 
core (which is still pretty uncommon). 

For embedded CPUs I have no data.

> As I said above, the idea to decouple the timestamp retrieval from
> the conversion to normalized units came from the suggestion by
> network guys that do_gettimeofday has too much overhead for their
> packet-stamping requirements.  In their case, very often the stamps

That was probably me (if you check the original thread about this issue)
But I eventually implemented a better fix for networking - just don't 
take a timestamp unless you really need it. This better version is used
in the current code.

> are not used, and so they thought it would be nice if the conversion
> of the values into normalized units (as do_gettimeofday does) were
> a separate operation, that could be performed only as needed.

While the conversion can be a bit slow (due to the memory barriers
needed for the xtime seqlocK) the real issue is the slow external 
clock access for the timestamp on some systems. 

-Andi
