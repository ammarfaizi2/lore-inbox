Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWBKMAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWBKMAY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 07:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWBKMAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 07:00:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24261 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751332AbWBKMAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 07:00:23 -0500
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the
 process id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 11 Feb 2006 04:57:36 -0700
In-Reply-To: <43ECF803.8080404@sw.ru> (Kirill Korotaev's message of "Fri, 10
 Feb 2006 23:30:59 +0300")
Message-ID: <m1psluw1jj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> [ ... skipped .... ]
>
>> @@ -788,6 +801,16 @@ fastcall NORET_TYPE void do_exit(long co
>>  		panic("Attempted to kill the idle task!");
>>  	if (unlikely(is_init(tsk)))
>>  		panic("Attempted to kill init!");
>> +
>> +	/*
>> +	 * If we are the pspace leader it is nonsense for the pspace
>> +	 * to continue so kill everyone else in the pspace.
>> +	 */
>> +	if (pspace_leader(tsk)) {
>> +		tsk->pspace->flags = PSPACE_EXIT;
>> +		kill_pspace_info(SIGKILL, (void *)1, tsk->pspace);
>> +	}
>> +
> <<<<
>
> 1.
> flags are neither atomic nor protected with any lock.

flags are atomic as they are a machine word.  So they do not
require a read/modify write so they will either be written
or not written.  Plus this allows write-sharing of the appropriate
cache line which is very polite (assuming the line is not shared with
something else)

I do need a big fat comment about this though.

There is serialization as there is only one process that can write
to this value from exactly one spot.

> So if it will be used later for something else in future, there will be 100%
> race. You also assigns them here, while everywhere in other places a bit is
> checked.

Agreed.  I need to change the name to something like state and stop doing
bit tests.  To make this clear.

> 2. due to 1) you code is buggy. in this respect do_exit() is not serialized with
> copy_process().

Yes. I may need a memory barrier in there.  I need to think
about that a little more.

> 3. due to the same 1) reason
>  > +		kill_pspace_info(SIGKILL, (void *)1, tsk->pspace);
> can miss a task being forked. Bang!!!

Well the only bad thing that can happen is that I get a process that
can run and observe pid == 1 has exited.  So Bang!! is not too
painful.


For an initial implementation that is not yet ready for kernel
inclusion, and was posted to show the form I expect my patches
to take that wasn't too bad.

> 4.
> So you are effectively inserting a code for cleaning up pspace here and the same
> is actually required for other subsystems like networking/IPC etc.

So the SIGKILL is not about pspace clean up so much as making it
impossible to observe a state where pid == 1 is not running.

> I think you suppose that other resources are freed when the last reference is
> dropped, but to tell the truth this is a way to deadlocks. Because refs are put
> in too many places, where you can't make a real cleanup due to locking etc. You
> can't for example call syncronize_net() from bh, which is required for network
> cleanup.

Yes references counts can work, and do so regularly in the kernel.
Work queues will put you in a process context trivially, so being
dropping the last ref from an irq handler and then needed process
context to do the cleanup is not a problem.

> Just an another argument why containers are easier/better and why you will
> eventually end up with it.

Does not follow.

Kirill you are not making all of your reasoning explicit and making
mistakes in the gaps.

The steps you are making seem to be.
containers are simpler.
simpler means easier to get correct.
bugs will happen.
therefore you will use the simpler solution.

The above reasoning seems to assume that containers are not prone
to the same reference counting bugs as namespaces.  Given that
we are solving the same problem in similar problems this seems 
unwarranted.

In addition the rejection of the basic container approach is largely
based upon lack of flexibility.  No amount of additional simplicity
can make up for not meeting real world requirements. 

Kirill there may be a case where your container concept performs
beautifully and simplifies the problem, but I have looked and I
have not seen it. 

Eric
