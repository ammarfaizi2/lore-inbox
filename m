Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266113AbUFWQ0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266113AbUFWQ0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 12:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUFWQ0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 12:26:19 -0400
Received: from fmr05.intel.com ([134.134.136.6]:13775 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S266113AbUFWQXo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 12:23:44 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: Geoff Levand <geoffrey.levand@am.sony.com>, ganzinger@mvista.com
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Date: Wed, 23 Jun 2004 09:23:08 -0700
User-Agent: KMail/1.5.4
Cc: Mark Gross <mgross@linux.jf.intel.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <40C7BE29.9010600@am.sony.com> <40D76C76.7000509@mvista.com> <40D86E51.2080108@am.sony.com>
In-Reply-To: <40D86E51.2080108@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406230923.08254.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 June 2004 10:37, Geoff Levand wrote:
> George Anzinger wrote:
> > Geoff Levand wrote:
> >> Mark Gross wrote:
> >>> On Friday 11 June 2004 15:33, George Anzinger wrote:
> >>>> I have been thinking of a major rewrite which would leave this code
> >>>> alone,
> >>>> but would introduce an additional list and, of course, overhead for
> >>>> high-res timers. This will take some time and be sub optimal, so I
> >>>> wonder
> >>>> if it is needed.
> >>>
> >>> What would your goal for the major rewrite be?
> >>> Redesign the implementation?
> >>> Clean up / re-factor the current design?
> >>> Add features?
> >>>
> >>> I've been wondering lately if a significant restructuring of the
> >>> implementation could be done.  Something bottom's up that enabled
> >>> changing / using different time bases without rebooting and coexisted
> >>> nicely with HPET.
> >>>
> >>> Something along the lines of;
> >>> * abstracting the time base's, calibration and computation of the
> >>> next interrupt time into a polymorphic interface along with the
> >>> implementation of a few of your time bases (ACPI, TSC) as a stand
> >>> allown patch.
> >>> * implement yet another polymorphic interface for the interrupt
> >>> source used by the patch, along with a few interrupt sources (PIT,
> >>> APIC, HPET <-- new )
> >>> * Implement a simple RTC-like charactor driver using the above for
> >>> testing and integration.  * Finally a patch to integrate the first 3
> >>> with the POSIX timers code.
> >>>
> >>> What do you think?
> >>>
> >>>
> >>> --mgross
> >>
> >> Mark,
> >>
> >> Generally I agree with your ideas on what needs fixing up, but I'm
> >> concerned that the run-time binding of this kind of design would have
> >> too much overhead for time-critical code paths.  Do you think it is
> >> useful to have run-time selection of the time base and interrupt
> >> source?   In my work we have a known fixed hardware configuration that
> >> has limited timers, so I don't really see a need for runtime
> >> configuration there.
> >
> > Well, I don't see much added overhead, (save memory).  We already
> > dispatch interrupts via indirect function calls in irq.c.  And the core
> > clock functions (used by gettimeofday, for example) are also indirected
> > today (this to allow pm-timer, TSC, or PIT at boot time).  All we would
> > do is put both of our possibilities in the list.  The only place we add
> > overhead is in an indirect to the "proper" hardware timer for the
> > sub-jiffie interrupt.
>
> If that's the case, then Mark's proposal sounds like a good way to
> abstract the arch dependent code.  Someone mentioned to me that distro
> vendors would like the idea of runtime configuration because they could
> use a single kernel binary to support many different hardware
> configurations.  I suppose if needed some optimization can be done later.
>
> Mark, do you have time to do a first cut at the interfaces?  It seems
> you've been thinking about this, and I'd like to see your ideas.  It
> would be great if you could put together a sample hrtime.h.  If you are

I'm sorry, but I'm very much behind schedule on the ipw2200 driver and shouldn't even 
be taking the time to read LKML right now.  And likely won't for a while.

However; I was thinking of a simple structure with a few function pionters and perhaps some 
data, a pointer to arch specific private data.

struct {
	void *hrt_arch_priv; /* <-- perhaps not useful TBD */
	function pointer to time convertion function to sub_jiffies hrt_to_sub_jiffies(...);
	function pointer to get number of sub_jiffies since last jiffie hrt_sub_jiffies();
	function pointer to setting next initerrupt hrt_program_int( sub_jiffes_from_now);
	function pointer to getting current drift between system clock and hrt time base hrt_drift(...);
	function pointer to drift correction WRT system clock hrt_sync(...);
	};
It would be easiest to grock if sub_jiffies units where fixed, say nano or micro seconds.

--mgross

> short on time, I could put something together, but I think you are the
> guy to do this.
>
>  From what I've been told, Renesas did an HRT port to the SH arch on a
> recent kernel.  I'm trying to get the code so that there will be three
> arch's (i386, ppc32 & sh) to work against when doing the arch
> independent interface.
>
> Another thing that seems to be a sore point is the HRT core.  I think
> there's a good consensus that the current use of preprocessor
> conditionals makes the code pretty hairy, but what alternatives are there?
>
> If the HRT code is always compiled in, that would simplify things alot,
> but then there would always be a small performance hit in the compares,
> and a slightly bigger code size.  Is this acceptable?  Also, something
> would need to be arranged to take care of the non-supported arch's.  Any
> ideas here?
>
> Another way would be to pull out the HRT operations into separate
> functions that could be conditionally included or replaced with no-op
> versions based on a config option.  I don't know if this would be
> do-able, or if the result would be very clean though...
>
> George also mentioned an idea of a second 'timer slave list'.   Any
> other ideas here?
>
>
> -Geoff
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

