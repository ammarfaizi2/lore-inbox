Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVEQBXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVEQBXp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 21:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVEQBXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 21:23:45 -0400
Received: from mail.shareable.org ([81.29.64.88]:32215 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261581AbVEQBXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 21:23:36 -0400
Date: Tue, 17 May 2005 02:23:25 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] namespace.c: fix bind mount from foreign namespace
Message-ID: <20050517012325.GB32226@mail.shareable.org>
References: <E1DXlcQ-0005h6-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DXlcQ-0005h6-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> Bind mount from a foreign namespace results in an un-removable mount.
> The reason is that mnt->mnt_namespace is copied from the old mount in
> clone_mnt().  Because of this check_mnt() in sys_umount() will fail.
> 
> The solution is to set mnt->mnt_namespace to current->namespace in
> clone_mnt().  clone_mnt() is either called from do_loopback() or
> copy_tree().  copy_tree() is called from do_loopback() or
> copy_namespace().
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

This patch is correct.  The old code was buggy for more fundamental
and serious reason: it broke the invariant that a tree of vfsmnts all
have the same value of mnt_namespace (and the same for the mnt_list
list).

Signed-off-by: Jamie Lokier <jamie@shareable.org>

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
