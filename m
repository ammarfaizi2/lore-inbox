Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVBBBg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVBBBg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 20:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVBBBg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 20:36:26 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:62650 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262193AbVBBBgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 20:36:22 -0500
Message-Id: <200502020100.j12104Ws031252@laptop11.inf.utfsm.cl>
To: Andreas Gruenbacher <agruen@suse.de>
cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort() 
In-Reply-To: Message from Andreas Gruenbacher <agruen@suse.de> 
   of "Tue, 01 Feb 2005 18:50:00 BST." <1107280199.12050.113.camel@winden.suse.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Tue, 01 Feb 2005 22:00:04 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher <agruen@suse.de> said:

[...]

> Yes, because a custom swap routine isn't very useful generally. It's
> over-engineered IMHO.

It shouldn't swap, but juggle elements around like so:

    t --------------->+
    ^                 |
    |                 v
    x <-- x <-- x <-- x

Sure, this needs a temporary element, but reduces the data copying to
around 1/3 (1 swap == 3 copies, this makes a bit more than 1 copy for each
element moved). This is probably much more important than
microoptimizations in swap.

My tuned heapsort for doubles is:

/*
 * heapsort.c: Heap sort
 */

#include "sort.h"

void
sort(double a[], int n)

{
  double tmp;
  int i, j, k;
    
  /* Make heap */
  for(i = n / 2 - 1; i >= 0; i--) {
    /* downheap(a, i, n); */
    j = i;
    tmp = a[j];
    for(;;) {
      k = 2 * j + 1;
      if(k >= n)
	break;
      if(k + 1 < n && a[k + 1] > a[k])
	k++;
      if(tmp > a[k])
	break;
      a[j] = a[k];
      j = k;
    }
    a[j] = tmp;
  }
    
  /* Sort */
  for(i = n - 1; i >= 1; i--) {
    /* downheap(a, 1, i); swap(a[1], a[n]); */
    j = 0;
    tmp = a[j];
    for(;;) {
      k = 2 * j + 1;
      if(k > i)
	break;
      if(k + 1 <= i && a[k + 1] > a[k])
	k++;
      if(tmp > a[k])
	break;
      a[j] = a[k];
      j = k;
    }
    a[j] = tmp;

    tmp = a[0]; a[0] = a[i]; a[i] = tmp;
  }
}

Hack on it as you wish.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
