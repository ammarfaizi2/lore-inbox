Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVCYB66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVCYB66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVCYAtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 19:49:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56080 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261308AbVCYAP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 19:15:58 -0500
Date: Fri, 25 Mar 2005 01:15:56 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/attr.c: fix check after use
Message-ID: <20050325001556.GH3966@stusta.de>
References: <20050324011043.GI1948@stusta.de> <20050324031845.GG28536@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050324031845.GG28536@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2005 at 07:18:45PM -0800, Chris Wright wrote:
> * Adrian Bunk (bunk@stusta.de) wrote:
> > --- linux-2.6.12-rc1-mm1-full/fs/attr.c.old	2005-03-23 04:44:40.000000000 +0100
> > +++ linux-2.6.12-rc1-mm1-full/fs/attr.c	2005-03-23 04:45:40.000000000 +0100
> > @@ -112,7 +112,7 @@
> >  int notify_change(struct dentry * dentry, struct iattr * attr)
> >  {
> >  	struct inode *inode = dentry->d_inode;
> > -	mode_t mode = inode->i_mode;
> > +	mode_t mode;
> >  	int error;
> >  	struct timespec now = current_fs_time(inode->i_sb);
> 
> looks like same issue here too?
>...

You forgot to a attach a brown paperbag.  ;-)

Corrected patch below.

cu
Adrian


<--  snip  -->


This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm2-full/fs/attr.c.old	2005-03-25 01:02:32.000000000 +0100
+++ linux-2.6.12-rc1-mm2-full/fs/attr.c	2005-03-25 01:05:18.000000000 +0100
@@ -112,14 +112,17 @@
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
-	mode_t mode = inode->i_mode;
+	mode_t mode;
 	int error;
-	struct timespec now = current_fs_time(inode->i_sb);
+	struct timespec now;
 	unsigned int ia_valid = attr->ia_valid;
 
 	if (!inode)
 		BUG();
 
+	mode = inode->i_mode;
+	now = current_fs_time(inode->i_sb);
+
 	attr->ia_ctime = now;
 	if (!(ia_valid & ATTR_ATIME_SET))
 		attr->ia_atime = now;

