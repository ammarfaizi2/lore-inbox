Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWDSI1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWDSI1G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 04:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWDSI1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 04:27:06 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17028 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750761AbWDSI1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 04:27:04 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [RFC] PATCH 0/4 - Time virtualization
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Apr 2006 02:25:00 -0600
In-Reply-To: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org> (Jeff
 Dike's message of "Thu, 13 Apr 2006 13:19:36 -0400")
Message-ID: <m1d5feotur.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> writes:

> This set of patches implements 
> 	time virtualization by creating a time namespace
> 	an interface to it through unshare
> 	a ptrace extension to allow UML to take advantage of this
> 	UML support
>
> The guts of the namespace is just an offset from the system time.  Within
> the container, gettimeofday adds this offset to the system time.  settimeofday
> changes the offset without touching the system time.  As such, within a 
> namespace, settimeofday is unprivileged.
>
> The interface to it is through unshare(CLONE_TIME).  This creates the new
> namespace, initialized with a zero offset from the system time.
>
> The advantage of this for UML is that it can create a time namespace for itself
> and subsequently let its process' gettimeofday run on the host, without
> being intercepted and run inside UML.  As such, it should basically run at
> native speed.
>
> In order to allow this, we need selective system call interception.  The
> third patch implements PTRACE_SYSCALL_MASK, which specifies, through a 
> bitmask, which system calls are intercepted and which aren't.

That patch should probably be separated, from the rest.
But it looks like a fairly sane idea. 


> Finally, the UML support is straightforward.  It calls unshare(CLONE_TIME)
> to create the new namespace, sets gettimeofday to run without being 
> intercepted, and makes settimeofday call the host's settimeofday instead
> of maintaining the time offset itself.

I think you missed a couple essential things to a time namespace.
Timers.  The posix timers, in particular.  The worst
of those is the monotonic timer.  

In the case of migration the ugly case to properly handle is the
monotonic timer.   That needs an offset yet it is absolutely forbidden
to provide that offset from the inside.  So this is the one namespace
that I think is inappropriate to use sys_unshare to create.
We need a system call so that we can specify the minimum or the
starting monotonic time base.

I don't know how we want to describe time while a process is not
inside of a kernel.

> As expected, a gettimeofday loop runs basically at native speed.  The two
> quick tests I did had it running inside UML at 98.8 and 99.2 % of
> native.

Interesting.

> BUG - as I was writing this, I realized that refcounting of the time_ns
> structures is wrong - they need to be incremented at process creation and
> decremented at process exit.

Actually the more I think of the using PTRACE to help with some of
these issues the more I like it.  It's only real alternative is a
security module, and that must be written as kernel code.

The reference counting is terrible, as you don't free syscall_mask,
during ptrace_detach.

As a comparison what is the overhead if you don't use syscall_mask,
and just do a ptrace_cont on the system call you want to let through?

Eric
