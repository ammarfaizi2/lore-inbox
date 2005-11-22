Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVKVQey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVKVQey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVKVQey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:34:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:37266 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964984AbVKVQex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:34:53 -0500
Subject: mmap64() behaviour on 64-bit machines ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-RS2gLw2oA91Nqz5B5mKw"
Date: Tue, 22 Nov 2005 08:34:53 -0800
Message-Id: <1132677293.24066.242.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RS2gLw2oA91Nqz5B5mKw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I am confused on the behaviour of mmap64() on 64-bit machines.
When I run following simple program, I get SIGSEGV in memset().
But if I replace mmap64() with mmap() - it works fine.
I verified this on ppc64, em64t, amd64.

Whats happening here ? Any clues ?

Thanks,
Badari

[root@localhost ~]# ./tst junk
Segmentation fault

strace output: 
...

open("junk", O_RDWR|O_CREAT, 0644)      = 3
write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
4096) = 4096
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, 3, 0) =
0x2aaaaaaac000
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
Process 26736 detached


--=-RS2gLw2oA91Nqz5B5mKw
Content-Disposition: attachment; filename=tst.c
Content-Type: text/x-csrc; name=tst.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <fcntl.h>
#include <stdio.h>
#include <sys/mman.h>

char buf[4096];
int main(int argc, char* argv[])
{
  int fd;
  char *start;

  if (argc < 2) {
	printf("Usage: %s <filename>\n", argv[0]);
	exit(1);
  }
  fd = open(argv[1], O_RDWR | O_CREAT , 0644);
  if (fd < 0) {
	perror("open");
	exit(1);
  }
  if (write(fd, buf, 4096) < 0) {
	perror("write");
	exit(2);
  } 
  start = (char *)mmap64(0, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
  if (!start) {
	perror("mmap64");
	exit(2);
  }
  memset(start, 0, 4096);
  exit(0);	
}

--=-RS2gLw2oA91Nqz5B5mKw--

