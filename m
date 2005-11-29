Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVK2XCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVK2XCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 18:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbVK2XCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 18:02:41 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:27119 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964800AbVK2XCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 18:02:41 -0500
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
From: Nicholas Miell <nmiell@comcast.net>
To: Andi Kleen <ak@suse.de>
Cc: Stephane Eranian <eranian@hpl.hp.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
In-Reply-To: <20051129224346.GS19515@wotan.suse.de>
References: <20051129151515.GG19515@wotan.suse.de>
	 <200511291056.32455.raybry@mpdtxmail.amd.com>
	 <20051129180903.GB6611@frankl.hpl.hp.com>
	 <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy>
	 <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy>
	 <20051129224346.GS19515@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 15:02:18 -0800
Message-Id: <1133305338.3271.30.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 23:43 +0100, Andi Kleen wrote:
> > I think you really need to come up with a better justification than "I
> > think this will be useful" for a permanent user-space ABI change.
> 
> There's no user space ABI change involved, at least not from
> the kernel side. Hardware is breaking some assumptions people
> made though (they actually never worked fully, but these days they
> break more clearly) and this is a best effort to adapt.

Yes there is, you're allowing userspace usage of RDPMC and you're
guaranteeing that PMC0 will always be a cycle counter. The RDPMC usage
is benign (assuming you make a note somewhere that future versions of
Linux might disable both RDPMC and RDTSC(P) to prevent timing-channel
attacks), but that "PMC0 is a cycle counter" guarantee will probably
come back to haunt you.

> To give an bad analogy RDTSC usage in the last years is
> like explicit spinning wait loops for delays in the earlier
> times. They tended to work on some subset of computers,
> but were always bad and caused problems and people eventually learned
> it was better to use operating system services for this.

And you are now suggesting people should use RDPMC instead of OS
services?

> The kernel will probably not disable RDTSC outright,
> but will make it clear in documentation that it's a bad
> idea to use directly and laugh at everybody who runs
> into problems with it.
> 
> oprofile usage might change slightly though, although only
> for a small subset of its users. There can't be very many
> of them using multiple performance counters anyways because
> at least in the last 0.9 release I tried it didn't even work.
> 
> > What problem are you trying to solve, why is that a problem, how does
> > making PMC0 always be a cycle counter solve that, what makes you think
> 
> Read the original messages in the thread. They explain it all.
> 
> > that future CPUs will have the same type of cycle counter that behaves
> > the same way as the current cycle counters, etc.
> > 
> > AFAICT, the problem you're trying to solve is two-fold:
> > 
> > a) RDTSC is serializing and RDPMC isn't.
> > 
> > Which is nicely solved by RDTSCP.
> 
> No, you got that totally wrong. Please read the RDTSCP specification again.

Whoops, thanks.

> > and
> > b) RDTSC isn't well defined.
> 
> It's well defined - but in a way that makes it useless for cycle
> measurements these days.
> 
> > 
> > Well, RDPMC isn't defined at all. You're assuming that future processor
> > revisions will have the same or substantially similar PerfCtrs as
> > current processors, and nothing guarantees that at all.
> 
> Point, but i guess it is reasonable to assume that future x85 CPUs
> will have cycle counter perfctrs.  I cannot imagine anybody dropping
> such a basic facility.

I don't think that's a reasonable assumption at all.

The definition of all these performance events for the Opteron is hidden
away in a very terse chart in the BIOS/Kernel manual.

That chart contains incompatible variations for pre-B, B, and C revision
processors and (among other strange things) includes instructions for
the monitoring of segment register loads to the HS register.

Everything is telling me that this is not something AMD intends to keep
stable and it isn't even something they're interested in documenting
very well at all.

My problem with this is basically that you are abusing something not
intended as a RDTSC-like interface to replace RDTSC, you're using a
scarce resource that could probably be put to better use to do it,
there's no guarantee that this abuse will continue to work in future
processor revisions, and this is a userspace-visible ABI change that
will have to be maintained indefinitely.

-- 
Nicholas Miell <nmiell@comcast.net>

