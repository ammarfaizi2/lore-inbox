Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWGPGuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWGPGuX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 02:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWGPGuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 02:50:22 -0400
Received: from intrepid.intrepid.com ([192.195.190.1]:27587 "EHLO
	intrepid.intrepid.com") by vger.kernel.org with ESMTP
	id S964794AbWGPGuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 02:50:22 -0400
From: "Gary Funck" <gary@intrepid.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.17-1.2145_FC5 mmap-related soft lockup
Date: Sat, 15 Jul 2006 23:50:26 -0700
Message-ID: <JCEPIPKHCJGDMPOHDOIGKEKMDFAA.gary@intrepid.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000C_01C6A869.71EF52E0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <JCEPIPKHCJGDMPOHDOIGGEKJDFAA.gary@intrepid.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Spam-Score: -1.44 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000C_01C6A869.71EF52E0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



> From: Gary Funck
> Sent: Saturday, July 15, 2006 10:07 AM
>
> A test program which allocates about 256M of MAP_ANONYMOUS mmap memory,
> and then spawns 4 processess, where each process i writes to 1/4 of the
> mapped memory, and then reads the memory written by
> the process (i + 1)%4, triggers a soft lockup, when exiting.
> Hardware:
> dual core dual Opteron 275 (Tyan motherboard, 4G physical memory)
> has been rock solid reliable.
>
> BUG: soft lockup detected on CPU#3!

Follow up, the attached test program, when compiled on FC5 with the
2.6.17-1.2145 kernel will cause lost timer ticks, lost RS-232 interrupts,
and often will lead to the soft lockup situation shown below:

BUG: soft lockup detected on CPU#0!

Call Trace: <IRQ> <ffffffff802b2fb5>{softlockup_tick+219}
       <ffffffff8029708e>{update_process_times+66}
<ffffffff8027a3ed>{smp_local_timer_interrupt+35}
       <ffffffff8027aa95>{smp_apic_timer_interrupt+65}
<ffffffff80263acb>{apic_timer_interrupt+135} <EOI>
       <ffffffff8020e578>{__set_page_dirty_nobuffers+0}
<ffffffff8020a7ab>{release_pages+111}
       <ffffffff80267b76>{thread_return+0}
<ffffffff80267bd4>{thread_return+94}
       <ffffffff8020e578>{__set_page_dirty_nobuffers+0}
<ffffffff8020e578>{__set_page_dirty_nobuffers+0}
       <ffffffff8020e09e>{free_pages_and_swap_cache+115}
<ffffffff80207b62>{unmap_vmas+1145}
       <ffffffff8023c7d9>{exit_mmap+120} <ffffffff8023eda8>{mmput+44}
       <ffffffff80215ece>{do_exit+599}
<ffffffff8024cacd>{debug_mutex_init+0}
       <ffffffff80262f01>{tracesys+209}

After compiling the code, A continuous loop like the following, seems to
eventually lead to the soft lockup situation (FC5, x86_64) shown above:

while true; do
  a.out
done


------=_NextPart_000_000C_01C6A869.71EF52E0
Content-Type: application/octet-stream;
	name="mmap_soft_lockup_x86_64.c"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="mmap_soft_lockup_x86_64.c"

#include <stddef.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <sys/wait.h>

#define PER_PROCESS_ALLOC (256*1024*1024)

#define NUM_SYNC_WORDS (256/32)

typedef struct shared_data_s
  {
    int sync[NUM_SYNC_WORDS];
  } shared_data_t;
typedef shared_data_t *shared_data_p;

shared_data_p shared_data;
int num_cpus;
void *map;
int n;

#if __x86_64__
=20
#define LOCK_PREFIX "lock ; "
=20
int
atomic_cas (int *ptr, int old, int new)
{
  int prev;
  __asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
                       : "=3Da"(prev)
                       : "q"(new), "m"(*ptr), "0"(old)
                       : "memory");
  return prev =3D=3D old;
}
#else
# error this test must be run on an x86_64 cpu
#endif

int
get_bit (int *bits, int bitnum)
{
  int *word =3D bits + (bitnum / 32);
  int bit =3D (1 << (bitnum % 32));
  return (*word & bit) !=3D 0;
}

void
atomic_set_bit (int *bits, int bitnum)
{
  int *word =3D bits + (bitnum / 32);
  int bit =3D (1 << (bitnum % 32));
  int old_val, new_val;
  do
    {
      old_val =3D *word;
      new_val =3D old_val | bit;
    }
  while (!atomic_cas (word, old_val, new_val));
}

void
barrier ()
{
  int *sync =3D shared_data->sync;
  atomic_set_bit (sync, n);  /* set my bit */
  if (n =3D=3D 0)
    {
      int i, cnt;
      /* spin until all bits are set */
      for (cnt =3D 0; cnt !=3D num_cpus;)
        for (i =3D 0, cnt =3D 0; i < num_cpus; ++i)
	  if (get_bit(sync, i)) ++cnt;
      /* all set, open the barrier. */
      for (i =3D 0; i < (num_cpus + 31)/32; ++i) sync[i] =3D 0;
    }
  else
    while (get_bit (sync, n)) /* spin on my bit set */;
}

void
run_test ()
{
  int nxt =3D (n + 1) % num_cpus;
  char *s;
  char *cp;
  int i;
  int c;
  char *buf;
  barrier ();
  /* write the data for the next process */
  s =3D map + nxt * PER_PROCESS_ALLOC;
  c =3D 'A' + nxt % 26;
  memset (s, c, PER_PROCESS_ALLOC-1);
  s[PER_PROCESS_ALLOC-1] =3D '\0';
  barrier ();
  /* read our data */
  s =3D map + n * PER_PROCESS_ALLOC;
  c =3D 'A' + n % 26;
  buf =3D malloc (PER_PROCESS_ALLOC);
  if (!buf)
    { perror ("malloc"); abort (); }
  memset (buf, c, PER_PROCESS_ALLOC-1);
  buf[PER_PROCESS_ALLOC-1] =3D '\0';
  if (strcmp(s, buf))
    { fprintf (stderr, "%d: data mismatch\n", n); abort (); }
  barrier ();
  exit (0);
}

int
main (int argc, char *argv[])
{
  char *pgm =3D argv[0];
  int mask;
  int fd;
  int pid;
  off_t alloc_size;
  int wait_status;
  num_cpus =3D (int)sysconf(_SC_NPROCESSORS_ONLN);
  if (num_cpus <=3D 0)
    { perror ("sysconf"); abort (); }
  for (mask =3D 1; (num_cpus & ~mask); mask <<=3D 1)
    num_cpus =3D (num_cpus & ~mask);
  shared_data =3D mmap((void *)0, 64*1024*1024, PROT_READ|PROT_WRITE,
	             MAP_SHARED | MAP_ANONYMOUS, 0, (off_t)0);
  if (shared_data =3D=3D MAP_FAILED)
    { perror ("mmap"); abort (); }
  memset (shared_data, '\0', sizeof (shared_data_t));
  alloc_size =3D num_cpus * PER_PROCESS_ALLOC;
  map =3D mmap((void *)0, alloc_size, PROT_READ|PROT_WRITE,
	     MAP_SHARED | MAP_ANONYMOUS, 0, (off_t)0);
  if (map =3D=3D MAP_FAILED)
    { perror ("mmap"); abort (); }
  for (n =3D 0; n < num_cpus; ++n)
    {
      pid =3D fork ();
      if (pid =3D=3D 0)
        run_test (n);  /* no return */
      else if (pid < 0)
        { perror ("fork"); abort (); }
    }
  while ((pid =3D wait (&wait_status)) > 0)
    {
      if (WIFEXITED (wait_status))
	{
	  int child_exit =3D WEXITSTATUS (wait_status);
	  if (child_exit)
	    { fprintf (stderr, "non-zero child exit status\n"); abort ();}
	}
      else if (WIFSIGNALED (wait_status))
	{
	  int child_sig =3D WTERMSIG (wait_status);
	  fprintf (stderr, "child caught signal\n");=20
	  abort ();
	}
    }
  exit (0);
}

------=_NextPart_000_000C_01C6A869.71EF52E0--

