Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbVJ0BYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbVJ0BYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 21:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbVJ0BYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 21:24:46 -0400
Received: from fmr21.intel.com ([143.183.121.13]:5300 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932076AbVJ0BYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 21:24:45 -0400
Message-Id: <200510270124.j9R1OPg27107@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: better wake-balancing: respin
Date: Wed, 26 Oct 2005 18:24:25 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXalSsjyf4J9a1rRVG4O3vn7bOx+Q==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, this patch was in -mm tree (2.6.13-mm1):
http://marc.theaimsgroup.com/?l=linux-kernel&m=112265450426975&w=2

It is neither in Linus's official tree, nor it is in -mm anymore.

I guess I missed the objection for dropping the patch.  I'm bringing
up this discussion again.  The wake-up path is a lot hotter on numa
system running database benchmark.  Even on a moderate 8P numa box,
__wake_up and try_to_wake_up is showing up as #1 and #4 hottest kernel
functions.  While on a comparable 4P smp box, these two functions are
#5 and #9 respectively.

I think situation will be worse on 32P numa box in the wake up path.
I don't have any measurement on 32P setup yet, because 8P numa
performance sucks at the moment and it is a blocker for us before
proceed any bigger setup.


Execution profile for 8P numa box [1]:

   Symbol              Clockticks Inst. Retired   L3 Misses
#1 __wake_up           8.08%      1.88%           4.67%
#2 finish_task_switch  7.53%      18.11%          5.82%
#3 __make_request      6.87%      2.09%           4.35%
#4 try_to_wake_up      5.57%      0.64%           3.10%



Execution profile for 4P SMP box [2]:

   Symbol              Clockticks
#5 __wake_up           3.57%
#9 try_to_wake_up      2.38%

My question is: what was the reason this patch is dropped and what
can we do to improve wake-up performance?  In my opinion, we should
simply put the task on the CPU it was previously ran and have
rebalance_tick and load_balance_newidle to balance out the load.

- Ken


[1] 8 processor: 1.6 GHz Itanium2 processor, 9M L3. 256 GB memory
[2] 4 processor: 1.6 GHz Itanium2 processor, 9M L3. 128 GB memory

