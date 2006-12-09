Return-Path: <linux-kernel-owner+w=401wt.eu-S1759151AbWLIGH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759151AbWLIGH1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 01:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759156AbWLIGH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 01:07:27 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:23963 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759147AbWLIGH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 01:07:26 -0500
Date: Fri, 8 Dec 2006 22:07:50 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] group xtime, xtime_lock, wall_to_monotonic, avenrun,
 calc_load_count fields together in ktimed
Message-Id: <20061208220750.b953d414.randy.dunlap@oracle.com>
In-Reply-To: <20061208214625.90e010ae.akpm@osdl.org>
References: <20061206234942.79d6db01.akpm@osdl.org>
	<457849E2.3080909@garzik.org>
	<20061207095715.0cafffb9.akpm@osdl.org>
	<200612081752.09749.dada1@cosmosbay.com>
	<20061208214625.90e010ae.akpm@osdl.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 21:46:25 -0800 Andrew Morton wrote:

> On Fri, 8 Dec 2006 17:52:09 +0100
> Eric Dumazet <dada1@cosmosbay.com> wrote:

[snip]

> Sounds like you have about three patches there.
> 
> <save attachment, read from file, s/^/> />
> 
> >  
> > -extern struct timespec xtime;
> > -extern struct timespec wall_to_monotonic;
> > -extern seqlock_t xtime_lock;
> > +/*
> > + * define a structure to keep all fields close to each others.
> > + */
> > +struct ktimed_struct {
> > +	struct timespec _xtime;
> > +	struct timespec wall_to_monotonic;
> > +	seqlock_t lock;
> > +	unsigned long avenrun[3];
> > +	int calc_load_count;
> > +};
> 
> crappy name, but I guess it doesn't matter as nobody will use it at this
> stage.  But...

ktimedata would be better IMO.  somethingd looks like a daemon.

> 
> > +extern struct ktimed_struct ktimed;
> > +#define xtime             ktimed._xtime
> > +#define wall_to_monotonic ktimed.wall_to_monotonic
> > +#define xtime_lock        ktimed.lock
> > +#define avenrun           ktimed.avenrun
> 
> They'll use these instead.
> 
> Frankly, I think we'd be better off removing these macros and, longer-term,
> use
> 
> 	write_seqlock(time_data.xtime_lock);
> 
> The approach you have here would be a good transition-period thing.

[snip]

> hm, the patch seems to transform a mess into a mess.  I guess it's a messy
> problem.
> 
> I agree that aggregating all the time-related things into a struct like
> this makes some sense.  As does aggregating them all into a similar-looking
> namespace, but that'd probably be too intrusive - too late for that.

Just curious, is the change measurable (time/performance wise)?
Patch makes sense anyway.

---
~Randy
