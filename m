Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWCaLWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWCaLWv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 06:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWCaLWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 06:22:51 -0500
Received: from unthought.net ([212.97.129.88]:62219 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751296AbWCaLWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 06:22:50 -0500
Date: Fri, 31 Mar 2006 13:22:49 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: NFS client regression, simple test program
Message-ID: <20060331112249.GG9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
References: <20060331094850.GF9811@unthought.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20060331094850.GF9811@unthought.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Attached is a small test program that exposes the regression.

Kernel LEADING_EMPTY_SPACE wall-clock time to run
2.6.15    0                0.2s
2.6.15    1                29.3s
2.6.14.7  0                0.2s
2.6.14.7  1                0.2s

So it seems that if a file is repeatedly read from and written to, it
matters a lot for later kernels whether or not the blocks that are
worked on, are offset a single byte or not...

Any ideas?

-- 

 / jakob


--17pEHd4RhPHOinZp
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="nfsbench.c"

/*
 * Tiny benchmark for Linux NFS client problem 2.6.14.7->2.6.15
 *
 * By Jakob Oestergaard, joe@unthought.net / joe@evalesco.com
 *
 * Compile as:
 *  gcc -o nfsbench -O3 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 nfsbench.c
 */

#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdint.h>

#define MYBLOCKSIZE 32768
#define MYSUBSIZE 1024

/* Set this define to non-zero to expose the regression */
#define LEADING_EMPTY_SPACE 1

int main(int argc, char **argv)
{
  int testfd = open("testfile", O_RDWR|O_CREAT|O_TRUNC, 0666);
  off_t blockoff;
  uint8_t garbage[MYBLOCKSIZE];

  memset(garbage, 42, sizeof garbage);

  for (blockoff = LEADING_EMPTY_SPACE;
       blockoff < 10 * 1024 * 1024;
       blockoff += MYBLOCKSIZE) {
    off_t inblockoff;
    lseek(testfd, blockoff, SEEK_SET);
    write(testfd, garbage, MYBLOCKSIZE);

    for (inblockoff = MYBLOCKSIZE / 4;
	 inblockoff < MYBLOCKSIZE * 3 / 4;
	 inblockoff += MYSUBSIZE * 2) {
      uint8_t gdata[MYBLOCKSIZE];
      lseek(testfd, blockoff, SEEK_SET);
      read(testfd, gdata, MYBLOCKSIZE);
      lseek(testfd, -inblockoff, SEEK_CUR);
      write(testfd, gdata + inblockoff, MYSUBSIZE);
    }
  }

  close(testfd);
}

--17pEHd4RhPHOinZp--
