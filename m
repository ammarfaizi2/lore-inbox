Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVC1ST6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVC1ST6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVC1ST5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 13:19:57 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:31703 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261958AbVC1STw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 13:19:52 -0500
Message-ID: <42484B13.4060408@comcast.net>
Date: Mon, 28 Mar 2005 13:21:07 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, ubuntu-hardened@lists.ubuntu.com
Subject: Collecting NX information
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Greetings.

Currently I'm in need of some information about both vanilla and Exec
Shield kernels in regards to markings emitted by the toolchain,
specifically PT_GNU_STACK.  I'd like to check my assumptions, in
preparation for possibly making a non-intrusive change which would allow
the PT_PAX_FLAGS from PaX to be used in a more finegrained way than
PT_GNU_STACK is used now to control mainline and exec shield memory
protections.

As I understand, PT_GNU_STACK uses a single marking to control whether a
task gets an executable stack and whether ASLR is applied to the
executable.  I would like more information on this.  To start, I'll
supply some background on why I need this information.

PaX uses its own markings, PT_PAX_FLAGS, to control the way PaX applies
protections to processes.  In particular, PaX supplies the following
markings:

P  - PAGEEXEC (NX bit or emulated NX bit)
S  - SEGMEXEC (NX emulation on x86, ignored for our purposes)
E  - EMUTRAMP (Trampoline emulation, to avoid giving an executable stack
               in situations where nested functions are used)
M  - MPROTECT (mprotect() restrictions, to control kernel policy on how
               memory protections may be applied in userspace)
R  - RANDMMAP (mmap() base randomization, for libraries, PIEs, anonymous
               segments, etc; also controls all other randomization
               except RANDEXEC)
X  - RANDEXEC (random ET_EXEC base)

Each marking has three states:  On, Off, and Neutral.  The Neutral
marking takes the most restrictive setting by default, except in the
case of RANDEXEC, in which it's off because RANDEXEC can crash things
easily.  A sysctl in PaX can switch the Neutral logic, except for RANDEXEC.

For our purposes, SEGMEXEC is completely ignored; aside from x86 PaX,
SEGMEXEC has no impact on anything.  PAGEEXEC is equivalent to using the
processor supplied facilities to enforce PROT_EXEC (or emulation to do
such on x86).

I believe that these could map easily to PT_GNU_STACK's functionality:

P  - Page-based PROT_EXEC enforcement.  With this off, PROT_EXEC has no
     effect.  This is slightly different than normal PT_GNU_STACK
     (executable stack).
R  - Randomization.  With this off, the ASLR for stack, heap, mmap(),
     etc are disabled.
E  - Trampoline Emulation, port this from PaX in the future

If PT_PAX_FLAGS exists (the logic to check and read it can be derived
from PaX), these markings should be used; else, PT_GNU_STACK should be
fallen back to.  This would have no effect on any current distributions;
however, future development could mark for any situation and potentially
have one marking which simultaneously make the program work under PaX,
Exec Shield, and Vanilla.

The default state (when these are Neutral) would be the more
restrictive, of course; that is, PRe would be equal to ---.

Trampoline emulation would allow for a task to use nested functions with
a non-executable stack.  This would allow some PT_GNU_STACK markings to
come off for i.e. x86-64 and for Exec Shield.

Currently my understanding of how PT_GNU_STACK affects mainline and exec
shield kernels is very limited.  The above is what I came up under the
assumption that it simply allows the stack to be made executable and
allows ASLR to be turned off with one setting, rather than individual
fine-grained settings; I may need more information.  If anyone has any
suggestions, comments, etc, I'd like to hear them.

To do this, I'd pretty much simply have to port over the part of PaX
which checks for PT_PAX_FLAGS and if it can't find it falls back to
EI_PAX, changing that to falling back to PT_GNU_STACK and appropriate
code; and tweak the code to reflect mainline rather than a PaX kernel.
Not sure how I'd do that exactly, but I have a whole week off work and
class somehow so maybe I'll learn something.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCSEsThDd4aOud5P8RAnh8AJ9dv11ozerlf5MKGzeFIyvLpucjtACfV+vF
Ll8bAJBbTCReRBwToCGVX/c=
=1qEV
-----END PGP SIGNATURE-----
