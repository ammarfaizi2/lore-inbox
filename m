Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264401AbTK0AiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 19:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbTK0AiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 19:38:21 -0500
Received: from mail19b.dulles19-verio.com ([198.170.241.3]:47890 "HELO
	mail19b.dulles19-verio.com") by vger.kernel.org with SMTP
	id S264401AbTK0AiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 19:38:17 -0500
From: Lothar Werzinger <lothar@xcerla.com>
Organization: Xcerla Corporation
To: linux-kernel@vger.kernel.org
Subject: mmap and MAP_FIXED question
Date: Wed, 26 Nov 2003 16:38:15 -0800
User-Agent: KMail/1.5.9.1i
Cc: Krishnakumar B <kitty@dre.vanderbilt.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3dUx/L8u5WyM+5t"
Message-Id: <200311261638.15343.lothar@xcerla.com>
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_3dUx/L8u5WyM+5t
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I currently do not have subscribed to LKML, so please CC to my address when 
answering. I will browse the archive, but on a not so regular basis.

I came across a strange behavior of mmap using the ACE library. After some 
discussion on the ace-users mailing list 
(http://groups.yahoo.com/group/ace-users/message/36897) I'd like to post this 
question here in the hope that anyone knows more about this.

The problem basically is that a program doing a mmap call with the MAP_FIXED 
flag set crashes just by unmapping and mapping of an extended (larger) memory 
area. Note it crashes although it never touches (writes) to the memory it 
maps.

Attached is a C file that if compiled and run on a 2.4.x Kernel crashes with a 
segmentation fault.  If called with any argument it uses a (delta) value to 
increase the map size, so it crashes after 21 iterations on my computer.
My kernel version is:
$ cat /proc/version
Linux version 2.4.20-18.9.acpi.4 (dsanta@ltspc67.epfl.ch) (gcc version 3.2.2 
20030222 (Red Hat Linux 3.2.2-5)) #1 Wed Jul 2 14:54:57 CEST 2003

If anyone knows why the program crashes instead of just failing with some 
error code, please let me know.

The attached program is a slightly modified version I got from an ACE 
developer
> Here's my test program. It fails under all machines that I have tested.
> Maybe you can post it to Linux Kernel and ask what is broken and tell me if
> you get any answer. 

Lothar
-- 
Lothar Werzinger Dipl.-Ing. Univ.
framework & platform architect
Xcerla Corporation
275 Tennant Avenue, Suite 202
Morgan Hill, Ca 95037
email: lothar@xcerla.com
phone: +1-408-776-9018
--Boundary-00=_3dUx/L8u5WyM+5t
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="mmaptest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mmaptest.c"

#include <sys/mman.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

int main(int argc, char ** argv)
{
  int fd = 0;
  int pagesize = 0;
  unsigned int delta = 0;
  int retval = 0;
  size_t count = 0;
  size_t size = 0;
  char* addr = 0;

  pagesize = getpagesize();

  srand(time(0));
  delta = rand() % pagesize;
  if (argc > 1)
    delta = 0xf96;
  
  fprintf (stderr, "pagesize %d\n", pagesize);
  fprintf (stderr, "using delta %06d, %06x\n", delta, delta);


  fd = open ("/tmp/MemMapTest1.data", O_RDWR|O_CREAT);
  if (fd == -1)
    {
      fprintf (stderr, "Unable to create file: %s\n", strerror (errno));
      exit (1);
    }
  if (unlink ("/tmp/MemMapTest1.data") == -1)
    {
      fprintf (stderr, "Unable to unlink file: %s\n", strerror (errno));
      exit (1);
    }

  retval = ftruncate (fd, delta);
  if (retval == -1)
    {
      fprintf (stderr, "Unable to resize file: %s\n", strerror (errno));
      exit (1);
    }

  size = delta;
  addr = (char*) mmap (0, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
  if (addr == MAP_FAILED)
    {
      fprintf (stderr, "Unable to map file: %s\n", strerror (errno));
      exit (1);
    }

  fprintf (stderr, "%03d address: %p, size: %06d, %06x, new size: %06d, %06x\n",
           count, addr, size, size, size + delta, size + delta);
  
  while (count < 500)
    {
      if (munmap(addr, size) == -1)
        {
          fprintf (stderr, "Unable to unmap file: %s\n", strerror (errno));
          exit (1);
        }

      size += delta;
      retval = ftruncate (fd, size);
      if (retval == -1)
        {
          fprintf (stderr, "Unable to resize file: %s\n", strerror (errno));
          exit (1);
        }
      addr = (char*) mmap (addr, size, PROT_READ|PROT_WRITE,
                           MAP_SHARED|MAP_FIXED, fd, 0);
      if (addr == MAP_FAILED)
        {
          fprintf (stderr, "Unable to map file: %s\n", strerror (errno));
          exit (1);
        }

      ++count;
      fprintf (stderr, "%03d address: %p, size: %06d, %06x, new size: %06d, %06x\n",
               count, addr, size, size, size + delta, size + delta);
    }
  fprintf (stderr, "%03d exited loop\n", count);
  return 0;
}

--Boundary-00=_3dUx/L8u5WyM+5t--

