Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbVJSQEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVJSQEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 12:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbVJSQEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 12:04:12 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:48327 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1751140AbVJSQEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 12:04:11 -0400
Message-ID: <43566E79.8020903@vc.cvut.cz>
Date: Wed, 19 Oct 2005 18:04:09 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 1.6ms jitter in rtc_wakeup (Re: 2.6.14-rc4-rt1)
References: <Pine.OSF.4.05.10510190946360.22661-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10510190946360.22661-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Nielsen wrote:
> On Fri, 14 Oct 2005, Esben Nielsen wrote:
>>>>I set up rtc_wakeup and got a jitter up 1.6ms!
>>>>It came when I cd'en into a nfs-mount and typed ls.
>>>
>>>>      ls-11239 0Dn..    4us : profile_hit (__schedule)
>>>>      ls-11239 0Dn.1    4us : sched_clock (__schedule)
>>>>      ls-11239 0Dn.1    5us : check_tsc_unstable (sched_clock)
>>>>      ls-11239 0Dn.1    5us : tsc_read_c3_time (sched_clock)
>>>>   IRQ 8-775   0D..2    6us : __switch_to (__schedule)
>>>>   IRQ 8-775   0D..2    7us!: __schedule <ls-11239> (75 0)
>>>>   IRQ 8-775   0...1 1594us : trace_stop_sched_switched (__schedule)
>>>>   IRQ 8-775   0D..2 1594us : trace_stop_sched_switched <IRQ 8-775> (0 0)
>>>>   IRQ 8-775   0D..2 1595us : trace_stop_sched_switched (__schedule)
>>>
>>>ouch! This very much looks like a hardware induced latency, because the 
>>>codepath from those two __schedule points is extremely short and there 
>>>is no loop there. Have you tested this particular box before too? If 
>>>not, can you reproduce this latency with older versions of -rt too on 
>>>the same box, or is this completely new? 
>>
>>I have been testing on this box before but never with such long latencies
>>before.
> 
> 
> I could not reproduce it on linux-2.6.14-rc3-rt10. The maximum meassured
> rtc_wakeup is 146us with the same config options. 
> Running linux-2.6.14-rc4-rt1 with ethernet disabled gave a maximum latency
> of 1468us while building the kernel:

Hello,
   I've just wrote to Randy that I'm seeing same on non-RT kernel when system
uses HPET.  It makes it unusable for >512Hz, as when 1kHz timer is requested
we miss one tick and HPET interrupts stop for 5 minutes (32bit * 69.8ns).
Delay happens sometime after HPET programming - when frequency like 16kHz
is programmed, first ~6 interrupts arrive correctly, but 7th is delayed by
1 millisecond or so when compared with time on which it should arrive.

   I've found it on VIA board, so I just assumed that VIA's hardware is
strange and went back to disabling HPET.

   Maybe I should try -rt kernel sometime, but as I need working RTC interrupts
on that box for daily work, it is not simple to experiment with nohpet/hpet
options.
								Petr

