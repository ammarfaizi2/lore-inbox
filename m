Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263265AbVFXWiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263265AbVFXWiz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 18:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbVFXWiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 18:38:54 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:63889 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263265AbVFXWeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 18:34:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lz0VgxdGHTG0mEAYq4nXcXjYRLzEm+99ky1SnbEafwGLVmcwBCJtSmx6Y3IXQZTVq/xlbRid8YCKP13B96iUKFPg3EuRO5HL8TCWuqYQcCQdqWDUHnNGJabk9DfOFl6IiQi9utTSX8TsvXaV1YecfQBtYPTH2l02QQyebOWcEZ8=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kambarov@berkeley.edu, zkambarov@coverity.com
Subject: Re: coverity-fs-udf-namei-null-check.patch added to -mm tree
Date: Sat, 25 Jun 2005 02:39:57 +0400
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <200506242122.j5OLMXeK013299@shell0.pdx.osdl.net>
In-Reply-To: <200506242122.j5OLMXeK013299@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506250239.59864.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 June 2005 01:23, akpm@osdl.org wrote:
> "dir" was dereferenced before null check

> --- 25/fs/udf/namei.c~coverity-fs-udf-namei-null-check
> +++ 25-akpm/fs/udf/namei.c
> @@ -159,7 +159,7 @@ udf_find_entry(struct inode *dir, struct
>  	char *nameptr;
>  	uint8_t lfi;
>  	uint16_t liu;
> -	loff_t size = (udf_ext0_offset(dir) + dir->i_size) >> 2;
> +	loff_t size;
>  	kernel_lb_addr bloc, eloc;
>  	uint32_t extoffset, elen, offset;
>  	struct buffer_head *bh = NULL;
> @@ -167,6 +167,8 @@ udf_find_entry(struct inode *dir, struct
>  	if (!dir)
>  		return NULL;
>  
> +	size = (udf_ext0_offset(dir) + dir->i_size) >> 2;
> +

Let's see...

udf_find_entry() is called from:
1. udf_lookup(dir, ...)
	udf_find_entry(dir, dentry, &fibh, &cfi);

2. udf_rmdir(dir, ...)
	udf_find_entry(dir, dentry, &fibh, &cfi);

3. udf_unlink(dir, ...)
	udf_find_entry(dir, dentry, &fibh, &cfi);

4. udf_rename(old_dir, old_dentry, new_dir, new_dentry)
	udf_find_entry(old_dir, old_dentry, &ofibh, &ocfi);
	udf_find_entry(new_dir, new_dentry, &nfibh, &ncfi);
	udf_find_entry(old_dir, old_dentry, &ofibh, &ocfi);

So the question boils down to:
Can one call 
	1. ->lookup(NULL, ...)			or
	2. ->rmdir(NULL, ...)			or
	3. ->unlink(NULL, ...)			or
	4a. ->rename(NULL, ..., ..., ...)	or
	4b. ->rename(..., ..., NULL, ...)	?

1.

fs/namei.c:416:                 result = dir->i_op->lookup(dir, dentry, nd);
fs/namei.c:1084:                dentry = inode->i_op->lookup(inode, new, nd);

2.

fs/namei.c:1797:                        error = dir->i_op->rmdir(dir, dentry);

3.

fs/namei.c:1871:                        error = dir->i_op->unlink(dir, dentry);

4.

fs/namei.c:2138:                error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
	=> Can one do vfs_rename_dir(..., ..., NULL, ...) ?
fs/namei.c:2172:                error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
	=> Can one do vfs_rename_other(..., ..., NULL, ...) ?

Both are called in vfs_rename(..., ..., new_dir, ...) where new_dir is passed
to may_create(new_dir, ..., ...) or may_delete(new_dir, ..., ...). Both
unconditionally dereference first argument.

Have I missed something?
