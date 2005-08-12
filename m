Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbVHLSXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbVHLSXX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbVHLSXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:23:22 -0400
Received: from liaag2ae.mx.compuserve.com ([149.174.40.156]:18841 "EHLO
	liaag2ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750804AbVHLSXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:23:02 -0400
Date: Fri, 12 Aug 2005 14:18:52 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the
  difference between /dev/km
To: Hugh Dickins <hugh@veritas.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200508121422_MC3-1-A70F-D742@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005 at 15:25:18 +0100 (BST), Hugh Dickins wrote:

> On Thu, 11 Aug 2005, Steven Rostedt wrote:
> > 
> > Found the problem.  It is a bug with mmap_kmem.  The order of checks is
> > wrong, so here's the patch.
> 
> Good find, looks right to me, so far as it goes (why does this check

 Even with Steven's patch applied, root cannot read from /dev/kmem with the
following program, which works on 2.6.9.  "Invalid argument" means that the
"fd is attached to an object that is unsuitable for reading."

# ./desc2
GDT is at 0xc13097a0
read /dev/kmem: Invalid argument


#include <stdio.h>
#include <fcntl.h>
#define perr(err) { perror(err), exit(1); }

struct {
        unsigned short limit;
        unsigned int base;
} __attribute__ ((packed)) dtr;

int kmem, i;
int buf[1024];

int main() {
        if ((kmem = open("/dev/kmem", O_RDONLY)) < 0)
                perr("open /dev/kmem");

        asm("sgdtl %0" : "=m"(dtr));
        printf("GDT is at 0x%x\n", dtr.base);
        dtr.limit++;  /* convert to size */

        if (lseek(kmem, dtr.base, SEEK_SET) != dtr.base)
                perr("lseek /dev/kmem");
        if (read(kmem, buf, dtr.limit) != dtr.limit)
                perr("read /dev/kmem");

        for (i = 0; i < dtr.limit / 4; i += 2)
                if (buf[i+1])
                        printf("entry %d(0x%x): 0x%x 0x%x\n",
                                i / 2, i / 2, buf[i], buf[i+1]);

        return 0;
}

__
Chuck
