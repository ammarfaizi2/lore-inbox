Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbTHTTwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTHTTwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:52:50 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:5128 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261940AbTHTTws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:52:48 -0400
Date: Wed, 20 Aug 2003 21:52:46 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andries Brouwer <aebr@win.tue.nl>, Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS regression in 2.6
Message-ID: <20030820215246.B3065@pclin040.win.tue.nl>
References: <3F4268C1.9040608@redhat.com> <shszni499e9.fsf@charged.uio.no> <20030820192409.A2868@pclin040.win.tue.nl> <16195.49464.935754.526386@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16195.49464.935754.526386@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Aug 20, 2003 at 11:43:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 11:43:04AM -0700, Trond Myklebust wrote:
> >>>>> " " == Andries Brouwer <aebr@win.tue.nl> writes:
> 
>      > I don't think it will. My analysis of yesterday night was:
>      > - no silly rename is done
>      > - this is because d_count equals 1
>      > - this is because we have two different dentries for the same
>      >   file
>      > - this is caused by the fragment
> 
>      >         /* If we're doing an exclusive create, optimize away
>      >         the lookup */ if (nfs_is_exclusive_create(dir, nd))
>      >                 return NULL;
> 
>      > in nfs/dir.c.  Do you agree?
> 
> No... The above snippet just short-circuits the process of doing an
> RPC call in order to look the file up on the *server*. Doing such a
> lookup would be wrong since it can race with a file creation on
> another NFS client.
> IOW the result of the above 2 lines should be the immediate creation
> of a negative dentry (i.e. one without an inode) that open_namei() can
> pass on to vfs_create().

It should be. But it isnt. I propose the following patch
(with whitespace damage):

diff -u --recursive --new-file -X /linux/dontdiff a/fs/nfs/dir.c b/fs/nfs/dir.c
--- a/fs/nfs/dir.c      Fri Jul 11 00:35:26 2003
+++ b/fs/nfs/dir.c      Wed Aug 20 22:38:42 2003
@@ -671,8 +671,10 @@
        dentry->d_op = &nfs_dentry_operations;
 
        /* If we're doing an exclusive create, optimize away the lookup */
-       if (nfs_is_exclusive_create(dir, nd))
+       if (nfs_is_exclusive_create(dir, nd)) {
+               d_add(dentry, NULL);
                return NULL;
+       }
 
        lock_kernel();
        error = nfs_cached_lookup(dir, dentry, &fhandle, &fattr);

Andries

