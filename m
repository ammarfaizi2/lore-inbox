Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282042AbRLOHkj>; Sat, 15 Dec 2001 02:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282062AbRLOHkU>; Sat, 15 Dec 2001 02:40:20 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:4109 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S282042AbRLOHkL>; Sat, 15 Dec 2001 02:40:11 -0500
Date: Sat, 15 Dec 2001 01:40:07 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Random "File size limit exceeded" under 2.4
Message-ID: <20011215014007.B6810@asooo.flowerfire.com>
In-Reply-To: <1007573331.1809.6.camel@two> <3C0E813D.F5B1F84E@zip.com.au> <9um7bf$lsp$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <9um7bf$lsp$1@ncc1701.cistron.net>; from miquels@cistron.nl on Wed, Dec 05, 2001 at 10:33:19PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FWIW, I've been using this over-engineered, under-tested command line
utility to run e2fsck on our older distributions:

	http://web.irridia.com/info/linux/unflimit.c

It works like "nice" or "time", but sets the proper RLIM_INFINITY
filesize limit for the inheriting subshell.  For example:

	unflimit e2fsck /dev/sda3

The boot-time fscks work fine, but in multiuser I'm extremely lucky to
get it to work without this.

The kernel patch below would work, I expect, but I think it's not
necessarily the Right Thing To Do.  If Andrew is right, is anyone
looking at why block devices (or fsck?) are honoring the filesize limit?

Thanks,
-- 
Ken.
brownfld@irridia.com

On Wed, Dec 05, 2001 at 10:33:19PM +0000, Miquel van Smoorenburg wrote:
| In article <3C0E813D.F5B1F84E@zip.com.au>,
| Andrew Morton  <akpm@zip.com.au> wrote:
| >Derek Glidden wrote:
| >> 
| >> I've been experiencing random and occasional encounters with "File size
| >> limit exceeded" errors under 2.4 kernels when trying to make
| >> filesystems.
| >
| >I don't know if anyone has come forth to fix this yet.
| >
| >Apparently it's something to do with your shell setting
| >rlimits, and block devices are (bogusly) honouring those
| >settings.
| 
| Perhaps the old app is calling sys_old_getrlimit() from
| linux/kernel/sys.c. It truncates rlimits to 0x7FFFFFFF
| if it's bigger than that. 0x7FFFFFFF used to be the old
| RLIM_INFINITY in 2.2 [actually, ((long)(~0UL>>1))]. In
| 2.4, RLIM_INFINITY is (~0UL).
| 
| So if you call sys_setrlimit() with the old RLIM_INFINITY from 2.2
| OR with the result from sys_old_getrlimit(), then the new limit
| will be 0x7FFFFFFF instead of unlimited.
| 
| Looks like someone forgot to implement sys_old_setrlimit(),
| which would have been the right thing to do.
| 
| Now all we can do is to hack sys_setrlimit and let it translate
| 0x7FFFFFFF to RLIM_INFINITY.
| 
| The following untested and uncompiled patch might do it, or not...
| 
| --- linux-2.4.17-pre2/kernel/sys.c.orig	Tue Sep 18 23:10:43 2001
| +++ linux-2.4.17-pre2/kernel/sys.c	Wed Dec  5 23:30:50 2001
| @@ -1120,6 +1120,16 @@
|  		return -EINVAL;
|  	if(copy_from_user(&new_rlim, rlim, sizeof(*rlim)))
|  		return -EFAULT;
| +#if !defined(__ia64__)
| +	/*
| +	 * 	In 2.2, RLIMIT_INFINITY was defined as ((long)(~0UL>>1)).
| +	 * 	Reckognize it and translate it to the new RLIMIT_INFINITY.
| +	 */
| +	if ((long)new_rlim.rlim_cur == ((long)(~0UL>>1)))
| +		new_rlim.rlim_cur = RLIMIT_INFINITY;
| +	if ((long)new_rlim.rlim_max == ((long)(~0UL>>1)))
| +		new_rlim.rlim_max = RLIMIT_INFINITY;
| +#endif
|  	old_rlim = current->rlim + resource;
|  	if (((new_rlim.rlim_cur > old_rlim->rlim_max) ||
|  	     (new_rlim.rlim_max > old_rlim->rlim_max)) &&
| 
| Mike.
| -- 
| "Only two things are infinite, the universe and human stupidity,
|  and I'm not sure about the former" -- Albert Einstein.
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
