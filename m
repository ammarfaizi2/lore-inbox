Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWDJHnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWDJHnL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 03:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWDJHnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 03:43:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14563 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750884AbWDJHnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 03:43:10 -0400
To: Petr Baudis <pasky@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dumpable tasks and ownership of /proc/*/fd
References: <20060408120815.GB16588@pasky.or.cz>
	<m17j5yhtp4.fsf@ebiederm.dsl.xmission.com>
	<20060410065332.GD16588@pasky.or.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 10 Apr 2006 01:42:03 -0600
In-Reply-To: <20060410065332.GD16588@pasky.or.cz> (Petr Baudis's message of
 "Mon, 10 Apr 2006 08:53:32 +0200")
Message-ID: <m1r745ho6s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis <pasky@ucw.cz> writes:

> Dear diary, on Mon, Apr 10, 2006 at 07:43:03AM CEST, I got a letter
> where "Eric W. Biederman" <ebiederm@xmission.com> said that...
>> Speaking of things why does the *at() emulation need to touch
>> /proc/self/fd/*?  I may be completely dense but if the practical
>> justification for allowing access to /proc/self/fd/ is that we
>> already have access then we shouldn't need /proc/self/fd.
>> 
>> I suspect this a matter of convenience where you are prepending
>> /proc/self/fd/xxx/ to the path before you open it instead of calling
>> fchdir openat() and the doing fchdir back.  Have I properly guessed
>> how the *at() emulation works?
>
> Ok, now I'm not completely following you. Only i386 and x86_64 appears
> to provide the openat() syscall (only in new kernels, furthermore) and
> glibc otherwise emulates openat(n, "relpath") with
> open("/proc/self/fd/<n>/relpath"). I don't know of any other way how to
> emulate it.

I can think of a couple of ways, but thanks for confirming
I properly guessed how the openat emulation was working.

The first point to note is that fixing proc and exporting
syscalls to new architectures is going to take about equally
long with a chance that fixing proc will take longer because
that needs to be understood.

With that said I can think of a couple of different ways
to implement openat that won't have proc permission problems.

The most straight forward is:
int openat(int dirfd, const char *path, int flags, int mode)
{
        int orig_dir_fd;
        int result;
	lock()
	orig_dir_fd = open(".");
	fchdir(dirfd);
        result = open(relpath);
        fchdir(orig_dir_fd);
        close(orig_dir_fd);
        unlock();
        return result;
}

I suspect something like the above needs to be considered if
you want the emulation to work on old kernels, in the presence
of suid applications.

I will look at fixing proc but I none of my work on /proc
is going to get merged until 2.6.18 at this point.

I doubt a proc permission change could count as a simply
a bug fix, and even then it doesn't matter because it won't
be available for your emulation.

Although I guess you could attempt to use /proc/self/fd/<n>
and if that gets a permission problem try a slower but more
reliable path in the emulation.

Eric


