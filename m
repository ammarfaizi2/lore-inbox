Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWAXDjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWAXDjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 22:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWAXDjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 22:39:49 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:20056 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030282AbWAXDjt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 22:39:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eLNmYoOn8frCXxw3A9Y2VviHUVCfZGQ2ALAblhXMzETbEpQ7ftSmzW0lgmpFc8P4bQ2AvpYI/IiRCj7fLsLv00GmoIIwXwCDR6NUefcSgRgUIz0yF7TZnPZq3ust+cjmpMHenpUkJw2WhjqXcPTv5lZPbc9EH5WH2XTKt+urOqE=
Message-ID: <787b0d920601231939x1cf519e1x540316c06973de58@mail.gmail.com>
Date: Mon, 23 Jan 2006 22:39:48 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: anon unions are cool
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
In-Reply-To: <m1wtgqls23.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601221636h7acbb891wd52b88e0aea75aaf@mail.gmail.com>
	 <5AB1D65D-8F03-4CDF-9847-D75143EC0A9C@mac.com>
	 <787b0d920601221717v460283eclc72380ae541d7fef@mail.gmail.com>
	 <m1wtgqls23.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Albert Cahalan <acahalan@gmail.com> writes:
>
> > This case is rather interesting. At more than one place I've worked,
> > I found people assuming that the kernel's "pid" was a pid, when in
> > fact it is a tid. (a "task ID" or "thread ID") The confusion probably
> > leads to kernel bugs. I've seen many bugs related to this, though I
> > can't be 100% sure that they don't all involve code that existed prior
> > to the tgid concept.
>
> Actually this is a really weird area.  A lot of it depends on your
> perspective.  current->pid is more than just a thread group ID.

It's not a thread group ID at all. It's a task ID or thread ID.

The thread group ID is something different. It's the same as
a POSIX process ID. The kernel uses "tgid" as the name.

At least you're not alone in your confusion. :-)

> You can always use kill to send a signal to the ``pid'' of any
> task.  However if that task is part of a thread group the signal
> might go to one of that threads siblings.

This is sort of a bug really, though we're probably stuck
with it now. You should get errno=ESRCH when you use
an ID that does not match up with a tgid.

The "feature" doesn't work for thread group leaders
because kill() doesn't let you specify that you really
want to address the task rather than the task group.
We have tkill() and tgkill() to address this problem.

> If you were to follow the normal rules and send to a signal
> to a thread group.  All threads would get it.  Although I
> don't think the kernel has code for that.

That would be wrong for most signals. The kernel follows
the POSIX behavior, with "process" being struct signal or
the tgid. A few signals, like SIGKILL, go the the whole process.
All others are delivered to the first task willing to take it,
which is how POSIX treats a process with threads. (there
is also different behavior for per-task stuff like SIGSEGV)

> So from a signal perspective current->pid is the pid.

Aside from bugs, no.

> However get_pid has been modified to return the thread group id.
> Instead of the PID.  And a lot of times when you are exporting
> information to user space you want the thread group id.
>
> But in practice neither thread ID nor process ID map directly
> to the kernels concept.

They sure do, unless you play with abnormal clone() flags.

> Then there is the other weird side where only the leaders of
> thread groups are placed in sessions and process groups.

That's not at all weird. It fits perfectly with the use of the tgid
as the POSIX PID and the use of the "pid" (ugh) as the POSIX
thread ID.

Aside from POSIX just being arguably weird, the only weird
things here are:

1. kill() not returning errno=ESRCH when it should
2. the name "pid" being used oddly in the kernel
