Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135601AbRD1TQN>; Sat, 28 Apr 2001 15:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135602AbRD1TPy>; Sat, 28 Apr 2001 15:15:54 -0400
Received: from fep01.swip.net ([130.244.199.129]:58869 "EHLO
	fep01-svc.swip.net") by vger.kernel.org with ESMTP
	id <S135601AbRD1TPm>; Sat, 28 Apr 2001 15:15:42 -0400
Date: Sat, 28 Apr 2001 21:14:39 +0200 (CEST)
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
X-X-Sender: <petero@ppro.localdomain>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4 sluggish under fork load
In-Reply-To: <Pine.LNX.4.21.0104281046240.9559-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0104282056450.11556-100000@ppro.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Apr 2001, Linus Torvalds wrote:

> > Reverting the fork patch makes all these problems go away on my machine.
>
> Reverting it outright may be an acceptable approach. I'll think about
> it: the arguments _for_ the patch are true and real, and it shows up as
> real improvements on some things..

I agree with the reasoning for running the child first. Maybe the real
problem is somewhere else. I wrote two test programs to quantify the
behaviour. If I run "./fork 0.2" and "./lat 0.15" at the same time, lat
shows regular 160ms scheduling delays. (With the old fork.c the scheduling
delay is 20ms + epsilon as expected.)

Maybe some code path just forgets to reschedule?

-------- fork.c --------

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h>

int main(int argc, char* argv[])
{
    double childTime = atof(argv[1]);

    for (;;) {
	int child = fork();
	if (child == -1) {
	    printf("fork error\n");
	    exit(0);
	} else if (child > 0) {
	    while (waitpid(child, NULL, 0) != child)
		;
	    printf("."); fflush(stdout);
	} else {
	    struct timeval tv1, tv2;
	    double t;
	    gettimeofday(&tv1, NULL);
	    for (;;) {
		gettimeofday(&tv2, NULL);
		t = (tv2.tv_sec - tv1.tv_sec) +
		    (tv2.tv_usec - tv1.tv_usec) / 1000000.0;
		if (t > childTime)
		    break;
	    }
	    _exit(0);
	}
    }

    return 0;
}


-------- lat.c --------

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h>

int main(int argc, char* argv[])
{
    double tLimit = 0.03;
    if (argc > 1)
	tLimit = atof(argv[1]);

    for (;;) {
	struct timeval tv1, tv2;
	double t;

	gettimeofday(&tv1, NULL);
	usleep(10000);
	gettimeofday(&tv2, NULL);
	t = (tv2.tv_sec - tv1.tv_sec) +
	    (tv2.tv_usec - tv1.tv_usec) / 1000000.0;
	if (t > tLimit)
	    printf("t:%g\n", t);
    }
    return 0;
}

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden


