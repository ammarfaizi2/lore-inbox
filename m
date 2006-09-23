Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWIWPRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWIWPRV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWIWPRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:17:21 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:52215 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1751233AbWIWPRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:17:20 -0400
Date: Sat, 23 Sep 2006 16:16:51 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Stas Sergeev <stsp@aknet.ru>
cc: Andrew Morton <akpm@osdl.org>, Ulrich Drepper <drepper@redhat.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
In-Reply-To: <45150CD7.4010708@aknet.ru>
Message-ID: <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
References: <45150CD7.4010708@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Sep 2006 15:16:47.0375 (UTC) FILETIME=[495451F0:01C6DF23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006, Stas Sergeev wrote:
> Hi Andrew.
> 
> I am not sure at all whether this patch is appreciated
> or not. The on-list query yielded no results, but I have
> to try. :)

Probably not appreciated :)  I agree with your earlier mail, that
those mmap MNT_NOEXEC checks don't give any watertight protection:
they're more a heuristic to prevent the wrong thing happening
automatically.  But they were put in for good reason, have been
in for nearly three years, I doubt they should come out now.

It's hardly any surprise, is it, that if a distro chooses now
to mount something "noexec", a problem is then found with a few
things which want otherwise?  And it seems unlikely that the answer
is then to modify the kernel, to weaken the very protection they're
wanting to add?

The original 2.6.0 patch (later backported into 2.4.25) was
<drepper@redhat.com>
	[PATCH] Fix 'noexec' behaviour
	
	We should not allow mmap() with PROT_EXEC on mounts marked "noexec",
	since otherwise there is no way for user-supplied executable loaders
	(like ld.so and emulator environments) to properly honour the
	"noexec"ness of the target.
so let's CC Ulrich Drepper in case he's changed his mind on it.

Hugh

> 
> This patch removes the MNT_NOEXEC check for the PROT_EXEC
> mappings. That allows to mount tmpfs with "noexec" option
> without breaking the existing apps, which is what debian
> wants to do for sequrity reasons:
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=386945
> More details here:
> http://uwsg.ucs.indiana.edu/hypermail/linux/kernel/0609.2/1537.html
> 
> Signed-off-by: Stas Sergeev <stsp@aknet.ru>
> 
> --- a/mm/mmap.c	2006-01-25 15:02:24.000000000 +0300
> +++ b/mm/mmap.c	2006-09-21 13:19:15.000000000 +0400
> @@ -899,10 +899,6 @@
>  
>  		if (!file->f_op || !file->f_op->mmap)
>  			return -ENODEV;
> -
> -		if ((prot & PROT_EXEC) &&
> -		    (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
> -			return -EPERM;
>  	}
>  	/*
>  	 * Does the application expect PROT_READ to imply PROT_EXEC?
> @@ -911,8 +907,7 @@
>  	 *  mounted, in which case we dont add PROT_EXEC.)
>  	 */
>  	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
> -		if (!(file && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC)))
> -			prot |= PROT_EXEC;
> +		prot |= PROT_EXEC;
>  
>  	if (!len)
>  		return -EINVAL;
> --- a/mm/nommu.c	2006-04-12 09:37:34.000000000 +0400
> +++ b/mm/nommu.c	2006-09-21 13:21:32.000000000 +0400
> @@ -493,13 +493,7 @@
>  				capabilities &= ~BDI_CAP_MAP_DIRECT;
>  		}
>  
> -		/* handle executable mappings and implied executable
> -		 * mappings */
> -		if (file->f_vfsmnt->mnt_flags & MNT_NOEXEC) {
> -			if (prot & PROT_EXEC)
> -				return -EPERM;
> -		}
> -		else if ((prot & PROT_READ) && !(prot & PROT_EXEC)) {
> +		if ((prot & PROT_READ) && !(prot & PROT_EXEC)) {
>  			/* handle implication of PROT_EXEC by PROT_READ */
>  			if (current->personality & READ_IMPLIES_EXEC) {
>  				if (capabilities & BDI_CAP_EXEC_MAP)
