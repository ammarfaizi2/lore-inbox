Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284360AbRLCIvq>; Mon, 3 Dec 2001 03:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284375AbRLCItt>; Mon, 3 Dec 2001 03:49:49 -0500
Received: from mail.spylog.com ([194.67.35.220]:6886 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S284385AbRLBXDy>;
	Sun, 2 Dec 2001 18:03:54 -0500
Date: Mon, 3 Dec 2001 02:07:02 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: http://www.spylog.ru
X-Priority: 3 (Normal)
Message-ID: <142576153324.20011203020702@spylog.ru>
To: Andrew Morton <akpm@zip.com.au>
Cc: theowl@freemail.c3.hu, theowl@freemail.hu, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re[2]: your mail on mmap() to the kernel list
In-Reply-To: <3C08A4BD.1F737E36@zip.com.au>
In-Reply-To: <3C082244.8587.80EF082@localhost>,
 <3C082244.8587.80EF082@localhost> <61437219298.20011201113130@spylog.ru>
 <3C08A4BD.1F737E36@zip.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

Saturday, December 01, 2001, 12:37:01 PM, you wrote:

>>
>> The only question is why map anonymous is rather fast (i get
>> 1000req/sec even then mapped 300.000 of blocks), therefore with
>> mapping a fd the perfomance drops to 20req/second at this number.
>> 

AM> well a kernel profile is pretty unambiguous:

AM> c0116af4 mm_init                                       1   0.0050
AM> c0117394 do_fork                                       1   0.0005
AM> c0124ccc clear_page_tables                             1   0.0064
AM> c0125af0 do_wp_page                                    1   0.0026
AM> c01260a0 do_no_page                                    1   0.0033
AM> c01265dc find_vma_prepare                              1   0.0081
AM> c0129138 file_read_actor                               1   0.0093
AM> c012d95c kmem_cache_alloc                              1   0.0035
AM> c0147890 d_lookup                                      1   0.0036
AM> c01573dc write_profile                                 1   0.0061
AM> c0169d44 journal_add_journal_head                      1   0.0035
AM> c0106e88 system_call                                   2   0.0357
AM> c01264bc unlock_vma_mappings                           2   0.0500
AM> c0135bb4 fget                                          2   0.0227
AM> c028982c __generic_copy_from_user                      2   0.0192
AM> c01267ec do_mmap_pgoff                                 4   0.0035
AM> c0126d6c find_vma                                      7   0.0761
AM> c0105000 _stext                                       16   0.1667
AM> c0126c70 get_unmapped_area                          4991  19.8056
AM> c0105278 poll_idle                                  4997 124.9250
AM> 00000000 total                                     10034   0.0062

AM> The `poll_idle' count is from the other CPU.

AM> What appears to be happening is that the VMA tree has degenerated
AM> into a monstrous singly linked list.  All those little 4k mappings
AM> are individual data structures, chained one after the other.

Well. The thing is I've modified an application a bit so it randomly
asked from 1 to 64 pages  and the execution process still look the
same.  So this does not only happen then mapping same sizes but also
touches the initial mapping of many chunks.

So the next test was also simple - I started to deallocate in the same
order fist mmaped chunks  holding only 40.000 of last mapped chunks:

 31000  Time: 5
 32000  Time: 4
 33000  Time: 5
 34000  Time: 5
 35000  Time: 5
 36000  Time: 6
 37000  Time: 5
 38000  Time: 6
 39000  Time: 5
 40000  Time: 6
 41000  Time: 0
 42000  Time: 0
 43000  Time: 1
 44000  Time: 0
 45000  Time: 0
 46000  Time: 1
 47000  Time: 1
 48000  Time: 1
 49000  Time: 1
 50000  Time: 1

 As you see then I start to free pages they are able to be find rather
 fast.

 Now I made in to hold 20000 of mappings only on loop iterations from
 20000 to 40000  and then stop freeing and continue allocating:


 2000  Time: 0
 4000  Time: 0
 6000  Time: 1
 8000  Time: 2
 10000  Time: 2
 12000  Time: 4
 14000  Time: 4
 16000  Time: 4
 18000  Time: 5
 20000  Time: 6
 22000  Time: 0
 24000  Time: 1
 26000  Time: 1
 28000  Time: 1
 30000  Time: 3
 32000  Time: 3
 34000  Time: 4
 36000  Time: 5
 38000  Time: 5
 40000  Time: 6
 42000  Time: 6
 44000  Time: 7
 46000  Time: 8
  

 Quite surprising as you see the speed increases in the hole but
 degrades quite fast even the number of mapped pages stays the same on
 interval 20.000 - 40.000

And now back to the previous test. Now I tested it with 20.000 of
mapped pages: As you see the cycle with a period of 20.000 - with this
period the pages with low addresses are freed so it look exactly like
address space is scaned from the low address to high looking for the
first place for page to fit:

 5000  Time: 1
 10000  Time: 4
 15000  Time: 10
 20000  Time: 13
 25000  Time: 1
 30000  Time: 5
 35000  Time: 9
 40000  Time: 14
 45000  Time: 1
 50000  Time: 5
 55000  Time: 9
 60000  Time: 13
 65000  Time: 1
 70000  Time: 5
 75000  Time: 10
 80000  Time: 13
 85000  Time: 1
 90000  Time: 5
 95000  Time: 10
 100000  Time: 13
 105000  Time: 1
 110000  Time: 5
 115000  Time: 9
 120000  Time: 14

 


AM> The reason you don't see it with an anonymous map is, I think, that
AM> the kernel will merge contiguous anon mappings into a single one,
AM> so there's basically nothing to be searched each time you request some
AM> more memory.

AM> Running the same test on the -ac kernel is 4-5% slower, so Andrea's
AM> new rbtree implementation makes a better linked list than the old
AM> AVL-tree's one :)

AM> It strikes me that this is not a completely stupid usage pattern, and
AM> that perhaps it's worth thinking about some tweaks to cope with it.
AM> I really don't know, but I've Cc'ed some people who do.

Hope so :)
Also As you see other patterns also show fast performance degradation
over increasing number of pages. I can also test random allocation and
freeing but something tells me the result will be the same.

Hope to hear some info from guru :)


Please write me if some patches will be available I will be happy to
test them

The last test programm (if interested)

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <stdlib.h>

int main()
 {
  int i=0;
  void* p;
  int t;
  int fd;
  int size;
  void* arr[1000000];
  int   sz[1000000];
  
  int addr;
  
  for (t=0;t<1000000;t++) arr[t]=NULL;
  for (t=0;t<1000000;t++) sz[t]=0;
  t=time(NULL);
  while(1)
    {     
     fd=open("/spylog/1/test.dat",O_RDWR);
     if (fd<0)
      {
       puts("Unable to open file !");
       return;
      }
//     size=(((double)random()/RAND_MAX*16)+1)*4096;
       size=4096;
//     printf("<%d>",size);
     p=mmap(0x60000000,size, PROT_READ | PROT_WRITE , MAP_PRIVATE ,fd ,0);
     if ((int)p==-1) 
          {
           printf("Failed %d\n",errno);
           return;
          }       
     arr[i]=p;
     sz[i]=size;
     if ((i>20000)) munmap(arr[i-20000],sz[i-20000]);
     i++;     
     if (i%5000==0)
       {
        printf(" %d  Time: %d\n",i,time(NULL)-t);
        t=time(NULL);
       }
     
    } 
 }




-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

