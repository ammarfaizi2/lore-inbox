Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277256AbRJIOag>; Tue, 9 Oct 2001 10:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277258AbRJIOa3>; Tue, 9 Oct 2001 10:30:29 -0400
Received: from mailrelay1.inwind.it ([212.141.54.101]:17909 "EHLO
	mailrelay1.inwind.it") by vger.kernel.org with ESMTP
	id <S277256AbRJIOaT>; Tue, 9 Oct 2001 10:30:19 -0400
Message-Id: <3.0.6.32.20011009163147.01e5e6e0@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Tue, 09 Oct 2001 16:31:47 +0200
To: linux-kernel@vger.kernel.org
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: qsbench
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've rewritten the "qsort test" again, now it uses its own qsort
and it's much faster than the previous qs.c.
Renamed qs.c to qsbench.c :)
Previous results are not comparable.
Three sequential runs of qsbench with the same seed = 140175100

Results below, qsbench.c code to the end.

Linux-2.4.11-pre5:

time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.950u 1.890s 2:20.41 51.8%    0+0k 0+0io 10671pf+0w

time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.370u 1.610s 2:20.85 51.8%    0+0k 0+0io 10591pf+0w

time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.870u 1.700s 2:20.99 51.4%    0+0k 0+0io 10587pf+0w


Linux-2.4.10-ac9:

time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
70.940u 2.420s 3:21.21 36.4%    0+0k 0+0io 12745pf+0w

time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
72.240u 3.250s 4:01.99 31.1%    0+0k 0+0io 15616pf+0w

time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.530u 2.560s 3:33.09 34.7%    0+0k 0+0io 13095pf+0w


Linux-2.4.10-ac9 + Rik's eatcache patch:

time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.680u 2.410s 3:30.48 35.2%    0+0k 0+0io 12603pf+0w

time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
72.070u 2.460s 3:53.87 31.8%    0+0k 0+0io 15361pf+0w

time ./qsbench -n 90000000 -p 1 -s 140175100
seed = 140175100
71.240u 2.940s 4:36.24 26.8%    0+0k 0+0io 17801pf+0w


I would say qsbench can't give a definitive answer on this
patch because results are not enough reproducible.
Maybe qsbench is not even suited to test this patch, I suspect.
Anyway, here's the qsbench.c new code,


/*
 * Copyright (C) 2001 Lorenzo Allegrucci (lenstra@tiscalinet.it)
 * Licensed under the GPL
 */
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#define MAX_PROCS	1024

/**
 * quick_sort - Sort in the range [l, r]
 */
void quick_sort(int a[], int l, int r)
{
	int i, j, p, tmp;
	int m, min, max;

	i = l;
	j = r;
	m = (l + r) >> 1;

	if (a[m] >= a[l]) {
		max = a[m];
		min = a[l];
	} else {
		max = a[l];
		min = a[m];
	}

	if (a[r] >= max)
		p = max;
	else {
		if (a[r] >= min)
			p = a[r];
		else
			p = min;
	}

	do {
		while (a[i] < p)
			i++;

		while (p < a[j])
			j--;

		if (i <= j) {
			tmp = a[i];
			a[i] = a[j];
			a[j] = tmp;
			i++;
			j--;
		}
	} while (i <= j);

	if (l < j)
		quick_sort(a, l, j);

	if (i < r)
		quick_sort(a, i, r);
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

	quick_sort(a, 0, n - 1);

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
	int i, pid[MAX_PROCS];
	int status;

	if (p > MAX_PROCS)
		p = MAX_PROCS;

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
	fprintf(stderr, "Usage: qs [-h] [-n nr_elems] [-p nr_procs]"
			" [-s seed]\n");
	exit(1);
}


int main(int argc, char * argv[])
{
	char * n = NULL, * p = NULL, * s = NULL;
	int nr_elems = 1000000, nr_procs = 1, seed = 1;
	int c;

	if (argc == 1)
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
			nr_elems = atoi(n);
			break;
		case 'p':
			p = optarg;
			nr_procs = atoi(p);
			break;
		case 's':
			s = optarg;
			seed = atoi(s);
			break;
		case 'V':
			printf("Version 0.92\n");
			return 1;
		case '?':
			return 1;
		}
	}

	start_procs(nr_elems, nr_procs, seed);

	return 0;
}



-- 
Lorenzo

