Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbUKVNnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbUKVNnk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 08:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbUKVNlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 08:41:07 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:26530 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S262107AbUKVNkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 08:40:07 -0500
Subject: Re: [PATCH 2/5] selinux: adds a private inode operation
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Jeffrey Mahoney <jeffm@novell.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       James Morris <jmorris@redhat.com>
In-Reply-To: <20041121001318.GC979@locomotive.unixthugs.org>
References: <20041121001318.GC979@locomotive.unixthugs.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1101130521.18273.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 22 Nov 2004 08:35:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 19:13, Jeffrey Mahoney wrote:
<snip>
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

Shouldn't this be using dget_parent() for safety?

> @@ -2391,6 +2400,15 @@ static int selinux_inode_listsecurity(st
>  	return len;
>  }
>  
> +static void selinux_inode_mark_private(struct inode *inode)
> +{
> +	struct inode_security_struct *isec = inode->i_security;
> +
> +	isec->sid = SECINITSID_KERNEL;
> +	isec->initialized = 1;
> +	isec->inherit = 1;
> +}
> +

Don't we also need to modify inode_has_perm() to skip checking if the
inode has the kernel SID (as is already done by socket_has_perm) to
avoid the search checks when the reiserfs code looks up xattrs? 
Otherwise, we'll see access attempts by the process context on
directories with the kernel SID upon such lookups.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

