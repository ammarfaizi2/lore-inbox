Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbVINXTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbVINXTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 19:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbVINXTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 19:19:53 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:48500 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S965104AbVINXTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 19:19:52 -0400
Message-ID: <4328B013.1010400@cosmosbay.com>
Date: Thu, 15 Sep 2005 01:19:47 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] reorder struct files_struct
References: <20050914191842.GA6315@in.ibm.com> <20050914.125750.05416211.davem@davemloft.net> <20050914201550.GB6315@in.ibm.com> <20050914.132936.105214487.davem@davemloft.net> <43289376.7050205@cosmosbay.com> <20050914220205.GC6237@in.ibm.com> <4328A73B.1080801@cosmosbay.com> <20050914225043.GD6237@in.ibm.com>
In-Reply-To: <20050914225043.GD6237@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080309080809080405060903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080309080809080405060903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Dipankar Sarma a écrit :
> On Thu, Sep 15, 2005 at 12:42:03AM +0200, Eric Dumazet wrote:
> 
>>Dipankar Sarma a écrit :

> Not just embedded fdtable, but also the embedded fdsets. I would expect
> count, fdt, fdtab and the fdsets to fit into one cache line in 
> some archs.
> 
> 
> 
>>But I wonder if 'next_fd' really has to be in 'struct fdtable', maybe it 
>>could be moved to 'struct files_struct' close to file_lock ?
> 
> 
> next_fd has to be in struct fdtable. It needs to be consistent
> with whichever fdtable a lock-free reader sees.
> 

I may be wrong, but I think a reader never look at next_fd.

next_fd is only used (read/written) by a 'writer', with file_lock hold,  in 
locate_fd(), copy_fdtable() and get_unused_fd(), __put_unused_fd()


> 
>>If yes, the whole embedded struct fdtable is readonly.
> 
> 
> But not close_on_exec_init or open_fds_init. We would update them
> on open/close.

Yes, sure, but those fields are not part of the embedded struct fdtable

> 
> Some benchmarking would be useful here.

This simple bench can be used, I got good results on a dual opteron machine. 
As Opterons have prety good NUMA links (Hypertransport), I suspect older 
hardware should obtain even better results.

$ gcc -O2 -o bench bench.c -lpthread
$ ./bench -t 2 -l 10   # run the bench with 2 threads for 10 seconds.
2 threads, 10 seconds, work_done=1721627

To run it with a small fdset (no more than 3 + (nbthreads) files opened)
$ ./bench -s -t 2 -l 10
2 threads, 10 seconds, work_done=1709716

Unfortunatly I cannot boot the dual opterons at the moment to try to move 
next_fd close to file_lock

Eric


--------------080309080809080405060903
Content-Type: text/plain;
 name="bench.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bench.c"

/*
 * Bench program to exercice multi threads using open()/close()/read()/lseek() calls.
 * Usage :
 *    bench [-t XX] [-l len]
 *   XX : number of threads
 *   len : bench time in seconds
 * -s : small fdset : try to use embedded sruct fdtable
 */
#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

pthread_mutex_t  mut = PTHREAD_MUTEX_INITIALIZER;

char *file = "/etc/passwd";
int sflag; /* small fdset */
int end_prog;
unsigned long work_done;

void *perform_work(void *arg)
{
	int fd, i;
	unsigned long units = 0;
	char c;

	/* force this program to open more than 64 fds */
	if (!sflag)
		for (i = 0 ; i < 64 ; i++)
			open("/dev/null", O_RDONLY);

	while (!end_prog) {
		fd = open(file, O_RDONLY);
		read(fd, &c, 1);
		lseek(fd, 10, SEEK_SET);
		read(fd, &c, 1);
		lseek(fd, 20, SEEK_SET);
		read(fd, &c, 1);
		lseek(fd, 30, SEEK_SET);
		read(fd, &c, 1);
		lseek(fd, 40, SEEK_SET);
		read(fd, &c, 1);
		close(fd);
		units++;
	}
	pthread_mutex_lock(&mut);
	work_done += units;
	pthread_mutex_unlock(&mut);
	return 0;
}

void usage(int code)
{
	fprintf(stderr, "Usage : bench [-s] [-t threads] [-l duration]\n");
	exit(code);
}

int main(int argc, char *argv[])
{
	int i, c;
	int nbthreads = 2;
	unsigned int length = 10;
	pthread_t *tid;

	while ((c = getopt(argc, argv, "st:l:")) != -1) {
		if (c == 't')
			nbthreads = atoi(optarg);
		else if (c == 'l')
			length = atoi(optarg);
		else if (c == 's')
			sflag = 1;
		else usage(1);
	}


	tid = malloc(nbthreads*sizeof(pthread_t));
	for (i = 0 ; i < nbthreads; i++)
		pthread_create(tid + i, NULL, perform_work, NULL);

	sleep(length);
	end_prog = 1;
	for (i = 0 ; i < nbthreads; i++)
		pthread_join(tid[i], NULL); 

pthread_mutex_lock(&mut);
printf("%d threads, %u seconds, work_done=%lu\n", nbthreads, length, work_done);
pthread_mutex_unlock(&mut);
return 0;
}

--------------080309080809080405060903--
