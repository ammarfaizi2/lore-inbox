Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318973AbSHMRYu>; Tue, 13 Aug 2002 13:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSHMRYr>; Tue, 13 Aug 2002 13:24:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:41880 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318982AbSHMRXp>;
	Tue, 13 Aug 2002 13:23:45 -0400
Date: Tue, 13 Aug 2002 19:27:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] clone_startup(), 2.5.31-A0
In-Reply-To: <20020813164415.A11554@infradead.org>
Message-ID: <Pine.LNX.4.44.0208131921020.4369-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Christoph Hellwig wrote:

> > with the help of this syscall glibc's next-generation pthreads code
> 
> have you discussed this code with IBM's pthread group?  I think we don't
> want to add a new syscall that is only useful to glibc..

what i did was i thought about the problem in the generic context of
threading, so these syscalls help both glibc and NGPT.

(i'd have loved to test these concepts with NGPT as well, but i couldnt
get it to run the attached simple pthreads application (perf.c - measures
a few kinds of threaded workloads), with the latest NGPT version from the
NGPT website. So if anyone could send me a working static binary of said
application linked against NGPT, that would be great.)

btw., with the help of these syscalls and futexes, the layer between Linux
and pthreads became very thin - almost nonexistant in the majority of
cases.

	Ingo

#define _GNU_SOURCE	1
#include <argp.h>
#include <error.h>
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <limits.h>
#include <pthread.h>
#include <signal.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>

#ifndef MAX_THREADS
# define MAX_THREADS		100000
#endif
#ifndef DEFAULT_THREADS
# define DEFAULT_THREADS	50
#endif


#define OPT_TO_THREAD	300
#define OPT_TO_PROCESS	301


static const struct argp_option options[] =
  {
    { NULL, 0, NULL, 0, "\
This is a test for threads so we allow ther user to selection the number of \
threads which are used at any one time.  Independently the total number of \
rounds can be selected.  This is the total number of threads which will have \
run when the process terminates:" },
    { "threads", 't', "NUMBER", 0, "Number of threads used at once" },
    { "starts", 's', "NUMBER", 0, "Total number of working threads" },

    { NULL, 0, NULL, 0, "\
Each thread can do one of two things: sleep or do work.  The latter is 100% \
CPU bound.  The work load is the probability a thread does work.  All values \
from zero to 100 (inclusive) are valid.  How often each thread repeats this \
can be determined by the number of rounds.  The work cost determines how long \
each work session (not sleeping) takes.  If it is zero a thread would \
effectively nothing.  By setting the number of rounds to zero the thread \
does no work at all and pure thread creation times can be measured." },
    { "workload", 'w', "PERCENT", 0, "Percentage of time spent working" },
    { "workcost", 'c', "NUMBER", 0,
      "Factor in the cost of each round of working" },
    { "rounds", 'r', "NUMBER", 0, "Number of rounds each thread runs" },

    { NULL, 0, NULL, 0, "\
One parameter for each threads execution is the size of the stack.  If this \
parameter is not used the system's default stack size is used.  If many \
threads are used the stack size should be chosen quite small." },
    { "stacksize", 'S', "BYTES", 0, "Size of threads stack" },
    { "guardsize", 'g', "BYTES", 0,
      "Size of stack guard area; must fit into the stack" },

    { NULL, 0, NULL, 0, "Signal options:" },
    { "to-thread", OPT_TO_THREAD, NULL, 0, "Send signal to main thread" },
    { "to-process", OPT_TO_PROCESS, NULL, 0,
      "Send signal to process (default)" },

    { NULL, 0, NULL, 0, "Administrative options:" },
    { "progress", 'p', NULL, 0, "Show signs of progress" },
    { "timing", 'T', NULL, 0,
      "Measure time from startup to the last thread finishing" },
    { NULL, 0, NULL, 0, NULL }
  };

/* Prototype for option handler.  */
static error_t parse_opt (int key, char *arg, struct argp_state *state);

/* Data structure to communicate with argp functions.  */
static struct argp argp =
{
  options, parse_opt
};


static unsigned long int threads = DEFAULT_THREADS;
static unsigned long int workload = 50;
static unsigned long int workcost = 20;
static unsigned long int rounds = 100;
static long int starts = 5000;
static unsigned long int stacksize;
static long int guardsize = -1;
static bool progress;
static bool timing;
static bool to_thread;


static long int running;
static pthread_mutex_t running_mutex = PTHREAD_MUTEX_INITIALIZER;

static pid_t pid;
static pthread_t tmain;

static clockid_t cl;
static struct timespec start_time;


static pthread_mutex_t sum_mutex = PTHREAD_MUTEX_INITIALIZER;
unsigned int sum;


/* We use 64bit values for the times.  */
typedef unsigned long long int hp_timing_t;


static void *
thread_function (void *arg)
{
  unsigned long int i;
  unsigned int state = (unsigned long int) arg;

  for (i = 0; i < rounds; ++i)
    {
      /* Determine what to do.  */
      unsigned int rnum;

      /* Equal distribution.  */
      do
	rnum = rand_r (&state);
      while (rnum >= UINT_MAX - (UINT_MAX % 100));

      rnum %= 100;

      if (rnum < workload)
	{
	  int j;
	  int a[4] = { i, rnum, i + rnum, rnum - i };

	  if (progress)
	    write (STDERR_FILENO, "c", 1);

	  for (j = 0; j < workcost * 10000; ++j)
	    {
	      a[0] += a[3] >> 12;
	      a[1] += a[2] >> 20;
	      a[2] += a[1] ^ 0x3423423;
	      a[3] += a[0] - a[1];
	    }

	  pthread_mutex_lock (&sum_mutex);
	  sum += a[0] + a[1] + a[2] + a[3];
	  pthread_mutex_unlock (&sum_mutex);
	}
      else
	{
	  /* Just sleep.  */
	  struct timespec tv;

	  tv.tv_sec = 0;
	  tv.tv_nsec = 40000000;

	  if (progress)
	    write (STDERR_FILENO, "w", 1);

	  nanosleep (&tv, NULL);
	}
    }

  pthread_mutex_lock (&running_mutex);
  if (--running <= 0 && starts <= 0)
    {
      /* We are done.  */
      if (progress)
	write (STDERR_FILENO, "\n", 1);

      if (timing)
	{
	  struct timespec end_time;

	  if (clock_gettime (cl, &end_time) == 0)
	    {
	      end_time.tv_sec -= start_time.tv_sec;
	      end_time.tv_nsec -= start_time.tv_nsec;
	      if (end_time.tv_nsec < 0)
		{
		  end_time.tv_nsec += 1000000000;
		  --end_time.tv_sec;
		}

	      printf ("\nRuntime: %lu.%09lu seconds\n",
		      (unsigned long int) end_time.tv_sec,
		      (unsigned long int) end_time.tv_nsec);
	    }
	}

      printf ("Result: %08x\n", sum);

      exit (0);
    }
  pthread_mutex_unlock (&running_mutex);

  if (to_thread)
    /* This code sends a signal to the main thread.  */
    pthread_kill (tmain, SIGUSR1);
  else
    /* Use this code to test sending a signal to the process.  */
    kill (pid, SIGUSR1);

  if (progress)
    write (STDERR_FILENO, "f", 1);

  return NULL;
}


int
main (int argc, char *argv[])
{
  int remaining;
  sigset_t ss;
  pthread_attr_t attr;

  /* Parse and process arguments.  */
  argp_parse (&argp, argc, argv, 0, &remaining, NULL);

  if (timing)
    {
      if (clock_getcpuclockid (0, &cl) != 0
	  || clock_gettime (cl, &start_time) != 0)
	timing = false;
    }

  /* We need this later.  */
  pid = getpid ();
  tmain = pthread_self ();

  /* We use signal SIGUSR1 for communication between the threads and
     the main thread.  We only want sychronous notification.  */
  sigemptyset (&ss);
  sigaddset (&ss, SIGUSR1);
  if (sigprocmask (SIG_BLOCK, &ss, NULL) != 0)
    error (EXIT_FAILURE, errno, "cannot set signal mask");

  /* Create the thread attribute.  */
  pthread_attr_init (&attr);

  /* If the user provided a stack size use it.  */
  if (stacksize != 0
      && pthread_attr_setstacksize (&attr, stacksize) != 0)
    puts ("could not set stack size; will use default");
  /* And stack guard size.  */
  if (guardsize != -1
      && pthread_attr_setguardsize (&attr, guardsize) != 0)
    puts ("invalid stack guard size; will use default");

  /* All threads are created detached.  */
  pthread_attr_setdetachstate (&attr, PTHREAD_CREATE_DETACHED);

  while (1)
    {
      pthread_t th;
      int err;
      bool cont = true;
      bool do_wait = false;;

      pthread_mutex_lock (&running_mutex);
      if (starts-- < 0)
	cont = false;
      else
	do_wait = ++running >= threads && starts > 0;
      pthread_mutex_unlock (&running_mutex);

      if (! cont)
	break;

      if (progress)
	write (STDERR_FILENO, "t", 1);

      err = pthread_create (&th, &attr, thread_function, (void *) starts);
      if (err != 0)
	error (EXIT_FAILURE, err, "cannot start thread %lu", starts);

      if (do_wait)
	sigwaitinfo (&ss, NULL);
    }

  /* Do nothing anymore.  On of the threads will terminate the program.  */
  sigfillset (&ss);
  sigdelset (&ss, SIGINT);
  while (1)
    sigsuspend (&ss);

  /* NOTREACHED */
  return 0;
}


/* Handle program arguments.  */
static error_t
parse_opt (int key, char *arg, struct argp_state *state)
{
  unsigned long int num;
  long int snum;

  switch (key)
    {
    case 't':
      num = strtoul (arg, NULL, 0);
      if (num < MAX_THREADS)
	threads = num;
      else
	printf ("\
number of threads limited to %u; recompile with a higher limit if necessary",
		MAX_THREADS);
      break;

    case 'w':
      num = strtoul (arg, NULL, 0);
      if (num <= 100)
	workload = num;
      else
	puts ("workload must be between 0 and 100 percent");
      break;

    case 'c':
      workcost = strtoul (arg, NULL, 0);
      break;

    case 'r':
      rounds = strtoul (arg, NULL, 0);
      break;

    case 's':
      starts = strtoul (arg, NULL, 0);
      break;

    case 'S':
      num = strtoul (arg, NULL, 0);
      if (num >= PTHREAD_STACK_MIN)
	stacksize = num;
      else
	printf ("minimum stack size is %d\n", PTHREAD_STACK_MIN);
      break;

    case 'g':
      snum = strtol (arg, NULL, 0);
      if (snum < 0)
	printf ("invalid guard size %s\n", arg);
      else
	guardsize = snum;
      break;

    case 'p':
      progress = true;
      break;

    case 'T':
      timing = true;
      break;

    case OPT_TO_THREAD:
      to_thread = true;
      break;

    case OPT_TO_PROCESS:
      to_thread = false;
      break;

    default:
      return ARGP_ERR_UNKNOWN;
    }

  return 0;
}


static hp_timing_t
get_clockfreq (void)
{
  /* We read the information from the /proc filesystem.  It contains at
     least one line like
	cpu MHz         : 497.840237
     or also
	cpu MHz         : 497.841
     We search for this line and convert the number in an integer.  */
  static hp_timing_t result;
  int fd;

  /* If this function was called before, we know the result.  */
  if (result != 0)
    return result;

  fd = open ("/proc/cpuinfo", O_RDONLY);
  if (__builtin_expect (fd != -1, 1))
    {
      /* XXX AFAIK the /proc filesystem can generate "files" only up
         to a size of 4096 bytes.  */
      char buf[4096];
      ssize_t n;

      n = read (fd, buf, sizeof buf);
      if (__builtin_expect (n, 1) > 0)
	{
	  char *mhz = memmem (buf, n, "cpu MHz", 7);

	  if (__builtin_expect (mhz != NULL, 1))
	    {
	      char *endp = buf + n;
	      int seen_decpoint = 0;
	      int ndigits = 0;

	      /* Search for the beginning of the string.  */
	      while (mhz < endp && (*mhz < '0' || *mhz > '9') && *mhz != '\n')
		++mhz;

	      while (mhz < endp && *mhz != '\n')
		{
		  if (*mhz >= '0' && *mhz <= '9')
		    {
		      result *= 10;
		      result += *mhz - '0';
		      if (seen_decpoint)
			++ndigits;
		    }
		  else if (*mhz == '.')
		    seen_decpoint = 1;

		  ++mhz;
		}

	      /* Compensate for missing digits at the end.  */
	      while (ndigits++ < 6)
		result *= 10;
	    }
	}

      close (fd);
    }

  return result;
}


int
clock_getcpuclockid (pid_t pid, clockid_t *clock_id)
{
  /* We don't allow any process ID but our own.  */
  if (pid != 0 && pid != getpid ())
    return EPERM;

#ifdef CLOCK_PROCESS_CPUTIME_ID
  /* Store the number.  */
  *clock_id = CLOCK_PROCESS_CPUTIME_ID;

  return 0;
#else
  /* We don't have a timer for that.  */
  return ENOENT;
#endif
}


#define HP_TIMING_NOW(Var)	__asm__ __volatile__ ("rdtsc" : "=A" (Var))

/* Get current value of CLOCK and store it in TP.  */
int
clock_gettime (clockid_t clock_id, struct timespec *tp)
{
  int retval = -1;

  switch (clock_id)
    {
    case CLOCK_PROCESS_CPUTIME_ID:
      {

	static hp_timing_t freq;
	hp_timing_t tsc;

	/* Get the current counter.  */
	HP_TIMING_NOW (tsc);

	if (freq == 0)
	  {
	    freq = get_clockfreq ();
	    if (freq == 0)
	      return EINVAL;
	  }

	/* Compute the seconds.  */
	tp->tv_sec = tsc / freq;

	/* And the nanoseconds.  This computation should be stable until
	   we get machines with about 16GHz frequency.  */
	tp->tv_nsec = ((tsc % freq) * UINT64_C (1000000000)) / freq;

	retval = 0;
      }
    break;

    default:
      errno = EINVAL;
      break;
    }

  return retval;
}

