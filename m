Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277414AbRJEPbR>; Fri, 5 Oct 2001 11:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277416AbRJEPbB>; Fri, 5 Oct 2001 11:31:01 -0400
Received: from mailrelay3.inwind.it ([212.141.54.103]:10128 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S277414AbRJEPap>; Fri, 5 Oct 2001 11:30:45 -0400
Message-Id: <3.0.6.32.20011005173218.01dea7d0@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Fri, 05 Oct 2001 17:32:18 +0200
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: VM: more numbers
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I rewritten my qs.c, now can start several processes in parallel.
However, I did not use this feature on the tests below.
Instead, I used the feature to set a given seed by the "-s" option.

Firstly, I gathered 6 _random_ seeds:
140175100
337007780
1475617586
1243149688
1846276605
786915464

and I tested 2.4.10, 2.4.11-pre3 and 2.4.10-ac2 using the _same seeds_
for all tests to compare apples with apples.
(I switched from bash to the tcsh which has better statistics.)


Linux-2.4.10:

time ./qs -n 90000000 -p 1 -s 140175100
seed = 140175100
167.260u 2.730s 4:59.74 56.7%	0+0k 0+0io 23120pf+0w

time ./qs -n 90000000 -p 1 -s 337007780
seed = 337007780
164.180u 2.550s 5:00.12 55.5%	0+0k 0+0io 23223pf+0w

time ./qs -n 90000000 -p 1 -s 1475617586
seed = 1475617586
166.480u 2.510s 4:57.78 56.7%	0+0k 0+0io 23031pf+0w

time ./qs -n 90000000 -p 1 -s 1243149688
seed = 1243149688
168.400u 2.480s 5:05.35 55.9%	0+0k 0+0io 23317pf+0w

time ./qs -n 90000000 -p 1 -s 1846276605
seed = 1846276605
163.630u 2.810s 4:56.23 56.1%	0+0k 0+0io 23178pf+0w

time ./qs -n 90000000 -p 1 -s 786915464
seed = 786915464
165.040u 3.040s 4:57.31 56.5%	0+0k 0+0io 23566pf+0w

As you can see Linux-2.4.10 has a quite predictable VM.


Linux-2.4.11-pre3:

time ./qs -n 90000000 -p 1 -s 140175100
seed = 140175100
167.470u 2.010s 4:35.31 61.5%	0+0k 0+0io 18290pf+0w

time ./qs -n 90000000 -p 1 -s 337007780
seed = 337007780
169.220u 2.140s 4:38.31 61.5%	0+0k 0+0io 17814pf+0w

time ./qs -n 90000000 -p 1 -s 1475617586
seed = 1475617586
170.000u 2.380s 4:37.44 62.1%	0+0k 0+0io 17564pf+0w

time ./qs -n 90000000 -p 1 -s 1243149688
seed = 1243149688
170.130u 2.390s 4:46.07 60.3%	0+0k 0+0io 18219pf+0w

time ./qs -n 90000000 -p 1 -s 1846276605
seed = 1846276605
168.190u 2.390s 4:37.16 61.5%	0+0k 0+0io 17843pf+0w

time ./qs -n 90000000 -p 1 -s 786915464
seed = 786915464
161.370u 2.500s 4:28.97 60.9%	0+0k 0+0io 18569pf+0w

Linux-2.4.11-pre3 has the Andrea's vm_tweaks that make it faster
but a bit less predictable. Not tried -pre4.


Linux-2.4.10-ac2:

time ./qs -n 90000000 -p 1 -s 140175100
seed = 140175100
165.890u 3.390s 6:02.54 46.6%	0+0k 0+0io 18183pf+0w

time ./qs -n 90000000 -p 1 -s 337007780
seed = 337007780
162.720u 3.010s 6:21.12 43.4%	0+0k 0+0io 20498pf+0w

time ./qs -n 90000000 -p 1 -s 1475617586
seed = 1475617586
167.330u 3.470s 6:48.38 41.8%	0+0k 0+0io 21089pf+0w

time ./qs -n 90000000 -p 1 -s 1243149688
seed = 1243149688
166.130u 3.340s 7:00.27 40.3%	0+0k 0+0io 21297pf+0w

time ./qs -n 90000000 -p 1 -s 1846276605
seed = 1846276605
166.030u 3.630s 6:10.54 45.7%	0+0k 0+0io 18695pf+0w

time ./qs -n 90000000 -p 1 -s 786915464
seed = 786915464
169.770u 3.620s 6:37.10 43.6%	0+0k 0+0io 20898pf+0w

Rik's VM seems slower and less predictable.


Below is the new (raw) qs.c

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <malloc.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>


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


void do_qsort(int n, int s)
{
	int * a, i, errors = 0;

	if ((a = malloc(sizeof(int) * n)) == NULL) {
		perror("malloc");
		exit(1);
	}

	srand(s);
	printf("seed = %d\n", s);

	for (i = 0; i < n; i++)
		a[i] = rand();

	qsort(a, n, sizeof(int), cmp);

	for (i = 0; i < n - 1; i++)
		if (a[i] > a[i + 1])
			errors++;
	if (errors)
		fprintf(stderr, "WARNING: %d errors.\n", errors);
	free(a);
	exit(0);
}

void start_procs(int n, int p, int s)
{
	int i, pid[256];
	int status;

	for (i = 0; i < p; i++) {
		pid[i] = fork();
		if (pid[i] == 0)
			do_qsort(n, s);
		else if (pid[i] < 0)
			perror("fork");
	}

	for (i = 0; i < p; i++)
		waitpid(pid[i], &status, 0);
}

void usage(void)
{
	fprintf(stderr, "Usage: qs [-h] -n nr_elems -p nr_procs\n");
	exit(1);
}


int main(int argc, char * argv[])
{
	char * n = NULL, * p = NULL, * s = NULL;
	int nr_elems, nr_procs, seed;
	int c;

	if (argc < 6)
		usage();
	while (1) {
		c = getopt(argc, argv, "hn:p:s:V");
		if (c == -1)
			break;

		switch (c) {
		case 'h':
			usage();
		case 'n':
			n = optarg;
			break;
		case 'p':
			p = optarg;
			break;
		case 's':
			s = optarg;
			break;
		case 'V':
			printf("Version 0.92\n");
			return 1;
		case '?':
			return 1;
		}
	}

	nr_elems = atoi(n);
	nr_procs = atoi(p);
	seed = atoi(s);

	start_procs(nr_elems, nr_procs, seed);

	return 0;
}


BTW, while rewriting qs.c I got a 'Internal compiler error' from
my gcc 2.92.2 ...
My hw is stable and the bug is totally reproducible by inserting
and deleting a few lines of code. The version above compiles fine.



-- 
Lorenzo
