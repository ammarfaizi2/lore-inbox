Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263267AbSJVPtJ>; Tue, 22 Oct 2002 11:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263356AbSJVPtI>; Tue, 22 Oct 2002 11:49:08 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:59782 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S263267AbSJVPtH>;
	Tue, 22 Oct 2002 11:49:07 -0400
Subject: Re: can chroot be made safe for non-root?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: Ville Herva <vherva@niksula.hut.fi>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1035296135.1089.35.camel@zaphod>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
	<87n0pevq5r.fsf@ceramic.fifi.org>
	<1035213732.27259.160.camel@irongate.swansea.linux.org.uk>
	<20021022072132.GN147946@niksula.cs.hut.fi> 
	<1035296135.1089.35.camel@zaphod>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Oct 2002 17:55:13 +0200
Message-Id: <1035302113.723.20.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 16:15, Shaya Potter wrote:

> from vserver patch
> 
> diff -rc2P linux-2.4.19/fs/namei.c linux-2.4.19ctx-14/fs/namei.c
> *** linux-2.4.19/fs/namei.c     Tue Aug  6 15:02:24 2002
> --- linux-2.4.19ctx-14/fs/namei.c       Sun Oct 13 23:58:55 2002
> ***************
> *** 153,156 ****
> --- 153,165 ----
>         umode_t                 mode = inode->i_mode;
>   
> +       /*
> +               A dir with permission bit all 0s is a dead zone for
> +               process running in a vserver. By doing
> +                       chmod 000 /vservers
> +               you fix the "escape from chroot" bug.
> +       */
> +       if ((mode & 0777) == 0
> +               && S_ISDIR(mode)
> +               && current->s_context != 0) return -EACCES;
>         if (mask & MAY_WRITE) {
>                 /*
> 
> I don't think that will work, especially as it seems vserver's dont
> nest.

This was just a quick and dirty fix to prevent root in a vserver from
breaking out into the "real server", that's it. chroot() inside a
vserver works exactly the same way as without vservers.

One negative sideeffect is that root in a vserver can't access any
directory with all 0s in the permission bits. But that's better than
having root in a vserver being able to go out into the "real server".

I'm not saying this is a very good solution but I think it at least does
what it's supposed to do in a dirty way.

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat
you with experience.
