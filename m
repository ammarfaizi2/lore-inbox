Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbVJNDo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbVJNDo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 23:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbVJNDo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 23:44:56 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:44236 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932497AbVJNDoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 23:44:55 -0400
Date: Fri, 14 Oct 2005 05:45:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
Subject: Re: 1.6ms jitter in rtc_wakeup (Re: 2.6.14-rc4-rt1)
Message-ID: <20051014034513.GA6513@elte.hu>
References: <20051011111454.GA15504@elte.hu> <Pine.OSF.4.05.10510130024260.24215-200000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10510130024260.24215-200000@da410.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> I set up rtc_wakeup and got a jitter up 1.6ms!
> It came when I cd'en into a nfs-mount and typed ls.

>       ls-11239 0Dn..    4us : profile_hit (__schedule)
>       ls-11239 0Dn.1    4us : sched_clock (__schedule)
>       ls-11239 0Dn.1    5us : check_tsc_unstable (sched_clock)
>       ls-11239 0Dn.1    5us : tsc_read_c3_time (sched_clock)
>    IRQ 8-775   0D..2    6us : __switch_to (__schedule)
>    IRQ 8-775   0D..2    7us!: __schedule <ls-11239> (75 0)
>    IRQ 8-775   0...1 1594us : trace_stop_sched_switched (__schedule)
>    IRQ 8-775   0D..2 1594us : trace_stop_sched_switched <IRQ 8-775> (0 0)
>    IRQ 8-775   0D..2 1595us : trace_stop_sched_switched (__schedule)

ouch! This very much looks like a hardware induced latency, because the 
codepath from those two __schedule points is extremely short and there 
is no loop there. Have you tested this particular box before too? If 
not, can you reproduce this latency with older versions of -rt too on 
the same box, or is this completely new? Occasionally there are boxes 
that show clear signs of hardware latencies - there's little the kernel 
can do about those.

Wild shot in the dark: are there any power-saving modes enabled on the 
box? Another shot in the dark: can you trigger these latencies if the 
networking card is ifconfig down-ed? I.e. perhaps it's related to DMA 
done by the networking device. Playing with BIOS settings / DMA/PCI 
priorities might help reduce DMA related latencies ...

	Ingo
