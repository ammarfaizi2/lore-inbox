Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTK0BKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 20:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbTK0BKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 20:10:18 -0500
Received: from hsp51.hspserver.com ([213.131.231.14]:16077 "HELO
	hsp51.hspserver.com") by vger.kernel.org with SMTP id S264415AbTK0BKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 20:10:10 -0500
From: "Timo Kamph" <timo@kamph.org>
To: Mingming Cao <cmm@us.ibm.com>
Date: Thu, 27 Nov 2003 02:10:19 +0100
Subject: Re: [BUG]Missing i_sb NULL pointer check in destroy_inode()
CC: linux-kernel@vger.kernel.org
Message-ID: <3FC55D0B.4119.2BDECA65@localhost>
In-reply-to: <1069884594.1137.22744.camel@localhost.localdomain>
References: <20031125083643.A15777@infradead.org>
X-mailer: Pegasus Mail for Windows (v4.12a)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Nov 2003 at 14:09, Mingming Cao wrote:
> On Tue, 2003-11-25 at 00:36, Christoph Hellwig wrote:
> > On Mon, Nov 24, 2003 at 11:00:38AM -0800, Mingming Cao wrote:
> > > Hello, Andrew, Marcelo,
> > > 
> > > destroy_inode() dereferences inode->i_sb without checking if it is NULL.
> > > This is inconsistent with its caller: iput() and clear_inode(),  both of
> > > which check inode->i_sb before dereferencing it. Since iput() calls
> > > destroy_inode() after calling file system's .clear_inode method(via
> > > clear_inode()),  some file systems might choose to clear the i_sb in the
> > > .clear_inode super block operation. This results in a crash in
> > > destroy_inode().
> > > 
> > > This issue exists in both 2.6, 2.4 and 2.4 kernel.  A simple fix against
> > > 2.6.0-test9 is included below. 2.4 based fix should be very similar to
> > > this one.  Please take a look and consider include it.  
> > 
> > inode->i_sb can't be NULL.  We should remove all those checks.
> > 
> Sorry I can not agree with this. Maybe the inode->i_sb should not be
> NULL, but the kernel still allows the file system to do so.  In fact
> JFS's diReadSpecial() function clears the inode->i_sb to NULL before
> calling iput().  
> 
> Acutally iput() in 2.6 is missing the check too.(in 2.4 the check is
> there).  Here is the the incremental fix for 2.6 only:

There is a little typo in your patch. The struct member is s_op and not op.
The following patch should be right.

	Timo

diff -urNp linux-2.6.0-test10/fs/inode.c a/fs/inode.c
--- linux-2.6.0-test10/fs/inode.c	2003-11-23 17:33:24.000000000 -0800
+++ a/fs/inode.c	2003-11-26 13:59:34.000000000 -0800
@@ -1084,13 +1084,13 @@ static inline void iput_final(struct ino
 void iput(struct inode *inode)
 {
 	if (inode) {
-		struct super_operations *op = inode->i_sb->s_op;
-
+		struct super_block *sb = inode->i_sb;
+		
 		if (inode->i_state == I_CLEAR)
 			BUG();
 
-		if (op && op->put_inode)
-			op->put_inode(inode);
+		if (sb && sb->s_op && sb->s_op->put_inode)
+			sb->s_op->put_inode(inode);
 
 		if (atomic_dec_and_lock(&inode->i_count, &inode_lock))
 			iput_final(inode);


