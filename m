Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284283AbRLMRhs>; Thu, 13 Dec 2001 12:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284464AbRLMRhj>; Thu, 13 Dec 2001 12:37:39 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:33032 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S284283AbRLMRhV>;
	Thu, 13 Dec 2001 12:37:21 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Wayne Whitney <whitney@math.berkeley.edu>
Date: Thu, 13 Dec 2001 18:36:43 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
CC: LKML <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <BE42B9D5208@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Dec 01 at 8:22, Wayne Whitney wrote:
> > So maybe MAGMA uses some API which it should not use under any
> > circumstances... Such as that you linked it with libc6 stdio.
> 
> Indeed.  How can I avoid the map at 0x40000000?  Must I avoid using
> certain glibc2 functions, and then link the executable carefully to leave
> out their initialization routines?  Or can I set some magic environment

It is caused by (I think that stupid...) code in 
glibc-2.2.4/libio/libioP.h:ALLOC_BUF(), which unconditionally does
'mmap(0, ROUND_TO_PAGE(size), PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0)' instead of 'malloc(size)' when it finds that underlying system
supports malloc.

If you linked Magma yourself, try adding:
---
#include <malloc.h>

void* malloc(size_t len) { return sbrk(len); }
void* __mmap(void* start, size_t len, int prot, int flags, int fd, 
        unsigned long offset) {
    if (start == 0 && fd == -1) { return malloc(len); }
    return NULL;
}
---
into your project. It forces my 'void main() { printf("X\n"); pause(); }'
to use brk() instead of mmap() for stdio buffers. Maybe we should move
to bug-glibc instead, as there is no way to force stdio to not ignore
mallopt() parameters, it still insist on using mmap, and I think that it
is a glibc2.2 bug.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz

P.S.: I did some testing, and about 95% of mremap() allocations is
targeted to last VMA, so no VMA move is needed for them. But no Java
was part of picture, only c/c++ programs I use - gcc, mc, perl.
