Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262386AbUKRDC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbUKRDC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 22:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbUKRDC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 22:02:28 -0500
Received: from zamok.crans.org ([138.231.136.6]:2239 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262386AbUKRDCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 22:02:04 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Christian Axelsson <smiler@lanil.mine.nu>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc2-mm1] OOPS on boot (hotplug related?)
References: <419BBFD1.7060306@lanil.mine.nu>
	<20041117145359.4f017ed1.akpm@osdl.org>
	<87hdno0xnf.fsf@barad-dur.crans.org>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Thu, 18 Nov 2004 04:02:02 +0100
In-Reply-To: <87hdno0xnf.fsf@barad-dur.crans.org> (Mathieu Segaud's message of
	"Thu, 18 Nov 2004 02:11:00 +0100")
Message-ID: <87d5yb272t.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Mathieu Segaud <matt@minas-morgul.org> disait derni=E8rement que :

> V. Saveliev provided the right fix shortly after I reported this oops.
>
> I attach the patch
>
> Regards,

correcting myself, the patch I gave was to apply in fs/reiser4...
by the way, thanks go to Vladimir Saveliev.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=reiser4-context-fix.patch

--- a/fs/reiser4/plugin/file/file.c	2004-11-17 09:36:11 +03:00
+++ b/fs/reiser4/plugin/file/file.c	2004-11-17 09:36:11 +03:00
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
 

--=-=-=



-- 
"Just wait. My crystal ball is infallible."

	- Linus Torvalds

--=-=-=--

