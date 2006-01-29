Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWA2K0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWA2K0C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 05:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWA2K0C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 05:26:02 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17121 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750894AbWA2K0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 05:26:01 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Only allow a threaded init to exec from the
 thread_group_leader
References: <m14q3nh7zi.fsf@ebiederm.dsl.xmission.com>
	<20060129003606.7887ecd9.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 03:25:32 -0700
In-Reply-To: <20060129003606.7887ecd9.akpm@osdl.org> (Andrew Morton's
 message of "Sun, 29 Jan 2006 00:36:06 -0800")
Message-ID: <m1irs38h5v.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>> 408dad0f2b7067b23929866150e73b2b2f12d662
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 055378d..c9d8e31 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -600,6 +600,12 @@ static int de_thread(struct task_struct 
>>  	if (thread_group_empty(current))
>>  		goto no_thread_group;
>>  
>> +	/* A threaded init must exec from it's primary thread.
>> +	 * As the init task (i.e. child_reaper) may not exit.
>> +	 */
>> +	if (!thread_group_leader(current) && (current->tgid == 1))
>> +		return -EINVAL;
>> +	
>>  	/*
>>  	 * Kill all other threads in the thread group.
>>  	 * We must hold tasklist_lock to call zap_other_threads.
>
> hmm, this just looks like overhead.  If sometime someone _does_ try to
> thread init, what will happen to them?  If it's something nice and nasty,
> they'll just whine at us and stop doing that.  Same net effect, no runtime
> cost.

So threading init will work just fine.  The only case that will blow up
is calling exec from something that is not the thread group leader.
i.e.  If tgid == 1 but pid != 1 the kernel will cause pid == 1 to exit.

I think that will trigger a kernel panic.  It might just ensure that
no more processes are re-parented to init.  And we dereference a
bad pointer we look at child_reaper.  I haven't been brave enough
to try it.

The cost is only paid if you are a threaded task and you call exec.
Normal process never take that path, so we are already off of the
fast path.

The test when all expanded out is only:

if ((current->tgid == current->pid) && (current->tgid == 1))
	return -EINVAL

So it should be relatively cheap.


If process id namespaces become a reality init stops being
terribly special, and becomes something you may have several
of running at any one time.  If one of those inits is compromised
by a hostile user I having the whole system go down so we can
avoid executing a cheap test sounds terribly wrong.  That is
why I really care.

Eric
