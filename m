Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWE3Kpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWE3Kpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWE3Kpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:45:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:31458 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932246AbWE3Kpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:45:38 -0400
Date: Tue, 30 May 2006 11:45:32 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] NFS: Permit filesystem to override root dentry on mount [try #10]
Message-ID: <20060530104532.GW27946@ftp.linux.org.uk>
References: <20060519154640.11791.2928.stgit@warthog.cambridge.redhat.com> <20060519154644.11791.72373.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519154644.11791.72373.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 04:46:45PM +0100, David Howells wrote:
>  informative error value to report).  Call it foo_fill_super().  Now declare
>  
> -struct super_block foo_get_sb(struct file_system_type *fs_type,
> -	int flags, const char *dev_name, void *data)
> +int foo_get_sb(struct file_system_type *fs_type,
> +	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
>  {
> -	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super);
> +	return get_sb_bdev(fs_type, flags, dev_name, data, ext2_fill_super,
> +			   mnt);
>  }

BTW, s/ext2_fill_super/foo_fill_super/, while we are at it...

> +	BUG_ON(!mnt->mnt_sb);
> +	BUG_ON(!mnt->mnt_sb->s_root);
> +	BUG_ON(!mnt->mnt_root);

FWIW, I'm not sure it's needed.  We do
> +	up_write(&mnt->mnt_sb->s_umount);

soon enough and it will catch all likely breakage without cluttering
the code with BUG_ON().  Other than that, no objections.
