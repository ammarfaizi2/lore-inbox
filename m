Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbULDMSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbULDMSl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 07:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbULDMSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 07:18:41 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:9487 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262537AbULDMSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 07:18:39 -0500
Date: Sat, 4 Dec 2004 13:18:15 +0100
From: "Frank Denis (Jedi/Sector One)" <lkml@pureftpd.org>
To: Andrew Benton <andy@benton987.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 crash
Message-ID: <20041204121837.GA1998@c9x.org>
References: <41B1A3AA.5060703@benton987.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B1A3AA.5060703@benton987.fsnet.co.uk>
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2004 at 11:46:50AM +0000, Andrew Benton wrote:
> I've been using reiser4 for a couple of months. A couple of days ago I
> did something stupid with Abiword, the disk started thrashing and as the
> system crashed it left this on the screen

  You need that patch.

diff -urN linux-2.6.10-rc2-mm4/fs/reiser4/plugin/file/file.c /usr/src/linux-2.6.10-rc2-mm4-jedi1/fs/reiser4/plugin/file/file.c
--- linux-2.6.10-rc2-mm4/fs/reiser4/plugin/file/file.c	2004-12-03 22:31:54.502630648 +0100
+++ /usr/src/linux-2.6.10-rc2-mm4-jedi1/fs/reiser4/plugin/file/file.c	2004-12-03 22:17:11.113926144 +0100
@@ -1741,6 +1741,8 @@
 	while (left > 0) {
 		size_t to_read;		
 
+		txn_restart_current();
+
 		size = i_size_read(inode);
 		if (*off >= size)
 			/* position to read from is past the end of file */
@@ -1774,7 +1776,6 @@
 		if (user_space)
 			reiser4_put_user_pages(pages, nr_pages);
 		drop_nonexclusive_access(uf_info);
-		txn_restart_current();
 
 		if (read < 0) {
 			result = read;
@@ -1975,6 +1976,8 @@
 	drop_nonexclusive_access(unix_file_inode_data(inode));
 	up_read(&reiser4_inode_data(inode)->coc_sem);
 
+	txn_restart_current();
+
 	reiser4_exit_context(&ctx);
 	return page;
 }

--
Frank - my stupid blog: http://00f.net
