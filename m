Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVC3UjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVC3UjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 15:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVC3UjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 15:39:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:61896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261812AbVC3UjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 15:39:07 -0500
Date: Wed, 30 Mar 2005 12:39:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: rweight@us.ibm.com
Cc: linux-kernel@vger.kernel.org,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] Set MS_ACTIVE in isofs_fill_super()
Message-Id: <20050330123907.10740bc1.akpm@osdl.org>
In-Reply-To: <1112213392.25362.65.camel@russw.beaverton.ibm.com>
References: <1112213392.25362.65.camel@russw.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russ Weight <rweight@us.ibm.com> wrote:
>
> This patch sets the MS_ACTIVE bit in isofs_fill_super() prior to calling
> iget() or iput(). This eliminates a race condition between mount
> (for isofs) and kswapd that results in a system panic.
> 
> Signed-off-by: Russ Weight <rweight@us.ibm.com>
> 
> --- linux-2.6.12-rc1/fs/isofs/inode.c	2005-03-17 17:34:36.000000000
> -0800
> +++ linux-2.6.12-rc1-isofsfix/fs/isofs/inode.c	2005-03-22
> 15:29:51.945607217 -0800
> @@ -820,6 +820,7 @@
>  	 * the s_rock flag. Once we have the final s_rock value,
>  	 * we then decide whether to use the Joliet descriptor.
>  	 */
> +	s->s_flags |= MS_ACTIVE;
>  	inode = isofs_iget(s, sbi->s_firstdatazone, 0);
>  
>  	/*
> @@ -909,6 +910,7 @@
>  		kfree(opt.iocharset);
>  	kfree(sbi);
>  	s->s_fs_info = NULL;
> +	s->s_flags &= ~MS_ACTIVE;
>  	return -EINVAL;
>  }
>  

The patch is obviously safe enough, but seems a bit kludgy.

The basic problem here appears to be that isofs is doing iget/iput in
->fill_super before MS_ACTIVE is set and the inode freeing code
(generic_forget_inode) doesn't expect that to happen, yes?

I wonder if it would make more sense for all the ->fill_super callers to
set MS_ACTIVE prior to calling ->fill_super(), and clear MS_ACTIVE if
fill_super() failed?
