Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbWCAAv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWCAAv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWCAAv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:51:28 -0500
Received: from mailhost.NMT.EDU ([129.138.4.52]:50101 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id S932699AbWCAAv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:51:28 -0500
Date: Tue, 28 Feb 2006 17:51:22 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/3] prefetch the mmap_sem in the fault path
Message-ID: <20060301005120.GB32219@rainbow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the broken threading...

On Thursday 23 February 2006 11:13:50 EST, Ray Bryant wrote:
> On Thursday 23 February 2006 06:39, Arjan van de Ven wrote:
> > On Thu, 2006-02-23 at 07:29 -0500, Jes Sorensen wrote:
> > > >>>>> "Arjan" == Arjan van de Ven <arjan@xxxxxxxxxxxxxxx> writes:
> > >
> > > Arjan> In a micro-benchmark that stresses the pagefault path, the
> > > Arjan> down_read_trylock on the mmap_sem showed up quite high on the
> > > Arjan> profile. Turns out this lock is bouncing between cpus quite a
> > > Arjan> bit and thus is cache-cold a lot. This patch prefetches the
> > > Arjan> lock (for write) as early as possible (and before some other
> > > Arjan> somewhat expensive operations). With this patch, the
> > > Arjan> down_read_trylock basically fell out of the top of profile.
> > >
> > > Out of curiousity, how big was the box used for testing? It might be
> > > worth investigating if anything can be done to reduce the number of
> > > times that lock is taken in the first place.
> > >
> > > After all, what's a pain on a 4-way tends to be an utter nightmare on
> > > a 16-way ;(
> >
> > most of it was done on a 2 way, but some tests were done on a 4-way.
> 
> Could you share your microbenchmark with us (or point to the source) and we
> can give this a try on larger systems?

I would be ecstatic to share this benchmark; however I just started
working at Intel and did not realize how long it would take to open
source a program written solely by an Intel employee (me).  I'm
getting the paperwork done as fast as I can.

A quick description of the benchmark is:

* Allocate memory
* Write a pattern to it
* Spawn sufficient threads to keep your cpus busy

Each thread does:

* Allocate a little more memory and copy part of memory to it
* Search for a key within its copy
* Free the memory
* Repeat

The patches Arjan submitted make a small improvement, but the big win
turns out to be in tuning malloc() parameters, which we are currently
experimenting with.

-VAL (not subscribed to l-k as yet)
