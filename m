Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287588AbSA3Agd>; Tue, 29 Jan 2002 19:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287572AbSA3AgR>; Tue, 29 Jan 2002 19:36:17 -0500
Received: from zero.tech9.net ([209.61.188.187]:29961 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S287552AbSA3Af6>;
	Tue, 29 Jan 2002 19:35:58 -0500
Subject: Re: [PATCH] 2.5: push BKL out of llseek
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201291602510.1747-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 29 Jan 2002 19:41:48 -0500
Message-Id: <1012351309.813.56.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-29 at 19:09, Linus Torvalds wrote:

> Thinking about that, that actally sounds like the _right_ thing to do even
> from a correctness standpoint - as llseek() looks at the inode size, so we
> should have that lock anyway.
> 
> So I'd suggest doing the inode semaphore globally, instead of using
> kernel_lock at all.

This was my end result (or some sort of proper finer-grained lock) but I
was unsure of how to deal with the other llseek methods that may be
oddball.  I have no reason to suspect using the inode semaphore won't
work.

Another gain from pushing the locks into each method is that we can pick
and choose as-needed.  If it turns out inode semaphore is a global
solution, the following patch is sufficient.  Otherwise, we could
replace the lock_kernel in each caller with the inode semaphore, as
appropriate.  Oh Al ??

	Robert Love

--- linux-2.5.3-pre6/fs/read_write.c	Mon Jan 28 18:30:22 2002
+++ linux/fs/read_write.c	Tue Jan 29 19:29:32 2002
@@ -84,9 +84,9 @@
 	fn = default_llseek;
 	if (file->f_op && file->f_op->llseek)
 		fn = file->f_op->llseek;
-	lock_kernel();
+	down(&file->f_dentry->d_inode->i_sem);
 	retval = fn(file, offset, origin);
-	unlock_kernel();
+	up(&file->f_dentry->d_inode->i_sem);
 	return retval;
 }


