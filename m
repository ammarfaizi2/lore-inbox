Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWFSRCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWFSRCX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWFSRCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:02:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:64412 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964798AbWFSRCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:02:21 -0400
Subject: Re: [RFC][PATCH 03/20] Add vfsmount writer count
From: Dave Hansen <haveblue@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at
In-Reply-To: <20060618183320.GZ27946@ftp.linux.org.uk>
References: <20060616231213.D4C5D6AF@localhost.localdomain>
	 <20060616231215.09D54036@localhost.localdomain>
	 <20060618183320.GZ27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 10:02:16 -0700
Message-Id: <1150736536.10515.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-18 at 19:33 +0100, Al Viro wrote:
> On Fri, Jun 16, 2006 at 04:12:15PM -0700, Dave Hansen wrote:
> > +/*
> > + * Must be called under write lock on mnt->mnt_sb->s_umount,
> > + * this prevents concurrent decrements which could make the
> > + * value -1, and test in mnt_want_write() wrongly succeed
> > + */
> > +static inline int mnt_make_readonly(struct vfsmount *mnt)
> > +{
> > +	if (!atomic_dec_and_test(&mnt->mnt_writers)) {
> > +		atomic_inc(&mnt->mnt_writers);
> > +		return -EBUSY;
> > +	}
> > +	return 0;
> > +}
> 
> Check in faccessat() could get screwed by that, if you just lose the
> race with final writer going away.  Then mnt_make_readonly() will 
> fail (as it should) and access(2) give -EROFS.

Very true.  How about this to fix it?

--- lxc/fs//open.c~C8.1-fix-faccesat    2006-06-19 09:59:41.000000000 -0700
+++ lxc-dave/fs//open.c 2006-06-19 10:01:25.000000000 -0700
@@ -546,8 +546,12 @@ asmlinkage long sys_faccessat(int dfd, c
           special_file(nd.dentry->d_inode->i_mode))
                goto out_path_release;

-       if(__mnt_is_readonly(nd.mnt) || IS_RDONLY(nd.dentry->d_inode))
-               res = -EROFS;
+       res = mnt_want_write(nd.mnt);
+       if (!res) {
+               mnt_drop_write(nd.mnt);
+               if(IS_RDONLY(nd.dentry->d_inode))
+                       res = -EROFS;
+       }

 out_path_release:
        path_release(&nd);


-- Dave

