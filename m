Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261772AbTCQSG3>; Mon, 17 Mar 2003 13:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbTCQSG3>; Mon, 17 Mar 2003 13:06:29 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:62954 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261772AbTCQSG0>;
	Mon, 17 Mar 2003 13:06:26 -0500
Message-ID: <3E761124.8060402@colorfullife.com>
Date: Mon, 17 Mar 2003 19:17:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
References: <20030316213516.GM20188@holomorphy.com> <Pine.LNX.4.44.0303170719410.15476-100000@localhost.localdomain> <20030317070334.GO20188@holomorphy.com>
In-Reply-To: <20030317070334.GO20188@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------010802080708040208050805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010802080708040208050805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

William Lee Irwin III wrote:

>The NMI oopses are mostly decoded by hand b/c in-kernel (and other)
>backtrace decoders can't do it automatically. I might have to generate
>some fresh data, with some kind of hack (e.g. hand-coded NMI-based kind
>of smp_call_function) to trace the culprit and not just the victim.
>The victims were usually stuck in fork() or exit().
>
Could you check if the attached test app triggers the NMI oopser?

--
    Manfred

--------------010802080708040208050805
Content-Type: text/plain;
 name="numados.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numados.cpp"

/*
 * numados: stress test the tasklist lock.
 *
 * Copyright (C) 1999, 2001, 2003 by Manfred Spraul.
 *	All rights reserved except the rights granted by the GPL.
 *
 * Redistribution of this file is permitted under the terms of the GNU 
 * General Public License (GPL) version 2 or later.
 * $Header: /pub/home/manfred/cvs-tree/getdents/getdents.cpp,v 1.1 2003/03/16 21:07:43 manfred Exp $
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/types.h>
#include <linux/dirent.h>
#include <linux/unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

#define BUFSZ	4096
unsigned char entries[BUFSZ];

#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
type name(type1 arg1,type2 arg2,type3 arg3) \
{ \
long __res; \
__asm__ volatile ("int $0x80" \
	: "=a" (__res) \
	: "0" (__NR_##name),"b" ((long)(arg1)),"c" ((long)(arg2)), \
		  "d" ((long)(arg3))); \
__syscall_return(type,__res); \
}

_syscall3(int, getdents, uint, fd, struct dirent *, dirp, uint, count);

static void poll_tasklist(void) 
{
	int fd, retval;

	for (;;) {
		fd = open("/proc",O_RDONLY);
		if (fd < 0) {
			printf("open failed, errno %d.\n", errno);
			exit(4);
		}
		lseek(fd, 1000000, SEEK_SET);
		retval = getdents(fd, (struct dirent *)entries, BUFSZ);
		close(fd);
	}
}

int main(int argc, char **argv)
{
	int retval;
	int forks, readers;
	int i;
	printf("numados <forks> <readers>\n");
	if (argc != 3)
		return 1;

	forks=atoi(argv[1]);
	readers=atoi(argv[2]);
	printf("Forks: %d.\n", forks);
	for (i=0;i<forks;i++) {
		retval = fork();
		if (retval < 0) {
			printf("fork failed for process %d, errno %d.\n", i+1, errno);
			return 2;
		} else if (retval == 0) {
			for (;;) sleep(1000);
		} else {
			printf(" child %d: pid %d created\n", i, retval);
			fflush(stdout);
		}
	}
	printf("%d child processes created.\n", i);

	for (i=0;i<readers;i++) {
		retval = fork();
		if (retval < 0) {
			printf("fork failed for process %d, errno %d.\n", i+1, errno);
			return 3;
		} else if (retval == 0) {
			poll_tasklist();
			for (;;) sleep(10000);
		}
	}
	printf("%d reader processes created.\n", i);
	for(;;) sleep(1000);
}

--------------010802080708040208050805--

