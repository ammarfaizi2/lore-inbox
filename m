Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbVKURNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbVKURNg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVKURNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:13:35 -0500
Received: from web34115.mail.mud.yahoo.com ([66.163.178.113]:50348 "HELO
	web34115.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932376AbVKURNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:13:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=48Z22d9q7JlyzC207+JYv12Xq6pORlpVdDeqHXUtbN06T53Ok/XHfy5xgHxw0/APD/gLba5VCpWGvDRqs9HDc++YZfwqnRY/1WM0FfacZd7CiHcUkZetlNRJkLQG3jLYzaSDY+NexB9AA1RTqUIfx/S72g7iXVyxLEJ1nJU/zr8=  ;
Message-ID: <20051121171332.58073.qmail@web34115.mail.mud.yahoo.com>
Date: Mon, 21 Nov 2005 09:13:32 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: infinite loop? with mmap, nfs, pwrite, O_DIRECT
To: Andrew Morton <akpm@osdl.org>
Cc: trond.myklebust@fys.uio.no, cel@citi.umich.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051117130403.4155c94c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a smaller test case (4 system calls, and a memset), that causes the test case to hang in an
unkillable state*, and makes the system load consume an entire CPU.

*the process is killable if run under strace, but the system load does not drop when the strace is
killed.

Pass this the name of a target file on an NFS mount.

(tested to fail on 2.6.15-rc1).

-Kenny


Here is the test:

#define _GNU_SOURCE

#include <fcntl.h>
#include <stdio.h>
#include <strind.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main(int argc, char* argv[])
{
  if (argc != 2) {
    printf("usage: %0 <filename>\n", argv[0]);
    return 0;
  }

  {
    int fd = open(argv[1], O_RDWR | O_CREAT | O_LARGEFILE | O_DIRECT, 0644);
    if (fd < 0) {
      perror("open");
      return 0;
    }

    int window_size = 2 * 1024 * 1024;
    long long file_size = window_size;

    /* fast-forward */
    file_size += 2047u * (2 * 1024 * 1024);
    file_size += window_size + window_size;

    /* grow file */
    pwrite64(fd, "", 1, file_size);

    {
      char* mapping_start = (char*)mmap64(0, window_size,
                                          PROT_READ | PROT_WRITE,
                                          MAP_SHARED,
                                          fd, file_size - window_size);

      /* test only fails with this: */
      memset(mapping_start, 0, window_size);
    }

    /* grow file */
    file_size += window_size;

    /* this never returns */
    pwrite64(fd, "", 1, file_size);
  }
  return 0;
}



		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
