Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131617AbRCSVpS>; Mon, 19 Mar 2001 16:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131627AbRCSVpI>; Mon, 19 Mar 2001 16:45:08 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:16134 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S131617AbRCSVpF>; Mon, 19 Mar 2001 16:45:05 -0500
Date: Mon, 19 Mar 2001 21:44:19 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: Topi Miettinen <Topi.Miettinen@koti.tpo.fi>
cc: <linux-kernel@vger.kernel.org>, <security-audit@ferret.lmh.ox.ac.uk>
Subject: Re: [PATCH] Non-root sshd and capabilities
In-Reply-To: <20010318181419.A4197417C@smtp.koti.soon.fi>
Message-ID: <Pine.LNX.4.30.0103192053520.29611-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[cc: security-audit, because it's interesting :-)]

On Sun, 18 Mar 2001, Topi Miettinen wrote:

> (Please cc: me, I'm not subscribed.)
>
> Using the magical prctl() call it's possible to run daemons as non-root
> while still possessing some capabilities. For full support, patched kernel
> with ext2 capabilities is required, but if the daemon doesn't exec()
> anything (for example, by emulating exec() with mmap()), stock 2.4 is
> enough.

Kernel 2.2.18 (I think) also added this prctl().

> This works well for programs like pppd, hwclock and XFree86. There is a
> problem if the daemon uses setuid() and setgid() to change identity, like
> sshd or cron. In function cap_emulate_setxuid() (in kernel/sys.c) the
> capabilities are cleared when IDs are switched. However, the check misses
> the case where old_*uid are already nonzero. This patch attempts to fix
> the problem.

[...]

> Any suggestions?

No comments on the patch/bug you've highlighted, but I've got some
comments on the general approach.

Firstly, changing sshd so it runs with minimal privilege, is an excellent
project. You only need to look at the recent deattack.c vulnerability to
see why. I was going to tackle this once I finished vsftpd (also makes use
of capabilities and the prctl()).

However, I don't think running any daemon with CAP_SETUID can be
considered running with "minimal privilege". With CAP_SETUID, you can
change your uid to the owner of any number of critical system files, and
gain full access, as if you hadn't bothered using capabilities at all.
Even inside a chroot() jail, you have to be careful with CAP_SETUID. Think
"ptrace(), sysctl()".

Of course, _something_ needs to have CAP_SETUID, otherwise you cannot
switch to the authenticated userid at all. The solution is to have a
minimal privileged helper process, which takes authentication details from
the main sshd process over a pipe or socket. The helper process carefully
validates the authentication details, and if they are correct, switches to
the authenticated user, drops privileges, and runs some action on behalf
of sshd.

The above is a bit of hassle, but extremely powerful and secure. If you
also throw in a bit of chroot(), you can make future sshd holes very low
severity indeed.

For bonus points, make sure that sensitive information such as the private
host key, is only accesible to the privileged helper. Trickier (maybe not
feasible), but useful.

Finally, a comprised sshd session should not be able to compromise other
sshd sessions. This can be accomplished by ensuring the sshd session
processes all have "dumpable == 0" in the kernel, e.g. by starting sshd as
root and doing setuid() to some other userid without any exec()

Cheers
Chris

