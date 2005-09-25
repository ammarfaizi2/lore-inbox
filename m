Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVIYB00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVIYB00 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 21:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbVIYB00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 21:26:26 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:48140 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1750801AbVIYB0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 21:26:25 -0400
Date: Sun, 25 Sep 2005 09:25:37 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Jeff Moyer <jmoyer@redhat.com>
cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
In-Reply-To: <17205.48192.180623.885538@segfault.boston.redhat.com>
Message-ID: <Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
 <17203.7543.949262.883138@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
 <17205.48192.180623.885538@segfault.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-101.4, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, RCVD_IN_ORBS,
	RCVD_IN_OSIRUSOFT_COM, REFERENCES, REPLY_WITH_QUOTES,
	USER_AGENT_PINE, USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005, Jeff Moyer wrote:

> >> >> 
> >> >> Ian, I'm not really sure how we can address this issue without VFS >>
> >> changes.  Any ideas?
> >> >> 
> >> 
> raven> I'm aware of this problem.  I'm not sure how to deal with it yet.
> raven> The case above is probably not that difficult to solve but if the
> raven> last component is a directory it's hard to work out it's a problem.
> >> Ugh.  If you're thinking what I think you're thinking, that's an ugly
> >> hack.
> 
> raven> Don't think so.
> 
> raven> I've been seeing this for a while. I wasn't quite sure of the source
> raven> but, for some reason your report has cleared that up.
> 
> raven> The problem is not so much the success returned on the failed mount
> raven> (revalidate). It's the return from the following lookup. This is a
> raven> lookup in a non-root directory. I replaced the non-root lookup with
> raven> the root lookup a while ago and I think this is an unexpected side
> raven> affect of that. Becuase of other changes that lead to that decision
> raven> I think that it should be now be OK to put back the null function
> raven> (always return a negative dentry) that was there before I started
> raven> working on the browable maps feature.
> 
> raven> I'll change the module I use here and test it out for a while.  If
> raven> you have time I could make a patch for the 2.4 code and send it over
> raven> so that you could test it out a bit as well.
> 
> Just send along the 2.6 patch, since I have to deal with that, too.  I'll
> go through the trouble of backporting it.

I'm in the middle of working on lazy multi-mounts atm so I'm not in a good 
position to test. It's a little tricky so I don't want to forget where I'm 
at by getting side tracked.

But here's the patch that I will apply to my v5 tree for the initial 
testing. Hopefully you will be able to give it a run in a standard setup.

Ian

diff -Nurp linux-2.6.12.orig/fs/autofs4/root.c linux-2.6.12/fs/autofs4/root.c
--- linux-2.6.12.orig/fs/autofs4/root.c	2005-06-18 03:48:29.000000000 +0800
+++ linux-2.6.12/fs/autofs4/root.c	2005-09-25 09:15:11.000000000 +0800
@@ -28,7 +28,8 @@ static int autofs4_dir_open(struct inode
 static int autofs4_dir_close(struct inode *inode, struct file *file);
 static int autofs4_dir_readdir(struct file * filp, void * dirent, filldir_t filldir);
 static int autofs4_root_readdir(struct file * filp, void * dirent, filldir_t filldir);
-static struct dentry *autofs4_lookup(struct inode *,struct dentry *, struct nameidata *);
+static struct dentry *autofs4_root_lookup(struct inode *,struct dentry *, struct nameidata *);
+static struct dentry *autofs4_dir_lookup(struct inode *,struct dentry *, struct nameidata *);
 static int autofs4_dcache_readdir(struct file *, void *, filldir_t);
 
 struct file_operations autofs4_root_operations = {
@@ -47,7 +48,7 @@ struct file_operations autofs4_dir_opera
 };
 
 struct inode_operations autofs4_root_inode_operations = {
-	.lookup		= autofs4_lookup,
+	.lookup		= autofs4_root_lookup,
 	.unlink		= autofs4_dir_unlink,
 	.symlink	= autofs4_dir_symlink,
 	.mkdir		= autofs4_dir_mkdir,
@@ -55,7 +56,7 @@ struct inode_operations autofs4_root_ino
 };
 
 struct inode_operations autofs4_dir_inode_operations = {
-	.lookup		= autofs4_lookup,
+	.lookup		= autofs4_dir_lookup,
 	.unlink		= autofs4_dir_unlink,
 	.symlink	= autofs4_dir_symlink,
 	.mkdir		= autofs4_dir_mkdir,
@@ -438,8 +439,19 @@ static struct dentry_operations autofs4_
 	.d_release	= autofs4_dentry_release,
 };
 
+static struct dentry *autofs4_dir_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
+{
+	DPRINTK(("ignoring lookup of %.*s/%.*s\n",
+		dentry->d_parent->d_name.len, dentry->d_parent->d_name.name,
+		dentry->d_name.len, dentry->d_name.name));
+
+	dentry->d_fsdata = NULL;
+	d_add(dentry, NULL);
+	return NULL;
+}
+
 /* Lookups in the root directory */
-static struct dentry *autofs4_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
+static struct dentry *autofs4_root_lookup(struct inode *dir, struct dentry *dentry, struct nameidata *nd)
 {
 	struct autofs_sb_info *sbi;
 	int oz_mode;
