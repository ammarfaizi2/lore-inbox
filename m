Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUBZWMH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbUBZWMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:12:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:34462 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261169AbUBZWJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:09:24 -0500
Date: Thu, 26 Feb 2004 14:15:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
cc: linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PATCH] Add getdents32t syscall
In-Reply-To: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
Message-ID: <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org>
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Jakub Jelinek wrote:
> 
> glibc struct dirent has d_type field (similarly to struct dirent64).
> Because no 32-bit getdents syscall provides this field to userland,
> glibc needs to use getdents64 syscall even for 32-bit getdents
> (and readdir etc.) and convert dirent entries from struct dirent64
> to struct dirent.  The code is quite complicated and as the former
> is bigger and the size of 64-bit dirents cannot be predicted accurately,
> it can happen that glibc reads too many entries and has to seek back
> on the dir etc.

Nooo..

Please just use the old "getdents()", and if you really really need this, 
add the "type" char after the end of the name.

This is a two-liner change (yeah, and we'd need to add a flag saying we do 
this). 

In other words, what's wrong with this much simpler "extended getdents" 
instead?

		Linus

--- 1.23/fs/readdir.c	Tue Feb  3 21:29:14 2004
+++ edited/fs/readdir.c	Thu Feb 26 14:12:57 2004
@@ -139,7 +139,7 @@
 {
 	struct linux_dirent __user * dirent;
 	struct getdents_callback * buf = (struct getdents_callback *) __buf;
-	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 1);
+	int reclen = ROUND_UP(NAME_OFFSET(dirent) + namlen + 2);
 
 	buf->error = -EINVAL;	/* only used if we fail.. */
 	if (reclen > buf->count)
@@ -157,6 +157,8 @@
 	if (copy_to_user(dirent->d_name, name, namlen))
 		goto efault;
 	if (__put_user(0, dirent->d_name + namlen))
+		goto efault;
+	if (__put_user(d_type, dirent->d_name + namlen + 1))
 		goto efault;
 	buf->previous = dirent;
 	dirent = (void *)dirent + reclen;
