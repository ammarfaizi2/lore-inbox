Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVA0H55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVA0H55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVA0H55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:57:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35037 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262178AbVA0H5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:57:50 -0500
Date: Thu, 27 Jan 2005 07:57:49 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Attila Body <compi@freemail.hu>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: UDF madness
Message-ID: <20050127075749.GM8859@parcelfarce.linux.theplanet.co.uk>
References: <1106688285.5297.3.camel@smiley> <20050126201141.59c90e69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126201141.59c90e69.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 08:11:41PM -0800, Andrew Morton wrote:
> Yes, me too.  generic_shutdown_super() takes lock_super().  And udf uses
> lock_super for protecting its block allocation data strutures.  Trivial
> deadlock on unmount.
> 
> Filesystems really shouldn't be using lock_super() for internal purposes,
> and the main filesystems have been taught to not do that any more, but UDF
> is a holdout.
> 
> It seems that this deadlock was introduced on Jan 5 by the "udf: fix
> reservation discarding" patch which added the udf_discard_prealloc() call
> into udf_clear_inode().  The below dopey patch prevents the deadlock, but
> perhaps we can think of something more appealing.  Ideally, use a new lock
> altogether?

AFAICS, we probably could kill lock_super() in generic_shutdown_super().

	Note that all callers of lock_super() in VFS hold ->s_umount and
generic_shutdown_super() is called with ->s_umount held exclusively.
And internal fs code doing it at that point == guaranteed deadlock like
UDF one, unless we abuse it as synchronization mechanism for per-fs kernel
thread.
	Note that fs users of file_fsync() are definitely not going to be
involved into contention here - they need opened file => held active
reference to superblock.
	So we are left only with fs-internal asynchronous callers of
lock_super().  UDF, UFS, sysv, hpfs and ext2 are out of question - they
don't have async callers of that sort.  ext3... maybe, I'm not familiar
with resize code in there.  In any case, that'd better be fixed in
ext3 if such abuse exists.

	I really wonder if we need lock_super() in VFS callers - or at all,
since fs-internal stuff would better be handled by fs-private sempahores.
The only real use is to give exclusion between VFS-triggered ->write_super()
and fs-internal uses (in a handful of filesystems).  Could as well use
fs-private semaphore and grab/release it in ->write_super() of that fs...
Another suspect is ->s_flags protection - that one is going to get messy
as hell, since lock_super() is certainly not held in many places that change
->s_flags...
