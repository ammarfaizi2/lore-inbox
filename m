Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUBZWT3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbUBZWT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:19:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:19110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261194AbUBZWTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:19:20 -0500
Date: Thu, 26 Feb 2004 14:25:01 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
cc: linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PATCH] Add getdents32t syscall
In-Reply-To: <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org>
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
 <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Linus Torvalds wrote:
> 
> In other words, what's wrong with this much simpler "extended getdents" 
> instead?

Actually, let's put the "d_type" always at the last character, so that you 
don't have to search for it. Ie like the appended.

Then you just get

	d_type = ((unsigned char *)dirent)[dirent->d_reclen-1];

inside glibc. Instead of having a new system call.

You can even trivially check whether the system call fills in the d_type 
field or not:

 - pre-fill the dirent area with 0xff or something
 - do a small old-style "readdir()"
 - check the first entry: the above gives a d_type of 0xff, then you have 
   an old-style readdir. If it gives 0, then you have to test whether it 
   is an old-style readdir (and the zero is the end-of-name marker) or a 
   new-style readdir (and the zero is DT_UNKNOWN). You can trivially do 
   that by checking the length of the name, and comparing it with the 
   reclen.

See? No new system call, and trivial detection of whether the new code is 
there or not.

		Linus

--
--- 1.23/fs/readdir.c	Tue Feb  3 21:29:14 2004
+++ edited/fs/readdir.c	Thu Feb 26 14:17:05 2004
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
+	if (__put_user(d_type, (char *) dirent + reclen - 1))
 		goto efault;
 	buf->previous = dirent;
 	dirent = (void *)dirent + reclen;
