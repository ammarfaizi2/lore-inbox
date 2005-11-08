Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbVKHU55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbVKHU55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 15:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbVKHU54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 15:57:56 -0500
Received: from web34105.mail.mud.yahoo.com ([66.163.178.103]:20398 "HELO
	web34105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030345AbVKHU5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 15:57:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6FTUstUYgg0FfuIWT5/vd4fK9YGH7HEmHkWrpVKMUUVVEynOfu3YFElX0fNnZkX9ZGXmIBgTNzPkmxcByplE8eI2iMiaVuSrCRE8vzUY+K2/IUWW6TUI5/WjKm2bA/fZf8tH4N5bd65UDnpOfeAQQ20MRqLU9rW+gruT8Dqv1g4=  ;
Message-ID: <20051108205755.37541.qmail@web34105.mail.mud.yahoo.com>
Date: Tue, 8 Nov 2005 12:57:55 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: re: mmap over nfs leads to excessive system load
To: linux-kernel@vger.kernel.org
In-Reply-To: <1131480107.32482.48.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1074724565-1131483475=:23866"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1074724565-1131483475=:23866
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

I am attaching a sample piece of code to show the behavior.
This simply tries to grow a file as fast as it can using different methods.
Use with caution as it does not stop, and will fill the disk if you let it run.

Run as "nfstest -m <filename>" where <filename> is on an nfs mount.

-Kenny


		
__________________________________ 
Start your day with Yahoo! - Make it your home page! 
http://www.yahoo.com/r/hs
--0-1074724565-1131483475=:23866
Content-Type: text/x-csrc; name="nfstest.c"
Content-Description: 652126289-nfstest.c
Content-Disposition: inline; filename="nfstest.c"

/* test the write throughput of a sliding mmap window vs simple FILE*  */
#define _GNU_SOURCE

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

void timeout(int i)
{
  struct timeval now;
  gettimeofday(&now, 0);

  (void) i;

  {
    double time_diff = (now.tv_sec - last_time.tv_sec) + ((now.tv_usec - last_time.tv_usec) / 1000000.);

    int new_bytes = total_bytes;
    int diff = new_bytes - last_bytes;
    printf("wrote %dk %dM bytes in %f seconds -> %fM/sec\n", diff / 1024, diff / (1024 * 1024), time_diff, (diff / (time_diff * 1000000.)));
    last_bytes = new_bytes;
    last_time = now;
  }
}



void do_mapwrite(int fd)
{
  /* lets write as fast as we can.... */
  int const window_size = 2 * 1024 * 1024; /* 16k */
  int const window_pages = window_size / 4096;

  int file_page_offset = 0;
  long long file_size = window_size;

  ftruncate64(fd, file_size);

  {
    char* mapping_start = (char*)mmap64(0, window_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);


    /* scribble into buffer and walk the window */
    for (;;) {
      memset(mapping_start, 0, window_size);

      /* grow file */
      file_size += window_size;
      ftruncate64(fd, file_size);
      file_page_offset += window_pages;
      /*msync(mapping_start, window_size, MS_SYNC);*/
      /*munmap(mapping_start, window_size);*/
      /*mapping_start = (char*)mmap64(mapping_start, window_size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd, file_size - window_size);*/
      remap_file_pages(mapping_start, window_size, 0, file_page_offset, MAP_SHARED);

      total_bytes += window_size;
    }
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

  /* start the clock...  */
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

--0-1074724565-1131483475=:23866--
