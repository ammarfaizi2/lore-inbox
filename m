Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVAUU2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVAUU2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVAUU2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:28:41 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14590 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262476AbVAUUZ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:25:58 -0500
Message-ID: <41F16551.6090706@mvista.com>
Date: Fri, 21 Jan 2005 12:25:53 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
CC: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
References: <20050119000556.GB14749@atomide.com> <Pine.LNX.4.61.0501192100060.3010@montezuma.fsmlabs.com> <20050121174831.GE14554@atomide.com> <Pine.LNX.4.61.0501211123260.18199@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0501211123260.18199@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Fri, 21 Jan 2005, Tony Lindgren wrote:
> 
> 
>>>This doesn't seem to cover the local APIC timer, what do you do about the 
>>>1kHz tick which it's programmed to do?
>>
>>Sorry for the delay in replaying. Thanks for pointing that out, I
>>don't know yet what to do with the local APIC timer. Have to look at
>>more.
> 
> 
> Pavel does your test system have a Local APIC? If so that may also explain 
> why you didn't see a difference.
> 
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

The VST patch on sourceforge (http://sourceforge.net/projects/high-res-timers/) 
uses the local apic timer to do the wake up.  This is the same timer that is 
used for the High Res work.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

