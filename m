Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUFNRCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUFNRCI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUFNRCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:02:08 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:47340 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S263555AbUFNRB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:01:58 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>, linux-kernel@vger.kernel.org
Date: Mon, 14 Jun 2004 10:01:53 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Local DoS (was: Strange 'zombie' problem both in 2.4 and 2.6)
In-Reply-To: <20040413131017.GA11294@logos.cnet>
Message-ID: <Pine.LNX.4.60.0406140959250.30433@dlang.diginsite.com>
References: <200404091311.50787@zigzag.lvk.cs.msu.su> <20040413131017.GA11294@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I may be running into the same (or a similar) issue with a 
workload that forks heavily (~3500 forks/sec). What can I do to let the 
system survive this sort of load?

David Lang

On Tue, 13 Apr 2004, Marcelo Tosatti wrote:

> Date: Tue, 13 Apr 2004 10:10:17 -0300
> From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
> To: Nikita V. Youshchenko <yoush@cs.msu.su>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Local DoS (was: Strange 'zombie' problem both in 2.4 and 2.6)
> 
> On Fri, Apr 09, 2004 at 01:11:50PM +0400, Nikita V. Youshchenko wrote:
>> Hello.
>>
>> Several days ago I've posted to linux-kernel describing "zombie problem"
>> related to sigqueue overflow.
>>
>> Futher exploration of the problem showed that the reason of the described
>> behaviour is in user-space. There is a process that blocks a signal and
>> later receives tons of such signals. This effectively causes sigqueue
>> overflow.
>>
>> The following program gives the same effect:
>>
>> #include <signal.h>
>> #include <unistd.h>
>> #include <stdlib.h>
>>
>> int main()
>> {
>>         sigset_t set;
>>         int i;
>>         pid_t pid;
>>
>>         sigemptyset(&set);
>>         sigaddset(&set, 40);
>>         sigprocmask(SIG_BLOCK, &set, 0);
>>
>>         pid = getpid();
>>         for (i = 0; i < 1024; i++)
>>                 kill(pid, 40);
>>
>>         while (1)
>>                 sleep(1);
>> }
>>
>> Running this program on 2.4 or 2.6 kernel with
>> default /proc/sys/kernel/rtsig-max value will cause sigqueue overflow, and
>> all linuxthreads-based programs, INCLUDING DAEMONS RUNNING AS ROOT, will
>> stop receiving notifications about thread exits, so all completed threads
>> will become zombies. Exact reason why this is hapenning is described in
>> detail in my previous postings.
>>
>> This is a local DoS.
>>
>> Affected system services include (but are not limited to) mysql and clamav.
>> In fact, any linuxthreads application will be affected.
>>
>> The problem is not that bad on 2.6, since NPTL is used instead of
>> linuxthreads, so there are no zombies from system daemons. However, bad
>> things still happen: when sigqueue is overflown, all processes get zeroed
>> siginfo, which causes random application misbehaviours (like hangs in
>> pthread_cancel()).
>>
>> I don't know what is the correct solution for this issue. Probably there
>> should be per-process or per-user (but not systemwide) limits on number of
>> pending signals.
>
> Indeed, per-user sigqueue limit is the way to fix this.
>
> Anyone willing to implement it ?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
