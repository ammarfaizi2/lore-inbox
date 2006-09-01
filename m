Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWIAVwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWIAVwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 17:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWIAVwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 17:52:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5610 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751035AbWIAVwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 17:52:18 -0400
Date: Fri, 1 Sep 2006 14:52:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Access Control Lists for tmpfs
Message-Id: <20060901145203.d3880d1d.akpm@osdl.org>
In-Reply-To: <20060901221458.148480972@winden.suse.de>
References: <20060901221421.968954146@winden.suse.de>
	<20060901221458.148480972@winden.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Sep 2006 00:14:23 +0200
Andreas Gruenbacher <agruen@suse.de> wrote:

> +static void
> +shmem_set_acl(struct inode *inode, int type, struct posix_acl *acl)
> +{
> +	spin_lock(&inode->i_lock);
> +	switch(type) {
> +		case ACL_TYPE_ACCESS:
> +			if (SHMEM_I(inode)->i_acl)
> +				posix_acl_release(SHMEM_I(inode)->i_acl);
> +			SHMEM_I(inode)->i_acl = posix_acl_dup(acl);
> +			break;

i_lock is "general-purpose, innermost per-inode lock".  Calling kfree()
under it makes it no longer "innermost".  But kfree() is surely atomic wrt
everything which filesystems and the VFS will want to do, so that's OK.

However it does point at an inefficiency.  There's no need at all to be
holding onto that lock while running kfree().


-- 
VGER BF report: H 0
