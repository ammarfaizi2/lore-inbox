Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275981AbRJBJm2>; Tue, 2 Oct 2001 05:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275983AbRJBJmS>; Tue, 2 Oct 2001 05:42:18 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:40421 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S275981AbRJBJmE>; Tue, 2 Oct 2001 05:42:04 -0400
Message-ID: <3BB98BF0.9C205725@stud.uni-saarland.de>
Date: Tue, 02 Oct 2001 09:42:08 +0000
From: Manfred Spraul <masp0008@stud.uni-saarland.de>
Reply-To: manfred@colorfullife.com
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>, bcrl@redhat.com
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@chiara.elte.hu>
Subject: Ben Greear <greearb@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (note that in case of shared interrupts, another 'innocent' device might
> > stay disabled for some short amount of time as well - but this is not an
> > issue because this mitigation does not make that device inoperable, it
> > just delays its interrupt by up to 10 msecs. Plus, modern systems have
> > properly distributed interrupts.)
> 
> I'm all for anything that speeds up (and makes more reliable) high network
> speeds, but I often run with 8+ ethernet devices, so IRQs have to be shared,
> and a 10ms lockdown on an interface could lose lots of packets.

Yes, any interrupt mitigation should depend on the interrupt type - and
only the driver knows which interrupts are urgent.
Unconditionally disabling an interrupt for 10 ms is bad.

An idea for a network driver:

Under load TxDone (one packet finished) is unimportant, TxIdle (Tx
process stopped due to out of buffers) while netif_stop_queue() must be
handled ASAP.

I've tried a driver that disabled TxDone and TxIdle entirely while not
netif_stop_queued, only if the queue was stopped it enabled them. A
timer handled TxDone and start_xmit polled for TxDone, too.

Result: the performance for bulk TCP transfers was around 30 % higher.

But the 10ms timer latency killed the performance of 'ping -l'.


bcrl could you try that with ns83820?

* Do not use the interrupt holdoff register - it might hold off urgent
interrupt sources.
* instead disable TxDone and/or RxDone if too many interrupt arrive
/sec.
* I think the ns83820 has a general purpose timer interrupt, correct?
Set it to 400 us.
* If the timer interrupt occurs and neither TxDone nor RxDone are set,
then disable the timer and switch back to unmitigated TxDone, RxDone
interrupts.

Then you can limit the interrupts without sacrifying immediate response
to TxIdle while in netif_stop_queue() state.

--
	Manfred
