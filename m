Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbVKQVP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbVKQVP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVKQVP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:15:28 -0500
Received: from web34110.mail.mud.yahoo.com ([66.163.178.108]:1882 "HELO
	web34110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750899AbVKQVP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:15:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=s/i7fkoLHKOQ95qQi2NWyYJJT9tSNN0WyowFAOhLcmIopGARkduYhWt818fTthvIGvT8aZ43U87BghnaWaBPp3ybiddTh8GE+c7Jkd0R+uPNX8KtZWpWhlx5IFqz1Ia2url1ZD1D1arr8RftAsVwYxTTlnm7McVX0+5uB/PmZwM=  ;
Message-ID: <20051117211526.22130.qmail@web34110.mail.mud.yahoo.com>
Date: Thu, 17 Nov 2005 13:15:26 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051117130403.4155c94c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1355962302-1132262126=:21804"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1355962302-1132262126=:21804
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

--- Andrew Morton <akpm@osdl.org> wrote:
> Could you send the test app please?  (Apologies if you've already done so
> and I missed it).
> 

Here it is again... this one skips to just under 4GB before starting.
run with "writetest -m <filename>" for the mmap test.

-Kenny



		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
--0-1355962302-1132262126=:21804
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
  file_size += 2046u * (2 * 1024 * 1024);
  file_page_offset += 2046;


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
    //munmap(mapping_start, window_size);
    //mapping_start = static_cast<char*>(mmap64(mapping_start, window_size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, file_size - window_size));
    while (remap_file_pages(mapping_start, window_size, 0, file_page_offset, MAP_SHARED /*| MAP_NONBLOCK*/) <0)
      perror("remap_file_pages");

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
  int line_len = 64 * 1024;
  char* buf = (char*)malloc(line_len);
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

  int fd = open(argv[2], O_RDWR | O_CREAT | O_LARGEFILE | O_DIRECT, 0644);
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

--0-1355962302-1132262126=:21804--
