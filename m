Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289058AbSAIWdv>; Wed, 9 Jan 2002 17:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289057AbSAIWdm>; Wed, 9 Jan 2002 17:33:42 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:60579 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S289056AbSAIWd0>; Wed, 9 Jan 2002 17:33:26 -0500
Date: Wed, 9 Jan 2002 17:34:09 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.33.0201092218450.7442-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201091517080.22941-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> no wonder, it should be 'nice -n -20 vmstat -n 1'. And you should also do

I keep a suid setrealtime wrapper around (UNSAFE!) for this kind of use:

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sched.h>

int main(int argc, char *argv[]) {
    static struct sched_param sched_parms;
    int pid, wrapper=0;

    if (argc <= 1)
        return 1;

    pid = atoi(argv[1]);

    if (!pid || argc != 2) {
        wrapper = 1;
        pid = getpid();
    }

    sched_parms.sched_priority = sched_get_priority_min(SCHED_FIFO);
    if (sched_setscheduler(pid, SCHED_FIFO, &sched_parms) == -1) {
        perror("cannot set realtime scheduling policy");
        return 1;
    }
    if (wrapper) {
        setuid(getuid());
        execvp(argv[1],&argv[1]);
        perror("exec failed");
        return 1;
    }
    return 0;
}

regards, mark hahn.

