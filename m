Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbTHaUVe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 16:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbTHaUVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 16:21:34 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:19107 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262639AbTHaUVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 16:21:33 -0400
Date: Sun, 31 Aug 2003 13:20:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Nick's scheduler policy v10
Message-ID: <1806700000.1062361257@[10.10.2.4]>
In-Reply-To: <3F5044DC.10305@cyberone.com.au>
References: <3F5044DC.10305@cyberone.com.au>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is quite a big change from v8. Fixes a few bugs in child priority,
> and adds a small lower bound on the amount of history that is kept. This
> should improve "fork something" times hopefully, and stops new children
> being able to fluctuate priority so wildly.
> 
> Eliminates "timeslice backboost" and only uses "priority backboost". This
> decreases scheduling latency quite nicely - I can only measure 130ms for
> a very low priority task, with a make -j3 and wildly moving an xterm around
> in front of a mozilla window.
> 
> Makes a fairly fundamental change to how sleeping/running is accounted.
> It now takes into account time on the runqueue. This hopefully will keep
> priorities more stable under varying loads.
> 
> Includes an upper bound on the amount of priority a task can get in one
> sleep. Hopefully this catches freak long sleeps like a SIGSTOP or unexpected
> swaps. This change breaks the priority calculation a little bit. I'm thinking
> about how to fix it.
> 
> Feedback welcome! Its against 0-test4, as usual.

Oooh - much better.

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
              2.6.0-test4       45.87      116.92      571.10     1499.00
         2.6.0-test4-nick       49.37      131.31      611.15     1500.75
       2.6.0-test4-nick7a       49.48      125.95      617.71     1502.00
       2.6.0-test4-nick10       46.91      114.03      584.16     1489.25

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
              2.6.0-test4       100.0%         0.3%
         2.6.0-test4-nick       102.9%         0.3%
       2.6.0-test4-nick7a       105.1%         0.5%
       2.6.0-test4-nick10       107.7%         0.2%

System time of kernbench is back to what it would be with virgin, or
actually a little less. Elapsed time is still up a little bit, along
with user time, but it's getting pretty close.

Have you looked at Rick Lindsley's schedstat patches? I don't have a
totally up-to-date version, but that might give us a better idea of
what's going on wrt migrations, balancing, etc.

I'll try to get together a broader set of benchmarks and hammer on this
some more ...

M.
