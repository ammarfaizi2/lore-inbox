Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVDOVy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVDOVy7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 17:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVDOVy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 17:54:59 -0400
Received: from rtc10-252.rentec.com ([216.223.240.9]:60867 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S261983AbVDOVyl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 17:54:41 -0400
X-Rentec: external
From: Wolfgang Wander <wwc@rentec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16992.14366.232980.673857@gargle.gargle.HOWL>
Date: Fri, 15 Apr 2005 17:54:38 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Leaks in mmap address space: 2.6.11.4 
In-Reply-To: <200504151646.j3FGkLQ00256@troll.rentec.com>
References: <200504151646.j3FGkLQ00256@troll.rentec.com>
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
X-Logged: Logged by unicorn.rentec.com as j3FLsdWZ023155 at Fri Apr 15 17:54:40 2005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another program that illustrates the problem which this time
in C and without using glibc allocation schemes.

----------------------------------------------------------------------
/* run in 32 bit mode on 64Bit kernel, >4GB of RAM is helpful */

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>

#define bsz 600         /* number of mmaps to keep */
#define large 9500000   /* some odd large number */
#define success 1000000 /* number of iterations before we believe we are ok*/

                        /* program fails here on 2.6.11.4 kernel after 52K iterations 
                           with a fragmented /proc/self/mmap, 2.4 kernels behave fine */
void
aLLocator()
{

  char* bvec[bsz];
  unsigned int i;
  memset( bvec,0,sizeof(bvec));
	 
  for(  i = 0; i < success ; ++i ) {
    unsigned oidx;
    unsigned kidx;
    int len;
    kidx = i % bsz;
    oidx = (i+bsz/10) % bsz;
    len = (oidx & 7) ? ((oidx&7)* 1048576) : large;
    if( bvec[oidx] ) { munmap( bvec[oidx], len ); bvec[oidx] = 0; }
    len = (kidx & 7) ? ((kidx&7)* 1048576) : large;
    bvec[kidx] = (char*)(mmap(0, len, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0));
    if( bvec[kidx] == (char*)(-1) ) {
      printf("Failed after %d rounds\n", i);
      break;
    }
  }
}

int main() {
  FILE *f;
  int c;

  aLLocator();

  f = fopen( "/proc/self/maps", "r" );
  while( (c = fgetc(f)) != EOF )
    putchar(c);
  fclose(f);
  
  return 0;
}
----------------------------------------------------------------------

Wolfgang Wander writes:
 > Hi,
 > 
 >   we are running some pretty large applications in 32bit mode on 64bit
 >   AMD kernels (8GB Ram, Dual AMD64 CPUs, SMP).  Kernel is 2.6.11.4 or
 >   2.4.21.
 > 
 >   Some of these applications run consistently out of memory but only
 >   on 2.6 machines.  In fact large memory allocations that libc answers
 >   with private mmaps seem to contribute to the problem: 2.4 kernels
 >   are able to combine these mmaps to large chunks whereas 2.6
 >   generates a rather fragmented /proc/self/maps table.
 > 
 >   The following C++ program reproduces the error (compiled statically
 >   on a 32bit machine to get exactly the same executable for 2.4 and
 >   2.6 environments):
