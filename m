Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135744AbRDSWr6>; Thu, 19 Apr 2001 18:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135752AbRDSWrt>; Thu, 19 Apr 2001 18:47:49 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:16275 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S135746AbRDSWri>;
	Thu, 19 Apr 2001 18:47:38 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104191433001.1334-100000@penguin.transmeta.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 19 Apr 2001 15:46:36 -0700
In-Reply-To: Linus Torvalds's message of "Thu, 19 Apr 2001 14:41:15 -0700 (PDT)"
Message-ID: <m34rvkzewj.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> I'm not interested in re-creating the idiocies of Sys IPC.

I'm not talking about sysv semaphores (couldn't care less).  And you
haven't read any of the mails with examples I sent.

If the new interface can be useful for anything it must allow to
implement process-shared POSIX mutexes.  The user-level representation
of these mutexes are simple variables which in the case of
inter-process mutexes are placed in shared memory.  These variables
must be usable with the normal pthread_mutex_lock() functions and
perform whatever is needed.

Whether the pthread_mutex_init() function for shared mutexes is doing
a lot more work and allocates even more memory, I don't care.  The
standard certainly permits this and every pthread_mutex_init() must
have a pthread_mutex_destroy() which allows allocating and freeing
resources (no file descriptor, though).  So, yes, your FS_create
syscall can allocate something.

But the question is what handle to put in the pthread_mutex_t variable
so the different processes can use the mutex.  It cannot be a file
descriptor since it's not shared between processes.  It cannot be a
pointer to some other place in the virtual memory since the place
pointed to might not be (and probably isn't if FS_create is allocating
something in the process setting up the mutex).  You could put some
magic cookie in the pthread_mutex_t object the kernel can then use.


So, instead of repeating over and over again the same old story, fill
in the gaps here:


  int
  pthread_mutex_init (pthread_mutex_t *mutex,
                      const pthread_mutexattr_t *mutex_attr)
  {
    if (mutex_attr != NULL && mutex_attr->__pshared != 0)
      {
        ... FILL IN HERE ...
      }
    else
      ...intra-process mutex, uninteresting here...
  }

  int
  pthread_mutex_lock (pthread_mutex_t *mutex)
  {
    if (mutex_attr != NULL && mutex_attr->__pshared != 0)
      {
        ... FILL IN HERE ...
      }
    else
      ...intra-process mutex, uninteresting here...
  }

  int
  pthread_mutex_destroy (pthread_mutex_t *mutex)
  {
    if (mutex_attr != NULL && mutex_attr->__pshared != 0)
      {
        ... FILL IN HERE ...
      }
    else
      ...intra-process mutex, uninteresting here...
  }


These functions must work with something like this:

~~~~~~~~~~~~~~~~~~~~~ cons.c ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

int
main (int argc, char *argv[])
{
  char tmpl[] = "/tmp/fooXXXXXX";
  int fd = mkstemp (tmpl);
  pthread_mutexattr_t attr;
  pthread_mutex_t *m1;
  pthread_mutex_t *m2;
  void *addr;
  volatile int *i;

  pthread_mutexattr_init (&attr);
  pthread_mutexattr_setpshared (&attr, PTHREAD_PROCESS_SHARED);

  ftruncate (fd, 2 * sizeof (*m1) + sizeof (int));
  addr = mmap (NULL, sizeof (*m1), PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
  m1 = addr;
  m2 = m1 + 1;
  i = (int *) (m2 + 1);
  *i = 0;

  pthread_mutex_init (m1, &attr);
  pthread_mutex_lock (m1);

  pthread_mutex_init (m2, &attr);
  pthread_mutex_lock (m2);

  if (fork () == 0)
    {
      char buf[10];
      snprintf (buf, sizeof buf, "%d", fd);
      execl ("./prod", "prod", buf, NULL);
    }

  while (1)
    {
      pthread_mutex_lock (m1);
      printf ("*i = %d\n", *i);
      pthread_mutex_unlock (m2);
    }

  return 0;
}
~~~~~~~~~~~~~~~~~~~~~~prod.c ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

int
main (int argc, char *argv[])
{
  int fd = atoi (argv[1]);
  void *addr;
  pthread_mutex_t *m1;
  pthread_mutex_t *m2;
  volatile int *i;

  addr = mmap (NULL, sizeof (*m1), PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
  m1 = addr;
  m2 = m1 + 1;
  i = (int *) (m2 + 1);

  while (1)
    {
      ++*i;
      pthread_mutex_unlock (m1);
      pthread_mutex_lock (m2);
    }

  return 0;
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------

