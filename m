Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278678AbRJ3XGE>; Tue, 30 Oct 2001 18:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278694AbRJ3XF4>; Tue, 30 Oct 2001 18:05:56 -0500
Received: from dsl-213-023-043-203.arcor-ip.net ([213.23.43.203]:42764 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S278678AbRJ3XFm>;
	Tue, 30 Oct 2001 18:05:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Google's mm problems
Date: Wed, 31 Oct 2001 00:07:17 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15yhyY-0000Yb-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've been taking a look on a mm problem that Ben Smith of Google posted 
a couple of weeks ago.  As it stands, Google can't use 2.4 yet because all
known flavors of 2.4 mm fall down in one way or another.  This is not good.

The kernel that comes closest to working is 2.4.9.  After running the test 
application below for about 30 seconds, kswapd takes over and cpu utilization 
goes to 100%.  With a dual processor system the system remains usable
(because kswapd can't take over two cpus at the same time, however much it 
would like to).  The test application does run to completion, taking about
20% more real time and 95% more cpu than it should.

Other kernels show worse behaviour.  Ben has checked them, I haven't yet.  
Ben reports that they all lock up so that applications make no progress, 
except for linux-2.4.13-ac4 which locks up with 3.5G but not with 2G.  
According to Ben, the linus kernels after 2.4.9 (Andrea) lock up hard so that 
power cycling is required, while control can be recovered on -ac (Rik) 
kernels eventually by killing the application.

I took a look at this and was able to reproduce the problem easily on a 2.4.9 
kernel, dual cpu, 2 Gig memory, using a procedure described below.

The application, written by Ben, goes through a loop mmaping a number of 
large files, in this case 2 (with 2 Gig) and mlocking them.  So the effect is 
to allocate a lot of memory and free it.  This works fine until free memory 
runs out and freeable memory has to start being recycled.  After a while, 
most memory ends up on the active list and kswapd cpu utilization hits 100%.

Earlier, Andrea suggested trying madvise instead of mlock, and the results
are pretty much the same.  (Which could be a clue.)

I found that the first obvious problem is, kswapd is never sleeping.  I was 
able to reduce cpu utilization to 35% easily by ignoring the result of 
try_to_free_pages in kswapd, so that kswapd always sleeps after doing its 
work.  This sort of makes sense anyway, since in a heavily loaded state the 
synchronous mm scanning does just as good a job as kswapd, and unlike 
kswapd, does terminate after a known amount of scanning.  This trivial
change change is obviously just a bandaid.

I've run out of time to work on this just now since I have to get ready for 
ALS.  The next step is to find out why kernels other than 2.4.9 have trouble 
with this application.  This includes both Rik and Andrea mm variants.  So 
I'm posting my results so far and a method for reproducing the problems.

The application uses a little over 8 Gig of test data on disk, created by
the following bash script:

    for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19;
    do dd if=/dev/zero of=/test/chunk$i count=6682555 bs=64; done

The following c++ application runs with no parameters:

#include <stdlib.h>
#include <sys/time.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <string.h>
#include <errno.h>

#define BLOCK_SIZE 427683520
// Adjust NUM_BLOCKS as needed to ensure that mlock won't fail
#define NUM_BLOCKS 6
// Sometimes when mmap fails at the default address it will succed here
#define ALT_ADDR 0x0d000000
// We lock with 1M chunks to avoid machine lockups.
#define MLOCK_CHUNK 1048576
#define PAGE_SIZE 4096
char *addrs[NUM_BLOCKS];
const char *filepat = "/test/chunk%d";
static int num_slots;

void mlock_slot(int i) {
   timeval start, end;
   gettimeofday(&start, NULL);
   char *top = addrs[i] + BLOCK_SIZE;
   printf("mlocking slot %i, %x\n", i, addrs[i]);
   for (char* addr = addrs[i]; addr < top;
        addr += MLOCK_CHUNK) {
     int size = addr + MLOCK_CHUNK <= top ?
                MLOCK_CHUNK : top - addr;
     if (addr == addrs[i])
       printf("mlocking at %x of size %d\n", addr, MLOCK_CHUNK);
     if (mlock(addr, size) == -1) {
       printf("mlock failed: %s\n", strerror(errno));
       abort();
     } else {
       //      printf("mlock succeeded\n");
     }
   }
   gettimeofday(&end, NULL);
   long elapsed_usec = (end.tv_sec - start.tv_sec) * 1000000 +
                       (end.tv_usec - start.tv_usec);
   printf("mlock took %lf seconds\n", elapsed_usec / 1000000.0);
}

int main() {

   // First we setup our regions
   for (int i = 0; i < NUM_BLOCKS; ++i) {
     printf("mmap'ing %d bytes...\n", BLOCK_SIZE);
     addrs[i] = (char*)mmap(0, BLOCK_SIZE, PROT_READ, MAP_PRIVATE|MAP_ANON,
                            -1, 0);
     if (addrs[i] == MAP_FAILED) {
       printf("mmap failed: %s\n", strerror(errno));
       printf("trying backup region %x\n", ALT_ADDR);
       addrs[i] = (char*)mmap((char *)ALT_ADDR, BLOCK_SIZE, PROT_READ,
                              MAP_PRIVATE|MAP_ANON, -1, 0);
       if (addrs[i] == MAP_FAILED)
         printf("backup mmap failed: %s\n", strerror(errno));
     }
     if (addrs[i] != MAP_FAILED)
       printf("mmap'ed at %x-%x.\n", addrs[i], (int)addrs[i] + BLOCK_SIZE);
     if (mlock(addrs[i], BLOCK_SIZE) < 0) {
       printf("mlock of slot %d failed, using only %d slots\n", i, num_slots);
       munmap(addrs[i], BLOCK_SIZE);
       addrs[i] = (char *)MAP_FAILED;
       break;
     }
     num_slots++;
   }

   // Okay, let's load over the old blocks
   for (int j = 0; j < 20; ++j) {
     int i = j % num_slots;
     if (addrs[i] == MAP_FAILED)
       break;
     if ( munlock(addrs[i], BLOCK_SIZE) < 0 )
       printf("Error munlock'ing %x\n", addrs[i]);
     else
       printf("munlock'ed %x\n", addrs[i]);
     if ( munmap(addrs[i], BLOCK_SIZE) < 0 )
       printf("Error munmap'ing region %x\n", addrs[i]);
     else
       printf("munmap'ed %x\n", addrs[i]);
     printf("Loading data at %x for slot %i\n", addrs[i], i);
     char filename[1024];
     sprintf(filename, filepat, j);
     int fd = open(filename, O_RDONLY);
     if (fd < 0) abort();
     char *addr = (char*)mmap(addrs[i], BLOCK_SIZE, PROT_READ,
                              MAP_FIXED | MAP_PRIVATE, fd, 0);
     if (addr != addrs[i] || addr == MAP_FAILED) {
       printf("Load failed: %s\n", strerror(errno));
     } else {
       printf("Load (%s) succeeded!\n", filename);
     }
     mlock_slot(i);
     close(fd);
   }
   printf("sleeping...\n");
   while(1) sleep(5);
}

If it works flawlessly it will complete its work in about 20 X 18 seconds = 6
minutes, then sleep.  On 2.4.9 it gets bogged down in kswapd after about 30 
seconds as soon as the program has eaten its way through all the 'virgin' 
memory and memory starts to be recycled.  This causes it to take about 10 
minutes to complete, and kswapd usage stays at 100% when the program sleeps.

On a subsequent run, the application will drive kswapd to 100% cpu 
immediately, which is understandable because 99% of memory remains in cache.
This cache memory can be freed by putting the /test/ directory on a separate 
partition and umounting it, which restores the system to a relatively 
pristine state.

Profiling the kernel shows me that the cpu hogs are refill_inactive_scan, 
page_launder, and pagemap_lru_lock contention, in that order.  I suspected 
that kswapd is never sleeping, so I applied this patch:

--- ../2.4.9.clean/mm/vmscan.c  Wed Aug 15 05:37:07 2001
+++ ./mm/vmscan.c       Tue Oct 30 16:15:52 2001
@@ -927,7 +927,7 @@
                        recalculate_vm_stats();
                }
 
-               if (!do_try_to_free_pages(GFP_KSWAPD, 1)) {
+               if (!do_try_to_free_pages(GFP_KSWAPD, 1) && 0) {
                        if (out_of_memory())
                                oom_kill();
                        continue;

Which just ignores the result of do_try_to_free_pages and allows kswapd to 
sleep normally, even when it thinks it hasn't achieved its free memory 
target.  This reduced the steady-state cpu usage to about 35%, still very 
unimpressive but no longer a DoS.  With this patch in place, cpu usage drops 
to about 18% when the program sleeps, so some of the cpu is being hogged by 
do_try_to_free_pages on the kswapd path, and a roughly equal amount by 
do_try_to_free_pages on the synchonous alloc_pages path.

Ben confirmed my results on his machine but observed that my patch did not 
have much effect with 3.5 Gig in the machine instead of 2 Gig.  So we know
that the badness scales with memory size.

With my patch in place, a profile during the steady state looks like this:

  %   cumulative   self              self     total
 time   seconds   seconds    calls  us/call  us/call  name
 71.62     25.61    25.61    56190   455.78   455.78  default_idle
  7.10     28.15     2.54     2138  1188.03  1253.38  refill_inactive_scan
  6.15     30.35     2.20     2849   772.20   819.82  page_launder
  5.26     32.23     1.88                             stext_lock
  2.82     33.24     1.01    10307    97.99    99.65  DAC960_BA_InterruptHandler
  1.09     33.63     0.39                             USER
  0.78     33.91     0.28     3464    80.83    92.37  do_softirq
  0.36     34.04     0.13   160337     0.81     0.87  reclaim_page
  0.34     34.16     0.12    87877     1.37     1.48  schedule
  0.34     34.28     0.12                             mcount
  0.28     34.38     0.10    13862     7.21     7.21  statm_pgd_range
  0.25     34.47     0.09 10891694     0.01     0.01  zone_inactive_plenty
  0.14     34.52     0.05   160287     0.31     0.59  try_to_free_buffers

The stext_lock suggests that lock contention is excessive.  However, ordinary 
scanning is the real cpu hog.

At this point I ran out of time and didn't pursue the obvious question of why 
so much more scanning than necessary is being done.  Clearly,
refill_inactive_scan and page_launder aren't reaching their targets, but why?

Questions remain as to why Rik's mm is more heaviliy DoSed than 2.4.9, and why 
Andrea's locks up completely.  I'll be available if anyone wants to talk more 
about this, and in a couple weeks I'll return to it if the problem survives 
that long.

Rik, Andrea, enjoy ;-)

--
Daniel
