Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbTAEEMk>; Sat, 4 Jan 2003 23:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTAEEMk>; Sat, 4 Jan 2003 23:12:40 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:23559 "EHLO
	boo-mda02.boo.net") by vger.kernel.org with ESMTP
	id <S262602AbTAEEMi> convert rfc822-to-8bit; Sat, 4 Jan 2003 23:12:38 -0500
Message-Id: <3.0.6.32.20030104233111.007ed3c0@boo.net>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Sat, 04 Jan 2003 23:31:11 -0500
To: linux-mm@kvack.org
From: Jason Papadopoulos <jasonp@boo.net>
Subject: [PATCH] rewritten page coloring for 2.4.20 kernel
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello. After a year in stasis, I've completely rebuilt my kernel
patch that implements page coloring. Improvements include:

- Page coloring is now hardwired into the kernel. The hash
  queues now use bootmem, and page coloring is always on. The
  patch still creates /proc/page_color for statistics, but that
  will go away in time.

- Automatic detection of external cache size on many architectures.
  I have no idea if any of this code works, since I don't have any
  of the target machines. The preferred way to initialize the coloring
  is by passing "page_color=<external cache size in kB>" as a boot 
  argument.

- NUMA-safe, discontig-safe

Right now the actual page coloring algorithm is the same as in previous
patches, and performs the same. In the next few weeks I'll be trying new
ideas that will hopefully reduce fragmentation and increase performance.
This is an early attempt to get some feedback on mistakes I may have made.

lmbench shows no real gains or losses compared to an unpatched kernel; 
some of the page fault and protection fault times are slightly slower, but
it's close to the rounding error over five lmbench runs. 

Here are all the performance results I have for the patch:

1. Compile of 2.4.20 kernel with gcc 3.1.1 on 466MHz DS10 Alphaserver with
   2MB cache: repeatable 1% speedup (573 sec vs. 579 sec)

2. 1000x1000 matrix multiply: 10% speedup on Athlon II with 512kB cache
   (Dieter Nützel)

3. Without page coloring, the alpha gets 80% of max theoretical bandwidth
   for working sets at most 1/8 the size of its L2 cache. For larger working
   sets than that the achieved bandwidth is only 30%-50% of max. With page
   coloring, the 80% figure applies to the entire L2 cache.

4. FFTW (alpha): 30% speedup for 64k-point FFTs, 20% speedup for 1M-point FFTs 

Patch is available at

www.boo.net/~jasonp/page_color-2.4.20-20030104.patch

Thanks in advance for any feedback.
jasonp
