Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272314AbTHSSZt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272309AbTHSSZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:25:49 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:48610
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S272585AbTHSSOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:14:11 -0400
Message-ID: <3F4268C1.9040608@redhat.com>
Date: Tue, 19 Aug 2003 11:13:21 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: NFS regression in 2.6
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is a problem which pops up in the glibc test suite.  It's been like
this for many weeks, even months.  I just hadn't time to investigate.
But the problem is actually very easy.

Go into a directory mounted via NFS.  You need write access.  Then
execute this little program:

#include <errno.h>
#include <error.h>
#include <stdlib.h>
#include <unistd.h>
int
main (void)
{
  char tmp[] = "estale-test.XXXXXX";
  int fd = mkstemp (tmp);
  if (fd == -1)
    error (EXIT_FAILURE, errno, "mkstemp failed");
  if (unlink (tmp) != 0)
    error (EXIT_FAILURE, errno, "unlink '%s' failed", tmp);
  int fd2 = dup (fd);
  if (fd2 == -1)
    error (EXIT_FAILURE, errno, "dup failed");
  if (ftruncate (fd2, 0) != 0)
    error (EXIT_FAILURE, errno, "ftruncate failed");
  return 0;
}

The result is always, 100% of the time, a failure in ftruncate.  The
kernel reports ESTALE.  This has not been a problem in 2.4 and not even
in 2.6 until <mumble> months ago.  And of course it works with local disks.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/QmjB2ijCOnn/RHQRAhMhAJ94N+/b7G1jC6XVUOwCv0/rZyeeIgCdH2zg
JxbK7PqAuSMmUKQX76CjNVM=
=XUXf
-----END PGP SIGNATURE-----

