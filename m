Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUBKTE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 14:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266211AbUBKTE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 14:04:27 -0500
Received: from columba.eur.3com.com ([161.71.171.238]:2803 "EHLO
	columba.eur.3com.com") by vger.kernel.org with ESMTP
	id S266208AbUBKTEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 14:04:05 -0500
Message-ID: <402A7CA0.9040409@jburgess.uklinux.net>
Date: Wed, 11 Feb 2004 19:04:00 +0000
From: Jon Burgess <lkml@jburgess.uklinux.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-gb, en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved
 writes
Content-Type: multipart/mixed;
 boundary="------------020308030504060600090706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020308030504060600090706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I wrote a small benchmark tool to simulate the pattern of writes which 
occur when slowly streaming files to disk.
This is trying to replicate the filesystem activity when I record 
multiple TV and radio channels to disk.

I have attached a copy of the test program. It measures how long it 
takes to write a number of files in parallel, writing a small amount of 
data to each file at a time. I noticed that results for ext2 on 2.6.2 
are much slower than 2.4.22:

Write speed in MB/s using an ext2 filesystem for 1 and 2 streams:
Num streams:     1      2
linux-2.4.22   10.47  6.98
linux-2.6.2     9.71  0.34

"vmstat" agrees with the performance figures. It seems that the pattern 
of small interleaved writes to two files really upsets something in the 
2.6 code. 

During the disk light is on solid and it really slows any other disk 
access. It looks like the disk is continuously seeking backwards and 
forwards, perhaps re-writing the meta data.

Does this look like a problem, or is the test unrealistic?

Thanks,
    Jon



--------------020308030504060600090706
Content-Type: text/plain;
 name="trial.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trial.c"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/param.h>
#include <string.h>
#include <sys/time.h>

#define BSIZE  (4 * 1024)

#define MAX_NAME (256)
char base_name[MAX_NAME];

char *get_name(int n)
{
  static char name[MAX_NAME + 5];
  
  sprintf(name, "%s%d", base_name, n);
  return name;
}


void display_rate(struct timeval start, struct timeval end, int len) 
{
  int d_s, d_us;
  float sec;

  d_s  = end.tv_sec  - start.tv_sec;
  d_us = end.tv_usec - start.tv_usec;

  sec = d_s + d_us / 1000000.0;

  printf("Transferred %dMb of data in %.2f seconds (%.2fMb/s)\n",
	 len, sec, len / sec);
  fflush(NULL);
}

void create_files(int n, int sz)
{
  int out[n], i;
  char buf[BSIZE];
  int pos;
  struct timeval start, end;

  printf("Writing %dMb of data to %d files in parallel\n", sz, n);
  fflush(NULL);

  for (i = 0; i < n; i++) {
    out[i] = open(get_name(i), O_WRONLY | O_CREAT | O_TRUNC, 0666);
    if (out[i] < 0) {
      perror("Creating output file");
      exit(1);
    }
  }

  memset(buf, 0, BSIZE);
  
  gettimeofday(&start, NULL);

  for (pos = 0; pos < (sz * 1024 * 1024); pos += BSIZE) {
    for(i = 0; i < n; i++) {
      if (write(out[i], buf, BSIZE) != BSIZE) {
	  fprintf(stderr, "Problem writing output file\n");
	  exit(2);
      }
    }
  }
  
  for (i=0; i<n; i++) {
    fdatasync(out[i]);
    close(out[i]);
  }

  gettimeofday(&end, NULL);

  display_rate(start, end, n * pos / (1024 * 1024));
}


void delete_files(int n)
{
  int i;
  
  for (i = 0; i < n; i++) {
    unlink(get_name(i));
  }
}

void run_test(int n, int s)
{
  delete_files(n);

  create_files(n, s);

  delete_files(n);

  printf("\n");
  fflush(NULL);
}  

int main(int argc, char *argv[])
{
  unsigned int  s = 16;
  strcpy(base_name, "temp_");

  run_test(1, s);
  run_test(2, s / 2);

  return 0;
}

--------------020308030504060600090706--
