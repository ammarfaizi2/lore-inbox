Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263303AbTKXS60 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTKXS6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:58:25 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:63693 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263303AbTKXS6X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:58:23 -0500
Subject: [BUG]Missing i_sb NULL pointer check in destroy_inode()
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Cc: Paul.McKenney@us.ibm.com
In-Reply-To: <20031109152936.3a9ffb69.akpm@osdl.org>
References: <1068045518.10730.266.camel@socrates>
	<20031105181600.GC18278@thunk.org> <1068066524.10726.289.camel@socrates>
	<20031106033817.GB22081@thunk.org> <1068145132.10735.322.camel@socrates>
	<20031106123922.Y10197@schatzie.adilger.int>
	<1068148881.10730.337.camel@socrates> <1068230146.10726.359.camel@socrates>
	<20031109130826.2b37219d.akpm@osdl.org> <1068419747.687.28.camel@socrates> 
	<20031109152936.3a9ffb69.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Nov 2003 11:00:38 -0800
Message-Id: <1069700440.16649.19433.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew, Marcelo,

destroy_inode() dereferences inode->i_sb without checking if it is NULL.
This is inconsistent with its caller: iput() and clear_inode(),  both of
which check inode->i_sb before dereferencing it. Since iput() calls
destroy_inode() after calling file system's .clear_inode method(via
clear_inode()),  some file systems might choose to clear the i_sb in the
.clear_inode super block operation. This results in a crash in
destroy_inode().

This issue exists in both 2.6, 2.4 and 2.4 kernel.  A simple fix against
2.6.0-test9 is included below. 2.4 based fix should be very similar to
this one.  Please take a look and consider include it.  

Many thanks!!

--Mingming
----------------------------------------------------------
diff -urNp linux-2.6.0-test9/fs/inode.c a/fs/inode.c
--- linux-2.6.0-test9/fs/inode.c	2003-10-25 11:44:53.000000000 -0700
+++ a/fs/inode.c	2003-11-20 17:28:04.000000000 -0800
@@ -160,7 +160,7 @@ void destroy_inode(struct inode *inode) 
 	if (inode_has_buffers(inode))
 		BUG();
 	security_inode_free(inode);
-	if (inode->i_sb->s_op->destroy_inode)
+	if (inode->i_sb && inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
 	else
 		kmem_cache_free(inode_cachep, (inode));

