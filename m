Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279277AbRKDVPi>; Sun, 4 Nov 2001 16:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279228AbRKDVPU>; Sun, 4 Nov 2001 16:15:20 -0500
Received: from mailrelay3.inwind.it ([212.141.54.103]:49839 "EHLO
	mailrelay3.inwind.it") by vger.kernel.org with ESMTP
	id <S279105AbRKDVOm>; Sun, 4 Nov 2001 16:14:42 -0500
Message-Id: <3.0.6.32.20011104221747.01ff8d30@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Sun, 04 Nov 2001 22:17:47 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: VM: qsbench numbers
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111040913370.6919-100000@penguin.transmeta.
 com>
In-Reply-To: <3.0.6.32.20011104151152.01fdaea0@pop.tiscalinet.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1004905067==_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=====================_1004905067==_
Content-Type: text/plain; charset="us-ascii"

At 09.18 04/11/01 -0800, Linus Torvalds wrote:
>
>On Sun, 4 Nov 2001, Lorenzo Allegrucci wrote:
>>
>> I begin with the last Linus' kernel, three runs and kswapd CPU
>> time appended.
>
>It's interesting how your numbers decrease with more swap-space. That,
>together with the fact that the "more swap space" case also degrades the
>second time around seems to imply that we leave swap-cache pages around
>after they aren't used.
>
>Does "free" after a run has completed imply that there's still lots of
>swap used? We _should_ have gotten rid of it at "free_swap_and_cache()"
>time, but if we missed it..

lenstra:~/src/qsort> free
             total       used       free     shared    buffers     cached
Mem:        255984      16760     239224          0       1092       8008
-/+ buffers/cache:       7660     248324
Swap:       195512          0     195512
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.590u 7.640s 2:31.06 51.7%    0+0k 0+0io 19036pf+0w
lenstra:~/src/qsort> free
             total       used       free     shared    buffers     cached
Mem:        255984       6008     249976          0        100       1096
-/+ buffers/cache:       4812     251172
Swap:       195512       5080     190432

and with more swap..

lenstra:~/src/qsort> free
             total       used       free     shared    buffers     cached
Mem:        255984      13488     242496          0        532       5360
-/+ buffers/cache:       7596     248388
Swap:       390592          0     390592
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.180u 7.650s 2:43.22 47.6%    0+0k 0+0io 21019pf+0w
lenstra:~/src/qsort> free
             total       used       free     shared    buffers     cached
Mem:        255984       6596     249388          0        108       1116
-/+ buffers/cache:       5372     250612
Swap:       390592       5576     385016
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
71.030u 7.040s 2:49.45 46.0%    0+0k 0+0io 22734pf+0w
lenstra:~/src/qsort> free
             total       used       free     shared    buffers     cached
Mem:        255984       8808     247176          0        108       1152
-/+ buffers/cache:       7548     248436
Swap:       390592       7948     382644


>What happens if you make the "vm_swap_full()" define in <linux/swap.h> be
>unconditionally defined to "1"?

lenstra:~/src/qsort> free
             total       used       free     shared    buffers     cached
Mem:        256000      16772     239228          0       1104       8008
-/+ buffers/cache:       7660     248340
Swap:       195512          0     195512
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.530u 7.290s 2:33.26 50.7%    0+0k 0+0io 19689pf+0w
lenstra:~/src/qsort> free
             total       used       free     shared    buffers     cached
Mem:        256000       5132     250868          0        116       1144
-/+ buffers/cache:       3872     252128
Swap:       195512       3748     191764

..and now with 400M of swap:

lenstra:~/src/qsort> free
             total       used       free     shared    buffers     cached
Mem:        256000      13096     242904          0        504       4904
-/+ buffers/cache:       7688     248312
Swap:       390592          0     390592
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.830u 7.100s 2:29.52 52.1%    0+0k 0+0io 18488pf+0w
lenstra:~/src/qsort> free
             total       used       free     shared    buffers     cached
Mem:        256000       4980     251020          0        108       1132
-/+ buffers/cache:       3740     252260
Swap:       390592       3840     386752
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.560u 6.840s 2:28.66 52.0%    0+0k 0+0io 18203pf+0w
lenstra:~/src/qsort> free
             total       used       free     shared    buffers     cached
Mem:        256000       5044     250956          0        108       1112
-/+ buffers/cache:       3824     252176
Swap:       390592       3896     386696

Performace improved and numbers stabilized.

>That should make us be more aggressive
>about freeing those swap-cache pages, and it would be interesting to see
>if it also stabilizes your numbers.
>
>		Linus

I attach qsbench.c

--=====================_1004905067==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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

	i =3D l;
	j =3D r;
	m =3D (l + r) >> 1;

	if (a[m] >=3D a[l]) {
		max =3D a[m];
		min =3D a[l];
	} else {
		max =3D a[l];
		min =3D a[m];
	}

	if (a[r] >=3D max)
		p =3D max;
	else {
		if (a[r] >=3D min)
			p =3D a[r];
		else
			p =3D min;
	}

	do {
		while (a[i] < p)
			i++;
		while (p < a[j])
			j--;
		if (i <=3D j) {
			tmp =3D a[i];
			a[i] =3D a[j];
			a[j] =3D tmp;
			i++;
			j--;
		}
	} while (i <=3D j);

	if (l < j)
		quick_sort(a, l, j);
	if (i < r)
		quick_sort(a, i, r);
}


void do_qsort(int n, int s)
{
	int * a, i, errors =3D 0;

	if ((a =3D malloc(sizeof(int) * n)) =3D=3D NULL)=
 {
		perror("malloc");
		exit(1);
	}

	srand(s);
	//printf("seed =3D %d\n", s);

	for (i =3D 0; i < n; i++)
		a[i] =3D rand();

	quick_sort(a, 0, n - 1);

	//printf("verify... "); fflush(stdout);
	for (i =3D 0; i < n - 1; i++)
		if (a[i] > a[i + 1])
			errors++;
	//printf("done.\n");
	if (errors)
		fprintf(stderr, "WARNING: %d errors.\n",=
 errors);
	free(a);
	exit(0);
}


void start_procs(int n, int p, int s)
{
	int i, pid[MAX_PROCS];
	int status;

	if (p > MAX_PROCS)
		p =3D MAX_PROCS;

	for (i =3D 0; i < p; i++) {
		pid[i] =3D fork();
		if (pid[i] =3D=3D 0)
			do_qsort(n, s);
		else if (pid[i] < 0)
			perror("fork");
	}

	for (i =3D 0; i < p; i++)
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
	char *n =3D "1000000", *p =3D "1", *s =3D "1";
	int nr_elems, nr_procs, seed;
	int c;

	if (argc =3D=3D 1)
		usage();

	while (1) {
		c =3D getopt(argc, argv, "hn:p:s:V");
		if (c =3D=3D -1)
			break;

		switch (c) {
		case 'h':
			usage();
		case 'n':
			n =3D optarg;
			break;
		case 'p':
			p =3D optarg;
			break;
		case 's':
			s =3D optarg;
			break;
		case 'V':
			printf("Version 0.93\n");
			return 1;
		case '?':
			return 1;
		}
	}

	nr_elems =3D atoi(n);
	nr_procs =3D atoi(p);
	seed =3D atoi(s);
	start_procs(nr_elems, nr_procs, seed);

	return 0;
}

--=====================_1004905067==_
Content-Type: text/plain; charset="us-ascii"



-- 
Lorenzo
--=====================_1004905067==_--

