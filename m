Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUIFHon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUIFHon (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 03:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUIFHon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 03:44:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:58833 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267248AbUIFHoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 03:44:02 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       felipe_alfaro@linuxmail.org
In-Reply-To: <20040906063040.GA11541@elte.hu>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
	 <1094408203.4445.5.camel@krustophenia.net> <20040905191227.GA29797@elte.hu>
	 <1094418192.4445.58.camel@krustophenia.net>
	 <20040906063040.GA11541@elte.hu>
Content-Type: text/plain
Message-Id: <1094456653.29921.45.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 06 Sep 2004 03:44:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-06 at 02:30, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-R0#/var/www/2.6.9-rc1-R0/foo.hist
> > 
> > I find the two smaller spikes to either side of the central spike
> > really odd.  These showed up in my jackd tests too, I had attributed
> > them to some measurement artifact, but they seem real.  Maybe a
> > rounding bug, or some kind of weird cache effect?
> 
> interesting - the histograms are pretty symmetric around the center.
> E.g. the exponential foo.hist2 diagram is way too symmetric around 50
> usecs! What precisely is being measured?
> 

Here's the program.  It does mlockall(), acquires realtime scheduling,
then sets up a 2048 Hz stream of interupts from the RTC and measures the
delay.  It's quite possible there's a bug, the amlat program did not
seem to work, something must have changed with the RTC from 2.4 to 2.6.

/*
 * This was originally written by Mark Hahn.  Obtained from
 * http://brain.mcmaster.ca/~hahn/realfeel.c
 */

#include <linux/rtc.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>
#include <sys/mman.h>
#include <sched.h>
#include <sys/signal.h>
#include <string.h>

#define _GNU_SOURCE
#include <getopt.h>


/* global vars */
int stopit;				/* set to stop measuring */

#define SAMPLES	10000
int histogram[SAMPLES];			/* Milliseconds */

#define PAGE_SIZE	4096UL		/* virtual memory page size */
#define OSCR_HZ		3686400		/* frequency of clock ticks */
#define OSCR		0x90000010	/* physical address of OSCR register */
unsigned long *oscr;			/* ptr to OSCR */


void setup_clock (void)
{
	int fd;
	void *map_base;
	off_t target;
	off_t page;

#ifndef ARCHARM
	return;
#endif

	fd = open ("/dev/mem", O_RDWR | O_SYNC);
	if (-1 == fd) {
	    perror ("open of /dev/mem failed\n");
	    exit (1);
	}

	/* Map one page */
	target = OSCR;
	page = target & ~(PAGE_SIZE - 1);
	map_base = mmap (0, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, page);
	if (MAP_FAILED == map_base) {
	    perror ("mmap failed");
	    (void) close (fd);
	    exit (2);
	}
	oscr = map_base + (target - page);

	/* This does not end the mmap,
	 * the mmap will go away when the process dies
	 */
	close (fd);
}

double second() {
	struct timeval tv;
	gettimeofday(&tv,0);
	return tv.tv_sec + 1e-6 * tv.tv_usec;
}

typedef unsigned long long u64;

u64 rdtsc() {
	u64 tsc;
#ifdef ARCHARM
	tsc = *oscr;
#else
	__asm__ __volatile__("rdtsc" : "=A" (tsc));
#endif
	return tsc;
}

void selectsleep(unsigned us) {
	struct timeval tv;
	tv.tv_sec = 0;
	tv.tv_usec = us;
	select(0,0,0,0,&tv);
}

double secondsPerTick, ticksPerSecond;

void calibrate()
{
	double sumx = 0;
	double sumy = 0;
	double sumxx = 0;
	double sumxy = 0;
	double slope;

	// least squares linear regression of ticks onto real time
	// as returned by gettimeofday.

	const unsigned n = 30;
	unsigned i;

	for (i=0; i<n; i++) {
		double breal,real,ticks;
		u64 bticks;
	
		breal = second();
		bticks = rdtsc();

		selectsleep((unsigned)(10000 + drand48() * 200000));

		ticks = rdtsc() - bticks;
		real = second() - breal;

		sumx += real;
		sumxx += real * real;
		sumxy += real * ticks;
		sumy += ticks;
	}
	slope = ((sumxy - (sumx*sumy) / n) /
		 (sumxx - (sumx*sumx) / n));
	ticksPerSecond = slope;
	secondsPerTick = 1.0 / slope;
	printf("%3.3f MHz\n",ticksPerSecond*1e-6);
}

void fatal(char *msg)
{
	perror(msg);
	exit(1);
}

int set_realtime_priority(void)
{
	struct sched_param schp;
	/*
	 * set the process to realtime privs
	 */
	memset(&schp, 0, sizeof(schp));
	schp.sched_priority = sched_get_priority_max(SCHED_FIFO);
	
	if (sched_setscheduler(0, SCHED_FIFO, &schp) != 0) {
		perror("sched_setscheduler");
		exit(1);
	}

	return 0;
}

void hist(char *file)
{
	int i;
	FILE *f;

	f = fopen(file, "w");
	if (f == 0) {
		fprintf(stderr, "realfeel: can't open `%s':%s\n",
			file, strerror(errno));
		exit(1);
	}

	for (i = 0; i < SAMPLES; i++) {
		if (histogram[i]) {
			fprintf(f, "%d.%d %d\n",
				i / 10, i % 10, histogram[i]);
		}
	}
	fclose(f);
	exit(0);
}

void signalled(int sig)
{
	stopit = 1;
}

static void usage(void)
{
	fprintf(stderr, "Usage: realfeel [--samples n] [--hertz n] filename.hist\n");
	exit(1);
}

uint bounded=0;
uint ncycles=0;
uint current=0;
int hz = 2048;

char *parse_options(int argc, char **argv)
{
  int c, option_index;

  static struct option long_options[] = {
    {"samples", required_argument, 0, 0},
    {"hertz", required_argument, 0, 0}, 
    {0, 0, 0, 0}, 
  };
  
  while ((c = getopt_long (argc, argv, "b:", long_options, &option_index)) != -1) {
    switch (option_index) {
      
    default:
    case -1:
      fprintf (stderr, "Bad option (%s)\n", optarg);
      usage();
      exit (1);
      break;

    case 0:
      bounded = 1;
      ncycles = atoi(optarg);
      break;

    case 1:
      hz = atoi(optarg);
      if (hz > 2048) {
	fprintf(stderr, "max allowable interrupt frequency is 2048 Hz\n");
	hz = 2048;
      }
      else if (hz <= 0) {
	fprintf(stderr, "zero or negative frequency doesn't make sense!\n");
	hz = 1;
      }
    }
  }

  if (argv[optind] == NULL) {
    fprintf(stderr, "histogram file name required\n");
    usage();
    exit (2);
  }

  return argv[optind];
}


#define msec(f) (1e3 * (f))
#define usec(f) (1e6 * (f))

int main(int argc, char *argv[])
{
	int fd;
	double ideal;
	u64 last;
	double max_delay = 0;
	char *histfile = parse_options(argc, argv);

	if (mlockall(MCL_CURRENT|MCL_FUTURE) != 0) {
		perror("mlockall");
		exit(1);
	}
	setup_clock ();
	set_realtime_priority();
	calibrate();
	printf("secondsPerTick=%f\n", secondsPerTick);
	printf("ticksPerSecond=%f\n", ticksPerSecond);

	fd = open("/dev/rtc",O_RDONLY);
	if (fd == -1) 
		fatal("failed to open /dev/rtc");

	ideal = 1.0 / hz;

	if (ioctl(fd, RTC_IRQP_SET, hz) == -1)
		fatal("ioctl(RTC_IRQP_SET) failed");

	printf("Interrupt frequency: %d Hz\n",hz);

	if (bounded) {
	  printf("running for %d samples\n", ncycles);
	}

	/* Enable periodic interrupts */
	if (ioctl(fd, RTC_PIE_ON, 0) == -1)
		fatal("ioctl(RTC_PIE_ON) failed");


	signal(SIGINT, signalled);

	last = rdtsc();

	while (!stopit) {
		u64 now;
		double delay;
		int data;
		int ms;

		if (read(fd, &data, sizeof(data)) == -1)
			fatal("blocking read failed");

		now = rdtsc();
		delay = secondsPerTick * (now - last);
		if (delay > max_delay) {
			max_delay = delay;
		//	printf("%.3f msec\n", -(1e3 * (ideal - delay)));
		}
		ms = (-(ideal - delay) + 1.0/20000.0) * 10000000;
		if (ms < 0)
			ms = 0;		/* hmmm */
		if (ms >= SAMPLES)
			ms = SAMPLES;
		histogram[ms]++;

		if (bounded) {
		  if (++current >= ncycles) {
		    printf ("finished collecting %d samples\n", ncycles);
		    printf ("maximum cycle time: %.3fms\n", 
			    -msec(ideal - max_delay));
		    break;
		  }

		  if ((current % 10000) == 0) {
		    printf("%d cycles (max cycle time so far: %.3fus)\n",
			   current, -(usec(ideal - max_delay)));
		  }
		}

		last = now;
	}
	if (ioctl(fd, RTC_PIE_OFF, 0) == -1)
		fatal("ioctl(RTC_PIE_OFF) failed");

	hist(histfile);

	return 0;
}


> 	Ingo
> 

