Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136050AbREJMGQ>; Thu, 10 May 2001 08:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136098AbREJMFq>; Thu, 10 May 2001 08:05:46 -0400
Received: from zeus.kernel.org ([209.10.41.242]:61671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136123AbREJMEu>;
	Thu, 10 May 2001 08:04:50 -0400
Date: Thu, 10 May 2001 09:33:37 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make distclean tries to delete dirs in tmpfs
Message-ID: <20010510093337.R754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010509204434.Q754@nightmaster.csn.tu-chemnitz.de> <9dcgc8$ora$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <9dcgc8$ora$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, May 09, 2001 at 03:29:28PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 03:29:28PM -0700, H. Peter Anvin wrote:
> By author:    Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
> > make distclean deletes anything with size 0. This includes
> > directories, while making the kernel in tmpfs or ramfs.
> Wouldn't it be better to fix tmpfs/ramfs to report something sensible,
> even if it's artificial?

No, because it gives it as arguments to "rm" (which only deletes
files by defintion) and not to "rm -rf" (which also deletes
directories).

Not excluding directories from the arguments to "rm" is the BUG.
All my scripts always do that, just the kernel Makefile doesn't.

And it might even be faster, because we don't have to do all the
other tests, if it's not an directory ;-)

> N.B.: X/KDE will not run on a ramfs, because it reports as a size-zero
> filesystem in "df".  Switching to tmpfs solved that for me.

This is partially a ramfs BUG, because filesystems are supposed
to do accounting ;-)

OTOH, querying the available space before transfers says NOTHING
about the sucess of an operation. kfm is not the only application
running and the fs might do delayed allocation.

Applications should not check for free space, they should try to
allocate it (and maybe touch it, if we are not IO bound) and
watch for ENOSPC instead. 

Then we truncate all written stuff to the extend, where it made
sense, delete the whole file if it has become size 0 and emit an
error telling the user, that we had not enough disk space at this
time to succeed.

We don't check for available memory either, so why do it on disk?

It made sense in DOS times, but doesn't do anymore. It's only
relevant to the administrator to tell him, that we need a bigger
disk ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
