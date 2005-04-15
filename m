Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVDOQqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVDOQqg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVDOQqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:46:36 -0400
Received: from rtc10-252.rentec.com ([216.223.240.9]:2957 "EHLO
	unicorn.rentec.com") by vger.kernel.org with ESMTP id S261862AbVDOQqZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:46:25 -0400
X-Rentec: external
Date: Fri, 15 Apr 2005 12:46:21 -0400 (EDT)
Message-Id: <200504151646.j3FGkLQ00256@troll.rentec.com>
From: Wolfgang Wander <wwc@rentec.com>
To: linux-kernel@vger.kernel.org
Subject: Leaks in mmap address space: 2.6.11.4 
X-Logged: Logged by unicorn.rentec.com as j3FGkMH1002791 at Fri Apr 15 12:46:23 2005
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  we are running some pretty large applications in 32bit mode on 64bit
  AMD kernels (8GB Ram, Dual AMD64 CPUs, SMP).  Kernel is 2.6.11.4 or
  2.4.21.

  Some of these applications run consistently out of memory but only
  on 2.6 machines.  In fact large memory allocations that libc answers
  with private mmaps seem to contribute to the problem: 2.4 kernels
  are able to combine these mmaps to large chunks whereas 2.6
  generates a rather fragmented /proc/self/maps table.

  The following C++ program reproduces the error (compiled statically
  on a 32bit machine to get exactly the same executable for 2.4 and
  2.6 environments):

----------------------------------------------------------------------
#include <iostream>
#include <vector>
#include <unistd.h>
#include <fstream>
#include <string>
#include <iterator>

void
aLlocator()
{
  const int bsz = 160;
  const int ssz = 1000000;
  std::vector<char*> svec(ssz);
  std::vector<char*> bvec(bsz);
  std::fill( bvec.begin(), bvec.end(), (char*)0);
  std::fill( svec.begin(), svec.end(), (char*)0);
  for( unsigned i = 0, j = 0; i < 1843750 /* for our setup we crash  in 2.6
                                             if we iterate one more, YMMV */
       ; ++i ) {
    unsigned oidx;
    unsigned kidx;
    if( i % (ssz/bsz/2) == 0 ) {
      kidx = j % bsz;
      oidx = (j+bsz/10) % bsz;
      bvec[kidx] = new char[ 9500000 ]; // served via private mmap
      delete [] bvec[oidx];
      bvec[oidx] = (char*)0;
      ++j;
    }
    kidx = rand() % ssz;
    delete [] svec[kidx];
    svec[kidx] = new char[kidx%3500+1]; // served mostly via brk
  }
  std::ifstream ifs("/proc/self/maps");
  std::string line;
  while( std::getline(ifs, line))
    std::cout << line << std::endl;
}

int main() {
  aLlocator();
}

----------------------------------------------------------------------

The final output of this program results in a very large and fragmented
mapping table of /proc/self/maps on 2.6 and a fairly small one on 2.4:

2.4: 

08048000-080bd000 r-xp 00000000 00:82 16643931   /tmp/leak-me2
080bd000-080c9000 rwxp 00074000 00:82 16643931   /tmp/leak-me2
080c9000-55542000 rwxp 00000000 00:00 0
55555000-56227000 rwxp 00000000 00:00 0
56236000-58e77000 rwxp 00ce1000 00:00 0
58f87000-5b0b7000 rwxp 03a32000 00:00 0
5b9c7000-a54e7000 rwxp 06472000 00:00 0
a58f7000-a9457000 rwxp 503a2000 00:00 0
a9667000-b3077000 rwxp 54112000 00:00 0
ffffd000-ffffe000 rwxp 00000000 00:00 0

2.6

08048000-080bd000 r-xp 00000000 00:5a 16643931                           /tmp/leak-me2
080bd000-080c9000 rwxp 00074000 00:5a 16643931                           /tmp/leak-me2
080c9000-55542000 rwxp 080c9000 00:00 0 
55555000-55b26000 rwxp 55555000 00:00 0 
56236000-56338000 rwxp 56236000 00:00 0 
56b48000-56c48000 rwxp 56b48000 00:00 0 
57458000-57658000 rwxp 57458000 00:00 0 
57d68000-57e68000 rwxp 57d68000 00:00 0 
58678000-58778000 rwxp 58678000 00:00 0 

[ removed 150 lines ]

b0c38000-ff7e8000 rwxp b0c38000 00:00 0 
ffffc000-ffffe000 rwxp ffffc000 00:00 0 
ffffe000-fffff000 ---p 00000000 00:00 0 

  Any ideas?

     Thanks!
          Wolfgang
