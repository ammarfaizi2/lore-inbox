Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964923AbWEBQsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWEBQsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWEBQsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:48:53 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:14784 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S964923AbWEBQsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:48:53 -0400
Date: Tue, 2 May 2006 18:48:51 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: 2.6.17-rc3 - fs/namespace.c issue
Message-ID: <20060502164851.GJ22195@MAIL.13thfloor.at>
Mail-Followup-To: Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
References: <200605012106.k41L6GNc007543@turing-police.cc.vt.edu> <20060501143344.3952ff53.akpm@osdl.org> <20060501235637.GB12543@MAIL.13thfloor.at> <200605020656.k426uO7H002518@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605020656.k426uO7H002518@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 02:56:23AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 02 May 2006 01:56:37 +0200, Herbert Poetzl said:
> > > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f6422f17d3a480f21917a3895e2a46b968f56a08
> 
> > first, what do we expect from --bind mounts regarding
> > vfs (mount) level flags like noatime, noexec, nodev?
> > 
> >  - should they be propagated from the original mfs/mount?
> 
> I tripped over this apparent regression when I hit a problem with some
> code that expected this behavior. Given the documented behavior of the
> mount syscall (see below), apparently propagating all flags intact
> and clearing all flags are the only 2 options that don't break the
> documented API.
> 
> >  - should they only restrict the original set?
> >  - should they allow to modify the existing flags?
> 
> Well, absent a '-o newflags' to modify it, propagating the originals
> probably follows the Principle of Least Surprise.   And whether mountflags
> are permissible is an API change issue...
> 
> > IMHO, it makes perfect sense to mount something noatime
> > and change that rule later for a subtree like this:
> > 
> >  mkdir /foo
> >  mount -t tmpfs -o rw,noatime none /foo
> >  mkdir /foo/bar
> >  mount --bind -o atime /foo/bar /foo/bar
> 
> Here, there's a -o parameter being passed.

yes, but this information unfortunately cannot be passed 
to the kernel, assuming that we 'preserve' the original
mount flags, as there simply is no 'atime' flag, just an
MS_NOATIME flag, which in this case is not set :)

> > second, has the kernel to decide what flags userspace
> > can request and/or change, depending on the original?
> 
> Can of worms, too complicated for 3AM. :)
> 
> > and finally, how to handle --rbind mounts at a level
> > deeper than the top?
> 
> More worms. ;)

it's full of worms, maybe we should add a new option or
even a new mount type for this?

maybe we should allow remount on bind mounts, and keep
the original (copy all) behaviour intact for --bind and
--rbind mounts? (that would look most natural to me)

suggestions welcome!

best,
Herbert

> Note that any provision for changing the mountflags *IS* a break of
> the documented API.  'man 2 mount' says specifically:
> 
>        MS_BIND
>               (Linux 2.4 onwards) Perform a bind mount, making a
>               file or a directory subtree visible at another point
>               within a file system. Bind mounts may cross file system
>               boundaries and span chroot(2) jails. The filesystemtype,
>               mountflags, and data arguments are ignored.
> 
> I admit not knowing that whether POSIX or other standards specify that
> mountflags be ignored.


