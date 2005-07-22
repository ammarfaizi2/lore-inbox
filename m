Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVGVKC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVGVKC7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 06:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVGVKC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 06:02:58 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:64896 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S261200AbVGVKC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 06:02:58 -0400
Date: Fri, 22 Jul 2005 05:58:44 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Message-ID: <200507220602_MC3-1-A540-A73D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Jul 2005 at13:27:56 +1000, Andrew Morton wrote:

> hm.  What context switch rate is that thing doing?

  23000 - 25000 / second.  I guess that explains why my attempt to
duplicate this in C failed -- it switches at 15-19 times per second:


/* i387 context switch benchmark
 *    compile this program without optimization
 */
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <sched.h>

int lo = 0, fp = 0, af = 0;
long i, iters;
pid_t child;
cpu_set_t cpuset;

void handler(int sig) {
	lo = 0; /* stop looping */
}
struct sigaction sa = {
	.sa_handler = handler,
};
main(int argc, char *argv[]) {
	if (argc < 2) /* mandatory loop iteration count */
		exit(1);
	iters = atol(argv[1]);
	if (argc > 2) /* loop in parent while waiting for child to exit */
		lo = atoi(argv[2]);
	if (argc > 3) /* use FP while wait-looping */
		fp = atoi(argv[3]);
	if (argc > 4) /* use cpu affinity -- all code runs on cpu 0 */
		af = atoi(argv[4]);

	__CPU_SET(0, &cpuset);

	child = fork();
	if (child) {  /* parent */
		if (af)
			sched_setaffinity(0, &cpuset);
		if (lo) {
			sigaction(SIGCHLD, &sa, NULL);
			if (fp)
				__asm__ __volatile__("fld1" "\n\t" "fldz");
			while (lo)
				if (fp)
					__asm__ __volatile__(
						"fadd %st(1), %st(0)");
		} else 
			wait(NULL);

	} else {  /* child */
		if (af)
			sched_setaffinity(0, &cpuset);
		__asm__ __volatile__("fld1" "\n\t" "fldz");
		for (i = 0; i < iters; i++)
			__asm__ __volatile__("fadd %st(1), %st(0)");
	}
}


> Is the benchmark actually doing floating point stuff?

  They only release .class files.  ISTR java does FP math even when
developers think they are doing integer math but I can't find any
references.

__
Chuck
