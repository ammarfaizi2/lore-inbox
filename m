Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTIAKJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 06:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbTIAKJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 06:09:26 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:46217 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262796AbTIAKIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 06:08:50 -0400
Date: Mon, 1 Sep 2003 11:08:07 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Kars de Jong <jongk@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030901100807.GB1903@mail.jlokier.co.uk>
References: <Pine.GSO.4.21.0309011027310.5048-100000@waterleaf.sonytel.be> <1062407310.13046.6.camel@laptop.locamation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062407310.13046.6.camel@laptop.locamation.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kars de Jong wrote:
> On Mon, 2003-09-01 at 10:34, Geert Uytterhoeven wrote:
> > BTW, probably you want us to run your test program on other m68k boxes? Mine
> > got a 68040, that leaves us with:
> >   - 68020+68551
> >   - 68060
> 
> I can run it on these boxes if no-one else has done it yet before I come
> home tonight. I'm sure there are more people with a 68060 out there, not
> too sure about the 68020+68851.

I would prefer that you run the attached program.  It fixes a bug in
the function which tests whether the problem is in the L1 cache or
store buffer.  The bug probably didn't affect the test, but it might
have.

Ideally you could run the program Geert linked to as well?
Please remember to compile both with optimisation.

Thanks,
-- Jamie

/* This code maps shared memory to multiple addresses and tests it
   for cache coherency and performance.

   Copyright (C) 1999, 2001, 2002, 2003 Jamie Lokier

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or (at
   your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA */

#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/signal.h>
#include <sys/mman.h>
#include <sys/time.h>

#if HAVE_SYSV_SHM
#include <sys/ipc.h>
#include <sys/shm.h>
#endif

//#include "pagealias.h"

/* Helpers to temporarily block all signals.  These are used for when a
   race condition might leave a temporary file that should have been
   deleted -- we do our best to prevent this possibility. */

static void
block_signals (sigset_t * save_state)
{
  sigset_t all_signals;
  sigfillset (&all_signals);
  sigprocmask (SIG_BLOCK, &all_signals, save_state);
}

static void
unblock_signals (sigset_t * restore_state)
{
  sigprocmask (SIG_SETMASK, restore_state, (sigset_t *) 0);
}

/* Open a new shared memory file, either using the POSIX.4 `shm_open'
   function, or using a regular temporary file in /tmp.  Immediately
   after opening the file, it is unlinked from the global namespace
   using `shm_unlink' or `unlink'.

   On success, the value returned is a file descriptor.  Otherwise, -1
   is returned and `errno' is set.

   The descriptor can be closed using simply `close'. */

/* Note: `shm_open' requires link argument `-lposix4' on Suns.
   On GNU/Linux with Glibc, it requires `-lrt'.  Unfortunately, Glibc's
   -lrt insists on linking to pthreads, which we may not want to use
   because that enables thread locking overhead in other functions.  So
   we implement a direct method of opening shm on Linux. */

/* If this is changed, change the size of `buffer' below too. */
#if HAVE_SHM_OPEN
#define SHM_DIR_PREFIX "/"      /* `shm_open' arg needs "/" for portability. */
#elif defined (__linux__)
#include <sys/statfs.h>
#define SHM_DIR_PREFIX "/dev/shm/"
#else
#undef  SHM_DIR_PREFIX
#endif

static int
open_shared_memory_file (int use_tmp_file)
{
  char * ptr, buffer [19];
  int fd, i;
  unsigned long number;
  sigset_t save_signals;
  struct timeval tv;

#if !HAVE_SHM_OPEN && defined (__linux__)
  struct statfs sfs;
  if (!use_tmp_file && (statfs (SHM_DIR_PREFIX, &sfs) != 0
			|| sfs.f_type != 0x01021994 /* SHMFS_SUPER_MAGIC */))
    {
      errno = ENOSYS;
      return -1;
    }
#endif

 loop:
  /* Print a randomised path name into `buffer'.  The string depends on
     the directory and whether we are using POSIX.4 shared memory or a
     regular temporary file.  RANDOM is a 5-digit, base-62
     representation of a pseudo-random number.  The string is used as a
     candidate in the search for an unused shared segment or file name. */
#ifdef SHM_DIR_PREFIX
  strcpy (buffer, use_tmp_file ? "/tmp/shm-" : SHM_DIR_PREFIX "shm-");
#else
  strcpy (buffer, "/tmp/shm-");
#endif
  ptr = buffer + strlen (buffer);
  gettimeofday (&tv, (struct timezone *) 0);
  number = (unsigned long) random ();
  number += (unsigned long) getpid ();
  number += (unsigned long) tv.tv_sec + (unsigned long) tv.tv_usec;
  for (i = 0; i < 5; i++)
    {
      /* Don't use character arithmetic, as not all systems are ASCII. */
      *ptr++ = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" [number % 62];
      number /= 62;
    }
  *ptr = '\0';

  /* Block signals between the open and unlink, to really minimise
     the chance of accidentally leaving an unwanted file around. */
  block_signals (&save_signals);
#if HAVE_SHM_OPEN
  if (!use_tmp_file)
    {
      fd = shm_open (buffer, O_RDWR | O_CREAT | O_EXCL, 0600);
      if (fd != -1)
	shm_unlink (buffer);
    }
  else
#endif /* HAVE_SHM_OPEN */
    {
      fd = open (buffer, O_RDWR | O_CREAT | O_EXCL, 0600);
      if (fd != -1)
	unlink (buffer);
    }
  unblock_signals (&save_signals);

  /* If we failed due to a name collision or a signal, try again. */
  if (fd == -1 && (errno == EEXIST || errno == EINTR || errno == EISDIR))
    goto loop;

  return fd;
}

/* Allocate a region of address space `size' bytes long, so that the
   region will not be allocated for any other purpose.  It is freed with
   `munmap'.

   Returns the mapped base address on success.  Otherwise, MAP_FAILED is
   returned and `errno' is set. */

static size_t system_page_size;

#if !defined (MAP_ANONYMOUS) && defined (MAP_ANON)
#define MAP_ANONYMOUS	MAP_ANON
#endif
#ifndef MAP_NORESERVE
#define MAP_NORESERVE	0
#endif
#ifndef MAP_FILE
#define MAP_FILE	0
#endif
#ifndef MAP_VARIABLE
#define MAP_VARIABLE	0
#endif
#ifndef MAP_FAILED
#define MAP_FAILED	((void *) -1)
#endif
#ifndef PROT_NONE
#define PROT_NONE	PROT_READ
#endif

static void *
map_address_space (void * optional_address, size_t size, int access)
{
  void * addr;
#ifdef MAP_ANONYMOUS
  addr = mmap (optional_address, size,
	       access ? (PROT_READ | PROT_WRITE) : PROT_NONE,
	       (MAP_PRIVATE | MAP_ANONYMOUS
		| (optional_address ? MAP_FIXED : MAP_VARIABLE)
		| (access ? 0 : MAP_NORESERVE)), -1, (off_t) 0);
#else  /* not defined MAP_ANONYMOUS */
  int save_errno, zero_fd = open ("/dev/zero", O_RDONLY);
  if (zero_fd == -1)
    return MAP_FAILED;
  addr = mmap (optional_address, size,
	       access ? (PROT_READ | PROT_WRITE) : PROT_NONE,
	       (MAP_PRIVATE | MAP_FILE
		| (optional_address ? MAP_FIXED : MAP_VARIABLE)
		| (access ? 0 : MAP_NORESERVE)), zero_fd, (off_t) 0);
  save_errno = errno;
  close (zero_fd);
  errno = save_errno;
#endif /* not defined MAP_ANONMOUS */
  return addr;
}

/* Set up a page alias mapping using mmap() on POSIX shared memory or on
   a temporary regular file.

   Returns the mapped base address on success.  Otherwise, 0 is returned
   and `errno' is set. */

static void *
page_alias_using_mmap (size_t size, size_t separation, int use_tmp_file)
{
  void * base_addr, * addr;
  int fd, i, save_errno;
  struct stat st;

  fd = open_shared_memory_file (use_tmp_file);
  if (fd == -1)
    goto fail;

  /* First, resize the shared memory file to the desired size. */
  if (ftruncate (fd, size) != 0 || fstat (fd, &st) != 0 || st.st_size != size)
    goto close_fail;

  /* Map an anonymous region `separation + size' bytes long.  This is how
     we allocate sufficient contiguous address space.  We over-map
     this with the aliased buffer. */
  if ((base_addr = map_address_space (0, separation + size, 0)) == MAP_FAILED)
    goto close_fail;

  /* Map the same shared memory repeatedly, at different addresses. */
  for (i = 0; i < 2; i++)
    {
      addr = mmap ((char *) base_addr + (i ? separation : 0), size,
		   PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FILE | MAP_FIXED,
		   fd, (off_t) 0);
      if (addr == MAP_FAILED)
	goto unmap_fail;
      if (addr != (char *) base_addr + (i ? separation : 0))
	{
	  /* `mmap' ignored MAP_FIXED!  Should never happen. */
	  munmap (addr, size);
	  save_errno = EINVAL;
	  goto unmap_fail_se;
	}
    }
  if (close (fd) != 0)
    goto unmap_fail;

  /* Success! */
  return base_addr;

  /* Failure. */
 unmap_fail:
  save_errno = errno;
 unmap_fail_se:
  munmap (base_addr, separation + size);
  errno = save_errno;
 close_fail:
  save_errno = errno;
  close (fd);
  errno = save_errno;
 fail:
  return 0;
}

/* Set up a page alias mapping using SYSV IPC shared memory.

   Returns the mapped base address on success.  Otherwise, 0 is returned
   and `errno' is set. */

#if HAVE_SYSV_SHM

static void *
page_alias_using_sysv_shm (size_t size, size_t separation)
{
  void * base_addr, * addr;
  sigset_t save_signals;
  int shmid, i, save_errno;

  /* Map an anonymous region `separation + size' bytes long.  This is how
     we allocate sufficient contiguous address space.  We over-map
     this with the aliased buffer. */
  if ((base_addr = map_address_space (0, separation + size, 0)) == MAP_FAILED)
    goto fail;

  /* Block signals between the shmget() and IPC_RMID, to minimise the chance
     of accidentally leaving an unwanted shared segment around. */
  block_signals (&save_signals);

  shmid = shmget (IPC_PRIVATE, size, IPC_CREAT | IPC_EXCL | 0600);
  if (shmid == -1)
    goto unmap_fail;

  /* Map the same shared memory repeatedly, at different addresses. */
  for (i = 0; i < 2; i++)
    {
      /* `shmat' is tried twice.  The fist time it can fail if the local
	 implementation of `shmat' refuses to map over a region mapped
	 with `mmap'.  In that case, we punch a hole using `munmap' and
	 do it again.

	 If the local `shmat' has this property, the `shmat' calls
	 to fixed addresses might collide with a concurrent thread
	 which is also doing mappings, and will fail.  At least it
	 is a safe failure.

	 On the other hand, if the local `shmat' can map over
	 already-mapped regions (in the same way that `mmap' does), it
	 is essential that we do actually use an already-mapped region,
	 so that collisions with a concurrent thread can't possibly
	 result in both of us grabbing the same address range with no
	 indication of error. */
      addr = shmat (shmid, (char *) base_addr + (i ? separation : 0), 0);
      if (addr == (void *) -1 && errno == EINVAL)
	{
	  munmap ((char *) base_addr + (i ? separation : 0), size);
	  addr = shmat (shmid, (char *) base_addr + (i ? separation : 0), 0);
	}

      /* Check for errors. */
      if (addr == (void *) -1)
	{
	  save_errno = errno;
	  if (i == 1)
	    shmdt (base_addr);
	  goto remove_shm_fail_se;
	}
      else if (addr != (char *) base_addr + (i ? separation : 0))
	{
	  /* `shmat' ignored the requested address! */
	  if (i == 1)
	    shmdt (base_addr);
	  save_errno = EINVAL;
	  goto remove_shm_fail_se;
	}
    }
		    
  if (shmctl (shmid, IPC_RMID, (struct shmid_ds *) 0) != 0)
    goto remove_shm_fail;
  unblock_signals (&save_signals);

  /* Success! */
  return base_addr;

  /* Failure. */
 remove_shm_fail:
  save_errno = errno;
 remove_shm_fail_se:
  while (--i >= 0)
    shmdt ((char *) base_addr + (i ? separation : 0));
  shmctl (shmid, IPC_RMID, (struct shmid_ds *) 0);
  errno = save_errno;
 unmap_fail:
  save_errno = errno;
  unblock_signals (&save_signals);
  munmap (base_addr, separation + size);
  errno = save_errno;
 fail:
  return 0;
}

#endif /* HAVE_SYSV_SHM */

/* Map a page-aliased ring buffer.  Shared memory of size `size' is
   mapped twice, with the difference between the two addresses being
   `separation', which must be at least `size'.  The total address range
   used is `separation + size' bytes long.

   On success, *METHOD is filled with a number which must be passed to
   `page_alias_unmap', and the mapped base address is returned.
   Otherwise, 0 is returned and `errno' is set. */

static void *
__page_alias_map (size_t size, size_t separation, int * method)
{
  void * addr;
  if (((size | separation) & (system_page_size - 1)) != 0 || size > separation)
    {
      errno = -EINVAL;
      return 0;
    }

  /* Try these strategies in turn: POSIX shm_open(), SYSV IPC, regular file. */
#ifdef SHM_DIR_PREFIX
  *method = 0;
  if ((addr = page_alias_using_mmap (size, separation, 0)) != 0)
    return addr;
#endif
#if HAVE_SYSV_SHM
  *method = 1;
  if ((addr = page_alias_using_sysv_shm (size, separation)) != 0)
    return addr;
#endif
  *method = 2;
  return page_alias_using_mmap (size, separation, 1);
}

/* Unmap a page-aliased ring buffer previously allocated by
   `page_alias_map'.  `address' is the base address, and `size' and
   `separation' are the arguments previously passed to
   `__page_alias_map'.  `method' is the value previously stored in *METHOD.

   Returns 0 on success.  Otherwise, -1 is returned and `errno' is set. */

static int
__page_alias_unmap (void * address, size_t size, size_t separation, int method)
{
#if HAVE_SYSV_SHM
  if (method == 1)
    {
      shmdt (address);
      shmdt (address + separation);
      if (separation > size)
	munmap (address + size, separation - size);
      return 0;
    }
#endif

  return munmap (address, separation + size);
}

/* Map a page-aliased ring buffer.  `size' is the size of the buffer to
   create; it will be mapped twice to cover a total address range
   `size * 2' bytes long.

   On success, *METHOD is filled with a number which must be passed to
   `page_alias_unmap', and the mapped base address is returned.
   Otherwise, 0 is returned and `errno' is set. */

void *
page_alias_map (size_t size, int * method)
{
  return __page_alias_map (size, size, method);
}

/* Unmap a page-aliased ring buffer previously allocated by
   `page_alias_map'.  `address' is the base address, and `size' is the
   size of the buffer (which is half of the total mapped address range).
   `method' is a value previously stored in *METHOD by `page_alias_map'.

   Returns 0 on success.  Otherwise, -1 is returned and `errno' is set. */

int
page_alias_unmap (void * address, size_t size, int method)
{
  return __page_alias_unmap (address, size, size, method);
}

/* Map some memory which is not aliased, for timing comparisons against
   aliased pages.  We use a combination of mappings similar to
   page_alias_*(), in case there are resource limitations which would
   prevent malloc() or a single mmap() working for the larger address
   range tests. */

static void *
page_no_alias (size_t size, size_t separation)
{
  void * base_addr, * addr;
  int i, save_errno;

  if ((base_addr = map_address_space (0, separation + size, 0)) == MAP_FAILED)
    goto fail;

  /* Map anonymous memory at the different addresses. */
  for (i = 0; i < 2; i++)
    {
      addr = map_address_space ((char *) base_addr + (i ? separation : 0),
				size, 1);
      if (addr == MAP_FAILED)
	goto unmap_fail;
      if (addr != (char *) base_addr + (i ? separation : 0))
	{
	  /* `mmap' ignored MAP_FIXED!  Should never happen. */
	  munmap (addr, size);
	  save_errno = EINVAL;
	  goto unmap_fail_se;
	}
    }

  /* Success! */
  return base_addr;

  /* Failure. */
 unmap_fail:
  save_errno = errno;
 unmap_fail_se:
  munmap (base_addr, separation + size);
  errno = save_errno;
 fail:
  return 0;
}

/* This should be a word size that the architecture can read and write
   fast in a single instruction.  In principle, C's `int' is the natural
   word size, but in practice it isn't on 64-bit machines. */

#define WORD long

/* These GCC-specific asm statements force values into registers, and
   also act as compiler memory barriers.  These are used to force a
   group of write/write/read instructions as close together as possible,
   to maximise the detection of store buffer conditions.  Despite being
   asm statements, these will work with any of GCC's target architectures,
   provided they have >= 4 registers. */

#if __GNUC__ >= 3
#define __noinline __attribute__ ((__noinline__))
#else
#define __noinline
#endif

#ifdef __GNUC__
#define force_into_register(var) \
  __asm__ ("" : "=r" (var) : "0" (var) : "memory")
#define force_into_registers(var1, var2, var3, var4) \
  __asm__ ("" : "=r" (var1), "=r" (var2), "=r" (var3), "=r" (var4) \
	   : "0" (var1), "1" (var2), "2" (var3), "3" (var4) : "memory")
#else
#define force_into_register(var) do {} while (0)
#define force_into_registers(var1, var2, var3, var4) do {} while (0)
#endif

/* This function tries to test whether a CPU snoops its store buffer for
   reads within a few instructions, and ignores virtual to physical
   address translations when doing that.  In principle a CPU might do
   this even if it's L1 cache is physically tagged or indexed, although
   I have not seen such a system.  (A CPU which uses store buffer
   snooping and with an off-board MMU, which the CPU is unaware of,
   could have this property).

   It isn't possible to do this test perfectly; we do our best.  The
   `force_into_register' macros ensure that the write/write/read
   sequence is as compact as the compiler can make it. */

static WORD __noinline
test_store_buffer_snoop (volatile WORD * ptr1, volatile WORD * ptr2)
{
  register volatile WORD * __regptr1 = ptr1, * __regptr2 = ptr2;
  register WORD __reg1 = 1, __reg2 = 0;
  force_into_registers (__reg1, __reg2, __regptr1, __regptr2);
  *__regptr1 = __reg1;
  *__regptr2 = __reg2;
  __reg1 = *__regptr1;
  force_into_register (__reg1);
  return __reg1;
}

/* This function tests whether writes to one page are seen in another
   page at a different virtual address, and whether they are nearly as
   fast as normal writes.

   The accesses are timed by the caller of this function.
   Alternate writes go to alternate pages, so that if aliasing is
   implemented using page faults, it will clearly show up in the
   timings. */

static int __noinline
test_page_alias (volatile WORD * ptr1, volatile WORD * ptr2, int timing_loops)
{
  WORD fail = 0;
  while (--timing_loops >= 0)
    fail |= test_store_buffer_snoop (ptr1, ptr2);
  return fail != 0;
}

/* This function tests L1 cache coherency without checking for store
   buffer snoop coherency.  To do this, we add enough stores that the
   writes to *PTR1 are flushed (or drain due to the time delay) from the
   store buffer before we read from *PTR1.  The result of this function
   is not important: it is only used in a diagnostic message. */

static int __noinline
test_l1_only (volatile WORD * ptr1, volatile WORD * ptr2)
{
  int i, j;
  WORD fail = 0;
  for (i = 0; i < 10; i++)
    {
      *ptr1 = 1;
      /* This loop of volatile writes creates a short time delay.  The
	 delay gives the store to *PTR1 time to flush from the store
	 buffer and/or the many writes flush the store buffer.  The loop
	 writes to *PTR2 because if we pick another fixed address and
	 write to it, that would be testing 3 cache lines (PTR1, PTR2
	 and the fixed address) and the fixed address _might_ happen to
	 collide with PTR1 or PTR2 in the L1 cache.  If the L1 cache is
	 2-way set-associative, that would flush it every time, possibly
	 making it appear coherent when it isn't. */
      for (j = 0; j < 1000; j++)
	*ptr2 = 0;
      fail |= *ptr1;
    }
  return fail != 0;
}

/* Thoroughly test a pair of aliased pages with a fixed address
   separation, to see if they really behave like memory appearing at two
   locations, and efficiently.  We search through different values of
   `separation' searching for a suitable "cache colour" on this machine. */

static inline const char *
test_one_separation (size_t separation)
{
  void * buffers [2];
  long timings [3];
  int i, method, timing_loops = 64;

  /* We measure timings of 3 different tests, each 128 times to find the
     minimum.  0: Writes and reads to aliased pages.  1: Writes and
     reads to non-aliased pages, to compare with 1.  2: Doing nothing,
     to measure the time for `gettimeofday' itself.

     The measurements are done in a mixed up order.  If we did 64
     measurements of type 0, then 64 of type 1, then 64 of type 2, the
     results could be mislead due to synchronisation with other
     processes occuring on the machine. */

  /* A previously generated random shuffle of bit-pairs.  Each pair is a
     number from the set {0,1,2}.  Each number occurs exactly 128 times. */
  static const unsigned char pattern [96] =
    {
      0x64, 0x68, 0x9a, 0x86, 0x42, 0x10, 0x90, 0x81, 0x58, 0x91, 0x18, 0x56,
      0x12, 0x44, 0x64, 0x89, 0x29, 0xa9, 0x96, 0x05, 0x61, 0x80, 0x82, 0x49,
      0x02, 0x16, 0x89, 0x12, 0x9a, 0x45, 0x41, 0x12, 0xa9, 0xa6, 0x01, 0x99,
      0x88, 0x80, 0x94, 0x20, 0x86, 0x29, 0x29, 0x1a, 0xa5, 0x46, 0x66, 0x25,
      0x42, 0x20, 0xa4, 0x81, 0x20, 0x81, 0x50, 0x44, 0x01, 0x06, 0xa5, 0x19,
      0x4a, 0x56, 0x28, 0x89, 0x88, 0x14, 0x94, 0x88, 0x1a, 0xa4, 0x95, 0x15,
      0x82, 0x99, 0x84, 0x64, 0x52, 0x56, 0x69, 0x64, 0x00, 0x95, 0x9a, 0x89,
      0x48, 0x01, 0x58, 0x88, 0x60, 0xa6, 0x29, 0x06, 0x64, 0xa0, 0x56, 0x85,
    };

  buffers [0] = __page_alias_map (system_page_size, separation, &method);
  if (buffers [0] == 0)
    return "alias map failed";
  buffers [1] = page_no_alias (system_page_size, separation);
  if (buffers [1] == 0)
    {
      __page_alias_unmap (buffers [0], system_page_size, separation, method);
      return "non-alias map failed";
    }

 retry:
  timings [2] = timings [1] = timings [0] = LONG_MAX;
  for (i = 0; i < 384; i++)
    {
      struct timeval time_before, time_after;
      long time_delta;
      int fail = 0, which_test = (pattern [i >> 2] >> ((i & 3) << 1)) & 3;
      volatile WORD * ptr1 = (volatile WORD *) buffers [which_test];
      volatile WORD * ptr2 = (volatile WORD *) ((char *) ptr1 + separation);

      /* Test whether writes to one page appear immediately in the other,
	 and time how long the memory accesses take. */
      gettimeofday (&time_before, (struct timezone *) 0);
      if (which_test < 2)
	fail = test_page_alias (ptr1, ptr2, timing_loops);
      gettimeofday (&time_after, (struct timezone *) 0);
	      
      if (fail && which_test == 0)
	{
	  /* Test whether the failure is due to a store buffer bypass
	     which ignores virtual address translation. */
	  int l1_fail = test_l1_only (ptr1, ptr2);
	  __page_alias_unmap (buffers [0], system_page_size, separation,
			      method);
	  munmap (buffers [1], separation + system_page_size);
	  return l1_fail ? "cache not coherent" : "store buffer not coherent";
	}

      time_delta = ((time_after.tv_usec - time_before.tv_usec)
		    + 1000000 * (time_after.tv_sec - time_before.tv_sec));

      /* Find the smallest time taken for each test.  Ignore negative
	 glitches due to Linux' tendancy to jump the clock backwards. */
      if (time_delta >= 0 && time_delta < timings [which_test])
	timings [which_test] = time_delta;
    }

  /* Remove the cost of `gettimeofday()' itself from measurements. */
  timings [0] -= timings [2];
  timings [1] -= timings [2];

  /* Keep looping until at least one measurement becomes significant.  A
     very fast CPU will show measurements of zero microseconds for
     smaller values of `timing_loops'.  Also loop until the cost of
     `gettimeofday()' becomes insignificant.  When the program is run
     under `strace', the latter is a big and this is needed to stabilise
     the results. */
  if (timings [0] <= 10 * (1 + timings [2])
      && timings [1] <= 10 * (1 + timings [2]))
    {
      timing_loops <<= 1;
      goto retry;
    }

  __page_alias_unmap (buffers [0], system_page_size, separation, method);
  munmap (buffers [1], separation + system_page_size);

  printf ("(%d) [%ld,%ld,%ld] ",
	  timing_loops, timings [0], timings [1], timings [2]);

  /* Reject page aliasing if it is much slower than accessing a single,
     definitely cached page directly. */
  if (timings [0] > 2 * timings [1])
    return "too slow";

  /* Success!  Passed all tests for these parameters. */
  return 0;
}

size_t page_alias_smallest_size;

void
page_alias_init (void)
{
  size_t size;

#ifdef _SC_PAGESIZE
  system_page_size = sysconf (_SC_PAGESIZE);
#elif defined (_SC_PAGE_SIZE)
  system_page_size = sysconf (_SC_PAGE_SIZE);
#else
  system_page_size = getpagesize ();
#endif

  for (size = system_page_size; size <= 16 * 1024 * 1024; size *= 2)
    {
      const char * reason = test_one_separation (size);

      printf ("Test separation: %lu bytes: %s%s\n",
	      (unsigned long) size, reason ? "FAIL - " : "pass",
	      reason ? reason : "");

      /* This logic searches for the smallest _contiguous_ range
	 of page sizes for which `page_alias_test' passes. */
      if (reason == 0 && page_alias_smallest_size == 0)
	page_alias_smallest_size = size;
      else if (reason != 0 && page_alias_smallest_size != 0)
	{
	  /* Fail, indicating that page-aliasing is not reliable,
	     because there's a maximum size.  We don't support that as
	     it seems quite unlikely given our model of cache colouring. */
	  page_alias_smallest_size = 0;
	  break;
 	}
    }

  printf ("VM page alias coherency test: ");

  if (page_alias_smallest_size == 0)
    printf ("failed; will use copy buffers instead\n");
  else if (page_alias_smallest_size == system_page_size)
    printf ("all sizes passed\n");
  else
    printf ("minimum fast spacing: %lu (%lu page%s)\n",
	    (unsigned long) page_alias_smallest_size,
	    (unsigned long) (page_alias_smallest_size / system_page_size),
	    (page_alias_smallest_size == system_page_size) ? "" : "s");
}

//#ifdef TEST_PAGEALIAS
int
main ()
{
  page_alias_init ();
  return 0;
}
//#endif

