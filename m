Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262779AbSJ0X0s>; Sun, 27 Oct 2002 18:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSJ0X0s>; Sun, 27 Oct 2002 18:26:48 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:29415 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262779AbSJ0X0r> convert rfc822-to-8bit; Sun, 27 Oct 2002 18:26:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Date: Mon, 28 Oct 2002 01:32:33 +0100
User-Agent: KMail/1.4.1
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
References: <3022997410.1035634489@[10.10.2.3]> <3105925354.1035713817@[10.10.2.3]>
In-Reply-To: <3105925354.1035713817@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210280132.33624.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 October 2002 19:16, Martin J. Bligh wrote:
> > OK, I went to your latest patches (just 1 and 2). And they worked!
> > You've fixed the performance degradation problems for kernel compile
> > (now a 14% improvement in systime), that core set works without
> > further futzing about or crashing, with or without TSC, on either
> > version of gcc ... congrats!
>
> So I have a slight correction to make to the above ;-) Your patches
> do work just fine, no crashes any more. HOWEVER ... turns out I only
> had the first patch installed, not both. Silly mistake, but turns out
> to be very interesting.
>
> So your second patch is the balance on exec stuff ... I've looked at
> it, and think it's going to be very expensive to do in practice, at
> least the simplistic "recalc everything on every exec" approach. It
> does benefit the low end schedbench results, but not the high end ones,
> and you can see the cost of your second patch in the system times of
> the kernbench.

This is interesting, indeed. As you might have seen from the tests I
posted on LKML I could not see that effect on our IA64 NUMA machine.
Which arises the question: is it expensive to recalculate the load
when doing an exec (which I should also see) or is the strategy of
equally distributing the jobs across the nodes bad for certain
load+architecture combinations? As I'm not seeing the effect, maybe
you could do the following experiment:
In sched_best_node() keep only the "while" loop at the beginning. This
leads to a cheap selection of the next node, just a simple round robin. 

Regarding the schedbench results: are they averages over multiple runs?
The numa_test needs to be repeated a few times to get statistically
meaningful results.

Thanks,
Erich

> In summary, I think I like the first patch alone better than the
> combination, but will have a play at making a cross between the two.
> As I have very little context about the scheduler, would appreciate
> any help anyone would like to volunteer ;-)
>
> Corrected results are:
>
> Kernbench:
>                              Elapsed        User      System         CPU
>               2.5.44-mm4     19.676s    192.794s     42.678s     1197.4%
>         2.5.44-mm4-hbaum     19.422s    189.828s     40.204s     1196.2%
>       2.5.44-mm4-focht-1      19.46s    189.838s     37.938s       1171%
>      2.5.44-mm4-focht-12      20.32s        190s       44.4s     1153.6%
>
> Schedbench 4:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>               2.5.44-mm4       32.45       49.47      129.86        0.82
>         2.5.44-mm4-hbaum       31.31       43.85      125.29        0.84
>       2.5.44-mm4-focht-1       38.61       45.15      154.48        1.06
>      2.5.44-mm4-focht-12       23.23       38.87       92.99        0.85
>
> Schedbench 8:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>               2.5.44-mm4       39.90       61.48      319.26        2.79
>         2.5.44-mm4-hbaum       32.63       46.56      261.10        1.99
>       2.5.44-mm4-focht-1       37.76       61.09      302.17        2.55
>      2.5.44-mm4-focht-12       28.40       34.43      227.25        2.09
>
> Schedbench 16:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>               2.5.44-mm4       62.99       93.59     1008.01        5.11
>         2.5.44-mm4-hbaum       49.78       76.71      796.68        4.43
>       2.5.44-mm4-focht-1       51.69       60.23      827.20        4.95
>      2.5.44-mm4-focht-12       51.24       60.86      820.08        4.23
>
> Schedbench 32:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>               2.5.44-mm4       88.13      194.53     2820.54       11.52
>         2.5.44-mm4-hbaum       54.67      147.30     1749.77        7.91
>       2.5.44-mm4-focht-1       56.71      123.62     1815.12        7.92
>      2.5.44-mm4-focht-12       55.69      118.85     1782.25        7.28
>
> Schedbench 64:
>                              Elapsed   TotalUser    TotalSys     AvgUser
>               2.5.44-mm4      159.92      653.79    10235.93       25.16
>         2.5.44-mm4-hbaum       65.20      300.58     4173.26       16.82
>       2.5.44-mm4-focht-1       55.60      232.36     3558.98       17.61
>      2.5.44-mm4-focht-12       56.03      234.45     3586.46       15.76

