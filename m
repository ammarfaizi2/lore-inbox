Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVK3UEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVK3UEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 15:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbVK3UEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 15:04:52 -0500
Received: from web34103.mail.mud.yahoo.com ([66.163.178.101]:35951 "HELO
	web34103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750705AbVK3UEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 15:04:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=yK1PdAi6rvkHY1n0B7UUBAl0PJ2Imo4RP8mz9MKN/BIEQJr/m+RrIdkQTApdAtq2CcAx/lU6IDaSi76N3I39BPA1V2HKoIXoxb2VDmmOnZtanynNttzP/f9PARniTpir3Xz2wA/bbsVwrYy9HiKBhgmbQ0kbFaOptLSjZTvd1iY=  ;
Message-ID: <20051130200448.76281.qmail@web34103.mail.mud.yahoo.com>
Date: Wed, 30 Nov 2005 12:04:48 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: nfs unhappiness with memory pressure
To: linux-kernel@vger.kernel.org
Cc: theonetruekenny@yahoo.com
In-Reply-To: <1132620540.8011.58.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-839040735-1133381088=:75895"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-839040735-1133381088=:75895
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi again... I'm still doing nfs tests.

With 2.6.15-rc3-mm1, a simple program can bring the system to a halt (as it can with previous
kernels).

I ran the test in single user mode, and copied the following output from sysrq-m, sysrq-t by
hand...

sysrq-t:
writetest:
  io_schedule
  sync_page
  __wait_on_bit_lock
  __lock_page
  filemap_nopage
  do_no_page
  __handle_mm_fault
  error_code

rpciod/0:
  io_schedule_timeout
  blk_congestion_wait
  throttle_vm_writeout
  shrink_zone
  shrink_caches
  try_to_free_pages
  __alloc_pages
  tcp_sendmsg
  inet_sendmsg
  sock_sendmsg
  kernel_sendmsg
  sock_no_sendpage
  xs_tcp_send_request
  xprt_transmit
  call_transmit
  __rpc_execute
  rpc_async_schedule
  worker_thread
  kthread
  kernel_thread_helper

sysrq-m:
Mem-Info:
  DMA per-cpu:
  cpu 0  hot: high 12  batch 2  used 0
  cpu 0 cold:       4        1       0
  cpu 1  hot:      12        2       1
  cpu 1 cold:       4        1       0
  cpu 2  hot:      12        2       0
  cpu 2 cold:       4        1       0
  cpu 3  hot:      12        2       0
  cpu 3 cold:       4        1       0

  DMA32 per-cpu: empty

  Normal per-cpu:
  cpu 0  hot: high 384  batch 64  used  1
  cpu 0 cold:      128        32        0
  cpu 1  hot:      384        64       97
  cpu 1 cold:      128        32        0
  cpu 2  hot:      384        64       63
  cpu 2 cold:      128        32       32
  cpu 3  hot:      384        64       47
  cpu 3 cold:      128        32        0

  Highmem per-cpu:
  cpu 0:  hot:  high 384  batch 64  used 0
  cpu 0: cold:       128        32       0
  cpu 1:  hot:  high 384  batch 64  used 0
  cpu 1: cold:       128        32       0
  cpu 2:  hot:  high 384  batch 64  used 0
  cpu 2: cold:       128        32       0
  cpu 3:  hot:  high 384  batch 64  used 0
  cpu 3: cold:       128        32       0

  free pages: 14088kB (6000kB HighMem)
  Active: 453253  inactive: 43719  dirty: 149725  writeback: 310580
  unstable: 0  free: 3502  slab: 14870  mapped: 1230

  524149 pages of RAM
  294773 pages of HIGHMEM
  6137 reserved pages
  311956 pages shared
  0 pages swap cache
  149725 pages dirty
  310580 pages writeback
  1230 pages mapped
  14870 pages slab
  16 pages pagetables

This is the same test program as before.
It simply opens a file O_RDWR | O_CREAT | O_TRUNC | O_LARGEFILE,
  grows the file by doing a pwrite64 of 1 byte,
  maps the end of the file with mmap64(PROT_READ | PROT_WRITE, MAP_SHARED)
  touches all the bytes by doing a memset
  grows the file some more
  unmaps, maps the new region, touches memory, ....

Once all the free memory on the system is used, no new processes can start, and the system is
effectively hung.  Only sysrq and vt switching function (unless running X).

Any further info I could provide?  Any ideas?  Patches to try out?

thanks,
-Kenny

Here is the test program again (run as writetest -m <file-on-nfs>)


		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free. 
http://music.yahoo.com/unlimited/
--0-839040735-1133381088=:75895
Content-Type: text/x-c++src; name="writetest.cpp"
Content-Description: 3360621278-writetest.cpp
Content-Disposition: inline; filename="writetest.cpp"

// test the write throughput of a sliding mmap window vs simple FILE*

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/time.h>

int total_bytes = 0;
int last_bytes = 0;

struct timeval last_time;

void timeout(int)
{
  struct timeval now;
  gettimeofday(&now, 0);

  double time_diff = (now.tv_sec - last_time.tv_sec) + ((now.tv_usec - last_time.tv_usec) / 1000000.);
  last_time = now;

  int new_bytes = total_bytes;
  int diff = new_bytes - last_bytes;
  printf("wrote %dk %dM bytes in %f seconds -> %fM/sec\n", diff / 1024, diff / (1024 * 1024), time_diff, (diff / (time_diff * 1000000.)));
  last_bytes = new_bytes;
}


// tests O_DIRECT + pwrite = fail
//       O_DIRECT + truncate = happy
//                  truncate = happy

//                  pwrite = happy
//       O_DIRECT + truncate = happy
//                  truncate = happy
//       O_DIRECT + pwrite = fail

void do_mapwrite(int fd)
{
  // lets write as fast as we can....
  int const window_size = 2 * 1024 * 1024; // 2 * 1024 * 1024; // 16k
  int const window_pages = window_size / 4096;

  int file_page_offset = 0;
  long long file_size = window_size;


  // fast-forward... by 2046 windows
  file_size += 2047u * (2 * 1024 * 1024);
  file_page_offset += 2047;


  //ftruncate64(fd, file_size);
  printf("pwrite to %llx  %llu\n", file_size, file_size);
  pwrite64(fd, "", 1, file_size);

  char* mapping_start = static_cast<char*>(mmap64(0, window_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, file_size - window_size));


  // scribble into buffer and walk the window
  for (;;) {
    memset(mapping_start, 0, window_size);

    // grow file
    file_size += window_size;

    //ftruncate64(fd, file_size);
    pwrite64(fd, "", 1, file_size);

    file_page_offset += window_pages;


#if 1
    munmap(mapping_start, window_size);

    mapping_start = static_cast<char*>(mmap64(mapping_start, window_size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, file_size - window_size));
    if (mapping_start == (char*)MAP_FAILED) {
      perror("mmap");
      return;
    }
#else

    while (remap_file_pages(mapping_start, window_size, 0, file_page_offset, MAP_SHARED /*| MAP_NONBLOCK*/) <0)
      perror("remap_file_pages");
#endif
    //ftruncate64(fd, file_size);

    total_bytes += window_size;
  }
}



void do_filewrite(int fd)
{
  FILE* ptr = fdopen(fd, "w+");

  int line_len = 80;
  char* buf = (char*)malloc(line_len);
  memset(buf, 0, line_len);

  for (;;) {
    fwrite(buf, line_len, 1, ptr);
    total_bytes += line_len;
  }
}

void do_syswrite(int fd)
{
  unsigned int line_len = 64 * 1024;
  char* buf = (char*)(((long)malloc(line_len * 2) + (line_len - 1)) & -line_len);
  memset(buf, 0, line_len);

  for (;;) {
    write(fd, buf, line_len);
    total_bytes += line_len;
  }
}


int main(int argc, char* argv[])
{
  if (argc != 3) {
    printf("usage: %s -[mfw] <filename>\n", argv[0]);
    return 0;
  }

  if ((argv[1][0] != '-') || 
      ((argv[1][1] != 'm') &&
       (argv[1][1] != 'w') &&
       (argv[1][1] != 'f'))) {
    printf("usage: %s -[mfw] <filename>\n", argv[0]);
    return 0;
  }

  int fd = open(argv[2], O_RDWR | O_CREAT | O_TRUNC | O_LARGEFILE /*| O_DIRECT*/, 0644);
  if (fd < 0) {
    perror("open");
    return 0;
  }

  // start the clock...
  signal(SIGALRM, timeout);
  {
    struct itimerval itv;
    itv.it_interval.tv_sec = 1;
    itv.it_interval.tv_usec = 0;
    itv.it_value = itv.it_interval;

    setitimer(ITIMER_REAL, &itv, 0);
  }

  switch (argv[1][1]) {
  case 'm': do_mapwrite(fd); break;
  case 'f': do_filewrite(fd); break;
  case 'w': do_syswrite(fd); break;
  }

  return 0;
}

--0-839040735-1133381088=:75895--
