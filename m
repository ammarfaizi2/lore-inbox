Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUKPILG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUKPILG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 03:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbUKPILG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 03:11:06 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:36083 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S261932AbUKPIK6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 03:10:58 -0500
Message-ID: <4199B60D.9040101@mvista.com>
Date: Tue, 16 Nov 2004 00:10:53 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>
CC: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_X86_PM_TIMER is slow
References: <Pine.LNX.4.61.0411112143200.1846@twinlark.arctic.org> <20041112060413.GF783@alpha.home.local> <Pine.LNX.4.61.0411112208180.24919@twinlark.arctic.org> <20041112070611.GA12474@alpha.home.local> <Pine.LNX.4.61.0411112339100.24919@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.61.0411112339100.24919@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dean gaudet wrote:
> On Fri, 12 Nov 2004, Willy Tarreau wrote:
> 
> 
>>>        /* It has been reported that because of various broken
>>>         * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
>>>         * source is not latched, so you must read it multiple
>>>         * times to insure a safe value is read.
>>>         */
>>>        do {
>>>                v1 = inl(pmtmr_ioport);
>>>                v2 = inl(pmtmr_ioport);
>>>                v3 = inl(pmtmr_ioport);
>>>        } while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
>>>                        || (v3 > v1 && v3 < v2));
>>
>>Just a thought : have you tried to check whether it's the recovery time
>>after a read or read itself which takes time ?
> 
> 
> each read is ~0.8us ... the loop only runs once.
> 
> 
>>I mean, perhaps one read
>>would take, say 50 ns, but two back-to-back reads will take 2 us. If
>>this is the case, having a separate function with only one read for
>>non-broken chipsets will be better because there might be no particular
>>reasons to check the counter that often.
> 
> 
> yeah for the few chipsets i've looked at i haven't seen the problem the 
> loop is defending against yet.  or the problem is pretty rare.

I contend that the problem can be defended against with only one read the 
majority of the time.  A bit of logic is needed to see if the read is within 
reason and, only when not, an additional read is needed.  For example, the 
following is the pm_timer read in the HRT patch.

quick_get_cpuctr(void)
{
	static  unsigned long last_read = 0;
	static  int qgc_max = 0;
	int i;

	unsigned long rd_delta, rd_ans, rd = inl(acpi_pm_tmr_address);

	/*
	 * This will be REALLY big if ever we move backward in time...
	 */
	rd_delta = (rd - last_read) & SIZE_MASK;
	last_read = rd;

	rd_ans =  (rd - last_update) & SIZE_MASK;

	if (likely((rd_ans < (arch_cycles_per_jiffy << 1)) &&
		   (rd_delta < (arch_cycles_per_jiffy << 1))))
		return rd_ans;

	for (i = 0; i < 10; i++) {
		rd = inl(acpi_pm_tmr_address);
		rd_delta = (rd - last_read) & SIZE_MASK;
		last_read = rd;
		if (unlikely(i > qgc_max))
			qgc_max = i;
		/*
		 * On my test machine (800MHZ dual PIII) this is always
		 * seven.  Seems long, but we will give it some slack...
		 * We note that rd_delta (and all the vars) unsigned so
		 * a backward movement will show as a really big number.
		 */
		if (likely(rd_delta < 20))
			return (rd - last_update) & SIZE_MASK;
	}
	return (rd - last_update) & SIZE_MASK;
}
> 
> 
>>Other thought : is it possible to memory-map this timer to avoid the slow
>>inl() on x86 ?

I suspect not.  The problem is that the timer is in I/O land and the cpu and I/O 
clocks need to sync to to the transfer and that is the cause of the delay.
~
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

