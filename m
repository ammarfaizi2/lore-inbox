Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVBARue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVBARue (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVBARue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:50:34 -0500
Received: from mail.suse.de ([195.135.220.2]:45445 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262083AbVBARuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:50:01 -0500
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
From: Andreas Gruenbacher <agruen@suse.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050131193032.GR2891@waste.org>
References: <2.416337461@selenic.com>
	 <1107191783.21706.124.camel@winden.suse.de>
	 <20050131193032.GR2891@waste.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1107280199.12050.113.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 01 Feb 2005 18:50:00 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 20:30, Matt Mackall wrote:
> On Mon, Jan 31, 2005 at 06:16:23PM +0100, Andreas Gruenbacher wrote:
> > Hello,
> > 
> > On Mon, 2005-01-31 at 08:34, Matt Mackall wrote:
> > > This patch adds a generic array sorting library routine. This is meant
> > > to replace qsort, which has two problem areas for kernel use.
> > 
> > looks reasonable.
> > 
> > > Note that this function has an extra parameter for passing in an
> > > optimized swapping function. This is worth 10% or more over the
> > > typical byte-by-byte exchange functions.
> > 
> > I would appreciate a version without the swap callback.
> 
> Why? To eliminate an argument?

Yes, because a custom swap routine isn't very useful generally. It's
over-engineered IMHO.

> > The optimized version of swap should use the machine word size
> > instead of u32.
> 
> That occurred to me, but most instances I found in my audit were using
> u32 rather than long.

Alright, that may be the case.

> > How about this approach instead, if you think we
> > must really optimize swapping?
> >
> > static inline void swap(void *a, void *b, int size)
> > {
> >         if (size % sizeof(long)) {
> >                 char t;
> >                 do {
> >                         t = *(char *)a;
> >                         *(char *)a++ = *(char *)b;
> >                         *(char *)b++ = t;
> >                 } while (--size > 0);
> >         } else {
> >                 long t;
> >                 do {
> >                         t = *(long *)a;
> >                         *(long *)a = *(long *)b;
> >                         *(long *)b = t;
> >                         size -= sizeof(long);
> >                 } while (size > sizeof(long));
> >         }
> > }
> 
> This makes things worse. Sort isn't inlined, so we don't know size
> until we're called and then we're branching in the innermost loop

Well, the example code I referred to had an inlined __sort, and the size
== sizeof(long) case ended up being perfectly optimized. It bloats the
code somewhat though, but it's still tiny.

> and growing the code footprint to boot.

You mean the object footprint? I don't care much whether we use some 350
bytes more or not.

> Function pointer wins in my benchmarks.

I had a slowdown in the low percentage range when doing bytewise swap
instead of wordwise swap as well, but function pointers were about as
fast as wordwise swap. So no significant gain.

> Note that there are callers like IA64 extable that want a custom swap already:
> 
> - * stack may be more than 2GB away from the exception-table).
> + * Sort the exception table. It's usually already sorted, but there
> + * may be unordered entries due to multiple text sections (such as the
> + * .init text section). Note that the exception-table-entries contain
> + * location-relative addresses, which requires a bit of care during
> + * sorting to avoid overflows in the offset members (e.g., it would
> + * not be safe to make a temporary copy of an exception-table entry on
> + * the stack, because the stack may be more than 2GB away from the
> + * exception-table).
>   */

We could either leave the current insertion sort in place in
arch/ia64/mm/extable.c, or transform the exception table into sortable
form first, as in the below mock-up.

+       /* Exception-table-entries contain location-relative addresses. Convert
+          to addresses relative to START before sorting, and convert back to
+          location-relative addresses afterwards. This allows us to use the
+          general-purpose sort function. */
+       for (p = start+1; p < finish; p++) {
+               int n = (void *)p - (void *)start;
+               p->addr += n;
+               p->cont += n;
+       }
+       sort(start, finish - start, sizeof(struct exception_table_entry),
+            compare_entries);
+       for (p = start+1; p < finish; p++) {
+               int n = (void *)p - (void *)start;
+               p->addr -= n;
+               p->cont -= n;
+       }

Switching to the generic sort probably isn't worth it in this case.

> There are a bunch of other potential users that sort parallel arrays
> a[] and b[] with keys in a[] that want this too.

Where?

Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

