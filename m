Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261728AbTCQPQ1>; Mon, 17 Mar 2003 10:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261735AbTCQPQ1>; Mon, 17 Mar 2003 10:16:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63722 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261728AbTCQPQ0>;
	Mon, 17 Mar 2003 10:16:26 -0500
Date: Mon, 17 Mar 2003 15:27:19 +0000
From: Matthew Wilcox <willy@debian.org>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Matthew Wilcox <willy@debian.org>, Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [Ext2-devel] [PATCH] distributed counters for ext2 to avoid group scaning
Message-ID: <20030317152719.GD28607@parcelfarce.linux.theplanet.co.uk>
References: <m3el5773to.fsf@lexa.home.net> <20030316104447.D12806@schatzie.adilger.int> <m3bs0bugca.fsf@lexa.home.net> <20030317151108.GC28607@parcelfarce.linux.theplanet.co.uk> <m3ptoqjagt.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ptoqjagt.fsf@lexa.home.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 06:09:54PM +0300, Alex Tomas wrote:
> >>>>> Matthew Wilcox (MW) writes:
>  MW> And then we have 3 of these (an additional 3k..).  Per
>  MW> blockgroup.  My 4GB / has 30 blockgroups; my 30GB /home has 232.
>  MW> So that's a little under 8 per GB.  My _laptop_ has a 40GB drive,
>  MW> so that's on the order of 320 blockgroups -- almost an additional
>  MW> megabyte of ram consumed for these counters.
> 
> no-no!
> 
> _one_ dcounter to maintain number of free blocks _per_ fs.
> _one_ dcounter to maintain number of inode blocks _per_ fs.
> _one_ dcounter to maintain number of dirs _per_ fs.
> 
> 3 dcounter per fs. no more.

Gah.  That's your fault.  Use diff -p in future; I saw:

diff -uNr linux/include/linux/ext2_fs_sb.h edited/include/linux/ext2_fs_sb.h
--- linux/include/linux/ext2_fs_sb.h    Sun Mar 16 17:21:34 2003
+++ edited/include/linux/ext2_fs_sb.h   Mon Mar 17 00:12:00 2003
@@ -16,6 +16,8 @@
 #ifndef _LINUX_EXT2_FS_SB
 #define _LINUX_EXT2_FS_SB

+#include <linux/dcounter.h>
+       
 struct ext2_bg_info {
        u8 debts;
        spinlock_t balloc_lock;
@@ -52,6 +54,9 @@
        u32 s_next_generation;
        unsigned long s_dir_count;
        struct ext2_bg_info *s_bgi;
+       struct dcounter free_blocks_dc;
+       struct dcounter free_inodes_dc;
+       struct dcounter dirs_dc;
 };

which makes it look like the dcounters are added to ext2_bg_info.
diff -p would have put the name of the struct after the @@ line.  Not to
mention you didn't follow the `s_' prefix style used everywhere else in
that struct.

Anyway, I think dcounters should probably be allocated from kmalloc_percpu()
rather than as part of the dcounter struct.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
