Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUJESoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUJESoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUJESmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:42:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:40675 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263117AbUJESm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:42:27 -0400
X-Authenticated: #885628
Date: Tue, 5 Oct 2004 20:49:49 +0200
From: Dominik Vogt <dominik.vogt@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: dominik.vogt@gmx.de
Subject: SECURITY BUG: Symlink exploit in 2.6.8 ia64 build scripts
Message-ID: <20041005184949.GA24154@gmx.de>
Reply-To: dominik.vogt@gmx.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-PGP-Key: http://www.dominikvogt.de/gpg/pubkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The 2.6.8 kernel sources (and earlier 2.6.x versions) are
susceptible to temporary filename attacks.  In the arch/ia64
branch, there are several scripts that are vulnerable to known
temporary filename attacks:

  scripts/check-gas
  scripts/toolchain-flags
  sn/runsim

All three write to temporary files named out$$, out$$.o or tmp.$$
where $$ is replaced with the process pid.

A local attacker can use symlinks to let the build processes
overwrite any file if they are executed as root.

Exploit script:

  $ cd /tmp || exit 1
  $ for i in `seq 32767`; do ln -s owned out.$i.o; done
  $ cd <path_to_2.6.8 sources>
  $ make ARCH=ia64

should demonstrate the problem, but I can't test it as I don't
have an ia64 cross compiler.  However, I can see that, for
example, the line

   gcc -c <path>/arch/ia64/scripts/check-gas-asm.S -o /tmp/out29763.o

is executed, and if I remove the contents of check-gas-asm.S, the
symlink attack does work (i.e. the file /tmp/owned is
overwritten).

Proposed fix:

Normally, I would fix that by using the mktemp command to generate
the temporary filenames, but I'm not sure that is acceptable for
the kernel:

  umask 077
  out=`mktemp "$tmp/outXXXXXXXX.o"` || exit 1

An alternate solution might be

  umask 077
  set -C

(Please CC me)

Ciao

Dominik ^_^  ^_^

 --
Dominik Vogt, dominik.vogt@gmx.de

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQFBYuzNmeSprTOr4tgRAs1CAJ9itnpG/5jg1DdRYe3a8nyCcZ5LFgCggfup
tY7z1DkHBCZ8S+AcpZw7MBk=
=roeU
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
