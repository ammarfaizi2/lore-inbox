Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTHTTDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbTHTTDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:03:52 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:58857
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262148AbTHTTDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:03:50 -0400
Message-ID: <3F43C5D4.9010704@redhat.com>
Date: Wed, 20 Aug 2003 12:02:44 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030731 Thunderbird/0.2a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no
CC: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
References: <3F4268C1.9040608@redhat.com>	<shszni499e9.fsf@charged.uio.no>	<20030820192409.A2868@pclin040.win.tue.nl> <16195.49464.935754.526386@charged.uio.no>
In-Reply-To: <16195.49464.935754.526386@charged.uio.no>
X-Enigmail-Version: 0.81.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Trond Myklebust wrote:

> In short the scenario should be that
> 
>   - mkstemp() does an open(O_EXCL) -> nfs_lookup() creates hashed
>     negative dentry -> nfs_create() then does an O_EXCL call to the
>     server and instantiates the dentry.
> 
>   - unlink() walks the pathname -> finds the existing dentry using
>     cached_lookup() and only calls down to nfs_lookup_revalidate().

Sounds reasonable especially since the dup() call in my original example
isn't necessary.  So, the shortened test case is this:

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
  if (ftruncate (fd, 0) != 0)
    error (EXIT_FAILURE, errno, "ftruncate failed");
  return 0;
}

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE/Q8XU2ijCOnn/RHQRAtMYAJ9CgabR0FdQFG8Sobkrfv9aKloDmQCWN28G
QUj8oMiKWM7v61yupENQ+Q==
=fzKm
-----END PGP SIGNATURE-----

