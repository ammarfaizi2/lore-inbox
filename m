Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbTALVUu>; Sun, 12 Jan 2003 16:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbTALVUu>; Sun, 12 Jan 2003 16:20:50 -0500
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:13749 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267532AbTALVUs>; Sun, 12 Jan 2003 16:20:48 -0500
Date: Sun, 12 Jan 2003 16:27:30 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <20030112211530.GP27709@mea-ext.zmailer.org>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: robw@optonline.net
Message-id: <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
 <20030112211530.GP27709@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 16:15, Matti Aarnio wrote:
> On Sun, Jan 12, 2003 at 02:34:54PM -0500, Rob Wilkens wrote:
> > Linus,
> > 
> > I'm REALLY opposed to the use of the word "goto" in any code where it's
> > not needed.  OF course, I'm a linux kernel newbie, so I'm in no position
> > to comment
> 
> Bob,
> 
> At first, read   Documentation/CodingStyle   of the kernel.
> Then have a look into:
> 
>     fs/open.c  file    do_sys_truncate()  function.
> 
> Explain how you can do that cleanly, understandably, and without
> code duplication, or ugly kludges  without using those goto ?
> (And sticking to coding-style.)

I've only compiled (and haven't tested this code), but it should be much
faster than the original code.  Why?  Because we're eliminating an extra
"jump" in several places in the code every time open would be called. 
Yes, it's more code, so the kernel is a little bigger, but it should be
faster at the same time, and memory should be less of an issue nowadays.

Here's the patch if you want to apply it (i have only compile tested it,
I haven't booted with it).. This patch applied to the 2.5.56 kernel.

--- open.c.orig	2003-01-12 16:17:01.000000000 -0500
+++ open.c	2003-01-12 16:22:32.000000000 -0500
@@ -100,44 +100,58 @@
 
 	error = -EINVAL;
 	if (length < 0)	/* sorry, but loff_t says... */
-		goto out;
+		return error;
 
 	error = user_path_walk(path, &nd);
 	if (error)
-		goto out;
+		return error;
 	inode = nd.dentry->d_inode;
 
 	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
 	error = -EISDIR;
-	if (S_ISDIR(inode->i_mode))
-		goto dput_and_out;
+	if (S_ISDIR(inode->i_mode)){
+		path_release(&nd);
+		return error;
+	}
 
 	error = -EINVAL;
-	if (!S_ISREG(inode->i_mode))
-		goto dput_and_out;
+	if (!S_ISREG(inode->i_mode)){
+		path_release(&nd);
+		return error;
+	}
 
 	error = permission(inode,MAY_WRITE);
-	if (error)
-		goto dput_and_out;
+	if (error){
+		path_release(&nd);
+		return error;
+	}
 
 	error = -EROFS;
-	if (IS_RDONLY(inode))
-		goto dput_and_out;
+	if (IS_RDONLY(inode)){
+		path_release(&nd);
+		return error;
+	}
 
 	error = -EPERM;
-	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		goto dput_and_out;
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode)){
+		path_release(&nd);
+		return error;
+	}
 
 	/*
 	 * Make sure that there are no leases.
 	 */
 	error = break_lease(inode, FMODE_WRITE);
-	if (error)
-		goto dput_and_out;
+	if (error){
+		path_release(&nd);
+		return error;
+	}
 
 	error = get_write_access(inode);
-	if (error)
-		goto dput_and_out;
+	if (error){
+		path_release(&nd);
+		return error;
+	}
 
 	error = locks_verify_truncate(inode, NULL, length);
 	if (!error) {
@@ -146,9 +160,7 @@
 	}
 	put_write_access(inode);
 
-dput_and_out:
 	path_release(&nd);
-out:
 	return error;
 }


