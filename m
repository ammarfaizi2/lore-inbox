Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313492AbSEVNaF>; Wed, 22 May 2002 09:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSEVNaE>; Wed, 22 May 2002 09:30:04 -0400
Received: from news.cistron.nl ([195.64.68.38]:62987 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S313254AbSEVNaC>;
	Wed, 22 May 2002 09:30:02 -0400
From: Rene Blokland <reneb@orac.aais.org>
Subject: Re: OOPS kernel2.5.17 in vatfs? !SOLVED!
Date: Wed, 22 May 2002 15:00:56 +0200
Organization: Cistron
Message-ID: <slrnaen5k7.ae.reneb@orac.aais.org>
In-Reply-To: <slrnaekbe3.4u.reneb@orac.aais.org> <87vg9ha6lc.fsf@devron.myhome.or.jp>
Reply-To: reneb@cistron.nl
X-Trace: ncc1701.cistron.net 1022074202 17123 195.64.94.30 (22 May 2002 13:30:02 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi OGAWA Hirofumi san
This solves the oops pervect please sent it to Linus san
Thank you for ypour help!

In article <87vg9ha6lc.fsf@devron.myhome.or.jp>, OGAWA Hirofumi wrote:
>
> --- linux-cvs/fs/vfat/namei.c.orig	Tue May 21 21:59:42 2002
> +++ linux-cvs/fs/vfat/namei.c	Tue May 21 21:58:25 2002
> @@ -1020,16 +1020,12 @@
>  	unlock_kernel();
>  	dentry->d_op = &vfat_dentry_ops[table];
>  	dentry->d_time = dentry->d_parent->d_inode->i_version;
> -	if (inode) {
> -		dentry = d_splice_alias(inode, dentry);
> -		if (dentry) {
> -			dentry->d_op = &vfat_dentry_ops[table];
> -			dentry->d_time = dentry->d_parent->d_inode->i_version;
> -		}
> -		return dentry;
> +	dentry = d_splice_alias(inode, dentry);
> +	if (dentry) {
> +		dentry->d_op = &vfat_dentry_ops[table];
> +		dentry->d_time = dentry->d_parent->d_inode->i_version;
>  	}
> -	d_add(dentry,inode);
> -	return NULL;
> +	return dentry;
>  }
>
>  int vfat_create(struct inode *dir,struct dentry* dentry,int mode)
> --- linux-cvs/fs/msdos/namei.c.orig	Tue May 21 22:02:08 2002
> +++ linux-cvs/fs/msdos/namei.c	Tue May 21 22:01:46 2002
> @@ -221,22 +221,17 @@
>  	if (res)
>  		goto out;
>  add:
> -	if (inode) {
> -		dentry = d_splice_alias(inode, dentry);
> -		dentry->d_op = &msdos_dentry_operations;
> -	} else {
> -		d_add(dentry, inode);
> -		dentry = NULL;
> -	}
>  	res = 0;
> +	dentry = d_splice_alias(inode, dentry);
> +	if (dentry)
> +		dentry->d_op = &msdos_dentry_operations;
>  out:
>  	if (bh)
>  		fat_brelse(sb, bh);
>  	unlock_kernel();
> -	if (res)
> -		return ERR_PTR(res);
> -	else
> +	if (!res)
>  		return dentry;
> +	return ERR_PTR(res);
>  }
>
>  /***** Creates a directory entry (name is already formatted). */
>


--
Groeten / Regards, Rene J. Blokland

