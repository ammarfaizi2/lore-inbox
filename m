Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbUKQHKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUKQHKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 02:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbUKQHKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 02:10:14 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:2453 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262220AbUKQHJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 02:09:59 -0500
Subject: Re: 2.6.10-rc2-mm1: oops when accessing reiser4 fs's (maybe fix
	provided)
From: Vladimir Saveliev <vs@namesys.com>
To: Mathieu Segaud <matt@minas-morgul.org>
Cc: reiserfs-list@namesys.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <874qjptyl1.fsf@barad-dur.crans.org>
References: <874qjptyl1.fsf@barad-dur.crans.org>
Content-Type: multipart/mixed; boundary="=-gLZgRza9uPOe2WI0L/IL"
Message-Id: <1100675389.1399.27.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 17 Nov 2004 10:09:49 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gLZgRza9uPOe2WI0L/IL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Tue, 2004-11-16 at 21:53, Mathieu Segaud wrote:
> I tried 2.6.10-rc2-mm1 and the last reiser4 updates gave some (many many)
> oopses flooding my screen :).
> I tried reverting reiser4-fix-deadlock.patch and oopses are gone.
> 
Would you please instead try the attached patch? 

> I tried this one because thru the quick traces on my screen, I saw a reference
> to get_current_context.
> The speed of the traces and the unasibility of the box prevented me from
> making differences between "real" oopses and BUG_ON(), sorry for that...
> 
> If you want some traces I can provide them ASAP (e.g. tomorrow)




--=-gLZgRza9uPOe2WI0L/IL
Content-Disposition: attachment; filename=1.1755
Content-Type: text/plain; name=1.1755; charset=koi8-r
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/15 16:23:47+03:00 vs@tribesman.namesys.com 
#   unix_file_filemap_nopage: missing context creation is added
# 
# plugin/file/file.c
#   2004/11/15 16:23:45+03:00 vs@tribesman.namesys.com +5 -1
#   unix_file_filemap_nopage: missing context creation is added
# 
diff -Nru a/plugin/file/file.c b/plugin/file/file.c
--- a/plugin/file/file.c	2004-11-17 09:36:11 +03:00
+++ b/plugin/file/file.c	2004-11-17 09:36:11 +03:00
@@ -1961,8 +1961,10 @@
 {
 	struct page *page;
 	struct inode *inode;
-
+	reiser4_context ctx;
+	
 	inode = area->vm_file->f_dentry->d_inode;
+	init_context(&ctx, inode->i_sb);
 
 	/* block filemap_nopage if copy on capture is processing with a node of this file */
 	down_read(&reiser4_inode_data(inode)->coc_sem);
@@ -1972,6 +1974,8 @@
 
 	drop_nonexclusive_access(unix_file_inode_data(inode));
 	up_read(&reiser4_inode_data(inode)->coc_sem);
+
+	reiser4_exit_context(&ctx);
 	return page;
 }
 

--=-gLZgRza9uPOe2WI0L/IL--

