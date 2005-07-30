Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263196AbVG3Xub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbVG3Xub (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 19:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263198AbVG3Xub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 19:50:31 -0400
Received: from smtpauth03.mail.atl.earthlink.net ([209.86.89.63]:24212 "EHLO
	smtpauth03.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S263196AbVG3Xu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 19:50:26 -0400
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: sigwait() breaks when straced
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 21.4.1
Date: Sat, 30 Jul 2005 19:50:10 -0400
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1Dz15m-0000sO-Qx@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d47826f234369f82662f80f78c1dae2055da8e4562d45b0cc31f350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> If you think it is a linux bug, can you produce small test case doing
> just the sigwait, and post it on l-k with big title "sigwait() breaks
> when straced, and on suspend"?

Here it is.  I haven't tested the sigwait()+suspend lately, since
suspend isn't working with any kernel except 2.6.11.4 and I'm chasing
down other acpi errors in 2.6.13-*.  But here's a test case for how
sigwait() breaks when straced (see C file below).  It is with 2.6.13-rc4
on a Thinkpad 600X (Pentium III), Debian 'testing', libc
2.3.2.

  $ gcc waiting.c -o waiting -lpthread
  $ ./waiting
  Sigwaiting...[strace my pid, which is 3359]
  [in another shell I run 'strace -p 3359', and get:]
  sigwait() returned 4, errno=0, sig=77

In the strace window, I get 

  $ strace -p 3359
  Process 3359 attached - interrupt to quit
  write(2, "sigwait() returned 4, errno=0, s"..., 39) = 39
  exit_group(4)                           = ?
  Process 3359 detached

According to the man entry for sigwait:

       The !sigwait! function never returns an error.

so the return value should not be 4 (or the docs are not right).

Here's waiting.c:

#include <stdio.h>
#include <pthread.h>
#include <signal.h>
#include <errno.h>

sigset_t mask;

int main () {
  int ret, id;
  int sig = 77;			/* easy to see if it gets changed */

  id = getpid();
  sigemptyset(&mask);
  fprintf (stderr, "Sigwaiting...[strace my pid, which is %d]\n", id);
  ret = sigwait(&mask, &sig);
  fprintf (stderr,
	   "sigwait() returned %d, errno=%d, sig=%d\n",
	   ret, errno, sig);
  return ret;
}


-Sanjoy

`A society of sheep must in time beget a government of wolves.'
   - Bertrand de Jouvenal
