Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVB0Vxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVB0Vxh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 16:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVB0Vxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 16:53:36 -0500
Received: from news.suse.de ([195.135.220.2]:47770 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261309AbVB0VxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 16:53:25 -0500
From: Andreas Gruenbacher <agruen@suse.de>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Date: Sun, 27 Feb 2005 22:53:23 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <2.416337461@selenic.com> <200502271417.51654.agruen@suse.de> <20050227212536.GG3120@waste.org>
In-Reply-To: <20050227212536.GG3120@waste.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TFkICpe8pI8mThl"
Message-Id: <200502272253.23732.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_TFkICpe8pI8mThl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 27 February 2005 22:25, Matt Mackall wrote:
> On Sun, Feb 27, 2005 at 02:17:51PM +0100, Andreas Gruenbacher wrote:
> > Matt,
> >
> > On Monday 31 January 2005 08:34, Matt Mackall wrote:
> > > This patch adds a generic array sorting library routine. This is meant
> > > to replace qsort, which has two problem areas for kernel use.
> >
> > the sort function is broken. When sorting the integer array {1, 2, 3, 4,
> > 5}, I'm getting {2, 3, 4, 5, 1} as a result. Can you please have a look?
>
> Which kernel? There was an off-by-one for odd array sizes in the
> original posted version that was quickly spotted:
>
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2
>.6.11-rc4-mm1/broken-out/sort-fix.patch

Okay, I didn't notice the off-by-one fix. It's still broken though; see the 
attached user-space test.

> I've since tested all sizes 1 - 1000 with 100 random arrays each, so
> I'm fairly confident it's now fixed.

Famous last words ;)

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

--Boundary-00=_TFkICpe8pI8mThl
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="sort.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sort.c"

/*
 * A fast, small, non-recursive O(nlog n) sort for the Linux kernel
 *
 * Jan 23 2005  Matt Mackall <mpm@selenic.com>
 */

#include <stdlib.h>
#include <stdio.h>

void generic_swap(void *a, void *b, int size)
{
	char t;

	do {
		t = *(char *)a;
		*(char *)a++ = *(char *)b;
		*(char *)b++ = t;
	} while (--size > 0);
}

/*
 * sort - sort an array of elements
 * @base: pointer to data to sort
 * @num: number of elements
 * @size: size of each element
 * @cmp: pointer to comparison function
 * @swap: pointer to swap function or NULL
 *
 * This function does a heapsort on the given array. You may provide a
 * swap function optimized to your element type.
 *
 * Sorting time is O(n log n) both on average and worst-case. While
 * qsort is about 20% faster on average, it suffers from exploitable
 * O(n*n) worst-case behavior and extra memory requirements that make
 * it less suitable for kernel use.
 */

void sort(void *base, size_t num, size_t size,
	  int (*cmp)(const void *, const void *),
	  void (*swap)(void *, void *, int size))
{
	/* pre-scale counters for performance */
	int i = (num/2) * size, n = num * size, c, r;

	if (!swap)
		swap = generic_swap;

	/* heapify */
	for ( ; i >= 0; i -= size) {
		for (r = i; r * 2 < n; r  = c) {
			c = r * 2;
			if (c < n - size && cmp(base + c, base + c + size) < 0)
				c += size;
			if (cmp(base + r, base + c) >= 0)
				break;
			swap(base + r, base + c, size);
		}
	}

	/* sort */
	for (i = n - size; i >= 0; i -= size) {
		swap(base, base + i, size);
		for (r = 0; r * 2 < i; r = c) {
			c = r * 2;
			if (c < i - size && cmp(base + c, base + c + size) < 0)
				c += size;
			if (cmp(base + r, base + c) >= 0)
				break;
			swap(base + r, base + c, size);
		}
	}
}

int cmp(const int *a, const int *b)
{
	return b - a;
}

int main(void)
{
	int a[] = { 1, 2, 3, 4, 5 };
	size_t n;

	for (n = 0; n < sizeof(a)/sizeof(a[0]); n++)
		printf("%d ", a[n]);
	puts("");
	sort(a, sizeof(a)/sizeof(a[0]), sizeof(a[0]),
	     (int (*)(const void *, const void *))cmp, NULL);
	for (n = 0; n < sizeof(a)/sizeof(a[0]); n++)
		printf("%d ", a[n]);
	puts("");

	return 0;
}

--Boundary-00=_TFkICpe8pI8mThl--
