Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBWROt>; Fri, 23 Feb 2001 12:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRBWROa>; Fri, 23 Feb 2001 12:14:30 -0500
Received: from 196-41-175-253.citec.net ([196.41.175.253]:37556 "EHLO
	penguin.wetton.prism.co.za") by vger.kernel.org with ESMTP
	id <S129093AbRBWROT>; Fri, 23 Feb 2001 12:14:19 -0500
Date: Fri, 23 Feb 2001 19:13:45 +0200
From: Bernd Jendrissek <berndj@prism.co.za>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new setprocuid syscall
Message-ID: <20010223191345.A5166@prism.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

(Please CC me - I am not subscribed)

BERECZ Szabolcs (szabi@inf.elte.hu) wrote:
>  Here is a new syscall. With this you can change the owner of a running
>  procces.

Stupid question: why?  Not so stupid: why, giving examples?  Does the
target process expect to be re-owned?  Remember that a process can easily
remember its original uid, and become confused later after you stole it.

>  +++ linux-2.4.1-setprocuid/kernel/sys.c Mon Feb 19 21:52:51 2001
[...]
>  +asmlinkage long sys_setprocuid(pid_t pid, uid_t uid)
>  +{
>  + struct task_struct *p;
>  +
>  + if (current->euid)
>  + return -EPERM;
>  +
>  + p = find_task_by_pid(pid);
>  + p->fsuid = p->euid = p->suid = p->uid = uid;
>  + return 0;
>  +}

How about a *slow* (for everyone) setprocuid(2)?  Is it still possible in
current kernels to "lock out" all other processes even on SMP boxen?  If 
so, make sure the target is not in a syscall (EAGAIN until it's out), then
change the world.  Or, ...

A gross hack: make a special case in do_signal that overloads some
rarely-used signal.  Send that signal with needed magic to the target.
When the target wants to re-enter userland for whatever reason, it notices
that this ain't a signal, but a backdoor to make it change its uid *itself*
so the assumption

Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> There is an assumption in the kernel that only the task changes its
> own uid and other related data.

remains true.  setprocuid(2) blocks until the signal is delivered.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6lppADaF1aCTutCYRAiKnAJ4jHUTN9XfsaVXlOnuhQy4JtS/slACcCr17
1g5KvyDY7LCFGFKG/BZIfC4=
=DUal
-----END PGP SIGNATURE-----
