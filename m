Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTKTTyZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTKTTyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:54:25 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:54424
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261812AbTKTTyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:54:21 -0500
Message-ID: <3FBD1BD2.908@redhat.com>
Date: Thu, 20 Nov 2003 11:53:54 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031118 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: process file descriptor limit handling
X-Enigmail-Version: 0.82.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040408020107060702060001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040408020107060702060001
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The current kernel (and all before as far as I can see) have a problem
with the file system limit handling.  The behavior does not conform to
the current POSIX spec.

Look at the attached example code.  The programs opens descriptors up to
the limit, then lowers the limit, closes a descriptor below the number
given to the last setrlimit call, and tries to open a descriptor.  This
currently succeeds.

The problem is that RLIMIT_NOFILE is defined as the number of open
descriptors.  In the example case, before the final open call, there are
N1-1 open descriptors, with RLIMIT_NOFILE set to N2 (which is << N1).
The open call should fail.  Another, more common solution, is to have
the setrlimit call fail in case the new limit is larger than the largest
file descriptor in use.  Returning EINVAL in this case is just fine and
is apparently what other platforms do.


One could also take the position that the current behavior has it's
advantages.  A program could open all the file descriptors it needs, and
then close a few which can be used to open some files for the normal
mode of operation.  Possible, maybe even quite secure, but still smells
a bit like a hack.

It might also be that some wording is getting in the specification which
will allow the current kernel behavior to continue to exist.  More
through a loophole, but still.


Anyway, I think the existing behavior is probably an oversight.  Whether
it is worth keeping is a question somebody (= Linus) will have to
answer.  My  recommendation is probably, to make setrlimit fail.

- --
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/vRvS2ijCOnn/RHQRAl4HAKDK3xp5vydo1bqfDNvVZUCxObukMQCeI/1l
xFnOkWYL4iXmzqjVuIXfYWI=
=ftW/
-----END PGP SIGNATURE-----

--------------040408020107060702060001
Content-Type: text/x-c;
 name="t.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="t.c"

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/resource.h>

int
main (void)
{
#define N1 100
  struct rlimit r;
  r.rlim_cur = N1;
  r.rlim_max = N1;
  setrlimit (RLIMIT_NOFILE, &r);
  int i;
  int fd[N1];
  for (i = 0; ; ++i)
    if ((fd[i] = open ("/dev/null", 0)) < 0)
      {
        if (i == N1 - 3)
          printf ("fine, %d file descriptors open\n", N1);
        else
          {
            puts ("*** make sure the parent doesn't open any descriptors other than 0, 1, 2");
            return 1;
          }
        break;
      }
#define N2 50
  r.rlim_cur = N2; 
  r.rlim_max = N2; 
  int e = setrlimit (RLIMIT_NOFILE, &r);
  if (e == EINVAL)
    {
      puts ("good, setrlimit sees the open descriptors");
      return 0;
    }
  getrlimit (RLIMIT_NOFILE, &r);
  if (r.rlim_cur != N2 || r.rlim_max != N2)
    {
      puts ("getrlimit returned different values");
      return 1;
    }
  close (fd[N2 - 4]);
  fd[N2 - 4] = open ("/dev/null", 0);
  if (fd[N2 - 4] != -1)
    {
      printf ("opening a new descriptor succeeded even though %d are open and the limit is %d\n",
              N1 - 1, N2);
      return 1;
    }
  return 0;
}

--------------040408020107060702060001--
