Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVAUS2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVAUS2t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVAUS2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:28:49 -0500
Received: from fsmlabs.com ([168.103.115.128]:12468 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262449AbVAUS2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:28:18 -0500
Date: Fri, 21 Jan 2005 11:27:09 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Tony Lindgren <tony@atomide.com>
cc: Pavel Machek <pavel@ucw.cz>, George Anzinger <george@mvista.com>,
       john stultz <johnstul@us.ibm.com>, Andrea Arcangeli <andrea@suse.de>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
In-Reply-To: <20050121174831.GE14554@atomide.com>
Message-ID: <Pine.LNX.4.61.0501211123260.18199@montezuma.fsmlabs.com>
References: <20050119000556.GB14749@atomide.com>
 <Pine.LNX.4.61.0501192100060.3010@montezuma.fsmlabs.com>
 <20050121174831.GE14554@atomide.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005, Tony Lindgren wrote:

> > This doesn't seem to cover the local APIC timer, what do you do about the 
> > 1kHz tick which it's programmed to do?
> 
> Sorry for the delay in replaying. Thanks for pointing that out, I
> don't know yet what to do with the local APIC timer. Have to look at
> more.

Pavel does your test system have a Local APIC? If so that may also explain 
why you didn't see a difference.

Tony, something like the following for oneshot should work, untested of 
course. Perhaps you could use that for the wakeup interrupt instead?

void setup_oneshot_apic_timer(unsigned int count)
{
	unsigned int lvtt, tmp_value;
	unsigned long flags;

	count *= calibration_result;
	local_irq_save(flags);
	lvtt = ~APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
	apic_write_around(APIC_LVTT, lvtt);
	tmp_value = apic_read(APIC_TDCR);
	apic_write_around(APIC_TDCR, (tmp_value
			& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
			| APIC_TDR_DIV_16);

	apic_write_around(APIC_TMICT, count/APIC_DIVISOR);
	local_irq_restore(flags);
}
