Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVBMDrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVBMDrB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 22:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVBMDrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 22:47:01 -0500
Received: from ns4.mountaincable.net ([24.215.0.14]:64230 "EHLO
	ns4.mountaincable.net") by vger.kernel.org with ESMTP
	id S261242AbVBMDq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 22:46:56 -0500
Subject: Strange /dev/mem behaviour on IA32, PPC64, (others?)
From: Ryan Lortie <desrt@desrt.ca>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-XIUubieHobpJpoYCesy2"
Date: Sat, 12 Feb 2005 22:46:54 -0500
Message-Id: <1108266414.8479.12.camel@moonpix.desrt.ca>
Mime-Version: 1.0
X-Mailer: Evolution 2.1.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XIUubieHobpJpoYCesy2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

There are a couple of problems that I have encountered with /dev/mem on
the 2.6.10 kernel.

The first problem is that lseek()/read() results in different data than
mmap() and reading from the mapped memory area.  I've written a small
program to demonstrate the problem.  I am fairly sure it is correct (a
few others haved looked over it).  The program produces unexpected
output when I run it on both IA32 and PPC64.  You need to have at least
1GB of RAM to run it, but it is easy to modify if you have less.

In short, lseek()/read() returns what I believe to be the correct
values.  Reading from the mmap() region gives the correct values for the
first few reads but after that it starts giving zeros.

In testing this program on IA32 I ran into an additional problem.  If
you lseek() to the (very suspicious) 896MB mark and read() then read
gives EFAULT (Bad address).

I have high memory support enabled and the 'free' command reports:

             total
Mem:       1036172

so seeking should be OK all the way up to 1GB.

Any information about these problems (including "you're wrong
because....") is appreciated.  I'm not on the list, so please Cc:
replies.

Cheers.

--=-XIUubieHobpJpoYCesy2
Content-Disposition: attachment; filename=fetch.c
Content-Type: text/x-csrc; name=fetch.c; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#include <sys/mman.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>

int main( void )
{
  char *ptr;
  int fd;
  long i;
  char z;

  fd = open( "/dev/mem", O_RDONLY, 0666 );

  if( fd < 0 )
  {
    perror( "open /dev/mem" );
    exit( 1 );
  }

  /* map in 1G worth of physical RAM */
  ptr = mmap( NULL, 0x40000000L, PROT_READ, MAP_SHARED, fd, 0 );

  if( ptr == (void *) -1 )
  {
    perror( "mmap" );
    exit( 1 );
  }

  /* print out memory at 8 meg intervals.  8M * 128 = 1024M */
  for( i = 0; i < 128; i++ )
  {
    /* -> for mmap */
    printf( "%02lx -> %x\n", i, ptr[8 * 1024 * 1024 * i] );

    /* => for lseek/read */
    if( lseek( fd, 8 * 1024 * 1024 * i, SEEK_SET ) < 0 )
    {
      perror( "lseek" );
      exit( 1 );
    }

    if( read( fd, &z, 1 ) != 1 )
    {
      perror( "read" );
      exit( 1 );
    }

    printf( "%02lx => %x\n", i, z );
  }

  return 0;
}


--=-XIUubieHobpJpoYCesy2--

