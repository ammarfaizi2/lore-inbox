Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTKCQz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 11:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTKCQz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 11:55:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:21145 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262118AbTKCQzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 11:55:54 -0500
Date: Mon, 3 Nov 2003 08:55:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Konstantin Boldyshev <konst@linuxassembly.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <marcelo.tosatti@cyclades.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: minix fs corruption fix for 2.4
In-Reply-To: <Pine.LNX.4.43L.0311031557480.1077-200000@alpha.linuxassembly.org>
Message-ID: <Pine.LNX.4.44.0311030851430.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Nov 2003, Konstantin Boldyshev wrote:
> 
> Enclosed is a simple patch to fix corruption of minix filesystem
> when deleting character and block device nodes (special files).
> From what I've found out the bug was introduced somehwere in 2.3
> and is present in all 2.4 versions, and I guess also goes into 2.6.

Oops, yes.

The problem is that block and character devices put not a block number but 
a _device_ number in the place where other files put their block 
allocations.

Your patch is wrong, though - you shouldn't test for APPEND and IMMUTABLE 
here. That should be done at higher layers. 

I'd also prefer to do the test the other way around: test for CHRDEV and 
BLKDEV in inode.c the same way the other functions do. Something like the 
appended..

Al, can you verify? I think this crept in when you did the block lookup 
cleanups. I also worry whether anybody else got the bug?

		Linus

===== fs/minix/inode.c 1.38 vs edited =====
--- 1.38/fs/minix/inode.c	Fri Sep  5 04:31:53 2003
+++ edited/fs/minix/inode.c	Mon Nov  3 08:51:01 2003
@@ -547,6 +547,8 @@
  */
 void minix_truncate(struct inode * inode)
 {
+	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
+		return;
 	if (INODE_VERSION(inode) == MINIX_V1)
 		V1_minix_truncate(inode);
 	else

