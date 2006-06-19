Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWFSRS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWFSRS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWFSRSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:18:55 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:15849 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964812AbWFSRSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:18:54 -0400
Subject: Re: [RFC][PATCH 11/20] elevate write count over calls to
	vfs_rename()
From: Dave Hansen <haveblue@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at, Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <20060618182359.GY27946@ftp.linux.org.uk>
References: <20060616231213.D4C5D6AF@localhost.localdomain>
	 <20060616231221.C30C0D59@localhost.localdomain>
	 <20060618182359.GY27946@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 10:18:48 -0700
Message-Id: <1150737528.10515.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-18 at 19:23 +0100, Al Viro wrote:
> 	a) nfsd_rename() should check that tfhp->fh_export->ex_mnt ==
> ffhp->fh_export->ex_mnt (if not that tfhp->fh_export == ffhp->fh_export)
> instead of comparing ->i_sb
> 	b) that patch should do mnt_want_write() only once.

Here's a replacement.

diff -puN fs/nfsd/vfs.c~C-elevate-writers-vfs_rename-part1 fs/nfsd/vfs.c
--- lxc/fs/nfsd/vfs.c~C-elevate-writers-vfs_rename-part1        2006-06-19 08:43:10.000000000 -0700
+++ lxc-dave/fs/nfsd/vfs.c      2006-06-19 10:09:19.000000000 -0700
@@ -1597,13 +1597,21 @@ nfsd_rename(struct svc_rqst *rqstp, stru
                        err = -EPERM;
        } else
 #endif
+       err = -EXDEV
+       if (ffhp->fh_export->ex_mnt != tfhp->fh_export->ex_mnt)
+               goto out_dput_new;
+
+       err = mnt_want_write(ffhp->fh_export->ex_mnt);
+       if (err)
+               goto out_dput_new;
+
        err = vfs_rename(fdir, odentry, tdir, ndentry);
        if (!err && EX_ISSYNC(tfhp->fh_export)) {
                err = nfsd_sync_dir(tdentry);
                if (!err)
                        err = nfsd_sync_dir(fdentry);
        }
-
+       mnt_drop_write(ffhp->fh_export->ex_mnt);
  out_dput_new:
        dput(ndentry);
  out_dput_old:



-- Dave

