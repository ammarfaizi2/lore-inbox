Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbUKRBPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbUKRBPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 20:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUKRBNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 20:13:25 -0500
Received: from zamok.crans.org ([138.231.136.6]:51376 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262661AbUKRBLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 20:11:04 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Christian Axelsson <smiler@lanil.mine.nu>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc2-mm1] OOPS on boot (hotplug related?)
References: <419BBFD1.7060306@lanil.mine.nu>
	<20041117145359.4f017ed1.akpm@osdl.org>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Thu, 18 Nov 2004 02:11:00 +0100
In-Reply-To: <20041117145359.4f017ed1.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 17 Nov 2004 14:53:59 -0800")
Message-ID: <87hdno0xnf.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Andrew Morton <akpm@osdl.org> disait derni=E8rement que :

> Christian Axelsson <smiler@lanil.mine.nu> wrote:
>>
>> I'm getting OOPSes on boot on my laptop. Output is copied by hand and Iv=
e=20
>> only included the parts that I *think* are useful:
>>=20
>> ...
>> EIP is at get_nonexclusive_access+0x13/0x40
>
> Yup, seems that reiser4 broke.  I've forwarded a copy of an earlier report
> to reiserfs-dev@namesys.com.

V. Saveliev provided the right fix shortly after I reported this oops.

I attach the patch

Regards,


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=reiser4-context-fix.patch

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
 

--=-=-=



-- 
Lisa R. Nelson wrote:
> So much for a friendly group.

You really have seen nothing yet :-)

	- Bas Mevissen on linux-kernel

--=-=-=--

