Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVAYDiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVAYDiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 22:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVAYDiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 22:38:09 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:46306 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261789AbVAYDht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 22:37:49 -0500
Message-Id: <200501250044.j0P0iPG3031683@inf.utfsm.cl>
To: hpa@zytor.com (H. Peter Anvin)
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 1/13] Qsort 
In-Reply-To: Message from hpa@zytor.com (H. Peter Anvin) 
   of "Mon, 24 Jan 2005 17:10:16 -0000." <ct3a5o$n0e$1@terminus.zytor.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: Mon, 24 Jan 2005 21:43:55 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

hpa@zytor.com (H. Peter Anvin) said:

[...]

> In klibc, I use combsort:
> 
> /*
>  * qsort.c
>  *
>  * This is actually combsort.  It's an O(n log n) algorithm with
>  * simplicity/small code size being its main virtue.
>  */
> 
> #include <stddef.h>
> #include <string.h>
> 
> static inline size_t newgap(size_t gap)
> {
>   gap = (gap*10)/13;
>   if ( gap == 9 || gap == 10 )
>     gap = 11;
> 
>   if ( gap < 1 )
>     gap = 1;
>   return gap;
> }
> 
> void qsort(void *base, size_t nmemb, size_t size,
>            int (*compar)(const void *, const void *))
> {
>   size_t gap = nmemb;
>   size_t i, j;
>   char *p1, *p2;
>   int swapped;
> 
>   do {
>     gap = newgap(gap);
>     swapped = 0;
> 
>     for ( i = 0, p1 = base ; i < nmemb-gap ; i++, p1 += size ) {
>       j = i+gap;
>       if ( compar(p1, p2 = (char *)base+j*size) > 0 ) {
>         memswap(p1, p2, size);
>         swapped = 1;
>       }
>     }
>   } while ( gap > 1 || swapped );
> }

AFAICS, this is just a badly implemented Shellsort (the 10/13 increment
sequence starting with the number of elements is probably not very good,
besides swapping stuff is inefficient (just juggling like Shellsort does
gives you almost a third less copies)).

Have you found a proof for the O(n log n) claim?

I'd write as attached (careful, a local element on stack!)


--=-=-=
Content-Type: text/x-c
Content-Disposition: attachment; filename=shellsort-fuctions.c
Content-Description: Shellsort

/*
 * shellsort.c: Shell sort
 *
 * Copyright (c) 2005, Horst H. von Brand <vonbrand@inf.utfsm.cl>
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *     * Neither the name of Horst H. von Brand nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <string.h>

void qsort(void *base, size_t nmemb, size_t size, 
           int (*compar)(const void *, const void *))

{
  int i, j, h;
  char tmp[size];
    
  for(h = 1; h < nmemb; h = 3 * h + 1)
    ;
    
  do {
    h /= 3;
    for(i = h; i < nmemb; i++) {
      memcpy(tmp, base + i * size, size);
      for(j = i - h; j >= 0 && compar(tmp, base + j * size); j -= h)
	memcpy(base + (j + h) * size, base + j * size, size);
      memcpy(base + (j + h) * size, tmp, size);
    }
  } while(h > 1);
}

--=-=-=

-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

--=-=-=--
