Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266274AbUG0Gli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266274AbUG0Gli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 02:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266258AbUG0Gli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 02:41:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:6375 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266287AbUG0Gla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 02:41:30 -0400
Date: Mon, 26 Jul 2004 23:40:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Rutt <rutt.4+news@osu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clearing filesystem cache for I/O benchmarks
Message-Id: <20040726234005.597a94db.akpm@osdl.org>
In-Reply-To: <87pt6iq5u2.fsf@osu.edu>
References: <87vfgeuyf5.fsf@osu.edu>
	<20040726002524.2ade65c3.akpm@osdl.org>
	<87pt6iq5u2.fsf@osu.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Please don't remove people from the email recipient list when doing kernel
work.)

Benjamin Rutt <rutt.4+news@osu.edu> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Benjamin Rutt <rutt.4+news@osu.edu> wrote:
> >>
> >>  How can I purge all of the kernel's filesystem caches, so I can trust
> >>  that my I/O (read) requests I'm trying to benchmark bypass the kernel
> >>  filesystem cache?
> >
> > Either delete the benchmark test files or
> 
> I'm not sure I follow.  If I delete the benchmark files, I'll only
> need to create them again later in order to do a read test, and I'll
> have the same problem then, of how to eliminate the just-written-data
> from cache.

OK.

> Thanks for the reference, I wasn't aware of that one.  We are running
> some 2.4 kernels in our storage cluster unfortunately so that won't be
> usable for us everywhere.  I take it POSIX_FADV_DONTNEED is ignored
> under 2.4.

posix_fadvise() will return -ENOSYS under 2.4.

However...  If you write any amount of data to a file with O_DIRECT, that
will, as a side-effect, remove _all_ of that file's pagecache.  In 2.4 as
well as 2.6.  So you could scrub the pagecache by reading the first 4k then
writing it back with O_DIRECT.

However O_DIRECT is supported on very few filesystems in 2.4.  ext2 and
reiserfs have it.

XFS in 2.4 has O_DIRECT, I think, but I don't know if the invalidation
side-effect works on XFS.

> A related question...if no posix_fadvise() advice has been given, does
> reading sequentially every byte of an 8GB file on a machine with <=
> 8GB of RAM guarantee that any page cache data that existed on the
> machine prior to the start of the 8GB read is now gone?

It's not guaranteed that this will work - if the pages which you're trying
to evict were accessed multiple times then it may take more page
replacement to reliably shoot them down.  But writing a 2xmemory file and
then deleting it will be a reasonably effective way of evicting most of
the other pagecache.


