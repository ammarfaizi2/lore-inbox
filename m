Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261348AbTCJQaX>; Mon, 10 Mar 2003 11:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbTCJQaW>; Mon, 10 Mar 2003 11:30:22 -0500
Received: from comtv.ru ([217.10.32.4]:49889 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261348AbTCJQaU>;
	Mon, 10 Mar 2003 11:30:20 -0500
X-Comment-To: Andreas Dilger
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] concurrent block allocation for ext3
References: <m3zno3grfz.fsf@lexa.home.net>
	<20030310092546.D12806@schatzie.adilger.int>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 10 Mar 2003 19:33:44 +0300
In-Reply-To: <20030310092546.D12806@schatzie.adilger.int>
Message-ID: <m3n0k3gp07.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andreas Dilger (AD) writes:

 AD> Any ideas on how much this improves the performance?  What sort
 AD> of tests were you running?  We could improve things a bit further
 AD> by having separate per-group locks for the update of the group
 AD> descriptor info, and only lazily update the superblock at statfs
 AD> and unmount time (with a suitable feature flag so e2fsck can fix
 AD> this up at recovery time), but you seem to have gotten the
 AD> majority of the parallelism from this fix.

I'm trying to measure improvement.

The tests were:

1) on big fs (1GB)
lots of processes (up to 50) creating, removing directories and files +
untaring kernel and make -j4 bzImage +
dd if=/dev/zero of=/mnt/dump.file bs=1M count=8000; rm -f /mnt/dump.file

2) on small fs (64MB)
20 processes create and remove lots of files and directories


in fact, I catched dozens of debug messages about set_bit collision. Then
I fscked fs to be sure all is ok.

 >> @@ -214,11 +213,13 @@ block + i); BUFFER_TRACE(bitmap_bh, "bit
 >> already cleared"); } else { +
 >> spin_lock(&EXT3_SB(sb)->s_alloc_lock); dquot_freed_blocks++;
 gdp-> bg_free_blocks_count =
 >> cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count)+1);
 es-> s_free_blocks_count =
 >> cpu_to_le32(le32_to_cpu(es->s_free_blocks_count)+1); +
 >> spin_unlock(&EXT3_SB(sb)->s_alloc_lock);

 AD> One minor nit is that you left an ext3_error() for the "bit
 AD> already cleared" case just above this patch hunk.


hmm. whats wrong with it?

with best regards, Alex

