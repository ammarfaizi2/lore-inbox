Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWEZS3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWEZS3d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWEZS3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:29:33 -0400
Received: from kanga.kvack.org ([66.96.29.28]:11235 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751245AbWEZS3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:29:32 -0400
Date: Fri, 26 May 2006 15:27:58 -0300
From: Marcelo Tosatti <marcelo@kvack.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: Grant Coady <gcoady.lk@gmail.com>, linux-kernel@vger.kernel.org,
       Grant Coady <grant_lkml@dodo.com.au>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [ANNOUNCE] Linux-2.4.32-hf32.5
Message-ID: <20060526182758.GB565@dmt>
References: <20060507131034.GA19198@exosec.fr> <20060525133427.GA22727@w.ods.org> <k2nd725cl0vocvb72boalj06tpjlita644@4ax.com> <20060526121623.GA14474@w.ods.org> <vvvd72p7mv2j9fet19evm807e0flonnugh@4ax.com> <20060526140731.GC14725@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060526140731.GC14725@w.ods.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2006 at 04:07:31PM +0200, Willy Tarreau wrote:
> [ I removed Jari who told me yesterday he did not need to be Cc'd ]
> 
> On Fri, May 26, 2006 at 11:28:51PM +1000, Grant Coady wrote:
> > On Fri, 26 May 2006 14:16:23 +0200, Willy Tarreau <willy@w.ods.org> wrote:
> > 
> > >Could you please pass it through ksymoops so that we get an idea about the
> > >function causing this ? What was the last version not causing it ? hf32.4 ?
> > 
> > Yes, hf32.4 okay, see: <http://bugsplatter.mine.nu/test/linux-2.4/>
> > 
> > >This looks like a structure member gets accessed while a pointer is NULL,
> > >if you always get 0x88... I would be it could come from
> > >2.4.32-ext3-link-unlink-race-1, but that would be strange.
> > 
> > Good guess!  The previous version comment stripped .configs are 
> > linked by machine name from the summary page above.
> 
> Hmmm that's bad, this one has been merged into mainline.
> It would look like dentry->d_inode is NULL here :
> 
>   double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
> 
> I don't know how this can be fixed, though ! My first guess would be to
> quickly revert the patch. 

may_delete() should be called before attempting to grab victim's
i_zombie. Grant, can you please try the following?

diff --git a/fs/namei.c b/fs/namei.c
index 48bd26c..42cce98 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1479,19 +1479,20 @@ int vfs_unlink(struct inode *dir, struct
 {
 	int error;
 
-	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
 	error = may_delete(dir, dentry, 0);
-	if (!error) {
-		error = -EPERM;
-		if (dir->i_op && dir->i_op->unlink) {
-			DQUOT_INIT(dir);
-			if (d_mountpoint(dentry))
-				error = -EBUSY;
-			else {
-				lock_kernel();
-				error = dir->i_op->unlink(dir, dentry);
-				unlock_kernel();
-			}
+	if (error)
+		return error;
+
+	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
+	error = -EPERM;
+	if (dir->i_op && dir->i_op->unlink) {
+		DQUOT_INIT(dir);
+		if (d_mountpoint(dentry))
+			error = -EBUSY;
+		else {
+			lock_kernel();
+			error = dir->i_op->unlink(dir, dentry);
+			unlock_kernel();
 		}
 	}
 	double_up(&dir->i_zombie, &dentry->d_inode->i_zombie);
