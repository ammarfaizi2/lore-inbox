Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUENOcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUENOcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUENObo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:31:44 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:47004 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261179AbUENO0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:26:14 -0400
Subject: Re: [PATCH] capabilites, take 2
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: luto@myrealbox.com, chrisw@osdl.org,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
Content-Type: text/plain
Organization: 
Message-Id: <1084536213.951.615.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 May 2004 08:03:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski writes:

> Posix (as interpreted by Linux 2.4/2.6) says:
> pP' = (fP & cap_bset) | (fI & pI)
>
> So (assuming that set_security did the "obvious" (but dangerous) thing):
>
> pP := "task may enable and use these capabilities"
> pE := "task may use these capabilities _now_"
> pI := "task may gain these on exec from fI"
>
> fP := "this program gets these caps (module cap_bset)"
> fI := "this program gets these caps if pI says so"
>
> Which screams "overcomplicated."

People will screw this up.

That you should even have to explain the names as you do is an
indication that the names are poor.

Having names that match IRIX names but act differently is
a sure path to disaster via confused admins and developers.

> I see no particular invariants here, except for pE <= pP.
>
> IRIX (thanks Valdis) says:
>
> pI' = pI & fI
> pP' = fP | (pI' & fP)
>
> Which I interpret as
>
> pP := "task may enable and use these capabilities"
> pE := "task may use these capabilities _now_"
> pI := ~"task _loses_ these on exec"
>
> fP := "this program gets these caps"
> fI := "this program may keep these caps"
>
> This seems to want pP <= pI as an invariant.
>
> This is what I always thought Linux capabilities meant to be.  They
> don't make my brain hurt.
>
> But I also think they're overengineered.  Instead of:
>
> drop_caps_from_inheritable()
> exec()
>
> a program could do:
>
> drop_caps_from_permitted()
> exec()
>
> And I can't imagine what use fI != ~0 has, since it's trivially
> accomplished by a wrapper.  It is also trivially bypassed by
> loading the program manually (with ld.so).

Good point. Even if an exec-only executable would block this,
nearly all admins will fail to mark it as such.

> So, in my patch, I decided steal the inheritable mask to mean this:
>
> pI := "this process may gain these caps"
> fI := "this is an upper bound on pI"
>
> In other words, if a process is extra-untrusted (e.g. it's a daemon
> that never needs a certain capability and has no business trying
> to gain it), it can drop it from pI.  Then it cannot try to abuse
> programs with pP>0.  The setuid override is just added paranoia.
> Another benefit is that it allows a securelevel-like scheme, where
> even root isn't quite trusted.
>
> I suppose it might be inappropriate to steal this field like this,
> given that IRIX already has a (somewhat reasonable) use for it. I
> have no problem implementing IRIX-style capabilities and (if there
> is enough interest) adding a _fourth_ process field pM (process
> maximum capabilities) that does what my pI does.

A few mostly-unrelated thoughts:

Rather than adding a compile-time option or boot option, simply
change the syscall numbers and /proc/*/status names. This will
cause any existing capability-aware tools to act as if being
run on a pre-capability Linux kernel. This seems to be safer
than allowing these tools to assume that nothing has changed.

Allow me to mark an executable with a set of capabilities that
must be all set or all unset. Default to ~0ull for setuid apps,
and to 0ull for all other apps.
Like this:
   if ((pFOO & fBAR) != fBAR)    pFOO &= ~fBAR;

Before writing the kernel code, how about writing documentation
for admins, software developers, and Linux vendors? Until clear
and readable documentation exists, this is all just a hazard.
You might even make a mistake in the kernel code if it isn't
easy for a non-kernel hacker to review how things will interact
with their software. Just listing all the cases that need to
be reviewed would be an improvement.

This would be an excellent time to reconsider how capabilities
are assigned to bits. You're breaking things anyway; you might
as well do all the breaking at once. I want local-use bits so
that the print queue management access isn't by magic UID/GID.
We haven't escaped UID-as-priv if server apps and setuid apps
are still making UID-based access control decisions.



