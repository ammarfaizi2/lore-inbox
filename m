Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWDNRDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWDNRDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 13:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWDNRDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 13:03:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15025 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751292AbWDNRDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 13:03:45 -0400
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH rc1-mm 2/3] coredump: shutdown current process first
References: <20060409001127.GA101@oleg>
	<20060410070840.26AE41809D1@magilla.sf.frob.com>
	<20060410140131.GB85@oleg> <m1hd4w4m84.fsf@ebiederm.dsl.xmission.com>
	<20060414153336.GB131@oleg>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 14 Apr 2006 11:02:04 -0600
In-Reply-To: <20060414153336.GB131@oleg> (Oleg Nesterov's message of "Fri,
 14 Apr 2006 19:33:36 +0400")
Message-ID: <m1slog2ir7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 04/14, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@tv-sign.ru> writes:
>> 
>> > On 04/10, Roland McGrath wrote:
>> >>
>> >> I would be inclined to restructure the inner loop something like this:
>> >> 
>> >> 		p = g;
>> >> 		while (unlikely(p->mm == NULL)) {
>> >> 			p = next_thread(p);
>> >> 			if (p == g)
>> >> 				break;
>> >> 		}
>> >> 		if (p->mm == mm) {
>> >> 			/*
>> >> 			 * p->sighand can't disappear, but
>> >> 			 * may be changed by de_thread()
>> >> 			 */
>> >> 			lock_task_sighand(p, &flags);
>> >> 			zap_process(p);
>> >> 			unlock_task_sighand(p, &flags);
>> >> 		}
>> >
>> > Yes, I agree, this is much more understandable.
>> 
>> There is one piece of zap_threads that still makes me uncomfortable.
>> 
>> task_lock is used to protect p->mm.
>> Therefore killing a process based upon p->mm == mm is racy
>> with respect to sys_unshare I believe if we don't take
>> task_lock.
>
> Well, unshare(CLONE_VM) is not yet supported. Currently (as I see
> it) mm->mmap_sem is enough to protect against changing ->mm. Yes,
> exit_mm/exec_mmap take task_lock too, so it can be used as well.
> Please correct my understanding.

So what has me unsettled is that task_lock is used to
protect p->mm.  The other place this could be a problem
is exit_mm.  But it does appear that deliberately takes the mm_sem
to prevent this problem.  So it looks like I was just missed
that trick.

> I think it is better to take ->mmap_sem in sys_unshare, this path
> is rare.

Agreed.

Eric
