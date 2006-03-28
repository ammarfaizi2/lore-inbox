Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWC1QBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWC1QBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWC1QBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:01:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12681 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751131AbWC1QBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:01:14 -0500
Subject: Re: eCryptfs Design Document
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, phillip@hellewell.homeip.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mcthomps@us.ibm.com,
       yoder1@us.ibm.com, toml@us.ibm.com, emilyr@us.ibm.com,
       daw@cs.berkeley.edu, sfrench@us.ibm.com,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20060327233111.GH4541@us.ibm.com>
References: <20060324222517.GA13688@us.ibm.com>
	 <20060324154920.11561533.akpm@osdl.org> <20060325001345.GC13688@us.ibm.com>
	 <20060324163358.557ac5f7.akpm@osdl.org>  <20060327233111.GH4541@us.ibm.com>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 11:00:56 -0500
Message-Id: <1143561657.3356.24.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2006-03-27 at 17:31 -0600, Michael Halcrow wrote:

> So let's say that locking eCryptfs files to only be accessible on
> machines with the same page size as the machine on which the files
> were created is unacceptable.

Agreed.

> We will be
> changing that so that eCryptfs works on extent-based regions of 4096
> bytes, as Andrew Morton suggested.
...
> In the current release, changing eCryptfs to operate in terms of
> fixed-size (4096-byte) extents will cause page reads and writes in
> eCryptfs to ``straddle'' pages in the lower filesystem if the first
> extent contains the header. 

Right, that's undesirable from a performance point of view.

> For instance, if eCryptfs writes
> page 0 out to disk, and then a crash occurs, then the data will be
> left in an inconsistent state.

Sorry, but you have to deal with that anyway.  There is no guarantee
that a page write is atomic.

On an ext2/3 filesystem with 1k blocksize, for example, it can take 4
separate writes to 4 different, potentially discontiguous disk blocks to
perform that page write.  Some storage may be doing transparent
bad-block relocation at the sector level.  And your partition may be
oddly aligned with the tracks on disk, causing a 4k write to span
tracks.  Many of these effects can be worked around with care, but the
default assumption must be that 4k writes are not guaranteed to be
atomic wrt crashes.

ext3 in its default "ordered" journaling mode does give you the
guarantee that newly-allocated page writes (writes to holes, or appends)
are atomic, but that's a special case not guaranteed at the VFS level in
general; and even there, overwrites are not necessarily atomic.

Restricting eCryptfs to filesystems with a 4k or larger blocksize is
possible, although many filesystems (eg. XFS) are fundamentally sector-
and extent-based, and cannot provide such an allocation unit guarantee.
(Though I think XFS will give you 4k extents anyway unless and until it
gets so fragmented and full that there are no >4k free extents left.)
With a 4k fs blocksize, there may be no absolute guarantee of page write
atomicity, but it should be pretty rare that a page write gets
fractured.

> To achieve page alignment, one solution is to make the header consume
> as many extents as will occupy some notion of a ``largest supported
> page size.'' If we arbitrarily set that at, say, 64k, then every file
> in eCryptfs on a system with a page size of 4k will automatically
> consume at least 68k of space (64k header + 4k page), and eCryptfs
> still will have to straddle pages for systems with 128k or 256k page
> sizes (how may systems out there have page sizes >64k?).

If you make the underlying file sparse, you could move the data offset
all the way out to 4MB or more without penalty.  (It would make for
extra pain when doing backups with non-sparse-aware tools, though, or
when using non-sparse-capable filesystems; and it would bring down the
file size limit at which you get EFBIG on ext2/3 slightly.)

> Another solution is to write the ``header'' at the tail 4k of the
> file. Then we have to abandon the benefit of having an ``untouchable''
> first 4k region of the lower file. 

Would it be possible simply to shift metadata to a subdir, so file foo
has the header in .encfs/foo ?  That may be a performance cost you don't
want to bear, especially for small files, of course.  If the header can
be shrunk enough, xattrs might also be possible; although that has its
own problems, such as compatibility with NFS etc.

> Seeks past the end of the file to
> truncate to a larger size or to append data will blow away the header
> extent, and it will have to be re-written. When should that happen? On
> each and every truncate? 

On every one; and it would have to be done atomically to avoid
corrupting things.

> When the file is closed? If we choose the
> latter, then it is easy to lose your file forever if there is a system
> crash before the file is closed and the header can be re-written to
> its new location.

Right; nasty.  

> To complicate matters, in future versions, the header will need to
> take multiple extents, and so we have always been planning on
> eventually appending some header information at the end of the file
> anyway;

At that point, it definitely sounds attractive to start thinking about
an external file in a subdir for the metadata.  You need to keep the two
in sync, but in principle syncing data between two different parts of
different files is actually no harder than doing it in the same file,
simply because even within a file there are no guarantees against
reordering of writes.

> So we have several ways to proceed at this point, but before we run
> off and implement one of them, does anyone else out there have any
> insights?

It sounds like simply reserving the head 64k (or so) of the file for the
header will get rid of the short-term alignment problems for now, so for
development that's probably the easy way out.  But if you really
anticipate potentially unbounded growth of the key/layout metadata for a
file, then using a separate file for that may be easier than trying to
come up with a complex interleaved data/metadata format.

--Stephen


