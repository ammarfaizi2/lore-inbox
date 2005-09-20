Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVITWIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVITWIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVITWIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:08:04 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:38529 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750818AbVITWID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:03 -0400
Message-ID: <43308815.1000200@comcast.net>
Date: Tue, 20 Sep 2005 18:07:17 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hot-patching
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Oftentimes distributions spin on a stable kernel, but occasionally
update it for security bugs.  This then demands a reboot, or you sit on
a buggy kernel for however long.

These bugfixes don't typically change the exported binary interface of
the existing functions being corrected, and so it would be feasible to
halt all processors and execute an atomic codepath to switch the symbols
in the running kernel to point to the replacement functions from the old
ones.  If big functions are split up into smaller ones, as long as the
interface is the same for all existing functions, it shouldn't matter as
well.

I'm curious though, we're seeing a pattern of 2.6.x -> 2.6.x.y ->
for(;;) 2.6.x.++y; the incrimental releases are pretty much bugfixes,
although they get to be mounting eventually.  I believe it would be
feasible to set up an internal kernel function to atomically replace
existing symbols with new, updated ones; but I'm not sure, as I've never
looked that deep into the kernel.  I'm thinking the following process
would do it though:

struct replace_syms {
	void *old_address; // Address to look up to replace,
			   // i.e. &sys_fork()
	void *new_address; // New address to replace with, i.e.
			   // &new_sys_fork();
};

 - Load module
 - Module calls atomic_replace_symbols(struct replace_syms changes[])
 - atomic_replace_symbols() freezes all other processors (SMP)
 - atomic_replace_symbols() disables preempt for itself
 - atomic_replace_symbols() turns off interrupt handling
 - atomic_replace_symbols() finds each old_address in the symbol table
   and replaces with each corresponding new_address
 - atomic_replace_symbols() sees {NULL,NULL} and decides it's done
 - atomic_replace_symbols() turns interrupt handling back on
 - atomic_replace_symbols() turns preempt back on
 - atomic_replace_symbols() un-halts all the CPUs
 - Module init is done

Of course the module could never be removed.  The pre-existing code
would continue to exist, and any CPU or thread executing in those
replaced functions would finish in the copy it started in; the new
copies would be used for future calls.  Because it's very un-nice to try
to figure out when a copy of the function is no longer being used, it
would be infeasible to later try to remove the module.

Besides getting rid of a pet peeve of mine (more rebooting than
absolutely necessary) and giving a way to continuously increase the size
of the running kernel with each bugfix, this has implications on servers
that don't want to reboot for whatever reason.  For enterprise
applications, it would be possible to fix a kernel bug or security hole
that hasn't been triggered by loading a module with the bugfixes,
effectively hot-patching the kernel.

Physically updating the kernel would be complex; the distribution would
have to install a new kernel, and install corresponding update modules
to avoid a reboot.  However, consider that the routine phases of early
boot "worked up until now," and you realize that as long as the hotfix
is loaded early, there's no real risk of triggering whatever bug it
fixes if you just install the new modules and load them early during boot.

Implementing this could be done via a script which scans for changes in
two kernel trees and notes all functions that need to be individually
built into the module.  These functions could be extracted from the
files and packed into a single module with wrapper code that facilitates
the hot-patching on load.  Exactly how to fully automate this is,
however, difficult.  Once the scripts and facilities are made, however,
it would be fully up to distribution maintainers to split out, compile,
and package hot-patches.

Security concerns with this are minimal; to exploit any added attack
vectors, an attacker needs module loading permissions.  This would mean
the attacker already has the system compromised.  Further, there are
"modules" that load into the kernel and supply a fork bomb defuser and
trusted path execution; these modules change things like sys_fork() and
basic filesystem symbols in a similar manner, so it's demonstratable
that the "added attack vectors" can just be embedded into the module
anyway.  At best, trying to "do it yourself" may produce a method that
won't quite work all the time; while using a supplied facility will give
a guarantee that it'll work.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDMIgUhDd4aOud5P8RAm3NAJwJBN7KHYAgD8NftZEqYrv6GRpSFgCfXwPK
44m+XbymTPaycZhuHIi8LeA=
=zrVt
-----END PGP SIGNATURE-----
