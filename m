Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317714AbSFLOxU>; Wed, 12 Jun 2002 10:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317716AbSFLOxT>; Wed, 12 Jun 2002 10:53:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:57984 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S317714AbSFLOxS>; Wed, 12 Jun 2002 10:53:18 -0400
Date: Wed, 12 Jun 2002 15:52:34 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
In-Reply-To: <3D06FEA9.AB40CC79@zip.com.au>
Message-ID: <Pine.LNX.4.21.0206121455560.1032-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, Andrew Morton wrote:
> 
> A more serious form of data loss occurs when an application has a shared
> mapping over a sparse file.  If the filesystem is out of space when
> the VM decides to write back some pages, your data simply gets dropped
> on the floor.  Even a subsequent msync() won't tell you that you have
> a shiny new bunch of zeroes in your file.
> 
> It's not simple to fix.  Approaches might be:
> 
> 1: Map the page to disk at fault time, generate SIGBUS on
>    ENOSPC  (the standards don't seem to address this issue, and
>    this is a non-standard overload of SIGBUS).

I've looked at this issue in the past: it's a familiar problem
for various filesystems on various flavours of UNIX.  Some of the
strangeness in tmpfs (shmem_recalc_inode, or ac's shmem_removepage)
can be traced to this issue, I believe.  The filesystem does not
know when a clean page is dirtied, and somehow has to cope afterwards.

I believe your option 1 is closest to the right direction; and SIGBUS
is entirely appropriate, I don't see it as a non-standard overload.

But you didn't spell out the worst news on that option: read faults
into a read-only shared mapping of a file which the application had
open for read-write when it mmapped: the page must be mapped to disk
at read fault time (because the mapping just might be mprotected for
read-write later on, and the page then dirtied).

Most apps would have opened the file read-only anyway, and no
problem then.  Perhaps it's acceptable to penalize those that don't;
but it does seem distasteful to have to desparsify a file when
accessing it through a read-only mapping.

What I wanted was a "wppage" method (I seem to recall stealing the
name from a different now defunct method) in vm_operations_struct:
int (*wppage)(struct vm_area_struct * area, struct page * page, int write_now);

This was called by do_no_page after calling FS nopage, when mapping
shared writable, the write_now flag true if write fault.  If write_now,
FS wppage would return success if page already backed, or hole now backed,
and do_no_page would give write permission to the pte, failure SIGBUS;
if not write_now, FS wppage could decide for itself whether to back
hole now (success) or defer (failure, no SIGBUS, but write permission
withheld from pte).  Code in do_wp_page to call FS wppage again if
shared mapping, to allocate if deferred.  Code in mprotect_fixup to
withhold write permission from shared mapping if FS has wppage method.

Hugh

