Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965016AbVKGWrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVKGWrr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbVKGWrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:47:47 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:15882 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965016AbVKGWrq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:47:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <436FD291.2060301@us.ibm.com>
References: <436FD291.2060301@us.ibm.com>
X-OriginalArrivalTime: 07 Nov 2005 22:47:44.0742 (UTC) FILETIME=[4496E060:01C5E3ED]
Content-class: urn:content-classes:message
Subject: Re: Database regression due to scheduler changes ?
Date: Mon, 7 Nov 2005 17:47:44 -0500
Message-ID: <Pine.LNX.4.61.0511071745020.28676@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Database regression due to scheduler changes ?
Thread-Index: AcXj7USggu4FgG+hSeilFzzo/FOOlw==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Brian Twichell" <tbrian@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <mbligh@mbligh.org>, <slpratt@us.ibm.com>,
       <anton@samba.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Nov 2005, Brian Twichell wrote:

> Hi,
>
> We observed a 1.5% regression in an OLTP database workload going from
> 2.6.13-rc4 to 2.6.13-rc5.  The regression has been carried forward
> at least as far as 2.6.14-rc5.
>
> Through experimentation, and through examining the changes that
> went into 2.6.13-rc5, we found that we can eliminate the regression
> in 2.6.13-rc5 with one straightforward change:  eliminating the
> NUMA level from the CPU scheduler domain structures.
>
> After observing this, we collected schedstats (provided below)
> to try to determine how the scheduler behaves differently
> when the NUMA level is eliminated.  It appears to us that
> the scheduler is having more success in balancing in this
> case.  We tried to duplicate this effect by changing parameters
> in the NUMA-level and SMP-level domain definitions to
> increase the aggressiveness of the balancing, but none of the
> changes could recoup the regression.
>
> We suspect the regression was introduced in the scheduler changes
> that went into 2.6.13-rc1.  However, the regression was hidden
> from us by a bug in include/asm-ppc64/topology.h that made ppc64
> look non-NUMA from 2.6.13-rc1 through 2.6.13-rc4.  That bug was
> fixed in 2.6.13-rc5.  Unfortunately the workload does not run to
> completion on 2.6.12 or 2.6.13-rc1.  We have measurements on
> 2.6.12-rc6-git7 that do not show the regression.
>
> One alternative for fixing this in 2.6.13 would have been to #define
> ARCH_HAS_SCHED_DOMAINS and to introduce a ppc64-specific version
> of build_sched_domains that eliminates the NUMA-level domain for
> small (e.g. 4-way) ppc64 systems.  However, ARCH_HAS_SCHED_DOMAINS
> has been eliminated from 2.6.14, and anyways that solution doesn't
> seem very encompassing to me.
>
> So, at this point I am soliciting assistance from scheduler experts
> to determine how this regression can be eliminated.  We are keen
> to prevent this regression from going into the next distro versions.
> Simply shipping a distro kernel with CONFIG_NUMA off isn't a viable
> option because we need it for our larger configurations.
>
> Our system configuration is a 4-way 1.9 GHz Power5-based server.  As
> the system supports SMT, it shows eight online CPUs.
>
> Below are the schedstats.  The first set is with the NUMA-level
> domain, while the second set is without the NUMA-level domain.
>
> Cheers,
> Brian Twichell
>
> Schedstats (NUMA-level domain included)
> ----------------------------------------------------------------------
> 00:09:05--------------------------------------------------------------
>       2845          sys_sched_yield()
>          0(  0.00%) found (only) active queue empty on current cpu
>          0(  0.00%) found (only) expired queue empty on current cpu
>        157(  5.52%) found both queues empty on current cpu
>       2688( 94.48%) found neither queue empty on current cpu
>
>
>    23287180          schedule()
>          1(  0.00%) switched active and expired queues
>          0(  0.00%) used existing active queue
>
>          0          active_load_balance()
>          0          sched_balance_exec()
>
>      0.19/1.17      avg runtime/latency over all cpus (ms)
>
> [scheduler domain #0]
>    1418943          load_balance()
>     112240(  7.91%) called while idle
>                         499(  0.44%) tried but failed to move any tasks
>                       80433( 71.66%) found no busier group
>                       31308( 27.89%) succeeded in moving at least one task
>                                      (average imbalance:   1.549)
>     316022( 22.27%) called while busy
>                          21(  0.01%) tried but failed to move any tasks
>                      220440( 69.75%) found no busier group
>                       95561( 30.24%) succeeded in moving at least one task
>                                      (average imbalance:   1.727)
>     990681( 69.82%) called when newly idle
>                         533(  0.05%) tried but failed to move any tasks
>                      808816( 81.64%) found no busier group
>                      181332( 18.30%) succeeded in moving at least one task
>                                      (average imbalance:   1.500)
>
>          0          sched_balance_exec() tried to push a task
>
> [scheduler domain #1]
>     922193          load_balance()
>      85822(  9.31%) called while idle
>                        4032(  4.70%) tried but failed to move any tasks
>                       70982( 82.71%) found no busier group
>                       10808( 12.59%) succeeded in moving at least one task
>                                      (average imbalance:   1.348)
>      27022(  2.93%) called while busy
>                         106(  0.39%) tried but failed to move any tasks
>                       25478( 94.29%) found no busier group
>                        1438(  5.32%) succeeded in moving at least one task
>                                      (average imbalance:   1.712)
>     809349( 87.76%) called when newly idle
>                        6967(  0.86%) tried but failed to move any tasks
>                      757097( 93.54%) found no busier group
>                       45285(  5.60%) succeeded in moving at least one task
>                                      (average imbalance:   1.338)
>
>          0          sched_balance_exec() tried to push a task
>
> [scheduler domain #2]
>     825662          load_balance()
>      52074(  6.31%) called while idle
>                       17791( 34.16%) tried but failed to move any tasks
>                       32839( 63.06%) found no busier group
>                        1444(  2.77%) succeeded in moving at least one task
>                                      (average imbalance:   1.981)
>       9524(  1.15%) called while busy
>                        1072( 11.26%) tried but failed to move any tasks
>                        7654( 80.37%) found no busier group
>                         798(  8.38%) succeeded in moving at least one task
>                                      (average imbalance:   2.976)
>     764064( 92.54%) called when newly idle
>                      262831( 34.40%) tried but failed to move any tasks
>                      409353( 53.58%) found no busier group
>                       91880( 12.03%) succeeded in moving at least one task
>                                      (average imbalance:   2.518)
>
>          0          sched_balance_exec() tried to push a task
>
>
> Schedstats (NUMA-level domain eliminated)
> ----------------------------------------------------------------------
> 00:09:03--------------------------------------------------------------
>       2576          sys_sched_yield()
>          0(  0.00%) found (only) active queue empty on current cpu
>          0(  0.00%) found (only) expired queue empty on current cpu
>        118(  4.58%) found both queues empty on current cpu
>       2458( 95.42%) found neither queue empty on current cpu
>
>
>    23617887          schedule()
>    1106774          goes idle
>          0(  0.00%) switched active and expired queues
>          0(  0.00%) used existing active queue
>
>          0          active_load_balance()
>          0          sched_balance_exec()
>
>      0.19/1.10      avg runtime/latency over all cpus (ms)
>
> [scheduler domain #0]
>    1810988          load_balance()
>     153509(  8.48%) called while idle
>                         680(  0.44%) tried but failed to move any tasks
>                      104906( 68.34%) found no busier group
>                       47923( 31.22%) succeeded in moving at least one task
>                                      (average imbalance:   1.658)
>     317016( 17.51%) called while busy
>                          30(  0.01%) tried but failed to move any tasks
>                      217438( 68.59%) found no busier group
>                       99548( 31.40%) succeeded in moving at least one task
>                                      (average imbalance:   1.831)
>    1340463( 74.02%) called when newly idle
>                         762(  0.06%) tried but failed to move any tasks
>                     1092960( 81.54%) found no busier group
>                      246741( 18.41%) succeeded in moving at least one task
>                                      (average imbalance:   1.564)
>
>          0          sched_balance_exec() tried to push a task
>
> [scheduler domain #1]
>    1244187          load_balance()
>     111326(  8.95%) called while idle
>                        8396(  7.54%) tried but failed to move any tasks
>                       71276( 64.02%) found no busier group
>                       31654( 28.43%) succeeded in moving at least one task
>                                      (average imbalance:   1.412)
>      39138(  3.15%) called while busy
>                         220(  0.56%) tried but failed to move any tasks
>                       34676( 88.60%) found no busier group
>                        4242( 10.84%) succeeded in moving at least one task
>                                      (average imbalance:   1.360)
>    1093723( 87.91%) called when newly idle
>                       15971(  1.46%) tried but failed to move any tasks
>                      932422( 85.25%) found no busier group
>                      145330( 13.29%) succeeded in moving at least one task
>                                      (average imbalance:   1.189)
>
>          0          sched_balance_exec() tried to push a task
>

Can you change sched_yield() to usleep(1) or usleep(0) and see if
that works. I found that in recent kernels sched_yield() just seems
to spin (may not actually spin, but seems to with a high CPU usage).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.55 BogoMips).
Warning : 98.36% of all statistics are fiction.
.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
