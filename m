Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265763AbUFOQgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUFOQgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265766AbUFOQgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:36:15 -0400
Received: from fmr05.intel.com ([134.134.136.6]:20685 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265763AbUFOQgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:36:02 -0400
From: Mark Gross <mgross@linux.jf.intel.com>
Organization: Intel
To: ganzinger@mvista.com, George Anzinger <george@mvista.com>,
       Mark Gross <mgross@linux.jf.intel.com>
Subject: Re: [ANNOUNCE] high-res-timers patches for 2.6.6
Date: Tue, 15 Jun 2004 09:04:01 -0700
User-Agent: KMail/1.5.4
Cc: ganzinger@mvista.com, Arjan van de Ven <arjanv@redhat.com>,
       Geoff Levand <geoffrey.levand@am.sony.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <40C7BE29.9010600@am.sony.com> <200406141520.20971.mgross@linux.intel.com> <40CE40FC.1070404@mvista.com>
In-Reply-To: <40CE40FC.1070404@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406150904.01447.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 June 2004 17:21, George Anzinger wrote:
> Mark Gross wrote:
> > On Monday 14 June 2004 13:48, George Anzinger wrote:
> >>Mark Gross wrote:
> >>>On Friday 11 June 2004 15:33, George Anzinger wrote:
> >>>>I have been thinking of a major rewrite which would leave this code
> >>>>alone, but would introduce an additional list and, of course, overhead
> >>>>for high-res timers. This will take some time and be sub optimal, so I
> >>>>wonder if it is needed.
> >>>
> >>>What would your goal for the major rewrite be?
> >>>Redesign the implementation?
> >>>Clean up / re-factor the current design?
> >>>Add features?
> >>
> >>Mostly I would like to make it "clean" enough to get the community to
> >>accept it. As I look at the current implemtation, the biggest intrusion
> >>into the "normal" kernel is in the timer list area.  Thus, my thinking is
> >>to introduce a second or slave list which would only be used by HR
> >> timers. This list would be "checked" by putting a "normal" i.e.
> >> add_timer, timer in place to mark the jiffie that a HR timer was to
> >> expire in.  The "check" code would then set up the HR interrupt to
> >> expire the timer.
> >>
> >>I am also considering removing a lot of the ifdefs one way or another.
> >>AND, I think I can make the whole thing configureable at boot time just
> >> as the pm/TSC/etc. timers are.
> >
> > Sounds good to me.  The higher level code can use this type of clean up.
> >
> >>>I've been wondering lately if a significant restructuring of the
> >>>implementation could be done.  Something bottom's up that enabled
> >>>changing / using different time bases without rebooting and coexisted
> >>>nicely with HPET.
> >>>
> >>>Something along the lines of;
> >>>* abstracting the time base's, calibration and computation of the next
> >>>interrupt time into a polymorphic interface along with the
> >>> implementation of a few of your time bases (ACPI, TSC) as a stand
> >>> allown patch.
> >>
> >>Uh, is this something like the current TSC/ pmtimer/ HPET/ PIT selection
> >>code in the x86?  Or do you have something else in mind here.  Given the
> >>goal of integration with and inclusion in the kernel.org kernel, I don't
> >>want to wander too far from what they are doing now.
> >
> > Sort of but implemented with a dynamic binding as opposed to the current
> > compile time binding via ifdefs.
> >
> > The current HRT code implements a kind of static / compile time
> > polymorphism that is hard for me to read and keep straight.  It
> > implements N time bases, with M interrupt sources for K architectures. 
> > Implementing the binding logic between all these at compile time leads to
> > a lot of ifdefs and hard to grok code.
>
> What the 2.6 x86 timer code does is to "try" different clocks until they
> find one that "accepts" the job.  A boot time option can override this to
> force a given clock, but all are compile in.  (By the way, the first
> machine I wrote code for had a total of 8K bytes, so I really don't like to
> waste memory :))
>
> I started to do this with the latest patch but stopped when I realized that
> I would have to redo the conversion code.  Still, this isn't too hard and I
> may finish this conversion.  This would eliminate the pm/ TSC configure
> option AND allow the user to completly eliminate the HR (buy choosing a
> non-HR option at boot time), which, by the way, he can do now.
>

Eliminating the PM/TSC configure option idea sounds good to me.  Are you 
talking about the code your private codebase or the patch from SF for 2.6.5?  

The code I'm looking at can't really do this, for the various time bases.  It 
chooses between including the conversion code from hrtime-Macpi.h ^ 
htrime-M586.h at compile time.   There can be no "try" different clocks with 
this linkage to the conversion code.

get_jiffies_time macro, is statically linked to get_arch_cycles who's 
implementation id dependent on which hrtime-M*.h is included in at build 
time.  Further the interpretation of "sub_left" is a function of the same 
build time configuration setting.

Grepping on USE_APIC_TIMERS shows more of the compile time ifdef code.  It 
cannot use APIC clocks unless its compiled into the kernel there can be no 
"try" different timers WRT the APIC timer.

> >>>* implement yet another polymorphic interface for the interrupt source
> >>>used by the patch, along with a few interrupt sources (PIT, APIC, HPET
> >>><-- new ) * Implement a simple RTC-like charactor driver using the above
> >>>for testing and integration.
> >>
> >>I am not sure what wants to be done here.  I have to keep in mind that
> >> x86 is only one of many archs.  I would like to keep it as simple as
> >> possible in this area.  See the include/linux/hrtime.h file for the arch
> >> interface we are now using.
> >
> > yes but the code in the include/linux/hrtime.h file exports zero
> > abstractions to the architecture independent kernel.
> >
> > Its mostly a documentation header file, that includes the architecture
> > dependent exports, that then need to be used by the architecture
> > independent code.  Its all wrapped up in macros and what not to make it
> > work across a handful of architectures but its still a significant CTAGS
> > work out to follow the logic.
> >
> > I think that re-working the lower level HRT code to be more object based
> > (like pci and net devices for example) with a layered design would
> > significantly simplify the code and improve the extensibility across
> > architectures and platform hardware time based interrupt sources.
>
> I haven't looked at pci or net stuff lately, but my attmept to export the
> conversion_bits structure was dissed by the arch folks, so I went for just
> what was needed.  Some of them don't export a conversion to micro seconds
> conversion, for example.  I welcome more details...
>

Details...  Thats a hard thing to come by when in a high level design 
discussion.  

Its too bad the conversion_bits export got shot down.  Perhaps it was because 
you where exporting a data structure that made implicit assumptions rather 
than a more object based interface, with function pointers to conversion 
functions, and private data?

Regardless of doing an object based implementation of your design or not, if 
we could loose the #ifdefs and implicit ifdefs (i.e. IF_HIGH_RES) from the 
code (especially posix-timers.c) that would be really a good thing.

I do still like the object based design concept ;)


--mgross

