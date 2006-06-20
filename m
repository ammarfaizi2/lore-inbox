Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWFTGKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWFTGKc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWFTGKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:10:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9155 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965072AbWFTGKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:10:31 -0400
Date: Tue, 20 Jun 2006 16:10:06 +1000
From: Nathan Scott <nathans@sgi.com>
To: Avuton Olrich <avuton@gmail.com>
Cc: linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS crashed twice, once in 2.6.16.20, next in 2.6.17, reproducable
Message-ID: <20060620161006.C1079661@wobbly.melbourne.sgi.com>
References: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3aa654a40606190044q43dca571qdc06ee13d82d979@mail.gmail.com>; from avuton@gmail.com on Mon, Jun 19, 2006 at 12:44:58AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 12:44:58AM -0700, Avuton Olrich wrote:
> ..
> Hello, when trying to recursively delete a directory (same directory
> twice) from my 500gb hard drive I get a problem. It crashed first in
> 2.6.16.20, then I upgraded to try to get rid of the issue. This one is
> from 2.6.17:

How reproducible is it?  Is it reproducible even after xfs_repair?

If so, can you try Mandy's patch below, to see if it is addressing
the root cause of your problem?  If problems persist, a reproducible
test case would be wonderful, if one can be found..

cheers.

-- 
Nathan


Fix nused counter.  It's currently getting set to -1 rather than getting
decremented by 1.  Since nused never reaches 0, the "if (!free->hdr.nused)"
check in xfs_dir2_leafn_remove() fails every time and xfs_dir2_shrink_inode()
doesn't get called when it should.  This causes extra blocks to be left on
an empty directory and the directory in unable to be converted back to
inline extent mode.

Signed-off-by: Mandy Kirkconnell <alkirkco@sgi.com>
Signed-off-by: Nathan Scott <nathans@sgi.com>

--- a/fs/xfs/xfs_dir2_node.c	2006-06-20 16:00:45.000000000 +1000
+++ b/fs/xfs/xfs_dir2_node.c	2006-06-20 16:00:45.000000000 +1000
@@ -972,7 +972,7 @@ xfs_dir2_leafn_remove(
 			/*
 			 * One less used entry in the free table.
 			 */
-			free->hdr.nused = cpu_to_be32(-1);
+			be32_add(&free->hdr.nused, -1);
 			xfs_dir2_free_log_header(tp, fbp);
 			/*
 			 * If this was the last entry in the table, we can
