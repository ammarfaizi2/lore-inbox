Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276282AbRI1UGB>; Fri, 28 Sep 2001 16:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276281AbRI1UFw>; Fri, 28 Sep 2001 16:05:52 -0400
Received: from chiara.elte.hu ([157.181.150.200]:52751 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276283AbRI1UFn>;
	Fri, 28 Sep 2001 16:05:43 -0400
Date: Fri, 28 Sep 2001 22:03:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, <bcrl@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <200109281939.XAA05297@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0109282149020.11179-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001 kuznet@ms2.inr.ac.ru wrote:

> Why skbs?

because i did not mean to queue 'softirq bits'. the current bitmap is
perfectly okay and equivalent to any queued scheme. (i'd say queueing
those bits is pretty stupid and only adds overhead. It might make sense
once there are more softirqs, but that can wait.)

what i really meant to queue is something much more finegrained: to queue
softirq *events*. The ones that get queued by netif_rx into
softnet_data[this_cpu]'s input_pkt_queue. We basically have the skb as the
'event context', and we have a number of queues that are used by hardirqs
to queue work towards softirq processing.

do you see the whole scope of this approach? It has a number of
disadvantages (some of which i outlined in the previous mail), but it also
has a number of (i think important) advantages. It's also in fact simpler,
once implemented.

but this means that some of the queueing, that is softnet_data & skb
pointers now, has to be generalized. netif_rx would use this generic
interface to push work towards softirq processing, and the generic softirq
engine would use a callback in the event data structure to do actual
processing of the event.

eg. a fastroute packet could set its event handler to be a function that
does dev_queue_xmit. Other packets could set their event handlers based on
their ->dev. The current demultiplexing done in net_rx_action could be
done in a more natural way, and eg. fastrouting would not add runtime
overhead.

another effect: i think it might be useful to preserve micro-ordering of
rx and tx events. It's certainly the best way to get the most out of
existing cache footprint, but the downside is that it has a higher
'environment' cache footprint, due to rx and tx functions being called at
high frequencies and being intermixed randomly.

> Only "skbs" scares me. :-)

well :)

	Ingo

