Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132316AbRDFTXV>; Fri, 6 Apr 2001 15:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRDFTXK>; Fri, 6 Apr 2001 15:23:10 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:31610 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S132316AbRDFTXF>; Fri, 6 Apr 2001 15:23:05 -0400
Date: Fri, 6 Apr 2001 15:22:23 -0400 (EDT)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: majer@endeca.com, linux-kernel@vger.kernel.org
Subject: Re: memory allocation problems
In-Reply-To: <200104061657.f36GvWn01002@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Message-ID: <Pine.LNX.4.10.10104061433030.19450-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> can get at most 2GB.  Newer glibc's allow you to tune the definition
> of "small" via an environment variable.

eventually, perhaps libc will be smart enough to create 
more arenas in mmaped space once sbrk fails.  note, though,
that you *CAN* actually malloc a lot more than 1G: you just
have to avoid causing mmaps that chop your VM at TASK_UNMAPPED_BASE:

#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>

void printnumber(unsigned n) {
    char number[20];
    int i;
    for (i=sizeof(number)-1; i>=0 && n; i--) {
        number[i] = '0' + (n % 10);
        n /= 10;
    }
    i++;
    write(1,number+i, sizeof(number)-i);
}
int main() {
    unsigned total = 0;
    const unsigned size = 32*1024;

    while (malloc(size)) {
        total += size;
        printnumber(total>>20);
        write(1,"\n",1);
    }
    return 0;
}

compile -static, of course; printnumber is to avoid stdio, which seems
to use mmap for a small scratch buffer.  I allocated 2942 MB on my 128M 
machine(had to add a swapfile temporarily, since so many tiny mallocs 
do touch nontrivial numbers of pages for arena bookkeeping.)

