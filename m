Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWDUOuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWDUOuS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 10:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWDUOuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 10:50:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12249 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932318AbWDUOuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 10:50:16 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060420181616.0f167b1d.akpm@osdl.org> 
References: <20060420181616.0f167b1d.akpm@osdl.org>  <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165941.9968.13602.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       sct@redhat.com, aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] FS-Cache: CacheFiles: A cache that backs onto a mounted filesystem 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 21 Apr 2006 15:49:57 +0100
Message-ID: <24065.1145630997@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > +unsigned long cachefiles_debug = 0;
> 
> Unneeded initialisation.

Yep.

> > +static int cachefiles_init(void)
> 
> __init?

Yep.

> removeable?

Yep.

> hm, what's going on here?  It's strange for a callee to undo an i_mutex
> which some caller took.

It happens occasionally.  The problem here is that I want to call this from
three different places, but if I drop the mutex before calling the burial
function, I have to get the mutex again to do the unlink; but as it is, I have
to drop it before I can do the rename:-/

It's not nice, but...

You have to note also that the directory's i_mutex is quite important for
interacting with the daemon also.  The wonders of working through an existing
filesystem, and the the wonders of co-operating with userspace.

> > +int
> > +generic_file_buffered_write_one_kernel_page(struct file *file,
> > +					    pgoff_t index,
> > +					    struct page *src)
> 
> Some covering comments would be nice.

I copied those of generic_file_buffered_write() and rearranged them a bit:-)

I'll add a comment to my function.

> If the hosts's i_mutex is held (it should be, but there are no comments)
> then we can read inode->i_size directly.  Minor thing.

Ah.  Do we though?  I just copied generic_file_buffered_write() and cut it
down.  The same is done there.  The comments at the top of that function
weren't exactly forthcoming on the preconditions for calling that function.

> that's copy_highpage().

Good point.

> Sigh.  It's all a huge pile of new code.  And it's only used by AFS, the
> number of users of which can be counted on the fingers of one foot.  An NFS
> implementation would make a testing phase much more useful.

Yes...  Whilst I have it working with NFS, the NFS anti-aliasing problems are
still there and still need to be sorted.  I thought I'd got them nailed, but
then Trond changed his mind:-(

But that does not preclude putting what I can release up for review.

David
