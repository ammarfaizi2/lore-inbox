Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSGCCzS>; Tue, 2 Jul 2002 22:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSGCCzR>; Tue, 2 Jul 2002 22:55:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56080 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314446AbSGCCzP>;
	Tue, 2 Jul 2002 22:55:15 -0400
Date: Wed, 3 Jul 2002 03:57:44 +0100
From: Matthew Wilcox <willy@debian.org>
To: Paul Menage <pmenage@ensim.com>
Cc: viro@math.psu.edu, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shift BKL into ->statfs()
Message-ID: <20020703035744.K27706@parcelfarce.linux.theplanet.co.uk>
References: <E17PYtv-0004Fd-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17PYtv-0004Fd-00@pmenage-dt.ensim.com>; from pmenage@ensim.com on Tue, Jul 02, 2002 at 06:25:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2002 at 06:25:47PM -0700, Paul Menage wrote:
> This patch removes BKL protection from the invocation of the
> super_operations ->statfs() method, and shifts it into the filesystems
> where necessary. Any out-of-tree filesystems may need to take the BKL in
> their statfs() methods if they were relying on it for synchronisation.

Sure, makes sense to do.  For real credit though, let's see how much we
need the BKL.  In ext2's statfs, we reference:

sbi->s_groups_count (not modified)
sbi->s_itb_per_group (not modified)
sbi->s_es->s_first_data_block (not modified)
sbi->s_es->s_blocks_count (not modified)
sbi->s_es->s_free_blocks_count (lock_super)
sbi->s_es->s_r_blocks_count (not modified)
sbi->s_es->s_inodes_count (not modified)
sbi->s_es->s_free_inodes_count (lock_super)
sb->s_blocksize (modified many places ... but we all know you don't do it
	to a mounted fs).
sb->s_mount_opt (NOT LOCKED)

s_mount_opt doesn't actually need to be locked due to how it is
modified & used.  So it _looks_ like we only need to lock_super(sb); /
unlock_super(sb); in ext2.  Anyone more familiar with ext2 locking care
to comment?

I bet most other filesystems can handle lock_super / unlock_super
for themselves.  See if some kerneljanitors are willing to help audit,
perhaps?

-- 
Revolutions do not require corporate support.
