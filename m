Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTEXA5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 20:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264220AbTEXA5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 20:57:54 -0400
Received: from fmr01.intel.com ([192.55.52.18]:41434 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S264219AbTEXA5w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 20:57:52 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: userspace irq balancer
Date: Fri, 23 May 2003 18:10:57 -0700
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB56402043360@fmsmsx407.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: userspace irq balancer
Thread-Index: AcMgdymncWzQmnfITdCfHnfmx2+NegBF4D1g
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: <jamesclv@us.ibm.com>
Cc: "Gerrit Huizenga" <gh@us.ibm.com>, <haveblue@us.ibm.com>,
       <pbadari@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       <johnstul@us.ibm.com>, <mannthey@us.ibm.com>,
       "Andrew Theurer" <habanero@us.ibm.com>
X-OriginalArrivalTime: 24 May 2003 01:10:58.0716 (UTC) FILETIME=[55A1FDC0:01C32191]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, I suppose an argument could be made for setting the TPR to the vector
> number on entry of do_IRQ.  I don't think that would be a good idea.  

I agree. If we start spl-like ranking of interrupts, we need to modify disable/enable_irq(), etc. as well, causing possible impacts to device derivers.

One thing that might be helpful here is to have 4-level of priorities, for example:
Idle (0)
User (0x10)
Kernel (0x20)
Interrupt (0x30)

Jun

> -----Original Message-----
> From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> Sent: Thursday, May 22, 2003 8:30 AM
> To: William Lee Irwin III
> Cc: Gerrit Huizenga; Nakajima, Jun; haveblue@us.ibm.com;
> pbadari@us.ibm.com; linux-kernel@vger.kernel.org; johnstul@us.ibm.com;
> mannthey@us.ibm.com; Andrew Theurer
> Subject: Re: userspace irq balancer
> 
> On Thursday 22 May 2003 07:43 am, William Lee Irwin III wrote:
> > On Thu, May 22, 2003 at 07:18:06AM -0700, James Cleverdon wrote:
> > > Here's my old very stupid TPR patch .  It lacks TPRing soft ints for
> > > kernel preemption, etc.  Because the xTPR logic only compares the top
> > > nibble of the TPR and I don't want to mask out IRQs unnecessarily, it
> > > only tracks busy/idle and IRQ/no-IRQ.
> > > Simple enough for you, Bill?   8^)
> >
> > Simple enough, yes. But I hesitate to endorse it without making sure
> > it's not too simple.
> >
> > It's much closer to the right direction, which is actually following
> > hardware docs and then punting the fancy (potentially more performant)
> > bits up into userspace. When properly tuned, it should actually have a
> > useful interaction with explicit irq balancing via retargeting IO-APIC
> > RTE destinations as interrupts targeted at a destination specifying
> > multiple cpus won't always target a single cpu when TPR's are adjusted.
> >
> > The only real issue with the TPR is that it's an spl-like ranking of
> > interrupts, assuming a static prioritization based on vector number.
> > That doesn't really agree with the Linux model and is undesirable in
> > various scenarios; however, it's how the hardware works and so can't
> > be avoided (and the disastrous attempt to avoid it didn't DTRT anyway).
> >
> >
> > -- wli
> 
> Serial APICs have always had a spl-like effect built into them.  The
> effective
> TPR value of a given local APIC is:
> 	max(TPR, highest vector currently in progress) & 0xF0
> Parallel APICs don't do that because they don't have serial priority
> arbitration; instead they use the xTPRs in the bridge chips.
> 
> So, I suppose an argument could be made for setting the TPR to the vector
> number on entry of do_IRQ.  I don't think that would be a good idea.  It
> could interfere with IRQ nesting during a non-DMA IDE interrupt handler.
> And
> of course, an IRQ's vector has little to do with the IRQ itself, thanks to
> the vector hashing scheme used to avoid the (stupid) 2 latches per APIC
> level
> HW limitation of most i586 and i686 CPUs.
> 
> 
> --
> James Cleverdon
> IBM xSeries Linux Solutions
> {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
