Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269693AbRHDAZ2>; Fri, 3 Aug 2001 20:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269727AbRHDAZT>; Fri, 3 Aug 2001 20:25:19 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:53194 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S269693AbRHDAZH>; Fri, 3 Aug 2001 20:25:07 -0400
Message-Id: <5.1.0.14.2.20010803164849.02d88e30@pop.we.mediaone.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 03 Aug 2001 17:24:24 -0700
To: linux-kernel@vger.kernel.org
From: Eric Taylor <et@rocketship1.com>
Subject: "[BUG] linux-2.4.7, <kswapd goes into deep thought ~30 secs
  locks up system>"
Cc: eric.a.tailor@jpl.nasa.gov
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a 2.4.7 (and .5,.6 also) Intel kernel, a large malloc,
that is more than the total of physical ram, (with large
swapfile) that is written to can cause a long system freeze.

If one proceeds to init the allocated memory 
in sequence (but not to exclude other orderings) e.g. init to
all non-zero values (value may not be important, just haven't
tried all zeros) once you reach about 2x the size of physical
ram, the system locks up for 30 seconds or more at a time. No
xterm or telnet or console windows respond. Eventually, the system
comes back to normal, but this can be as much as 5 minutes. Top
then updates and shows that [kswapd] has all the cpu time during
the interval. I have a small test case program (attached) that
can cause the problem.

I also sometimes see strange values for shared memory (in top) that
don't make any sense. The test program uses no shared memory.

regards,
eric
et@rocketship1.com
please cc me on any reply



Details:
#==========

I have seen this behavior on 3 systems: 

First: A 400mhz pentiumII with
512 meg ram and 1.5 gig swapspace. The included program is run thus:

memtest m 1200

Where the 1200 means 1.2 gigs of memory are malloc'd and then
a for loop inits this 32 bits at a time in sequence to some integer value.
The program writes to stdout each meg that it has inited, i.e.
1,2,...1200 but never reaches 1200. At about 1000 (on my 1/2 gig
system) the program does not make any further progress, the
system becomes totally unresponsive (except I was able to hear
my swap disk kick in for a second or so every so often, and pings
from another system respond). About every 30 seconds or so, top
will update it's screen and the mouse will move a bit etc. Top
shows that kswapd has all the cpu time.

Just prior to the freeze, top will begin to show large values
for shared memory. The share and rss values become large, change
rapidly, but have different values. After the freeze is over, the
rss and share are often (always I think, but not certain) the same.

If I kill the program and start over, the scenario repeats.

Second: On a dual 1ghz smp system, with 2 gigs of ram and some other
processes running (6 using 200meg each), I tried this:

memtest m 2000

and it would get to a point about 800 or so, and it too would lock
up. Again, when it finally kicks loose, top shows kswapd to be
the culprit.

On a 3rd system, one with only 128meg, I cannot reproduce the problem
to the same extent. I do see lots of time given to kswapd and the
system is not too responsive (i.e. mouse jumpy) but it does not
reproduce the same situation. 

My efforts:
----------

I have built my own kernel with an array of counters that I increment
in each of the functions in various routines in vmscan.c and a few others.
While I do see some large counts once swapping begins, I have not been
able to determine a particularly large jump when it gets into freeze mode.

I then tried to write a module that along with some debug /proc variables
would allow me to schedule a routine on the timer interrupt, but was unable
to determine the current program counter (eip register value) for kswapd.
My idea was to test current->pid for 5 which is usually kswapd and then
if true, try to see where kswapd was running (i.e. get its eip contents).

Apparently, kswapd does not have a task->mm pointer, so I cannot use the
code from proc_pid_stat which can get the saved pc (on my uniprocessor).
If I could sample the kswapd thread's program counters I could narrow the
location of the loop down so as perhaps to help debug this problem. But
I am stuck at this point. I think my code was correct, as /proc/5/stat
shows all zeros for the eip and esp registers and other mm stuff.

Maybe someone could help out here and point me to some code that would be
able to determine this threads location during a timer interrupt.

my test code:
------------


just call it memtest.c

build: gcc -o memtest memtest.c

run:   memtest m nnn

where nnn is number of megs to allocate an test.

If it gets past the initial stage, it will read/write
the memory with a test pattern. For this problem, if it
gets that far, then you need to use a larger value for nnn
and start over.

------ memtest.c ---------

#include <time.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/io.h>
#include <fcntl.h>      
#include <stdlib.h>
#include <stdio.h>
#define SIZE 4 * 1024 * 250
char buffer[SIZE];
char buffer2[SIZE];
int *buff,*buff2;
#define _O_RDONLY O_RDONLY 
#define _O_CREAT O_CREAT
#define _O_RDRW O_RDRW 
#define _O_RDWR O_RDWR 
#define _O_RANDOM 0
#define _O_BINARY 0
#define _open(a,b) open((a),(b))
#define _read(a,b,c) read((a),(b),(c))
#define _lseek(a,b,c) lseek((a),(b),(c))
#define _write(a,b,c) write((a),(b),(c))

#define ERR 100
#define OK 0
char * timeis() {
	struct tm *newtime;
	static char buf[100];
	time_t aclock;
    time( &aclock );                 /* Get time in seconds */
    newtime = localtime( &aclock );  /* Convert time to struct */
	strcpy(buf,(char *)asctime( newtime )+11);
	buf[strlen(buf)-1-4] = '\0';
	return buf;
}
main(int argc, char **argv) {int r=0;

#ifdef _DEBUG
	{int ac ; char ** av;
	av = malloc(50);
	av[1] = "i:\\drives\\jul13.pqi";
	av[2] = "g:\\jul13.pqi";
	main2(3,av);
	r = 0;
	}
#else
	if (argc <= 2) {
		printf("\n");
		printf("usage: fr m size(millions)     -- simple mem test, 10 = 10 million bytes etc.\n");
		printf("\n");
		printf("memory test allocates amount of memory specified and reads/writes\n");
		printf("a rotating pattern\n");
		r = 0;
		return r;
	}
	if (argv[1][0] == 's') {
	} else if (argv[1][0] == 'm') {
		r =main0(argc-1,&argv[1]);
	} else if (argv[1][0] == 'w') {
	} else {
	}
#endif





	printf("return = %d, finished at %s\n",r, timeis() );
	return r;



}
static t[] = {0,1,2,4,8,16,32,64};
main0(int argc, char **argv) {
	int *m; int i,j,k,e=0,v;
	unsigned int sizeb,size,sizel;
	double sex,asex=0.0;
	time_t start,finish; int times=0;

	if (argc <= 1) {
		printf("usage: fr m bytes\n");
		return ERR;
	}
	size = atoi(argv[1]);
	printf("Do mem %d %s\n",size,timeis());
	sizeb = size * 1024 * 1024;
	m = malloc(sizeb);
	printf("Do mem %u (%u)%08x %s malloc complete\n",size,sizeb,sizeb,timeis());

	sizel = sizeb/4;
	if (!m) {
		perror("error allocating memory");
		return ERR;
	}
	for(i = 0 ; i <  sizel ; i++ ) {
		m[i] = 0xaaaaaaaa; // alternating ones and zeros
		if ((i % (1024*1024/4)) == 0) {
					printf("=%4d\r",   (i/(1024*1024/4)) +1);fflush(stdout);
		}
	}
	k=0;
	for(;;){
		k++;
		for(j = 0 ; j <  32 ; j++ ) {
		  time(&start);
			v = 0xaaaaaaaa>>j;
			for(i = 0 ; i <  sizel ; i++ ) {
				m[i] = v; // alternating ones and zeros
			}
			printf("*--------\r");fflush(stdout);
			for(i = 0 ; i <  sizel ; i++ ) {
				if (m[i] != v) {
					//printf("error at %d  value = %08x\n",i,m[i]);
					e++;
				}
				 // alternating ones and zeros
			}
		  time(&finish);
			sex = (double) difftime( finish, start ); asex = asex + sex;times++;
			printf(" %08x %4d : %2d (%d errs)  %.2f secs ave=%.2f  %.2f/%-6d  \r",0xaaaaaaaa>>j,k,j,e,sex,asex/times,asex,times);fflush(stdout);
		}
		for(j = 0 ; j <  32 ; j++ ) {
		time(&start);
			v = 0xaaaaaaaa<<j;
			for(i = 0 ; i <  sizel ; i++ ) {
				m[i] = v; // alternating ones and zeros
			}
			for(i = 0 ; i <  sizel ; i++ ) {
				if (m[i] != v) {
					//printf("error at %d  value = %08x\n",i,m[i]);
					e++;
				}
				 // alternating ones and zeros
			}
		time(&finish);
			sex = (double) difftime( finish, start ); asex = asex + sex;times++;
			printf(" %08x %4d : %2d (%d errs)  %.2f secs ave=%.2f  %.2f/%-6d  \r",0xaaaaaaaa<<j,k,j,e,sex,asex/times,asex,times);fflush(stdout);
		}
	}
	
}






