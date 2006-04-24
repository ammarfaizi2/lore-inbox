Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWDXLOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWDXLOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 07:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWDXLOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 07:14:03 -0400
Received: from [212.33.165.125] ([212.33.165.125]:28940 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750730AbWDXLOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 07:14:01 -0400
From: Al Boldi <a1426z@gawab.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
Date: Mon, 24 Apr 2006 14:12:13 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200511142327.18510.a1426z@gawab.com> <200604240756.42483.a1426z@gawab.com> <20060423221157.6a4b5c8e.akpm@osdl.org>
In-Reply-To: <20060423221157.6a4b5c8e.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604241412.13267.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Al Boldi <a1426z@gawab.com> wrote:
> > This is a another resend, which was ignored before w/o comment.
> > Andrew, can you at least comment on it?  Thanks!
>
> I don't have a clue what it's for.

Quoting from the 'Resource limits' thread on lkml on 27/09/05:
>>>>> Consider this dilemma:
>>>>> Runaway proc/s hit the limit.
>>>>> Try to kill some and you are denied due to the resource limit.
>>>>> Use some previously running app like top, hope it hasn't been killed
>>>>> by some OOM situation, try killing some procs and another one takes
>>>>> it's place because of the runaway situation.
>>>>> Raise the limit, and it gets filled by the runaways.
>>>>> You are pretty much stuck.
>>>>
>>>> Not really, this is the sort of thing ulimit is meant for.  To keep
>>>> processes from any one user from running away.  It lets you limit the
>>>> damage it can do, until such time as you can control it and fix the
>>>> runaway application.
>>>
>>> threads-max = 1024
>>> ulimit = 100 forks
>>> 11 runaway procs hitting the threads-max limit
>>
>> This is incorrect.  If you ulimit a user to 100 forks, and 11 processes
>> running with that uid
> 
> Different uid.
> 
Then yes, if you set a system-wide limit that is less than the sum of the 
limits imposed on each accountable part of the system you can have lock out.  
But thats your fault for misconfiguring the system.  Don't do that.

-- end of quote

> > --- kernel/fork.c.orig  2005-11-14 20:55:33.000000000 +0300
> > +++ kernel/fork.c       2005-11-14 20:58:25.000000000 +0300
>
> Please prepare patches in `patch -p1' form.

Ok.

> >         if (nr_threads >= max_threads)
> > +       if (p->pid != su_pid)
> >                 goto bad_fork_cleanup_count;
>
> We don't lay code out in that manner.  Not even vaguely.

Like so?
	if (nr_threads >= max_threads)
		if (p->pid != su_pid)
			goto bad_fork_cleanup_count;

> This check comes after the RLIMIT_PROC check, which is supposed to
> eliminate "process lockout situations", although you haven't really
> defined that.

RLIMIT_PROC is per user, this patch solves the global limit.

> >         if (!try_module_get(p->thread_info->exec_domain->module))
>
> Your email client replaces tabs with spaces.
>
> >         KERN_SETUID_DUMPABLE=69, /* int: behaviour of dumps for setuid
> > core */
>
> And it wordwraps.

I am using kmail, it does this when the mail is queued before sending it.  
Maybe somebody can point out how to instruct kmail not to do that?

Or maybe use an attachment?

Theodore Ts'o wrote:
> On Mon, Apr 24, 2006 at 07:56:42AM +0300, Al Boldi wrote:
>> 
>> Simple attempt to provide a backdoor in a process lockout situation.
>> 
>> echo $$ > /proc/sys/kernel/su-pid allows pid to exceed the threads_max
>> limit.
>
> Why not just have the root process do:
>
> echo {larger number} > /proc/sys/kernel/nr-threads instead?

Could do that by:

	# echo 1 > /proc/sys/kernel/su-pid

which would imply nr-threads = 1
	
So maybe introduce /proc/sys/kernel/nr-threads to allow that to be variable, 
but this isn't really critical.

Thanks!


