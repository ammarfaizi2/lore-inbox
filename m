Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318917AbSHSOQc>; Mon, 19 Aug 2002 10:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318918AbSHSOQc>; Mon, 19 Aug 2002 10:16:32 -0400
Received: from webmail27.rediffmail.com ([203.199.83.37]:4830 "HELO
	webmail27.rediffmail.com") by vger.kernel.org with SMTP
	id <S318917AbSHSOQa>; Mon, 19 Aug 2002 10:16:30 -0400
Date: 19 Aug 2002 14:19:16 -0000
Message-ID: <20020819141916.15289.qmail@webmail27.rediffmail.com>
MIME-Version: 1.0
From: "ashwani kumar mehra" <ashwani_mehra@rediffmail.com>
Reply-To: "ashwani kumar mehra" <ashwani_mehra@rediffmail.com>
To: linux-kernel@vger.kernel.org
Subject: CBQ implementation issues on linux
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm currently looking at various CBQ implementation issues and 
have been comparing the ALTQ and the Linux approach in this 
regard. However I've been unable to fathom out as to how does 
Linux exactly address some of the CBQ requirements.

I've gone through the relevant portions of the code 
(sch_cbq.c;sch_generic.c;pkt_*.c, etc.) My current understanding 
is that the packet scheduler is invoked :

i) during packet enqueue (in 
dev_queue_xmit->queue_run->queue_restart
ii) on expiry of CBQ watchdog timers (thru raising a software 
interrupt from __netif_schedule in include/linux/netdevice.h).
iii) A late 1999 doc that i found on the web says the  dequeue 
code is also invoked via qdisc_run_queues (in sch_generic.c), thru 
a bottom half handler(net_bh). but am unable to locate it in the 
2.4.18 code. am i missing something obvious or has the same been 
reimplemented using tasklets/soft interrupts? maybe a call to 
qdisc_restart?

There are two issues
1. buffering at driver level: large buffering at driver level may 
negate the effect of the scheduler by delaying higher priority 
packets. ALTQ uses a token bucket regulator after the scheduler to 
counter this problem. however i've been unable to find something 
similar or any comment on this issue with regards to linux.

2. timer granularity issues: a driver will only interrupt after 
its buffer gets emptied. however the scheduler may be invoked in 
between by trigerring it on events like packet enqueue, expiry of 
watchdog timers, etc. In case of timer expiry events, the timer 
granularity remains 10 ms, so wont this lead to a bursty dequeue 
on the next timer tick?

Please CC any replies.

Thanx in advance
Ashwani
India
__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/

