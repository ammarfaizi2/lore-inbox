Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbTHVWsf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbTHVWsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:48:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30132 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261513AbTHVWsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:48:32 -0400
Date: Fri, 22 Aug 2003 15:41:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: hugh@veritas.com, willy@debian.org, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org, drepper@redhat.com
Subject: Re: [parisc-linux] Re: Problems with kernel mmap (failing
 tst-mmap-eofsync in glibc on parisc)
Message-Id: <20030822154100.06314c8e.davem@redhat.com>
In-Reply-To: <1061591255.1784.636.camel@mulgrave>
References: <20030822110144.5f7b83c5.davem@redhat.com>
	<Pine.LNX.4.44.0308221926060.2200-100000@localhost.localdomain>
	<20030822113106.0503a665.davem@redhat.com>
	<1061578568.2053.313.camel@mulgrave>
	<20030822121955.619a14eb.davem@redhat.com>
	<1061591255.1784.636.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Aug 2003 17:27:33 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> Yes, the issue seems to be that the flush_dcache_page() was implemented
> with the thought that the caches of the shared mappings may contain
> modified data that needs to be flushed to the aliased page.
> 
> The opposite property: that the caches of the aliased page need to be
> invalidated because someone else changed data in the aliased page seems
> to work as a byproduct of the above implementation.
> 
> But some of the checks for !list_empty(&mapping->i_shared) are going to
> prevent the necessary invalidations on read only shared mappings...which
> was the initial problem.

The theory of operation is that there are two "classes" of mappings
for a page, the implicit kernel mapping and all user mappings.  The
goal is to flush out one class from the cache when the other one writes
to such a page.

When a write() system call occurs, the kernel "class" is writing to
the page so all user mappings (shared or not!) need to be flushed
out.

When a read() system call occurs, and shared+writable mmap()'s of
the page exist, we must flush the user mapping "class" before the
kernel "class" tries to read from that page.

You cannot avoid doing things exactly as I've just described without
allowing bad aliases to be in the cache and corrupt data.

Your test case is essentially, annotated with what the kernel
should do at each step:

	static const char *test1 = "Line the first\n";
	static const char *test2 = "Line the second\n";

	temp_fd = open(O_RDWR);
	write(temp_fd, test1, sizeof test1 - 1);

No mmaps of this page, so no flush_dcache_page() call.

 ...
	fd = open(O_RDONLY);
	p = mmap(fd, ... PROT_READ ...);

Not writable, not added to i_mmap_shared list, instead it is
added to normal i_mmap list.

	memcpy(tmp_buf, p, sizeof test1 - 1);
	p += sizeof test1 - 1;
	if (strcmp(tmp_buf, test1))
		BUG();
	...
	write(temp_fd, test2, sizeof test2 - 1);

Mmaps of this page exist, flush_dcache_page() call is made.

	memcpy(tmp_buf, p, sizeof test2 - 1);
	if (strcmp(tmp_buf, test2))
		BUG();

And thus memcpy() sees correct data.

I think on parisc you are trying to avoid the write() case
of the cache flush for non-shared mmap()s, and sorry you
really can't do this, again this is:

	When a write() system call occurs, the kernel "class" is writing to
	the page so all user mappings (shared or not!) need to be flushed
	out.

If your flush_dcache_page() is not doing this, it's no wonder
the test case fails for you.
