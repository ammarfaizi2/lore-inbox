Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264652AbUDVUHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264652AbUDVUHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264661AbUDVUHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:07:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:15232 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264652AbUDVUFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:05:54 -0400
Date: Thu, 22 Apr 2004 13:05:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump - as root not only if euid switched
In-Reply-To: <1082663036.2592.1.camel@picklock.adams.family>
Message-ID: <Pine.LNX.4.58.0404221259510.19703@ppc970.osdl.org>
References: <2899705.1082626850875.JavaMail.pwaechtler@mac.com> 
 <20040422025638.0bf86599.akpm@osdl.org> <1082663036.2592.1.camel@picklock.adams.family>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Apr 2004, Peter Wächtler wrote:
>
> > hm, OK.  There's a window in which someone can come in and recreate the
> > file, but the open is using O_EXCL|O_CREATE so that seems safe enough.
> 
> So here is the updated patch with an open coded call to sys_unlink

Aughr. 

Wouldn't it be much nicer to just refuse to overwrite files owned by 
anybody else?

In other words, I'd much rather see a patch that is a much simpler one, 
which just says: if we opened an existing file, we won't touch it if we 
weren't the owners of it.

That should be safe for root _and_ it should be safe for people who 
already had a file descriptor open previously (hey, if the previous 
root-owned core-file was world readable, then what else is new?)

Tell me why this isn't simpler?

		Linus

---
--- 1.111/fs/exec.c	Wed Apr 21 02:11:57 2004
+++ edited/fs/exec.c	Thu Apr 22 13:03:27 2004
@@ -1378,6 +1378,8 @@
 	inode = file->f_dentry->d_inode;
 	if (inode->i_nlink > 1)
 		goto close_fail;	/* multiple links - don't dump */
+	if (inode->i_uid != current->euid || inode->i_gid != current->egid)
+		goto close_fail;
 	if (d_unhashed(file->f_dentry))
 		goto close_fail;
 
