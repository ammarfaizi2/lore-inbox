Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283243AbRLRAAF>; Mon, 17 Dec 2001 19:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283223AbRLQX7z>; Mon, 17 Dec 2001 18:59:55 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:62728 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283204AbRLQX7q>; Mon, 17 Dec 2001 18:59:46 -0500
Message-ID: <3C1E86BD.43EAB279@zip.com.au>
Date: Mon, 17 Dec 2001 15:58:53 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: war <war@starband.net>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Limits broken in 2.4.x kernel.
In-Reply-To: <3C1E5A88.57F5A68A@starband.net>,
		<3C1E5A88.57F5A68A@starband.net> <shspu5dv3w4.fsf@charged.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> 
> >>>>> " " == war  <war@starband.net> writes:
> 
>      > Problem: Per-user process limits to not work correctly with a
>      > 2.4.x kernel.
> 
>      > Say I want to limit a user to [5] processes.
> 
>      > Example: Edit [/etc/security/limits.conf]
>      >               user hard nproc 5 -or- @group hard nproc 5
> 
>      > The result: The user cannot login.
> 
>      > How to fix?
> 
> One thing I noticed when doing the BSD cred patch for 2.5.x is that
> somebody broke the process accounting in 2.[45].x at least for the
> case of reparent_to_init():

That would be me.

> If you just charge current->user without moving over the process from
> the old uid to the new uid (such as is done in kernel/sys.c with the
> set_user() routine) then you risk seriously corrupting the counters.
>
> I'm not sure really what the point was of setting the user in
> reparent_to_init() in the first place, since it doesn't setreuid().

reparent_to_init() is there to cope with various strange things
which occur when a kernel thread is parented by a userspace process.
It's called after daemonize(), so the thread can no longer participate
in filesystem related things.

I think what you've pointed out here is yet another problem with
the idea of having kernel threads parented by user processes: they
articificially increase the user's process count.

I didn't have a clear reason for moving the UID to root's - it just
didn't seem a good idea to have kernel threads running with non-root
UIDs.   But we have a reason now - process accounting.

reparent_to_init() needs to decrement current->user's processes count,
and increment root's.  I'll do a patch.

-
