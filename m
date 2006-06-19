Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWFSEE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWFSEE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 00:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWFSEE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 00:04:57 -0400
Received: from 1wt.eu ([62.212.114.60]:58888 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750711AbWFSEE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 00:04:57 -0400
Date: Mon, 19 Jun 2006 06:01:52 +0200
From: Willy Tarreau <w@1wt.eu>
To: Grant Coady <gcoady.lk@gmail.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060619040152.GB2678@1wt.eu>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <20060618133718.GA2467@dmt> <ksib9210010mt9r3gjevi3dhlp4biqf59k@4ax.com> <20060618223736.GA4965@1wt.eu> <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 09:07:03AM +1000, Grant Coady wrote:
> On Mon, 19 Jun 2006 00:37:36 +0200, Willy Tarreau <w@1wt.eu> wrote:
> 
> >Hi Grant,
> >
> >On Mon, Jun 19, 2006 at 08:25:06AM +1000, Grant Coady wrote:
> >> On Sun, 18 Jun 2006 10:37:18 -0300, Marcelo Tosatti <marcelo@kvack.org> wrote:
> >> 
> >> >Can you please try the attached patch.
> >> >
> >> >Grab a reference to the victim inode before calling vfs_unlink() to avoid
> >> >it vanishing under us.
> >> >
> >> >diff --git a/fs/namei.c b/fs/namei.c
> >> >index 42cce98..7993283 100644
> >> >--- a/fs/namei.c
> >> >+++ b/fs/namei.c
> >> >@@ -1509,6 +1509,7 @@ asmlinkage long sys_unlink(const char * 
> >> > 	char * name;
> >> > 	struct dentry *dentry;
> >> > 	struct nameidata nd;
> >> >+	struct inode *inode = NULL;
> >> > 
> >> > 	name = getname(pathname);
> >> > 	if(IS_ERR(name))
> >> >@@ -1527,11 +1528,16 @@ asmlinkage long sys_unlink(const char * 
> >> > 		/* Why not before? Because we want correct error value */
> >> > 		if (nd.last.name[nd.last.len])
> >> > 			goto slashes;
> >> >+		inode = dentry->d_inode;
> >> >+		if (inode)
> >> >+			atomic_inc(&inode->i_count);
> >> > 		error = vfs_unlink(nd.dentry->d_inode, dentry);
> >> > 	exit2:
> >> > 		dput(dentry);
> >> > 	}
> >
> >Could you add this line here, because your oops still looks like the NULL
> >is close to this area :
> >
> >+       printk(KERN_DEBUG "nd.dentry->d_inode = %p\n", nd.dentry->d_inode);
> 
> It didn't get there for the segfault case, gets there for local file 
> delete 
> 
> After:
> grant@sempro:~$ dmesg >dmesg
> grant@sempro:~$ rm dmesg
> 
> Jun 19 08:49:17 sempro kernel: nd.dentry->d_inode = f73f4b80
> 
> After:
> grant@sempro:~$ dmesg >/home/share/dmesg-test
> grant@sempro:~$ rm /home/share/dmesg-test
> Segmentation fault
> 
> Nothing reported by debug or syslog, oops in messages.

Thanks. Then, could you send us your 'namei.o' file please ? Mine does
not produce the same content as yours and it makes it difficult to find
the exact position in the code.

Cheers,
Willy

