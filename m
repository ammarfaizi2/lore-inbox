Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUERKKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUERKKf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 06:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUERKKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 06:10:34 -0400
Received: from portal.beam.ltd.uk ([62.49.82.227]:36236 "EHLO beam.beamnet")
	by vger.kernel.org with ESMTP id S262882AbUERKKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 06:10:14 -0400
Message-ID: <40A9E105.7080907@beam.ltd.uk>
Date: Tue, 18 May 2004 11:10:13 +0100
From: Terry Barnaby <terry1@beam.ltd.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem with mlockall() and Threads: memory usage
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a problem with a soft real-time program that uses mlockall
to improve its latency.

The basic problem, which can be seen with a simple test example, is
that if we have a program that uses a large amount of memory, uses multiple
threads and uses mlockall() the physical memory usage goes through the
roof. This problem/feature is present using RedHat 7.3 (2.4.x libc user level
threads), RedHat 9 (2.4.20 kernel threads) and Fedora Core 2 (2.6.5).

Our simple test program first does a mlockall(MCL_CURRENT | MCL_FUTURE),
mallocs 10MBytes and then creates 8 threads all which pause.

The memory usage with the mlockall() call is:
  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
2251 pts/1    SL     0:00      0     2 95921 95924 37.3 ./t2 8

The memory usage without the mlockall() call is:
  PID TTY      STAT   TIME  MAJFL   TRS   DRS  RSS %MEM COMMAND
2275 pts/1    S      0:00      0     2 95929 11152  4.3 ./t2 8

It appears that the kernel is allocating physical memory for each
of the Threads shared data area's rather than allocating just
the one shared area.

Are we doing something wrong ?
Is this the correct behaviour ?
Is this a kernle or glibc bug ?

Example code follows:

Terry

/*******************************************************************************
  *	T2.c		Test Threads
  *			T.Barnaby,	BEAM Ltd,	18/5/04
  *******************************************************************************
  */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pthread.h>
#include <sys/mman.h>
#include <sys/statfs.h>

const int	memSize = (10 * 1024*1024);

void* threadFunc(void* arg){
	while(1){
		printf("Thread::function: loop: Pid(%d)\n", getpid());
		pause();
	}
}

void test1(int n){
	pthread_t*	threads;
	void*		mem;
	int		i;

	threads = (pthread_t*)malloc(n * sizeof(pthread_t));
	mem = malloc(memSize);
	memset(mem, 0, memSize);
	printf("Mem: %p\n", mem);

	for(i = 0; i < n; i++){
		pthread_create(&threads[i], 0, threadFunc, 0);
	}		
	pause();
}


int main(int argc, char** argv){
	if(argc != 2){
		fprintf(stderr, "Usage: t2 <numberOfThreads>\n");
		return 1;
	}
	
#ifndef ZAP
	// Lock in all of the pages of this application
	if(mlockall(MCL_CURRENT | MCL_FUTURE) < 0)
		fprintf(stderr, "Warning: unable to lock in memory pages\n");
#endif

	test1(atoi(argv[1]));
	return 0;
}

-- 
Dr Terry Barnaby                     BEAM Ltd
Phone: +44 1454 324512               Northavon Business Center, Dean Rd
Fax:   +44 1454 313172               Yate, Bristol, BS37 5NH, UK
Email: terry@beam.ltd.uk             Web: www.beam.ltd.uk
BEAM for: Visually Impaired X-Terminals, Parallel Processing, Software
                       "Tandems are twice the fun !"
