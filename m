Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbTDZREr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 13:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbTDZREr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 13:04:47 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:17793
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262849AbTDZREO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 13:04:14 -0400
Message-ID: <3EAABEB9.3030404@redhat.com>
Date: Sat, 26 Apr 2003 10:15:37 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030426
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 vsyscall DSO implementation
References: <200304250110.h3P1Aoo02525@magilla.sf.frob.com>
In-Reply-To: <200304250110.h3P1Aoo02525@magilla.sf.frob.com>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

- From what I've read here so far there were no objections.  The only
comments were to list the pages in /proc/*/maps and somehow make the DSO
available as a real file in the filesystem.

The first I think is reasonable.  But it is orthogonal to this patch.
It applies as well to the code currently in the kernel.  I'm pretty sure
we can arrange this to happen but it doesn't have to be in this patch.

As for the second, I do not think this is a good idea at all.  In theory
there could be more then one such DSO in use.  Without looking at the
actual process' address space it is not possible to determine which one
is used.  Roland also has IIRC a patch for ptrace() which allows it to
access the vsyscall page.  This is the method you'll have to apply.
Your remote debugger will in any case have to use ptrace(), so this is
no new requirement.

The fake kernel DSO will indeed be visible through the
_dl_iterate_phdr() function.  This means programs have easy access to it.


And a few more points on the DSO solution:

+ since the DSO is build just like an ordinary userlevel DSO there is
  no problem with writing the code which goes into it in C.  It is
  not necessary to do what is necessary for the current functions.

+ the DSO method allows to introduce new kernel interfaces which do
  not require new syscalls.  Well, somehow the kernel must be entered
  but how this happens is not visible to the user code.  This could
  mean using a syscall but the actual syscall number changes with
  every release.

+ the mechanism can easily be transferred to other architectures.  It
  could in theory mean using syscall numbers as the kernel interface
  can be abandoned.  Syscalls would be indentified by name at runtime
  (which is, I think, what most people think is the right solution).
  This has a slight runtime impact but it could be almost reduced to
  nil (maybe prelink is already capable of doing this).


Having said this, Linus, could you apply the patch if you have no
objections so that we can move on and add the remaining pieces?

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+qr652ijCOnn/RHQRAoZEAKCJ3D39tZubMFK+NBdoIHsixF3qhgCeMM/o
+IA3Hu+EMdNA+UYI4jlG6ys=
=ENqC
-----END PGP SIGNATURE-----

