Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVBLDTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVBLDTN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbVBLDTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:19:12 -0500
Received: from nevyn.them.org ([66.93.172.17]:43423 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262380AbVBLDTG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:19:06 -0500
Date: Fri, 11 Feb 2005 22:19:04 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Blocking behavior changed for pipes in 2.6.11-rc3
Message-ID: <20050212031904.GA18380@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This program [cribbed loosely from tst-cancel17.c in glibc] has changed
behavior with the recent pipe changes.  It used to block; which makes sense.
It gets the maximum buffer size for the pipe (or a page if that's larger),
and writes that many bytes plus two to it.  It reads one back.  The write
"shouldn't" have room to finish.

Checking the POSIX language for _PC_PIPE_BUF I think this is OK - it doesn't
say that no more bytes than that can be written at once, just that this is
the maximum which are guaranteed to be written atomically.  So I'm guessing
this change is a feature, not a bug.  Right?

[snip]

#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void *
tf (void *fd)
{
  int *fds = fd;
  char mem[1];
  read (fds[0], mem, 1);
}

int
main (void)
{
  pthread_t th;
  int len;
  int fds[2];

  if (pipe (fds) != 0)
    {
      puts ("pipe failed");
      return 1;
    }

  size_t len2 = fpathconf (fds[1], _PC_PIPE_BUF);
  size_t page_size = sysconf (_SC_PAGESIZE);
  len2 = (len2 < page_size ? page_size : len2) + 1 + 1;
  char *mem2 = malloc (len2);

  pthread_create (&th, NULL, tf, fds);
  write (fds[1], mem2, len2);

  return 0;
}

[/snip]

-- 
Daniel Jacobowitz
CodeSourcery, LLC
