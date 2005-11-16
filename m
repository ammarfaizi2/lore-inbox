Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbVKPL5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbVKPL5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 06:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbVKPL5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 06:57:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9120 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030281AbVKPL5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 06:57:11 -0500
Date: Wed, 16 Nov 2005 03:56:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
       nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
Message-Id: <20051116035639.3eaa7a35.akpm@osdl.org>
In-Reply-To: <1932.1132140406@warthog.cambridge.redhat.com>
References: <20051115112504.4b645a86.akpm@osdl.org>
	<20051114150347.1188499e.akpm@osdl.org>
	<dhowells1132005277@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
	<11717.1132077542@warthog.cambridge.redhat.com>
	<1932.1132140406@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > > What I'm trying to do is actually fairly simple in concept:
> > > 
> > >   (1) Have a metadata inode (imeta) that covers the block device.
> > > 
> > 
> > Can you remind me again why it requires a blockdev rather than a regular file?
> 
> That's the third time you've asked:-)

Maybe on the fourth or fifth time it'll occur you to put it into the
changelog.

> ...
> Look also at Documentation/filesystem/caching/fscache.txt provided by patch
> 9/12 for the constraints I've set, in particular:
> 
>  (1) It must be practical to operate without a cache.
> 
>  (2) The size of any accessible file must not be limited to the size of the
>      cache.
> 
>  (3) The combined size of all opened files (this includes mapped libraries)
>      must not be limited to the size of the cache.
> 
>  (4) The user should not be forced to download an entire file just to do a
>      one-off access of a small portion of it (such as might be done with the
>      "file" program).
> 
> To which I wish to add:
> 
>  (5) The netfs pages must remain owned by the netfs, so that there is no
>      difference between the netfs operating with a cache and it operating
>      without a cache. This means I/O must be done to/from the netfs pages
>      directly from/to the cache.

None of that appears to be relevant.

A blockdev is just a big, fixed-sized file.  Why cannot it be backed by a
big, fixed-sized file?

<looks>

OK, it's doing submit_bio() directly.

> 
> I have a start of a cache-on-files facility (called, most imaginatively,
> CacheFiles) which works as another backend to FS-Cache. Of the underlying
> filesystem, it requires:
> 
>  (*) O_DIRECT
> 
>  (*) Reads and writes on arbitrary kernel pages
> 
>  (*) Reads on holes must return short or ENODATA. This requires an extra
>      O_XXXX flag to be supplied when opening a file or the struct file or
>      inode to be flagged appropriately.
> 
>  (*) The ability to issue FS operations such as rename, open, setxattr, mkdir
>      from kernel space.
> 
> This facility isn't well advanced yet, and will initially only be available on
> EXT2/3. It will also require a userspace component to clean up dead nodes.

I'd have thought that a decent intermediate step would be
cache-on-single-file using a_ops.direct_IO, as you're implying above.  Then
all the direct-to-blockdev code can go away.  It'll take some tweaking of
the core direct-io code, but nothing terribly serious.

> 
> Are you willing to at least carry the FS-Cache core and the AFS usage of it?
>

fs-cache won't do anything without a backing store such as cachefs will it?

Those names are rather confusing, btw.

