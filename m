Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSLMT0u>; Fri, 13 Dec 2002 14:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbSLMT0u>; Fri, 13 Dec 2002 14:26:50 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:3571 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265339AbSLMT0t> convert rfc822-to-8bit;
	Fri, 13 Dec 2002 14:26:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Steffen Persvold <sp@scali.com>
Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
Date: Fri, 13 Dec 2002 11:32:06 -0800
User-Agent: KMail/1.4.3
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0212130644540.1053-100000@sp-laptop.isdn.scali.no>
In-Reply-To: <Pine.LNX.4.44.0212130644540.1053-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212131132.06630.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 December 2002 09:53 pm, Steffen Persvold wrote:
> On Thu, 12 Dec 2002, James Cleverdon wrote:
> > On Thursday 12 December 2002 07:26 pm, Zwane Mwaikambo wrote:
> > > On Thu, 12 Dec 2002, Nakajima, Jun wrote:
> > > > BTW, we are working on a xAPIC patch that supports more than 8 CPUs
> > > > in a generic fashion (don't use hardcode OEM checking). We already
> > > > tested it on two OEM systems with 16 CPUs.
> > > > - It uses clustered mode. We don't want to use physical mode because
> > > > it does not support lowest priority delivery mode.
> > >
> > > Wouldn't that only be for all including self? Or is the documentation
> > > incorrect?
> > >
> > > Thanks,
> > > 	Zwane
> >
> > I'm not sure I understand your question.  Lowest Priority delivery mode
> > only works with logical interrupts.  (I've tried it with physical intrs. 
> > It fails miserably.)  The "all including self" and "all excluding self"
> > destination shorthands don't do lowest priority arbitration.  They always
> > deliver the interrupt to the CPUs mentioned in the shortand.
> >
> > Lowest priority delivery mode isn't _too_ useful in Linux yet.  It would
> > be nice to preferentially target idle CPUs with interrupts in real time. 
> > That means changing each CPU's Task Priority Register (TPR) to represent
> > how busy it is.  I've got some patches to do that, but haven't posted
> > them as anything more than a RFC.
>
> Hmm, I though the APIC routing patch found in the LSE project
> (http://sourceforge.net/projects/lse/) did this already. Atleast I've
> tested this patch on a couple of Dual E7500 Xeon boxes (kernel 2.4.20) and
> it distributes interrupts nicely.
>
> However with the patch enabled, the interrupt latency on for example the
> Intel GbE 82544GC devices increased a fraction with this patch (a
> microsecond or two).
>
> Regards,

Sure, Dave Olien's patch adjusted the TPR.  However, he wrote that for the 
classic APIC; it does most of the priority adjustments in the lower nibble of 
the TPR's value.  xAPIC routing is done via HW in the PCI-to-host bridge 
chips.  There they keep a copy of each CPU's TPR value in eight XTPR 
registers for lowest priority interrupt routing -- but only the TPR's upper 
nibble.  So, Dave's patch is less useful on xAPIC systems.

I came up with something simpler.   Just 2 lines added to idle_cpu() and 
do_IRQ respectively.  It's a hack but it seemed useful.

Interesting that it would be a microsecond slower.  Maybe that's the time it 
takes to adjust the TPR.  One more reason to keep those adjustments as simple 
as possible.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

