Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbTEJTGF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264472AbTEJTGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:06:05 -0400
Received: from corky.net ([212.150.53.130]:52709 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S264471AbTEJTGC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:06:02 -0400
Date: Sat, 10 May 2003 22:18:34 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: arjanv@redhat.com, <masud@googgun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <Pine.LNX.4.44.0305102217300.1163-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 May 2003, Arjan van de Ven wrote:

> I'm pretty sure that auditing by your module can easily be avoided.
>
> examle: pseudocode for the unlink syscall
>
> long your_wrapped_syscall(char *userfilename)
> {
>     char kernelpointer[something];
>     copy_from_user(kernelpointer, usefilename, ...);
>     audit_log(kernelpointer);
>     return original_syscall(userfilename);
> }
>
> now.... the original syscall does ANOTHER copy_from_user().
> Eg I can easily fool your logging by having a second thread change the
> filename between the time your code copies it and the time the original
> syscall copies it again. The chances of getting the timing right are 50%
> at least (been there done that ;)
>
> The only solution for this is to check/audit/log things after the ONE
> copy. Eg not by overriding the syscall but inside the syscall.

been there done that, too :)

However, there is a solution.

Masud, your delay-based solutions won't work because an attack code can
just keep running in a loop until it gets the timing right.  Once is
enough.  Even if it could work, it would have impact on the whole system.
Afaik, you can't really yield the CPU for very short time slices so you'll
have to busy-loop instead, and its not acceptable.  I believe the below
solution is the right one.  Arjan, please correct me if I'm wrong.

The solution is to have only ONE REAL copy, done by the wrapper.  The
original syscall will copy from a kernel ptr, unknowingly.  Consider
the following modified pseudo-code:

long your_wrapped_syscall(char *userfilename)
{
    char kernelpointer[something];
    copy_from_user(kernelpointer, usefilename, ...);
    audit_log(kernelpointer);
    old_fs = get_fs();
    set_fs(KERNEL_DS);
    ret = original_syscall(kernelpointer);
    set_fs(old_fs);
    return ret;
}

userfilename is only copied once.  original_syscall just copies
kernelpointer again, to another kernel pointer.  No race.

Now, don't get me wrong - I still think intercepting the syscall is not
the right thing to do in this case, since LSM provides hooks in better
locations.  However, Masud has a working module that works this way, and
rewriting it for LSM is probably a headache.  No reason for him to rewrite
his module if it can be fixed as I suggested above.

Still, in my opinion, this symbol should remain exported, if only for test
modules like the one suggested by Muli.  I use them all the time.

Another thing to be considered is kernel newbies.  Most people, when
getting started in the kernel, do it by writing module.  One of the best
ways to understand certain parts of the kernel is to intercept some
syscalls and playing with them.  I gave some courses about it in the past,
and syscall intercepting was always a good exercise for newbies.  Face it,
most people can learn better by playing then by reading the code.

Removing this symbol will not really get in the way for the bad guys
because it'll always be possible to find and intercept it anyway (see my
previous post in this thread), but it'll increase the learning curve for
kernel newbies.  Do we really want that ?

	Yoav Weiss


