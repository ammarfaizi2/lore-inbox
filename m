Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWDEUgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWDEUgd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 16:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWDEUgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 16:36:33 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47515 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750776AbWDEUgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 16:36:33 -0400
Message-Id: <200604052036.k35KaQXk021296@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Herbert Rosmanith <kernel@wildsau.enemy.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Robin Holt <holt@sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Q on audit, audit-syscall 
In-Reply-To: Your message of "Wed, 05 Apr 2006 22:04:55 +0200."
             <200604052004.k35K4u56010157@wildsau.enemy.org> 
From: Valdis.Kletnieks@vt.edu
References: <200604052004.k35K4u56010157@wildsau.enemy.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1144269386_4315P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Apr 2006 16:36:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1144269386_4315P
Content-Type: text/plain; charset=us-ascii

On Wed, 05 Apr 2006 22:04:55 +0200, Herbert Rosmanith said:

> (1) CONFIG_AUDIT and CONFIG_AUDITSYSCALL: how do I use that from
>     userspace? is it possible at all (1.1) to use this from userspace or
>     (1.2) is this a "kernel-only" infrastructure provided for other
>     kernel-modules only (such as e.g. LSM?). is there a description
>     of this interface and how and where to use it? I cannot find it.
>     clear enough?

'man auditd' and friends.  This is providing after-the-fact reporting
of security-related events for audit and forensic analysis.  We have *no*
idea if it will fill your needs, because you have explained what you're
trying to *do* with ptrace.  If you merely need a record that a syscall
happened, this is what you want.  If you want to apply a security restriction,
you want to look at SELinux or perhaps a custom LSM.  If you have some
other need, you need some other tool.

So what problem are you trying to solve by using ptrace()?

> (2) in linux/Documentation/devices.txt I've found an "audit device":
> 
>         103 block       Audit device
>                           0 = /dev/audit        Audit device
> 
>     which software implements this device? I see no block-device
>     registration in linux/kernel/audit.c nor in linux/kernel/auditsc.c.
>     Booting a kernel with CONFIG_AUDIT* enabled does not show this
>     device in /proc/devices.
> 
>     so, what the deal with this block device? clear enough?

"That is an old worn-out magic word" -- ADVENT.FOR

I think that's a leftover from before the audit subsystem was converted
to use netlink.

> (3) audit-1.1.5/lib is using "socket(PF_NETLINK,SOCK_RAW,NETLINK_AUDIT)"
>     is this the way to communicate with the audit-system enabled by
>     CONFIG_AUDIT/_AUDITSYSCALL? or is this something different.

Well, this is how auditd talks to the netlink socket.  Whether it supports
the functionality you need in a unpatched kernel depends on what you're
trying to do (which you still haven't explained).

> > otherwise it's impossible to help you.  You want to trace and  
> > intercept syscalls, no?
> 
> > It implicitly doesn't make any sense to try to trace and intercept syscalls
> > from one process in more than one other.
> 
> I'm pretty sure I can find a quote from the fortune program saying
> that "if something does not make sense for you, that doesnt mean that it wont
> make sense for someone else". In fact, it makes sense for me.

Good. Please enlighten us what the proper system behavior is, if *two* processes
are ptrace()ing the same target process - and one specifies PTRACE_CONT and
the other PTRACE_SINGLESTEP (or other conflicting pairs of requests...)
Handling two PTRACE_{GET|POKE}* requests for the same data looks massively
racy as well, as there's no defined way to say what order to handle them.

But hey - if you're comfortable and get warm fuzzies about the idea that one
process could use PTRACE_POKEDATA to set the variable 'a_upper_lim' to 23, and
the other could use it to set a_upper_lim to -10, and then execution resumes
with no clear indication of which one actually gets used, that's OK by us...

(Or for more fun - what if one process sends a PTRACE_CONT before the other one
gets a shot at it to do the PTRACE_POKEDATA, at which point you're storing into
a already-running process (bonus points for knowing if the live value is in a
register or in memory at the time you get there with a non-stopped process ;)

> I wonder if IBM and SuSE/Novell are right when they write in~\ref{1}:
> 
> \begin{quote}
> The vanilla 2.6 Linux kernel does not provide a mechanism to
> trace syscalls in the desired way, nor does it contain the
> capability to to track process and generate an audit trail.
> \end{quote}

LAuS was a long-ago predecessor of the current audit system.  At the time
it was written, it was correct, but it no longer is.


--==_Exmh_1144269386_4315P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFENCpKcC3lWbTT17ARAjWOAKDa7GS6yWF/YKInexW1BYLA/+9JNACeKD7y
v3jMp33z941kxS1zeuBWkG4=
=MumO
-----END PGP SIGNATURE-----

--==_Exmh_1144269386_4315P--
