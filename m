Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWCIBEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWCIBEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 20:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932694AbWCIBEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 20:04:01 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:25736
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932693AbWCIBEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 20:04:00 -0500
Date: Wed, 8 Mar 2006 17:03:42 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: maneesh@in.ibm.com, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: problem with duplicate sysfs directories and files
Message-ID: <20060309010342.GA13910@kroah.com>
References: <20060308075342.GA17718@kroah.com> <20060308010205.7e989a5a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308010205.7e989a5a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 01:02:05AM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > Hi,
> > 
> > I spent some time tonight trying to track down how to fix the issue of
> > duplicate sysfs files and/or directories.  This happens when you try to
> > create a kobject with the same name in the same directory.  The creation
> > of the second kobject will fail, but the directory will remain in sysfs.
> > 
> > Now I know this isn't a normal operation, but it would be good to fix
> > this eventually.  I traced the issue down to fs/sysfs/dir.c:create_dir()
> > and the check for:
> > 	if (error && (error != -EEXIST)) {
> > 
> > Problem is, error is set to -EEXIST, so we don't clean up properly.  Now
> > I know we can't just not check for this, as if you do that error
> > cleanup, the original kobject's sysfs entry gets very messed up (ls -l
> > does not like it at all...)
> > 
> > But I can't seem to figure out what exactly we need to do to clean up
> > properly here.
> > 
> > Do you, or anyone else, have any pointers or ideas?
> > 
> 
> Emit a loud warning and don't bother cleaning up - leave the current
> behaviour as-is.  Whatever takes the least amount code and has the minimum
> end-user impact, IMO.

Yeah, we do give a warning.  Well, we used to always do it, but now that
more people are not using kobject_register() but only kobject_add(), it
doesn't always show up...

Here's a patch that I've added to my queue that fixes the warn issue,
but it still would be nice to fix up sysfs someday.

thanks,

greg k-h


---
 lib/kobject.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- gregkh-2.6.orig/lib/kobject.c
+++ gregkh-2.6/lib/kobject.c
@@ -194,6 +194,17 @@ int kobject_add(struct kobject * kobj)
 		unlink(kobj);
 		if (parent)
 			kobject_put(parent);
+
+		/* be noisy on error issues */
+		if (error == -EEXIST)
+			printk("kobject_add failed for %s with -EEXIST, "
+			       "don't try to register things with the "
+			       "same name in the same directory.\n",
+			       kobject_name(kobj));
+		else
+			printk("kobject_add failed for %s (%d)\n",
+			       kobject_name(kobj), error);
+		dump_stack();
 	}
 
 	return error;
@@ -207,18 +218,13 @@ int kobject_add(struct kobject * kobj)
 
 int kobject_register(struct kobject * kobj)
 {
-	int error = 0;
+	int error = -EINVAL;
 	if (kobj) {
 		kobject_init(kobj);
 		error = kobject_add(kobj);
-		if (error) {
-			printk("kobject_register failed for %s (%d)\n",
-			       kobject_name(kobj),error);
-			dump_stack();
-		} else
+		if (!error)
 			kobject_uevent(kobj, KOBJ_ADD);
-	} else
-		error = -EINVAL;
+	}
 	return error;
 }
 
