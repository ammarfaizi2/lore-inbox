Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbUKVRv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUKVRv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 12:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbUKVRpz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 12:45:55 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:6071 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262293AbUKVRmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 12:42:06 -0500
Subject: Re: [PATCH 2/5] selinux: adds a private inode operation
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeffrey Mahoney <jeffm@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Jeff Mahoney <jeffm@suse.com>
In-Reply-To: <20041121001318.GC979@locomotive.unixthugs.org>
References: <20041121001318.GC979@locomotive.unixthugs.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1101145050.18273.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 22 Nov 2004 12:37:30 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 19:13, Jeffrey Mahoney wrote:
> diff -ruNpX dontdiff linux-2.6.9/security/selinux/hooks.c linux-2.6.9.selinux/security/selinux/hooks.c
> --- linux-2.6.9/security/selinux/hooks.c	2004-11-19 14:40:58.000000000 -0500
> +++ linux-2.6.9.selinux/security/selinux/hooks.c	2004-11-20 17:11:22.000000000 -0500
> @@ -740,6 +740,15 @@ static int inode_doinit_with_dentry(stru
>  	if (isec->initialized)
>  		goto out;
>  
> +	if (opt_dentry && opt_dentry->d_parent && opt_dentry->d_parent->d_inode) {
> +		struct inode_security_struct *pisec = opt_dentry->d_parent->d_inode->i_security;
> +		if (pisec->inherit) {
> +			isec->sid = pisec->sid;
> +			isec->initialized = 1;
> +			goto out;
> +		}
> +	}
> +
>  	down(&isec->sem);
>  	hold_sem = 1;
>  	if (isec->initialized)

Actually, isn't this code unnecessary given that patch 3/5 ensures that
the selinux_inode_mark_private() hook is called from
reiserfs_new_inode() on the new inode if the directory is private?  I
think that eliminates the need to perform this test and inheritance in
inode_doinit, which is called by the d_instantiate.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

