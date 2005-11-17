Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVKQV3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVKQV3T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 16:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbVKQV3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 16:29:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21689 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751335AbVKQV3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 16:29:17 -0500
Date: Thu, 17 Nov 2005 13:29:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: sct@redhat.com, dhowells@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility
Message-Id: <20051117132926.31c09d71.akpm@osdl.org>
In-Reply-To: <4204.1132255682@warthog.cambridge.redhat.com>
References: <20051116035639.3eaa7a35.akpm@osdl.org>
	<20051115112504.4b645a86.akpm@osdl.org>
	<20051114150347.1188499e.akpm@osdl.org>
	<dhowells1132005277@warthog.cambridge.redhat.com>
	<Pine.LNX.4.64.0511141428390.3263@g5.osdl.org>
	<11717.1132077542@warthog.cambridge.redhat.com>
	<1932.1132140406@warthog.cambridge.redhat.com>
	<4204.1132255682@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > > That's the third time you've asked:-)
> > 
> > Maybe on the fourth or fifth time it'll occur you to put it into the
> > changelog.
> 
> But that's not what's changed.

It's an FAQ and it's an obvious shortcoming of the entire proposal.  It
should be covered in the overall description.

> > OK, it's doing submit_bio() directly.
> 
> Using a big fixed-sized file also means that you've got two layout managers
> and two transaction managers and two metadata managers on top of each other.

That's a choice users can make.  Right now, they'll use loopback, which is
worse.  But perhaps acceptably.

> > > This facility isn't well advanced yet, and will initially only be
> > > available on EXT2/3. It will also require a userspace component to clean
> > > up dead nodes.
> > 
> > I'd have thought that a decent intermediate step would be
> > cache-on-single-file using a_ops.direct_IO, as you're implying above.
> 
> That's really the worst of both worlds. If you can access files, then you're
> best of doing so on a one cache-file per netfs-file basis, *if* you can get
> notification of completion on an asynchronous operation.
> 
> If you try to do this, the caching backend will try to lay the blocks out in
> a manner that will then be undone because the underlying filesystem will then
> put the blocks or parts thereof where *it* wishes.

The same will happen with a loopback mount, no?

> Furthermore, it would seem that whilst undertaking direct I/O on an inode,
> that inode is locked against other direct I/O operations. This could end up
> serialising all I/O operations on the cache (see dio_complete() in
> fs/direct-io.c).

No, direct-io has (almost) complete parallelism for readers and writers. 
We use locking in there to protect certain filesystem metadata operations
but the locks can be dropped prior to performing the bulk IO.


> > Then all the direct-to-blockdev code can go away.  It'll take some tweaking
> > of the core direct-io code, but nothing terribly serious.
> 
> The direct-to-blockdev code should get you better performance than going
> through a single file on a filesystem: with your suggestion, you end up adding
> the latency of the cache-to-single-file to that of the underlying filesystem.

hmm?  direct-io to a file is only a few percent slower than direct-io to
blockdev iirc.

> 
> There are five main problems that need solving for cachefiles that I can see:
> 
>  (1) Reading of holes must return ENODATA or a short write. I have a patch to
>      do this for O_DIRECT (attached).

Should we be exposing O_NOREADHOLE to userspace like this?

>  (2) It must be possible to do O_DIRECT reads/writes directly to/from kernel
>      pages. This may possible without modification, but I'm not certain of
>      that; looking at dio_refill_pages() it may not be - that accesses the
>      current->mm to get more pages.

No, we'll need to modify direct-io.

My suggestion would be to modify address_space_operations.direct_IO so that
it no longer takes a zillion arguments - instead, pass in a new `struct
direct_io_cb' thing which has all the args, pass that up and down the
stack.

Within blockdev_direct_IO, stick that direct_io_cb* into struct dio.

Add sufficient fields in direct_io_cb so that dio_refill_pages() can
populate dio->pages with kernel pages rather than using get_user_pages(),
if it was called for in-kernel direct-io.

>  (3) It must be possible to do these reads and writes asynchronously and to
>      get notification of their completion. I'm not sure how easy this is, but
>      it looks like it should be possible, perhaps using a kiocb. The routines
>      in fs/direct-io.c don't seem to be able to do asynchronicity, except
>      through AIO.

Harder.  Yes, perhaps we could use AIO infrastructure.

>  (4) It must be possible to maintain structural integrity in the cache. This
>      should be possible simply be relying on the underlying filesystem.
> 
>  (5) It must be possible to maintain a certain level of data integrity in the
>      cache. We really don't want to have to blow the entire cache away if the
>      power goes out or the cache isn't laid to rest correctly.
> 
> It may end up being necessary to have a parallel to fs/direct-io.c for doing
> I/O asynchronously to/from kernel pages.
> 
> Also, fs/direct-io.c seems to assume the filesystem on which it's running uses
> buffer_heads - but not all of them do.

Nope, buffer_heads are only in there because it happens to be the container
in which the get_block[s]() callback returns the file offset -> block
number mapping information.

