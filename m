Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVBWXJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVBWXJE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVBWXHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:07:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:659 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261681AbVBWXHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:07:01 -0500
Date: Wed, 23 Feb 2005 23:06:59 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 6/6] Bind Mount Extensions 0.06
Message-ID: <20050223230659.GE21383@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050222121333.GG3682@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222121333.GG3682@mail.13thfloor.at>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/ext2/ioctl.c	2005-02-19 06:32:05 +0100
> @@ -29,7 +29,8 @@ int ext2_ioctl (struct inode * inode, st
>  	case EXT2_IOC_SETFLAGS: {
>  		unsigned int oldflags;
>  
> -		if (IS_RDONLY(inode))
> +		if (IS_RDONLY(inode) ||
> +			(filp && MNT_IS_RDONLY(filp->f_vfsmnt)))

doing this in every filesystem ->ioctl is a really bad idea.  We need to
add common handling for ext2-style file attributes first.

Also please add a file_readonly() helper - when introduced it only checks
IS_RDONLY(file->f_dentry->d_inode) and once you add per-mount flags it
only needs to be added in a single place. Actually probably a lowelevel
one taking inode,vfsmount and wrappers for a struct file * or
struct nameidata * which would cover most of the cases.

