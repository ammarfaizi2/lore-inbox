Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbUK0GEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbUK0GEc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUK0DqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:46:00 -0500
Received: from zeus.kernel.org ([204.152.189.113]:17604 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262658AbUKZTfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:35:44 -0500
Subject: Re: [Ext2-devel] [Patch 2/3]: ext3: handle attempted delete of
	bitmap blocks.
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20041121190901.GQ1974@schnapps.adilger.int>
References: <200411200004.iAK04oZk006590@sisko.sctweedie.blueyonder.co.uk>
	 <20041121190901.GQ1974@schnapps.adilger.int>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1101464061.1941.16.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Nov 2004 10:14:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2004-11-21 at 19:09, Andreas Dilger wrote:

> > This is easily reproduced with a sample ext3 fs image containing an
> > inode whose direct and indirect blocks refer to a block bitmap block.
> > Allocating new blocks and then deleting that inode will BUG() with:
> 
> Shouldn't we have already ext3_error'd when we tried to delete the
> bitmap block?  Not that this fix isn't a good one, I'm just trying to
> determine if there is something wrong with our error handling there.

There is --- if there wasn't, I wouldn't be able to reproduce the oops
on demand. :-)

The trouble is that ext3_free_branches() calls ext3_forget() and
ext3_free_blocks() in that order.  The ordering is fairly important: we
don't ever want to get the revoke bits in the bh out-of-sync with what's
in the bitmaps.  (Ordering wrt the journal is far less important because
those are committed atomically.)

And while ext3_free_blocks() has the check for freeing blocks in the
system zone, ext3_forget() does not.  So we assert-fail on the initial
attempt to forget a b_committed_data bh before we get to the system-zone
check.

Cheers,
 Stephen

