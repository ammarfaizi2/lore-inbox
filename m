Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268734AbTBZMpe>; Wed, 26 Feb 2003 07:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268737AbTBZMpe>; Wed, 26 Feb 2003 07:45:34 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:60170 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S268734AbTBZMpc>; Wed, 26 Feb 2003 07:45:32 -0500
Message-Id: <200302261248.h1QCmIs24145@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Rhodes, Tom" <tom.rhodes@hp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: lockups with 2.4.20 (tg3? net/core/dev.c|deliver_to_old_ones)
Date: Wed, 26 Feb 2003 14:45:16 +0200
X-Mailer: KMail [version 1.3.2]
References: <DC900CF28D03B745B2859A0E084F044D029601AD@cceexc19.americas.cpqcorp.net>
In-Reply-To: <DC900CF28D03B745B2859A0E084F044D029601AD@cceexc19.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 February 2003 09:00, Rhodes, Tom wrote:
> >> Since sometime in December two systems we have on site using P4 HT
>
> (one
>
> >> Dell 2650 and one Dell 4600, both dual CPU, both ht/mce capable)
> >> have
>
> been
>
> >> locking up without any kernel output and without sysrq keys
> >> working
>
> (the
>
> >> keyboard is locked solid).
> >>[...]
> >> Using nmi_watchdog I've managed to get a stack track and ran
> >> ksymoops
>
> over
>
> >> it (attached).
> >
> > Good report. To tell the truth, I know that this lockup exists,
> > there's an RH issue-tracker item against me on this.
>
> Several of us at HP have been chasing this problem as well. Here is
> why there is a deadlock: deliver_to_old_ones()attempts to stop all
> timers from running and then blocks until all the timers are no
> longer running.

Here, linux/interrupt.h:

static inline void tasklet_unlock_wait(struct tasklet_struct *t)
{
        while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
}

Yes this can run forever

> This code is called from netif_receive_skb which is
> called from tg3_poll while it is holding a lock in the tg3 driver. On
> another CPU, the tg3_timer routine is run but is blocked by the lock
> held in the tg3_poll routine. The tg3_timer routine never finishes
> because it can't acquire the lock being held by tg3_poll on another
> CPU. That prevents deliver_to_old_ones from executing because there
> is still a timer routine executing.
>
> Here is the call stack of the deadlocked CPUs on a RH8.0 system with
> a 2.4.18-24.8.0 smp kernel:
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
--
vda
