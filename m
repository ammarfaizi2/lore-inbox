Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVLTQuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVLTQuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVLTQuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:50:24 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:20609
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750785AbVLTQuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:50:23 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Zdenek Pavlas <pavlas@nextra.cz>, uclibc@uclibc.org
Subject: Re: [PATCH 10/15] misc: Make *[ug]id16 support optional
Date: Tue, 20 Dec 2005 10:50:04 -0600
User-Agent: KMail/1.8
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <11.282480653@selenic.com> <20051116180140.GO31287@waste.org> <43A82764.8050305@nextra.cz>
In-Reply-To: <43A82764.8050305@nextra.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512201050.05278.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 December 2005 09:46, Zdenek Pavlas wrote:
> Matt Mackall wrote:
> > On Wed, Nov 16, 2005 at 07:21:30AM -0600, Rob Landley wrote:
> >>Is there an easy way to make sure our programs aren't using these?  (If I
> >>build a new system from source with busybox and uclibc, how do I know if
> >> I can disable this?)
> >
> > These should only be found in legacy binaries, ie 5+ years old.
>
> Not true, unfortunately.  To make uClibc work with linux-tiny
> and [ug]id16 disabled one has to apply patches like this.
> uClibc probably assumes 16 bit __kernel_[ug]id_t and uses
> legacy syscalls exclusively.

They've been fixing that.  Working with linux-tiny is definitely something 
uClibc is interested in.  When you say "patches like this", do you have a 
complete list or is there something we could grep for?

> --- uClibc-0.9.28/libc/sysdeps/linux/common/chown.c
> +++ uclibc/libc/sysdeps/linux/common/chown.c
> @@ -10,16 +10,11 @@
>   #include "syscalls.h"
>   #include <unistd.h>
>
> -#define __NR___syscall_chown __NR_chown
> +#define __NR___syscall_chown __NR_chown32
>   static inline _syscall3(int, __syscall_chown, const char *, path,
>                  __kernel_uid_t, owner, __kernel_gid_t, group);
>
>   int chown(const char *path, uid_t owner, gid_t group)
>   {
> -       if (((owner + 1) > (uid_t) ((__kernel_uid_t) - 1U))
> -               || ((group + 1) > (gid_t) ((__kernel_gid_t) - 1U))) {
> -               __set_errno(EINVAL);
> -               return -1;
> -       }
>          return (__syscall_chown(path, owner, group));
>   }

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
