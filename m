Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267973AbRHFLRN>; Mon, 6 Aug 2001 07:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbRHFLRE>; Mon, 6 Aug 2001 07:17:04 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:56454 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267973AbRHFLQv>; Mon, 6 Aug 2001 07:16:51 -0400
Date: Mon, 6 Aug 2001 07:16:59 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Luyer <david_luyer@pacific.net.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010806071659.K3862@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <997080081.3938.28.camel@typhaon> <20010806105904.A28792@athlon.random> <20010806063003.H3862@devserv.devel.redhat.com> <20010806124952.G15925@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010806124952.G15925@athlon.random>; from andrea@suse.de on Mon, Aug 06, 2001 at 12:49:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 12:49:52PM +0200, Andrea Arcangeli wrote:
> I never noticed this limit and personally I don't like it regardless of
> the merge_segments (but of course without merge_segments it is can
> trigger problems while switching between 2.2 and 2.4).

Note that mprotect has this behaviour even if the mprotect range covers the
area before it, so unless the heap is allocated without PROT_NONE initially
with mprotect calls later, there isn't anything glibc can do to avoid this.

The program below creates 3 times 10 new vma areas:

#include <sys/mman.h>
#include <unistd.h>
#include <stdio.h>

int main(void)
{
  void *p, *q, *r;
  p = mmap(NULL, 10*4096, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0);
  printf ("p %p\n", p);
  mprotect(p+1*4096, 4096, PROT_READ|PROT_WRITE);
  mprotect(p+2*4096, 4096, PROT_READ|PROT_WRITE);
  mprotect(p+3*4096, 4096, PROT_READ|PROT_WRITE);
  mprotect(p+4*4096, 4096, PROT_READ|PROT_WRITE);
  mprotect(p+5*4096, 4096, PROT_READ|PROT_WRITE);
  mprotect(p+6*4096, 4096, PROT_READ|PROT_WRITE);
  mprotect(p+7*4096, 4096, PROT_READ|PROT_WRITE);
  mprotect(p+8*4096, 4096, PROT_READ|PROT_WRITE);
  q = mmap(NULL, 10*4096, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0);
  printf ("q %p\n", q);
  mprotect(q+1*4096, 4096, PROT_READ|PROT_WRITE);
  mprotect(q+1*4096, 8192, PROT_READ|PROT_WRITE);
  mprotect(q+2*4096, 8192, PROT_READ|PROT_WRITE);
  mprotect(q+3*4096, 8192, PROT_READ|PROT_WRITE);
  mprotect(q+4*4096, 8192, PROT_READ|PROT_WRITE);
  mprotect(q+5*4096, 8192, PROT_READ|PROT_WRITE);
  mprotect(q+6*4096, 8192, PROT_READ|PROT_WRITE);
  mprotect(q+7*4096, 8192, PROT_READ|PROT_WRITE);
  r = mmap(NULL, 10*4096, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE, -1, 0);
  printf ("r %p\n", r);
  mprotect(r+4096, 1*4096, PROT_READ|PROT_WRITE);
  mprotect(r+4096, 2*4096, PROT_READ|PROT_WRITE);
  mprotect(r+4096, 3*4096, PROT_READ|PROT_WRITE);
  mprotect(r+4096, 4*4096, PROT_READ|PROT_WRITE);
  mprotect(r+4096, 5*4096, PROT_READ|PROT_WRITE);
  mprotect(r+4096, 6*4096, PROT_READ|PROT_WRITE);
  mprotect(r+4096, 7*4096, PROT_READ|PROT_WRITE);
  mprotect(r+4096, 8*4096, PROT_READ|PROT_WRITE);
  fflush(stdout);
  pause();
  return 0;
}

	Jakub
