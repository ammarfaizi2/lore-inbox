Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWCZLum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWCZLum (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 06:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWCZLum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 06:50:42 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:773 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751287AbWCZLul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 06:50:41 -0500
Date: Sun, 26 Mar 2006 19:51:09 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] autofs4 - follow_link missing funtionality
In-Reply-To: <20060310145016.39b028be.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603261946410.6061@eagle.themaw.net>
References: <Pine.LNX.4.64.0603102003110.3032@eagle.themaw.net>
 <20060310145016.39b028be.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

Here is an update to this patch to address your concern below.

Basicly, I wait for pending operations to complete, the main concern is an 
expire operation causing directories to be removed. As we hold a reference 
to the vfsmount and the dentry that shouldn't happen once any that are in 
progress have completed.

At least that's what I expect.

On Fri, 10 Mar 2006, Andrew Morton wrote:

> Ian Kent <raven@themaw.net> wrote:
> >
> > @@ -337,10 +340,34 @@ static void *autofs4_follow_link(struct 
> >  	if (oz_mode || !lookup_type)
> >  		goto done;
> >  
> > +	/*
> > +	 * If the dentry contains directories then it is an
> > +	 * autofs multi-mount with no root offset. So don't
> > +	 * try to mount it again.
> > +	 */
> > +	spin_lock(&dcache_lock);
> > +	if (!list_empty(&dentry->d_subdirs)) {
> > +		spin_unlock(&dcache_lock);
> > +		goto done;
> > +	}
> > +	spin_unlock(&dcache_lock);
> > +
> 
> Can list_empty(&dentry->d_subdirs) become false right here, after the lock
> was dropped?  If so, what happens?
> 
> 
> >  	status = try_to_fill_dentry(dentry, 0);
> 

Signed-off-by: Ian Kent <raven@themaw.net>

--

--- linux-2.6.16-mm1/fs/autofs4/root.c.follow_link-expire-check	2006-03-24 12:32:16.000000000 +0800
+++ linux-2.6.16-mm1/fs/autofs4/root.c	2006-03-24 15:01:15.000000000 +0800
@@ -341,38 +341,49 @@ static void *autofs4_follow_link(struct 
 		goto done;
 
 	/*
-	 * If the dentry contains directories then it is an
-	 * autofs multi-mount with no root offset. So don't
-	 * try to mount it again.
+	 * If a request is pending wait for it.
+	 * If it's a mount then it won't be expired till at least
+	 * a liitle later and if it's an expire then we might need
+	 * to mount it again.
 	 */
-	spin_lock(&dcache_lock);
-	if (!list_empty(&dentry->d_subdirs)) {
-		spin_unlock(&dcache_lock);
-		goto done;
-	}
-	spin_unlock(&dcache_lock);
+	if (autofs4_ispending(dentry)) {
+		DPRINTK("waiting for active request %p name=%.*s",
+			dentry, dentry->d_name.len, dentry->d_name.name);
 
-	status = try_to_fill_dentry(dentry, 0);
-	if (status)
-		goto out_error;
+		status = autofs4_wait(sbi, dentry, NFY_NONE);
+
+		DPRINTK("request done status=%d", status);
+	}
 
 	/*
-	 * The mount succeeded but if there is no root mount
-	 * and directories have been created then it must
-	 * be an autofs multi-mount with no root offset.
+	 * If the dentry contains directories then it is an
+	 * autofs multi-mount with no root mount offset. So
+	 * don't try to mount it again.
 	 */
 	spin_lock(&dcache_lock);
-	if (!d_mountpoint(dentry) && !list_empty(&dentry->d_subdirs)) {
+	if (!d_mountpoint(dentry) && list_empty(&dentry->d_subdirs)) {
 		spin_unlock(&dcache_lock);
+
+		status = try_to_fill_dentry(dentry, 0);
+		if (status)
+			goto out_error;
+
+		/*
+		 * The mount succeeded but if there is no root mount
+		 * it must be an autofs multi-mount with no root offset
+		 * so we don't need to follow the mount.
+		 */
+		if (d_mountpoint(dentry)) {
+			if (!autofs4_follow_mount(&nd->mnt, &nd->dentry)) {
+				status = -ENOENT;
+				goto out_error;
+			}
+		}
+
 		goto done;
 	}
 	spin_unlock(&dcache_lock);
 
-	if (!autofs4_follow_mount(&nd->mnt, &nd->dentry)) {
-		status = -ENOENT;
-		goto out_error;
-	}
-
 done:
 	return NULL;
 
