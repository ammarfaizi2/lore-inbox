Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288061AbSA3CT0>; Tue, 29 Jan 2002 21:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288040AbSA3CTG>; Tue, 29 Jan 2002 21:19:06 -0500
Received: from zero.tech9.net ([209.61.188.187]:14090 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288061AbSA3CSr>;
	Tue, 29 Jan 2002 21:18:47 -0500
Subject: Re: [PATCH] 2.5: push BKL out of llseek
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201291647310.1747-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201291647310.1747-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 29 Jan 2002 21:24:38 -0500
Message-Id: <1012357479.817.71.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-29 at 19:52, Linus Torvalds wrote:

> Doing it in the low-level filesystem would match how we now do it inside
> generic_file_write() - ie the locking is done by the low-level filesystem,
> but most low-level filesystems choose to use a generic helper function.

OK.  Hopefully the inode semaphore works ...

> And I think your patch is slightly wrong:
> 
> > +	down(&file->f_dentry->d_inode->i_sem);
> 
> That should really be:
> 
> 	file->f_dentry->d_inode->i_mapping->host->i_sem
> 
> to get the hosted filesystem case right (ie coda).

Ahh, learn something ;-)

	Robert Love

--- linux-2.5.3-pre6/fs/read_write.c	Mon Jan 28 18:30:22 2002
+++ linux/fs/read_write.c	Tue Jan 29 19:29:32 2002
@@ -84,9 +84,9 @@
 	fn = default_llseek;
 	if (file->f_op && file->f_op->llseek)
 		fn = file->f_op->llseek;
-	lock_kernel();
+	down(&file->f_dentry->d_inode->i_mapping->host->i_sem);
 	retval = fn(file, offset, origin);
-	unlock_kernel();
+	up(&file->f_dentry->d_inode->i_mapping->host->i_sem);
 	return retval;
 }
 


