Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265700AbUADP41 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 10:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265708AbUADP41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 10:56:27 -0500
Received: from ns.suse.de ([195.135.220.2]:30383 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265700AbUADP4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 10:56:25 -0500
Subject: Re: [patch] linux-2.4 Ext2/3 compatibility problem with EAs on
	symlinks
From: Andreas Gruenbacher <agruen@suse.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       SE Linux <selinux@tycho.nsa.gov>,
       ACL devel list <acl-devel@bestbits.at>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <1072104195.1967.49.camel@sisko.scot.redhat.com>
References: <1072104195.1967.49.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1073231783.2483.22.camel@nb.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 04 Jan 2004 16:56:24 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I agree with Stephen that the revised symlink checking code should be
added to the 2.4 series. Marcelo, could you please apply?

(The extended attribute patches contain an equivalent check, but these
patches will not get integrated into 2.4, so people switching between
vanilla 2.4 and 2.6 without this patch would run into the problems
mentioned. Because I wasn't using EA-unaware kernels much since ages, I
didn't experience this problem.)


On Mon, 2003-12-22 at 15:43, Stephen C. Tweedie wrote:
> Hi all, 
> 
> I found why people running SELinux on 2.6 were having trouble booting
> again on 2.4 kernels, and it's nothing to do with SELinux per-se.  It's
> a compatibility problem with extended attributes.  
> 
> The trouble is that setting an EA on a fast symlink upsets the kernel's
> symlink detection code.  Older kernels will see a symlink with non-zero
> i_blocks, and will assume that the symlink is a slow one --- ie. that
> the first direct block of the inode points to the symlink contents ---
> and will end up doing a block lookup from what is in fact the first four
> ascii chars from the symlink path.
> 
> 2.6 kernels deal with this by detecting a non-zero i_file_acl field and
> subtracting the EA's blocks from i_blocks before checking if the block
> count is zero.  The patch below adds the same compatibility code to
> 2.4.  Booting a SELinux partition results in immediate death via access
> beyond end-of-device as soon as the kernel tries to dereference /bin/sh
> (a symlink to /bin/bash on this box); with the fix, it's fine.
> 
> Any kernel built with EA patches will be immune to this, even if the EA
> config is not set.  So, 2.6 is simply not vulnerable.
> 
> There are a couple of questions left over.  First, should we be adding a
> compatibility flag so that mounting filesystems with EAs on symlinks is
> rejected on older kernels?

I don't think we should. EA file systems work "well enough" on
EA-unaware kernels.

> Secondly, there's the problem of getting EA
> refcounts out-of-sync if you delete an inode with EAs on an older,
> non-EA-aware kernel.  Even with the fix, the old kernel will still fail
> to update the refcount on the EA block so we'd need a fsck to fix things
> up; setting a readonly compatibility bit when EAs are present would
> avoid that, but it's not clear whether the underlying problem is bad
> enough to justify the hit in usability.

The only problem that deleting EA inodes with a non-EA-aware kernel
causes are refcounts that are too high, and a file system check will fix
this. When no FS check is done, a few file system blocks that appear to
be in use actually won't be. I think this event will be rare, so I would
not introduce a read-only flag.


Thanks,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

