Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbTHaLQO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 07:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbTHaLQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 07:16:14 -0400
Received: from ns.suse.de ([195.135.220.2]:9123 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261179AbTHaLQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 07:16:10 -0400
Subject: Re: 2.6.0-test4-mm3.1 oops with ext3 extended attributes on R/O
	filesystem
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030830214751.5baaab4c.akpm@osdl.org>
References: <200308310412.h7V4Cxd7013786@turing-police.cc.vt.edu>
	 <20030830214751.5baaab4c.akpm@osdl.org>
Content-Type: text/plain
Organization: SuSE Labs, SuSE Linux AG
Message-Id: <1062328746.2386.21.camel@bree.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Aug 2003 13:19:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2003-08-31 at 06:47, Andrew Morton wrote:
> Valdis.Kletnieks@vt.edu wrote:
> >
> > Working on installing SELINUX, and I get to the part where all the file labels
> >  get added.  Unfortunately, I had some file systems mounted R/O (intentionally,
> >  forgot to mount them R/W for this).  The ext3 code upchucked while trying
> >  to set extended attributes on the filesystem it couldn't write to.
> 
> Thanks.   It's a very straightforward bug; I'll fix it with the below patch.

Thanks for fixing.

> A wider question is whether we should have got this far into the filesystem
> code if the fs is mounted read-only.  A check right up at the VFS
> setxattr() level might make sense.

The read-only check is in ext3_xattr_set_handle(). My thinking was that
it should happen below the xattr handler level, so that attribute
classes with some sort of set behavior are possible on read-only file
systems as well. I'm not aware of an implementation that would need
this, though.

> Regardless of that, this fix is needed because journal_start() could fail
> for other reasons.

Yes.

> diff -puN fs/ext3/xattr.c~ext3-xattr-oops-fix fs/ext3/xattr.c
> --- 25/fs/ext3/xattr.c~ext3-xattr-oops-fix	2003-08-30 21:41:24.000000000 -0700
> +++ 25-akpm/fs/ext3/xattr.c	2003-08-30 21:42:41.000000000 -0700
> @@ -873,17 +873,22 @@ ext3_xattr_set(struct inode *inode, int 
>  	       const void *value, size_t value_len, int flags)
>  {
>  	handle_t *handle;
> -	int error, error2;
> +	int error;
>  
>  	handle = ext3_journal_start(inode, EXT3_DATA_TRANS_BLOCKS);
> -	if (IS_ERR(handle))
> +	if (IS_ERR(handle)) {
>  		error = PTR_ERR(handle);
> -	else
> +	} else {
> +		int error2;
> +
>  		error = ext3_xattr_set_handle(handle, inode, name_index, name,
>  					      value, value_len, flags);
> -	error2 = ext3_journal_stop(handle);
> +		error2 = ext3_journal_stop(handle);
> +		if (error == 0)
> +			error = error2;
> +	}
>  
> -	return error ? error : error2;
> +	return error;
>  }
>  
>  /*
> 
> _
-- 
Andreas Gruenbacher <agruen@suse.de>
SuSE Labs, SuSE Linux AG <http://www.suse.de/>


