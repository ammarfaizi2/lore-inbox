Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbVLONBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbVLONBu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 08:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbVLONBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 08:01:50 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:18131 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1422715AbVLONBt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 08:01:49 -0500
Date: Thu, 15 Dec 2005 06:01:48 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: torvalds@osdl.org, willy@debian.org, arnd@arndb.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org, debian-glibc@lists.debian.org
Subject: Re: [patch] ioctl BLKGETSIZE64 fix
Message-ID: <20051215130148.GA9286@parisc-linux.org>
References: <20051215122527.GA7762@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215122527.GA7762@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 08:25:27PM +0800, Coywolf Qi Hunt wrote:
> Two years ago, "[PATCH] use size_t for the broken ioctl numbers" brought in the problem.
> <http://lkml.org/lkml/2003/9/7/14> (also FYI: <https://lwn.net/Articles/48360/>)
> 
> The patch below fixes the bug on BLKGETSIZE64. typeof(size_t) == 32, but we expect 64. 
> The choice of `size_t' is also a mistake. We should have taken `int'.  This also affects
> userland linux-kernel-headers.
> 
> Or am I missing something? Thanks.

Did you test this change?  I don't think you understood what the original
problem was.

This is the original definition:
-#define BLKGETSIZE64 _IOR(0x12,114,sizeof(u64))	/* return device
size in bytes (u64 *arg) */

What the author *meant* was to use u64.  What they *got* was size_t.
Unfortunately, changing this to u64 breaks compatibility with userspace.
So we put in some checking code to make sure that people wouldn't make
this kind of mistake any more and converted all the bad users to size_t.

With Linux the size argument is *just* a convention.  Some Unices do
the copyin/copyout thing in the ioctl dispatcher; Linux has the ioctl
handler do the copyin/copyout.  So it does no harm to have the wrong size.

In summary: This change is wrong and causes ABI breakage for
architectures which have sizeof(u64) != sizeof(size_t).

> 	Coywolf
> 
> Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
> ---
> diff -pruN 2.6.15-rc5-mm3/include/linux/fs.h 2.6.15-rc5-mm3~BLKGETSIZE64-fix/include/linux/fs.h
> --- 2.6.15-rc5-mm3/include/linux/fs.h	2005-12-15 16:55:22.000000000 +0800
> +++ 2.6.15-rc5-mm3~BLKGETSIZE64-fix/include/linux/fs.h	2005-12-15 20:08:52.000000000 +0800
> @@ -197,7 +197,7 @@ extern int dir_notify_enable;
>  /* A jump here: 108-111 have been used for various private purposes. */
>  #define BLKBSZGET  _IOR(0x12,112,size_t)
>  #define BLKBSZSET  _IOW(0x12,113,size_t)
> -#define BLKGETSIZE64 _IOR(0x12,114,size_t)	/* return device size in bytes (u64 *arg) */
> +#define BLKGETSIZE64 _IOR(0x12,114,u64)	/* return device size in bytes (u64 *arg) */
>  #define BLKSTARTTRACE _IOWR(0x12,115,struct blk_user_trace_setup)
>  #define BLKSTOPTRACE _IO(0x12,116)
>  
