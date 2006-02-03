Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWBCNA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWBCNA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 08:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWBCNA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 08:00:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18876 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750763AbWBCNA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 08:00:28 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH] pidhash:  Kill switch_exec_pids
References: <m1r76lslhi.fsf@ebiederm.dsl.xmission.com>
	<43E26AB1.8509A175@tv-sign.ru>
	<m13bj1sevb.fsf@ebiederm.dsl.xmission.com>
	<43E35A13.B83AC4B8@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 03 Feb 2006 05:59:40 -0700
In-Reply-To: <43E35A13.B83AC4B8@tv-sign.ru> (Oleg Nesterov's message of
 "Fri, 03 Feb 2006 16:26:43 +0300")
Message-ID: <m1psm4pphf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> "Eric W. Biederman" wrote:
>> 
>> 
>> All I have done is enlarged the window where this
>> race is possible.  So for tkill I am not concerned,
>> as it wants a particular thread.  Nor am I concerned
>> about anything else that wants a particular thread.
>
> Yes, you are right, sorry for noise. We have exactly same situation
> before de_thread() locks tasklist after killing the leader.

No problem.  If de_thread was simple and obviously correct
we wouldn't be fixing it :)

>> The fact that the group_leader does not point
>> at the actual thread group leader might be a problem,
>> as I have opened a window where that is now the case.
>> 
>> For signals that is not a problem as signals are still shared.
>> This applies to most other resources as well.
>
> Actually, now I think this patch fixes a small theoretical bug.
> Currently we have a tiny window in switch_exec_pids() when it
> detaches ->pid from PIDTYPE_PID namespace. RCU based kill_proc_info()
> does not take tasklist, so we can miss a signal.

Ok.  I thought there was a RCU component to the readers.  I just
lost track of where it was.

> I have added Paul to the CC: list.
>
>> So until we spot that case I'm ready to put this down
>> of one of those cases in de_thread that looks wrong
>> but happens to work.  Now if there is a way to make
>> it work more cleanly that may be worth looking at.
>
> I think you are right.

I hope so.

> Andrew, please drop this one:
>
> 	dont-touch-current-tasks-in-de_thread.patch
>
> Eric's patch includes this cleanup.

I just tested this path against 2.6.16-rc1-mm5 
and the patch applies with just a little fuzz.

Eric
