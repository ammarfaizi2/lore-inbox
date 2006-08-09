Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWHIWRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWHIWRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 18:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWHIWRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 18:17:43 -0400
Received: from pat.uio.no ([129.240.10.4]:50411 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751295AbWHIWRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 18:17:42 -0400
Subject: Re: [RFC] Privilege escalation in filesystems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       ezk@cs.sunysb.edu, dquigley@ic.sunysb.edu, dpquigl@tycho.nsa.gov
In-Reply-To: <20060809215200.GB1882@filer.fsl.cs.sunysb.edu>
References: <20060809215200.GB1882@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 18:17:32 -0400
Message-Id: <1155161852.15624.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.188, required 12,
	autolearn=disabled, AWL 0.30, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 17:52 -0400, Josef Sipek wrote:
> While going though the Unionfs code, Chris Wedgwood commented that it might
> make sense to ask the list about temporary privilege escalation in file
> systems.
> 
> Much like NFS, at times Unionfs has to perform operations as another user.
> (See below for details as to when and why this has to happen.)
> 
> I'd like to know what the preferred way of doing that is. I noticed that NFS
> does a simple assignment:
> 
> (fs/nfs/nfs4recover.c:nfs4_save_user)
> current->fsuid = 0;
> current->fsgid = 0;

This sort of thing can be defeated by selinux. The right way to perform
privileged operations is normally to give the task to a kernel thread
that has the required privileges (for instance a work_queue like
keventd).

> Should the capabilities be set/dropped as well? Would it be worth it to
> provide some kind of generic way of accomplishing this having file system
> messing with current directly?
> 
> 
> Unionfs specific details:
> -------------------------
> 
> Namespace unification requires that there is a way to mark a directory
> "opaque" - meaning that lookup/readdir should not merge the objects of this
> directory with those of a directory of a lower priority. When one creates a
> new, empty directory using mkdir(2), the new directory should be empty
> according to POSIX/UNIX. To prevent contents of directories on lower
> priority branches from appearing in this newly created directory, the
> directory is made opaque.
> 
> Suppose we have a union of /mnt/a and /mnt/b that are initially empty. Then
> we perform the following steps:
> 
> $ cd /union
> $ mkdir foo
> $ find /union
> /union/
> /union/foo/
> $ find /mnt/
> /mnt/
> /mnt/a/
> /mnt/a/foo/
> /mnt/a/foo/.wh.__dir_opaque
> /mnt/b/
> 
> The .wh.__dir_opaque informs our implementation of Unionfs that the
> directory is opaque.
> 
> The privilege problem appears when we try to remove the directory foo. If
> we have write permission to /union, we should be able to remove any file or
> (empty) directory. In the above example, /union/foo is empty.
> If the foo is owned by someone else and we don't have write permission to
> it, we'll fail to remove the opaque whiteout from foo (.wh.__dir_opaque),
> which would in turn prevent us from removing foo itself. If we become a
> superuser temporarily, we can remove the whiteout as well as the directory,
> and all is well.

Ugh. Having the kernel interpret magic directory entries is just evil.
Having the kernel magically create and remove said entries on behalf of
the user ought to be punishable by death.

Why can't you use something like an xattr to label opaqueness (or
visibility!) instead?

Cheers,
  Trond

