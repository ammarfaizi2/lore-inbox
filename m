Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUFAJhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUFAJhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFAJht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:37:49 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:54701 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264961AbUFAJhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:37:33 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'John Bradford'" <john@grabjohn.com>,
       "'Michael Brennan'" <mbrennan@ezrs.com>, <linux-kernel@vger.kernel.org>
Cc: <riel@redhat.com>
Subject: RE: why swap at all?
Date: Tue, 1 Jun 2004 02:38:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200405312029.i4VKTCZ0000596@81-2-122-30.bradfords.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRHTSJ+d00MPXkHSzG+qsumbGqwLAAZBCIQ
Message-Id: <S264961AbUFAJhd/20040601093733Z+1483@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not really sure what the above was intended to demonstrate, but 
> I assume that it was that having swap allowed the first grep to fill 
> physical RAM with
> cache at the expense of swapping other processes, which were 
> using physical RAM to disk.

> However, if 57 Mb of swap allows this, 57 Mb of extra physical RAM should
> also allow the grep to be cached, without having to swap out anything.

> Hence my comment about it not being a magical property of swap space.

> John.

Exactly! Swap will allow for room to evict anonymous pages (heap, stack,
shared memory, etc.) from memory to make room for other pages in memory.
Those pages could be file backed pages and therefore qualify as "pagecache".

When you read or write to/from a file at a given offset, the file operations
actually occur against memory.

Accessing an offset into the mapping of a file triggers a pagefault if a
page for that offset doesn't currently exist in memory. The point is, file
system I/O is actually achieved by accessing memory which triggers a major
pagefault (disk access) if the page doesn't already exist in memory. If the
page does already exist (minor fault) because the lookup of that
device,inode,offset succeeded, the already memory resident page is used
rather than incurring an I/O to disk.

This means if you grep thru the kernel tree, grep reads every line of every
file in the kernel tree trying to do pattern matching, every file in the
kernel tree is sitting in memory in it's entirety. Any subsequent reads of
those files are quite snappy since they are already memory resident (only
minor faults are incurred).

The above scenario where 57mb of swap allows for the entire kernel src tree
to be memory resident may provide tremendous value on a workstation or a
system with a small amount of disk I/O takes place, but it assumes that the
anonymous pages aren't going to be faulted right back in as soon as the
program that uses these pages becomes runnable again. It's not uncommon to
have a system where certain pages continually are paged in and out to/from
the swap device, simply because the system is very low on RAM, and
filesystem I/O is filling up physical memory at a rate that exceeds the
frequency that a process that is allocating anonymous memory becomes
runnable.

The problem is that any system doing enough constant filesystem I/O, with
enough data is eventually going to fill physical memory. This is not true
for anonymous memory. When I choose the amount of memory for a system, it is
first and foremost based on the resident set size of the application
processes. If I care about caching filesystem I/O, then all I have to do is
populate the system with enough "extra" physical RAM that files can be
cached in physical memory.

If I know in advance that filesystem I/O will eventually fill physical
memory with filesystem pages (pagecache), then why would I allow file system
I/O to force out anonymous pages on the system? Also, why wake up an
expensive algorithm (kswapd) that walks all pages in physical memory in
order to determine which pages are "Least Recently Used" on a system where
all resident set sizes of all processes add up to 100MB, and another 900MB
of physical RAM is full of filesystem backed pages?

On a server, where lots of I/O is taking place and you are willing to size
applications to fit completely within physical memory and add a little extra
for pagecache, I very much prefer the way that Solaris was modified to work
in Solaris 8 using a cyclical page cache.

The idea is "something" like this:

Filesystem backed pages are considered free memory. If you need to allocate
more anonymous memory, you just grab from (evict) the tail of a linked list
(called the cachelist) that represents the pagecache. If you update a page
or create a new page in the cachelist, then you simply move that page to the
head of the cachelist. This means there is always a small overhead in
maintaining the list, but nothing compared to the two-handed clock algorithm
that scans for pages to evict. The two-handed clock algorthim (the scanner)
is kept, but only when freemem falls to lotsfree. In Solaris 8, freemem is
the size of the cachelist + the size of free memory (pages that are not
pagecache and are free).

This way, filesystem I/O CANNOT cause the scanner to wake up and start
traversing main memory, eating up valuable CPU time. Also, anonymous pages
will not be evicted on systems due to lots of filesystem I/O. 

I won't try to imply that the Solaris 8 or later VM system outperforms the
Linux VM because I haven't compared the two, but I can attest that the
Solaris 8 VM beats the pants off the Solaris 7 VM system on systems where
large amounts of filesystem I/O take place.

You don't get the supposed "benefit" of evicting anonymous memory to swap in
order to cache filesystem pages, but quite frankly on a server, I would not
want this bug ... err, ... I mean ...  feature :) I would much rather size
my system such that applications fit in physical memory and if I so desire,
add a little extra for pagecache.

--Buddy



 

 








