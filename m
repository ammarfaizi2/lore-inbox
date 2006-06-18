Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWFRWk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWFRWk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWFRWk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:40:56 -0400
Received: from 1wt.eu ([62.212.114.60]:56840 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750781AbWFRWkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:40:55 -0400
Date: Mon, 19 Jun 2006 00:40:41 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060618224041.GB4965@1wt.eu>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <20060618133718.GA2467@dmt> <oqkb925d1kvcf3bjuckuniee9dm1h1lmrs@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oqkb925d1kvcf3bjuckuniee9dm1h1lmrs@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:33:19AM +1000, Grant Coady wrote:
> On Sun, 18 Jun 2006 10:37:18 -0300, Marcelo Tosatti <marcelo@kvack.org> wrote:
> 
> >Can you please try the attached patch.
> >
> >Grab a reference to the victim inode before calling vfs_unlink() to avoid
> >it vanishing under us.
> >
> >diff --git a/fs/namei.c b/fs/namei.c
> >index 42cce98..7993283 100644
> >--- a/fs/namei.c
> >+++ b/fs/namei.c
> >@@ -1509,6 +1509,7 @@ asmlinkage long sys_unlink(const char * 
> > 	char * name;
> > 	struct dentry *dentry;
> > 	struct nameidata nd;
> >+	struct inode *inode = NULL;
> > 
> > 	name = getname(pathname);
> > 	if(IS_ERR(name))
> >@@ -1527,11 +1528,16 @@ asmlinkage long sys_unlink(const char * 
> > 		/* Why not before? Because we want correct error value */
> > 		if (nd.last.name[nd.last.len])
> > 			goto slashes;
> >+		inode = dentry->d_inode;
> >+		if (inode)
> >+			atomic_inc(&inode->i_count);
> > 		error = vfs_unlink(nd.dentry->d_inode, dentry);
> > 	exit2:
> > 		dput(dentry);
> > 	}
> > 	up(&nd.dentry->d_inode->i_sem);
> >+	if (inode)
> >+		iput(inode);
> > exit1:
> > 	path_release(&nd);
> > exit:
> 
> An odd thing happening is that after editing /etc/lilo.conf I get the 
> vim backup file: "/etc/lilo.co~" instead of "/etc/lilo.conf~" -- this 
> was happening before the above patch, with -rc1.  Very weird.  I'm 
> editing lilo.conf to have the box reboot to 2.6.16.20, since it is 
> semi-headless (has KVM, but I usually it run via ssh terminal).

OK, if you doubt about the kernel you're running, the build # and date are
reported by 'uname -a'. I often abuse this because sometimes I'm not sure
about what I see !

> Grant.

Cheers,
Willy

