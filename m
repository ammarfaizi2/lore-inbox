Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbVEMQuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbVEMQuW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 12:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVEMQuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 12:50:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:47500 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262429AbVEMQt5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 12:49:57 -0400
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
References: <E1DWXeF-00017l-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1116002952.6248.361.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 May 2005 09:49:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 03:44, Miklos Szeredi wrote:
> Bind mount from a foreign namespace results in an un-removable mount.

i wonder, should we even allow the ability to bind mount 
from a foreign namespace?  

The only time this is allowed is while creating a new namespace.

RP


> The reason is that mnt->mnt_namespace is copied from the old mount in
> clone_mnt().  Because of this, check_mnt() in sys_umount() will fail.
> 
> The solution is to set mnt->mnt_namespace to current->namespace.
> 
> clone_mnt() is either called from do_loopback() or copy_tree().
> copy_tree() is called from do_loopback() or copy_namespace().
> 
> When called (directly or indirectly) from do_loopback(), always
> current->namspace is being modified: check_mnt(nd->mnt).  So setting
> mnt->mnt_namespace to current->namspace is the right thing to do.
> 
> When called from copy_namespace(), the setting of mnt_namespace is
> irrelevant, since mnt_namespace is reset later in that function for
> all copied mounts.


> 
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> 
> Index: linux/fs/namespace.c
> ===================================================================
> --- linux.orig/fs/namespace.c	2005-05-13 12:22:52.000000000 +0200
> +++ linux/fs/namespace.c	2005-05-13 12:32:36.000000000 +0200
> @@ -160,7 +160,7 @@ clone_mnt(struct vfsmount *old, struct d
>  		mnt->mnt_root = dget(root);
>  		mnt->mnt_mountpoint = mnt->mnt_root;
>  		mnt->mnt_parent = mnt;
> -		mnt->mnt_namespace = old->mnt_namespace;
> +		mnt->mnt_namespace = current->namespace;
>  
>  		/* stick the duplicate mount on the same expiry list
>  		 * as the original if that was on one */
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

