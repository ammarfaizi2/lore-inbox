Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756704AbWK1Axa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704AbWK1Axa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 19:53:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757734AbWK1Axa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 19:53:30 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756704AbWK1Ax3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 19:53:29 -0500
Date: Mon, 27 Nov 2006 16:52:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wendy Cheng <wcheng@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
Message-Id: <20061127165239.9616cbc9.akpm@osdl.org>
In-Reply-To: <456B7A5A.1070202@redhat.com>
References: <4564C28B.30604@redhat.com>
	<20061122153603.33c2c24d.akpm@osdl.org>
	<456B7A5A.1070202@redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2006 18:52:58 -0500
Wendy Cheng <wcheng@redhat.com> wrote:

> Andrew Morton wrote:
> > This search is potentially inefficient.  It would be better walk
> > sb->s_inodes.
> >
> >   
> Not sure about walking thru sb->s_inodes for several reasons....
> 
> 1. First, the changes made are mostly for file server setup with large 
> fs size - the entry count in sb->s_inodes may not be shorter then 
> inode_unused list.

umm, that's the best-case.  We also care about worst-case.  Think:
1,000,000 inodes on inode_unused, of which a randomly-sprinkled 10,000 are
from the being-unmounted filesytem.  The code as-proposed will do 100x more
work that it needs to do.  All under a global spinlock.

> 2. Different from calls such as drop_pagecache_sb() (that doesn't do 
> list entry removal), we're walking thru the list to dispose the entries. 
> This implies we are walking thru one list (sb->s_inodes) to remove the 
> other list's entries (inode_unused). This feels awkward.
> 3. The new code will be very similar to current prune_icache() with few 
> differences - e.g., we really don't want to list_move() within the 
> sb->s_inodes list itself (as done in prune_icache() that moves the 
> examined entry to the tail of the inode_unused list). We have to either 
> duplicate the code or clutter the current prune_icache() routine.
> 
> Pruning based on sb->s_inodes *does* have its advantage but a simple and 
> plain patch as shown in previous post (that has been well-tested out in 
> two large scale production systems) could be equally effective. Make 
> sense ?
> 

I also worry about the whole thing:

> There seems to have a need to prune inode cache entries for specific mount
> points (per vfs superblock) due to performance issues found after some io
> intensive commands ("rsyn" for example).  The problem is particularly
> serious for one of our kernel modules where it caches its (cluster) locks
> based on vfs inode implementation.  These locks are created by inode
> creation call and get purged when s_op->clear_inode() is invoked.  With
> larger servers that equipped with plenty of memory, the page dirty ratio
> may not pass the threshold to trigger VM reclaim logic but the accumulated
> inode counts (and its associated cluster locks) could causes unacceptable
> performance degradation for latency sensitive applications.

What's this about "the page dirty ratio may not pass the threshold to
trigger VM reclaim logic"?  Page reclaim isn't triggered by a dirty page
ratio.

Page reclaim is triggered by a shortage of free pages.  And page reclaim is
supposed to reclaim unused inodes in an orderly and balanced fashion.  It
appears that it's not doing so in your case and we'd need to see more
details (please) so we can understand why it is not working.

You're proposing that we not do any of that and that the filesytem be able
to call into a VM memory reclaim function for not-clearly-understood
reasons.  This is a workaround.

Please help us to understand what has gone wrong with inode reclaim.  And
please see if you can find time to help us with this rather than adding
some RH-specific fix and then forgetting about it (sensible though that
approach would be...)

Thanks.

