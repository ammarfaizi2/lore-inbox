Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135549AbRD1SCA>; Sat, 28 Apr 2001 14:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135576AbRD1SBt>; Sat, 28 Apr 2001 14:01:49 -0400
Received: from fep04.swip.net ([130.244.199.132]:6016 "EHLO fep04-svc.swip.net")
	by vger.kernel.org with ESMTP id <S135549AbRD1SBg>;
	Sat, 28 Apr 2001 14:01:36 -0400
To: John Kacur <jkacur@home.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
In-Reply-To: <Pine.LNX.4.33.0104281322070.1159-100000@ppro.localdomain> <20010428170709.A410@kianga.local> <3AEAF969.58972FB4@home.com>
From: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
Date: 28 Apr 2001 20:00:45 +0200
In-Reply-To: John Kacur's message of "Sat, 28 Apr 2001 13:10:01 -0400"
Message-ID: <m2k8443nw2.fsf@ppro.localdomain>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Kacur <jkacur@home.com> writes:

> >Peter Osterlund wrote:
> >> 
> >> Another thing is that the bash loop "while true ; do /bin/true ; done" is
> >> not possible to interrupt with ctrl-c.
> 
> >        Same thing here.
> 
> I'm not having any problems. Just a quick question, is everyone who is
> having a problem running with more than one cpu?

A clarification. The bash loop above doesn't cause any sluggishness on
my single cpu system. The non-working ctrl-c is probably just a bash
bug. The child process must eat some cpu time to provoke the
sluggishness, like in the following test program where the child busy
waits 100ms and then exits:

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/time.h>

int main(int argc, char* argv[])
{
    double childTime = 0.10;
    if (argc > 1)
	childTime = atof(argv[1]);

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

-- 
Peter Österlund             peter.osterlund@mailbox.swipnet.se
Sköndalsvägen 35            http://home1.swipnet.se/~w-15919
S-128 66 Sköndal            +46 8 942647
Sweden

