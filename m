Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293027AbSCOSJW>; Fri, 15 Mar 2002 13:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293028AbSCOSJJ>; Fri, 15 Mar 2002 13:09:09 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2432 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293027AbSCOSI4>;
	Fri, 15 Mar 2002 13:08:56 -0500
Date: Fri, 15 Mar 2002 10:08:31 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: mingo@elte.hu, Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        oliend@us.ibm.com
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
Message-ID: <89210000.1016215711@flay>
In-Reply-To: <Pine.LNX.4.44.0203150834050.11415-100000@elte.hu>
In-Reply-To: <Pine.LNX.4.44.0203150834050.11415-100000@elte.hu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, March 15, 2002 08:43:38 +0100 Ingo Molnar <mingo@elte.hu> wrote:
> 
> On Thu, 14 Mar 2002, Martin Wilck wrote:
>> Btw is it correct that one could also use the APIC Task Priority
>> Registers to implement "fair" IRQ routing? (If linux adjusted them,
>> which it currently doesn't).
> 
> no. The TPR has a number of limitations, and it suffers from the same
> problem that lowest priority routing is suffering.
> 
> 1) the TRP is not really finegrained and does not match Linux's irq
> architecture, it's a rather spl-alike metric to allow irqs in below/above
> a certain level. Since Linux distributes IRQ sources in essence randomly,
> there is no point in TPR-limiting a certain half of the IRQ vector
> spectrum.

OK, there's actually two levels here, there's the stuff you're talking about
that blocks interrupts, then there's a way underneath that to affect which
CPU gets priority. You're really going to make me trawl through the Intel 
APIC docs again? Not sure what I did to deserve that level of pain ;-)
I think I can remember this, but please forgive me if I don't get it 100% right
first time.

Dave could explain this to you better than I could, but if I remember all this 
correctly what he was doing was really trying to was program the APR,
not the TPR, but the APR is a read only register ... it's affected by the way
you program the TPR. The docs are particularly opaque about how this really
works. I've had pretty much exactly this argument with Dave before, and we
thrashed out how it all worked in the process. 

What I normally look at is Section 7.5 (APIC) of Vol 3 of the PIII Intel docs.
These are very confusing in this area, and Dave had some better docs
that I'll see if I can dig out. But if you look carefully at them (and you know
how it's meant to work before you start) it makes sense in a twisted sort of
way. 

Look at the section marked "Interrupt distribution mechanisms":

Dynamic distribution assigns incoming interrupts to the lowest priority processor,
which is generally the least busy processor ... <snip> ... from all processors listed
in the destination, the processor selected is the one whose current arbitration
priority is the lowest. The latter is specified in the arbitration priority register (APR) 
... <snip> ... If more than one processor shares the lowest priority, the processor
with the highest arbitration priority (the unique value in the Arb ID register) is selected.

The last sentence is how round robin happens on an SMP P3 system. I presume
this is what fell off for the P4.

In the section "valid interrupts", they define "priority = vector / 16".

Now look at the two paragraphs defining the TPR. The first para describes pretty
much what you describe. Note that this operation would only require 4 bits.
Now look at the second para, where they define the 4 msbs as corresponding
to the interrupt priorities, and mumble something about the 4 lsbs, giving very
little real information.

Now look at the section defining the APR, and look at the wierd algorithm,
which does somewhat opaque things to derive the value of the APR from the TPR
(and some other registers). It's easy to figure out that they're coupled, it's harder
to figure out exactly how, and I can't remember exactly how this works right now.

Now read Dave's code, and see what he does ;-) Look at his notes (they're at
the same URL I gave), and amongst other things, you'll see he says:

Linux does not
assign APIC interrupt vectors below the value 0x20.  Reading specifications on
the APIC indicates that vector values 0 through 0xf are "reserved".  So,
tpr values ranging from 0x10 through 0x1f where assigned to the "idle" through
"kernel-mode executing an interrupt handler" states. 

> 2) i initially played with the TPR and it does not really solve the P4
> problem. It can be used to force irqs away from a busy CPU, but in the
> common (idle, or mostly idle) case the TPR will be equivalent across CPUs,
> resulting in the same 'ugly' IRQ inbalance that you see.

As above, you can do a little more with it. I'm not too worried about the
'ugliness' of the distribution pattern, but we should throw enough randomness
in there to help. No, it's not deterministic, and you're correct, it probably doesn't
give you good enough guarantees to solve completely what you're discussing.
 
It does seem to me like a fine idea to get the idle cpus taking the interrupts,
and those doing user work to take them in preference to those cpus doing
interrupt processing already.

I'll go look at what you were doing to acheive what seems to be similar goals.

M.

