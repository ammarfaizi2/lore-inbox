Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbSKOQYJ>; Fri, 15 Nov 2002 11:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbSKOQYJ>; Fri, 15 Nov 2002 11:24:09 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:13316 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S266520AbSKOQYH>; Fri, 15 Nov 2002 11:24:07 -0500
Message-Id: <200211151630.gAFGUqfk024668@pincoya.inf.utfsm.cl>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 1/2] Remove NGROUPS hardlimit (resend w/o qsort) 
In-reply-to: Your message of "Thu, 14 Nov 2002 15:26:13 -0800."
             <200211142326.gAENQE231767@scl2.sfbay.sun.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Fri, 15 Nov 2002 13:30:51 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Hockin <th122948@scl2.sfbay.sun.com> said:

[...]

> +/* a simple shell-metzner sort */
> +static void groupsort(gid_t *grouplist, int gidsetsize)
> +{
> +	int right, left, cur, max, stride;
> +
> +	stride = gidsetsize / 2;

This guarantees bad performance for certain gidgetsizes... customary wisdom
(at least, Knuth sayeth so) is to go:

        for(stride = 1; stride < gidgetsize; stride = 3 * stride + 1)
		;
        do {
           stride /= 3;
           ...
        } while (stride > 1) {

> +	while (stride) {
> +		max = gidsetsize - stride;
> +
> +		for (left = 0; left < max; left++) {
> +			cur = left;
> +			while (cur >= 0) {
> +				right = cur + stride;
> +				if (grouplist[right] < grouplist[cur]) {
> +					gid_t tmp = grouplist[cur];
> +					grouplist[cur] = grouplist[right];
> +					grouplist[right] = tmp;
> +					cur -= stride;
> +				} else {
> +					break;
> +				}
> +			}

You should work by stuffing the new element in a temporary variable, and
just shift the greater ones up, then stuff the one in

My version of shellsort (h is stride, n is size) goes:

  /*
   * shellsort.c: Shell sort
   */

  #include "sort.h"

  void
  sort(double a[], int n)

  {
    int i, j, h;
    double tmp;

    for(h = 1; h < n; h = 3 * h + 1)
      ;

    do {
      h /= 3;
      for(i = h; i < n; i++) {
	tmp = a[i];
	for(j = i - h; j >= 0 && tmp < a[j]; j -= h)
	  a[j + h] = a[j];
	a[j + h] = tmp;
      }
    } while(h > 1);
  }

This gets around bad h (stride) values, and does just a bit more than 1
assignment per element moved in the inner loop (you do 3). Plus it is
shorter ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
