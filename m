Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271843AbTG2O2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271846AbTG2O2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:28:16 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:33465 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S271843AbTG2O2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:28:15 -0400
Date: Tue, 29 Jul 2003 07:27:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>, habanero@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
cc: Andi Kleen <ak@muc.de>, torvalds@osdl.org
Subject: Re: [patch] scheduler fix for 1cpu/node case
Message-ID: <3380000.1059488845@[10.10.2.4]>
In-Reply-To: <200307291208.30332.efocht@hpce.nec.com>
References: <200307280548.53976.efocht@gmx.net> <3904530000.1059424676@[10.10.2.4]> <200307282124.28378.habanero@us.ibm.com> <200307291208.30332.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I am going to ask a silly question, do we have any data showing this really
>> is a problem on AMD?  I would think, even if we have an idle cpu, sometimes
>> a little delay on task migration (on NUMA) may not be a bad thing.   If it
>> is too long, can we just make the rebalance ticks arch specific?
> 
> The fact that global rebalances are done only in the timer interrupt
> is simply bad! It complicates rebalance_tick() and wastes the
> opportunity to get feedback from the failed local balance attempts.

The whole point of the NUMA scheduler is to rebalance globally less
often. Now I'd agree that in the idle case we want to be more agressive,
as your patch does, but we need to be careful not to end up in a cacheline
thrashing war. 

Aiming for perfect balance is not always a good idea - the expense of both 
the calculation and the migrations has to be taken into account. For some 
arches, it's less important than others ... one thing we're missing is
a per arch "node-balance-agressiveness" factor.

Having said that, the NUMA scheduler is clearly broken on Hammer at the
moment, from Andi's observations.

> If you want data supporting my assumptions: Ted Ts'o's talk at OLS
> shows the necessity to rebalance ASAP (even in try_to_wake_up). There
> are plenty of arguments towards this, starting with the steal delay
> parameter scans from the early days of multi-queue schedulers (Davide
> Libenzi), over my experiments with NUMA schedulers and the observation
> of Andi Kleen that on Opteron you better run from the wrong CPU than
> wait (if the tasks returns to the right cpu, all's fine anyway).

That's a drastic oversimplification. It may be better in some 
circumstances, on some benchmarks. For now, let's just get your patch
tested on Hammer, and see if it works better to have the NUMA scheduler
on than off after your patch ...

M.



