Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTKZQxH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 11:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTKZQxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 11:53:07 -0500
Received: from chaos.analogic.com ([204.178.40.224]:58241 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264256AbTKZQwe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 11:52:34 -0500
Date: Wed, 26 Nov 2003 11:54:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: BUG (non-kernel), can hurt developers.
Message-ID: <Pine.LNX.4.53.0311261153050.10929@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note  to hackers. Even though this is a lib-c bug, be
aware that many versions of the 'C' runtime library
have a rand() function that can (read will) segfault
in threads or signals.

		glibc-2.1.3
		libc.so.6

Are two culprits. This "little" problem just took me
a week to find. Rand() was used as a source of test
data in a system diagnostic. The diagnostic kept blowing
up. The following code tests for the problem.

//-----------------
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/time.h>

static int spare;
static int inside;
void handler(int unused)
{
    struct itimerval it;
    inside++;
    spare = rand();
    it.it_interval.tv_sec = 0L;
    it.it_interval.tv_usec = 0L;
    it.it_value.tv_sec = 0L;
    it.it_value.tv_usec = 1L;
    (void)signal(SIGALRM, handler);
    setitimer(ITIMER_REAL, &it, &it);
    inside--;
}
void bad(int sig)
{
    char *where;
    if(inside)
      where = "inside";
    else
      where = "outside";
   fprintf(stderr, "Failed %s handler on %d\n", where, spare);
   exit(EXIT_FAILURE);
}
int main(void);
int main()
{
    (void)signal(SIGSEGV, bad);
    handler(0);
    for(;;)
        (void)rand();
    return 0;
}
//---------------------


Run this for a few minutes.

Script started on Wed Nov 26 11:50:23 2003
$ gcc -Wall -o xxx -O2 xxx.c
$ ./xxx
Failed inside handler on 1735818301
$ ./xxx
Failed inside handler on 129960814
$ ./xxx
Failed inside handler on 1999426653
$ exit
exit
Script done on Wed Nov 26 11:50:52 2003


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


