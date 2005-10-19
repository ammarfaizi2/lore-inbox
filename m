Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVJSP4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVJSP4V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 11:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVJSP4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 11:56:21 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:27799 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751125AbVJSP4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 11:56:21 -0400
Message-ID: <43566CA2.4090002@vc.cvut.cz>
Date: Wed, 19 Oct 2005 17:56:18 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Clemens Ladisch <clemens@ladisch.de>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] more HPET fixes and enhancements
References: <Pine.HPX.4.33n.0510191540170.2146-100000@studcom.urz.uni-halle.de>
In-Reply-To: <Pine.HPX.4.33n.0510191540170.2146-100000@studcom.urz.uni-halle.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Ladisch wrote:
> Petr Vandrovec wrote:
> 
>>Clemens Ladisch wrote:
>>
>>>However, I've patched my kernel to initialize the HPET manually
>>>because my BIOS doesn't bother to do it at all.  A quick Google search
>>>shows that in most cases where the BIOS _does_ bother, the third timer
>>>(which is the only free one after system timer and RTC have grabbed
>>>theirs) didn't get initialized and is still set to interrupt 0 (which
>>>isn't actually supported by most HPET hardware).
>>>
>>>This means that hpet.c must initialize the interrupt routing register
>>>in this case.  I'll write a patch for this.
>>
>>I'm using attached diff.
> 
> 
> The other changes of your patch are already in the -mm kernel.
> 
> 
>>But I gave up on HPET.  On VIA periodic mode is hopelessly broken,
> 
> 
> I've heard it works with timer 0, and the capability bit on timer 1 is
> just wrong.

Nope.  Periodic mode works (I've made my tests on timer #2), you can just
set only period (through way which sets value according to the spec), and
you cannot set current value (at least I do not know how).  So I can
program VIA hardware to generate periodic interrupt, there is just
unavoidable delay up to 5 minutes. I've worked around by setting period
to 1 tick, so in 5 minutes value and main timer synchronize, and if
timer is not stopped after that then it stays synchronized with main timer.

>>And fixing this would add at least 1.5us to the interrupt handler,
>>and it seems quite lot to me...
> 
> 
> I didn't measure how much reading the RTC registers costs us, but
> those aren't likely to be faster.
> 
> I'm thinking of a different approach:  Assuming that such a big delay
> almost never actually does happen, we run a separate watchdog timer
> (using a kernel timer that is guaranteed to work) at a much lower
> frequency to check whether the real timer got stuck.  This trades off
> the HPET register read against the timer_list overhead (and that we
> still lose _some_ interrupts when the worst case happens).

It would work for VMware's use of /dev/rtc if number of missed interrupts
will be reported on next read.  Otherwise it might be a problem for
keeping time between host and virtual machines in sync.
								Petr

