Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbUCYTZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbUCYTZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:25:42 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:957 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263529AbUCYTZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:25:40 -0500
Date: Thu, 25 Mar 2004 11:24:44 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       Rick Lindsley <ricklind@us.ibm.com>, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <10030000.1080242684@flay>
In-Reply-To: <20040325190944.GB12383@elte.hu>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de> <20040325190944.GB12383@elte.hu>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It doesn't do load balance in wake_up_forked_process() and is
>> relatively non aggressive in balancing later. This leads to the
>> multithreaded OpenMP STREAM running its childs first on the same node
>> as the original process and allocating memory there. [...]
> 
> i believe the fix we want is to pre-balance the context at fork() time. 
> I've implemented this (which is basically just a reuse of
> sched_balance_exec() in fork.c, and the related namespace cleanups), 
> could you give it a go:
> 
>   http://redhat.com/~mingo/scheduler-patches/sched-2.6.5-rc2-mm2-A5
> 
> another solution would be to add SD_BALANCE_FORK.
> 
> also, the best place to do fork() blancing is not at
> wake_up_forked_process() time, but prior doing the MM copy. This patch
> does it there. At wakeup time we've already copied all the pagetables
> and created tons of dirty cachelines.

How are you going to decide whether to rebalance at fork time or exec time?
Exec time balancing is a *lot* more efficient, it just doesn't work for
things that don't exec ... cloned threads would certainly be one case.

M.

