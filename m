Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271832AbTHMMnS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 08:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272520AbTHMMnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 08:43:18 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:17612 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S271832AbTHMMnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 08:43:11 -0400
Message-ID: <024601c36198$6c934560$4600a8c0@edumazet>
From: "dada1" <dada1@cosmosbay.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
References: <20030813013156.49200358.akpm@osdl.org><020c01c3617a$f1b7ba00$4600a8c0@edumazet> <20030813022650.56cfa680.akpm@osdl.org>
Subject: Re: How to use hugetlb for the text of a program ?
Date: Wed, 13 Aug 2003 14:42:53 +0200
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


From: "Andrew Morton" <akpm@osdl.org>
> "dada1" <dada1@cosmosbay.com> wrote:
> >
> > The msync() call produces this kernel message (linux-2.6.0-test3)
> >  mm/msync.c:52: bad pmd 108000e7.
>
> please post the whole test application, and the command line which was
used
> to demonstrate this failure.

My problem came from the choice of _end : it was not the last byte of the
text segment.

I changed the ldscript to define _last_byte (after .rodata, .rodata1,
.gcc_except_table) and now it's ok.

However the msync() problem stays. And a 4M mem leak happens.

Here is a sample program.

# cat msync.c
/*  start of msync.c */
#include <sys/mman.h>
#include <fcntl.h>
#include <stdio.h>

#define HUGESZ           4*1024*1024 /* size of one 4M page*/

int main(int argc, char *argv[])
{
int fd ;
char *ptr ;
const char *filename ;

if (argc < 2) {
        fprintf(stderr, "Usage : msync filename\n") ;
        exit(1) ;
        }
filename = argv[1] ;
fd = open(filename, O_RDWR | O_CREAT, 0644) ;
if (fd == -1) {perror("filename") ; return 1; }
ftruncate(fd, 0) ;
ftruncate(fd, HUGESZ) ;
ptr = mmap((char *)0x10000000, HUGESZ, PROT_READ|PROT_WRITE, MAP_SHARED, fd,
0) ;
if (ptr == (char *)-1) { perror("mmap") ; close(fd);return 2;}
msync(ptr, HUGESZ, MS_SYNC) ;
close(fd) ;
munmap(ptr, HUGESZ) ;
return 0 ;
}
/* end of msync.c */
# gcc -o msync msync.c
# ./msync /huge/testfile
mm/msync.c:52: bad pmd 114000e7
# ./msync /huge/testfile
mm/msync.c:52: bad pmd 118000e7
# ./msync /huge/testfile
mm/msync.c:52: bad pmd 11c000e7
# ./msync /huge/testfile
mmap: Cannot allocate memory

# grep HugePages /proc/meminfo
HugePages_Total:    16
HugePages_Free:      0

Thanks

Eric Dumazet

