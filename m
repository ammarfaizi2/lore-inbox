Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTEVPSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 11:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbTEVPSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 11:18:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60600 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261928AbTEVPSC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 11:18:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: userspace irq balancer
Date: Thu, 22 May 2003 08:30:29 -0700
User-Agent: KMail/1.4.3
Cc: Gerrit Huizenga <gh@us.ibm.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       haveblue@us.ibm.com, pbadari@us.ibm.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, mannthey@us.ibm.com,
       Andrew Theurer <habanero@us.ibm.com>
References: <3014AAAC8E0930438FD38EBF6DCEB5640204334F@fmsmsx407.fm.intel.com> <200305220718.06982.jamesclv@us.ibm.com> <20030522144306.GQ8978@holomorphy.com>
In-Reply-To: <20030522144306.GQ8978@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200305220830.29592.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 May 2003 07:43 am, William Lee Irwin III wrote:
> On Thu, May 22, 2003 at 07:18:06AM -0700, James Cleverdon wrote:
> > Here's my old very stupid TPR patch .  It lacks TPRing soft ints for
> > kernel preemption, etc.  Because the xTPR logic only compares the top
> > nibble of the TPR and I don't want to mask out IRQs unnecessarily, it
> > only tracks busy/idle and IRQ/no-IRQ.
> > Simple enough for you, Bill?   8^)
>
> Simple enough, yes. But I hesitate to endorse it without making sure
> it's not too simple.
>
> It's much closer to the right direction, which is actually following
> hardware docs and then punting the fancy (potentially more performant)
> bits up into userspace. When properly tuned, it should actually have a
> useful interaction with explicit irq balancing via retargeting IO-APIC
> RTE destinations as interrupts targeted at a destination specifying
> multiple cpus won't always target a single cpu when TPR's are adjusted.
>
> The only real issue with the TPR is that it's an spl-like ranking of
> interrupts, assuming a static prioritization based on vector number.
> That doesn't really agree with the Linux model and is undesirable in
> various scenarios; however, it's how the hardware works and so can't
> be avoided (and the disastrous attempt to avoid it didn't DTRT anyway).
>
>
> -- wli

Serial APICs have always had a spl-like effect built into them.  The effective 
TPR value of a given local APIC is:
	max(TPR, highest vector currently in progress) & 0xF0
Parallel APICs don't do that because they don't have serial priority 
arbitration; instead they use the xTPRs in the bridge chips.

So, I suppose an argument could be made for setting the TPR to the vector 
number on entry of do_IRQ.  I don't think that would be a good idea.  It 
could interfere with IRQ nesting during a non-DMA IDE interrupt handler.  And 
of course, an IRQ's vector has little to do with the IRQ itself, thanks to 
the vector hashing scheme used to avoid the (stupid) 2 latches per APIC level 
HW limitation of most i586 and i686 CPUs.


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

