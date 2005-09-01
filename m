Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbVIAK3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVIAK3X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 06:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVIAK3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 06:29:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23270 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964780AbVIAK3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 06:29:23 -0400
Date: Thu, 1 Sep 2005 15:58:39 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick
Message-ID: <20050901102839.GB9936@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200509010829.35958.thomas.schlichter@web.de> <20050901072303.GB9760@in.ibm.com> <200509010942.24026.thomas.schlichter@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509010942.24026.thomas.schlichter@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 09:42:23AM +0200, Thomas Schlichter wrote:
> Think about two adjacent regular timer interrupts. Now consider the first one 
> is handled very late (indeed even after the second interrupt already 
> occoured). Then will see two "lost" ticks.
> 
> Now directly the second timer interrupt handler is executed and, well it sees 
> there has _nearly_ no time passed, so no "lost" ticks are reported.

Thomas,
	In such a case, we should not increment jiffie during second interrupt 
(mainline code increments jiffie always on a timer interrupt).

Also in such a case, it is probably not a good idea to drop offset_delay.
I think we should retain it - otherwise next tick will show up as zero ticks 
lost?). There is another complication that the offset_tick recorded during 
init_pmtmr may not be aligned on jiffy boundary. Ideally we want offset_tick 
to be aligned as closely as possible to jiffy boundary. This is one of the 
reason why I added setup_pit_timer in my patch during init_pmtmr.

After all this, I think the patch you sent out and what I had
sent are fundamentally same - they rely on some constant ticks per jiffy to be
seen for lost tick calculation. I have seen this works on some machines and 
not on others. I am trying to come up with another way of calculating
lost ticks, which partially depends on some known PMTMR_TICKS_PER_JIFFY
_and_ also reads the PIT to find out how late we are in processing
the interrupt (refer delay_at_last_interrupt calculation in timer_tsc.c).

Note that if you are testing mainline kernel, probably it wont test
the lost tick calculation code as much as dynamic tick does, since
not many ticks may be lost in practice. This could be one of the reasons 
why no one has probably complained about time drift bitterly in mainline! 
I would be much happy to accept a solution which works with dynamic tick. 
For this you will need to apply the set of patches I mailed out.


P.S : I think PMTMR_TICKS_PER_JIFFY has to be calculated differently,
      since a tick is not exactly 1/HZ of a second (see definition
      of LATCH and pm_ticks_per_jiffy in my patch).

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
