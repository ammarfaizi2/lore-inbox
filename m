Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWD0JGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWD0JGA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 05:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWD0JGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 05:06:00 -0400
Received: from iona.labri.fr ([147.210.8.143]:44508 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S964991AbWD0JF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 05:05:59 -0400
Date: Thu, 27 Apr 2006 11:06:20 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org, bonachead@comcast.net, torvalds@osdl.org
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
Message-ID: <20060427090620.GF4649@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, bonachead@comcast.net,
	torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting a bit late in the discussion, but this is a bug that we've
here known for quite some time now. The easy fix for getting correct
concurrent writes was to add a pipe: instead of calling

my_parallel_program > log

just call

my_parallel_program | tee log

the pipe guarantees atomicity.

Another testcase was the following program:

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
  int n, num = 0, lus = 0;
  char c;

  if(argc >= 2) num = atoi(argv[1]) - 1;

  while (num) {
    if(fork() == 0) break;
    num--;
  }

  for(;;) {
    n = read(STDIN_FILENO, &c, 1);
    if(n == 1) lus++;
    else break;
  }

  printf("Proc %d read %d bytes\n", num, lus);
  return 0;
}

Running it with no parameter runs fine:

$ ls -l foo
-rwxr-xr-x 1 samy samy 8174 2006-04-07 11:21 testlocale
$ ./lire < foo
Proc 0 read 8174 bytes

Running it with a given number of processes shows the non-atomicity of
offset update, even on UP:

$ ./lire 2 < foo
Proc 0 read 3903 bytes
Proc 1 read 8174 bytes

And it is getting worse as the number of processes increase. When we
discovered this, we checked such atomicity (i.e. each byte of the file
is read exactly by one process) on several systems:

- As shown, linux completely fails.
- OS X almost succeeds: on a dual SMP system, with 10 processes on a
900KB file, 68 bytes got read by more that one process.
- OSF succeeds: on a 8-way SMP system, with 10 processes on a 50MB
file, _no_ byte got read by more than one process.
- Solaris completely fails.
- AIX completely fails.

So I guess that people should just _not_ rely on such atomicity.

Regards,
Samuel
