Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbVLIXHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbVLIXHM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 18:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbVLIXHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 18:07:09 -0500
Received: from d36-15-41.home1.cgocable.net ([24.36.15.41]:45283 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932513AbVLIXHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 18:07:08 -0500
Subject: Re: [patch] add two inotify_add_watch flags
From: John McCutchan <ttb@tentacle.dhs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rml@novell.com
In-Reply-To: <20051209145144.4b118f09.akpm@osdl.org>
References: <1133927688.20396.8.camel@localhost.localdomain>
	 <20051209145144.4b118f09.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 09 Dec 2005 18:07:09 -0500
Message-Id: <1134169629.18310.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-12 at 14:51 -0800, Andrew Morton wrote:
> John McCutchan <ttb@tentacle.dhs.org> wrote:
> >
> > -static int find_inode(const char __user *dirname, struct nameidata *nd)
> > +static int find_inode(const char __user *dirname, struct nameidata *nd,
> > +		      int only_dir, int dont_follow_symlink)
> >  {
> >  	int error;
> > +	unsigned flags = 0;
> >  
> > -	error = __user_walk(dirname, LOOKUP_FOLLOW, nd);
> > +	if (!dont_follow_symlink)
> > +		flags |= LOOKUP_FOLLOW;
> > +	if (only_dir)
> > +		flags |= LOOKUP_DIRECTORY;
> > +
> > +	error = __user_walk(dirname, flags, nd);
> >  	if (error)
> >  		return error;
> >  	/* you can only watch an inode if you have read permissions on it */
> > @@ -943,7 +950,7 @@
> >  		goto fput_and_out;
> >  	}
> >  
> > -	ret = find_inode(path, &nd);
> > +	ret = find_inode(path, &nd, mask & IN_ONLYDIR, mask & IN_DONT_FOLLOW);
> >  	if (unlikely(ret))
> >  		goto fput_and_out;
> 
> I'd have thought that it'd be more general to pass the __user_walk flags
> into find_inode(), rather than calculating them in the callee.  Slightly
> more efficient too.  

Makes sense.

Signed-off-by: John McCutchan <ttb@tentacle.dhs.org>

Index: linux-2.6.14-rc5/fs/inotify.c
===================================================================
--- linux-2.6.14-rc5.orig/fs/inotify.c	2005-12-09 17:59:10.000000000 -0500
+++ linux-2.6.14-rc5/fs/inotify.c	2005-12-09 18:04:22.000000000 -0500
@@ -363,11 +363,12 @@
 /*
  * find_inode - resolve a user-given path to a specific inode and return a nd
  */
-static int find_inode(const char __user *dirname, struct nameidata *nd)
+static int find_inode(const char __user *dirname, struct nameidata *nd, 
+		      unsigned flags)
 {
 	int error;
 
-	error = __user_walk(dirname, LOOKUP_FOLLOW, nd);
+	error = __user_walk(dirname, flags, nd);
 	if (error)
 		return error;
 	/* you can only watch an inode if you have read permissions on it */
@@ -932,6 +933,7 @@
 	struct file *filp;
 	int ret, fput_needed;
 	int mask_add = 0;
+	unsigned flags = 0;
 
 	filp = fget_light(fd, &fput_needed);
 	if (unlikely(!filp))
@@ -943,7 +945,12 @@
 		goto fput_and_out;
 	}
 
-	ret = find_inode(path, &nd);
+	if (!(mask & IN_DONT_FOLLOW))
+		flags |= LOOKUP_FOLLOW;
+	if (mask & IN_ONLYDIR)
+		flags |= LOOKUP_DIRECTORY;
+
+	ret = find_inode(path, &nd, flags);
 	if (unlikely(ret))
 		goto fput_and_out;
 
Index: linux-2.6.14-rc5/include/linux/inotify.h
===================================================================
--- linux-2.6.14-rc5.orig/include/linux/inotify.h	2005-12-09 17:59:10.000000000 -0500
+++ linux-2.6.14-rc5/include/linux/inotify.h	2005-12-09 18:00:49.000000000 -0500
@@ -47,6 +47,8 @@
 #define IN_MOVE			(IN_MOVED_FROM | IN_MOVED_TO) /* moves */
 
 /* special flags */
+#define IN_ONLYDIR		0x01000000	/* only watch the path if it is a directory */
+#define IN_DONT_FOLLOW		0x02000000	/* don't follow a sym link */
 #define IN_MASK_ADD		0x20000000	/* add to the mask of an already existing watch */
 #define IN_ISDIR		0x40000000	/* event occurred against dir */
 #define IN_ONESHOT		0x80000000	/* only send event once */

