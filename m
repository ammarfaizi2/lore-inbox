Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbUASVRA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUASVRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:17:00 -0500
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:16772 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S263571AbUASVQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:16:50 -0500
From: jlnance@unity.ncsu.edu
Date: Mon, 19 Jan 2004 16:16:49 -0500
To: linux-kernel@vger.kernel.org
Cc: cmp@synopsys.com
Subject: Awful NFS performance with attached test program
Message-ID: <20040119211649.GA20200@ncsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    The attached program demonstrates a problem I am having writing to
files on an NFS file system.  It works by creating a file, and then
seeking through the file to update it.  The problem I am seeing is that
the seek/update stage takes more than 10X as long as the amount of time
required to initially create the file.  And its not even seeking in
some strange pattern.

    I am running this with a 2.4.20 (red hat patched) kernel.  I have not
tried it with 2.6.  I have played with various mount options, but they
do not seem to make much difference.  Here is one example that I used:

sledge:/l0 /mnt/v3_tcp_8k nfs rw,v3,rsize=8192,wsize=8192,hard,intr,tcp,lock,addr=sledge 0 0

Anyone have any ideas or comments?

Thanks,

Jim


----------------------------------------------------------------------
#include <stdlib.h>
#include <stdio.h>
#include <sys/time.h>

char buff[4096];

double dt(struct timeval *a, struct timeval *b)
{
  double sec = b->tv_usec - a->tv_usec;

  sec /= 1e6;
  sec += b->tv_sec - a->tv_sec;

  return sec;
}

int main()
{
  struct timeval a, b;
  int i;

  FILE *fp = fopen("testfile", "w");

  printf("Creating file: ");
  fflush(stdout);
  gettimeofday(&a, 0);
  for(i=0; i<100*1024; i++)
    fwrite(buff, 4096, 1, fp);
  fflush(fp);
  gettimeofday(&b, 0);

  printf("%.3f seconds\n", dt(&a, &b));

  printf("Updating file: ");
  fflush(stdout);
  gettimeofday(&a, 0);
  for(i=0; i<100*1024*sizeof(buff); i += 5000) {
    fseek(fp, i, SEEK_SET);
    fwrite(&i, sizeof(i), 1, fp);
  }
  gettimeofday(&b, 0);

  printf("%.3f seconds\n", dt(&a, &b));

  return 0;
}
