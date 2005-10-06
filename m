Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbVJFUDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbVJFUDf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 16:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbVJFUDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 16:03:35 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:4314 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751339AbVJFUDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 16:03:35 -0400
Message-Id: <200510062003.j96K3In0016900@owlet.beaverton.ibm.com>
To: Robert Derr <rderr@weatherflow.com>
cc: linux-kernel@vger.kernel.org, amitarora@in.ibm.com, suzukikp@in.ibm.com
Subject: Re: 2.6.13.3 Memory leak, names_cache 
In-reply-to: Your message of "Thu, 06 Oct 2005 14:34:25 EDT."
             <43456E31.8000906@weatherflow.com> 
Date: Thu, 06 Oct 2005 13:03:18 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you running with CONFIG_AUDITSYSCALL?

We ran into what sounds like the same problem and we're testing
a patch right now for a names_cache growth which only occurs
with CONFIG_AUDITSYSCALL enabled, and then only every time you
traverse a symlink.  In open_namei(), in the do_link section, we call
__do_follow_link() which will bypass the auditing whether it's enabled
or not.  However at the end of this section, we will call putname(),
which will *not* actually do a __putname() if auditing is enabled because
it believes it will happen at syscall return.  So we slowly lose memory
with each link traversal.

The code in open_namei() is a bit non-intuitive in error conditions,
but the general fix appears to be pretty straightforward.  Let me know if
this patch seems to do the trick for you.


--- linux-2.6.13.3/fs/namei.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13.3-new/fs/namei.c	2005-10-06 12:45:41.996243768 -0700
@@ -1557,19 +1557,19 @@ do_link:
 	if (nd->last_type != LAST_NORM)
 		goto exit;
 	if (nd->last.name[nd->last.len]) {
-		putname(nd->last.name);
+		__putname(nd->last.name);
 		goto exit;
 	}
 	error = -ELOOP;
 	if (count++==32) {
-		putname(nd->last.name);
+		__putname(nd->last.name);
 		goto exit;
 	}
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
 	path.dentry = __lookup_hash(&nd->last, nd->dentry, nd);
 	path.mnt = nd->mnt;
-	putname(nd->last.name);
+	__putname(nd->last.name);
 	goto do_last;
 }
 
