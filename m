Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbTJAX4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTJAX4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:56:33 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:11936 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262673AbTJAX4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:56:31 -0400
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
From: Albert Cahalan <albert@users.sf.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       perfctr-devel@lists.sourceforge.net,
       Albert Cahalan <albert@users.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065051745.736.39.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Oct 2003 19:42:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-01 at 11:11, Linus Torvalds wrote:
> On Wed, 1 Oct 2003, Mikael Pettersson wrote:
> >
> > Linus' 2.6.0-test6 announcement doesn't seem to mention the
> > fact that 2.6.0-test5-bk9 fundamentally changed the semantics
> > of /proc/self and the /proc/<pid> name space.
> 
> Well, that's because the semantics weren't _supposed_ to change. The new 
> semantics were meant to be a superset of the old behaviour, with just the 
> added "task" subdirectory that lists the actual threads.
> 
> However, you're right that "/proc/self" should likely point into the
> _thread_, and not into the task. But it's debatable. You are very likely 
> the only one who could ever care ;)

That seems likely to break other stuff, as new-style
threads become more common. Right now, many tools are
unaware of new-style threads. Pointing at the tgid
directory (POSIX PID directory) lets tools ignore threads.

> > I don't actually disagree with the change, but it took me by
> > surprise since neither the 2.6.0-test6 annoucement nor the
> > diff between the t5-bk8 and t5-bk9 logs seem to mention it.
> 
> Well, the changelog mentions "fix for hidden task problem", since the diff 
> really is mainly to _add_ threads to the /proc layout. The fact that it 
> changed /proc/self is actually a bit surprising. Albert?

This is an interesting problem for sure. The link was
pointing to a directory that didn't get listed, except
that CLONE_THREAD wasn't exactly a popular feature yet.
So it was very seldom that the distinction mattered.

Currently, I rely on checking for /proc/self/task to
see if threads can be examined. Like this:

task_dir_missing = stat("/proc/self/task", &sbuf);

That wouldn't work if /proc/self pointed at the task.

It certainly seems to me that the intent of /proc/self is
to point to a "process", which is a tgid in kernel terms.
Back in the 2.4.xx days, that was a pid in kernel terms.
Now that we have CLONE_THREAD and the tgid, a "process"
is represented by the tgid. Pointing to the tgid matches
what other OSes do.

I think there is something clearly defective about having
the /proc/self link point to a hidden directory. It could
be pointed at /proc/42/task/58 and such I guess, but I
think tools could break as new-style threads begin to get
used in the real world.


