Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWDXG0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWDXG0Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 02:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWDXG0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 02:26:16 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48080 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750838AbWDXG0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 02:26:15 -0400
Message-ID: <444C6F3C.1070505@jp.fujitsu.com>
Date: Mon, 24 Apr 2006 15:25:00 +0900
From: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Maeda Naoaki <maeda.naoaki@jp.fujitsu.com>
Subject: Re: [ckrm-tech] Re: [RFC][PATCH 5/9] CPU controller - Documents how
 the controller works
References: <20060421022727.13598.15397.sendpatchset@moscone.dvs.cs.fujitsu.co.jp>	 <20060421022753.13598.77686.sendpatchset@moscone.dvs.cs.fujitsu.co.jp> <1145776430.7990.58.camel@homer>
In-Reply-To: <1145776430.7990.58.camel@homer>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Fri, 2006-04-21 at 11:27 +0900, maeda.naoaki@jp.fujitsu.com wrote:
>> +3. Timeslice scaling
>> +
>> + If there are hungry classes, we need to adjust timeslices to satisfy
>> + the share.  To scale timeslices, we introduce a scaling factor
>> + used for scaling timeslices.  The scaling factor is associated with
>> + the class (stored in the cpu_rc structure) and adaptively adjusted
>> + according to the class load and the share.
> 
> This all works fine until interactive task requeueing is considered, and
> it must be considered.
> 
> One simple way to address the requeue problem is to introduce a scaled
> class sleep_avg consumption factor.  Remove the scaling exemption for
> TASK_INTERACTIVE(p), and if a class's cpu usage doesn't drop to what is
> expected by group timeslice scaling, make members consume sleep_avg at a
> higher rate such that scaling can take effect.

Interesting approach. However, I'm worrying about hurting interactive
response by this change.

> A better way to achieve the desired group cpu usage IMHO would be to
> adjust nice level of members at slice refresh time.  This way, you get
> the timeslice scaling and priority adjustment all in one.
> 
> (I think I would do both actually, with nice level being preferred such
> that dynamic priority spread within the group isn't flattened, which can
> cause terminal starvation within the group, unless really required.)

If nice is changed, the task priority is also changed. I don't think
changing the task priority for this purpose is a good choice, but
only lengthen the timeslice would work and that is what I'm considering.

Another obvious bad case is an imbalanced number of runnable tasks
in the different groups. Since minimum timeslice is 1 tick,
minimum share is the factor of number of runnable tasks in the group.
If 1% share group contains 99 runnable tasks and the other 99% share
group has just one runnable task, the load of the two groups would be
the same. (It becomes worse in small HZ configuration.)

I've tried different approach to compensate for this badness.
Which is to requeue the starving tasks to the active as if they are
TASK_INTERACTIVE, but it sometimes hurt system response and other
undesirable side effect was observed.

Now, I'm thinking to enlarge the timeslice of starving groups.

Thanks,
MAEDA Naoaki

