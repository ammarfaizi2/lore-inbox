Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUHDCkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUHDCkz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267251AbUHDCky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:40:54 -0400
Received: from gizmo05ps.bigpond.com ([144.140.71.40]:18899 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S267250AbUHDCkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:40:20 -0400
Message-ID: <41104C8F.9080603@bigpond.net.au>
Date: Wed, 04 Aug 2004 12:40:15 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
References: <410DDFD2.5090400@bigpond.net.au> <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au> <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au> <20040803104912.GW2334@holomorphy.com> <41102FE5.9010507@bigpond.net.au> <20040804005034.GE2334@holomorphy.com> <41103DBB.6090100@bigpond.net.au> <20040804015115.GF2334@holomorphy.com>
In-Reply-To: <20040804015115.GF2334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>Aperiodic rotations defer movement until MAX_RT_PRIO's slot is evacuated.
> 
> 
> On Wed, Aug 04, 2004 at 11:36:59AM +1000, Peter Williams wrote:
> 
>>Unfortunately, to ensure no starvation, promotion has to continue even 
>>when there are tasks in MAX_RT_PRIO's slot.
> 
> 
> One may either demote to evict MAX_RT_PRIO immediately prior to
> rotation or rely on timeslice expiry to evict MAX_RT_PRIO. Forcibly
> evicting MAX_RT_PRIO undesirably accumulates tasks at the fencepost.

It's starting to get almost as complex as the current scheme :-)

> 
> 
> William Lee Irwin III wrote:
> 
>>>The primary concern was that ticklessness etc. may require it to occur
>>>during context switches.
> 
> 
> On Wed, Aug 04, 2004 at 11:36:59AM +1000, Peter Williams wrote:
> 
>>On a tickless system, I'd consider using a timer to control when 
>>do_promotions() gets called.  I imagine something similar will be 
>>necessary to manage time slices?
> 
> 
> This is an alternative to scheduler accounting in context switches.
> Periodicity often loses power conservation benefits.

The timer would be deactivated whenever the number of runnable tasks for 
the runqueue goes below 2.  The whole thing could be managed from the 
enqueue and dequeue functions i.e.

dequeue - if the number running is now less than two cancel the timer 
and otherwise decrease the expiry time to maintain the linear 
relationship of the interval with the number of runnable tasks

enqueue - if the number of runnable tasks is now 2 then start the time 
with a single interval setting and if the number is greater than two 
then increase the timer interval to maintain the linear relationship.

I'm assuming here that add_timer(), del_timer() and (especially) 
mod_timer() are relatively cheap.  If mod_timer() is too expensive some 
alternative method could be devised to maintain the linear relationship.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

