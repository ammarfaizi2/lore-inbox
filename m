Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262847AbVDHPRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262847AbVDHPRK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 11:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262839AbVDHPRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 11:17:10 -0400
Received: from gw.exalead.com ([212.234.111.157]:37194 "EHLO exalead.com")
	by vger.kernel.org with ESMTP id S262847AbVDHPRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 11:17:02 -0400
Message-ID: <4256A06C.8020304@exalead.com>
Date: Fri, 08 Apr 2005 17:17:00 +0200
From: Xavier Roche <roche+kml2@exalead.com>
Organization: Exalead
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: fr, en-us, en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Timestamp of file modified through mmap are not changed in 2.6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timestamp of file modified through mmap are not changed in 2.6 (even 
after msync()). Observations on 2.4 and 2.6 kernels:
- on 2.4, timestamps are altered a few seconds after the program exits.
- on 2.6, timestamps are never altered.

Is this behaviour a normal behaviour ?

Program example to reproduce the bug (you need to create a "test" file 
in the current directory first):

#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <fcntl.h>

int main(void) {
   int fd = open("test", O_RDWR);
   struct stat st;
   char* file;
   if (fd == -1) {
     printf("error opening file\n");
     return 1;
   }
   if (fstat(fd, &st) != 0) {
     printf("error fstating file\n");
     return 1;
   }

   if (st.st_size == 0) {
     printf("error empty file\n");
     return 1;
   }

   printf("Modified date before change: %u\n", st.st_mtime);

   file = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

   if (file == NULL) {
     printf("error mmaping file");
     return 1;
   }

   file[0] = file[0] + 1;

   if (msync((void*) file, st.st_size, MS_SYNC) != 0) {
     printf("error syncing file");
     return 1;
   }

   if (munmap(file, st.st_size) != 0) {
     printf("error closing file");
     return 1;
   }

   if (fstat(fd, &st) != 0) {
     printf("error fstating file\n");
     return 1;
   }

   printf("Modified date after change: %u\n", st.st_mtime);

   return 0;
}

