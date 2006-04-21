Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWDUK5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWDUK5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 06:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWDUK5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 06:57:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932239AbWDUK5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 06:57:36 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060420171118.119ddb4e.akpm@osdl.org> 
References: <20060420171118.119ddb4e.akpm@osdl.org>  <20060420171857.GA21659@infradead.org> <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> <20060420165932.9968.40376.stgit@warthog.cambridge.redhat.com> <22114.1145556402@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, hch@infradead.org, torvalds@osdl.org,
       steved@redhat.com, sct@redhat.com, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] FS-Cache: Avoid ENFILE checking for kernel-specific open files 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 21 Apr 2006 11:57:09 +0100
Message-ID: <31581.1145617029@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> That would seem to be a great shortcoming in fscache.

It's not something that's easy to get around.  The file has to be "open" to be
able to do certain operations on it.

> I guess as memory reclaim reaps the top-level dentries those file*'s will
> also be freed up, leading to their dentries becoming reclaimable, leading
> to their inodes being reclaimable.

Exactly.

> But still.  Is it not possible to release those files-pinned-by-dcache when
> the top-level files are closed?

No, for three (or maybe four) reasons:

 (1) You assume there's a "top-level" file open.  AFS lookup(), for example,
     will read the cache to get the directory contents, but there will _not_
     be an open top-level file.

     We could open and close the cache file in each lookup(), but that could
     be very bad for lookup performance.

 (2) mmap() may still have the struct file open, even though the last close()
     has happened.

 (3) There may be pages not yet written to the cache outstanding.  These
     belong to the netfs *inode* not the netfs *file*.  Whilst the flush or
     release file operation could be made to wait for these, that's not
     necessarily within their spec, and could take a long time.  How far is
     the flush op supposed to go anyway?

 (4) It prevents the data file going away whilst we have a cookie for it
     (someone might go into the cache and delete something they shouldn't).

     Pinning the dentry might work just as well, I suppose, but it makes
     little difference to the resource consumption.

     We keep at least the dentry available so that we can honour the netfs's
     requests to update the auxiliary data as quickly as possible.

David
