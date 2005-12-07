Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVLGUqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVLGUqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 15:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVLGUqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 15:46:14 -0500
Received: from web34114.mail.mud.yahoo.com ([66.163.178.112]:53357 "HELO
	web34114.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964899AbVLGUqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 15:46:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VnakuZEgBuN+0+hWbaPRJqL0Ah/h7ol4WwAc8YyQJHaLaYT9Re43tQUSNZyPVnbVf/javXznzBS1QKjQQMReYW9PZ7/pPQ5GZpi+tGrH0ZHEkX7AN91pqwCrgEimraYa1Nf+WKLHD8Em4QMUepw+5I6/CoWOxN24932qUb80tGg=  ;
Message-ID: <20051207204612.70808.qmail@web34114.mail.mud.yahoo.com>
Date: Wed, 7 Dec 2005 12:46:12 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: nfs question - ftruncate vs pwrite
To: linux kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-811623306-1133988372=:66928"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-811623306-1133988372=:66928
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Sorry about the previous partial message...

If a file is extended via ftruncate, the new empty pages are read in before the the ftruncate
returns (taking 64mS on my machine), but if the file is extended via pwrite, nothing is read in
and the system call is very quick (34uS).

Why is there such a difference?  Is there another cheap way to grow a file and map in its new
pages?  Am I missing some other semantic difference between ftruncate and a pwrite past the end of
the file?

Here is a test program.. compile with -DABUSE to get the pwrite version.

thanks,
-Kenny


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

--0-811623306-1133988372=:66928
Content-Type: text/x-csrc; name="dtest.c"
Content-Description: 862959384-dtest.c
Content-Disposition: inline; filename="dtest.c"

#define _GNU_SOURCE

#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include <stdio.h>
#include <string.h>
#include <malloc.h>

int main(int argc, char* argv[])
{
  int fd;
  unsigned long long int const size = 4096 * 1024;
  unsigned int const size_page = 1024;
  unsigned long long int offset = 0;
  unsigned int offset_page = 0;

  //char* buffer = valloc(size);
  //memset(buffer, 0, size);

  if (argc != 2) {
    printf("usage: %s <filename>\n", argv[0]);
    return 0;
  }

  fd = open(argv[1], O_RDWR | O_CREAT | O_TRUNC | O_LARGEFILE /*| O_DIRECT*/, 0644);
  if (fd < 0) {
    perror("open");
    return 0;
  }

#ifdef ABUSE
  pwrite64(fd, "" , 1, offset + size);
#else
  ftruncate64(fd, offset + size);
#endif

  char* mapping = (char*)mmap64(0, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE | MAP_NONBLOCK, fd, offset);
  memset(mapping, 'a', size);

  for (;;) {
    offset += size;
    offset_page += size_page;

#ifdef ABUSE
    pwrite64(fd, "", 1, offset + size);
#else
    ftruncate64(fd, offset + size);
#endif

    //munmap(mapping, size);
    //mapping = (char*)mmap64(0, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_POPULATE | MAP_NONBLOCK, fd, offset);
    remap_file_pages(mapping, size, 0, offset_page, MAP_NONBLOCK);

    memset(mapping, 'a', size);
  }

  close(fd);

  return 0;
}

--0-811623306-1133988372=:66928--
