Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVHSVj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVHSVj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 17:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbVHSVj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 17:39:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56726 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932219AbVHSVj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 17:39:26 -0400
Date: Fri, 19 Aug 2005 22:42:16 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>, vandrove@vc.cvut.cz,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel bug: Bad page state: related to generic symlink code and mmap
Message-ID: <20050819214215.GI29811@parcelfarce.linux.theplanet.co.uk>
References: <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk> <1124466246.2294.65.camel@imp.csi.cam.ac.uk> <Pine.LNX.4.58.0508190855350.3412@g5.osdl.org> <Pine.LNX.4.58.0508190913570.3412@g5.osdl.org> <Pine.LNX.4.58.0508190934470.3412@g5.osdl.org> <20050819165332.GD29811@parcelfarce.linux.theplanet.co.uk> <20050819180218.GE29811@parcelfarce.linux.theplanet.co.uk> <20050819180037.GA5686@infradead.org> <20050819193834.GF29811@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0508191323250.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508191323250.3412@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 01:35:49PM -0700, Linus Torvalds wrote:
> I'm not sure if this merits a new file or new organization (hey,
> fs/lib/xxx might be good in theory). In particular, I had actually been
> hoping to release 2.6.13 today, but this seems like a valid thing to hold 
> things up for - but not if we're going to re-organize things.
> 
> The one thing that strikes me is that we might actually have less pain if
> we just changed the calling convention for follow_link/put_link slightly
> instead of creating a new library function. The existing "page cache"  
> thing really _does_ work very well, and would work fine for NFS and ncpfs
> too, if we just allowed an extra cookie to be passed along from
> "follow_link()" to "put_link()".

Er...  We can do that, but current calling conventions for ->follow_link()
are already too complex (and we had bugs in that area).  What we have is
	1) you can return -error; then you must release nameidata yourself
and ->put_link() will _not_ be called.
	2) you can do nd_set_link(nd, ERR_PTR(-error)) and return 0
	3) you can do nd_set_link(nd, path) and return 0
	4) you can return 0 (after having moved nameidata yourself)
Note that in practice (2) is far more convenient than (1).  So pretty much
everything does it for errors and (1) turns out to be a source of bugs -
people forget to drop nameidata.  The only real case for (1) is failed
(4) - when we went too far and already dropped nameidata naturally.

Let me take a look at the current situation...
	* a bunch of filesystems do only (2) and (3).  That's the normal
case.
	* jffs2 follow_link() is broken - it has an exit where it returns
-EIO and leaks nameidata.
	* procfs special symlinks - (1) or (4), correctly used.
	* afs magic - (1) or (4), correctly used.
	* hppfs - badly broken for unrelated reasons.

Adding "you can return a cookie as long as it's not ERR_PTR() and it will
be treated like (2), (3) or (4), except that you won't want it in (4)" will
add to confusion.  And of course, we will have to update every ->put_link()
and ->follow_link() out there...

_If_ you want 2.6.13 with minimal PITA right now, I'd suggest leaving API
as is until 2.6.13-git1 and using stray_page_... + patch below to deal with
jffs2 until then.  Then we can deal with API change - immediately after
2.6.13 release.  Removing stray_... in process.

diff -urN RC13-rc6-git10-base/fs/jffs2/symlink.c current/fs/jffs2/symlink.c
--- RC13-rc6-git10-base/fs/jffs2/symlink.c	2005-08-10 10:37:52.000000000 -0400
+++ current/fs/jffs2/symlink.c	2005-08-19 17:35:52.000000000 -0400
@@ -30,6 +30,7 @@
 static int jffs2_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(dentry->d_inode);
+	char *p = (char *)f->dents;
 	
 	/*
 	 * We don't acquire the f->sem mutex here since the only data we
@@ -45,13 +46,14 @@
 	 * nd_set_link() call.
 	 */
 	
-	if (!f->dents) {
+	if (!p) {
 		printk(KERN_ERR "jffs2_follow_link(): can't find symlink taerget\n");
-		return -EIO;
+		p = ERR_PTR(-EIO);
+	} else {
+		D1(printk(KERN_DEBUG "jffs2_follow_link(): target path is '%s'\n", (char *) f->dents));
 	}
-	D1(printk(KERN_DEBUG "jffs2_follow_link(): target path is '%s'\n", (char *) f->dents));
 
-	nd_set_link(nd, (char *)f->dents);
+	nd_set_link(nd, p);
 	
 	/*
 	 * We unlock the f->sem mutex but VFS will use the f->dents string. This is safe
