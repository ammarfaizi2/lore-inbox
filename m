Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWDNIF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWDNIF5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 04:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWDNIF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 04:05:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59563 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751110AbWDNIF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 04:05:56 -0400
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH rc1-mm 2/3] coredump: shutdown current process first
References: <20060409001127.GA101@oleg>
	<20060410070840.26AE41809D1@magilla.sf.frob.com>
	<20060410140131.GB85@oleg>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 14 Apr 2006 02:04:11 -0600
In-Reply-To: <20060410140131.GB85@oleg> (Oleg Nesterov's message of "Mon, 10
 Apr 2006 18:01:31 +0400")
Message-ID: <m1hd4w4m84.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 04/10, Roland McGrath wrote:
>>
>> I would be inclined to restructure the inner loop something like this:
>> 
>> 		p = g;
>> 		while (unlikely(p->mm == NULL)) {
>> 			p = next_thread(p);
>> 			if (p == g)
>> 				break;
>> 		}
>> 		if (p->mm == mm) {
>> 			/*
>> 			 * p->sighand can't disappear, but
>> 			 * may be changed by de_thread()
>> 			 */
>> 			lock_task_sighand(p, &flags);
>> 			zap_process(p);
>> 			unlock_task_sighand(p, &flags);
>> 		}
>
> Yes, I agree, this is much more understandable.

There is one piece of zap_threads that still makes me uncomfortable.

task_lock is used to protect p->mm.
Therefore killing a process based upon p->mm == mm is racy
with respect to sys_unshare I believe if we don't take
task_lock.

Eric
