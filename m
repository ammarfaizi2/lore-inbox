Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318900AbSHNPid>; Wed, 14 Aug 2002 11:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318907AbSHNPid>; Wed, 14 Aug 2002 11:38:33 -0400
Received: from compsciinn-gw.customer.ALTER.NET ([157.130.84.134]:4230 "EHLO
	picard.csi-inc.com") by vger.kernel.org with ESMTP
	id <S318900AbSHNPic>; Wed, 14 Aug 2002 11:38:32 -0400
Message-ID: <050a01c243a9$2afa3590$f6de11cc@black>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: mmap'ing a large file
Date: Wed, 14 Aug 2002 11:42:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a logical reason why a process can't mmap more than a 2G file?

I seem to get stuck at 2142208000 with
mmap: Cannot allocate memory

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define FILESIZE 2500000000

int
main ()
{
    unsigned long long offset = 0;
    unsigned long maplength = getpagesize () * 1000;
    int i;
    unsigned char *p;
    char mynull = 0;
    int fd = open ("test.map", O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
    if (fd < 0) {
        perror ("test.map");
        exit (-1);
    }
    lseek (fd, FILESIZE - 1, SEEK_SET);
    write (fd, &mynull, 1);
    for (offset = 0; offset < FILESIZE - maplength; offset += maplength) {
        p = mmap (p, maplength, PROT_READ | PROT_WRITE, MAP_SHARED, fd,offset);
        printf ("%lld %p\n", offset, p);
        fflush (stdout);
        if (p == (unsigned char *) -1) {
            perror ("mmap");
            exit (-1);
        }
        memset (p, 1, maplength);
#if 0
        munmap (p, maplength);  /* this of course let's things go on */
#endif
    }
    return 0;
}


Michael D. Black mblack@csi-inc.com
http://www.csi-inc.com/
http://www.csi-inc.com/~mike
321-676-2923, x203
Melbourne FL

