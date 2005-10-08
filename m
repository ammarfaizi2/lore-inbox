Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbVJHJlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbVJHJlj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 05:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVJHJlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 05:41:39 -0400
Received: from main.gmane.org ([80.91.229.2]:42974 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750824AbVJHJli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 05:41:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Felix_M=F6ller?= <felixmoeller@gmx.de>
Subject: Re: pivot_root doesn't work for me in 2.6.14-rc3
Date: Sat, 08 Oct 2005 11:23:37 +0200
Message-ID: <43479019.6070803@gmx.de>
References: <Pine.LNX.4.62.0510061555190.12337@www.mcquillansystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
Cc: miklos@szeredi.hu
X-Gmane-NNTP-Posting-Host: dslb-082-083-127-023.pools.arcor-ip.net
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: de-DE, de, en-us, en
In-Reply-To: <Pine.LNX.4.62.0510061555190.12337@www.mcquillansystems.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
> I've found a problem with pivot_root that worked fine in 2.6.13.3, but
> fails for me, starting in 2.6.14-rc3  (haven't tried rc1 or rc2).
> 
> This is for LTSP.org (Linux Terminal Server Project) thin clients.
> 
> In our initramfs, we have a '/init' script that creates a mountpoint for
> a 2nd ramfs, and i'm trying to pivot_root to that mount point.
> 
> I'm getting:
> 
>    pivot_root: Invalid Argument
> 
> This worked perfectly in 2.6.13.3, so I looked at the 2.6.14-rc3 patch,
> and I found the code in fs/namespace.c that is causing it to fail for
> me:
> 
> @@ -1334,8 +1332,12 @@ asmlinkage long sys_pivot_root(const cha
>         error = -EINVAL;
>         if (user_nd.mnt->mnt_root != user_nd.dentry)
>                 goto out2; /* not a mountpoint */
> +       if (user_nd.mnt->mnt_parent == user_nd.mnt)
> +               goto out2; /* not attached */
>         if (new_nd.mnt->mnt_root != new_nd.dentry)
>                 goto out2; /* not a mountpoint */
> +       if (new_nd.mnt->mnt_parent == new_nd.mnt)
> +               goto out2; /* not attached */
>         tmp = old_nd.mnt; /* make sure we can reach put_old from
> new_root */
>         spin_lock(&vfsmount_lock);
>         if (tmp != new_nd.mnt) {
> 
> 
> The first of the 2 new tests are causing the pivot_root to fail for me.
> If I comment out those lines, it works again.
> 
> I'm thinking that somebody put those lines there for a reason, so
> there's possibly something wrong with the way i've been doing this for a
> long time, and the tightening of the code has uncovered my problem.
Miklos Szeredi put these lines there with the following comment:
"[PATCH] pivot_root() circular reference fix

Fix http://bugzilla.kernel.org/show_bug.cgi?id=4857

When pivot_root is called from an init script in an initramfs 
environment, it causes a circular reference in the mount tree.

The cause of this is that pivot_root() is not prepared to handle 
pivoting an unattached mount. In an initramfs environment, rootfs is the 
root of the namespace, and so it is not attached.

This patch fixes this and related problems, by returning -EINVAL if 
either the current root or the new root is detached."

> I'll explain how we use the initramfs/nfsroot:
> [...]
> 
> Somebody recently told me that pivot_root has been put in the 'evil way
> to do things' category, and that there was a new way, but he couldn't
> remember what that was.
googeling a little bit I found the following link:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=137005

Felix Möller

