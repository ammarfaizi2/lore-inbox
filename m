Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWCZGyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWCZGyD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 01:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWCZGyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 01:54:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:38808 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750804AbWCZGyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 01:54:01 -0500
X-Authenticated: #14349625
Subject: Re: swap prefetching merge plans
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <200603260944.26362.kernel@kolivas.org>
References: <20060322205305.0604f49b.akpm@osdl.org>
	 <Pine.LNX.4.61.0603251537290.16342@yvahk01.tjqt.qr>
	 <442560A3.8040200@yahoo.com.au>  <200603260944.26362.kernel@kolivas.org>
Content-Type: multipart/mixed; boundary="=-fF6lNsCbDVnXK+Bu/TMJ"
Date: Sun, 26 Mar 2006 07:54:57 +0200
Message-Id: <1143352497.7934.30.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fF6lNsCbDVnXK+Bu/TMJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2006-03-26 at 10:44 +1100, Con Kolivas wrote:
> On Sunday 26 March 2006 02:24, Nick Piggin wrote:
> > Jan Engelhardt wrote:
> > > When will Staircase go in?
> >
> > It is in... the queue ;)
> 
> Hah you wish.
> 
> No way would I let mainline benefit from something that good. I'm hoarding it 
> for -ck only.

Well, my box doesn't think it's _that_ good.  I just got done doing some
basic testing, and it is most definitely not ready for primetime.  It
has the same problem with sleep as the stock kernel does for instance.

This is bonnie competing with three sleeping cpu hogs.

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  1   3684  13824   4516 818888    0    1  2414  2510 1160  3062 54  5 29 12
 1  0   3684  14892   4528 817888    0    0    28  6940 1248  1779 98  2  0  0
 1  0   3684  13624   4532 819240    0    0     0     0 1097  1586 99  1  0  0
 1  0   3684  14556   4532 818284    0    0     0     0 1181  1709 99  1  0  0
 1  0   3684  13688   4532 819184    0    0     0     0 1193  2011 100  0  0  0
 1  1   3684  14252   4532 818528    0    0   128  5196 1441  1632 98  2  0  0
 1  0   3684  15028   4536 817804    0    0     0    80 1216  1735 99  1  0  0
 1  0   3684  13276   4536 819576    0    0     0     0 1157  1650 99  1  0  0
 1  0   3684  13976   4540 818832    0    0     4     0 1204  1793 99  1  0  0
 1  0   3684  14788   4544 817972    0    0     0     0 1087  1540 100  0  0  0
 2  0   3684  13408   4552 819412    0    0    80  6760 1237  1736 98  2  0  0
 1  0   3684  14260   4552 818596    0    0     0     4 1091  1564 99  1  0  0
 1  0   3684  13144   4556 819712    0    0     0     0 1223  1781 99  1  0  0
 1  0   3684  13704   4548 819176    0    0     0     0 1090  1546 99  1  0  0

(after short read, I see it wasn't allowed to compete)

Needless to say, I interrupted it.

It also fails the attached testcase.

	-Mike

--=-fF6lNsCbDVnXK+Bu/TMJ
Content-Disposition: attachment; filename=starve.c
Content-Type: text/x-csrc; name=starve.c; charset=us-ascii
Content-Transfer-Encoding: 7bit

#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/wait.h>

volatile unsigned long loop = 10000000;

void
handler (int n)
{
  if (loop > 0)
    --loop;
}

static int
child (void)
{
  pid_t ppid = getppid ();

  sleep (1);
  while (1)
    kill (ppid, SIGUSR1);
  return 0;
}

int
main (int argc, char **argv)
{
  pid_t child_pid;
  int r;

  loop = argc > 1 ? strtoul (argv[1], NULL, 10) : 10000000;
  printf ("expecting to receive %lu signals\n", loop);

  if ((child_pid = fork ()) == 0)
    exit (child ());

  signal (SIGUSR1, handler);
  while (loop)
    sleep (1);
  r = kill (child_pid, SIGTERM);
  waitpid (child_pid, NULL, 0);
  return 0;
}

--=-fF6lNsCbDVnXK+Bu/TMJ--

