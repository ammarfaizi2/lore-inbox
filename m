Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264831AbVBEIhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264831AbVBEIhs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 03:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbVBEIhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 03:37:48 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:58802 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264831AbVBEIhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 03:37:24 -0500
Message-ID: <420485B1.5030103@colorfullife.com>
Date: Sat, 05 Feb 2005 09:37:05 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ove Kaaven <ovek@transgaming.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: PATCH: SysV semaphore race vs SIGSTOP
Content-Type: multipart/mixed;
 boundary="------------000309080804030702060002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000309080804030702060002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ove,

>As I mentioned in an earlier mail, there is a race when SIGSTOP-ing a
>process waiting for a SysV semaphore, where if a process holding a
>semaphore suspends another process waiting on the semaphore and then
>releases the semaphore, 
>
Your patch looks correct (for 2.4 - 2.6 uses a different approach), but 
I'm not certain that it's needed:
You assume that signals have an immediate effect.
Linux ignores that - it delays signal processing under some 
circumstances. If a syscall can be completed without blocking, then the 
syscall is handled, regardless of any pending signals. The signal is 
handled at the syscall return, i.e. after completing the syscall.
That's not just in SysV semaphore - at least pipes are identical:
pipe_read first check if there is data. If there is some, then it 
returns the data. Signals are only checked if there is no pending data.
I'm not sure if this is a bug. But if it's one, then far more than just 
sysv sem must be updated.

What about other unices? I've attached a test app that tests pipes. 
Could someone try it?

--
    Manfred

--------------000309080804030702060002
Content-Type: text/x-c++src;
 name="test8.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test8.cpp"

/*
 * Copyright (C) 1999, 2001,2005 by Manfred Spraul.
 * 
 * Redistribution of this file is permitted under the terms of the GNU 
 * General Public License (GPL)
 * $Header: /home/manfred/cvs-tree/pipetest/test8.cpp,v 1.1 2005/02/05 08:35:01 manfred Exp $
 */

#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <limits.h>
#include <errno.h>

#define WRITE_LEN	128	/* less than PIPE_BUF */

int buffer[WRITE_LEN];

void dummy(int sig)
{
}

int main()
{
	int pipes[2];
	int ret;

	ret = pipe(pipes);
	if(ret != 0) {
		printf("pipe creation failed, ret %d, errno %d.\n",
				ret, errno);
		exit(1);
	}
	ret = fork();
	if(!ret) {
		/* child: read from pipe */
		printf("child: trying to read %d bytes.\n", WRITE_LEN);
		ret = read(pipes[0], buffer, WRITE_LEN);
		/* never executed! */
		printf("child: read returned %d.\n", ret);
		printf("SIGSTOP test result: SIGSTOP completely broken\n");
	} else {
		/* synchronize with timer - the following block must be atomic */
		sleep(1);
		/* begin atomic block */
		ret = kill(ret, SIGSTOP);
		if (ret != 0) {
			printf("Sending SIGSTOP failed, aborting (errno=%d).\n", errno);
			exit(1);
		}
		ret = write(pipes[1], buffer, WRITE_LEN);
		if (ret != WRITE_LEN) {
			printf("Writing to pipe buffer failed, aborting (errno=%d).\n", errno);
			exit(1);
		}
		/* end of atomic block */
		printf("parent: yielding\n");
		sleep(1);
		ret = fcntl(pipes[0], F_SETFL, O_NONBLOCK);
		if (ret != 0) {
			printf("fcntl(,,O_NONBLOCK) failed, aborting (errno=%d).\n", errno);
			exit(1);
		}
		ret = read(pipes[0], buffer, WRITE_LEN);
		printf("parent: read returned %d.\n", ret);
		printf("\n\n");
		printf("SIGSTOP test result:\n");
		printf("Expected values:\n");
		printf("	%d for OS with synchroneous SIGSTOP\n", WRITE_LEN);
		printf("	-1 for OS with asynchroneous SIGSTOP (errno EAGAIN=%d)\n", EAGAIN);
		printf("Got: %d (errno: %d)\n", ret, errno);
		close(pipes[1]);
		close(pipes[0]);
	}
}

--------------000309080804030702060002--
