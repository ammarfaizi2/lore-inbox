Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbVIORLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbVIORLz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 13:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbVIORLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 13:11:54 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:15810 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1030529AbVIORLy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 13:11:54 -0400
Message-ID: <4329AB3E.1070904@cosmosbay.com>
Date: Thu, 15 Sep 2005 19:11:26 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] reorder struct files_struct
References: <20050914.125750.05416211.davem@davemloft.net> <20050914201550.GB6315@in.ibm.com> <20050914.132936.105214487.davem@davemloft.net> <43289376.7050205@cosmosbay.com> <20050914220205.GC6237@in.ibm.com> <4328A73B.1080801@cosmosbay.com> <20050914225043.GD6237@in.ibm.com> <4328B013.1010400@cosmosbay.com> <20050915045440.GE6237@in.ibm.com> <43291204.9060208@cosmosbay.com> <20050915093518.GB5168@in.ibm.com>
In-Reply-To: <20050915093518.GB5168@in.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030702070203080801070507"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 15 Sep 2005 19:11:27 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030702070203080801070507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Dipankar Sarma a écrit :
> On Thu, Sep 15, 2005 at 08:17:40AM +0200, Eric Dumazet wrote:
>>The point is that we gain nothing in this case for 32 bits platforms, but 
>>we gain something on 64 bits platform. And for apps using more than 
> 
> 
> I am not sure about that. IIRC, x86_64 has a 128-byte L1 cacheline.
> So, count, fdt, fdtab, close_on_exec_init and open_fds_init would
> all fit into one cache line. And close_on_exec_init will get updated
> on open(). Also, most apps will not likely have more than the
> default # of fds, it might not be a good idea to optimize for
> that case.

x86_64 has 64-bytes L1 cache line, at least for AMD cpus.
SMP P3 are quite common and they have 32-bytes L1 cache line.

*** WARNING *** BUG **** :

In the mean time I discovered that sizeof(fd_set) was 128 bytes !
I thought it was sizeof(long) only.

This is a huge waste of 248 bytes for most apps (apps that open less than 32 
or 64 files)

>>
>>Moving next_fd from 'struct fdtable' to 'struct files_struct' is also a win 
>>for 64bits platforms since sizeof(struct fdtable) become 64 : a nice power 
>>of two, so 64 bytes are allocated instead of 128.
> 
> 
> Can you benchmark this on a higher end SMP/NUMA system ?

Well, I can benchmark on a dual Xeon 2GHz machine. (Dell Poweredge 1600SC)
Thats 2 physical cpus, four logical cpus (thanks to HyperThreading)
Not exactly higher end NUMA systems unfortunatly.


here are the results :

linux-2.6.14-rc1

# ./bench -t 1 -l 100 -s   # one thread, small fdset
1 threads, 100.005352 seconds, work_done=8429730
# ./bench -t 1 -l 100      # one thread, big fdset
1 threads, 100.006087 seconds, work_done=8343664

# ./bench -t 1 -l 100 -s -i  # one thread plus one idle thread to force locks
1 threads, 100.007956 seconds, work_done=6786008
# ./bench -t 1 -l 100 -i # one thread + idle, bigfdset
1 threads, 100.005044 seconds, work_done=6791259

# ./bench -t 2 -l 100 -s # two threads, small fdset
2 threads, 100.002860 seconds, work_done=11034805
# ./bench -t 2 -l 100 # two threads, big fdset
2 threads, 100.006046 seconds, work_done=11063804

# ./bench -t 2 -l 100 -s -a 5 # force affinity to two phys CPUS
2 threads, 100.004547 seconds, work_done=10825310
# ./bench -t 2 -l 100 -a 5
2 threads, 100.006288 seconds, work_done=11273778

# ./bench -t 4 -l 100 -s # Four threads, small fdset
4 threads, 100.007234 seconds, work_done=15061795
# ./bench -t 4 -l 100 # Four threads, big fdset
4 threads, 100.007620 seconds, work_done=14811832


linux-2.6.14-rc1 + patch :


# ./bench -t 1 -l 100 -s  # one thread, small fdset
1 threads, 100.005759 seconds, work_done=8406981 (~same)
# ./bench -t 1 -l 100     # one thread, big fdset
1 threads, 100.006887 seconds, work_done=8350681 (~same)

# ./bench -t 1 -l 100 -s -i # one thread plus one idle thread to force locks
1 threads, 100.005829 seconds, work_done=6858520 (1% better)
# ./bench -t 1 -l 100 -i # one thread + idle, bigfdset
1 threads, 100.007902 seconds, work_done=6847941 (~same)

# ./bench -t 2 -l 100 -s # two threads, small fdset
2 threads, 100.005877 seconds, work_done=11257165 (2% better)
# ./bench -t 2 -l 100 # two threads, big fdset
2 threads, 100.005561 seconds, work_done=11520262 (4% better)

# ./bench -t 2 -l 100 -s -a 5 # force affinity to two phys CPUS
2 threads, 100.006744 seconds, work_done=11505449 (6% better)
# ./bench -t 2 -l 100 -a 5
2 threads, 100.006706 seconds, work_done=11688051 (3% better)

# ./bench -t 4 -l 100 -s # Four threads, small fdset
4 threads, 100.007496 seconds, work_done=15556770 (3% better)
# ./bench -t 4 -l 100 # Four threads, big fdset
4 threads, 100.009882 seconds, work_done=16145618 (9% better)


linux-2.6.14-rc1 + patch + two embedded fd_set replaced by a long :
(this change should also speedup fork())

struct fdtable {
         unsigned int max_fds;
         int max_fdset;
         struct file ** fd;      /* current fd array */
         fd_set *close_on_exec;
         fd_set *open_fds;
         struct rcu_head rcu;
         struct files_struct *free_files;
         struct fdtable *next;
};

/*
  * Open file table structure
  */
struct files_struct {
/* read mostly part */
         atomic_t count;
         struct fdtable *fdt;
         struct fdtable fdtab;
/* written part */
         spinlock_t file_lock ____cacheline_aligned_in_smp;
         int next_fd;
         unsigned long close_on_exec_init;
         unsigned long open_fds_init;
         struct file * fd_array[NR_OPEN_DEFAULT];
};



# grep files_cache /proc/slabinfo
files_cache           53    195    256   15    1 : tunables  120   60    8 : 
slabdata     13     13      0
  (256 bytes used instead of 512 for files_cache objects)

# ./bench -t 1 -l 100 -s  # one thread, small fdset
1 threads, 100.007298 seconds, work_done=8413167 (~same)
# ./bench -t 1 -l 100     # one thread, big fdset
1 threads, 100.006007 seconds, work_done=8441197 (1% better)

# ./bench -t 1 -l 100 -s -i # one thread plus one idle thread to force locks
1 threads, 100.005101 seconds, work_done=6870893 (1% better)
# ./bench -t 1 -l 100 -i # one thread + idle, bigfdset
1 threads, 100.005285 seconds, work_done=6852314 (~same)

# ./bench -t 2 -l 100 -s # two threads, small fdset
2 threads, 100.007029 seconds, work_done=11424646 (3.5 % better)
# ./bench -t 2 -l 100 # two threads, big fdset
2 threads, 100.006128 seconds, work_done=11634769 (5% better)

# ./bench -t 2 -l 100 -s -a 5 # force affinity to two phys CPUS
2 threads, 100.008100 seconds, work_done=11408030 (5% better)
# ./bench -t 2 -l 100 -a 5
2 threads, 100.004221 seconds, work_done=11686082 (3% better)

# ./bench -t 4 -l 100 -s # Four threads, small fdset
4 threads, 100.008243 seconds, work_done=15818419 (5% better)
# ./bench -t 4 -l 100 # Four threads, big fdset
4 threads, 100.008279 seconds, work_done=16352921 (10% better)


I suspect that NUMA machines will get more interesting results...

Eric

Attached bench source code.
Compile : gcc -O2 -o bench bench.c -lpthread


--------------030702070203080801070507
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
#include <sys/time.h>
#include <string.h>
#include <sched.h>
#include <errno.h>
#include <signal.h>

static pthread_mutex_t  mut = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

static int sflag; /* small fdset */
static int end_prog;
static unsigned long work_done;
static char onekilo[1024];

static void catch_alarm(int sig)
{
	end_prog = 1;
}

static void *perform_work(void *arg)
{
	int fd, i;
	unsigned long units = 0;
	int fds[64];
	char filename[64];
	char c;
	strcpy(filename, "/tmp/benchXXXXXX");
	fd = mkstemp(filename);
	write(fd, onekilo, sizeof(onekilo));
	close(fd);

	/* force this program to open more than 64 fds */
	if (!sflag)
		for (i = 0 ; i < 64 ; i++)
			fds[i] = open("/dev/null", O_RDONLY);

	while (!end_prog) {
		fd = open(filename, O_RDONLY);
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
	unlink(filename);
	if (!sflag)
		for (i = 0 ; i < 64 ; i++)
			close(fds[i]);
	pthread_mutex_lock(&mut);
	work_done += units;
	pthread_mutex_unlock(&mut);
	return 0;
}

static void *idle_thread(void *arg)
{
	pthread_mutex_lock(&mut);
	while (!end_prog) {
		pthread_cond_wait(&cond, &mut);
	}
	pthread_mutex_unlock(&mut);
}

static void usage(int code)
{
	fprintf(stderr, "Usage : bench [-i] [-s] [-a affinity_mask] [-t threads] [-l duration]\n");
	exit(code);
}

int main(int argc, char *argv[])
{
	int i, c;
	int nbthreads = 2;
	int iflag = 0;
	unsigned int length = 10;
	pthread_t *tid;
	struct sigaction sg;
	struct timeval t0, t1;
	long mask = 0;

	while ((c = getopt(argc, argv, "sit:l:a:")) != -1) {
		if (c == 't')
			nbthreads = atoi(optarg);
		else if (c == 'l')
			length = atoi(optarg);
		else if (c == 's')
			sflag = 1;
		else if (c == 'i')
			iflag = 1;
		else if (c == 'a')
			sscanf(optarg, "%li", &mask);
		else usage(1);
	}
	if (mask != 0) {
		int res = sched_setaffinity(0, &mask);
		if (res != 0)
			fprintf(stderr, "sched_affinity(0x%lx)->%d errno=%d\n", mask, res, errno);
	}


	tid = malloc(nbthreads*sizeof(pthread_t));
	gettimeofday(&t0, NULL);
	for (i = 1 ; i < nbthreads; i++)
		pthread_create(tid + i, NULL, perform_work, NULL);
	if (iflag)
		pthread_create(tid, NULL, idle_thread, NULL);
	memset(&sg, 0, sizeof(sg));
	sg.sa_handler = catch_alarm;
	sigaction(SIGALRM, &sg, NULL);
	alarm(length);
	perform_work(NULL);

	if (iflag) {
		pthread_cond_signal(&cond);
		pthread_join(tid[0], NULL);
	}
	for (i = 1 ; i < nbthreads; i++)
		pthread_join(tid[i], NULL); 

	gettimeofday(&t1, NULL);
	t1.tv_sec -= t0.tv_sec;
	t1.tv_usec -= t0.tv_usec;
	if (t1.tv_usec < 0) {
		t1.tv_usec += 1000000;
		t1.tv_sec--;
	}
	pthread_mutex_lock(&mut);
	printf("%d threads, %d.%06d seconds, work_done=%lu\n",
		nbthreads, (int)t1.tv_sec, (int)t1.tv_usec, work_done);
	pthread_mutex_unlock(&mut);
	return 0;
}

--------------030702070203080801070507--
