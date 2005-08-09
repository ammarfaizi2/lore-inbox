Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbVHIE7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbVHIE7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVHIE7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:59:18 -0400
Received: from nef2.ens.fr ([129.199.96.40]:59396 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1750938AbVHIE7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:59:18 -0400
Date: Tue, 9 Aug 2005 06:59:17 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: understanding Linux capabilities brokenness
Message-ID: <20050809045916.GA3157@clipper.ens.fr>
References: <20050808211241.GA22446@clipper.ens.fr> <20050808223238.GA523@clipper.ens.fr> <dd8r9s$eqn$1@taverner.CS.Berkeley.EDU> <20050809015048.GA14204@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809015048.GA14204@thunk.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Tue, 09 Aug 2005 06:59:17 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2005 at 01:53:50AM +0000, Theodore Ts'o wrote:
> The POSIX specification for capabilities requires filesystem support,
> so that each executables can be marked with three capability sets ---
> which indicate which capabilities are asserted when the executable
> starts, which capabilities the executable is allowed to request, and
> which capabilities the executable is allowed to inherit from its
> parent process.  This effectively takes a single setuid bit and splits
> it into a hundred-odd bits.  

You point out various reasons why the POSIX (draft-)specification is
problematic.  But nobody says Linux has to abide it, especially as it
is a mere withdrawn draft.  Solaris 10 has capabilities (except that
they're called "privileges") which are similar, but not identical, to
the POSIX ones.

And even capabilities with no filesystem support can be useful.  In
fact, as far as I see it, the main interest in capabilities lies in
the "process management" part.  For example, I might like to run this
or that binary, which claims it needs to be run as root, with a
limited set of capabilities: the current Linux kernels make this quite
impossible.  Conversely, I might wish to give a particular capability
to a given user; in association with sudo, this might be quite useful:
instead of telling sudo to let the user run a given command as root,
just let him run a capability-aware wrapper which drops every
capability except the required ones and then calls the actual program
- so even if the latter is not secure, damage is more limited.  I can
think of thousands of other uses not requiring any kind of filesystem
support.

>					    Note that many some setuid
> programs don't necessarily check error returns, and sometimes turning
> off permissions can sometimes open up vulnerabilities.

Yes, the sendmail vulnerability proved this quite clearly.  So
certainly a luser should not be permitted to run a suid root program
with anything in between the empty set and the full set of
capabilities.

> Another problem with the POSIX capabilities is that most of the
> programs that system administrators run to look for setuid programs
> will miss programs that have capabilities encoded in extended
> attributes.  This problem could be fixed by requiring the setuid bit
> to be set before paying attention to the capability EA's; but this
> could lead to surprising results if the filesystem is mounted on a
> system that doesn't use filesystem capabilities at all.

I might suggest encoding the presence of capabilities by a sgid bit
for a specific group (say, wheel) on top of the extended attributes.
So the careful sysadmin will notice the programs (because sgid wheel
is significant enough to be noted) but it will not cause total
disaster if mounted on a non-capability-capable ;-) filesystem.

> Yet another issue is that the POSIX capabilities model means that a
> default executable, such as gcc for example, is not allowed to inherit
> _any_ capabilities, even if it is run from a setuid root shell.  This
> is good from a security point of view, since it means that people
> can't get in trouble by doing silly things like typing
> "./configure;make" as root and expect any of the build tools to have
> override arbitrary file controls.  The bad news is that system
> administrators aren't particularly happy when their own private tools
> have to especially marked to allow them to run with elevated
> privileges.

Yes, this seems like a reason to deviate from the POSIX model under
Linux.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
