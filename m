Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbVITH6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbVITH6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVITH6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:58:00 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:38105 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964918AbVITH57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:57:59 -0400
Date: Tue, 20 Sep 2005 00:57:43 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: zippel@linux-m68k.org, akpm@osdl.org, torvalds@osdl.org,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050920005743.4ea5f224.pj@sgi.com>
In-Reply-To: <20050915104535.6058bbda.pj@sgi.com>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<20050912043943.5795d8f8.akpm@osdl.org>
	<20050912075155.3854b6e3.pj@sgi.com>
	<Pine.LNX.4.61.0509121821270.3743@scrub.home>
	<20050912153135.3812d8e2.pj@sgi.com>
	<Pine.LNX.4.61.0509131120020.3728@scrub.home>
	<20050913103724.19ac5efa.pj@sgi.com>
	<Pine.LNX.4.61.0509141446590.3728@scrub.home>
	<20050914124642.1b19dd73.pj@sgi.com>
	<Pine.LNX.4.61.0509150116150.3728@scrub.home>
	<20050915104535.6058bbda.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Either I'm as dense as a petrified log, or we are still talking past
each other on this topic of what locking is needed in cpuset_exit()
when clearing tsk->cpuset, checking the cs->count and checking for
notify_on_release.

You're saying I don't need the spinlock when clearing tsk->cpuset in
cpuset_exit(), and I am saying that I do need cpuset_sem when handing
the count field if notify_on_release is enabled.

    You keep saying I don't need the spinlock, and showing code that
    has -neither- lock around the section that checks or decrements
    the count and conditionally does the notify_on_release stuff.

    I keep protesting that the portion of your code that handles the
    count and notify_on_release stuff is unsafe, which I believe it
    is, for lack of holding cpuset_sem.

    You keep pointing out that the clearing tsk->cpuset doesn't need
    the spinlock to be safe.

I agree that I don't need the spinlock when clearing tsk->cpuset in the
cpuset_exit code:

> > 	tsk->cpuset = NULL;
> > 	if (atomic_read(&cs->count) == 1 && notify_on_release(cs)) {

But I do need to hold cpuset_sem around the portion that deals with
count, if the cpuset is marked notify_on_release, to avoid missing a
notify_on_release due to confusions from a second task in cpuset_attach
or cpuset_exit at the same time.

If I don't hold cpuset_sem while doing that atomic_read(&cs->count),
then that atomic_read() is utterly totally bleeping useless, for
attach_task can bump the count right back up on the next memory
cycle, from some other task on another cpu.  Worse than totally
useless, because I might have read a count of 2, just as the other
task executing the same cpuset_exit code at the same time also read a
count of 2.  Then we both decrement the count, and abandon the cpuset,
failing to handle the notify_on_release.

Similarly, the atomic_dec(&cs->count) a few lines later, also
unguarded by cpuset_sem, is not safe, if I have a cpuset marked
notify_on_release.  If I am not holding cpuset_sem, then regardless of
any checks I might have made in previous lines of code, the cs->count
could be one (1) when I get here, and the atomic_dec() could send it to
zero without my realizing it, resulting in a missed notify on release.

Unless I hold cpuset_sem, modifying cs->count is only safe if I don't
care to look at the result, as happens in fork when I blindly increment
it, or happens in exit if notify_on_release is false and I can blindly
decrement the count.  Reading cs->count when not holding cpuset_sem is
never of any use for reference counting purposes, for what you read
means nothing one cycle later.

We were talking past each other.  I'm sure of it.

And I'm pretty sure I understand enough of this to code it now.

So I plan to put it aside for a few days, while I tend to more
pressing matters.

Thank-you, Roman.  I owe you one.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
