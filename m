Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292283AbSBZRWL>; Tue, 26 Feb 2002 12:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292249AbSBZRWB>; Tue, 26 Feb 2002 12:22:01 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:63739
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292237AbSBZRVo>; Tue, 26 Feb 2002 12:21:44 -0500
Date: Tue, 26 Feb 2002 09:22:27 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226172227.GM4393@matchmail.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com> <02022518330103.01161@grumpersII> <a5f7s4$2o1$1@cesium.transmeta.com> <20020226160544.GD4393@matchmail.com> <3C7BB9A3.30408@evision-ventures.com> <20020226164316.GH4393@matchmail.com> <3C7BBDE2.8050207@evision-ventures.com> <20020226170520.GJ4393@matchmail.com> <3C7BC0E5.3060300@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7BC0E5.3060300@evision-ventures.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 06:07:49PM +0100, Martin Dalecki wrote:
> >>For the educated user it was always a pain
> >>in the you know where, to constantly run out of quota space due to
> >>file versioning.
> >>
> >
> >Ahh, so we'd need to chown the files to root (or a configurable user and
> >group) to get around the quota issue.
> 
> Welcome to my kill-file. This just shows that you don't even have basic
> background.
> 

Ok guys,

Maybe you'll respect the ideas coming from Andreas Dilger, as some of you
obviously don't like some of my ideas.

Here goes:

On Feb 25, 2002  13:45 -0800, Mike Fedyk wrote:
> I don't think we need anything very complicated either.
> 
> Here's what it probably should do *in libc*:
>   o trap unlink calls
>     o if link count >= 2 then act normally
>     o if link count == 1 then move file (including directory structure from
>       mount point to $mount_point/.deleted/$path/file)

Well, my idea on this is that you don't check the link count at all.  Why
should it be special if I delete /home/adilger/foo, when it is also linked
to /home/adilger/bar?  If I want to undelete /home/adilger/foo, then I
should be able to.  Since it is on the same filesystem, it doesn't take any
more space in the filesystem to keep this link, and in fact avoids the
race condition entirely.

Only the undelete daemon would do real deletions, everything else would
_always_ do something like:

base=`echo $file | sed "s#$mntpt/##"` 
mv $file $mntpt/.undelete/$base[.timestamp/username/etc]

> The undelete daemon (undeleted) would do:
>   o monitor how full the various deleted directories are (always keep some
>     percentage empty to allow new files to be deleted without overflowing
>     the space configured for undelete)
>   o enforce configurable setting for how much space .undelete will hold
>   o delete any single file that will not fit in .undelete's space no matter
>     how new it is
>   o any other sysadmin notification type of things
> 
> Should the glibc routine interact directly with the undelete daemon so that
> the case of a lot of deletion of large files will be handled faster?
> Otherwise, if you delete a lot of files, df won't show the free space
> getting bigger until undeleted did a rescan of it's undelete dirs and freed
> the old deleted files.

Well, my take on this would be that since we are only ever moving files over
to .undelete, then we are never using up more space than what we are already
using, so we do not need to ever synchronously free space to delete a file.

We could always have unlink() write to a socket (e.g. .undelete/daemon or so)
telling it which file it just deleted, and the daemon sleeps on this socket
until woken to see if it needs to do cleanup.  Having the name of the
recently deleted file passed in allows it to do things like clean up old
copies of that file quickly, etc.

Note also that the "unrm" command would need some smarts so that it can
match against variations of $base, because programs may rename a file,
make a new copy, and then delete the renamed file (e.g. emacs, vi, etc).
It would probably do some sort of regexp on the basename() of the file.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


