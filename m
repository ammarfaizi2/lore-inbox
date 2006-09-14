Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWINOYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWINOYr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWINOYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:24:47 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:20170 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750794AbWINOYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:24:46 -0400
Subject: Re: [PATCH] JFS: return correct error when i-node allocation failed
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060914095227.GA4186@miraclelinux.com>
References: <20060914095227.GA4186@miraclelinux.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 09:24:35 -0500
Message-Id: <1158243875.15047.34.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 17:52 +0800, Akinobu Mita wrote:
> I have seen confusing behavior on JFS when I injected many intentional
> slab allocation errors. The cp command failed with no disk space error
> with enough disk space.

Thanks.  I'll push this upstream.

> 
> This patch makes:
> 
> - change the return value in case slab allocation failures happen
>   from -ENOSPC to -ENOMEM
> 
> - ialloc() return error code so that the caller can know the reason
>   of failures
> 
> Cc: Dave Kleikamp <shaggy@austin.ibm.com>
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
> 
>  fs/jfs/jfs_dtree.c   |    4 ++--
>  fs/jfs/jfs_inode.c   |    9 +++++----
>  fs/jfs/jfs_unicode.c |    2 +-
>  fs/jfs/namei.c       |   18 +++++++++---------
>  fs/jfs/super.c       |    2 +-
>  5 files changed, 18 insertions(+), 17 deletions(-)
> 
> Index: work-shouldfail/fs/jfs/jfs_inode.c
> ===================================================================
> --- work-shouldfail.orig/fs/jfs/jfs_inode.c
> +++ work-shouldfail/fs/jfs/jfs_inode.c
> @@ -61,7 +61,7 @@ struct inode *ialloc(struct inode *paren
>  	inode = new_inode(sb);
>  	if (!inode) {
>  		jfs_warn("ialloc: new_inode returned NULL!");
> -		return inode;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	jfs_inode = JFS_IP(inode);
> @@ -69,9 +69,10 @@ struct inode *ialloc(struct inode *paren
>  	rc = diAlloc(parent, S_ISDIR(mode), inode);
>  	if (rc) {
>  		jfs_warn("ialloc: diAlloc returned %d!", rc);
> -		make_bad_inode(inode);
> +		if (rc == -EIO)
> +			make_bad_inode(inode);
>  		iput(inode);
> -		return NULL;
> +		return ERR_PTR(rc);
>  	}
>  
>  	inode->i_uid = current->fsuid;
> @@ -97,7 +98,7 @@ struct inode *ialloc(struct inode *paren
>  		inode->i_flags |= S_NOQUOTA;
>  		inode->i_nlink = 0;
>  		iput(inode);
> -		return NULL;
> +		return ERR_PTR(-EDQUOT);
>  	}
>  
>  	inode->i_mode = mode;
> Index: work-shouldfail/fs/jfs/namei.c
> ===================================================================
> --- work-shouldfail.orig/fs/jfs/namei.c
> +++ work-shouldfail/fs/jfs/namei.c
> @@ -97,8 +97,8 @@ static int jfs_create(struct inode *dip,
>  	 * begin the transaction before we search the directory.
>  	 */
>  	ip = ialloc(dip, mode);
> -	if (ip == NULL) {
> -		rc = -ENOSPC;
> +	if (IS_ERR(ip)) {
> +		rc = PTR_ERR(ip);
>  		goto out2;
>  	}
>  
> @@ -231,8 +231,8 @@ static int jfs_mkdir(struct inode *dip, 
>  	 * begin the transaction before we search the directory.
>  	 */
>  	ip = ialloc(dip, S_IFDIR | mode);
> -	if (ip == NULL) {
> -		rc = -ENOSPC;
> +	if (IS_ERR(ip)) {
> +		rc = PTR_ERR(ip);
>  		goto out2;
>  	}
>  
> @@ -908,8 +908,8 @@ static int jfs_symlink(struct inode *dip
>  	 * (iAlloc() returns new, locked inode)
>  	 */
>  	ip = ialloc(dip, S_IFLNK | 0777);
> -	if (ip == NULL) {
> -		rc = -ENOSPC;
> +	if (IS_ERR(ip)) {
> +		rc = PTR_ERR(ip);
>  		goto out2;
>  	}
>  
> @@ -980,7 +980,7 @@ static int jfs_symlink(struct inode *dip
>  		xlen = xsize >> JFS_SBI(sb)->l2bsize;
>  		if ((rc = xtInsert(tid, ip, 0, 0, xlen, &xaddr, 0))) {
>  			txAbort(tid, 0);
> -			rc = -ENOSPC;
> +			rc = ERR_PTR(rc);

Compiler warning.  I just removed this line completely.

>  			goto out3;
>  		}
>  		extent = xaddr;
> @@ -1352,8 +1352,8 @@ static int jfs_mknod(struct inode *dir, 
>  		goto out;
>  
>  	ip = ialloc(dir, mode);
> -	if (ip == NULL) {
> -		rc = -ENOSPC;
> +	if (IS_ERR(ip)) {
> +		rc = PTR_ERR(ip);
>  		goto out1;
>  	}
>  	jfs_ip = JFS_IP(ip);
> Index: work-shouldfail/fs/jfs/jfs_dtree.c
> ===================================================================
> --- work-shouldfail.orig/fs/jfs/jfs_dtree.c
> +++ work-shouldfail/fs/jfs/jfs_dtree.c
> @@ -3780,13 +3780,13 @@ static int ciGetLeafPrefixKey(dtpage_t *
>  	lkey.name = (wchar_t *) kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t),
>  					GFP_KERNEL);
>  	if (lkey.name == NULL)
> -		return -ENOSPC;
> +		return -ENOMEM;
>  
>  	rkey.name = (wchar_t *) kmalloc((JFS_NAME_MAX + 1) * sizeof(wchar_t),
>  					GFP_KERNEL);
>  	if (rkey.name == NULL) {
>  		kfree(lkey.name);
> -		return -ENOSPC;
> +		return -ENOMEM;
>  	}
>  
>  	/* get left and right key */
> Index: work-shouldfail/fs/jfs/super.c
> ===================================================================
> --- work-shouldfail.orig/fs/jfs/super.c
> +++ work-shouldfail/fs/jfs/super.c
> @@ -422,7 +422,7 @@ static int jfs_fill_super(struct super_b
>  
>  	sbi = kzalloc(sizeof (struct jfs_sb_info), GFP_KERNEL);
>  	if (!sbi)
> -		return -ENOSPC;
> +		return -ENOMEM;
>  	sb->s_fs_info = sbi;
>  	sbi->sb = sb;
>  	sbi->uid = sbi->gid = sbi->umask = -1;
> Index: work-shouldfail/fs/jfs/jfs_unicode.c
> ===================================================================
> --- work-shouldfail.orig/fs/jfs/jfs_unicode.c
> +++ work-shouldfail/fs/jfs/jfs_unicode.c
> @@ -124,7 +124,7 @@ int get_UCSname(struct component_name * 
>  	    kmalloc((length + 1) * sizeof(wchar_t), GFP_NOFS);
>  
>  	if (uniName->name == NULL)
> -		return -ENOSPC;
> +		return -ENOMEM;
>  
>  	uniName->namlen = jfs_strtoUCS(uniName->name, dentry->d_name.name,
>  				       length, nls_tab);

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

