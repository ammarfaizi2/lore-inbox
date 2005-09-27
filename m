Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbVI0XUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbVI0XUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbVI0XUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:20:35 -0400
Received: from newpeace.netnation.com ([204.174.223.7]:13979 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id S1751147AbVI0XUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:20:34 -0400
Date: Tue, 27 Sep 2005 16:20:34 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Strangeness with signals
Message-ID: <20050927232034.GC6833@netnation.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

I'm not sure if this is buggy, strange or just perfectly normal
behaviour.  I was trying to write an application that does some simple
network performance polling with setitimer() and also keeps a look out
for SIGWINCH to see if the window size changes.  I was interested to
find out that when I resized the window, the signal was never noticed.
Even more interesting is the fact that if I run it in strace or even
GDB to figure out what's going on, it works!

I've simplified the program to this simple test case which will show
clearly that (both on 2.4 and 2.6), SIGALRM and SIGHUP are received as
expected but that without setting a special sa_sigaction handler,
SIGWINCH and SIGCHLD don't appear to wake up sigwaitinfo().  Also,
applying a sigaction() to all signals won't change the situation unless
an sa_sigaction is set; sa_handler does not appear to change anything.

Some people mentioned blocked and ignored signals, but as can be seen in
this example, differing behaviour can be seen across signals even with
all signals blocked and ignored.

Usage:

gcc -o sigweird sigweird.c && ./sigweird

In another window, "killall -WINCH sigweird" and "killall -HUP sigweird". 
Note the differing behaviour. :)

Try running "strace sigweird" or "strace -p `pidof sigweird`".  Note
how the behaviour changes.

Try changing the second "#if 0" to "#if 1" to enable setting the same
signal handlers exactly for all of the signals.  Note that the behaviour
does not change.

Try changing the first "#if 0" to "#if 1".  Note how all signals now
appear to behave similarly, with or without strace/GDB.

CHLD and WINCH seemed to be dropped without an sa_sigaction while HUP and
ALRM seem to work as expected.  This might have something to do with
their default behaviour.

Broken?  Bizarre?

Simon-

--n8g4imXOkfNTN/H1
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="sigweird.c"

#include <sys/types.h>
#include <sys/time.h>
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <string.h>

void some_signal_handler(int si_number, siginfo_t *siginfo, void *bits)
{
}

int main(int argc,char *argv[])
{
	int r;
	struct itimerval it;
	sigset_t sigset;
	siginfo_t siginfo;

#if 0
#define THE_SIGACTION some_signal_handler
#else
#define THE_SIGACTION NULL
#endif

#if 0
	struct sigaction sa;

	memset(&sa,0,sizeof(sa));
	sa.sa_handler = SIG_IGN;
	sa.sa_sigaction = THE_SIGACTION;
	sigaction(SIGALRM,&sa,NULL);

	memset(&sa,0,sizeof(sa));
	sa.sa_handler = SIG_IGN;
	sa.sa_sigaction = THE_SIGACTION;
	sigaction(SIGWINCH,&sa,NULL);

	memset(&sa,0,sizeof(sa));
	sa.sa_handler = SIG_IGN;
	sa.sa_sigaction = THE_SIGACTION;
	sigaction(SIGCHLD,&sa,NULL);

	memset(&sa,0,sizeof(sa));
	sa.sa_handler = SIG_IGN;
	sa.sa_sigaction = THE_SIGACTION;
	sigaction(SIGHUP,&sa,NULL);
#endif

	sigemptyset(&sigset);
	sigaddset(&sigset,SIGALRM);
	sigaddset(&sigset,SIGWINCH);
	sigaddset(&sigset,SIGCHLD);
	sigaddset(&sigset,SIGHUP);
	sigprocmask(SIG_BLOCK,&sigset,NULL);

	memset(&it,0,sizeof(it));
	it.it_interval.tv_sec = 2;
	it.it_interval.tv_usec = 0;
	it.it_value.tv_sec = it.it_interval.tv_sec;
	it.it_value.tv_usec = it.it_interval.tv_usec;
	setitimer(ITIMER_REAL,&it,NULL);

	sigemptyset(&sigset);
	sigaddset(&sigset,SIGALRM);
	sigaddset(&sigset,SIGWINCH);
	sigaddset(&sigset,SIGCHLD);
	sigaddset(&sigset,SIGHUP);

	for (;;) {
		r = sigwaitinfo(&sigset,&siginfo);
		if (r > 0)
			printf("Received signal %u.\n",siginfo.si_signo);
	}

	exit(0);
}


--n8g4imXOkfNTN/H1--
