Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271713AbTHMJMD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271699AbTHMJMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:12:03 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:29098 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S271714AbTHMJL7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:11:59 -0400
Message-ID: <020c01c3617a$f1b7ba00$4600a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: <linux-kernel@vger.kernel.org>
References: <20030813013156.49200358.akpm@osdl.org>
Subject: How to use hugetlb for the text of a program ?
Date: Wed, 13 Aug 2003 11:11:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
x-mimeole: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I'm trying to use a 4Mo page on a i686 to map the text portion of a
statically linked program.
I used a link script to make the text mapped to 0x00400000
The datas start at next 4M boundary (0x00800000)

architecture: i386, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x00400100

Program Header:
    LOAD off    0x00000000 vaddr 0x00400000 paddr 0x00400000 align 2**12
         filesz 0x00080ebc memsz 0x00080ebc flags r-x
    LOAD off    0x00081000 vaddr 0x00800000 paddr 0x00800000 align 2**12
         filesz 0x00005994 memsz 0x00047870 flags rw-
    NOTE off    0x00000094 vaddr 0x00400094 paddr 0x00400094 align 2**2
         filesz 0x00000020 memsz 0x00000020 flags r--

Next, I tried to use the following function in a hope to copy the text into
a single 4Mo page :

#include <sys/mman.h>
#include <fcntl.h>

#define HUGESZ           0x400000   /* size of one 4M page*/
#define TEXTSTART (char*)0x00400000 /* see ldscript */

void hugerelocate()
{
int fd = open("/huge/textfile", O_RDWR | O_CREAT, 0644) ;
char *ptr ;
extern int _etext ;
if (fd == -1) return ;
ftruncate(fd, 0) ;
ftruncate(fd, HUGESZ) ;
ptr = mmap((char *)0x10000000, HUGESZ, PROT_READ|PROT_WRITE, MAP_SHARED, fd,
0) ;
if (ptr == (char *)1) { close(fd);return;}
memcpy(ptr, TEXTSTART, (char *)&_etext - TEXTSTART) ;
msync(ptr, HUGESZ, MS_SYNC) ;
mmap(TEXTSTART, HUGESZ, PROT_READ|PROT_EXEC,
MAP_SHARED|MAP_FIXED|MAP_POPULATE, fd, 0) ;
close(fd) ;
munmap(ptr, HUGESZ) ;
}

The msync() call produces this kernel message (linux-2.6.0-test3)
mm/msync.c:52: bad pmd 108000e7.

The problem I have is the last mmap(), trying to replace the program text by
the 4M page, just kills the program.

If I try to use a regular file (not on a hugetlbfs), the program is killed
to.

I tried other MAP_??? flags without success.

Do you know if what I'm trying to do is possible ? ie is a hugetlb page OK
with PROT_EXEC ?

Alternatives :

- I was thinking to write a special loader to load the program, but I dont
know how to cope with the brk()

- A combination of a linker/kernel new feature :
    ELF tagged program to ask the kernel to use 4Mo pages if possible to
load the text of a program from the executable file, instead of mapping it
(only for superuser users)

Thanks

Eric Dumazet

