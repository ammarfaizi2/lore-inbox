Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbTB0Ucj>; Thu, 27 Feb 2003 15:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTB0Ucj>; Thu, 27 Feb 2003 15:32:39 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:42369 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267081AbTB0Ucg>; Thu, 27 Feb 2003 15:32:36 -0500
Date: Thu, 27 Feb 2003 14:42:50 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Valdis.Kletnieks@vt.edu
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 - if/ifdef janitor work - actual bug found..
In-Reply-To: <200302271946.h1RJkAJT010712@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.44.0302271440000.1074-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2003 Valdis.Kletnieks@vt.edu wrote:

> The previous patches cleaned things up enough that -Wundef doesn't trigger
> a lot of false positives.. which made this one visible.  There's no other
> occurrence of MAX_OWNER_OVERRIDE in the tree, and it's obviously not
> MAY_OWNER_OVERRIDE either.  Looks like just remaindered cruft that I've
> cleaned up....
> 
> --- include/linux/nfsd/nfsd.h.dist	2003-02-24 14:06:01.000000000 -0500
> +++ include/linux/nfsd/nfsd.h	2003-02-27 00:21:53.957428476 -0500
> @@ -39,7 +39,7 @@
>  #define MAY_LOCK		32
>  #define MAY_OWNER_OVERRIDE	64
>  #define	MAY_LOCAL_ACCESS	128 /* IRIX doing local access check on device special file*/
> -#if (MAY_SATTR | MAY_TRUNC | MAY_LOCK | MAX_OWNER_OVERRIDE | MAY_LOCAL_ACCESS) & (MAY_READ | MAY_WRITE | MAY_EXEC | MAY_OWNER_OVERRIDE)
> +#if (MAY_SATTR | MAY_TRUNC | MAY_LOCK | MAY_LOCAL_ACCESS) & (MAY_READ | MAY_WRITE | MAY_EXEC | MAY_OWNER_OVERRIDE)
>  # error "please use a different value for MAY_SATTR or MAY_TRUNC or MAY_LOCK or MAY_OWNER_OVERRIDE."
>  #endif
>  #define MAY_CREATE		(MAY_EXEC|MAY_WRITE)


Why couldn't it be MAY_OWNER_OVERRIDE??? There are occurrences of 
MAY_OWNER_OVERRIDE
What about the following in fs/nfsd/vfs.c ??

/*
 * Set various file attributes.
 * N.B. After this call fhp needs an fh_put
 */
int
nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr 
*iap,
             int check_guard, time_t guardtime)
{
        struct dentry   *dentry;
        struct inode    *inode;
        int             accmode = MAY_SATTR;
        int             ftype = 0;
        int             imode;
        int             err;
        int             size_change = 0;

        if (iap->ia_valid & (ATTR_ATIME | ATTR_MTIME | ATTR_SIZE))
                accmode |= MAY_WRITE|MAY_OWNER_OVERRIDE;
        if (iap->ia_valid & ATTR_SIZE)
                ftype = S_IFREG;


Or this ???

        /* The size case is special. It changes the file as well as the 
attributes.  */
        if (iap->ia_valid & ATTR_SIZE) {
                if (iap->ia_size < inode->i_size) {
                        err = nfsd_permission(fhp->fh_export, dentry, 
MAY_TRUNC|MAY_OWNER_OVERRIDE);
                        if (err)
                                goto out;
                }


Or this ???

        /*
         * If we get here, then the client has already done an "open",
         * and (hopefully) checked permission - so allow OWNER_OVERRIDE
         * in case a chmod has now revoked permission.
         */
        err = fh_verify(rqstp, fhp, type, access | MAY_OWNER_OVERRIDE);
        if (err)
                goto out;




