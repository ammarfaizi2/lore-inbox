Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265024AbSJPO4r>; Wed, 16 Oct 2002 10:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265026AbSJPO4r>; Wed, 16 Oct 2002 10:56:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25868 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265024AbSJPO4q>;
	Wed, 16 Oct 2002 10:56:46 -0400
Date: Wed, 16 Oct 2002 16:02:42 +0100
From: Matthew Wilcox <willy@debian.org>
To: John Levon <levon@movementarian.org>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, willy@debian.org,
       akpm@digeo.com
Subject: Re: Linux v2.5.43
Message-ID: <20021016160242.H15163@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0210152040540.1708-100000@penguin.transmeta.com> <20021016145728.GA78571@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021016145728.GA78571@compsoc.man.ac.uk>; from levon@movementarian.org on Wed, Oct 16, 2002 at 03:57:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 03:57:28PM +0100, John Levon wrote:
> Matthew, can we submit the proper fix (using cond_resched ?) at some
> point ?

yes, i have the proper fix in my tree, along with some other changes I
want to make.  Here's the better patch:

diff -urpNX dontdiff linux-2.5.43/fs/locks.c linux-2.5.43-flock/fs/locks.c
--- linux-2.5.43/fs/locks.c	2002-09-27 20:10:43.000000000 -0700
+++ linux-2.5.43-flock/fs/locks.c	2002-10-10 18:03:10.000000000 -0700
@@ -727,12 +726,16 @@ static int flock_lock_file(struct file *
 	}
 	unlock_kernel();
 
-	if (found)
-		yield();
-
 	if (new_fl->fl_type == F_UNLCK)
 		return 0;
 
+	/*
+	 * If a higher-priority process was blocked on the old file lock,
+	 * give it the opportunity to lock the file.
+	 */
+	if (found)
+		cond_resched();
+
 	lock_kernel();
 	for_each_lock(inode, before) {
 		struct file_lock *fl = *before;

-- 
Revolutions do not require corporate support.
