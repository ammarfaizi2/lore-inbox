Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVBAVqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVBAVqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 16:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVBAVqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 16:46:19 -0500
Received: from gizmo07bw.bigpond.com ([144.140.70.42]:31903 "HELO
	gizmo07bw.bigpond.com") by vger.kernel.org with SMTP
	id S262130AbVBAVqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 16:46:14 -0500
Message-ID: <41FFF89E.20708@bigpond.net.au>
Date: Wed, 02 Feb 2005 08:46:06 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] sys_setpriority() euid semantics fix
References: <20050120172506.GA20295@elte.hu> <87wtu6fho8.fsf@sulphur.joq.us> <20050122165458.GA14426@elte.hu> <87hdl940ph.fsf@sulphur.joq.us> <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu> <20050125135613.GA18650@elte.hu> <41F6C5CE.9050303@bigpond.net.au> <20050126092014.GA7003@elte.hu> <41FEB951.8070307@bigpond.net.au> <20050201101105.GA28194@elte.hu>
In-Reply-To: <20050201101105.GA28194@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>I've just noticed what might be a bug in the original code.  Shouldn't
>>the following:
>>
>>       if ((current->euid != p->euid) && (current->euid != p->uid) &&
>>               !capable(CAP_SYS_NICE))
>>
>>be:
>>
>>       if ((current->uid != p->uid) && (current->euid != p->uid) &&
>>               !capable(CAP_SYS_NICE))
>>
>>I.e. if the real or effective uid of the task doing the setting is not
>>the same as the uid of the target task it is not allowed to change the
>>target task's policy unless it is specially privileged.
> 
> 
> no. The original code is quite logical: when doing something to others,
> only the euid is taken into account. When others do something to you,
> both the uid and the euid is checked ('others' might have no idea about
> this task temporarily changing the euid to a less/more privileged uid). 
> So sys_setscheduler() [and sys_setaffinity(), which does the same] is
> fine.

I disagree.  Logically, the only privileges that should be relevant are 
those of the task making the change i.e. those of current.  The 
effective uid of the target task is irrelevant.  If only the effective 
uid counts for determining what a task can do then the statement can be 
simplified to:

        if ((current->euid != p->uid) && !capable(CAP_SYS_NICE))

but I think that this is wrong as having an effective uid that is 
different to the real uid doesn't cancel the privileges assoctaied with 
the real uid.

The way uid and effective uid effect a task's operations on files are a 
guide to their logical application in cases like this.

Since this operation is usually performed by a task on itself it 
probably doesn't matter.  But when task A is trying to change the policy 
of task B then it is the privileges of the task A that count and all 
that is relevant about task B is who its real owner is.

For example, if a user A ran a program that was setuid to an 
unprivileged user B then A would be unable (from within that program) to 
change the policy of any RT tasks that she had running to SCHED_NORMAL 
unless those tasks were also setuid to B.  I agree that this is a highly 
unlikely circumstance but it does serve to illustrate the point w.r.t. 
what is logical.

> 
> what _is_ inconsistent is kernel/sys.c's setpriority()/set_one_prio(). 
> 
> It checks current->euid|uid against p->uid, which makes little sense,

I think that this is correct.

> but is how we've been doing it ever since. It's a Linux quirk documented
> in the manpage. To make things funnier, SuS requires current->euid|uid
> match against p->euid.

I've just read the man page and I think that the description of what 
Linux does (or is supposed to do) is correct/logical and that the other 
behaviors described are (very) illogical.  In any case, the change that 
I suggested will make the behaviour match what the man page says.

> 
> The patch below fixes it (and brings the logic in line with what
> setscheduler()/setaffinity() does), but if we do it then it should be
> done only in 2.6.12 or later, after good exposure in -mm.
> 
> (Worst-case this could break an application but i highly doubt it: it at
> most could deny renicing another task to positive (or in very rare
> cases, to negative) nice values, which no application should crash on
> something like that, normally.)

Yes, it's fairly benign.  Especially as most common use of this would be 
tasks calling it on themselves.  I'm not going to lose any sleep over it :-)

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
