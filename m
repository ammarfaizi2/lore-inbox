Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTKIApm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 19:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTKIApm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 19:45:42 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:43142 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261661AbTKIApl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 19:45:41 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 8 Nov 2003 16:44:52 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Nick Piggin <piggin@cyberone.com.au>
cc: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, <mbligh@aracnet.com>
Subject: Re: [PATCH] Fix find busiest queue 2.6.0-test9
In-Reply-To: <3FAD7F7D.2020003@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0311081631300.2122-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Nov 2003, Nick Piggin wrote:

> Andrew Morton wrote:
> 
> >Con Kolivas <kernel@kolivas.org> wrote:
> >
> >>Hi
> >>
> >>I believe this is a simple typo / variable name mixup between rq_src and 
> >>this_rq. So far all testing shows positive (if minor) improvements.
> >>
> >>
> >
> >Looks right to me.  I'll queue this up for the 2.6.1 deluge.
> >
> 
> prev_cpu_load[i] is nr_running of cpu i last time this operation was
> performed. Either it, or the current nr_running is taken, whichever
> is lower.
> 
> I guess its done this way for cache benefits, but it was correct as
> Ingo intended. For example, with Con's patch you can see
> rq_src->prev_cpu_load[i] will only ever use the ith position in the array.

Yes. The prev_cpu_load[] array takes a snapshot of the run queue lengths 
seen by the current rq (this_rq). The code is ok as is, and the reason is 
to avoid stealing tasks too fast from remote CPU (cache thing). Time ago I 
also tried to store an K-average (by varying K) rq length in 
prev_cpu_load[] instead of a simple min-of-two-values:

this_rq->prev_cpu_load[i] = (K * this_rq->prev_cpu_load[i] + rq_src->nr_running) / (K + 1);

I couldn't see any major improvements in my 2SMP (never tried on bigger SMP/NUMA).



- Davide



