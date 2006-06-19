Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWFSEeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWFSEeH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 00:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWFSEeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 00:34:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59820 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750826AbWFSEeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 00:34:05 -0400
Date: Sun, 18 Jun 2006 21:33:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Staubach <staubach@redhat.com>
Cc: staubach@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory mapped files not updating timestamps
Message-Id: <20060618213356.e847db04.akpm@osdl.org>
In-Reply-To: <447DD80C.2000408@redhat.com>
References: <446B3E5D.1030301@redhat.com>
	<447DD80C.2000408@redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 13:53:16 -0400
Peter Staubach <staubach@redhat.com> wrote:

>

A few issues here.

> 
> I embarked on this work due to a bug reported by one of Red Hat's large
> customers.  They are finding that files, which should have been backed
> up, were not getting backed up.  This is due to the mtime on the files
> not changing and their backup software looking for mtime changes.  This
> is corruption and I need to get it fixed, sooner as opposed to later.
> 
> While I would like to get this fixed on top of Peter Zijlstra's changes,
> the process for those is looking long and complicated.  I am wondering
> if we could consider these changes and then add the requirement of
> maintaining these semantics to those that Peter's work is attempting to
> address.
> 

We seem to be having a problem getting a coherent changelog.  A changelog
should describe why the patch exists, what it does and how it does it. 
Please develop and maintain a changelog for each patch and reissue the
changelog with each reissuing of a patch, thanks.

This sequence:

+	if (test_and_clear_bit(AS_MCTIME, &mapping->flags))
+		inode_update_time(inode);

appears all over the place and should be implemented in a helper function.


The patch should work correctly for mmaps of block devices and I don't
think it does.  Sometimes it updates the timestamp on the kernel-internal
blockdev inode at mapping->host and sometimes it updates the inode of the
device node (/dev/hda1) at file->f_dentry->d_inode.  It should be updating
the /dev/hda1 inode.

The change to unlink_file_vma() is awkward, IMO.  It means that this helper
function "knows" things about what its caller is using it for.  I'd suggest
that this code should be moved up to a higher level where we have a more
sure semantic context, rather than being implemented in some low-level
helper function where it happens to be convenient.

Also, inode_update_time() can sleep. 
mark_inode_dirty_sync()->__mark_inode_dirty()->ext3_dirty_inode().  This is
despite Documentation/filesystems/Locking saying "must not sleep".  But
unlink_file_vma() (at least) is called from atomic context:

	unmap_region()
	->tlb_gather_mmu()
	  ->preempt_disable()
	->free_pgtables()
	  ->unlink_file_vma()
	->tlb_finish_mmu()
	  ->preempt_enable()

Which _should_ have triggered warnings if full kernel debugging was enabled
and sufficient testing was performed.  Perhaps a might_sleep() is needed in
_mark_inode_dirty().

