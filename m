Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288117AbSAHPbb>; Tue, 8 Jan 2002 10:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288113AbSAHPbV>; Tue, 8 Jan 2002 10:31:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31008 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287976AbSAHPbL>; Tue, 8 Jan 2002 10:31:11 -0500
Date: Tue, 8 Jan 2002 16:29:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Anton Blanchard <anton@samba.org>, Luigi Genoni <kernel@Expansa.sns.it>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Message-ID: <20020108162930.E1894@inspiron.school.suse.de>
In-Reply-To: <20020108030420Z287595-13997+1799@vger.kernel.org> <20020108142117.F3221@inspiron.school.suse.de> <20020108133335.GB26307@krispykreme> <E16Nxjg-00009W-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16Nxjg-00009W-00@starship.berlin>; from phillips@bonn-fries.net on Tue, Jan 08, 2002 at 04:00:11PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 04:00:11PM +0100, Daniel Phillips wrote:
> On January 8, 2002 02:33 pm, Anton Blanchard wrote:
> > Andrea Arcangeli [apparently] wrote:
> > > So yes, mean latency will decrease with preemptive kernel, but your CPU
> > > is definitely paying something for it.
> > 
> > And Andrew Morton's work suggests he can do a much better job of
> > reducing latency than -preempt.
> 
> That's not a particularly clueful comment, Anton.  Obviously, any 
> latency-busting hacks that Andrew does could also be patched into a
> -preempt kernel.
> 
> What a preemptible kernel can do that a non-preemptible kernel can't is: 
> reschedule exactly as often as necessary, instead of having lots of extra 
> schedule points inserted all over the place, firing when *they* think the 
> time is right, which may well be earlier than necessary.

"extra schedule points all over the place", that's the -preempt kernel
not the lowlatency kernel! (on yeah, you don't see them in the source
but ask your CPU if it sees them)

> The preemptible approach is much less of a maintainance headache, since 
> people don't have to be constantly doing audits to see if something changed, 
> and going in to fiddle with scheduling points.

this yes, it requires less maintainance, but still you should keep in
mind the details about the spinlocks, things like the checks the VM does
in shrink_cache are needed also with preemptive kernel.

> Finally, with preemption, rescheduling can be forced with essentially zero 
> latency in response to an arbitrary interrupt such as IO completion, whereas 
> the non-preemptive kernel will have to 'coast to a stop'.  In other words, 
> the non-preemptive kernel will have little lags between successive IOs, 
> whereas the preemptive kernel can submit the next IO immediately.  So there 
> are bound to be loads where the preemptive kernel turns in better latency 
> *and throughput* than the scheduling point hack.

The I/O pipeline is big enough that a few msec before or later in a
submit_bh shouldn't make a difference, the batch logic in the
ll_rw_block layer also try to reduce the reschedule, and last but not
the least if the task is I/O bound preemptive kernel or not won't make
any difference in the submit_bh latency because no task is eating cpu
and latency will be the one of pure schedule call.

> Mind you, I'm not devaluing Andrew's work, it's good and valuable.  However 
> it's good to be aware of why that approach can't equal the latency-busting 
> performance of the preemptive approach.

I also don't want to devaluate the preemptive kernel approch (the mean
latency it can reach is lower than the one of the lowlat kernel, however
I personally care only about worst case latency and this is why I don't
feel the need of -preempt), but I just wanted to make clear that the
idea that is floating around that preemptive kernel is all goodness is
very far from reality, you get very low mean latency but at a price.

Andrea
