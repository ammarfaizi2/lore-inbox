Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbVAUSif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbVAUSif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbVAUSif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:38:35 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:15503 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262450AbVAUSic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:38:32 -0500
Date: Fri, 21 Jan 2005 10:38:09 -0800
From: Tony Lindgren <tony@atomide.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050121183808.GI14554@atomide.com>
References: <20050119000556.GB14749@atomide.com> <Pine.LNX.4.61.0501192100060.3010@montezuma.fsmlabs.com> <20050121174831.GE14554@atomide.com> <Pine.LNX.4.61.0501211123260.18199@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501211123260.18199@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo <zwane@arm.linux.org.uk> [050121 10:27]:
> On Fri, 21 Jan 2005, Tony Lindgren wrote:
> 
> > > This doesn't seem to cover the local APIC timer, what do you do about the 
> > > 1kHz tick which it's programmed to do?
> > 
> > Sorry for the delay in replaying. Thanks for pointing that out, I
> > don't know yet what to do with the local APIC timer. Have to look at
> > more.
> 
> Pavel does your test system have a Local APIC? If so that may also explain 
> why you didn't see a difference.

Yeah, that could explain why sleep mode seems to wake up too early.

> Tony, something like the following for oneshot should work, untested of 
> course. Perhaps you could use that for the wakeup interrupt instead?
> 
> void setup_oneshot_apic_timer(unsigned int count)
> {
> 	unsigned int lvtt, tmp_value;
> 	unsigned long flags;
> 
> 	count *= calibration_result;
> 	local_irq_save(flags);
> 	lvtt = ~APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
> 	apic_write_around(APIC_LVTT, lvtt);
> 	tmp_value = apic_read(APIC_TDCR);
> 	apic_write_around(APIC_TDCR, (tmp_value
> 			& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
> 			| APIC_TDR_DIV_16);
> 
> 	apic_write_around(APIC_TMICT, count/APIC_DIVISOR);
> 	local_irq_restore(flags);
> }
> 

Thanks, I'll try it out! As George also pointed out, we should use apic 
timer if available. Else we can fall back on use PIT.

Tony
