Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261713AbVFVRWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbVFVRWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVFVROl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:14:41 -0400
Received: from thunk.org ([69.25.196.29]:12431 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261750AbVFVRBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:01:50 -0400
Date: Wed, 22 Jun 2005 13:01:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-ID: <20050622170135.GB18544@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org, pavel@ucw.cz,
	linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz> <E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu> <20050621233914.69a5c85e.akpm@osdl.org> <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 09:16:34AM +0200, Miklos Szeredi wrote:
> The controversial part is fuse_allow_task() called from
> fuse_permission() and fuse_revalidate() (fs/fuse/dir.c).
> 
> This function (as explained by the header comment) disallows access to
> the filesystem for any task, which the filesystem owner (the user who
> did the mount) is not allowed to ptrace.
> 
> The rationale is that accessing the filesystem gives the filesystem
> implementor ptrace like capabilities (detailed in
> Documentation/filesystems/fuse.txt)
> 
> It is controversial, because obviously root owned tasks are not
> ptrace-able by the user, and so these tasks will be denied access to
> the user mounted filesystem (-EACCESS is returned on stat() or any
> other file operation).

I don't think this should be objectionable, since we already have
times when root-owned tasks can get EACCESS when accessing some
filesystem.  This can happen with any distributed filesystem that
enforces real security --- whether it be nfs-root-squash, or the
Andrew Filesystem, or NFSv4.  Root can get "permission denied" when
some other userid with appropriate credentials would be allowed to
access the file/directory.

On the other hand, sometimes a root process, or some other user's
process, might _want_ to give permission to allow a trusted FUSE
filesystem the potential to monkey with it (return potentially
untrusted information, or stop it entirely), in exchange for access to
the filesystem.  So it would be nice if there was some way that a
process could tell the kernel that it is willing to give permission to
allow certain FUSE filesystems to potentially affect it.  Say, via a
fnctl() call, perhaps.

					- Ted
