Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281796AbRK0Whc>; Tue, 27 Nov 2001 17:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281788AbRK0WhX>; Tue, 27 Nov 2001 17:37:23 -0500
Received: from fromage.dsndata.com ([198.183.6.16]:50436 "EHLO
	fromage.dsndata.com") by vger.kernel.org with ESMTP
	id <S279305AbRK0WhI>; Tue, 27 Nov 2001 17:37:08 -0500
Date: Tue, 27 Nov 2001 16:36:51 -0600
From: Jeff Epler <jepler@unpythonic.dhs.org>
To: Peter Zaitsev <pz@spylog.ru>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: MMAP issues
Message-ID: <20011127163650.B15307@unpythonic.dhs.org>
In-Reply-To: <183721898675.20011127194607@spylog.ru> <3C03D108.E3FADE95@zip.com.au> <149725995035.20011127205424@spylog.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149725995035.20011127205424@spylog.ru>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The difference in runtime between successive runs of your program
doesn't look terribly significant.

You open 'fd' each time, and never close it.  I die about 1000 mmap()s
into the process (-EMFILE returned by sys_open).  You may be testing
Linux' performance with huge fd sets in your test as well.

Moving the open() outside the loop, and running on a 512M, kernel 2.2
machine that's also running a full gnome desktop I get really intense
kernel CPU usage, and the following output:
 10000  Time: 12
 20000  Time: 45
 30000  Time: 79
 40000  Time: 113
[and I got too bored to watch it go on]

Unmapping the page after each map yields much better results:

 10000  Time: 4
 20000  Time: 4
 30000  Time: 4
 40000  Time: 5
 50000  Time: 4
 60000  Time: 4
 70000  Time: 5
 80000  Time: 5
 90000  Time: 5
 100000  Time: 4
[etc]

Interestingly, forcing the test to allocate at successively lower
addresses gives fast results until mmap fails (collided with a shared
library?):
 10000  Time: 4
 20000  Time: 4
 30000  Time: 4
 40000  Time: 4
 50000  Time: 4
 60000  Time: 4
Failed 0x60007000 12

So in kernel 2.2, it looks like some sort of linked list ordered by user
address is being traversed in order to complete the mmap() operation.
If so, then the O(N^2)-like behavior you saw in your original report is
explained as the expected performance of linux' mmap for a given # of
mappings.

Jeff

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

int main()
{
    int i = 0;
    void *p;
    int t;
    int fd;
    int addr = (void *) 0x70000000;

    fd = open("test.dat", O_RDWR);
    if (fd < 0) {
	puts("Unable to open file !");
	return;
    }
    t = time(NULL);
    while (1) {
	p = mmap(addr, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
	addr = addr - 4096;
	if ((int) p == -1) {
	    printf("Failed %p %d\n", addr, errno);
	    return;
	}
	i++;
	if (i % 10000 == 0) {
	    printf(" %d  Time: %d\n", i, time(NULL) - t);
	    t = time(NULL);
	}
    }
}
