Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbVANNca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbVANNca (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 08:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVANNca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 08:32:30 -0500
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:38801 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S261980AbVANNcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 08:32:25 -0500
Date: Fri, 14 Jan 2005 13:32:18 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] FUSE - remove mount_max and user_allow_other module
 parameters
In-Reply-To: <E1CpQvu-0000WV-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.60.0501141327450.18572@hermes-1.csi.cam.ac.uk>
References: <E1CpQvu-0000WV-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2005, Miklos Szeredi wrote:
> This patch removes checks for zero uid (spotted by you).  These cannot
> be replaced with checking for capable(CAP_SYS_ADMIN), since for mount
> this capability will always be set.  Better aproach seems to be to
> move the checks to fusermount (the mount utility provided with the
> FUSE library).
>
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> diff -rup linux-2.6.11-rc1-mm1/fs/fuse/inode.c linux-2.6.11-rc1-mm1-fuse/fs/fuse/inode.c
> --- linux-2.6.11-rc1-mm1/fs/fuse/inode.c	2005-01-14 12:30:07.000000000 +0100
> +++ linux-2.6.11-rc1-mm1-fuse/fs/fuse/inode.c	2005-01-14 12:44:36.000000000 +0100
[snip]
> @@ -534,11 +512,6 @@ static int fuse_fill_super(struct super_
>  	if (!parse_fuse_opt((char *) data, &d))
>  		return -EINVAL;
>  
> -	if (!user_allow_other &&
> -	    (d.flags & (FUSE_ALLOW_OTHER | FUSE_ALLOW_ROOT)) &&
> -	    current->uid != 0)
> -		return -EPERM;
> -
>  	sb->s_blocksize = PAGE_CACHE_SIZE;
>  	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
>  	sb->s_magic = FUSE_SUPER_MAGIC;
[snip]

Are you sure you want to do this?  Placing security checks inside a 
userspace utility and allowing everyone to do it in the kernel means that 
any user/hacker could compile their own version of fusermount without the 
check and bypass your security...  So if you really do not want users to 
be able to do this you must do it inside the kernel.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
