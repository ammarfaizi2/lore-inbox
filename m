Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSGVAR1>; Sun, 21 Jul 2002 20:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSGVAR1>; Sun, 21 Jul 2002 20:17:27 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:25992 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315279AbSGVAR0>; Sun, 21 Jul 2002 20:17:26 -0400
Date: Sun, 21 Jul 2002 19:20:26 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5.25 remove unnecessary recompiles when changing
 EXTRAVERSION
In-Reply-To: <30028.1025956438@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0207211856450.16927-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jul 2002, Keith Owens wrote:

> include/linux/version.h contains both the numeric part of the kernel
> version and the full uts_release string.  version.h is included almost
> everywhere, either on its own or via module.h.  module.h and modutils
> only require the numeric kernel version, the use of UTS_RELEASE is
> incorrect and causes significant recompiles when EXTRAVERSION changes.
> 
> This patch moves UTS_RELEASE into its own header which is explicitly
> included in only the files that really use UTS_RELEASE.  module.h uses
> a new field (KERNEL_VERSION_STRING) which has been added to version.h.
> With this patch, a change to EXTRAVERSION no longer recompiles 95% of
> your kernel.
> 
> The only significant changes are to module.h and Makefile.  The rest of
> the patch is adding #include <linux/uts_release.h> in those files that
> use UTS_RELEASE.  I suspect some of those files really only need
> KERNEL_VERSION_STRING but that has been left as an exercise for the
> file owners.  Some of those files may no longer required version.h,
> again that has been left for the file owners.

When I looked at the same thing, I gave up when I realized that the 
EXTRAVERSION part is actually used in module.h, thereby affecting most 
files in the tree.

Now, you get around this by only including the numeric part of the kernel 
version in the module. That's of course a possibility, but I'd think 
people should be aware that this actually a major change.

(I just looked at modutils-2.4.15, don't know if sth changed in the 
latest version)

a) This change breaks compatibility to current modutils. A module
   compiled for 2.5.30-pre5 will contain only "2.5.30" as its version
   after your patch, thus current modutils will refuse to insert it
   into "2.5.30-pre5". (unless using insmod -f)
   This is of course easily fixed by having a new version of modutils
   only compare the numeric part.

   But then we have
b) modutils will not complain when insmod'ing a module compiled for
   2.5.30-preX into 2.5.30-final (or any 2.5.30-, for that matter). If
   that happens, it of course means the user fscked up. However,
   I think the trend is to make things rather more fool-proof than
   less so, so I'm not convinced that we're on the right track with this 
   change.

Of course, on the other hand the patch means that when going from -pre<N> 
to -pre<N+1> modules won't be recompiled just for the heck of updating the 
version string, but only if something else changed.

(We don't have -pre's in 2.5, so think 2.6, or inserting modules from -djX 
into a vanilla kernel or so)

As I'd guess this issue is somewhat controversial, I'd like to gather 
opinions on whether it should be done or not.

--Kai



