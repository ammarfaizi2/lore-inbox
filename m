Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280114AbRJaJPL>; Wed, 31 Oct 2001 04:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280115AbRJaJPC>; Wed, 31 Oct 2001 04:15:02 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:33028 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280114AbRJaJOr>; Wed, 31 Oct 2001 04:14:47 -0500
Message-ID: <3BDFBFF5.9F54B938@zip.com.au>
Date: Wed, 31 Oct 2001 01:10:13 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <Pine.LNX.4.33.0110302349550.31996-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> If you have a pet peeve about the VM, now is the time to speak
> up.
>

I'm peeved by the request queue changes.

Appended here is a program which creates 100,000 small files.
Using ext2 on -pre5.  We see how long it takes to run

	(make-many-files ; sync)

For several values of queue_nr_requests:

queue_nr_requests:	128	8192	32768
execution time:		4:43	3:25	3:20

Almost all of the execution time is in the `sync'.

This is on a disk with a 2 meg cache which does pretty aggressive
write-behind.  I expect the difference would be worse with a disk
which doesn't help so much.

By restricting the number of requests in flight to 128 we're
giving new requests only a very small chance of getting merged with
an existing request.  More seeking.

OK, not an interesting workload.  But I suspect that there are real
workloads which will be bitten by this.

Why is the queue length so tiny now?  Latency?  If so, couldn't this
be addressed by giving reads higher priority versus writes?



#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>

static void doit(char *name)
{
	static char stuff[4096];
	int fd;

	fd = creat(name, 0666);
	if (fd < 0) {
		perror(name);
		exit(1);
	}
	write(fd, stuff, sizeof(stuff));
	close(fd);
}

int main(void)
{
	int i, j, k, l, m;
	char buf[100];

	for (i = 0; i < 10; i++) {
		sprintf(buf, "%d", i);
		mkdir(buf, 0777);
		for (j = 0; j < 10; j++) {
			sprintf(buf, "%d/%d", i, j);
			mkdir(buf, 0777);
			printf("%s\n", buf);
			for (k = 0; k < 10; k++) {
				sprintf(buf, "%d/%d/%d", i, j, k);
				mkdir(buf, 0777);
				for (l = 0; l < 10; l++) {
					sprintf(buf, "%d/%d/%d/%d", i, j, k, l);
					mkdir(buf, 0777);
					for (m = 0; m < 10; m++) {
						sprintf(buf, "%d/%d/%d/%d/%d", i, j, k, l, m);
						doit(buf);
					}
				}
			}
		}
	}
	exit(0);
}
