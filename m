Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbUDAUJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbUDAUJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:09:54 -0500
Received: from ns.suse.de ([195.135.220.2]:60800 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263135AbUDAUJw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:09:52 -0500
Date: Thu, 1 Apr 2004 22:09:57 +0200
From: Andi Kleen <ak@suse.de>
To: Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de>
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: Linux 2.6 nanosecond time stamp weirdness breaks GCC build
Message-Id: <20040401220957.5f4f9ad2.ak@suse.de>
In-Reply-To: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
References: <200404011928.VAA23657@faui1d.informatik.uni-erlangen.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Apr 2004 21:28:20 +0200 (CEST)
Ulrich Weigand <weigand@i1.informatik.uni-erlangen.de> wrote:

> However, I'd say that this should probably be fixed in the kernel,
> e.g. by not reporting high-precision time stamps in the first
> place if the file system cannot store them ...

Interesting. We discussed the case as a theoretical possibility when
the patch was merged, but it seemed to unlikely to make it worth
complicating the first version.

The solution from back then I actually liked best was to just round
up to the next second instead of rounding down when going from 1s 
resolution to ns.

-Andi

e.g. like this for ext3 (untested). Does that fix your problem?

diff -u linux-2.6.5rc3-work/fs/ext3/inode.c-o linux-2.6.5rc3-work/fs/ext3/inode.c
--- linux-2.6.5rc3-work/fs/ext3/inode.c-o	2004-04-01 22:07:43.000000000 +0200
+++ linux-2.6.5rc3-work/fs/ext3/inode.c	2004-04-01 22:08:49.000000000 +0200
@@ -2624,9 +2624,11 @@
 	}
 	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
 	raw_inode->i_size = cpu_to_le32(ei->i_disksize);
-	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
-	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
-	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);
+	/* round up because we cannot store nanoseconds. This avoids
+	   the time jumping back when the inode is loaded again. */
+	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec + 1);
+	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec + 1);
+	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec + 1);
 	raw_inode->i_blocks = cpu_to_le32(inode->i_blocks);
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 	raw_inode->i_flags = cpu_to_le32(ei->i_flags);


