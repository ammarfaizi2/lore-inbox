Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVAWEoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVAWEoJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 23:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVAWEoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 23:44:08 -0500
Received: from h80ad2661.async.vt.edu ([128.173.38.97]:1285 "EHLO
	h80ad2661.async.vt.edu") by vger.kernel.org with ESMTP
	id S261218AbVAWEnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 23:43:43 -0500
Message-Id: <200501230443.j0N4h6DA023479@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Rik van Riel <riel@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8 
In-Reply-To: Your message of "Sun, 23 Jan 2005 01:52:13 +0100."
             <20050123005213.GK7587@dualathlon.random> 
From: Valdis.Kletnieks@vt.edu
References: <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random> <20050122103242.GC9357@elf.ucw.cz> <20050122172542.GF7587@dualathlon.random> <20050122194242.GB21719@elf.ucw.cz> <20050122233418.GH7587@dualathlon.random> <Pine.LNX.4.61.0501221943050.7152@chimarrao.boston.redhat.com>
            <20050123005213.GK7587@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106455385_3985P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 22 Jan 2005 23:43:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106455385_3985P
Content-Type: text/plain; charset=us-ascii

On Sun, 23 Jan 2005 01:52:13 +0100, Andrea Arcangeli said:

> Why should I be kidding? The client code I'm doing, has to be at least as secure

Maybe in your estimation it *has* to be that secure.  However, actual experience
with other operating systems indicate that the mail programs and web browsers
have *higher* security requirements than ssh - because ssh can afford to trust
legitimate users, while MUAs and browsers have to protect the system against
actions taken by legitimate users.

> as ssh and the firewall code, what else has to be more secure than that?

Mail programs, web browsers, and I'm sure there's plenty of applications in
the various Three Letter Agencies that want even more security.

It's a poor idea to confuse "secure" with "can't break out of the sandbox".

> Nor ssh nor the firewall code depends on ptrace for their security. The

And they don't even depend on seccomp or ptrace for the security either...

> Once seccomp is in, I believe there's a chance that security people uses
> it for more than Cpushare while I don't think there's a chance you'll

Security people probably won't be interested, specifically because it's
way too inflexible.  Very few real-life applications can be made to fit
into a "open all the files you might need, then shut yourself into a 
read/write syscalls only" model.

In fact, a case could be made that the unnatural contortions needed to
restructure applications into a seccomp model actually *decrease* the
overall security, because of more complicated setup code being more
vulnerable to attack.  Also, the fact that you need to keep open() out
of the permitted set for seccomp to make any sense means that you need to
open all the possible files up front.  So now you're handing the program
*more* access to files than they should....

> see security people using ptrace_syscall hardcoding the syscall numbers

Oh, come *ON*, Andrea.  This is a red herring and you *know* it.  The only
people who will be hardcoding syscall numbers are the same idiots that
hardcoded capability masks instead of "#include <linux/capability.h>" and
using the CAP_* defines.

> in every userland app out there that may have to parse untrusted data
> with potentially buggy bytecode (i.e. decompression bytecode etc..).

And if a filename has a runtime dependency on the untrusted data (consider
any sort of web server or browser or mail program or anything else that
accepts a "suggested filename" as input), things get very difficult very quickly.

I can pass ptrace a SYSCALL_OPEN, and then call my untrusted code, and then
look at the filename at runtime and see if there's something hinky going on.
I can even apply heuristics like "The first file opened should be THIS one,
then THOSE 4 shared libraries in order, then THIS file, and then the NEXT file
is dependent on user input, but has to start with $USER/tmp/workdir, and then
there's two other opens of files X and Y, and then no others should happen".
Using seccomp, you don't get that choice.  You either have to jump through
hoops to get all that set up beforehand, or allow open() in all its glory.

--==_Exmh_1106455385_3985P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB8ytZcC3lWbTT17ARAqlqAJ4ixnygZk5dclkcENtjNMcqGdha5QCdHfKm
TUvAVKfcHjbnSUtLF8nSp2c=
=4XU+
-----END PGP SIGNATURE-----

--==_Exmh_1106455385_3985P--
