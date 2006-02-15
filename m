Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945900AbWBOJV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945900AbWBOJV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 04:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945901AbWBOJV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 04:21:28 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64655 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1945900AbWBOJV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 04:21:27 -0500
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] fix handling of st_nlink on procfs root
References: <E1F6vyO-00009r-3a@ZenIV.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Feb 2006 02:20:17 -0700
In-Reply-To: <E1F6vyO-00009r-3a@ZenIV.linux.org.uk> (Al Viro's message of
 "Wed, 08 Feb 2006 20:31:32 +0000")
Message-ID: <m1slql3rn2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> writes:

> Date: 1139427460 -0500
>
> 1) it should use nr_processes(), not nr_threads; otherwise we are getting
> very confused find(1) and friends, among other things.
> 2) better do that at stat() time than at every damn lookup in procfs root.
>
> Patch had been sitting in FC4 kernels for many months now...

And it is actually wrong.  It fails to take into account the static
/proc entries.

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 6889628..c3fd361 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -80,16 +80,16 @@ void __init proc_root_init(void)
>  	proc_bus = proc_mkdir("bus", NULL);
>  }
>  
> -static struct dentry *proc_root_lookup(struct inode * dir, struct dentry *
> dentry, struct nameidata *nd)
> +static int proc_root_getattr(struct vfsmount *mnt, struct dentry *dentry,
> struct kstat *stat
> +)
>  {
> -	/*
> -	 * nr_threads is actually protected by the tasklist_lock;
> -	 * however, it's conventional to do reads, especially for
> -	 * reporting, without any locking whatsoever.
> -	 */
> -	if (dir->i_ino == PROC_ROOT_INO) /* check for safety... */
> -		dir->i_nlink = proc_root.nlink + nr_threads;
> +	generic_fillattr(dentry->d_inode, stat);
> +	stat->nlink = proc_root.nlink + nr_processes();
> +	return 0;
> +}


proc_root_getattr should look more like below.
Notice the addition of de->nlink, which accounts for the
static entries as well.  

static int proc_root_getattr(struct vfsmount *mnt, struct dentry *dentry,
                               struct kstat *stat)
{
       struct inode *inode = dentry->d_inode;
       struct proc_dir_entry *de = PDE(inode);
       generic_fillattr(inode, stat);

       if (de && de->nlink)
               inode->i_nlink = de->nlink;

       /* Get the proper hardlink count */
       stat->nlink += nr_processes();
       return 0;

}
