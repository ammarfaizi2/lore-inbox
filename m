Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130532AbRDSQFl>; Thu, 19 Apr 2001 12:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRDSQFc>; Thu, 19 Apr 2001 12:05:32 -0400
Received: from goat.cs.wisc.edu ([128.105.166.42]:54030 "EHLO goat.cs.wisc.edu")
	by vger.kernel.org with ESMTP id <S130532AbRDSQFM>;
	Thu, 19 Apr 2001 12:05:12 -0400
To: linux-kernel@vger.kernel.org
Subject: BUG: Global FPU corruption in 2.2
From: Victor Zandy <zandy@cs.wisc.edu>
Date: 19 Apr 2001 11:05:03 -0500
Message-ID: <cpx7l0g3mfk.fsf@goat.cs.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have found that one of our programs can cause system-wide
corruption of the x86 FPU under 2.2.16 and 2.2.17.  That is, after we
run this program, the FPU gives bad results to all subsequent
processes.

We see this problem on dual 550MHz Xeons with 1GB RAM.  We have 64 of
these things, and we see the problem on every node we try (dozens).
We don't have other SMPs handy.  Uniprocessors, including other PIIIs,
don't seem to be affected.

While we prepare to test for the problem on more recent 2.2 and 2.4
kernels, we would appreciate hearing from anyone who may have insight
into it.

Below are two programs we use to produce the behavior.  The first
program, pi, repeatedly spawns 10 parallel computations of pi.  When
all is well, each process prints pi as it completes.

The second program, pt, repeatedly attaches to and detaches from
another process.  Run pt against the root pi process until the output
of pi begins to look wrong.  Then kill everything and run pi by itself
again.  It will no longer produce good results.  We find that the FPU
persistently gives bad results until we reboot.

Here is the sort of thing we see:

BEFORE                  AFTER
--------------------------------------
c36% ./pi               c36% ./pi        
[3883]                  [4069]           
3.141593                6865157.146714   
3.141593                inf              
3.141593                81705.277947     
3.141593                4.742524         
3.141593                nan              
3.141593                585.810296       
3.141593                inf              
3.141593                4.578857         
3.141593                nan              
3.141593                4.578857         

I am not currently subscribed to linux-kernel.  I'll be checking the
web archives, but please CC replies to me.

Thanks!

Vic Zandy

/* pi.c: gcc -g -o pi pi.c -lm */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <errno.h>

static double
do_pi()
{
	double sum=0.0;
	double x=1.0;
	double s=1.0;
	double pi;

	while (x <= 10000000.0)	{
		sum += (1.0/pow(x, 3.0))*s;
		s = -s;
		x += 2.0;
	}
	pi = pow(sum*32.0, 1.0/3.0);
	return pi;
}

int
main( int argc, char* argv[] )
{
	int i;
	int pid;
	int m = 1000;   /* runs */
	int n = 10;     /* procs per run */

	pid = getpid();
	fprintf(stderr, "[%d]\n", pid);
	while (m-- > 0) {
	     for (i = 1; i < n; i++)
		  if (!fork())
		       break;
	     fprintf(stderr, "%f\n", do_pi());
	     if (getpid() != pid)
		  return 0;
	     while (waitpid(0, 0, WNOHANG) > 0)
		  ;
	}
	return 0;
}
/* end of pi.c */

/* pt.c: gcc -g -o pt pt.c */
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>
#include <linux/ptrace.h>

long
dptrace(int req, pid_t pid, void *addr, void *data)
{
	char buf[64];
	int rv;
	rv = ptrace(req, pid, addr, data);
	if ((req != PTRACE_PEEKUSR && req != PTRACE_PEEKTEXT) && 0 > rv) {
		sprintf(buf, "ptrace (req=%d)", req);
		perror(buf);
		exit(1);
	}
	return rv;
}

int
main(int argc, char *argv[])
{
	int pid;
	char buf[1024];
	int n;

	if (argc < 2) {
		fprintf(stderr, "Usage: %s PID\n", argv[0]);
		exit(1);
	}
	pid = atoi(argv[1]);
	while (1) {
		dptrace(PTRACE_ATTACH, pid, 0, 0);
		waitpid(pid, 0, 0);
		dptrace(PTRACE_DETACH, pid, 0, 0);
		fprintf(stderr, ".");
	}
	return 0;
}
/* end of pt.c */


