Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVAXRLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVAXRLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 12:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVAXRLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 12:11:50 -0500
Received: from hera.kernel.org ([209.128.68.125]:64158 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261461AbVAXRLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 12:11:36 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [patch 1/13] Qsort
Date: Mon, 24 Jan 2005 17:10:16 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <ct3a5o$n0e$1@terminus.zytor.com>
References: <20050122203326.402087000@blunzn.suse.de> <Pine.LNX.4.61.0501230357580.2748@dragon.hygekrogen.localhost> <20050123044637.GA54433@muc.de> <Pine.LNX.4.61.0501230600070.2748@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1106586616 23567 127.0.0.1 (24 Jan 2005 17:10:16 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 24 Jan 2005 17:10:16 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.61.0501230600070.2748@dragon.hygekrogen.localhost>
By author:    Jesper Juhl <juhl-lkml@dif.dk>
In newsgroup: linux.dev.kernel
>
> On Sun, 23 Jan 2005, Andi Kleen wrote:
> 
> > > How about a shell sort?  if the data is mostly sorted shell sort beats 
> > > qsort lots of times, and since the data sets are often small in-kernel, 
> > > shell sorts O(n^2) behaviour won't harm it too much, shell sort is also 
> > > faster if the data is already completely sorted. Shell sort is certainly 
> > > not the simplest algorithm around, but I think (without having done any 
> > > tests) that it would probably do pretty well for in-kernel use... Then 
> > > again, I've known to be wrong :)
> > 
> > I like shell sort for small data sets too. And I agree it would be 
> > appropiate for the kernel.
> > 
> Even with large data sets that are mostly unsorted shell sorts performance 
> is close to qsort, and there's an optimization that gives it O(n^(3/2)) 
> runtime (IIRC), and another nice property is that it's iterative so it 
> doesn't eat up stack space (as oposed to qsort which is recursive and eats 
> stack like ****)...
> Yeah, I think shell sort would be good for the kernel.
> 

In klibc, I use combsort:

/*
 * qsort.c
 *
 * This is actually combsort.  It's an O(n log n) algorithm with
 * simplicity/small code size being its main virtue.
 */

#include <stddef.h>
#include <string.h>

static inline size_t newgap(size_t gap)
{
  gap = (gap*10)/13;
  if ( gap == 9 || gap == 10 )
    gap = 11;

  if ( gap < 1 )
    gap = 1;
  return gap;
}

void qsort(void *base, size_t nmemb, size_t size,
           int (*compar)(const void *, const void *))
{
  size_t gap = nmemb;
  size_t i, j;
  char *p1, *p2;
  int swapped;

  do {
    gap = newgap(gap);
    swapped = 0;

    for ( i = 0, p1 = base ; i < nmemb-gap ; i++, p1 += size ) {
      j = i+gap;
      if ( compar(p1, p2 = (char *)base+j*size) > 0 ) {
        memswap(p1, p2, size);
        swapped = 1;
      }
    }
  } while ( gap > 1 || swapped );
}
