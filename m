Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbVEIG2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbVEIG2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 02:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbVEIG2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 02:28:07 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:18571 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263059AbVEIG1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 02:27:35 -0400
Message-ID: <427F02CE.7080108@yahoo.com.au>
Date: Mon, 09 May 2005 16:27:26 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
CC: Rusty Russell <rusty@rustcorp.com.au>, schwidefsky@de.ibm.com,
       jdike@addtoit.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] (How to) Let idle CPUs sleep
References: <20050507182728.GA29592@in.ibm.com> <1115524211.17482.23.camel@localhost.localdomain> <427D921F.8070602@yahoo.com.au> <20050508121932.GA3055@in.ibm.com>
In-Reply-To: <20050508121932.GA3055@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Sun, May 08, 2005 at 02:14:23PM +1000, Nick Piggin wrote:
> 
>>Yeah probably something around that order of magnitude. I suspect
>>there will fast be a point where either you'll get other timers
>>going off more frequently, and / or you simply get very quickly
>>diminishing returns on the amount of power saving gained from
>>increasing the period.
> 
> 
> I am looking at it from the other perspective also i.e, virtualized
> env. Any amount of unnecessary timer ticks will lead to equivalent amount
> of unnecessary context switches among the guest OSes.
> 

Yep.

> 
>>It is not so much a matter of "fixing" the scheduler as just adding
>>more heuristics. When are we too busy? When should we wake another
>>CPU? What if that CPU is an SMT sibling? What if it is across the
>>other side of the topology, and other CPUs closer to it are busy
>>as well? What if they're busy but not as busy as we are? etc.
>>
>>We've already got that covered in the existing periodic pull balancing,
>>so instead of duplicating this logic and moving this extra work to busy
>>CPUs, we can just use the existing framework.
> 
> 
> I don't think we have to duplicate the logic, just "reuse" whatever logic
> exists (in find_busiest_group etc). However I do agree there is movement

OK, that may possibly be an option... however:

> of extra work to busy CPUs, but that is only to help the idle CPU sleep longer.
> Whether it justifies the additional complexity or not is what this RFC is
> about I guess!
> 

Yeah, this is a bit worrying. In general we should not be loading
up busy CPUs with any more work, and sleeping idle CPUs should be
done as a blunt "slowpath" operation. Ie. something that works well
enough.

> FWIW, I have also made some modifications in the original proposal 
> for reducing the watchdog workload (instead of the same non-idle cpu waking 
> up all the sleeping CPUs it finds in the same rebalance_tick, the task
> is spread over multiple non-idle tasks in different rebalance_ticks).
> New (lightly tested) patch is in the mail below.
> 

Mmyeah, I'm not a big fan :)

I could probably find some time to do my implementation if you have
a complete working patch for eg. UML.

> 
> 
>>At least we should try method A first, and if that isn't good enough
>>(though I suspect it will be), then think about adding more complexity
>>to the scheduler.
> 
> 
> What would be good to measure between the two approaches is the CPU utilization 
> (over a period of time - say 10 hrs) of somewhat lightly loaded SMP guest OSes 
> (i.e some CPUs are idle and other CPUs of the same guest are not idle), when 
> multiple such guest OSes are running simultaneously on the same box.  This 
> means I need a port of VST to UML :(
> 

Yeah that would be good.

-- 
SUSE Labs, Novell Inc.

