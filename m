Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268794AbTBZPUW>; Wed, 26 Feb 2003 10:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268795AbTBZPUW>; Wed, 26 Feb 2003 10:20:22 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:2053 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S268794AbTBZPUU> convert rfc822-to-8bit; Wed, 26 Feb 2003 10:20:20 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: lockups with 2.4.20 (tg3? net/core/dev.c|deliver_to_old_ones)
Date: Wed, 26 Feb 2003 09:29:56 -0600
Message-ID: <DC900CF28D03B745B2859A0E084F044D043506DD@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: lockups with 2.4.20 (tg3? net/core/dev.c|deliver_to_old_ones)
Thread-Index: AcLdZJaw1xsXJsVxQMKlzJ0tWdnVgQARM0GA
From: "Rhodes, Tom" <tom.rhodes@hp.com>
To: <jbourne@mtroyal.ab.ca>, <zaitcev@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Feb 2003 15:30:03.0299 (UTC) FILETIME=[EEA8EF30:01C2DDAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> Since sometime in December two systems we have on site using P4 HT
> (one
> >> Dell 2650 and one Dell 4600, both dual CPU, both ht/mce capable)
have
> been
> >> locking up without any kernel output and without sysrq keys working
> (the
> >> keyboard is locked solid).
> >>[...]
> >> Using nmi_watchdog I've managed to get a stack track and ran
ksymoops
> over
> >> it (attached).
> 
> 
> > Good report. To tell the truth, I know that this lockup exists,
> > there's an RH issue-tracker item against me on this.
> 
> Several of us at HP have been chasing this problem as well. Here is
why
> there is a deadlock: deliver_to_old_ones()attempts to stop all timers
> from running and then blocks until all the timers are no longer
running.
> This code is called from netif_receive_skb which is called from
tg3_poll
> while it is holding a lock in the tg3 driver. On another CPU, the
> tg3_timer routine is run but is blocked by the lock held in the
tg3_poll
> routine. The tg3_timer routine never finishes because it can't acquire
> the lock being held by tg3_poll on another CPU. That prevents
> deliver_to_old_ones from executing because there is still a timer
> routine executing.
> 
> Here is the call stack of the deadlocked CPUs on a RH8.0 system with a
> 2.4.18-24.8.0 smp kernel:
> CPU 2:
> deliver_to_old_ones+45
> netif_receive_skb
> tg3_rx+27b
> tg3_poll+81
> net_rx_action
> do_softirq
> do_IRQ
> call_do_IRQ
> 
> CPU 6:
> tg3_timer  (tg3+9fc4)
> run_timer_list+0x112
> bh_action+55
> tasklet_hi_action+67
> do_softirq+d9
> do_IRQ
> call_do_IRQ+5
> 
Until this is fixed, there are a couple work-arounds:
- Put the system behind a NAT firewall. This problem is caused by
another protocol on the wire, probably IPX (Netware).
- Switch to a non-NAPI driver. Since you're using the BroadComm NIC, try
the BCM5700 driver or switch to a different NIC.

While troubleshooting this problem here at HP, I have a couple of
systems that have run for over 2 weeks by using the above work-arounds.

Tom Rhodes
tom.rhodes@hp.com
