Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVAaRQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVAaRQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVAaRQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:16:44 -0500
Received: from cantor.suse.de ([195.135.220.2]:43658 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261253AbVAaRQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:16:24 -0500
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
From: Andreas Gruenbacher <agruen@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <2.416337461@selenic.com>
References: <2.416337461@selenic.com>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1107191783.21706.124.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 31 Jan 2005 18:16:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 2005-01-31 at 08:34, Matt Mackall wrote:
> This patch adds a generic array sorting library routine. This is meant
> to replace qsort, which has two problem areas for kernel use.

looks reasonable.

> Note that this function has an extra parameter for passing in an
> optimized swapping function. This is worth 10% or more over the
> typical byte-by-byte exchange functions.

I would appreciate a version without the swap callback. The optimized
version of swap should use the machine word size instead of u32. How
about this approach instead, if you think we must really optimize
swapping?

static inline void swap(void *a, void *b, int size)
{
        if (size % sizeof(long)) {
                char t;
                do {
                        t = *(char *)a;
                        *(char *)a++ = *(char *)b;
                        *(char *)b++ = t;
                } while (--size > 0);
        } else {
                long t;
                do {
                        t = *(long *)a;
                        *(long *)a = *(long *)b;
                        *(long *)b = t;
                        size -= sizeof(long);
                } while (size > sizeof(long));
        }
}

static inline
void __sort(void *base, size_t num, size_t size,
          int (*cmp)(const void *, const void *))
{
...
}

void sort(void *base, size_t num, size_t size,
          int (*cmp)(const void *, const void *)) {
        if (size == sizeof(long)) {
                __sort(base, num, size, cmp);
        } else {
                __sort(base, num, size, cmp);
        }
}

The code size doubles, but it's still hardly an issue. gcc will refuse
to inline things fully without __attribute((allways_inline)). (Note that
__builtin_constant_p doesn't work for inline functions; else we could do
better.)


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

