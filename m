Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVAaTeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVAaTeh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVAaTcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:32:50 -0500
Received: from waste.org ([216.27.176.166]:1933 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261327AbVAaTam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:30:42 -0500
Date: Mon, 31 Jan 2005 11:30:32 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
Message-ID: <20050131193032.GR2891@waste.org>
References: <2.416337461@selenic.com> <1107191783.21706.124.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107191783.21706.124.camel@winden.suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 06:16:23PM +0100, Andreas Gruenbacher wrote:
> Hello,
> 
> On Mon, 2005-01-31 at 08:34, Matt Mackall wrote:
> > This patch adds a generic array sorting library routine. This is meant
> > to replace qsort, which has two problem areas for kernel use.
> 
> looks reasonable.
> 
> > Note that this function has an extra parameter for passing in an
> > optimized swapping function. This is worth 10% or more over the
> > typical byte-by-byte exchange functions.
> 
> I would appreciate a version without the swap callback.

Why? To eliminate an argument?

> The optimized version of swap should use the machine word size
> instead of u32.

That occurred to me, but most instances I found in my audit were using
u32 rather than long.

> How about this approach instead, if you think we
> must really optimize swapping?
>
> static inline void swap(void *a, void *b, int size)
> {
>         if (size % sizeof(long)) {
>                 char t;
>                 do {
>                         t = *(char *)a;
>                         *(char *)a++ = *(char *)b;
>                         *(char *)b++ = t;
>                 } while (--size > 0);
>         } else {
>                 long t;
>                 do {
>                         t = *(long *)a;
>                         *(long *)a = *(long *)b;
>                         *(long *)b = t;
>                         size -= sizeof(long);
>                 } while (size > sizeof(long));
>         }
> }

This makes things worse. Sort isn't inlined, so we don't know size
until we're called and then we're branching in the innermost loop and
growing the code footprint to boot. Function pointer wins in my
benchmarks.

Note that there are callers like IA64 extable that want a custom swap already:

- * stack may be more than 2GB away from the exception-table).
+ * Sort the exception table. It's usually already sorted, but there
+ * may be unordered entries due to multiple text sections (such as the
+ * .init text section). Note that the exception-table-entries contain
+ * location-relative addresses, which requires a bit of care during
+ * sorting to avoid overflows in the offset members (e.g., it would
+ * not be safe to make a temporary copy of an exception-table entry on
+ * the stack, because the stack may be more than 2GB away from the
+ * exception-table).
  */

There are a bunch of other potential users that sort parallel arrays
a[] and b[] with keys in a[] that want this too.

-- 
Mathematics is the supreme nostalgia of our time.
