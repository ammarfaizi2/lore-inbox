Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263522AbTC3GKK>; Sun, 30 Mar 2003 01:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263523AbTC3GKJ>; Sun, 30 Mar 2003 01:10:09 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:18825
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S263522AbTC3GKI>; Sun, 30 Mar 2003 01:10:08 -0500
Message-ID: <3E868CDC.9030002@redhat.com>
Date: Sat, 29 Mar 2003 22:21:16 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: readlink in /proc w/ overlong path
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Trying to read the overlong target of a /proc/*/fd/N file descriptor
leads with the current BK kernel to a segfault in the kernel.  This is
on x86 but I have no doubt it's a generaic error.  The following the
program illustrates the problem.

#include <errno.h>
#include <error.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
int
main (void)
{
  const char s[] =
    "test_____________________________________________________________";
  int i;
  for (i = 0; i < 100; ++i)
    {
      mkdir (s, 0777);
      chdir (s);
    }
  int fd = open ("aaa", O_RDWR | O_CREAT);
  write (fd, "a", 1);
  char buf[200];
  sprintf (buf, "/proc/self/fd/%d", fd);
#define N 200000
  char *buf2 = (char *) malloc (N);
  if (buf2 == NULL)
    error (EXIT_FAILURE, errno, "failed to get memory");
  int n = readlink (buf, buf2, sizeof (buf2));
  if (n < 0 || n > N)
    printf ("readlink returned %d\n", n);
  else
    {
      buf2[n] = '\0';
      printf ("n = %d, %s\n", n, buf2);
    }
  return 0;
}


- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+hozc2ijCOnn/RHQRArauAJ980Mp4qO8bNQGEVilMFaG3c7Td5ACfTG1q
Rid/4i37aESW5H4U7K7dk5k=
=oyl+
-----END PGP SIGNATURE-----

