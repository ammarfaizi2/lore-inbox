Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTEFBQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 21:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTEFBQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 21:16:16 -0400
Received: from dp.samba.org ([66.70.73.150]:5329 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262225AbTEFBQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 21:16:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu 
In-reply-to: Your message of "Mon, 05 May 2003 01:47:29 MST."
             <20030505014729.5db76f70.akpm@digeo.com> 
Date: Tue, 06 May 2003 10:47:20 +1000
Message-Id: <20030506012846.18DD62C568@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030505014729.5db76f70.akpm@digeo.com> you write:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > This is the kmalloc_percpu patch.
> 
> How does it work?  What restrictions does it have, and
> what compromises were made?
> 
> +#define PERCPU_POOL_SIZE 32768
> 
> What's this?

OK.  It has a size restriction: PERCPU_POOL_SIZE is the maximum total
kmalloc_percpu + static DECLARE_PER_CPU you'll get, ever.  This is the
main downside.  It's allocated at boot.

The __alloc_percpu allocator is extremely space efficient, by not
insisting on cache-line aligning everything: __alloc_percpu(SIZE)
overhead is sizeof(int), plus SIZE bytes (rounded up to alignment
requirements) removed from per-cpu pool.

The allocator is fairly slow: they're not expected to be thrown around
like candy.

> The current implementation of kmalloc_per_cpu() turned out to be fairly
> disappointing because of the number of derefs which were necessary to get at
> the data in fastpaths.   How does this implementation compare?

It uses the same method as the static ones, so it's a single addition
of __per_cpu_offset (assuming arch doesn't override implementation).
This is a requirement for modules to use them (which was my aim: the
other side effects are cream).

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
