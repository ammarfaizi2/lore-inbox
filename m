Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUEUX5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUEUX5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264375AbUEUXwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:52:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28347 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264682AbUEUXdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:33:47 -0400
Date: Wed, 19 May 2004 12:53:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use-before-uninitialized value in ext3(2)_find_ goal
Message-ID: <20040519125328.J22989@build.pdx.osdl.net>
References: <20040519043235.30d47edb.akpm@osdl.org> <1084992705.15395.1276.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1084992705.15395.1276.camel@w-ming2.beaverton.ibm.com>; from cmm@us.ibm.com on Wed, May 19, 2004 at 11:51:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mingming Cao (cmm@us.ibm.com) wrote:
> +	goal = 0;
>  	down(&ei->truncate_sem);
>  	if (ext3_find_goal(inode, iblock, chain, partial, &goal) < 0) {
...
> +	goal = 0;
>  	if (ext2_find_goal(inode, iblock, chain, partial, &goal) < 0)
>  		goto changed;

I know it's a slightly bigger patch, but would it make sense to just enforce
this as part of api?  Just a thought...(patch untested)

thanks,
-chris

--- linux-2.6.6-mm3/fs/ext2/inode.c~goal	2004-05-09 19:32:00.000000000 -0700
+++ linux-2.6.6-mm3/fs/ext2/inode.c	2004-05-19 12:27:11.968054560 -0700
@@ -366,6 +366,7 @@ static inline int ext2_find_goal(struct 
 				 unsigned long *goal)
 {
 	struct ext2_inode_info *ei = EXT2_I(inode);
+	unsigned long _goal = 0;
 	write_lock(&ei->i_meta_lock);
 	if (block == ei->i_next_alloc_block + 1) {
 		ei->i_next_alloc_block++;
@@ -377,10 +378,11 @@ static inline int ext2_find_goal(struct 
 		 * failing that at least try to get decent locality.
 		 */
 		if (block == ei->i_next_alloc_block)
-			*goal = ei->i_next_alloc_goal;
-		if (!*goal)
-			*goal = ext2_find_near(inode, partial);
+			_goal = ei->i_next_alloc_goal;
+		if (!_goal)
+			_goal = ext2_find_near(inode, partial);
 		write_unlock(&ei->i_meta_lock);
+		*goal = _goal;
 		return 0;
 	}
 	write_unlock(&ei->i_meta_lock);
--- linux-2.6.6-mm3/fs/ext3/inode.c~goal	2004-05-13 11:19:42.000000000 -0700
+++ linux-2.6.6-mm3/fs/ext3/inode.c	2004-05-19 12:25:48.441752488 -0700
@@ -461,6 +461,7 @@ static int ext3_find_goal(struct inode *
 			  Indirect *partial, unsigned long *goal)
 {
 	struct ext3_inode_info *ei = EXT3_I(inode);
+	unsigned long _goal = 0;
 	/* Writer: ->i_next_alloc* */
 	if (block == ei->i_next_alloc_block + 1) {
 		ei->i_next_alloc_block++;
@@ -474,9 +475,10 @@ static int ext3_find_goal(struct inode *
 		 * failing that at least try to get decent locality.
 		 */
 		if (block == ei->i_next_alloc_block)
-			*goal = ei->i_next_alloc_goal;
-		if (!*goal)
-			*goal = ext3_find_near(inode, partial);
+			_goal = ei->i_next_alloc_goal;
+		if (!_goal)
+			_goal = ext3_find_near(inode, partial);
+		*goal = _goal;
 		return 0;
 	}
 	/* Reader: end */
