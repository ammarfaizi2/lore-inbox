Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310224AbSCLADj>; Mon, 11 Mar 2002 19:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310223AbSCLADa>; Mon, 11 Mar 2002 19:03:30 -0500
Received: from mail.rttinc.com ([139.142.30.71]:58891 "HELO mail.rttinc.com")
	by vger.kernel.org with SMTP id <S310212AbSCLADN>;
	Mon, 11 Mar 2002 19:03:13 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Brad Pepers <brad@linuxcanada.com>
Organization: Linux Canada Inc.
To: Andi Kleen <ak@suse.de>
Subject: Re: Multi-threading
Date: Mon, 11 Mar 2002 17:02:50 -0700
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020311182111Z310364-889+120750@vger.kernel.org.suse.lists.linux.kernel> <p73zo1e4voi.fsf@oldwotan.suse.de>
In-Reply-To: <p73zo1e4voi.fsf@oldwotan.suse.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020312000319Z310212-889+120887@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 March 2002 14:54, Andi Kleen wrote:
> Brad Pepers <brad@linuxcanada.com> writes:
> > there is a very complex multi-process dance involving (apparently)
> > multiple debugger interactions per wake up.  Kinda like the
> > guys who designed the threads didn't talk to the guys who designed
> > ptrace or one or the other didn't care.
>
> I guess the new futex mechanism that is currently
> designed/debugged/discussed will take care of that.  It doesn't require
> signals anymore. Unfortunately it is probably some time off until it can be
> used generally, but at least it is worked on

I'll watch the futex development than and wait for it do be available.

> atomic_dec_and_test() ?

Handles the most common case but not general enough for all cases and its 
sister function atomic_inc_and_test is pretty useless.

> atomic_dec_and_return() doesn't strike me as too useful, because
> it would need to lie to you. When you have a reference count
> and you unlink the object first from public view you can trust
> a 0 check (as atomic_dec_and_test does). As long as the object
> is in public view someone else can change the counts and any
> "atomic return" of that would be just lying. You can of course
> always use atomic_read(), but it's not really atomic. I doubt the
> microsoft equivalent is atomic neither, they are probably equivalent
> to atomic_inc(); atomic_read(); or atomic_dec(); atomic_read() and
> some hand weaving.

Apparently the Microsoft one really is in Windows 98 and up (not in 95).  
I've had it explained that the asm code (semi-pseudo code here) is like this:

        movl       reg, #-1
        lock xadd  reg, counter
        decl       reg
        movl       result, reg

This is in comparison to the current code which does something like this:

        lock decl counter
        sete      result

I don't see how the first asm code lies to you.  It is returning the value as 
it was decremented to and the lock on the xadd keeps it safe.

> BTW regarding atomic.h: while it is nicely usable on i386 in userspace
> it isn't completely portable. Some architectures require helper functions
> that are hard to implement in user space.

Its too bad Linux didn't have a nice wrapper around atom inc/dec/test that 
was completely portable.  Do you know what arch's have trouble implementing 
this?

-- 
Brad Pepers
brad@linuxcanada.com
