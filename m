Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276204AbRI1RtA>; Fri, 28 Sep 2001 13:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276206AbRI1Rsu>; Fri, 28 Sep 2001 13:48:50 -0400
Received: from chiara.elte.hu ([157.181.150.200]:38159 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S276204AbRI1Rsm>;
	Fri, 28 Sep 2001 13:48:42 -0400
Date: Fri, 28 Sep 2001 19:46:43 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] softirq performance fixes, cleanups, 2.4.10.
In-Reply-To: <200109281741.VAA04648@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.33.0109281939280.9790-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001 kuznet@ms2.inr.ac.ru wrote:

> More seriously, the question is not why these 10% appears, but rather
> why they _disappeared_ in 2.4.7.

the effects i saw (Ben is not around unfortunately, so i cannot confirm
neither deny whether there is any correlation between the effects Ben saw
and the effects i saw) were due to ksoftirqd's generic tendency to
increase the latency between the issuing of work and the completion of it.
Increasing ksoftirqd's priority (in fact, setting current->counter = 2
everytime schedule() is called :-) does not fix this fundamental property
=> it still causes 'work generators' (processes) to use more CPU time than
'work completion' (irqs, softirqs). Furthermore, it also increases the
latency between hardirqs and softirqs.

so my patch makes it sure that work is completed as soon as possible - but
i've also kept an exit door open. [which you might find insufficient, but
that i think is up to individual tuning anyway - i think i'm generally
running faster machines than you, so our perspectives are slightly
different.]

[processes are not always work generators, and irqs/softirqs not always do
work completion, but i think generally they fit nicely into these two
categories. Eg. the TCP stack often generates new work from softirqs, but
IMO this does not change the fundamental equation.]

	Ingo

