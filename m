Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275224AbRJAScX>; Mon, 1 Oct 2001 14:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274835AbRJAScO>; Mon, 1 Oct 2001 14:32:14 -0400
Received: from mailrelay2.inwind.it ([212.141.54.102]:54721 "EHLO
	mailrelay2.inwind.it") by vger.kernel.org with ESMTP
	id <S271800AbRJAScJ>; Mon, 1 Oct 2001 14:32:09 -0400
Message-Id: <3.0.6.32.20011001203320.02381600@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Mon, 01 Oct 2001 20:33:20 +0200
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: VM: 2.4.10 vs. 2.4.10-ac2 and qsort()
Cc: Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Disclaimer:
I don't know if this "benchmark" is meaningful or not, but anyhow..

As workload I used qsort() on an array of 90000000 32 bit ints.
(trivial code to the end of my email).

The VSIZE of the resulting process is about 343Mb.
Tested machine has 256Mb of RAM + 200Mb of swap.
Same srand() in all tests.

Below are linux-2.4.10 results

run 1:
real    4m54.728s
user    2m47.910s
sys     0m2.520s

run 2:
real    4m55.109s
user    2m46.050s
sys     0m2.530s

kswapd CPU time: 3 seconds
qs RSS always on 238-240M, very stable never below 235M.

.. and 2.4.10-ac2 results

run 1:
real    6m2.139s
user    2m44.390s
sys     0m3.210s

run 2:
real    6m57.140s
user    2m47.050s
sys     0m3.560s

kswapd CPU time: 20 seconds
qs RSS never above 204M, average value 150M.


Comments?

------------- qs.c ---------------
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include <time.h>

int cmp(const void * x, const void * y)
{
	int *a, *b;

	a = (int *)x;
	b = (int *)y;

	if (*a == *b)
		return 0;
	else
		if (*a > *b)
			return 1;
		else
			return -1;
}

int main(int argc, char *argv[])
{
	int *a, n, i, errors = 0;

	n = atoi(argv[1]);

	if ((a = malloc(sizeof(int) * n)) == NULL) {
		perror("malloc");
		exit(1);
	}
	srand(1);
	for (i = 0; i < n; i++)
		a[i] = rand();

	qsort(a, n, sizeof(int), cmp);

	for (i = 0; i < n - 1; i++)
		if (a[i] > a[i + 1])
			errors++;
	printf("%d errors.\n", errors);
	free(a);
	return 0;
}
----------------- qs.c -----------------



-- 
Lorenzo
