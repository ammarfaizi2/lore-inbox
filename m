Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUDFUss (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 16:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264003AbUDFUss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 16:48:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4764 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264002AbUDFUsp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 16:48:45 -0400
Date: Tue, 6 Apr 2004 21:48:44 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] BME, noatime and nodiratime
Message-ID: <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk>
References: <20040406145544.GA19553@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406145544.GA19553@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 04:55:44PM +0200, Herbert Poetzl wrote:
> 
> Hi Andrew!
> 
> according to todays vfs strategy (hope it hasn't changed
> again), here is the first patch, which adds the mount 
> flags propagation, fixes the /proc display, and implements
> noatime and nodiratime per mountpoint ...
> 
> please consider for inclusion ...

noatime/nodiratime: OK, but we still have direct modifications of i_atime
that need to be taken care of.

massage of ->show(): more or less OK.  However, we don't need to keep
MS_NOATIME and MS_NODIRATIME in flags at all - 
> +	if (flags & MS_NOATIME)
> +		mnt_flags |= MNT_NOATIME;
> +	if (flags & MS_NODIRATIME)
> +		mnt_flags |= MNT_NODIRATIME;
>  	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);

should remove them from flags in the last line, same way we do that for
nosuid/noexec/nodev, with obvious consequences for ->show().

Note that we don't need to keep MS_NOATIME check in update_atime() - that
animal is purely per-mountpoint now.

> +	if (MNT_IS_NOATIME(mnt))
> +		return;
> +	if (S_ISDIR(inode->i_mode) && MNT_IS_NODIRATIME(mnt))
> +		return;

Do we need those to be macros?  AFAICS, this is the only place where we
do such checks and we shouldn't get new callers.  IOW, keeping them
separate doesn't buy us anything and only obfuscates the code.

> -#define MNT_NOSUID	1
> -#define MNT_NODEV	2
> -#define MNT_NOEXEC	4
> +#define MNT_RDONLY	1
> +#define MNT_NOSUID	2
> +#define MNT_NODEV	4
> +#define MNT_NOEXEC	8
> +#define MNT_NOATIME	16
> +#define MNT_NODIRATIME	32

*ugh*

a) what's the point of reordering them (rdonly shifting the existing ones)?
b) since MNT_RDONLY doesn't do anything at that point, why introduce it
(and associated confusion) now?  As it is, your /proc/mounts will pretend
that per-mountpoint r/o works right now.  Since it doesn't...
  
> +#define	MNT_IS_RDONLY(m)	((m) && ((m)->mnt_flags & MNT_RDONLY))
> +#define	MNT_IS_NOATIME(m)	((m) && ((m)->mnt_flags & MNT_NOATIME))
> +#define	MNT_IS_NODIRATIME(m)	((m) && ((m)->mnt_flags & MNT_NODIRATIME))

See above.  Besides, are we ever planning to pass NULL to these guys?
