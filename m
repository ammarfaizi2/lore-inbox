Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422713AbWJRRVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422713AbWJRRVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422715AbWJRRVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:21:35 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:8575 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422713AbWJRRVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:21:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lb30E4Taf/KtAGxet2iHIWd2zHhKV6h5mIo2d/EiufPII68iBXL7fReG05+U/ZKKpBEStqXMg63hLAKvh9mHAiDsbr4ECv81PK5xHCOwPhxwzhgDrF8ES5LvRFIRcnh9wN84w6ZYRW1Urm9oI1KGcGvGlTiUkSLmgftF+WNbQow=  ;
Message-ID: <4536629C.4050807@yahoo.com.au>
Date: Thu, 19 Oct 2006 03:21:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] sched_tick with interrupts enabled
References: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0610181001480.28582@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> scheduler_tick() has the potential of running for some time if f.e.
> sched_domains for a system with 1024 processors have to be balanced.
> We currently do all of that with interrupts disabled. So we may be unable
> to service interrupts for some time.
> 
> I wonder if it would be possible to put the sched_tick() into a tasklet and
> allow interrupts to be enabled? Preemption is still disabled and so we
> are stuck on a cpu.

I don't think so because it also does accounting which probably wants to
be precisely on a tick.

Also the timeslice accounting takes the rq lock without disabling interrupt,
and task wakeups can easily happen from interrupt / softirq.

Taking rebalance_tick out of scheduler_tick, and not calling rebalance_tick
from sched_fork is probably a good idea.

After that, it might be acceptable to call rebalance_tick from a tasklet,
although it would be uneeded overhead on small systems. It might be better
to have a special case for your large systems which does the full balance
and runs less frequently in a tasklet (and make your regular rebalance_tick
skip the top level balancing).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
