Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965270AbWH2Sl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbWH2Sl5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbWH2Sl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:41:57 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43700 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965270AbWH2Slz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:41:55 -0400
Date: Tue, 29 Aug 2006 11:41:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: Why Semaphore Hardware-Dependent?
In-Reply-To: <200608292018.01602.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0608291136440.20095@schroedinger.engr.sgi.com>
References: <44F395DE.10804@yahoo.com.au> <200608291922.04354.ak@suse.de>
 <Pine.LNX.4.64.0608291033380.19174@schroedinger.engr.sgi.com>
 <200608292018.01602.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006, Andi Kleen wrote:

> > Correct. However, a cmpxchg may have to acquire that cacheline multiple 
> > times in a highly contented situation.
> 
> Hmm, thinking about it that sounds unlikely because only the first and the last
> user should touch the rwsem head. But ok it might be possible.

Well that sounds encouraging.

> BTW maybe it would be a good idea to switch the wait list to a hlist,
> then the last user in the queue wouldn't need to 
> touch the cache line of the head. Or maybe even a single linked
> list then some more cache bounces might be avoidable.
> 
> That is really why we need a single C implementation. If we had that 
> such optimizations would be pretty easy. Without it it's a big mess.

I am all for optimizations....
> 
> > We have long tuned that portion of the code and therefore we are 
> > skeptical of changes. But if we cannot measure a difference to a 
> > generic implemenentation then it would be okay.
> 
> Would you be willing to run numbers comparing them? (or provide a benchmark?) 

Yes. The infamous page fault test (pft.c) really hits this one hard and on 
a large SMP system you should be able to see problems immediately. In fact 
since the page table lock scaling fixes the page fault rate 
on our large system is limited by rwsem performance due to the mmap_sem 
cacheline becoming contended. We'd be glad about any improvements in our 
numbers.


Benchmark code follows (you may have to do some tweaking for 32 
bit):

#include <pthread.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <sys/mman.h>
#include <time.h>
#include <errno.h>
#include <sys/resource.h>

extern int      optind, opterr;
extern char     *optarg;

long     bytes=16384;
long     sleepsec=0;
long     verbose=0;
long     forkcnt=1;
long     repeatcount=1;
long	cachelines=1;
long     do_bzero=0;
long     mypid;
int 	title=0;

volatile int    go, state[128];

struct timespec wall,wall_end,wall_start;
struct rusage ruse;
long faults;
long pages;
long gbyte;
double faults_per_sec;
double faults_per_sec_per_cpu;

#define perrorx(s)      (perror(s), exit(1))
#define NBPP            16384

void* test(void*);
void  launch(void);


main (int argc, char *argv[])
{
        int                     i, j, c, stat, er=0;
        static  char            optstr[] = "b:c:f:g:r:s:vzHt";


        opterr=1;
        while ((c = getopt(argc, argv, optstr)) != EOF)
                switch (c) {
                case 'g':
                        bytes = atol(optarg)*1024*1024*1024;
                        break;
                case 'b':
                        bytes = atol(optarg);
                        break;
		case 'c':
			cachelines = atol(optarg);
                case 'f':
                        forkcnt = atol(optarg);
                        break;
                case 'r':
                        repeatcount = atol(optarg);
                        break;
                case 's':
                        sleepsec = atol(optarg);
                        break;
                case 'v':
                        verbose++;
                        break;
                case 'z':
                        do_bzero++;
                        break;
                case 'H':
                        er++;
                        break;
		case 't' :
			title++;
			break;
                case '?':
                        er = 1;
                        break;
                }

        if (er) {
                printf("usage: %s %s\n", argv[0], optstr);
                exit(1);
        }

	pages = bytes*repeatcount/getpagesize();
	gbyte = bytes/(1024*1024*1024);
	bytes = bytes/forkcnt;

	clock_gettime(CLOCK_REALTIME,&wall_start);

	if (verbose) printf("Calculated pages=%ld pagesize=%ld.\n",pages,getpagesize());

        mypid = getpid();
        setpgid(0, mypid);

        for (i=0; i<repeatcount; i++) {
                if (fork() == 0)
                        launch();
                while (wait(&stat) > 0);
        }
	
	getrusage(RUSAGE_CHILDREN,&ruse);
	clock_gettime(CLOCK_REALTIME,&wall_end);
	wall.tv_sec = wall_end.tv_sec - wall_start.tv_sec;
	wall.tv_nsec = wall_end.tv_nsec - wall_start.tv_nsec;
	if (wall.tv_nsec <0 )		{ wall.tv_sec--; wall.tv_nsec += 1000000000; }
	if (wall.tv_nsec >1000000000)	{ wall.tv_sec++; wall.tv_nsec -= 1000000000; }
	if (verbose) printf("Calculated faults=%ld. Real minor faults=%ld, major faults=%ld\n",pages,ruse.ru_minflt+ruse.ru_majflt);
	faults_per_sec=(double) pages / ((double) wall.tv_sec + (double) wall.tv_nsec / 1000000000.0);
	faults_per_sec_per_cpu=(double) pages /  (
		(double) (ruse.ru_utime.tv_sec + ruse.ru_stime.tv_sec) + ((double) (ruse.ru_utime.tv_usec + ruse.ru_stime.tv_usec) / 1000000.0));
	if (title) printf(" Gb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec\n");
	printf("%3ld %2ld %4ld %3ld %4ld.%02lds%7ld.%02lds%4ld.%02lds%10.3f %10.3f\n",
		gbyte,repeatcount,forkcnt,cachelines,
		ruse.ru_utime.tv_sec,ruse.ru_utime.tv_usec/10000,
		ruse.ru_stime.tv_sec,ruse.ru_stime.tv_usec/10000,
		wall.tv_sec,wall.tv_nsec/10000000,
		faults_per_sec_per_cpu,faults_per_sec);
        exit(0);
}

char *
do_shm(long shmlen) {
        char    *p;
        int     shmid;

        printf ("Try to allocate TOTAL shm segment of %ld bytes\n", shmlen);

        if ((shmid = shmget(IPC_PRIVATE, shmlen, SHM_R|SHM_W))  == -1)
                perrorx("shmget faiiled");

        p=(char*)shmat(shmid, (void*)0, SHM_R|SHM_W);
	printf("  created, adr: 0x%lx\n", (long)p);
	printf("  attached\n");
        bzero(p, shmlen);
	printf("  zeroed\n");

        // if (shmctl(shmid,IPC_RMID,0) == -1)
        //        perrorx("shmctl failed");
	// printf("  deleted\n");
	
	return p;


}

void
launch()
{
        pthread_t                       ptid[128];
        int     i, j;

        for (j=0; j<forkcnt; j++)
                if (pthread_create(&ptid[j], NULL, test, (void*) (long)j) < 0)
                        perrorx("pthread create");

        if(0) for (j=0; j<forkcnt; j++)
                while(state[j] == 0);
        go = 1;
        if(0) for (j=0; j<forkcnt; j++)
                while(state[j] == 1);
        for (j=0; j<forkcnt; j++)
                pthread_join(ptid[j], NULL);
        exit(0);
}

void*
test(void *arg)
{
        char    *p, *pe;
        long    id;
	int cl;
         
        id = (long) arg;
        state[id] = 1;
        while(!go);
        p = malloc(bytes);
        // p = do_shm(bytes);
	if (p == 0) {
	    printf("malloc of %Ld bytes failed.\n",bytes);
	    exit;
	} else 
	    if (verbose) printf("malloc of %Ld bytes succeeded\n",bytes);
        if (do_bzero)
                bzero(p, bytes);
        else {
                for(pe=p+bytes; p<pe; p+=16384)
			for(cl=0; cl<cachelines;cl++)
                        	p[cl*128] = 'r';
        }
        sleep(sleepsec);
        state[id] = 2;
        pthread_exit(0);
}
