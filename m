Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWFRWdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWFRWdW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 18:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWFRWdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 18:33:22 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:37347 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750734AbWFRWdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 18:33:21 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@w.ods.org>,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Date: Mon, 19 Jun 2006 08:33:19 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <oqkb925d1kvcf3bjuckuniee9dm1h1lmrs@4ax.com>
References: <20060616181419.GA15734@dmt> <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com> <20060618133718.GA2467@dmt>
In-Reply-To: <20060618133718.GA2467@dmt>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jun 2006 10:37:18 -0300, Marcelo Tosatti <marcelo@kvack.org> wrote:

>Can you please try the attached patch.
>
>Grab a reference to the victim inode before calling vfs_unlink() to avoid
>it vanishing under us.
>
>diff --git a/fs/namei.c b/fs/namei.c
>index 42cce98..7993283 100644
>--- a/fs/namei.c
>+++ b/fs/namei.c
>@@ -1509,6 +1509,7 @@ asmlinkage long sys_unlink(const char * 
> 	char * name;
> 	struct dentry *dentry;
> 	struct nameidata nd;
>+	struct inode *inode = NULL;
> 
> 	name = getname(pathname);
> 	if(IS_ERR(name))
>@@ -1527,11 +1528,16 @@ asmlinkage long sys_unlink(const char * 
> 		/* Why not before? Because we want correct error value */
> 		if (nd.last.name[nd.last.len])
> 			goto slashes;
>+		inode = dentry->d_inode;
>+		if (inode)
>+			atomic_inc(&inode->i_count);
> 		error = vfs_unlink(nd.dentry->d_inode, dentry);
> 	exit2:
> 		dput(dentry);
> 	}
> 	up(&nd.dentry->d_inode->i_sem);
>+	if (inode)
>+		iput(inode);
> exit1:
> 	path_release(&nd);
> exit:

An odd thing happening is that after editing /etc/lilo.conf I get the 
vim backup file: "/etc/lilo.co~" instead of "/etc/lilo.conf~" -- this 
was happening before the above patch, with -rc1.  Very weird.  I'm 
editing lilo.conf to have the box reboot to 2.6.16.20, since it is 
semi-headless (has KVM, but I usually it run via ssh terminal).

Grant.
