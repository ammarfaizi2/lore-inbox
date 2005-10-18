Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbVJRJAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbVJRJAu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 05:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbVJRJAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 05:00:49 -0400
Received: from koto.vergenet.net ([210.128.90.7]:41642 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751464AbVJRJAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 05:00:49 -0400
Date: Tue, 18 Oct 2005 17:59:10 +0900
From: Horms <horms@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, security@kernel.org,
       secure-testing-team@lists.alioth.debian.org, 334113@bugs.debian.org,
       debian-ne@durchnull.de, mckinstry@debian.org, team@security.debian.org
Subject: Re: [Security] kernel allows loadkeys to be used by any user, allowing for local root compromise
Message-ID: <20051018085909.GJ8830@verge.net.au>
References: <E1EQofT-0001WP-00@master.debian.org> <20051018044146.GF23462@verge.net.au> <20051017235211.161e8604.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051017235211.161e8604.akpm@osdl.org>
X-Cluestick: seven
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 11:52:11PM -0700, Andrew Morton wrote:
> Horms <horms@verge.net.au> wrote:
> >
> > drivers/char/vt_ioctl.c: vt_ioctl(): line 377
> > 
> >          /*
> >           * To have permissions to do most of the vt ioctls, we either
> >           * have
> >           * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
> >           */
> >          perm = 0;
> >          if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
> >                  perm = 1;
> > 
> > 
> >  A simple fix for this might be just checking for capable(CAP_SYS_TTY_CONFIG)
> >  in do_kdgkb_ioctl(), which effects KDSKBSENT. This more restrictive
> >  approach is probably appropriate for many of the other ioctls that set
> >  VT parameters.
> 
> I briefly discussed this with Alan and he agreed that that's a reasonable
> approach.

Thanks, thats pretty much what I had in mind. Though I would expect
some minor breakage, at least for people who expect nonsetuid loadkeys
to work. But then again, that is the whole point.

> I'll stick the below in -mm, see what breaks.
> 
> --- devel/drivers/char/vt_ioctl.c~setkeys-needs-root	2005-10-17 23:50:37.000000000 -0700
> +++ devel-akpm/drivers/char/vt_ioctl.c	2005-10-17 23:51:43.000000000 -0700
> @@ -192,6 +192,9 @@ do_kdgkb_ioctl(int cmd, struct kbsentry 
>  	int i, j, k;
>  	int ret;
>  
> +	if (!capable(CAP_SYS_TTY_CONFIG))
> +		return -EPERM;
> +
>  	kbs = kmalloc(sizeof(*kbs), GFP_KERNEL);
>  	if (!kbs) {
>  		ret = -ENOMEM;
> _

-- 
Horms
