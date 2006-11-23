Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755519AbWKWDvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755519AbWKWDvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 22:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbWKWDvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 22:51:50 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:52283 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1755519AbWKWDvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 22:51:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding:from:message-id;
        b=NogK5AksekRwym78FR18PhlCnMliviqdF4DRH4P8JhRqYForg71wMmpK5yJ248IBire3Gad9MjBKOITz8nbALOlWI2fQ8+SY/mW2K2Cr3H9Idsxvc8Ph8bAFytGhtNsf3Y0K72+eiQdFGjZOcDVsYCimqmkSb9eXdc90t7YUhBU=
Date: Thu, 23 Nov 2006 12:50:47 +0900 (JST)
To: hirofumi@mail.parknet.co.jp
Cc: smartart@tiscali.it, linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
In-Reply-To: <87mz6kajks.fsf@duaron.myhome.or.jp>
References: <877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
X-Mailer: Mew version 4.2 on Emacs 22.0.90 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: junjiec@gmail.com
Message-ID: <45651ad4.562a64ed.0e8d.ffffd499@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We encountered this problem before,it did being caused by dcache.
When creating files, VFS would check the dcache first and pass the dentry
it found there to vfat_create(). Instead of dentry , using the path info
passed by user solved the problem.

--- namei.c	2006-11-18 18:41:58.000000000 +0900
+++ namei.c.new	2006-11-23 12:45:34.000000000 +0900
@@ -742,7 +742,7 @@
 	lock_kernel();
 
 	ts = CURRENT_TIME_SEC;
-	err = vfat_add_entry(dir, &dentry->d_name, 0, 0, &ts, &sinfo);
+	err = vfat_add_entry(dir, &nd->last, 0, 0, &ts, &sinfo);
 	if (err)
 		goto out;
 	dir->i_version++;



From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: bug? VFAT copy problem
Date: Wed, 22 Nov 2006 00:46:43 +0900

> The Peach <smartart@tiscali.it> writes:
> 
> > On Tue, 21 Nov 2006 02:32:43 +0900
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
> >
> >> I couldn't reproduce this for now. Could you tell mount options which
> >> you used? and after mount, "cat /proc/mounts", please.
> >
> > # mount | grep vfat 
> > /dev/sdb1 on /mnt/iomega type vfat (rw,uid=1000,gid=100,codepage=850,iocharset=iso8859-15) 
> >
> > it seems only related to those kind of files, but I don't know how to inspect the "file properties" and why these files behave like this.
> > As you can see and with a strace made on cp, the files _seems_ to be copied with the correct case, whilst it isn't, as seen with "ls". This and other things let me think is a vfat problem.
> 
> Hmm... This may be the dentry cache handling problem of fat.
> 
> Can you try the attached debug patch? And if you comment-in the
> following parts, does this problem fix?
> 
> @@ -787,6 +830,9 @@ static int vfat_rmdir(struct inode *dir,
>  	clear_nlink(inode);
>  	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
>  	fat_detach(inode);
> +	/* need to revalidate for next create */
> +	table = (sbi->options.name_check == 's') ? 3 : 1;
> +//	dentry->d_op = &vfat_dentry_ops[table];
> @@ -811,6 +858,9 @@ static int vfat_unlink(struct inode *dir
>  	clear_nlink(inode);
>  	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
>  	fat_detach(inode);
> +	/* need to revalidate for next create */
> +	table = (sbi->options.name_check == 's') ? 3 : 1;
> +//	dentry->d_op = &vfat_dentry_ops[table];
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 
