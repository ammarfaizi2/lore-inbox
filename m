Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWFSWPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWFSWPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbWFSWPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:15:51 -0400
Received: from ns.suse.de ([195.135.220.2]:59042 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964948AbWFSWPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:15:51 -0400
Date: Mon, 19 Jun 2006 15:12:38 -0700
From: Greg KH <greg@kroah.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: statistics infrastructure (in -mm tree) review
Message-ID: <20060619221238.GA20018@kroah.com>
References: <20060613232131.GA30196@kroah.com> <20060613234739.GA30534@kroah.com> <20060613171827.73cd0688.rdunlap@xenotime.net> <4490923D.10904@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4490923D.10904@de.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 12:48:29AM +0200, Martin Peschke wrote:
> Randy.Dunlap wrote:
> >On Tue, 13 Jun 2006 16:47:39 -0700 Greg KH wrote:
> >
> >>First cut at reviewing this code.
> >>
> >>Initial impression is, "damm, that's a complex interface".  I'd really
> >>like to see some other, real-world usages of this.  Like perhaps the
> >>io-schedular statistics?  Some other /proc stats that have nothing to do
> >>with processes?
> >
> >Agreed with complexity.
> 
> Well, roughly 1500 lines of code is sort of complex, even if already
> being reviewed and cleaned up several times.
> 
> Please, let's try to break it down into design details that add
> their measure of complexity. A flat "too comlex" doesn't help on.
> 
> Could you ACK / NACK the following assumptions, so that we can
> figure out how far our (dis)agreement goes and how to continue?

Sure.

> 1) There are various kernel components that gather statistical data.
> (kernel/profile.c, network stack, genhd, memory management, taskstats,
> S390 DASD driver, zfcp driver, ...). Requirements for other statistics
> aren't unusual.

Agreed.

> 2) Basically, they all implement similar things (smp-safe and efficient
> data structures used for data gathering, implement algorithms for
> on-the-fly data preprocessing, delivery of data through some user
> interface, sometimes a switch for turning statistics on/off)

Agreed.

> 3) They all introduce their own macros / functions, resulting in code
> duplication (bad), while they usually have their unique way to show
> data to users (bad, too).

Agreed.

> 4) Possible ways to aggregate statistics data include plain counters,
> histograms, a utilisation indicator (min, max, average etc.), and
> potentially other algorithms people might come up with.

agreed.

> 5) Statistics counters should be maintained in kernel. That's cheapest.
> No bursts of zillions of incremental updates relayed to user space.
> (please see also other comment at bottom of message)

agreed.

> 6) Some library routines would suffice to take over data gathering
> and preprocessing. Avoids further code duplication, avoids bugs,
> speeds up development and test.

As long as the library functions do not cause any speed degradations,
which I think your current ones do with the pointer dereference (which
is very slow and measurable on some archs).

> 7) With regard to the delivery of statistic data to user land,
> a library maintaining statistic counters, histograms or whatever
> on behalf of exploiters doesn't need any help from the exploiter.
> We can avoid the usual callbacks and code bloat in exploiters
> this way.

I don't really understand what you are stating here.

> 8) If some library functions are responsible for showing data, and the
> exploiter is not, we can achieve a common format for statistics data.
> For example, a histogram about block I/O has the same format as
> a histogram about network I/O.
> This provides ease of use and minimises the effort of writing
> scripts that could do further processing (e.g. formatting as
> spreadsheats or bar charts, comparison and summarisation of
> statistics, ...)

Common functionality and formats would be wonderful.  But I'm not sure
you can guarantee that we really want the network io and block io
statistics in the same format, as they are fundimentally different
things.

Also, you will have to live with the existing interfaces, as we can't
break them, so porting them will not happen.

> 9) For performance reasons, per-cpu data and minimal locking
> (local_irq_save/restore) should be used.
> Adds to complexity, though.

If necessary.  Is this really necessary?

> 10) If data is per-cpu, we want to be very careful with regard to
> memory footprint. That is why, memory is only allocated for online
> cpus (requires cpu hot(un)plug handling, which adds to complexity),

Agreed.

> 11) At least for data processing modes more expensive than plain
> counters, like histograms, an on/off state makes sense.

So that userspace can tell the kernel to go faster?  I don't know why
this is really necessary :)

> 12) In order to minimise the memory footprint, a released/allocated
> state makes sense.

Again, telling userspace when to tell the kernel to free up memory can
cause problems.

> 13) Unconfigured/released/off/on states should be handled by a tiny
> state machine and a single check on statistic updates.

Ok, but you are now getting into implementation issues, like a few of
the above ones...

> 14) Kernel code delivering statistics data through library routines
> can, at best, guess whether a user wants incremental updates be
> aggregated in a single counter, a set of counters (histograms), or
> in the form of other results. Users might want to change how much
> detail is retained in aggregated statistic results.
> Adds to complexity.

Complexity where?  Userspace or in the kernel?

> 15) Nonetheless, exploiters are kindly requested to provide some
> default settings that are a good starting point for general
> purpose use.
> 
> 16) Aggregated statistic results, in many cases, don't need to be
> pushed to user space through a high-speed, high-volume interface.
> Debugfs, for example, is fine for this purpose.
> 
> 17) If the requirement for pushing data comes up anyway, we could,
> for example, add relay-entries in debugfs anytime.
> (For example, we could implement forwarding of incremental
> updates to user space. Just another conceivable data processing
> mode that fits into the current design.)
> 
> 18) The programming interface of a statistics library can be rougly as
> simple as statistic_create(), statistics_remove(), statistic_add().
> 
> 19) Statistic_add() should come in different flavours:
> statistic_add/inc() (just for convenience), and
> statistic_*_nolock() (more efficient locking for a bundle of updates)
> 
> 20) Statistic_add() takes a (X, Y) pair, with X being the main
> characteristics of the statistics (e.g. a request size) and with
> Y quantifying the update reported for a particular X (e.g. number
> of observed requests of a particular request size).
> 
> 21) Processing of (X, Y) according to abstract rules imposed by
> counters, histograms etc. doesn't require any knowledge about the
> semantics of X or Y.
> 
> 22) There might be statistic counters that exploiters want to use and
> maintain on their own, and which users still may want to have a look at
> along with other statistics. Statistic_set() fits in here nicely.


Ok, these are all implementation details.

Can you please step back a bit?  What is the requirements that you are
trying to achieve here?  A kernel-wide statistic gathering library?  If
so, why?  What has caused this to be needed?  And if it's needed, would
putting the stuff in debugfs for _all_ statistics really be a good idea
(hint, I would say no...)

> >>And what does this mean for relayfs?  Those developers tuned that code
> >>to the nth degree to get speed and other goodness, and here you go just
> >>ignoring that stuff and add yet another way to get stats out of the
> >>kernel.  Why should I use this instead of my own code with relayfs?
> >
> > Good questions.
> 
> Relayfs is a nice feature, but not appropriate here.
> 
> For example, during a performance measurements I have seen
> SCSI I/O related statistics being updated millions of times while
> I was just having a short lunch break. Some of them just increased
> a counter, which is pretty fast if done immediately in the kernel.
> If all these updates update would have to be relayed to user space
> to just increase a counter maintained in user space.. urgh, surely
> more expensive and not the way to go.
> 
> And what if user space isn't interested at all? Would we keep
> pumping zillions of unused updates into buffers instead of
> discarding them right away?

Yes, for simple counters, relayfs is overkill.  But so is an indirect
function call through a pointer for every simple counter update :)

> Profile.c, taskstats, genhd and all the other statistics listed
> above... they all maintain their counters in the kernel and
> show aggregated statistics to users.

Yes, but will you be allowed to port the existing users over to your new
framework without breaking any userspace stuff?  I don't see that
happening :(

> >>And is the need for the in-kernel parser really necessary?  I know it
> >>makes the userspace tools simpler (cat and echo), but should we be
> >>telling the kernel how to filter and adjust the data?  Shouldn't we just
> >>dump it all to userspace and use tools there to manipulate it?
> >
> >I agree again.
> 
> Assumimg we can agree on in-kernel counters, histograms etc.
> allowing for attributes being adjusted by users makes sense.
> 
> The parser stuff required for these attributes is implemented
> using match_token() & friends, which should be acceptible.
> But, I think that the standard way of using match_token() and
> strsep() needs improvement (strsep is destructive to strings
> parsed, which is painful).

Yeah, the parser isn't as bad as I originally thought it was.  But
overall, I'm still not sold on the real need for this kind of
subsystem/library.

thanks,

greg k-h
