Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276150AbRI1QeI>; Fri, 28 Sep 2001 12:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276154AbRI1Qd6>; Fri, 28 Sep 2001 12:33:58 -0400
Received: from chiara.elte.hu ([157.181.150.200]:26895 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276150AbRI1Qd4>;
	Fri, 28 Sep 2001 12:33:56 -0400
Date: Fri, 28 Sep 2001 18:31:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <kuznet@ms2.inr.ac.ru>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>, <bcrl@redhat.com>, <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <200109281618.UAA04122@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0109281817140.8840-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001 kuznet@ms2.inr.ac.ru wrote:

> >  - removed 'mask' handling from do_softirq() - it's unnecessery due to the
> >    restarts. this further simplifies the code.
>
> Ingo, but this means that only the first softirq is handled.
> "mask" implements round-robin and this is necessary.

it does not, please read the code again. We iterate over all active bits
in the 'pending' bitmask. All softirqs that are active are handled. This
inner loop is repeated up to MAX_SOFTIRQ_RESTART times, if any softirq got
reactivated meanwhile.

> Also, you did not assure me that you interpret problem correctly.
> netif_rx() is __insensitive__ to latencies due to blocked softirq
> restarts. It stops spinning only when it becomes true cpu hog. [...]

(i suspect you meant net_rx_action().)

net_rx_action() stops spinning if 1) a jiffy has passed 2) 300 packets
have been processed. [the jiffy test is not completely accurate as it can
break out of the loop after a short amount of time, but that is a minor
issue.]

there is nothing sacred about the old method of processing NET_RX_SOFTIRQ,
then NET_TX_SOFTIRQ, then breaking out of do_softirq() (the mechanizm was
a bit more complex than that, but in insignificant ways). It's just as
arbitrary as 10 loops - with the difference that 10 loops perform better.

> And scheduling ksoftirqd is the only variant here.

scheduling ksoftirqd is the only variant once we have decided that
softirqs are a CPU hog and we want to make progress in non-irq contexts.
A single loop over softirqs is just as arbitrary as 10 loops, this all is
a matter of balancing.

> Most likely, your problem will disappear when you renice ksoftirqd
> to higher priority f.e. equal to priority of tux threads.

(no. see the previous mails.)

	Ingo


