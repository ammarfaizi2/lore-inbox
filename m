Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWHTGRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWHTGRX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 02:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWHTGRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 02:17:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750891AbWHTGRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 02:17:22 -0400
Date: Sat, 19 Aug 2006 22:46:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ron Yorston <rmy@tigress.co.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: avoid needless discard of preallocated blocks
Message-Id: <20060819224603.bf687be2.akpm@osdl.org>
In-Reply-To: <200608171945.k7HJjaLk029781@tiffany.internal.tigress.co.uk>
References: <200608171945.k7HJjaLk029781@tiffany.internal.tigress.co.uk>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 20:45:36 +0100
Ron Yorston <rmy@tigress.co.uk> wrote:

> Currently preallocated blocks in ext2 are discarded on every call
> to iput() (by ext2_put_inode() calling ext2_discard_prealloc()).
> 
> An earlier attempt to fix this ("discard ext2 preallocation in last
> iput") moved the ext2_discard_prealloc() call to ext2_clear_inode(),
> but was found to cause filesystem corruption in a test using fsx.
> The problem was that ext2_clear_inode() was writing the inode data
> to disk before calling ext2_discard_prealloc(), so the value of
> i_blocks on disk included the preallocated blocks.
> 
> This patch moves the call to ext2_discard_prealloc() to the new
> function ext2_drop_inode().  This should be both efficient (discard
> happens on only the last call to iput()) and correct (fixes i_blocks
> before writing to disk).  Also, as there is now possibly a longer
> window during which an open file may have an incorrrect block count
> in its on-disk inode, ext2_update_inode adjusts the block count to
> account for preallocated blocks.

Been there, done that.  The problem was that hanging onto the preallocation
will cause separate files to have up-to-seven-block gaps between them.  So
if you put a large number of small files in the same directory, the time to
read them all back is quite significantly impacted: they cover a lot more
disk.
