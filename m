Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWGSCZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWGSCZX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 22:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWGSCZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 22:25:23 -0400
Received: from intrepid.intrepid.com ([192.195.190.1]:54986 "EHLO
	intrepid.intrepid.com") by vger.kernel.org with ESMTP
	id S932455AbWGSCZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 22:25:23 -0400
Message-Id: <200607190225.k6J2PGAq004975@intrepid.intrepid.com>
From: "Gary Funck" <gary@intrepid.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, "'Ingo Molnar'" <mingo@elte.hu>
Subject: RE: 2.6.17-1.2145_FC5 mmap-related soft lockup
Date: Tue, 18 Jul 2006 19:25:16 -0700
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0000_01C6AA9F.E6EB4C60"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcaomSDGiNUi5XztQI6gx5hGWCoC/wCQKcSw
In-Reply-To: <20060715221942.9f1543ca.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C6AA9F.E6EB4C60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit


> 
> Are you able to confirm that setting CONFIG_DEBUG_SPINLOCK=n fixes it?
> 
> And are you able to get us a copy of that test app?

Yes, I just ran the test with 2.6.17.6.  With CONFIG_DEBUG_SPINLOCK=y
the test fails and the soft lockup situation often results.
However, when built with CONFIG_DEBUG_SPINLOCK=n, the test passes,
and runs rather quickly in comparison to when it fails.

I've attached a slightly updated version of the test case.
It is a little more carefully crafted and prints some
output so that you have some idea that it is working.

------=_NextPart_000_0000_01C6AA9F.E6EB4C60
Content-Type: application/octet-stream;
	name="mmap_soft_lockup_x86_64.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mmap_soft_lockup_x86_64.c"

#include <stddef.h>=0A=
#include <stdlib.h>=0A=
#include <stdio.h>=0A=
#include <string.h>=0A=
#include <unistd.h>=0A=
#include <errno.h>=0A=
#include <sys/types.h>=0A=
#include <sys/mman.h>=0A=
#include <sys/wait.h>=0A=
=0A=
#define MEG (1024*1024)=0A=
#define PER_PROCESS_ALLOC (256*MEG)=0A=
=0A=
#define NUM_SYNC_WORDS (256/32)=0A=
=0A=
typedef struct shared_data_s=0A=
{=0A=
  int sync[NUM_SYNC_WORDS];=0A=
  pid_t pid[256];=0A=
} shared_data_t;=0A=
typedef shared_data_t *shared_data_p;=0A=
=0A=
shared_data_p shared_data;=0A=
int num_cpus;=0A=
void *map;=0A=
int n;=0A=
=0A=
/* This test also works on x86, but only fails=0A=
   on x86_64.  */=0A=
#if __x86_64__=0A=
=0A=
#define LOCK_PREFIX "lock ; "=0A=
=0A=
int=0A=
atomic_cas (int *ptr, int old, int new)=0A=
{=0A=
  int prev;=0A=
  __asm__ __volatile__ (LOCK_PREFIX "cmpxchgl %1,%2":"=3Da" (prev):"q" =
(new),=0A=
			"m" (*ptr), "0" (old):"memory");=0A=
  return prev =3D=3D old;=0A=
}=0A=
#else=0A=
# error this test must be run on an x86_64 cpu=0A=
#endif=0A=
=0A=
int=0A=
get_bit (int *bits, int bitnum)=0A=
{=0A=
  int *word =3D bits + (bitnum / 32);=0A=
  int bit =3D (1 << (bitnum % 32));=0A=
  return (*word & bit) !=3D 0;=0A=
}=0A=
=0A=
void=0A=
atomic_set_bit (int *bits, int bitnum)=0A=
{=0A=
  int *word =3D bits + (bitnum / 32);=0A=
  int bit =3D (1 << (bitnum % 32));=0A=
  int old_val, new_val;=0A=
  do=0A=
    {=0A=
      old_val =3D *word;=0A=
      new_val =3D old_val | bit;=0A=
    }=0A=
  while (!atomic_cas (word, old_val, new_val));=0A=
}=0A=
=0A=
void=0A=
barrier ()=0A=
{=0A=
  int *sync =3D shared_data->sync;=0A=
  atomic_set_bit (sync, n);	/* set my bit */=0A=
  if (n =3D=3D 0)=0A=
    {=0A=
      int i;=0A=
      /* spin until all bits are set */=0A=
      for (i =3D 0; i < num_cpus; ++i)=0A=
	while (!get_bit (sync, i)) /* loop */ ;=0A=
      /* all set, open the barrier. */=0A=
      for (i =3D 0; i < (num_cpus + 31) / 32; ++i)=0A=
	sync[i] =3D 0;=0A=
    }=0A=
  else=0A=
    while (get_bit (sync, n)) /* spin on my bit set */ ;=0A=
}=0A=
=0A=
void=0A=
run_test ()=0A=
{=0A=
  int nxt =3D (n + 1) % num_cpus;=0A=
  char *s;=0A=
  char *cp;=0A=
  int i;=0A=
  int c;=0A=
  char *buf;=0A=
  buf =3D malloc (PER_PROCESS_ALLOC);=0A=
  if (!buf)=0A=
    {=0A=
      perror ("malloc");=0A=
      abort ();=0A=
    }=0A=
  c =3D 'A' + n % 26;=0A=
  memset (buf, c, PER_PROCESS_ALLOC);=0A=
  barrier ();=0A=
  /* write the data for the next process */=0A=
  s =3D map + nxt * PER_PROCESS_ALLOC;=0A=
  c =3D 'A' + nxt % 26;=0A=
  memset (s, c, PER_PROCESS_ALLOC);=0A=
  barrier ();=0A=
  /* read our data */=0A=
  s =3D map + n * PER_PROCESS_ALLOC;=0A=
  if (memcmp (s, buf, PER_PROCESS_ALLOC))=0A=
    {=0A=
      fprintf (stderr, "%d: data mismatch\n", n);=0A=
      abort ();=0A=
    }=0A=
  barrier ();=0A=
  exit (0);=0A=
}=0A=
=0A=
int=0A=
main (int argc, char *argv[])=0A=
{=0A=
  char *pgm =3D argv[0];=0A=
  int mask;=0A=
  int fd;=0A=
  int pid;=0A=
  off_t alloc_size;=0A=
  int wait_status;=0A=
  num_cpus =3D (int) sysconf (_SC_NPROCESSORS_ONLN);=0A=
  if (num_cpus <=3D 0)=0A=
    {=0A=
      perror ("sysconf");=0A=
      abort ();=0A=
    }=0A=
  printf ("%d cpus\n", num_cpus);=0A=
  printf ("mapping %ld megs per process\n",=0A=
	  (long int) PER_PROCESS_ALLOC / MEG);=0A=
  shared_data =3D=0A=
    mmap ((void *) 0, 64 * 1024, PROT_READ | PROT_WRITE,=0A=
	  MAP_SHARED | MAP_ANONYMOUS, 0, (off_t) 0);=0A=
  if (shared_data =3D=3D MAP_FAILED)=0A=
    {=0A=
      perror ("mmap");=0A=
      abort ();=0A=
    }=0A=
  memset (shared_data, '\0', sizeof (shared_data_t));=0A=
  alloc_size =3D num_cpus * PER_PROCESS_ALLOC;=0A=
  map =3D mmap ((void *) 0, alloc_size, PROT_READ | PROT_WRITE,=0A=
	      MAP_SHARED | MAP_ANONYMOUS, 0, (off_t) 0);=0A=
  if (map =3D=3D MAP_FAILED)=0A=
    {=0A=
      perror ("mmap");=0A=
      abort ();=0A=
    }=0A=
  for (n =3D 0; n < num_cpus; ++n)=0A=
    {=0A=
      pid =3D fork ();=0A=
      if (pid =3D=3D 0)=0A=
	run_test (n);		/* no return */=0A=
      else if (pid < 0)=0A=
	{=0A=
	  perror ("fork");=0A=
	  abort ();=0A=
	}=0A=
      shared_data->pid[n] =3D pid;=0A=
    }=0A=
  printf ("processes created, wait for completion\n");=0A=
  while ((pid =3D wait (&wait_status)) > 0)=0A=
    {=0A=
      int np;=0A=
      for (np =3D 0;=0A=
	   np < num_cpus && shared_data->pid[np] !=3D pid; ++np) /* loop */ ;=0A=
      if (WIFEXITED (wait_status))=0A=
	{=0A=
	  int child_exit =3D WEXITSTATUS (wait_status);=0A=
	  if (child_exit)=0A=
	    {=0A=
	      fprintf (stderr, "%d: non-zero child exit status\n", np);=0A=
	      abort ();=0A=
	    }=0A=
	}=0A=
      else if (WIFSIGNALED (wait_status))=0A=
	{=0A=
	  int child_sig =3D WTERMSIG (wait_status);=0A=
	  fprintf (stderr, "%d child caught signal: %d\n", np, child_sig);=0A=
	  abort ();=0A=
	}=0A=
      printf ("process %d completed successfully\n", np);=0A=
    }=0A=
  exit (0);=0A=
}=0A=

------=_NextPart_000_0000_01C6AA9F.E6EB4C60--

