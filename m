Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265081AbTL1LYk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 06:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbTL1LYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 06:24:40 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:20443 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S265081AbTL1LYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 06:24:35 -0500
Date: Sun, 28 Dec 2003 12:23:40 +0100
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@surriel.com>, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Page aging broken in 2.6
Message-ID: <20031228112339.GA4847@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@surriel.com>,
	torvalds@osdl.org, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, andrea@suse.de
References: <1072423739.15458.62.camel@gaston> <Pine.LNX.4.58.0312260957100.14874@home.osdl.org> <1072482941.15458.90.camel@gaston> <Pine.LNX.4.58.0312261626260.14874@home.osdl.org> <1072485899.15456.96.camel@gaston> <Pine.LNX.4.58.0312261649070.14874@home.osdl.org> <Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com> <20031226190045.0f4651f3.akpm@osdl.org> <20031227230757.GA25229@k3.hellgate.ch> <20031227235538.GP22443@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031227235538.GP22443@holomorphy.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Dec 2003 15:55:38 -0800, William Lee Irwin III wrote:
> On Sun, Dec 28, 2003 at 12:07:58AM +0100, Roger Luethi wrote:
> > It can matter. Evicting a page that is infrequently referenced by many
> > processes increases the chance that all runnable processes block waiting
> > for that same page later. The likelihood of that happening grows under
> > memory pressure, when "infrequently" may actually be "quite often" and
> > when disk I/O is congested (resulting in higher disk access times).
> > You won't have the same effect when evicting a page that is referenced
> > by one process only, no matter how frequently.
> 
> Part of this is unrealistic; paging I/O being congested must be due to
> paging itself causing seeks without additional I/O load. Reading a
> single page once and then faulting that one page back into numerous
> process address spaces is only one I/O request, and so cannot seek in
> and of itself. So in this scenario, a convoy of processes on a single
> page is plausible; aggravated paging I/O seekiness is not. Did you have
> in mind some additional I/O load? Or do affected processes actually all
> fault before the one I/O completes, and so all block temporarily?

My previous message was meant as a warning of the assumption that
the aggregated reference frequency is all that matters. I was merely
pointing out how the number of processes referencing a page could affect
performance as well. Reference frequency is used as an estimator for
the _likelihood_ of a fault in the future, but the potential _impact_
of a fault grows with the number of processes that may block on it.
It is one possible (though not necessarily the most likely) explanation
for the symptoms I see with 2.6.

vmstat finds all processes blocked a lot more often in 2.6 than in
2.4, often for several seconds in a row. That only means something in
comparison, of course, because it is anything but a precise measurement
-- not only because of the 1 second snapshot granularity but also due
to the fact that bookkeeping of running and blocked processes in the
kernel is not accurate (processes may count as both blocked and running).

Typical log snippet for a kernel build under some 2.6.0-test release:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 9  3   6268 851814   1500   8992  440    0   996   348 1141   294 87 13  0  0
 9  3   6164 852816   1540   9088  352    0   456     0 1045   145 91  9  0  0
 9  6   6164   4044 853818   8112   60    0   100    28 1016    71 92  8  0  0
 4  6   6604 854820    924   7432  532  472   784   488 1096   626 57 43  0  0
 2  9   9248   3556 855921   6968 1044 2748  1640  2752 1283   412 74 13  0 13
 3  7   9248 857071    924   6864 1208    0  1720   108 1326   524 60 34  0  6
10  8  11164   2080 858438   5952 1068 1944  2040  2064 1623  1655 74 26  0  0
 0 11  13000 859563    356   5824  796 2032  1572  2036 1330   656 66 24  0 10
 0 10  16608   4064 861037   5868  832 3960  1836  3964 1755   725 42  9  0 49
 0 11  16604 862284    420   5920 1420    0  2216     4 1471   485 39  4  0 57
 7  4   9772  10656 863286   6644  552    0  1344    12 1112   250 56  5  0 39
 9  2   8228 864687    732   6960  296    0   632   108 1484   257 96  4  0  0
 8  3   8212  10656 865689   7176   80    0   320     0 1050   146 95  5  0  0

The trace above is not for the benchmark I referred to as kbuild in the
past few weeks (it was taken under lighter load). Even so 2.6 exhibits
significantly more periods with I/O wait and consequently takes longer
than 2.4 to complete.

> > Having all processes blocked is indeed one problem of 2.6 under memory
> > pressure. I don't know what the cause is, though.
> 
> Can you capture sysrq t while a situation like this is in progress?

What are you getting at? This may be easier for you to do because you
know what you are looking for.

Roger
