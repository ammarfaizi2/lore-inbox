Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbTAFT0b>; Mon, 6 Jan 2003 14:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbTAFT0b>; Mon, 6 Jan 2003 14:26:31 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:4320 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265102AbTAFT02>;
	Mon, 6 Jan 2003 14:26:28 -0500
Date: Mon, 6 Jan 2003 19:33:20 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: okir@suse.de
Subject: Re: [PATCH] Fix NFS IRIX compatibility braindamage
Message-ID: <20030106193320.GD16489@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	okir@suse.de
References: <200210291208.g9TC8s305165@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210291208.g9TC8s305165@hera.kernel.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going through the old 2.4 changelogs looking for bits that
have been missed out, the little one liners have been going
direct to Linus/maintainer, but here's the first one I'm
unsure of..

Any reason this is missing in 2.5 ?

		Dave


On Tue, Oct 29, 2002 at 11:09:05AM +0000, Linux Kernel wrote:
 > ChangeSet 1.771, 2002/10/29 09:09:05-02:00, okir@suse.de
 > 
 > 	[PATCH] Fix NFS IRIX compatibility braindamage
 > 	
 > 
 > 
 > # This patch includes the following deltas:
 > #	           ChangeSet	1.770   -> 1.771  
 > #	   fs/nfsd/nfsproc.c	1.9     -> 1.10   
 > #	       fs/nfsd/vfs.c	1.13    -> 1.14   
 > #	include/linux/nfsd/nfsd.h	1.4     -> 1.5    
 > #
 > 
 >  fs/nfsd/nfsproc.c         |    4 ++--
 >  fs/nfsd/vfs.c             |   26 +++++++++++++++-----------
 >  include/linux/nfsd/nfsd.h |    3 ++-
 >  3 files changed, 19 insertions(+), 14 deletions(-)
 > 
 > 
 > diff -Nru a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
 > --- a/fs/nfsd/nfsproc.c	Tue Oct 29 04:08:56 2002
 > +++ b/fs/nfsd/nfsproc.c	Tue Oct 29 04:08:56 2002
 > @@ -264,11 +264,11 @@
 >  					/* this is probably a permission check..
 >  					 * at least IRIX implements perm checking on
 >  					 *   echo thing > device-special-file-or-pipe
 > -					 * by does a CREATE with type==0
 > +					 * by doing a CREATE with type==0
 >  					 */
 >  					nfserr = nfsd_permission(newfhp->fh_export,
 >  								 newfhp->fh_dentry,
 > -								 MAY_WRITE);
 > +								 MAY_WRITE|_NFSD_IRIX_BOGOSITY);
 >  					if (nfserr && nfserr != nfserr_rofs)
 >  						goto out_unlock;
 >  				}
 > diff -Nru a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
 > --- a/fs/nfsd/vfs.c	Tue Oct 29 04:08:56 2002
 > +++ b/fs/nfsd/vfs.c	Tue Oct 29 04:08:56 2002
 > @@ -1493,17 +1493,21 @@
 >  		inode->i_uid, inode->i_gid, current->fsuid, current->fsgid);
 >  #endif
 >  
 > -	/* only care about readonly exports for files and
 > -	 * directories. links don't have meaningful write access,
 > -	 * and all else is local to the client
 > -	 */
 > -	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)) 
 > -		if (acc & (MAY_WRITE | MAY_SATTR | MAY_TRUNC)) {
 > -			if (EX_RDONLY(exp) || IS_RDONLY(inode))
 > -				return nfserr_rofs;
 > -			if (/* (acc & MAY_WRITE) && */ IS_IMMUTABLE(inode))
 > -				return nfserr_perm;
 > -		}
 > +	/* The following code is here to make IRIX happy, which
 > +	 * does a permission check every time a user does
 > +	 *	echo yaddayadda > special-file
 > +	 * by sending a CREATE request.
 > +	 * The original code would check read-only export status
 > +	 * only for regular files and directories, allowing
 > +	 * clients to chown/chmod device files and fifos even
 > +	 * on volumes exported read-only. */
 > +	if (!(acc & _NFSD_IRIX_BOGOSITY)
 > +	 && (acc & (MAY_WRITE | MAY_SATTR | MAY_TRUNC))) {
 > +		if (EX_RDONLY(exp) || IS_RDONLY(inode))
 > +			return nfserr_rofs;
 > +		if (/* (acc & MAY_WRITE) && */ IS_IMMUTABLE(inode))
 > +			return nfserr_perm;
 > +	}
 >  	if ((acc & MAY_TRUNC) && IS_APPEND(inode))
 >  		return nfserr_perm;
 >  
 > diff -Nru a/include/linux/nfsd/nfsd.h b/include/linux/nfsd/nfsd.h
 > --- a/include/linux/nfsd/nfsd.h	Tue Oct 29 04:08:56 2002
 > +++ b/include/linux/nfsd/nfsd.h	Tue Oct 29 04:08:56 2002
 > @@ -37,7 +37,8 @@
 >  #define MAY_TRUNC		16
 >  #define MAY_LOCK		32
 >  #define MAY_OWNER_OVERRIDE	64
 > -#if (MAY_SATTR | MAY_TRUNC | MAY_LOCK | MAX_OWNER_OVERRIDE) & (MAY_READ | MAY_WRITE | MAY_EXEC | MAY_OWNER_OVERRIDE)
 > +#define _NFSD_IRIX_BOGOSITY	128
 > +#if (MAY_SATTR | MAY_TRUNC | MAY_LOCK | MAY_OWNER_OVERRIDE | _NFSD_IRIX_BOGOSITY) & (MAY_READ | MAY_WRITE | MAY_EXEC)
 >  # error "please use a different value for MAY_SATTR or MAY_TRUNC or MAY_LOCK or MAY_OWNER_OVERRIDE."
 >  #endif
 >  #define MAY_CREATE		(MAY_EXEC|MAY_WRITE)
 > -
 > To unsubscribe from this list: send the line "unsubscribe bk-commits-24" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
