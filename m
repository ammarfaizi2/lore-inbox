Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSIRBAh>; Tue, 17 Sep 2002 21:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264891AbSIRBAh>; Tue, 17 Sep 2002 21:00:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:15358 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264888AbSIRBAf> convert rfc822-to-8bit;
	Tue, 17 Sep 2002 21:00:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
Date: Tue, 17 Sep 2002 18:04:33 -0700
User-Agent: KMail/1.4.1
Cc: ak@suse.de, johnstul@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, anton.wilson@camotion.com
References: <20020918015209.B31263@wotan.suse.de> <20020917.165131.81918297.davem@redhat.com> <20020918020535.A9784@wotan.suse.de>
In-Reply-To: <20020918020535.A9784@wotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209171804.33391.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 September 2002 05:05 pm, Andi Kleen wrote:
> On Tue, Sep 17, 2002 at 04:51:31PM -0700, David S. Miller wrote:
> >    From: Andi Kleen <ak@suse.de>
> >    Date: Wed, 18 Sep 2002 01:58:38 +0200
> >
> >    The local APIC timer is specified in the Intel Manual volume 3 for
> > example. It's an optional feature (CPUID), but pretty much everyone has
> > it.
> >
> > It is internal or external to the processor?  Ie. can it be in the
> > southbridge or something?  If yes, then I still hold my point.
>
> Local Apic is in the cpu.
>
> -Andi

I believe you gents are going off at a tangent.  Intel's current P4 manual 
says the local APIC timer is driven by the "bus clock".  For serial APICs 
that was doubtless the APIC serial bus clock, which almost always was derived 
from the system clock.  For P4 systems with the xAPIC in parallel mode, the 
only one available is the system bus.

If a multi-node system doesn't have synchronized bus clocks, it doesn't matter 
which one you use.  The time bases will drift relative to each other.

It's even worse when the "Frequency Spreading" BIOS option is turned on.  
Then, the bus clocks are deliberately offset by as much as half a megahertz 
(doubtless to pass FCC or equivalent emission certifications).

I don't know what Sun does with the Ultra SPARC 3's time counter.  Maybe they 
have a separate clock input for it that runs at 1 MHz so skew and 
distribution is no problem.  That's fine for Sun; they build their own CPUs 
and can put in whatever they want.  The rest of us have to work with what we 
get from the different manufacturers.  And, just about all of them use a 
value derived from the bus clock -- which might have drift in a multi-node 
system.

That's where a better abstraction of the timer hardware would come in handy.  
It would use the PIT or TSC for 99% of boxes, and switch to special code for 
the weird ones.

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

