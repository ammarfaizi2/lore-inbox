Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWBAOip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWBAOip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWBAOip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:38:45 -0500
Received: from mail.shareable.org ([81.29.64.88]:58017 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S932454AbWBAOio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:38:44 -0500
Date: Wed, 1 Feb 2006 14:38:40 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060201143840.GA19134@mail.shareable.org>
References: <200602011658.10418.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602011658.10418.a1426z@gawab.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> > Presumably you will want access to more data than you have RAM,
> > because RAM is still limited to a few GB these days, whereas a typical
> > personal data store is a few 100s of GB.
> >
> > 64-bit architecture doesn't change this mismatch.  So how do you
> > propose to avoid swapping to/from a disk, with all the time delays and
> > I/O scheduling algorithms that needs?
> 
> This is exactly what a linear-mapped memory model avoids.
> Everything is already mapped into memory/disk.

Having everything mapped to memory/disk *does not* avoid time delays
and I/O scheduling.  At some level, whether it's software or hardware,
something has to schedule the I/O to disk because there isn't enough RAM.

How do you propose to avoid those delays?

In my terminology, I/O of pages between disk and memory is called
swapping.  (Or paging, or loading, or virtual memory I/O...)

Perhaps you have a different terminology?

> Would you call reading and writing to memory/disk swapping?

Yes, if it involves the disk and heuristic paging decisions.  Whether
that's handled by software or hardware.

> > Applications don't currently care if they are swapped to disk or in
> > physical memory.  That is handled by the OS and is transparent to the
> > application.
> 
> Yes, a linear-mapped memory model extends this transparency to the OS.

Yes, that is possible.  It's slow in practice because that
transparency comes at the cost of page faults (when the OS accesses
that linear-mapped memory), which is slow on the kinds of CPU we are
talking about - i.e. commodity 64-bit chips.

> > > If you didn't understand it's meaning.  The shortest path meaning
> > > accessing hw w/o running workarounds; using 64bits+ to fly over past
> > > limitations.
> >
> > THe OS still has to map the address space to where it physically exists.
> > Mapping all disk space into the address space may actually be a lot less
> > efficient than using the filesystem interface for a block device.
> 
> Did you try tmpfs?

Actually, mmap() to read a tmpfs file can be slower than just calling
read(), for some access patterns.  It's because page faults, which are
used to map the file, can be slower than copying data.  However,
copying uses more memory.  Today we leave it to the application to
decide which method to use.

> > If so, then it actually makes *less* sense to me than before -- with
> > your scheme, you've reduced the speed of main memory by 100x or more,
> > then you try to compensate with a huge cache. IOW, you've reduced the
> > speed of *main* memory to (more or less) the speed of today's swap!
> > Suddenly it doesn't sound so good anymore...
> 
> There really isn't anything new here; we do swap and access the fs on disk 
> and compensate with a huge dcache now.  All this idea implies, is to remove 
> certain barriers that could not be easily passed before, thus move swap and 
> fs into main memory.
> 
> Can you see how removing barriers would aid performance?

I suspect that, despite possibly simplifying code, removing those
barriers would make it run slower.

If I understand your scheme, you're suggesting the kernel accesses
disks, filesystems, etc. by simply reading and writing somewhere in
the 64-bit address space.

At some level, that will involve page faults to move data between RAM and disk.

Those page faults are relatively slow - governed by the CPU's page
fault mechanism.  Probably slower than what the kernel does now:
testing flags and indirecting through "struct page *".

However, do feel free to try out your idea.  If it is actually notably
faster, or if it makes no difference to speed but makes a lot of code
simpler, well then surely it will be interesting.

-- Jamie
