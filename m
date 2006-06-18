Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWFRSYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWFRSYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWFRSYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:24:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9135 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751185AbWFRSYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:24:01 -0400
Date: Sun, 18 Jun 2006 19:23:59 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [RFC][PATCH 11/20] elevate write count over calls to vfs_rename()
Message-ID: <20060618182359.GY27946@ftp.linux.org.uk>
References: <20060616231213.D4C5D6AF@localhost.localdomain> <20060616231221.C30C0D59@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616231221.C30C0D59@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 04:12:21PM -0700, Dave Hansen wrote:
> +	err = mnt_want_write(ffhp->fh_export->ex_mnt);
> +	if (err)
> +		goto out_dput_new;
> +
> +	err = mnt_want_write(tfhp->fh_export->ex_mnt);
> +	if (err)
> +		goto out_mnt_drop_write_old;
> +
>  	err = vfs_rename(fdir, odentry, tdir, ndentry);
>  	if (!err && EX_ISSYNC(tfhp->fh_export)) {
>  		err = nfsd_sync_dir(tdentry);
>  		if (!err)
>  			err = nfsd_sync_dir(fdentry);
>  	}
> -
> +	mnt_drop_write(tfhp->fh_export->ex_mnt);
> + out_mnt_drop_write_old:
> +	mnt_drop_write(ffhp->fh_export->ex_mnt);

Ahem...
	a) nfsd_rename() should check that tfhp->fh_export->ex_mnt ==
ffhp->fh_export->ex_mnt (if not that tfhp->fh_export == ffhp->fh_export)
instead of comparing ->i_sb
	b) that patch should do mnt_want_write() only once.
