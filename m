Return-Path: <linux-kernel-owner+w=401wt.eu-S932802AbWLSQOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbWLSQOK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 11:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbWLSQOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 11:14:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:49335 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753261AbWLSQOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 11:14:09 -0500
Subject: Re: [Patch] BUG in fs/jfs/jfs_xtree.c
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1166467889.32321.4.camel@alice>
References: <1166467889.32321.4.camel@alice>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 10:14:02 -0600
Message-Id: <1166544842.14941.14.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 19:51 +0100, Eric Sesterhenn wrote:
> hi,
> 
> while playing around with fsfuzzer, i got the following oops with jfs:
> 
> [  851.804875] BUG at fs/jfs/jfs_xtree.c:760 assert(!BT_STACK_FULL(btstack))
> [  851.805179] ------------[ cut here ]------------
> [  851.805238] kernel BUG at fs/jfs/jfs_xtree.c:760!

...

> On a damaged filesystem we might have a full stack and should
> not progress further, and return instead of calling BUG()
> 
> Signed-off-by: Eric Sesterhenn
> 
> --- linux-2.6.19/fs/jfs/jfs_xtree.c.orig	2006-12-18 14:37:07.000000000 +0100
> +++ linux-2.6.19/fs/jfs/jfs_xtree.c	2006-12-18 14:37:55.000000000 +0100
> @@ -757,6 +757,8 @@ static int xtSearch(struct inode *ip, s6
>  			nsplit = 0;
>  
>  		/* push (bn, index) of the parent page/entry */
> +		if (BT_STACK_FULL(btstack))
> +			return -EINVAL;

This leaks a reference on an xtree page.  I'd also like to mark the
superblock dirty here, so that fsck.jfs will fix the file system on the
next boot.  jfs_error does this as well as the requested error action.
The default is to remount read-only.

>  		BT_PUSH(btstack, bn, index);
>  
>  		/* get the child page block number */
> 

Do you want to retry your fsfuzzer testing with this patch?  I'm going
to take a look at the other calls to BT_PUSH in xtTruncate and
xtTruncate_pmap, but I'm too busy now, so I'll send you what I have so
far (untested).

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

diff --git a/fs/jfs/jfs_xtree.c b/fs/jfs/jfs_xtree.c
index e98eb03..176e984 100644
--- a/fs/jfs/jfs_xtree.c
+++ b/fs/jfs/jfs_xtree.c
@@ -757,6 +757,11 @@ static int xtSearch(struct inode *ip, s64 xoff,	s64 *nextp,
 			nsplit = 0;
 
 		/* push (bn, index) of the parent page/entry */
+		if (BT_STACK_FULL(btstack)) {
+			jfs_error(ip->i_sb, "stack overrun in xtSearch!");
+			XT_PUTPAGE(mp);
+			return -EIO;
+		}
 		BT_PUSH(btstack, bn, index);
 
 		/* get the child page block number */

-- 
David Kleikamp
IBM Linux Technology Center

